
let Util = {
  /**
   * 获取比赛ID
   * @return {number} [比赛ID| 默认id 4]
   */
  getGameId() {
    let id = 44;
    let reg = /\d+$/;
    let pathname = window.location.pathname;

    if(reg.test(pathname)) {
      id = pathname.match(reg)[0];
    }

    return id
  },
  /**
   * 获取页面名
   * @return {string} [页面名]
   */
  getPageName() {
    let name = 'admin';
    let pathname = window.location.pathname;

    // 线上域名/m/, 本地h5.html
    if(/\/m\//.test(pathname) || /h5\.html$/.test(pathname)) {
      name = 'h5';
    }
    
    return name;
  },
  /**
   * 截取中文
   * @return {string}  text [文字]
   * @return {number}  len  [截取文字长度，默认12中文是字]
   * bug null 报错
   */
  subBtyesString(text, len = 12, endText = '...') {
    if(!text) {
      return ''
    }

    let str = text;

    let number = 0;
    let textlen = text.length;
    let strEnd = 0;
    let char;

    for(let i = 0; i < textlen; i++) {
      char = text.charAt(i);

      if(/[\x00-\xff]/.test(char)) {
        number++;
      }else{
        number += 2;
      }

      if (number <= len) {
        strEnd = i + 1;
      }
    }

    if(number > len){
      str = text.substr(0, strEnd);
      str += endText;
    }

    return str;
  },
  /**
   * 转换百分比
   * @param  {Number} number [description]
   * @param  {Number} total  [description]
   * @return {[type]}        [description]
   */
  changePct(number = 0, total = 0) {
    let rate = (number / total * 100) || 0;

    return Math.round(rate)  + '%';
  }
}

export default Util;
