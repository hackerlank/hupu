import * as util from './utils'
import parseDate from './parseDate'

let storeData = {};

function paramsHashKey( params ){
    return JSON.stringify(params)
}

/**
 * @class Store
 * 核心存储层，将单页数据保存于localStorage中
 */
class Store {
    constructor(name, expire = 0) {
       this.name = name;
       this.expire = parseDate(expire);
       this.store = util.isSupportLocalStorage ? window.localStorage : storeData;
    }

    hasValue( params = {} ){
        if(this.expire === 0) return false

        let data = this.store[this.name];
        //解析data
        if(data && data.length){
            try{
                data = JSON.parse(data);
            }catch(e){
                data = {}
            }
        }

        if(data && data.value && data.expire){
            if(util.getTime() < data.expire && paramsHashKey(params) == data.params ){
                return true
            } else{
                return false
            }
        }
        return false
    }

    /**
     * getValue 获取数据
     * {
     *    expire: 14000002000, //过期毫秒数
     *    value:  [data]       //本地存储的数据
     * }
     *
     * @return {Object}  返回数据
     */
    getValue(){
        let data = this.store[this.name];
        data = JSON.parse(data);
        return data.value
    }
    /**
     * setValue 设置存储
     */
    setValue( params = {}, value ){
        if(this.expire === 0) return false
        let data = {
            expire : util.getTime() + this.expire,
            params : paramsHashKey(params),
            value  : value
        }
        this.store[this.name] = JSON.stringify(data);
    }
}

module.exports = Store
