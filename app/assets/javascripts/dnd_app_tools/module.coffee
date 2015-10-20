# This code was pulled and adapted by Radben13 from
# --
# The Little Book on CoffeeScript
# By Alex MacCaw
# --

DndApp.moduleKeywords = ['extended', 'included']

DndApp.DndModule = class DndModule
  @extend: (obj) ->
    for key, value of obj when key not in window.moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in window.moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    obj.included?.apply(@)
    this