class PopupController {
  constructor($scope) {

    this.closeAction = ['outerchick'];

    this.reset = isUiEvent => {
      $scope.resets();
      if (isUiEvent) {
        $scope.$apply();
      }
    }

    this.close = isUiEvent => {
      $scope.close();
      if (isUiEvent) {
        $scope.$apply();
      }
    };
  }
}

PopupController.$inject = ['$scope'];

export default PopupController;
