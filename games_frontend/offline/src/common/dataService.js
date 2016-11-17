//import 'whatwg-fetch';
import request from './request'
import Versions from './versions'
import { isAndroid, info } from './app'

export default (API_BASE) => {

  //android 系统版本 < 5.0.0 重写系统fetch接口
  if(isAndroid && Versions.gt("5.0.0", info.osVer)){
      window.fetch = request
  }

  return {
    /**
     *   @example
     *   dataService.get("/info",{a:1}).then((res) =>{
     *       console.log(res);
     *   })
     */
    get(url, params = {}) {
      let query = [];
      let request = `${API_BASE()}${url}`;
      Object.keys(params).forEach(key =>{
          query.push(`${key}=${params[key]}`)
      });
      query = query.join("&");
      request = query ? [request, query].join("?") : request;
      return fetch(request, {
                  mode: 'cors',
                  redirect: 'follow'
              }).then(res => res.json())
    },
    /**
     *   @example
     *   dataService.post("/submit",{ a:1 }).then((res) =>{
     *       console.log(res);
     *   })
     */
    post(url, params = {}){
      let request = `${API_BASE()}${url}`;
      return fetch(request, {
                method: "post",
                headers: {
                    'Content-Type': 'application/json'
                },
                mode: 'cors',
                redirect: 'follow',
                body: JSON.stringify(params)
             }).then(res => res.json())
    },
    /**
     *   @example
     *   dataService.put("/submit",{ a:1 }).then((res) =>{
     *       console.log(res);
     *   })
     */
    put(url, params = {}){
      let request = `${API_BASE()}${url}`;
      return fetch(request, {
                method: "put",
                headers: {
                    'Content-Type': 'application/json'
                },
                credentials: 'include',
                mode: 'cors',
                redirect: 'follow',
                body: JSON.stringify(params)
             }).then(res => res.json())
    },

    /**
     *    @example
     *    dataService.delete("/submit", { a:1 }).then((res) => {
     *        console.log(res);
     *    })
     */
    delete(url, params = {}){
      let request =  `${API_BASE()}${url}`;
      return fetch(request, {
          method: 'delete',
          headers: {
              'Content-Type': 'application/json'
          },
          mode: 'cors',
          redirect: 'follow',
          body: JSON.stringify(params)
      }).then(res => res.json())
    }
  }
}
