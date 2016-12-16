/**
 * @file 对话框
 * @author wangjun@hupu.com
 * @date 2015-11-25
 **/
"use strict";
var Instance;

var defaults = {
  title: '',
  content: '',
  gray: '',
  canel: {
    text: '取消',
    callback: function() {}
  },
  confirm: {
    text: '确认',
    callback: function() {}
  }
}

function Popup(options) {
    this.init(options);
}

Popup.prototype = {
    init: function(options) {
        var that = this;

        this.opts = $.extend(true, {}, defaults, options || {});

        this.render();
    },
    render: function() {
        var that = this;

        var titleTpl = this.opts.title ? '<div class="hp-popup-title">'+ this.opts.title +'</div>' : '';

        var tpl = [
            '<div class="hp-dialog" id="J_hpDialog">',
                '<div class="hp-popup-wrap">',
                    titleTpl,
                    '<div class="hp-popup-content">',
                        this.opts.content+
                        '<p class="gray">'+this.opts.gray+'</p>'+
                    '</div>',
                    '<div class="button-inner">',
                        '<a href="javascript:" class="button button-cancel J_buttonCanel">' + this.opts.canel.text +'</a>',
                        '<a href="javascript:" class="button button-confirm J_buttonSubmit">' + this.opts.confirm.text + '</a>',
                    '</div>',
                '</div>',
            '</div>'
        ].join('');

        $.colorbox({
            width: '450',
            initialWidth: '450',
            initialHeight: '145',
            className: 'hp-dialog-wrap',
            opacity: 0.7,
            html: tpl
        });

        this.$popup = $('#J_hpDialog');

        this.bind();
    },
    bind: function() {
        var that = this;

        this.$popup.find('.J_buttonCanel').on('click', function(){
            $.colorbox.close();
            // that.opts.canel.callback && that.opts.canelCallback();
        });

        this.$popup.find('.J_buttonSubmit').on('click', function(){
            $.colorbox.close();
            that.opts.confirm.callback && that.opts.confirm.callback();
        });
    }
}

module.exports = function(options){
    if(Instance){
        return Instance.init(options);
    } else{
        return Instance = new Popup(options);
    }
};
