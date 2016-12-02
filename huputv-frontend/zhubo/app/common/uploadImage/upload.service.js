import angular from 'angular';
import DataService from 'dataService';

let app = angular.module('uploadImage', [])
  .service('uploadImage', ['$q', function ($q) {
    return {
      base64(file) {
        let deferred = $q.defer();
        let URL = window.URL || window.webkitURL,
            blob = URL.createObjectURL(file);

        let img = new Image();
        
        img.onload = () => {
          canvasURL(img, blob);
        }

        img.error = () => {
          canvasURL(img, blob);
        }  

        img.src = blob;  

        function canvasURL(image, blob) {
          // 生成比例
          let w = image.width,
              h = image.height,
              scale = w / h;

          //生成canvas
          let canvas = document.createElement('canvas'),
            ctx

          if(canvas.getContext) {
            ctx = canvas.getContext('2d');
          }else{
            alert("对不起，您的浏览器不支持图片压缩及上传功能，请换个浏览器试试~");
            return;
          }

          canvas.width = w;
          canvas.height = h;

          ctx.drawImage(image, 0, 0, w, h);

          let base64 = canvas.toDataURL('image/jpeg', 1);

          let params = {
            file_key: 'cover',
            cover: base64
          }

          DataService.post('/upload', params)
            .then(data => {
              console.log('upload', data);
              deferred.resolve(data);
            });  
        } 

        return deferred.promise;
      }
    };
  }]);


export default app;  