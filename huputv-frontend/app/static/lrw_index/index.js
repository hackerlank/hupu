/**
 * 路人王
 */
!function(){
  "use strict";

  var refresh = require("app:widget/ui-refresh/ui-refresh.js");
  var _ = require("app:static/js/underscore/underscore.js");

  var Lrw = {
    init: function() {
      var self = this;

      this.$wrap = $('#J_lrwWrap');

      if(!this.$wrap.length){
        return;
      }

      this.$tab = $('#J_innerTab');
      this.$tabList = this.$tab.find('li');
      this.$content = $('#J_lrwContent');

      this._titleTpl = $('#J_lrwTitleTpl').html();
      // 基本列表
      this._listTpl = $('#J_lrwListTpl').html();
      // 8强赛
      this._top8ListTpl = $('#J_lrwTop8Tpl').html();

      // 比赛状态
      this.match_status = M_LRW.game_info.match_status;

      var number = 2;

      if(this.match_status <= 2 || !M_LRW.game_info) {
        number = 0;
      }else if(this.match_status > 2 && this.match_status <= 4){
        number = 1;
      }

      this.switchTab(this.$tabList.eq(number));

      this.bind();
    },
    bind: function() {
      var self = this;

      this.$tabList.on('click', function() {
        self.switchTab($(this));
      })

      // refresh({
      //     contentEl: '#J-zhubo-list',
      //     isRefresh: true,
      //     isLoadingMore: false,
      //     refreshCallback: function(complete) {
      //          setTimeout(function() {
      //              complete();
      //              location.reload();
      //          }, 1000);
      //     }
      // });
    },
    switchTab: function(elem) {
      var self = this,
        index = elem.index();

      this.$tabList.removeClass('active');
      this.$tabList
        .eq(index)
        .addClass('active');

      this.getUserInfo(function() {
        switch (index) {
          case 1:
            self.top8();
            break;
          case 2:
            self.rank();
            break;
          default:
            self.wheel();
        }
      });

    },
    getUserInfo: function(callback) {
      var self = this;
      var url = window.location.pathname + '?json=1';

      $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function(data){
          self.match_status = data.game_info.match_status;
          callback();
        }
      });
    },
    /**
     * 车轮战
     * @return {[type]} [description]
     */
    wheel: function() {
      var self = this,
        template = '',
        isShowRank = (self.match_status > 1),
        url = isShowRank ? M_LRW.wheel_rank_url : M_LRW.wheel_match_url;

      this.getData(url, function(data) {


        if(self.match_status == 2){
          template = _.template( self._titleTpl )({
            title: '车轮战战绩表'
          });
          var wheelData = self.getWheelData(data.rank_list);

          template += _.template( self._listTpl )({
            datas: wheelData,
            type: 'top'
          });
        }else if(self.match_status > 2) {
          var wheelData = data.rank_list;

          template = _.template( self._titleTpl )({
            title: '已晋级球员'
          });

          template += _.template( self._listTpl )({
            datas: wheelData.top8,
            type: 'top'
          });

          if(wheelData.out.length) {
            template += _.template( self._titleTpl )({
              title: '已OUT球员'
            });

            template += _.template( self._listTpl )({
              datas: wheelData.out,
              type: 'top'
            });
          }
        }else {
          if(!data.ready.length && !data.out.length) {
            template = '<div class="not-content-match">车轮战尚未开始</div>';
          }else{
            template = _.template( self._titleTpl )({
              title: '进行中比赛'
            });

            data.playing.status = 4;

            template += _.template( self._top8ListTpl )({
              datas: [data.playing],
              subBtyesString: self.subBtyesString,
              matchText: self.matchText(),
              isTitle: true
            });

            if(data.ready.length){
              template += _.template( self._titleTpl )({
                title: '待比赛球员'
              });

              template += _.template( self._listTpl )({
                datas: data.ready
              });
            }

            if(data.out.length){
              template += _.template( self._titleTpl )({
                title: '已OUT球员'
              });

              template += _.template( self._listTpl )({
                datas: data.out
              });
            }
          }
        }

        self.$content.html(template);
      }, function(data) {
        template = '<div class="not-content-match">车轮战尚未开始</div>';
        self.$content.html(template);
      })
    },
    /**
     * 8强赛
     * @return {[type]} [description]
     */
    top8: function() {
      var self = this,
        template = '',
        isShowRank = (self.match_status <= 4),
        url = isShowRank ? M_LRW.top8_match_url : M_LRW.top8_rank_url;


      // 8强未开始
      if(self.match_status <= 2) {
        template = '<div class="not-content-match">8强赛尚未开始</div>';
        self.$content.html(template);
      }else{
        this.getData(url, function(data) {
          if(self.match_status <= 4) {
            template = _.template( self._titleTpl )({
              title: '进行中比赛'
            });

            data.playing.status = 4;

            template += _.template( self._top8ListTpl )({
              datas: [data.playing],
              subBtyesString: self.subBtyesString,
              matchText: self.matchText()
            });

            if(data.match_list.ready.length) {
              template += _.template( self._titleTpl )({
                title: '待比赛场次'
              });

              template += self.getTop8Tpl(data.match_list.ready);
            }

            if(data.match_list.end.length) {
              template += _.template( self._titleTpl )({
                title: '已结束比赛'
              });

              template += _.template( self._top8ListTpl )({
                datas: data.match_list.end,
                subBtyesString: self.subBtyesString,
                matchText: self.matchText()
              });
            }
          }else{
            template = self.getTop8Tpl(data.rank_list, true);
          }

          self.$content.html(template);
        })
      }
    },
    /**
     * 排行榜
     * @return {[type]} [description]
     */
    rank: function() {
      var self = this,
        template = '',
        url = M_LRW.rank_url;

      if(this.match_status <= 4) {
        template = '<div class="not-content-match">比赛未结束，战绩表尚未出来</div>';
        self.$content.html(template);
      }else{
        this.getData(url, function(data) {
          var result = {
            datas: data.rank_list,
            type: 'top'
          };


          template = _.template( self._titleTpl )({
            title: '本轮比赛战绩表',
            position: 'center'
          });

          template += _.template( self._listTpl )(result);

          self.$content.html(template);
        })
      }
    },
    /**
     * 获取数据
     * @param  {[type]}   url      [description]
     * @param  {Function} callback [description]
     * @return {[type]}            [description]
     */
    getData: function(url, callback, errorCallback) {

      $.ajax({
        url: url,
        type: "GET",
        dataType: "json",
        success: function(data){
          if(data.code == 1){
            callback && callback(data.data);
          }else{
            errorCallback && errorCallback(data.data);
          }
        }
      });
    },
    /**
     * 处理车轮战数据
     * @param  {[type]} data [description]
     * @return {[type]}      [description]
     */
    getWheelData: function(data) {
      //
      // if(!data.length) {
      //   return [];
      // }

      var params = [];
      var top = data.top8;
      var out = data.out;
      top.map(function(item,index){
        params.push(item);
      })

      out.map(function(item,index){
        params.push(item);
      })
      /*data.map(function(item, index) {
        if(item.status == 2){
          params.out.push(item)
        }else{
          params.ready.push(item)
        }
      })*/

      return params;
    },
    /**
     * 处理8强赛
     * @return {[type]} [description]
     */
    getTop8Tpl: function(data, endShow) {
      var self = this;

      if(!data.length) {
        return '';
      }

      var params = {
        finals: [],
        halfMatch: [],
        other: []
      }

      data.map(function(item, index) {
        if(+item.right_puid || +item.left_puid) {
          // 决赛
          if(item.num == 14){
            params.finals.push(item);
          // 半决赛
          }else if(item.num >= 11 && item.num < 14){
            params.halfMatch.push(item);
          }else{
            params.other.push(item);
          }
        }
      });

      var template = '';

      // 比赛结束
      if(endShow) {
        // 决赛
        if(params.finals.length){
          template += _.template( self._titleTpl )({
            title: '决赛',
            position: 'center'
          });

          template += _.template( self._top8ListTpl )({
            datas: params.finals,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }

        // 半决赛
        if(params.halfMatch.length){
          template += _.template( self._titleTpl )({
            title: '半决赛',
            position: 'center'
          });

          template += _.template( self._top8ListTpl )({
            datas: params.halfMatch,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }

        if(params.other.length) {
          template += _.template( self._titleTpl )({
            title: '8强赛',
            position: 'center'
          });

          template += _.template( self._top8ListTpl )({
            datas: params.other,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }
      }else{
        if(params.other.length) {
          template += _.template( self._top8ListTpl )({
            datas: params.other,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }

        // 半决赛
        if(params.halfMatch.length){
          template += _.template( self._titleTpl )({
            title: '半决赛',
            position: 'center'
          });

          template += _.template( self._top8ListTpl )({
            datas: params.halfMatch,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }

        // 决赛
        if(params.finals.length){
          template += _.template( self._titleTpl )({
            title: '决赛',
            position: 'center'
          });

          template += _.template( self._top8ListTpl )({
            datas: params.finals,
            subBtyesString: self.subBtyesString,
            matchText: self.matchText()
          });
        }
      }

      return template;
    },
    matchText: function() {
      return {
        5: {
          left: '第1场败者',
          right: '第2场败者'
        },
        6: {
          left: '第3场败者',
          right: '第4场败者'
        },
        7: {
          left: '第1场赢家',
          right: '第2场赢家'
        },
        8: {
          left: '第3场赢家',
          right: '第4场赢家'
        },
        9: {
          left: '第7场败者',
          right: '第6场赢家'
        },
        10: {
          left: '第8场败者',
          right: '第5场赢家'
        },
        11: {
          left: '第7场赢家',
          right: '第8场赢家'
        },
        12: {
          left: '第9场赢家',
          right: '第10场赢家'
        },
        13: {
          left: '第11场败者',
          right: '第12场赢家'
        },
        14: {
          left: '第11场赢家 ',
          right: '第13场赢家'
        }
      }
    },
    /**
     * 截取
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

  $(function(){
      Lrw.init();
  })
}();
