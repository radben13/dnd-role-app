angular.module("dnd_app")
.provider("DndStringTools", ->
  obj =
    titleize: (string) ->
      matches = string.match(/[-_\s\t\n\r][A-Za-z]/g)
      if /[a-zA-Z]/.test string[0]
        string = string[0].toUpperCase() + string.substr(1)
      for match in matches
        replacer = " " + match[1]
        string = string.replace(match, replacer)
      string
    rubify: (string) ->
      matches = string.match(/[-_\s\t\n\r]+[A-Za-z]/g)
      for match in matches
        replacer = "_" + match[match.length - 1]
        string = string.replace(match, replacer)
      string = string.toLowerCase()
      string
      
)