import DataService from 'dataService';

class VideoController {
  constructor($scope, $rootScope, cachePool, clipboard) {
    this.$scope = $scope;
    this.userInfo = cachePool.pull('user');

    this.getData();

    // 剪切板
    $scope.is_supported = !clipboard.supported; 
    $scope.handleClipboard = (pos) => {
      if(+pos === 1) {
        clipboard.copyText(this.$scope.url);
      }else{
        clipboard.copyText(this.$scope.stream);
      }
      
      alert('复制成功');
    }
    
    $scope.handleClick = () => {
      this.getData();
    }  
  }
  getData() {

  	DataService.get('/zhubo/stream', {room_id: this.userInfo.id})
      .then((data) => {
        if(data.code === 1) {
          let publish = data.data.publish;
          
          this.$scope.$apply(() => {
            this.$scope.url = publish.url;
            this.$scope.stream = publish.stream;
          })          
        }
      });
  }
}

VideoController.$inject = ['$scope', '$rootScope', 'cachePool', 'clipboard'];

export default VideoController;
