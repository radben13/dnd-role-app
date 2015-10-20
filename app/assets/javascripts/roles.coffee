angular.module("dnd_app")
.factory("DndClassFactory", ["$http", ($http) ->
  roleTypes =
    typeList: []
    raceList: []
    get: ->
      $http.get("/api/roles/types").then((response) ->
        angular.extend(roleTypes, response.data)
        console.log([roleTypes, response.data]);
      , (response) ->
        console.log("Error in http request!")
      )
  roleTypes.get()
  roleTypes
  
])
.controller("RoleFormCtrlOne", ["$scope", "DndClassFactory",  ($scope, DndClassFactory) ->
  newRole = $scope.newRole = {}
  tempRole = $scope.tempRole = {}
  roleTypes = $scope.roleTypes = DndClassFactory
])