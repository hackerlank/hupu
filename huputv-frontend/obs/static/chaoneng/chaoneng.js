/**
 * 超能的比分
 */
!function(){
  "use strict";

  var _ = require('common:static/js/underscore/underscore.js');

  var Games = {
    init: function() {
      var self = this;

      this.$wrap = $('#J_chaonengWrap');

      if(!this.$wrap.length){
        return;
      }

      this.$head = this.$wrap.find('.J_gameInfo');
      this.$skillList = this.$wrap.find('.J_skillList');
      this.$skillDetail = this.$wrap.find('.J_skillDetail');

      this.gameTpl = $('#chaoneng-game-tpl').html();
      this.skillListTpl = $('#skill-list-tpl').html();

      this.home_skill = [];
      this.guest_skill = [];
      this.home_team = '';
      this.guest_team = '';
      this.isHomeShow = false;
      this.isGuestShow = false;

      this.gameData();
      this.heart();
    },
    heart: function(){
      var self = this;

      this.timerHeart = setInterval(function() {
        self.gameData();
        
        if(self.home_skill.length && !self.isHomeShow){
          self.isHomeShow = true;
          self.showSkill(0);
        }

        if(self.guest_team.length && !self.isGuestShow){
          self.isGuestShow = true;
          self.showSkill(1);
        }
      }, 1000);
    },
    showSkill: function(index){
      var self = this,
        data = (index ? this.guest_skill : this.home_skill.reverse()),
        key = this.findIndex(data);

      if(key < 0){
        if(index){
          self.isGuestShow = false;
        }else{
          self.isHomeShow = false;
        }
        return;
      }

      var $list = this.$skillList.eq(index),
        $detail = this.$skillDetail.eq(index),
        width = 0;

      var fianlData = data[key],
        lists = {
        datas: data
      };

      fianlData.is_show = false;

      var list_tpl = _.template(this.skillListTpl)(lists),
        detail_tpl = this.home_team + ' 正在使用 <span class="name">['+ fianlData.skill_info.skill_name +']</span>';

      $list.html(list_tpl);
      $detail
        .html(detail_tpl)
        .show();

      width = $detail.innerWidth() + 10;
      
      $detail
        .css({
          width: 0
        })
        .animate({
            width: width
        }, 300, function(){
          self.endStage($detail, fianlData, index);
        });
    },
    /**
     * 技能退出
     * @return {[type]} [description]
     */
    endStage: function($elem, data, index) {
      var self = this;

      setTimeout(function() {
        $elem
          .animate({
              width: 0
          }, 300, function(){
            $elem
              .hide()
              .css({
                width: 'inherit'
              });
            data.is_show = true;

            if(index){
              self.isGuestShow = false;
            }else{
              self.isHomeShow = false;
            }
          });
      }, 1000);
    },
    gameData: function() {
      var self = this;

      var url = window.location.href;

      if(url.indexOf('is_api') !== -1){
        url = url.replace('is_api=0', 'is_api=1');
      }else{
        url += '&is_api=1';
      }

      $.ajax({
        url: url,
        type: "GET",
        data: {},
        dataType: 'json',
        success: function(data) {
          if(data.code === 1){
            var template = _.template(self.gameTpl)(data.data);

            self.$head.html(template);

            self.home_team = data.data.home_team_info.cn_name;
            self.guest_team = data.data.guest_team_info.cn_name;

            self.pushSkill(data.data.home_skill, 0);
            self.pushSkill(data.data.guest_skill, 1);
          }
        }
      });
    },
    pushSkill: function(data, keys) {
      var self = this,
        skill = (keys ? this.guest_skill : this.home_skill),
        pos = 0;

      if(data.length){
        if(skill.length){
          _.each(data, function(item, index) {
            pos = self.isRepeat(skill, item.skill_id);
            // 技能不存在push
            if(pos < 0){
              keys ? self.guest_skill.push(item) : self.home_skill.push(item)
            }
          });

          _.each(skill, function(item, index) {
            pos = self.isRepeat(data, item.skill_id);

            if(pos < 0){
              self.remove(index, keys);
            }
          });
        }else{
          if(keys){
            self.guest_skill = data
          }else{
            self.home_skill = data
          }
        }
      }

    },
    remove: function(pos, keys) {
      var arr = [];

      if(keys){
        arr = this.guest_skill[pos];
        this.guest_skill.splice(pos, pos + 1);
      }else{
        arr = this.home_skill[pos];
        this.home_skill.splice(pos, pos + 1);
      }

      $('.J_skillLi_' + arr.id).remove();
    },
    findIndex: function(data) {
      var index = -1;

      for(var i = 0, len = data.length; i < len; i++) {
          if(this.isUndefined(data[i].is_show)){
              index = i;
              break;
          }
      }

      return index;
    },
    /**
     * 是否重复
     * @return {Boolean} [description]
     */
    isRepeat: function(data, id) {
      var index = -1;

      for(var i = 0, len = data.length; i < len; i++) {
          if(data[i].skill_id === id){
              index = i;
              break;
          }
      }

      return index;
    },
    /**
     * 是否重复
     * @return {Boolean} [description]
     */
    isRepeats: function(data, id) {
      var index = -1;

      for(var i = 0, len = data.length; i < len; i++) {
          if(data[i].skill_id !== id){
              index = i;
              break;
          }
      }

      return index;
    },
    isUndefined: function(value) {
      return typeof value === 'undefined';
    }
  }

  $(function(){
    Games.init();
  })
}();