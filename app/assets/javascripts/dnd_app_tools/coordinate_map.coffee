DndApp = window.DndApp
DndApp.CoordinateMap = class CoordinateMap
  constructor: (@height, @width) ->
    tile = "empty"
    if arguments.length > 2
      tile = arguments[2]
    @tileMap = []
    @listeners = []
    if @height > 0 && @width > 0
      @setData(
        width: @width
        height: @height
        tile: tile
      )
    @decorations = []
  
  @newMap: (width, height, tile) =>
    data =
      width: width || 10
      height: height || 10
      tile: tile || "empty"
    map = @getMap()
    map.setData(data)
    map
  @getMap: ->
    if DndApp.currentMap
      DndApp.currentMap
    else
      DndApp.currentMap = new CoordinateMap(4,4) 
      DndApp.currentMap
  
  registerListener: (listener) ->
    if @listeners.indexOf(listener) < 0
      @listeners.push(listener)
  
  addDecoration: (decoration) ->
    if @decorations.indexOf(decoration) < 0
      @decorations.push(decoration)
  
  tellListeners: ->
    for listener in @listeners
      listener.mapUpdated()
  
  getTile: (x,y) ->
    if @width > x && x >= 0 && @height > y && y >= 0
      DndApp.tiles[@tileMap[x][y]]
    else
      null
  
  addColumn: (data) ->
    if data
      if data.index == 0
        index = data.index
      else
        index = data.index || @width
      tile = data.tile || "empty"
      @tileMap.splice(index, 0,
        for y in [0..(@height - 1)]
          y = tile
      )
    else
      @tileMap.push( 
        for y in [0..(@height - 1)]
          y = "empty"
      )
    @width = @tileMap.length
    @tellListeners()
    @width
  
  addBorder: (tile) ->
    @addRow(
      tile: tile
    )
    @addRow(
      index: 0
      tile: tile
    )
    @addColumn(
      tile: tile
    )
    @addColumn(
      index: 0
      tile: tile
    )
  addRow: (data) ->
    if data
      if data.index == 0
        index = data.index
      else
        index = data.index || @height
      tile = data.tile || "empty"
      for x in @tileMap
        x.splice(index, 0, tile)
    else
      for x in @tileMap
        x.push('empty')
    @height = @tileMap[0].length
    @tellListeners()
    @height
  setTile: (x,y,tile) ->
    if x < @width && y < @height && x >= 0 && y >= 0
      @tileMap[x][y] = tile
      @tellListeners()
      tile
    else
      alert "Trying to set tile outside of map bounds!"
  setData: (data) ->
    @height = data.height || @height
    @width = data.width || @width
    @tileMap = []
    for x in [0..(@width - 1)]
      @tileMap[x] = []
      for y in [0..(@height - 1)]
        if data.tileMap && data.tileMap[x] && data.tileMap[x][y]
          @tileMap[x][y] = data.tileMap[x][y]
        else if data.tile
          @tileMap[x][y] = data.tile
        else
          @tileMap[x][y] = "empty"
    @tellListeners()