angular.module("dnd_app")
.controller('DndTestCtrl', ['$scope', ($scope) ->
  $scope.dndTestScript
  $scope.testEval = ->
    eval($scope.dndTestScript)
])

DndApp = window.DndApp

DndApp.testerMap = {}
DndApp.test = (name) ->
  if DndApp.testerMap[name] != undefined
    DndApp.testerMap[name].start($('#dnd-test-wrapper'))
  else
    alert "That test is not registered."
DndApp.Tester = class Tester
  constructor: (@name, @start) ->
    DndApp.testerMap[@name] = @
  
# new DndApp.Tester('demoTest', ($element) ->
#   $element[0].innerHTML = "You never expected this, did you?"
# )
