import DataService from 'dataService';
import _ from 'underscore';

const Api = {
  topic: '/zhubo/topic',
  finish: '/zhubo/topic/finish/:id'
}

class Controller {
  constructor($scope, $timeout, cachePool) {
    this.$scope = $scope;
    this.$timeout = $timeout;
    this.userData = cachePool.pull('user');

    $scope.showDate = function(){
      $(".dropdown-date").toggle();
    }
    $scope.beforeRender = function ($view, $dates, $leftDate, $upDate, $rightDate) {
      var now = Date.now();
      $dates.forEach(date => {
        if(date.localDateValue() <= now){
          date.selectable = false;
        }
      })
    }

    const params = {
      title: '',
      option: [
        {"option_id" : 0, "option" : ""},
        {"option_id" : 0, "option" : ""}
      ],
      id: 0,
      score: "20",
      stop_time: new Date()
    }

    $scope.params = Object.assign(params, JSON.parse($scope.preddata));
    $scope.option_list = JSON.parse($scope.predOption);


    //开奖选项
    $scope.finishParams = null;

    //开盘
    $scope.handleStop = () => {
      this.stopPred();
    }

    // 添加选项
    $scope.handleAddOption = () => {
      $scope.params.option.push({"option_id" : 0, "option" : ""})
    }

    //开奖
    $scope.handleFinishPred = (option) => {
      this.finishPred(option);
    }

    //提交
    $scope.handleSubmit = (params = {}, form) => {
      this.submit(params, form);
    }
  }
  /**
   * 开奖
   */
  finishPred(option) {
    if(!option){
      this.$scope.error = '必须选择一项才能开奖!'
      return;
    }

    const url = Api.finish.replace(':id', this.$scope.params.id);
    const params = {
      option
    }

    if(confirm(`开奖选项: [${option}]`)){
      DataService
        .put(url, params)
        .then(data => {
          if(data.code == 1){
            this.$scope.$apply(() => {
              this.$scope.close();
            });
            location.reload();
            return;
          }

          this.$scope.$apply(() => {
            this.$scope.error = data.msg;
          })

        })
    }
  }
  /**
   * 发送
   * @return {[type]} [description]
   */
  submit(params, form) {
    if(!form.$valid){
      return;
    }

    let request = Api.topic;
    let method = "post";

    if(!this.$scope.autoPred){
      delete params.stop_time;
    }

    if(params.id === 0){
      delete params.id;
    }else{
      request = `${request}/${params.id}`;
      method = "put";
    }

    let param = Object.assign({}, params);
    let option = [];

    param.option.map((item, index) => {
      option.push(item.option);
    })
    param.option = option.join(',');

    this.$scope.isSaving = true;

  	DataService[method](request, param)
      .then((data) => {
        if(data.code === 1){
          this.$scope.$apply(() => {
            this.$scope.isSaving = false;
            this.$scope.close();
          })

          location.reload();
          return;
        }

        this.$scope.$apply(() => {
          this.$scope.error = data.msg;
          this.$scope.isSaving = false;
        })

        this.$timeout(() => {
          this.$scope.error = '';
        }, 2000)
      });
  }
}

Controller.$inject = ['$scope', '$timeout', 'cachePool'];

export default Controller;
