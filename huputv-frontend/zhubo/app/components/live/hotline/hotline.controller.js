import DataService from 'dataService';
import io from 'socket.io-client';

class Controller {
  constructor($scope, $rootScope, $state, $timeout, cachePool) {
    this.$scope = $scope;
    this.$state = $state;
    this.userData = cachePool.pull('user');
    this.$scope.message_item = [];
    this.$scope.gift_item = [];

    // this.getFirstData();
    this.socket();
    this.top();
  }
  /**
   * socket
   */
  socket() {
    DataService.get('/zhubo/message-server')
      .then((data) => {
        if(data.code === 1){
          let ip = this.getRandomNumber(data.data);
          
          let socket = io.connect(ip);

          socket.on('connect', () => {
            socket.emit('join', {
              et: 1000,
              via: 5,
              room_id: this.userData.id,
              match_id: this.userData.match_id
            });
          });

          // 监听
          socket.on('wall', data => {
            if(angular.isUndefined(data.et)){
              return;
            }

            this.upload(data);
          })

          // 重连
          socket.on('error', function (data) {
          })
        }
      });
  }
  upload(data) {

    switch(data.et) {
      // 在线人数   
      case 1010:  
        this.$scope.$emit('onlinePeopleNumber', data.n);
        break;
      // 热线   
      case 2000:  
        this.$scope.$apply(() => {
          this.$scope.message_item.unshift(data);
        });
        break;
      // 送礼   
      case 2001:  
        this.$scope.$apply(() => {
          this.$scope.gift_item.unshift(data);
        });

        this.top();
        break;
    }

    // if(!angular.isUndefined(data[0].event_type) && data[0].event_type === 2002) {
    //   this.$state.go('app.error', {page: 1001});
    //   return;
    // }
  }
  /**
   * 进入页面，获取数据
   * @param  {[type]} params [description]
   * @return {[type]}        [description]
   */
  getFirstData() {
    DataService.get('/zhubo/latest')
      .then((data) => {
        if(data.code === 1) {
          this.$scope.$apply(() => {
            let items = [...data.data.message, ...data.data.gift];
            this.$scope.items = items;
          })
        }
      });
  }
  /**
   * 排行榜
   * @return {[type]} [description]
   */
  top() {
    DataService.get('/zhubo/ranking')
      .then((data) => {
        if(data.code === 1) {
          this.$scope.$apply(() => {
            this.$scope.tops = data.data.room;
          })
        }
      });
  }
  /**
   * 随机数
   * @param  {[type]} arr [description]
   * @return {[type]}     [description]
   */
  getRandomNumber(arr){
    var len = arr.length,
        count = Math.floor(Math.random() * len);

    return arr[count];
  }
}

Controller.$inject = ['$scope', '$rootScope', '$state', '$timeout', 'cachePool'];

export default Controller;
