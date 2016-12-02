import angular from 'angular';

class CrumbController {
  constructor($scope, $state, $interpolate) {
    this.$scope = $scope;
    this.$interpolate = $interpolate;
    // console.log($state.$current);  
    // console.log($interpolate());  
    // 
    this.items = []; 
    
    this.getBreadcrumbs($state.$current);

    this.$scope.items = this.items;
  }
  /**
   * 获取面包屑
   * @param  {[type]} state [description]
   * @return {[type]}       [description]
   */
  getBreadcrumbs(state){
    if(angular.isDefined(state.parent)) {
      this.getBreadcrumbs(state.parent);
    }

    if(angular.isDefined(state.data)) {
      if(angular.isDefined(state.data.displayName)) {
        this.items.push({
          title: this.$interpolate(state.data.displayName)(state.locals.globals),
          state: state.name
        })
      }
    }
  }
}

CrumbController.$inject = ['$scope', '$state', '$interpolate'];

export default CrumbController;
