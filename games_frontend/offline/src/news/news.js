import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import routerConfig from './router'
import Page from './views/root'
import {App, initPage} from 'common/app'

App(debug => {
    //start page
    initPage(window.HupuBridge.nainfo);
    // Router
    Vue.use(VueRouter);
    const router = new VueRouter({
      hashbang: true,
      history: false,
      saveScrollPosition: false,
      suppressTransitionError: true
    });
    routerConfig(router);
    // Resource
    Vue.use(VueResource);
    // setting request base
    Vue.http.options.emulateJSON = true;
    // Filters
    // Vue.filter('date', filters.dateFilter)
    router.start(Page, '#app')
    window.router = router
})
