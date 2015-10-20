DndApp = window.DndApp

DndApp.pathFinders = []
DndApp.PathFinder = class PathFinder
  constructor: (x, y, travelType) ->
    @position = 
      x: x
      y: y
    @travelType = travelType || 'foot'
    @destination = 
      x: null
      y: null
    @currentPath = []
    @knowsPath = false
    PathFinder.register(@)
    
  isValidTile: (x,y) ->
    map = DndApp.CoordinateMap.getMap()
    tile = map.getTile(x,y)
    if tile
      tile.validPathType(@travelType)
    else
      false
  
  draw: (context, scale) ->
    context.beginPath()
    context.fillStyle = "#55CC55"
    context.arc((@position.x + 0.5) * scale,(@position.y + 0.5) * scale, 0.5 * scale, 0, 2 * Math.PI)
    context.fill()
    
  
  @register: (pathFinder) ->
    DndApp.pathFinders.push(pathFinder)
    
  @executeTurn: ->
    for pathFinder in DndApp.pathFinders
      pathFinder.moveOnPath()
      
  moveOnPath: ->
    if @currentPath.length > 0 && @currentPath[0]
      @position = @currentPath.shift()
      
  moveToPosition: (x, y) ->
    @destination =
      x: x
      y: y
    @buildPath()
    
  buildPath: ->
    @knowsPath = false
    @buildingPath = []
    @addNextSteps(@destination)
    counter = 0
    rejected = []
    while !@knowsPath && counter <= DndApp.CoordinateMap.getMap().width * DndApp.CoordinateMap.getMap().height
      testSteps = []
      for step in @buildingPath
        if step.count > counter
          testSteps.push(step)
      for step in testSteps
        @addNextSteps(step)
      counter++
    if !@knowsPath
      alert "Cannot find path to destination!"
      @buildingPath = []
      return null
    builtPath = []
    prevPosition = @pathEndPoint.prevPosition
    while prevPosition
      builtPath.push(
        x: prevPosition.x
        y: prevPosition.y
      )
      prevPosition = prevPosition.prevPosition
    @currentPath = builtPath
    @pathEndPoint = null
    
  addNextSteps: (position) ->
    nextSteps = []
    count = position.count || 0
    diagonal = position.diagonal || 0
    xRange = [(position.x - 1)..(position.x + 1)]
    yRange = [(position.y - 1)..(position.y + 1)]
    for x in xRange
      for y in yRange
        if x != position.x || y != position.y
          stepDiagonal = diagonal
          stepCount = count + 1
          if Math.abs((x - position.x) + (y - position.y)) == 2
            stepDiagonal += 1
            if stepDiagonal == 2
              stepDiagonal = 0
              stepCount++
          nextSteps.push
            x: x
            y: y
            count: stepCount
            diagonal: stepDiagonal
            prevPosition: position
    removeSteps = []
    for step in nextSteps
      if !@openStep(step) || !@isValidTile(step.x, step.y)
        removeSteps.push(step)
      if step.x == @position.x && step.y = @position.y
        @knowsPath = true
        @pathEndPoint = step
    for step in removeSteps
      nextSteps.splice(nextSteps.indexOf(step), 1)
    for step in nextSteps
      @currentPath.push(step)
    
  openStep: (step) ->
    removed = null
    for stored in @currentPath
      if stored.x == step.x && stored.y == step.y
        if stored.count >= step.count
          removed = stored
        else
          return false
    if removed
      @currentPath.splice(@currentPath.indexOf(removed), 1)
    return true

new DndApp.Tester("pathFinder", ->
  window.mapCanvas = mapCanvas = new DndApp.MapCanvas(100)
  window.map = map = mapCanvas.map
  map.setData({width: 10, height: 5, tile: "stoneFloor"})
)