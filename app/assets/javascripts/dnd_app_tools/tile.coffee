DndApp = window.DndApp

DndApp.tiles = {}
DndApp.Tile = class Tile
  constructor: (@name, @tileCategory) ->
    data = arguments[2]
    if data 
      if data.hasImg || data.imgSrc
        @img = new Image()
        @img.src = data.imgSrc || "https://s3.amazonaws.com/radben13/assets/img/defaultTile.jpg"
      else if data.fillColor
        @fillColor = data.fillColor
    if !@imgSrc && !@fillColor
      @fillColor = "#000000"
    Tile.registerTile(@)
  
  @tileCategories:
    clear: ['foot', 'flying', 'phasing']
    pit: ['flying']
    obstacle: ['phasing']
    incline: ['climbing', 'flying']
    impassable: []
  
  @registerTile: (newTile) ->
    DndApp.tiles[newTile.name] = newTile
  
  validPathType: (travelType) ->
    Tile.tileCategories[@tileCategory].indexOf(travelType) >= 0
  
  draw: (x, y, context, scale) ->
    if @img
      context.drawImage(@img, x * scale, y * scale, scale, scale)
    else
      context.fillStyle = @fillColor
      context.fillRect(x * scale, y * scale, scale, scale)
  
new Tile('empty', 'impassable')
# Temporary New Tiles
new Tile('stoneFloor', 'clear', {hasImg: true})