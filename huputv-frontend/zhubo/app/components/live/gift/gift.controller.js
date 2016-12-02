import DataService from 'dataService';
import angular from 'angular';


class Controller {
  constructor($scope, $timeout, $window, cachePool, uploadImage) {
    this.$scope = $scope;
    this.$timeout = $timeout;
    this.$window = $window;
    this.userData = cachePool.pull('user');

    this.getData();

    $scope.handleAdd = () => {
      this.add();
    }

    $scope.handleRemove = () => {
      this.remove();
    }

    $scope.handleSetActive = (item, list) => {
      this.handleSetActive(item, list);
    }

    $scope.handleSubmit = (params = {}, form) => {
      this.submit(params, form);
    }
  }
  getData() {

    DataService.get('/zhubo/gift/get')
      .then((data) => {
        if(data.code === 1){
          this.$scope.$apply(() => {
            if(angular.isUndefined(data.data.giftOrder)){
              this.$scope.leftscope = [];
            }else{
              this.$scope.leftscope = data.data.giftOrder;
            }

            if(angular.isUndefined(data.data.list)){
              this.$scope.rightscope = [];
            }else{
              this.$scope.rightscope = data.data.list;
            }

            this.setHeight();
          })
          return;
        }
      });
  }
  /**
   * 设置高度
   */
  setHeight() {
    let len = Math.max(this.$scope.leftscope.length, this.$scope.rightscope.length);
    let height = len * 66;
    let viewHeight = this.$window.innerHeight - 180;

    if(height > viewHeight){
      height = viewHeight;
    }

    this.$scope.popup.reset();

    this.$scope.giftScrollStyle = {
      'height': height + 'px',
      'overflow-y': 'auto'
    }
  }
  /**
   * 添加
   */
  add() {
    if(!this.$scope.rightscope.length){
      return;
    }

    if(this.$scope.leftscope.length >= 6){
      alert("展示礼物最多可设置6个");
      return;
    }

    this.$scope.rightscope.map((item, index) => {
      if(item.active){
        item.active = false;
        this.$scope.rightscope.splice(index, 1);
        this.$scope.leftscope.push(item);
      }
    })
  }
  /**
   * 删除
   */
  remove(){
    if(!this.$scope.leftscope.length){
      return;
    }
    this.$scope.leftscope.map((item, index) => {
      if(item.active){
        item.active = false;
        this.$scope.leftscope.splice(index, 1);
        this.$scope.rightscope.push(item);
      }
    })
  }
  /**
   * 礼物列表
   * @return {[type]} [description]
   */
  handleSetActive(item, list) {
    list.map(item => {
      if(item.active){
        return item.active = false;
      }
    })

    item.active = true;
  }
  /**
   * 发送
   * @return {[type]} [description]
   */
  submit(params, form) {

    console.log(params);

    let arr = {
      rank: params
    }

    if(!form.$valid){
      return;
    }

  	DataService.post('/zhubo/gift/set', arr)
      .then((data) => {
        console.log(data);
        if(data.code === 1){
          location.reload();
          return;
        }

        this.$scope.$apply(() => {
          this.$scope.error = data.msg;
        })

        this.$timeout(() => {
          this.$scope.error = '';
        }, 2000)
      });
  }
}

Controller.$inject = ['$scope', '$timeout', '$window', 'cachePool', 'uploadImage'];

export default Controller;
