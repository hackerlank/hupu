import DataService from 'dataService';

class Controller {
  constructor($scope, $timeout, cachePool) {
    this.$scope = $scope;
    this.$timeout = $timeout;
    this.userData = cachePool.pull('user');

    $scope.keydown = (event, params = {}, form) => {
      // Enter
      if(event.which === 13){
        this.submit(params, form);
        event.preventDefault();
      }
    }

    $scope.handleSubmit = (params = {}, form) => {
      this.submit(params, form);
    }  
  }
  /**
   * 发送
   * @return {[type]} [description]
   */
  submit(params, form) {

    form.$setSubmitted();

    if(angular.isUndefined(params.content) || params.content === ''){
      return;
    }

    if(!(angular.isUndefined(params.link) || params.link === '') && !/:\/\//.test(params.link)){
      this.$scope.error = '链接地址不包含http://、https://将无法正常显示,请修改地址！';
      return;
    }


    let client = 'chat_' + this.userData.lid + '_' + this.userData.gid + '_' + this.userData.id + '_' + (this.userData.is_login ? 0 : this.userData.uid)

    params = Object.assign({
      client
    }, params);

  	DataService.post('/zhubo/message', params)
      .then((data) => {
        this.$scope.$apply(() => {
          if(data.code === 1) {
            this.$scope.params = angular.copy({});
          }

          this.$scope.error = data.msg;
        })

        this.$timeout(() => {
          this.$scope.error = '';
          form.$setPristine();
        }, 2000)
      });
  }
}

Controller.$inject = ['$scope', '$timeout', 'cachePool'];

export default Controller;
