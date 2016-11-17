import * as bridge from 'common/bridge'
import { dom } from './utils'

const ua = navigator.userAgent

export const isInWeixin = ~ua.indexOf('MicroMessenger');
export const isIOS = /iPhone|iPad|iPod/i.test(ua);
export const isAndroid = /Android/i.test(ua);
export const isWinPhone = /Windows\sPhone/i.test(ua);
export const info = window.HupuBridge.nainfo;

/**
 * webapp 页面最开始初始化方法
 * @param  {Object} config 客户端基本信息
 * @return {void}
 */
export function initPage(config){
    //更新页面模式
    if(config.night){
        dom.addClass(document.body, "night");
    } else{
        dom.removeClass(document.body, "night");
    }

    //更新字体
    bridge.register("update")
}

/**
 * webApp 初始化方法
 * @param  {function} initCallBack bridgeready回调
 * @return {void}
 */
export function App(initCallBack){
  if(bridge.isInApp){
    if(window.HupuBridge.ready){
        initCallBack(bridge.debug, info.env);
    }else{
        document.addEventListener("hupuBridgeReady", function(){
            initCallBack(bridge.debug, info.env);
        });
    }
  }else{
      initCallBack(bridge.debug, info.env);
  }
}

/**
 * 校验登陆
 * @param  {function} loginCallback 登陆回调
 * @return {void}
 */
export function checkLogin( loginCallback ){
     bridge.send("hupu.user.login", {}, () =>{
        loginCallback && loginCallback()
     })
}

/**
 * 设置标题
 * @param {string} title 标题
 * @param {string} subTitle 二次标题
 */
export function setTitle( title = "", subTitle = "" ){
    document.title = `${title}-${subTitle}`
    bridge.send("hupu.ui.header", {
        title : title,
        subtitle : subTitle
    })
}
