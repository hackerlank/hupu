import DataService from 'dataService';

const Api = {
  getList: '/zhubo/topic',
  stop: '/zhubo/topic/stop/:id',
  cancel: '/zhubo/topic/cancel/:id'
}

class PredController {
  constructor($scope, $timeout, cachePool) {
    this.$scope = $scope;
    this.$timeout = $timeout;
    this.userData = cachePool.pull('user');

    $scope.list = [];

    $scope.popup = {
      open: false
    };

    $scope.popupoption = {
      open: false
    };

    // 计算总数
    $scope.computeTotle = data => {
      let totle = 0;

      data.map(item => {
        totle += (+item.total_count);
      })

      return totle;
    }


    // 打开
    $scope.handleNewPred = () => {
      this.newPred();
    }
    // 修改
    $scope.handleModify = (item) => {
      this.modifyPred(item);
    }
    // 开奖
    $scope.handleFinishPred = (item) => {
      this.finishPred(item);
    }

    // 选项
    $scope.handleOption = (item) => {
      this.optionDetail(item);
    }

    // 封盘
    $scope.handleStopPred = (id, index) => {
      this.stopPred(id, index);
    }

    // 流盘
    $scope.handleCancelPred = (id, index) => {
      this.cancelPred(id, index);
    }

    this.getList();
  }
  /**
   * 获得预测状态
   */
  getList() {
    const url = Api.getList;

    DataService.get(url)
      .then(data => {
        if(data.code == 1) {
          this.$scope.$apply(() => {
            this.$scope.list = data.data;
          })
        }
      })
  }
  /**
   * 新建
   * @return {[type]} [description]
   */
  newPred() {
    this.$scope.is_create = 1;
    this.$scope.is_edit = 1;
    this.$scope.pred_data = [];
    this.$scope.pred_option = [];

    this.openModal();
  }
  /**
   * 修改
   * @param  {Number} id    [description]
   * @param  {[type]} index [description]
   * @return {[type]}       [description]
   */
  modifyPred(data) {

    this.$scope.is_create = 0;
    this.$scope.is_edit = 1;
    this.$scope.pred_data = data;
    this.$scope.pred_option = [];

    this.openModal();
  }
  /**
   * 开奖
   * @param  {[type]} data [description]
   * @return {[type]}      [description]
   */
  finishPred(data){
    this.$scope.is_create = 0;
    this.$scope.is_edit = 0;
    this.$scope.pred_data = data;
    this.$scope.pred_option = data.option;

    this.openModal();
  }
  /**
   * 打开弹出
   * @return {[type]} [description]
   */
  openModal() {
    this.$scope.popup.open = true
  }
  /**
   * 选项详情
   * @return {[type]} [description]
   */
  optionDetail(data) {
    this.$scope.popupoption.open = true;
    this.$scope.optionDetail = data;
  }
  /**
   * 封盘
   */
  stopPred(id = 0, index) {
    const url = Api.stop.replace(':id', id);

    if(confirm("确定要封盘吗？")) {
      DataService.put(url)
        .then(data => {
          if(data.code == 1){
            this.$scope.$apply(() => {
              this.$scope.list[index].status = 1;
            })

          }
        })
    }
  }
  /**
   * 流盘
   */
  cancelPred(id = 0, index) {
    const url = Api.cancel.replace(':id', id);

    if(confirm("确定要流盘吗？")) {
      DataService.put(url)
        .then(data => {
          if(data.code == 1){
            this.$scope.$apply(() => {
              this.$scope.list[index].status = 3;
            })
          }
        })
    }
  }
}

PredController.$inject = ['$scope', '$state', 'cachePool'];

export default PredController;
