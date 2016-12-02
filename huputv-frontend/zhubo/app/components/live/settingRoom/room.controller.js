import DataService from 'dataService';

class Controller {
  constructor($scope, $timeout, cachePool, uploadImage) {
    this.$scope = $scope;
    this.$timeout = $timeout;
    this.uploadImage = uploadImage;
    this.userData = cachePool.pull('user');

    let {room_name, notice, cover, room_type} = this.userData;

    $scope.params = {
      room_name,
      notice,
      cover,
      room_type,
      tips: this.userData.tips
    }

    $scope.cover_url = cover;

    this.getCatalog();
    this.getGift();

    $scope.changeUpload = (event, files) => {
      this.upload(files[0]);
    }

    $scope.handleModifyGift = () => {
      // console.log($scope);
      $scope.close();
      $scope.giftOpen();
    }

    $scope.handleSubmit = (params = {}, form) => {
      this.submit(params, form);
    }
  }
  /**
   * 获取分类
   * @return {[type]} [description]
   */
  getCatalog() {
    DataService.get('/zhubo/catalog')
      .then((data) => {
        if(data.code === 1) {
          let items = data.data.list;
          this.$scope.$apply(() => {
            this.$scope.catalog = items;
            this.$scope.room_type = this.userData.room_type;
          })
        }

      });
  }
  /**
   * 获取礼物
   * @return {[type]} [description]
   */
  getGift() {
    DataService.get('/zhubo/gift/get')
      .then((data) => {
        if(data.code === 1) {
          console.log(data);
          this.$scope.$apply(() => {
            this.$scope.gift_list = data.data;
          })
        }

      });
  }
  /**
   * 上传图片
   * @return {[type]} [description]
   */
  upload(file) {
    this.uploadImage.base64(file, {
        width: 650
      })
      .then((data) => {
        if(data.code === 1){
          this.$scope.cover_url = data.data.url;
          this.$scope.params.cover = data.data.md5;
        }
      });
  }
  /**
   * 发送
   * @return {[type]} [description]
   */
  submit(form) {
    let params = this.$scope.params;

    if(!form.$valid){
      return;
    }

  	DataService.post('/zhubo/set', params)
      .then((data) => {
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

Controller.$inject = ['$scope', '$timeout', 'cachePool', 'uploadImage'];

export default Controller;
