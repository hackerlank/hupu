import angular from 'angular';
import DataService from 'dataService';

let app = angular.module('userService', [])
  .service('userService', ['$q', ($q) => {
    return {
      saveData: {},
      number: 0,
      get(){
        let deferred = $q.defer();

        DataService.get('/zhubo/id')
          .then(data => {
            if(data.code === 1){
              let params = data.data;

              params.is_login = (params === null);
              deferred.resolve(params);              
            }else{
              deferred.reject(data.msg);
            }  
          });

        return deferred.promise;  
      }
    }
  }])

export default app
