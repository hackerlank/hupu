class ErrorController {
  constructor($scope, $state, $stateParams, cachePool) {
    this.$scope = $scope;
    this.page = $stateParams.page;
    this.userData = cachePool.pull('user');

    if(+this.userData.status === 0 || (this.userData.is_login && !angular.isUndefined(this.userData.id))){
      $state.go('app.index');
    }

    if(this.page === 1001){
      this.getBanned();
    }
    
    $scope.back = () => {
      history.back();
    }
  }
  /**
   * 获取封禁
   * @return {[type]} [description]
   */
  getBanned() {
    var data = {
      title: '你的房间被封禁！暂时无法直播,请联系客服MM哦！'
    }

    let isBan = angular.isUndefined(this.userData.ban);

    if(!isBan){
      let ban = this.userData.ban;
      data = Object.assign(data, {
        reason: ban.reason,
        time: ban.duration + '小时'
      });
    }

    this.$scope.data = data;
  }
}

ErrorController.$inject = ['$scope', '$state', '$stateParams', 'cachePool'];


export default ErrorController;
