/**
 * @file 封装工具库
 * @author wangjun@hupu.com
 **/

var Util = {
  /**
   * 截取字节
   * @param  {string} text    [文字]
   * @param  {number} length  [截取长度]
   * @param  {string} endText [截取尾增加内容（...）]
   * @return {string}         [截取完内容]
   */
  subString: function(text, length, endText) {
    if(!text) {
      return ''
    }

    var len = length || 12;
    var number = text.length;
    var str = text;

    if(number > len){
      str = text.substr(0, len);
      str += endText;
    }

    return str;
  },
  /**
   * 截取字节
   * @return {[type]} [description]
   * bug null 报错
   */
  subBtyesString: function(text, length, endText) {
    if(!text) {
      return ''
    }

    var str = text;
    var len = length || 12;
    var endText = endText || '...'

    var number = 0;
    var textlen = text.length;
    var strEnd = 0;
    var char;

    for(var i = 0; i < textlen; i++) {
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
  }
}

module.exports = Util
