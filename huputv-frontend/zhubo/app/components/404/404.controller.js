class HomeController {
  constructor($scope) {
    
    $scope.back = () => {
      history.back();
    }

  }
}

export default HomeController;
