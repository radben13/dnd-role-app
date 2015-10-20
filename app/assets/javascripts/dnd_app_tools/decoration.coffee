DndApp = window.DndApp
DndApp.Decoration = class Decoration
  constructor: (@name, @x, @y, imgSrc) ->
    @img = new Image()
    @img.src = imgSrc || "https://s3.amazonaws.com/radben13/assets/img/defaultDecoration.png"
  draw: (context, scale) ->
    context.drawImage(@img, x * scale, y * scale, scale, scale)


DndApp.Door = class Door extends Decoration
  constructor: (name, pos1, pos2, imgSrc) ->
    if pos1.x != pos2.x
      if pos1.x > pos2.x
        x = pos1.x - 0.5
      else
        x = pos1.x + 0.5
      y = pos1.y
      @angle = "h"
    else
      if pos1.y > pos2.y
        y = pos1.y - 0.5
      else
        y = pos1.y + 0.5
      x = pos1.x
      @angle = "v"
    super(name, x, y, imgSrc)