import * as app from './app'
//获取当前毫秒数
export function getTime(){
    return Date.now ? Date.now() : Date.valueOf()
}

//判断是否支持localStorage
export const isSupportLocalStorage = ('localStorage' in window)

//截取数组
export function arraySlice(arr, start = 0, end){
 return arr instanceof Array ? arr.slice(start, end) : arr
}

//收拢alert接口
export function toast(msg){
    //IOS上不弹出
    if(app.isAndroid){
        alert(msg);
    }
}

//dom操作相关
export const dom = {
    addClass( element, cls ){
          let classArray = cls.split(/\s+/),
              result = element.className,  //element old className
              i = 0,
              classMatch = " " + result + " ",  //used to check if has then decide if add
              _length = classArray.length;
           for(;i<_length;i++){
               if(classMatch.indexOf(" "+ classArray[i] +" ") <0){
                  //if classArray[i] is new add it
                  //and attention (result ? " ":"") if element old className is empty
                  result += (result ? " ":"") + classArray[i];
               }
           }
           element.className = result;

    },
    removeClass( element, cls ){
        let oldClasses = element.className.split(/\s+/),
            newClasses = cls.split(/\s+/),
            oldLen = oldClasses.length,
            delLen = newClasses.length,
            j = 0,
            i = 0;
        for(;i<delLen;i++){
           for(;j<oldLen;++j){
            if(oldClasses[j] == newClasses[i]){
               oldClasses.splice(j, 1);
               break;
             }
           }
        }
        //change array to string
        element.className = oldClasses.join(" ");
    }
}
