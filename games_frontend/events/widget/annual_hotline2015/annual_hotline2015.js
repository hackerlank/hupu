var host = '61.174.11.223';
var _ = require("underscore");

function formatNum(count){
  return count < 10 ? "0" + count : count;
}

var hotline = {
  init: function(){
    this.pageOutContainer = $("#J-bd-container");
    this.pageContainer = $("#J-pager-hotline");
    this.container = $("#J-hotline-container");
    this.giftContainer = $("#J-gift-container");

    this.tpl = $("#J-hotline-tpl").html();
    this.giftTpl = $("#J-gift-guess-tpl").html();

    this.msgs = [];

    var winHeight = $(window).height();
    this.pageOutContainer.css({
        "height": winHeight
    });
    this.pageContainer.css({
        "min-height": winHeight
    });

    this.getHotline();
    
    this.showMsg();
  },
  showMsg: function(){
     var now = new Date();
     var self = this;
     var msg = this.getData();
     if(msg){
       msg.date = [formatNum(now.getHours()), formatNum(now.getMinutes()), formatNum(now.getSeconds())].join(":");
       msg.msg_type = !!msg.gift ? 2 : 1;
       this.append(msg);
     }
     var speed = this.getSpeed();
     setTimeout(function(){
       self.showMsg();
     }, speed);
  },
  getSpeed: function(){
    var speed = 1000;
    var msgLength = this.msgs.length;
    
    if(msgLength > 50){
       return speed / 8;
    }else if(msgLength > 30){
       return speed / 4;
    }else if(msgLength > 20){
       return speed / 2;
    } else if(msgLength > 10){
       return speed;
    } else if(msgLength > 5){
       return speed * 2;
    } else if(msgLength > 2){
       return speed * 4;
    }
  },
  getHotline: function(){
    var hotline = 'http://' + host + ':3080/nba_v1?client=xxxxx&token=xxxxx&background=false&type=5';
    var conn = io.connect(hotline);
    var self = this;
    conn.on('connect', function() {
      conn.emit('join', {
        room: GM.hroom,
        type: GM.htype,
        gid: GM.hgid,
        roomid: GM.hroomid
      });
    });
    conn.on('wall', function(data) {
       if(data.result && data.result.data){
          var msgs = data.result.data || [];
          self.pushData(msgs);
        }
        if(data.result && data.result.gift_update){
          self.render(data.result.gift_update);
        }
    });
  },
  append: function(data){
    var html = _.template(this.tpl, data);
    var winHeight = $(window).height();
    var contentHeight = this.container.height();
    this.container.append(html);

    if(contentHeight > 3000){
      this.container.find("li").eq(0).remove();
      contentHeight = this.container.height();
    }
    
    if(contentHeight > winHeight){
      this.container.css(
          "margin-top", (-(contentHeight - winHeight) +"px")
      );
    }
  },
  render: function(giftData){
    var html = _.template(this.giftTpl, {
        top: giftData[0],
        bottom: giftData[1]
    });
    this.giftContainer.html(html);
  },
  pushData: function(msgs){
     this.msgs = this.msgs.concat(msgs);
  },
  getData: function(){
     var shiftMsg = this.msgs.pop() || null;
     return shiftMsg;
  }
}

module.exports = hotline;