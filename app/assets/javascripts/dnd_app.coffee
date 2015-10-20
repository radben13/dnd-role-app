angular.module("dnd_app", ['ui.bootstrap'])
.controller('DndTestCtrl', ['$scope', ($scope) ->
  $scope.dndTestScript
  $scope.testEval = ->
    eval($scope.dndTestScript)
])

window.DndApp = {}