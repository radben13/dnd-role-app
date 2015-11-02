angular.module("dnd_app")
.controller("DndAttributesController", ["$scope", "$http", "$modal", ($scope, $http, $modal) ->
  $scope.attributesState =
    template: null
  
  $scope.initializeAttrs = 
    open: false
  $scope.openInitializeAttrs = ->
    $scope.attributesState.template = "initializeAttrs.html"
    $scope.initializeAttrs.open = true
  $scope.activeForm = ->
    $scope.attributesState.template
])