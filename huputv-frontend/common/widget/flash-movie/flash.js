
var abbrName = 'HPF';

// 创建Flash对外名字
var createName = window[abbrName] || {};
// flash接口ID
var flashApiId = 'live-video_Flash_api';

// 生成唯一ID
var uniqueName = function() {
	return 'callback_' + (+new Date)
}

/**
 * flashMovie 交互
 * @param {[type]} name [flash交互名字]
 */
var flashMovie = function() {
	var isIE = navigator.appName.indexOf("Microsoft") != -1;
	return (isIE) ? window[flashApiId] : document[flashApiId];
}

/**
 * 注册事件
 * @param  {[string]}   type             [事件名]
 * @param  {[object]}   data             [数据]
 * @param  {[function]} callback         [成功回调]
 * @return {[type]}                      [description]
 */
var register = function(type, data, callback) {
	if (typeof type === "string") {
		createName[type] = data;
		return 0;
	}

	return 1;
}

/**
 * 注销方法事件
 * @param  {[string]}   type             [事件名]
 * @return {[type]}                      [description]
 */
var unregister = function(type) {
	if (typeof type === "string") {
		delete createName[type];
	}
}

/**
 * 是否安装flash
 * @return {[boolean]} [description]
 */
var hayFlash = function() {
	var flash;

	try{
		flash = new ActiveXObject('ShockwaveFlash.ShockwaveFlash')
	}catch(e){
		flash = navigator.plugins['Shockwave Flash']
	}
	return flash
}

/**
* 调试日志
*/
var debug = function(content) {
 if(/debug/i.test(location.search)){
		 console.log(content);
 }
}

/**
 * 发送事件,默认调用出错
 * @param  {[string]}   type             [事件名]
 * @param  {[object]}   data             [数据]
 * @param  {[function]} callback         [回调]
 * @return {[type]}                      [description]
 * @example
 * Flash.send('gift', {}, function(data){})
 */
var send = function(type, data, callback) {
	var callbackName = '';

	// 数据是字符串，转换对象
	if (typeof data === "string") {
		data = {
			msg: data
		}
	}

	if (typeof callback === "function") {
		callbackName = uniqueName();
		createName[callbackName] = function(params) {
			unregister(callbackName);
			return callback && callback(params);
		};
	}

	try {
		flashMovie().jsCallAs(type, data, callbackName);
	} catch(err) {}
}

module.exports = {
	version: '1.0.0',
	onLists: createName,
	hayFlash: hayFlash,
	send: send,
	register: register,
	unregister: unregister,
	debug: debug
};
