var Store = require("app:widget/ui-store/ui-store.js");
var common = require("app:widget/ui-common/ui-common.js");

var Update = {
    init: function(){
        this.render();
        this.bind();
    },

    render: function(){
        this.wrap = $("#J-wrap");
        this.tip = $("#J-tip");
        this.close = $("#J-close");

        this.isTip = new Store("update_show");

       if(!this.isTip.get() && GM.isInApp){
            this.wrap.css("display", "table-cell");
       }
    },

    bind: function(){
        var self = this;

        self.close.on("click", function(){
            self.wrap.hide();
        });

        self.tip.on("click", function(){
            var radio = $(this).find(".icon");
            if(radio.hasClass("icon-checked")){
                radio.removeClass("icon-checked").addClass("icon-unchecked");
                self.isTip.set("0");
            }else{
                radio.removeClass("icon-unchecked").addClass("icon-checked");
                self.isTip.set("1");
            }
        });
    }

};

module.exports = Update;
