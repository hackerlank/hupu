import DataService from 'dataService';
import _ from 'underscore';

class Controller {
  constructor($scope, $state, cachePool) {
    this.$scope = $scope;
    this.$state = $state;
    this.userData = cachePool.pull('user');
    this.isLive = (+this.userData.is_live === 1);

    this.$scope.online_people_number = this.userData.online;
    this.$scope.allow_predict = !!+this.userData.allow_predict;

    // 更新人数
    this.$scope.$on('onlinePeopleNumber', (e, number) => {
      if(this.$scope.online_people_number != number){
        this.$scope.$apply(() => {
          this.$scope.online_people_number = number;
        })
      }
    });

    // 礼物打开
    this.$scope.setGiftOpen = () => {

      this.$scope.popupgift = {
        open: true
      };
    }

    this.$scope.handleSendRemind = () => {
      this.sendRemind();
    }

    this.$scope.handleLiveSwitch = () => {
      this.liveSwitch();
    }
  }
  /**
   * 直播切换，开始直播、结束直播
   * @return {[type]} [description]
   */
  liveSwitch() {
    let params = {
      switch: 'open'
    }

    // 直播中状态
    if(this.isLive){
      params.switch = 'close';

      if(!confirm('你是否要结束直播')){
        return;
      }

      // 校验预测状态
      // 先验证是否有预测权限
      if(this.$scope.allow_predict){
        DataService.get('/zhubo/topic')
          .then(data => {
            //已开预测
            if(data.code == 1 && _.isObject(data.data) && data.data.id){
                let status = data.data.status;
                //已开奖 或 已流盘
                if(status == 2 || status == 3){
                  this.changeLiveStatus(params);
                } else {
                  alert("你有未开奖的比赛预测，请在开奖后再结束直播");
                }
            } else{
              this.changeLiveStatus(params);
            }

          })
      } else{
        this.changeLiveStatus(params);
      }
    } else{
      this.changeLiveStatus(params);
    }

  }

  /**
   * 更新直播状态
   */
  changeLiveStatus(params){
    DataService.get('/zhubo/live-switch', params)
      .then((data) => {
        if(data.code === 1) {
          location.reload();
          return;
        }

        alert(data.msg);
      });
  }
  /**
   * 发送提醒
   */
  sendRemind() {
    DataService.get('/zhubo/live-remind')
      .then((data) => {
        alert(data.msg);
      });
  }
}

Controller.$inject = ['$scope', '$state', 'cachePool'];

export default Controller;
