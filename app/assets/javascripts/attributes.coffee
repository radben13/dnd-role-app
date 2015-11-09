angular.module("dnd_app")
.controller("DndAttributesController", ["$scope", "$http", "$modal", ($scope, $http, $modal) ->
  $scope.attributesState =
    template: null
  
  $scope.initializeAttrs = 
    open: false
    abilityScoresListTag: null
  $scope.openInitializeAttrs = (list) ->
    $scope.attributesState.template = "initializeAttrs.html"
    $scope.initializeAttrs.open = true
    $scope.initializeAttrs.abilityScoresListTag = list
  $scope.activeForm = ->
    $scope.attributesState.template
])
.controller("NewAttrSetController", ["$scope", "$http", ($scope, $http) ->
  $scope.setRandomPotentialAbilityScores = (list) ->
    for value in list
      abilityScoresList["random"].push(
        value: value
        ability: null
      )
  $scope.setStandardPotentialAbilityScores = (list) ->
    for value in list
      abilityScoresList["standard"].push(
        value: value
        ability: null
      )
  $scope.abilityScoresList = abilityScoresList =
    standard: [
      value: ""
      ability: null
    ]
    random: [
      value: ""
      ability: null
    ]
  
  $scope.validPotentialAbilityScores = (ability) ->
    list = []
    for potential in abilityScoresList[$scope.initializeAttrs.abilityScoresListTag]
      if potential.ability == ability || potential.ability == null
        list.push(potential)
    list
  
  $scope.attributeSet =
    strength:       ""
    dexterity:      ""
    constitution:   ""
    intelligence:   ""
    charisma:       ""
    wisdom:         ""
  $scope.chosenAttributes = []
  $scope.validValues = ->
    valid = true
    for key,value of $scope.attributeSet
      if !value
        valid = false
    valid
    
  $scope.chooseAttribute = (ability) ->
    for potential in $scope.validPotentialAbilityScores(ability)
      if potential.ability == ability
        potential.ability = null
    filled = false
    for potential in $scope.validPotentialAbilityScores(ability)
      if potential.value != "" && $scope.attributeSet[ability] == potential.value && !filled
        potential.ability = ability
        filled = true
    console.log($scope.attributeSet)
])