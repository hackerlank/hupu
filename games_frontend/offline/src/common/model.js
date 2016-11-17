import _ from 'underscore'
import Store from './store'
import getHeaders from './header'
import { isIOS, info } from './app'

/**
 * @class Model
 * 核心model层，用于数据获取 和 数据缓存
 */
class Model {
    constructor(name, request, url, method = 'get', expire = 0) {
       this.request = request;
       this.url = url;
       this.method = method.toLowerCase();
       this.params = { offline: 'json', client: info.client };
       this.expire = expire;

       this.store = new Store(`hupu_${name}`, expire);
    }
    getUrl(){
        const client = isIOS ? 3 : 1
        const version = info.version
        let url  = `/${client}/${version}${this.url}`
        return url
    }

    getMethod(){
        //方法兼容
        let methods = ['get','post','put','delete']
        if(~methods.indexOf(this.method)){
            return this.request[this.method]
        }else{
            return this.request['get']
        }
    }

    bind( params = {} ){
        this.params = _.extend(this.params, params);
        return this
    }

    //绑定从客户端获取的header，做为和服务端通信的信任机制.
    bindHeaders(){
        if(this.method != 'get'){
            this.params = _.extend(this.params, getHeaders());
        }
        return this
    }

    execute(sucessCallback, errCallback){
        if(this.expire !== 0 && this.store.hasValue(this.params)){
            sucessCallback(this.store.getValue());
        } else{
            this.bindHeaders().getMethod()(this.getUrl(), this.params).then(res => {
                if(res.status === 0){
                    sucessCallback(res);
                    this.store.setValue(this.params, res);
                } else{
                    errCallback && errCallback(res)
                }
            }).catch(err => {
                errCallback && errCallback(err)
            });
        }
    }
}

module.exports = Model
