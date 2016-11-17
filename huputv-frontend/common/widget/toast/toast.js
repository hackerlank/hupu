/**
 * @file 提示层
 * @author wangjun@hupu.com
 * @date 2016-04-27
 **/
"use strict";

var timer = null;

var Toast = {
    toast: function(msg, wrap) {
        if(!msg || !msg.length) return;

        var $toast = $('#J_uiToast');

        if(!$toast.length){
            var  str = '<div class="ui-toast" id="J_uiToast"></div>';
            var $wrap = wrap == undefined ? $('body') : $(wrap);
            $wrap.append(str);
            $toast = $('#J_uiToast');
        }

        clearTimeout(timer);

        $toast
            .removeClass('ui-toast-hide')
            .html( msg )
            .show();

        // 获取位标
        function getPosition(elem) {
            var win = $(window),
                getViewWidth = win.width(),
                getViewHeight = win.height(),
                getSrollTop = win.scrollTop(),
                getSrollLeft = win.scrollLeft(),
                width = elem.outerWidth(true) || 100,
                top = getSrollTop + getViewHeight / 3,
                left = getSrollLeft + (getViewWidth - width) / 2;


            return {
                top : top,
                left : left,
                width : width
            }
        }

        var getPos = getPosition($toast);

        if(!wrap){
            $toast
                .css({
                    top : getPos.top,
                    left : getPos.left
                });    
        }else{
            $toast
                .css({
                    top : '45%',
                    left : '50%',
                    marginLeft: -getPos.width/2
                });  
        }
        

        timer = setTimeout(function(){
            clearTimeout(timer);
            $toast
                .addClass('ui-toast-hide')
                .hide();
        }, 1130);

    }
}

module.exports = Toast;
