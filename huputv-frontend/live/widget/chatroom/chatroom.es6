    var _ = require('common:static/js/underscore/underscore.js');
    var io = require('common:widget/js/socket-1.4.5/socket.js');
    var Timeline = require('live:widget/timeline/timeline');
    var Gift = require('live:widget/send-gift/gift');
    var User = require("common:widget/login/login.js");
    var Flash = require('common:widget/flash-movie/flash');

    /**
     * 接口地址
     */
    var apiUrl = {
        // 获取socket ip
        getSocketIP: 'http://test.mobileapi.hupu.com/redirector',
        // 发送直播
        sendLive: '/live/sub'
    };

    var [isfullScreenStatus, hasPost] = [0, false];

    /**
     * 聊天室
     */
    var Chatroom = {
        init(callback) {
            var that = this;

            this.$wrap = $('#J_chatroom');

            if(!this.$wrap.length){
                return;
            }

            // 滚动条
            this.$scroll = this.$wrap.find('.J_chatroomScroll');
            // 内容
            this.$content = this.$wrap.find('.J_chatroomList');
            this.$textarea = this.$wrap.find('.J_formTextarea');
            // 发送按扭
            this.$buttonSend = this.$wrap.find('.J_buttonSend');
            // 还可以输入数
            this.$enterCount = this.$wrap.find('.J_canEnterCount');
            this.$error = this.$wrap.find('.J_chatError');
            // 点击登录
            this.$buttonLogin = $('#J_chatButtonLogin');
            // 屏蔽礼物
            this.$buttonShield = this.$wrap.find('.J_shieldCheckbox');

            this.$onlineCount = $('#J_onlineCount');

            this._listTpl = $('#hotline-tpl').html();
            this._chaonengListTpl = $("#chaoneng-hotline-tpl").html();

            this._totalCount = 60;
            this._sessionName = 'chatSendText';
            this.timer = null;
            this.isShieldGift = false;
            // 全部热线数
            this.allChatNumber = 0;

            // 浏览器默认选中，需要移除选中
            this.$buttonShield.removeAttr('checked');

            this.getNodeIP(function(ip) {
                that.socket(ip);
            });

            this.bind();

            // 礼物特效初始化
            this.timeline = new Timeline();
            this.timeline.start();

        },
        bind() {
            var that = this,
                timer = null;

            // 发送
            this.$buttonSend.on('click', function() {
                that.sendLive();
            });

            this.$textarea.on('keyup', function(event){
                var content = that.$textarea.val();

                that.hideError();

                // 防止用户输入空格
                that.calculatedTextarea(content);
            });

            this.$textarea.on('keydown', function(event){
                var content = $.trim(that.$textarea.val());

                if( event.keyCode == 13  ) {
                    that.sendLive(content);
                    event.preventDefault();
                }
            });

            this.$buttonShield.on('click', function() {
                that.isShieldGift = $(this).is(":checked");
            });

            this.$buttonLogin.on('click', function() {
                User.login();
                return false;
            });

            /**
             * 网页全屏
             */
            Flash.register('emitChat', function(str) {
              that.emit(str);
            });
        },
        /**
         * 获取ip
         */
        getNodeIP(callback) {

            function RandomVal(arr){
                var len = arr.length,
                    count = Math.floor(Math.random() * len);

                return arr[count];
            }

            callback && callback(RandomVal(HTV.socketIP));

        },
        socket(ip) {
            var that = this;

            var chatroom = io.connect(ip);

            chatroom.on('connect', () => {
                chatroom.emit('join', {
                    et: 1000,
                    token: HTV.token,
                    via: 5,
                    room_id: HTV.roomID,
                    match_id: HTV.matchID
                });
            });

            chatroom.on('wall', data => {
                this.wall(data);
            });

            // 重连
            // chatroom.on('error', function (data) {
            // });
        },
        wall(data){

            if(_.isUndefined(data.et)) return;

            $(document).trigger('wall', [data]);

            switch(data.et) {
              // 在线人数
              case 1010:
                this.$onlineCount.html(data.n);
                break;
              // 参与预测
              case 2002:
                this.renderChat(data, 'pred');
                break;
              // 礼物
              case 2001:
                let detail = Gift.getGiftDetail(data.giftid, data.lt);

                this.renderChat(data, 'gift');

                // 送礼物是虎扑币
                if(+detail.money_type == 6 && !this.isShieldGift) {
                  data.giftDetail = detail;
                  this.timeline.create({data: data});
                }
                break;
              // 主播发言
              case 3001:
              case 1011:
                  data.avater_url = HTV.zhiboAvatarUrl;
                  data.username = HTV.getUserName;
                  data.rp = HTV.rpzNumber;

                  this.timeline.create({
                      data: data,
                      type: data.et
                  });
                  break;
            }

            // et 热线2000 || 主播发言3001
            if(data.et === 2000 || data.et === 3001 ) {
              this.renderChat(data);
            }

            // et 技能使用3011 技能购买3012
            if(data.et === 3011 || data.et === 3012) {
              this.renderChaoneng(data);
            }
        },
        /**
         * 渲染
         */
        renderChat(data, conName) {
            let result = {
                    username: HTV.getUserName,
                    item: data,
                    conName: conName
                },
                template = '';

            if(data.et === 2001 && this.isShieldGift){
                return;
            }

            template = $.trim(_.template(this._listTpl)(result));

            // 热线列表最多100数
            if(this.allChatNumber >= 100) {
              this.$content.find('li:first').remove();
            }else{
              this.allChatNumber++;
            }

            // trim 超过100条删除，存在空白
            this.$content.append(template);
            this.scrollBottom();
        },
        /**
         * 渲染超能
         */
        renderChaoneng(data) {
            var that = this;

            //是否主队
            var isHomeTeam = function(teamId) {
                return teamId == HTV.chaoneng.home_team;
            }

            data.teamname = isHomeTeam(data.team_id) ? HTV.chaoneng.home_team_info.cn_name : HTV.chaoneng.guest_team_info.cn_name;

            var result = {
                username: HTV.getUserName,
                item: data
            };

            let template = _.template( this._chaonengListTpl )(result);

            this.$content.append(template);
            this.scrollBottom();

        },
        /**
         * 定位到底部
         */
        scrollBottom() {
            var height = this.$content.height();

            this.$scroll.scrollTop(height);
        },
        sendLive(content) {
            var that = this;

            var content = content || $.trim(that.$textarea.val());

            if(hasPost){
                return;
            }

            that.emit(content);
        },
        /**
         * 发送
         */
        emit(content) {
            var that = this;

            if(!HTV.isLogin){
                User.login();
                return;
            }

            if(content == ''){
                Chatroom.showError('不能为空');
                return;
            }

            Chatroom.hideError();
            hasPost = true;

            var sendData = {
                room_id: HTV.roomID,
                match_id: HTV.matchID,
                content: $.trim(content)
            };

            Chatroom.calculatedTextarea('');

            // flash 调用
            $('.J_formTextarea').val('');

            $.ajax({
                url: apiUrl.sendLive,
                type: "POST",
                data: sendData,
                dataType: 'json',
                success: function(data) {

                    // 发言频率限制
                    if(data.code === 201 || data.code === -15){
                        Chatroom.$buttonSend.addClass('button-has-send');

                        Chatroom.countdown(Chatroom.$buttonSend, data.msg, function() {
                            Chatroom.$buttonSend.removeClass('button-has-send');
                            hasPost = false;
                        });
                        return;
                    }

                    hasPost = false;

                    if(data.code === 1) {
                        return;
                    }

                    Chatroom.showError(data.msg);
                }
            });
        },
        /**
         * 计算输入框文字
         */
        calculatedTextarea(content) {
            var that = this;

            var len = content.length;

            this.$enterCount.html( len );

        },
        /**
         * 倒计时
         * @param elem
         * @param total
         * @param callback
         */
        countdown(elem, total, callback = function() {}) {
            var [that, count, activeCount, timer, buttonText] = [this, 0, 0, null];

            buttonText = elem.text();

            timer = setInterval(() => {
                count = parseInt(total, 10) - activeCount;

                if(count <= 0){
                    clearInterval(timer);
                    elem.html(buttonText);
                    callback();
                    return;
                }

                elem.html(count + 'S');

                activeCount ++;
            }, 1000)
        },
        /**
         * 错误提示
         */
        showError(val) {
            this.$error
                .show()
                .html(val);

            clearTimeout(this.timer);

            this.timer = setTimeout(() => {
                this.hideError();
            }, 800)
        },
        hideError() {
            this.$error.hide();
        }
    };

    module.exports = Chatroom;
