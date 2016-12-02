/**
 * @file 封装dace接口
 * @author yuhongfei@hupu.com
 **/
let _queue = [];
let maxCache = 20;

module.exports = {
    init(e) {
        this.listenElement(e);
        this.listenDace();
    },
    /**
     * 监听元素点击的事件. 在标签上添加 dace-node 属性，点击行为被自动收集.
     * @example
     *    <div dace-node="example">example</div>
     **/
    listenElement(e) {
        let nodeName = 'dace-node';
        let {send} = this;
        let {target} = e;

        while (!target.getAttribute(nodeName) && 'BODY' !== target.tagName) {
            target = target.parentElement;
            if (!target) {
                break;
            }
        }
        if ('BODY' !== target.tagName) {
            let daceData = target.getAttribute(nodeName);
            send(daceData);
        }
    },
    /**
     * 监听dace是否ready
     **/
    listenDace() {
        var self = this;
        this.interval = setInterval(() => {
            if (window.__dace && window.__dace.sendEvent) {
                clearInterval(self.interval);
                if (_queue && _queue.length) {
                    self.send();
                }
            }
        }, 5000);
    },
    /**
     * 做个简单的队列，避免丢失统计数据.
     *
     * @param {string} daceStr dace的数据
     * @return {void}
     */
     send(daceStr, param) {
        if(window.__dace){
            let sendHandler = window.__dace.sendEvent;

            if(daceStr && daceStr.length) {
                sendHandler(daceStr, param);
            }
            if(_queue && _queue.length){
                _.each(_queue, (item) => {
                    sendHandler(item.name, item.param);
                });
                _queue = [];
            }
        } else{
            if(daceStr && daceStr.length) {
                if(_queue.length >= maxCache){
                    _queue.shift();
                }
                _queue.push({
                    name: daceStr,
                    param: param
                });
            }
        }
     },
    /**
     * 发送百度自定义事件
     * @param {array} arr 自定内容
     */
     sendBaiduEvent(arr) {

        if(window._hmt && arr instanceof Array){
            arr = ['_trackEvent'].concat(arr);

            _hmt.push(arr);
        }
     },
    getCookie(name) {
      var value = "; " + document.cookie;
      var parts = value.split("; " + name + "=");
      if (parts.length == 2) return parts.pop().split(";").shift();
    },
     merge_options(obj1,obj2){
        var obj3 = {};
        for (var attrname in obj1) { obj3[attrname] = obj1[attrname]; }
        for (var attrname in obj2) { obj3[attrname] = obj2[attrname]; }
        return obj3;
    },
     /**
     * 发送动云事件
     */
     sendArenaCloudEvent(path, param) {
        if(window.XMLHttpRequest && window.GM){
            var isMobile = /(android|ip(hone|od|ad))/i.test(navigator.userAgent);
            var streamurl = document.getElementsByTagName('source')[0].getAttribute('src');
            var commonParam = {
                "head": {
                  "streamId": GM.room_id,           //流ID or 房间ID    （新模式huputTv自己填充）
                  "streamName": document.title,         //流名称 or房间名称   （新模式huputTv自己填充）
                  "platform": GM.platform,          //平台 ios/android/pc/h5
                  "time": Math.floor(new Date().getTime()/1000),      //秒时间戳
                  "isRegister": GM.islogin,      //秒时间戳
                  "streamUrl": streamurl,          //流URL
                  "token": this.getCookie('__dacevid3') || this.getCookie('_dacevid3'),             //用户唯一标识
                  "deviceNo": GM.client || this.getCookie('__dacevid3') || this.getCookie('_dacevid3'),             //用户唯一标识，使用dacevid
                  "match_id": GM.match_id
                }
            };
            var xhr = new XMLHttpRequest();
            xhr.open('GET', '/acloud/log?path=' + path + '&data=' + JSON.stringify(this.merge_options(commonParam, param)), true);
            xhr.send();
        }
     },
     /**
      * 发送播放事件通用接口
      * @param  {string} value    值为{卡顿，错误}单独处理，其它点击事件
      * @param  {object} options  不传值为点击事件
      * @config {string} type     事件类型 {1 播放时长，2 加载时长}
      * @config {string} source   事件类型 默认PC
      */
     sendBaiduPlayEvent(value, options) {
         var opt = options || {},
             type = opt.type,
             source = opt.source || 'H5';

         let [arr, temp_arr, str] = [[],[], ''];

         switch(type) {
             // 播放时长
             case 1:
                this.sendArenaCloudEvent('playHeartbeat', {"body":{"duration": value}});
                 arr = ["{source}播放时长", "{source}_时长_播放" , "{source}_时长_播放_" + GM.room_id, "{value}"];
                 break;
             // 加载时长
             case 2:
                this.sendArenaCloudEvent('playCatonEnd', {"body":{"duration": value}});
                 arr = ["{source}加载时长", "{source}_时长_加载" , "{source}_时长_加载_" + GM.room_id, "{value}"];
                 break;
             default:
                 // 卡顿
                 if(value == '卡顿'){
                    this.sendArenaCloudEvent('playCatonStart', {"body":{}});
                     arr = ["{source}卡顿次数", "{source}_次数_卡顿" , "{source}_次数_卡顿_" + GM.room_id, 1];
                 // 错误
                 }else if(/错误/.test(value)){
                    this.sendArenaCloudEvent('playerror', {"body":{"failMessage":value}});
                     arr = ["{source}错误次数", "{source}_次数_" + value, "{source}_次数_错误_" + GM.room_id, 1];
                 }else{
                     arr = ["{source}{value}点击次数", "{source}_点击次数_{value}", "{source}_点击次数_{value}_" + GM.room_id, 1];
                 }

        }

         for(var i in arr) {
             str = arr[i];

             if(/\{source\}/.test(str)){
                 str = str.replace(/\{source\}/g, source);
             }

             if(/\{value\}/.test(str)){
                 str = str.replace(/\{value\}/g, value);
             }

             temp_arr.push(str);
         }

         this.sendBaiduEvent(temp_arr);
     },
     /**
      * 发送播放时长
      * @param {string} str dace的数据
      */
     sendDacePlayTime(str) {
         var streamurl = document.getElementsByTagName('source')[0].getAttribute('src');
         str = str || 0;
         var daceParams = {
                 "streamId": GM.room_id,           //流ID or 房间ID    （新模式huputTv自己填充）
                 "streamName": document.title,         //流名称 or房间名称   （新模式huputTv自己填充）
                 "platform": GM.platform,          //平台 ios/android/pc/h5
                 "time": Math.floor(new Date().getTime()/1000),      //秒时间戳
                 "isRegister": GM.islogin,      //秒时间戳
                 "streamUrl": streamurl,          //流URL
                 "token": this.getCookie('__dacevid3') || this.getCookie('_dacevid3'),             //用户唯一标识
                 "deviceNo": GM.client || this.getCookie('__dacevid3') || this.getCookie('_dacevid3'),             //用户唯一标识，使用dacevid
                 "match_id": GM.match_id,
                 "dur": str
         };
         this.send('huputv_play', JSON.stringify(daceParams));
     }
}
