var User = require("common:widget/login/login.js");
var Toast = require("common:widget/toast/toast.js");
var Dialog = require('common:widget/dialog/dialog');
var _ = require('common:static/js/underscore/underscore.js');


/**
 * 接口地址
 */
var apiUrl = {
    // 送礼物
    predict: '/predict/join'
};

/**
 * 送礼物
 */
var PredGame = {
    init() {
        var self = this;

        this.$wrap = $('#J_predGame');

        if(!this.$wrap.length){
            return;
        }

        this.$pred = this.$wrap.find('.pred-game');

        this.topicId = this.$pred.data('id');
        this.score = this.$pred.data('score');
        this.rate = HTV.predData.magnification;

        this.bind();
    },
    bind() {
        var self = this;

        //DOM会被重新替换，所以事件委托.
        this.$wrap.delegate('.J_buttonPred', 'click', (e) => {
            if(!HTV.isLogin){
                User.login();
            }else{
                this.index = $.inArray(e.currentTarget, this.$wrap.find('.J_buttonPred'));
                this.option = $('.team-name').eq(this.index).text();
                this.pred();
            }


        })
    },
    pred() {
        var self = this;

        Dialog({
            content: '<div class="popup-pred-game"><div class="title">确认选择<b>'+self.option+'</b></div><div class="content">该题人品值基准分为'+self.score+'分，您的当前赢率为'+self.rate+'，<br />确认后将无法修改答案  </div></div>',
            confirm: {
                text: '确认',
                callback: function() {
                    $.post(apiUrl.predict,{
                        topic_id: self.topicId,
                        option: self.index+1
                    },function(data) {

                        if(data.code == 1){
                            var data = $.extend(true, {}, data.data, {user_option: self.index+1})
                            self.updatePred(data);

                            return;
                        }

                        Toast.toast(data.msg);

                    },'json')
                }
            }
        });
    },
    // 重新加载
    reloadPred(data) {
        //没有比赛预测
        if(!HTV.predData) return;

        data.status = 0;
        data.user_option = 0;
        data.total_score_1 = 0;
        data.total_score_2 = 0;
        data.total_score_1_percente = 50;
        data.total_score_2_percente = 50;
        data.id = data.toid;
        
        this.topicId = data.toid;
        this.score = data.score;

        this.updatePred(data);
    },
    updatePred(data) {
        //没有比赛预测
        if(!HTV.predData) return;
        // 仅在比分变化时才去计算修改
        if('total_score_1' in data || 'total_score_2' in data || 'status' in data || 'option1' in data) {
            HTV.predData = $.extend(true, HTV.predData, data);
            if(HTV.predData.total_score_1 == "0" && HTV.predData.total_score_2 == "0"){
              HTV.predData.total_score_1_percente = 50;
              HTV.predData.total_score_2_percente = 50;
            } else{
              HTV.predData.total_score_1_percente = (parseInt( HTV.predData.total_score_1) / (parseInt(HTV.predData.total_score_1) + parseInt(HTV.predData.total_score_2))) * 100;
              HTV.predData.total_score_2_percente = 100 - HTV.predData.total_score_1_percente;
            }
        }

        var predTpl = _.template( $("#pred-tpl").html(), {data: HTV.predData} );
        this.$wrap.html( predTpl );
    }
};

module.exports = PredGame;
