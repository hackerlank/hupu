import 'isomorphic-fetch';

const API_BASE = (location.port == 80 || location.port == 9091 || location.port == '') ? '' : 'http://dev.liangle.com';

let dataService = {
  getApiBase (){
    return API_BASE
  },
  /**
   *   @example
   *   dataService.get("/info",{a:1}).then((res) =>{
   *       console.log(res);
   *   })
   */
  get (url, params = {}) {
    let query = [];
    let request = `${API_BASE}${url}`;
    Object.keys(params).forEach(key =>{
        query.push(`${key}=${params[key]}`)
    });
    query = query.join("&");
    request = query ? [request, query].join("?") : request;

    return fetch(request, {
        method: "get",
        credentials: 'include',
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      .then(res => res.json())
      .catch(err => {
      })
  },
  /**
   *   @example
   *   dataService.post("/submit",{ a:1 }).then((res) =>{
   *       console.log(res);
   *   })
   */
  post(url, params = {}) {
    let request = `${API_BASE}${url}`;

    return fetch(request, {
              method: "post",
              headers: {
                  'Content-Type': 'application/json'
              },
              credentials: 'include',
              body: JSON.stringify(params)
           }).then(res => res.json())
             .catch(err => {})
  },
  /**
   *   @example
   *   dataService.put("/submit",{ a:1 }).then((res) =>{
   *       console.log(res);
   *   })
   */
  put(url, params = {}){
    let request = `${API_BASE}${url}`;
    return fetch(request, {
              method: "put",
              headers: {
                  'Content-Type': 'application/json'
              },
              credentials: 'include',
              body: JSON.stringify(params)
           }).then(res => res.json())
             .catch(err => {
             })
  },

  /**
   *    @example
   *    dataService.delete("/submit", { a:1 }).then((res) => {
   *        console.log(res);
   *    })
   */
  delete(url, params = {}){
    let request =  `${API_BASE}${url}`;
    return fetch(request, {
        method: 'delete',
        headers: {
            'Content-Type': 'application/json'
        },
        credentials: 'include',
        body: JSON.stringify(params)
    }).then(res => res.json())
      .catch(err => {
      })
  }
};

export default dataService
