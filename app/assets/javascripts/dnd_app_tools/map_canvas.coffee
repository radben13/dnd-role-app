DndApp = window.DndApp

DndApp.MapCanvas = class MapCanvas
  @findByCanvas: (canvas) ->
    for mapCanvas in DndApp.mapCanvasList
      if mapCanvas.canvas == canvas
        return mapCanvas
    null
  
  @registerCanvas: (mapCanvas) ->
    DndApp.mapCanvasList = DndApp.mapCanvasList || []
    DndApp.mapCanvasList.push(mapCanvas)
  
  constructor: (@scale) ->
    data = arguments[1] || {}
    @map = DndApp.CoordinateMap.getMap()
    @map.registerListener(@)
    @entities = []
    @buildCanvas(data.element)
    @mapUpdated()
    @clickListeners = []
    DndApp.MapCanvas.registerCanvas(@)
  
  buildCanvas: (element) ->
    @canvasElement = element || $('<canvas />')
    @canvas = @canvasElement[0]
    @context = @canvas.getContext('2d')
    @canvasElement.click(@canvasClicked)
  
  canvasClicked: (e) ->
    if e.preventDefault
      e.preventDefault()
    DndApp.MapCanvas.findByCanvas(@).clickEvent(
      offsetX: e.offsetX
      offsetY: e.offsetY
    )
  
  setScale: (scale) ->
    @scale = scale
    @canvas.width = @map.width * @scale
    @canvas.height = @map.height * @scale
    @drawMap()
  
  getUIScale: ->
    @scale * ( parseFloat(@canvasElement.width()) / @canvas.width )
  
  registerListener: (listener) ->
    if @clickListeners.indexOf(listener) < 0
      @clickListeners.push(listener)
  
  clickEvent: (event) ->
    event = 
      x: Math.floor(event.offsetX / @getUIScale())
      y: Math.floor(event.offsetY / @getUIScale())
      offsetX: event.offsetX
      offsetY: event.offsetY
    for listener in @clickListeners
      listener.click(event)
  
  addEntity: (entity) ->
    if @entities.indexOf(entity) < 0
      @entities.push(entity)
  
  mapUpdated: ->
    @xRange = [0..(@map.width - 1)]
    @yRange = [0..(@map.height - 1)]
    @canvas.width = @map.width * @scale
    @canvas.height = @map.height * @scale
    @drawMap()
  
  drawMap: ->
    @drawTiles()
    @drawDecorations()
    @drawGrid()
    @drawEntities()
  
  drawTiles: ->
    for x in @xRange
      for y in @yRange
        tile = @map.getTile(x,y)
        tile.draw(x, y, @context, @scale)
  
  drawDecorations: ->
    for decoration in @map.decorations
      decoration.draw(@context, @scale)
    
  drawEntities: ->
    for entity in @entities
      entity.draw(@context, @scale)
    
  drawGrid: ->
    @context.strokeStyle = "#000000"
    @context.lineWidth = 1
    for x in @xRange
      for y in @yRange
        @context.strokeRect(x * @scale, y * @scale, @scale, @scale)
        
  
  
new DndApp.Tester('mapCanvas', (element) ->
  mapCanvas = new DndApp.MapCanvas(25)
  window.mapCanvas = mapCanvas
  window.map = mapCanvas.map
  window.painter = painter =
    paint: "empty"
    click: (event) ->
      if mapCanvas.state == "painter"
        mapCanvas.map.setTile(event.x, event.y, painter.paint)
  element.append(mapCanvas.canvasElement)
  console.log(mapCanvas)
  mapCanvas.drawMap()
  mapCanvas.state = "painter"
  mapCanvas.registerListener(painter)
  
)