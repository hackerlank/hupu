$(function() {
    var _ = require('common:static/js/underscore/underscore.js');

    var pagination = {
        init: function() {
            this.coinTab = $('#J_coinTab');
            this.beanTab = $('#J_beanTab');
            this.coinPrev = $('#J_coinPrev');
            this.coinNext = $('#J_coinNext');
            this.beanPrev = $('#J_beanPrev');
            this.beanNext = $('#J_beanNext');
            this.coinSelect = $('#J_coinSelect');
            this.beanSelect = $('#J_beanSelect');

            this.status();
            this.initialAjax();
            this.bind();
        },

        status: function() {
            this.coinArr = [{offset:0,timeArea:'c'}];
            this.beanArr = [{offset:0,timeArea:'c'}];

            this.coinCount = 0;
            this.beanCount = 0;

            this.coinType = 6;
            this.beanType = 1;

            this.limit = 20;
        },

        initialAjax: function() {
            var self = this;

            var intialCB = function(reqData, resData, result) {
                var $wrap = reqData.moneyType == 6 ? $('#J_coinWrap') : $('#J_beanWrap'),
                    $table = reqData.moneyType == 6 ? $('#J_coinTable') : $('#J_beanTable'),
                    btnNext = reqData.moneyType == 6 ? self.coinNext : self.beanNext,
                    arr = reqData.moneyType == 6 ? self.coinArr : self.beanArr;
                                
                if(result.length == 0) {
                    $wrap.html('<p class="empty-tips">暂无交易记录</p>');
                }else{
                    if(result.length > 0) {
                        $table.html( _.template( $("#recordTpl").html())({datas: result}) );
                    }

                    if(result.length < self.limit){
                        btnNext.addClass('disabled');
                        return;
                    }

                    var tempObj = {};
                    tempObj.offset = resData.data.offset;
                    tempObj.timeArea = resData.data.timeArea;
                    arr[arr.length] = tempObj;
                    // reqData.moneyType == 6 ? self.coinCount++ : self.beanCount++;
                        
                    $wrap.find('.table-footer').show();
                }

            };
                

            this.ajaxFn(this.concatData(this.coinType), intialCB);
            this.ajaxFn(this.concatData(this.beanType), intialCB);
        },

        concatData: function(moneyType) {
            var arr = moneyType == 6 ? this.coinArr : this.beanArr;
            var count = moneyType == 6 ? this.coinCount : this.beanCount;
            return $.extend(
                arr[count],
                {moneyType: moneyType, limit: this.limit}
            )
        },

        handleDate: function(timestr) {
            var date = new Date(timestr);
            Y = date.getFullYear() + '-';
            M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
            D = date.getDate() + '  ';
            h = date.getHours() + ':';
            m = (date.getMinutes()<10?'0':'') + date.getMinutes();
            return Y+M+D+h+m;
        },
        ajaxFn: function(reqData, callback) {

            var reqData = reqData;
            var type = reqData.moneyType == 6 ? '虎扑币' : '金豆';
            var self = this;

            $.ajax({  
                type: "GET",  
                // url: HTV.base_url + "/wallet/pay-history", 
                url:  "/wallet/pay-history", 
                data: reqData,
                dataType: "json",
                success:function(resData){
                    if(resData.code == 1){
                        var result = resData.data.list;

                        for(var i = 0; i < result.length; i++) {

                            result[i].timestr = self.handleDate(result[i].createDatetime);
                            
                            if(result[i].direction == 1){
                                result[i].record = '+'+result[i].amount+ type;
                            }else{
                                result[i].record = '-'+result[i].amount+ type;
                            }
                        }

                        callback && callback(reqData, resData, result);

                        $('.table-con table tr:odd').addClass('odd');

                    }else{
                        if(reqData.moneyType == 6) {
                            $('#J_coinWrap').html('<p class="empty-tips">暂无交易记录</p>');
                        }else{
                            $('#J_beanWrap').html('<p class="empty-tips">暂无交易记录</p>');
                        }
                    }

                },
                error: function() {
                    if(reqData.moneyType == 6) {
                        $('#J_coinWrap').html('<p class="empty-tips">暂无交易记录</p>');
                    }else{
                        $('#J_beanWrap').html('<p class="empty-tips">暂无交易记录</p>');
                    }
                }
            });
        },

        bind: function() {
            var self = this;

            $('.tab').on('click', function() {
                var index = $('.tab').index(this);
                $('.tab').removeClass('active').eq(index).addClass('active');
                $('.table-con').hide().eq(index).show();
            });


            var nextCB = function(reqData, resData, result) {
                var $table = reqData.moneyType == 6 ? $('#J_coinTable') : $('#J_beanTable'),
                    btnNext = reqData.moneyType == 6 ? self.coinNext : self.beanNext,
                    btnPrev = reqData.moneyType == 6 ? self.coinPrev : self.beanPrev,
                    $select = reqData.moneyType == 6 ? self.coinSelect : self.beanSelect;

                if(result.length > 0){
                    $table.html( _.template( $("#recordTpl").html())({datas: result}) );
                }

                if(result.length < self.limit){
                    btnNext.addClass('disabled');
                    // return false;
                }

                if(btnPrev.hasClass('disabled')){
                    btnPrev.removeClass('disabled');
                }
            }

            this.coinNext.on('click', function() {

                if($(this).hasClass('disabled')) {
                    return ;
                }

                self.coinCount++;
                // 判断请求的字段是否已存在数组中
                if(self.coinCount < self.coinArr.length-1){
                    var coinCB = function(reqData, resData, result) {
                        nextCB(reqData, resData, result);
                        self.coinSelect.val(self.coinCount+1);
                    }
                    self.ajaxFn(self.coinArr[self.coinCount], coinCB);
                }else{
                    var coinCB = function(reqData, resData, result) {
                        if(result.length == 0){
                            self.coinNext.addClass('disabled');
                            return false;
                        }

                        nextCB(reqData, resData, result);

                        self.coinSelect.append('<option value="'+(self.coinCount+1)+'">第'+(self.coinCount+1)+'页</option>');
                        self.coinSelect.val(self.coinCount+1);
                        
                        if(result.length < self.limit){
                            return false;
                        }

                        var tempObj = {};
                        tempObj.offset = resData.data.offset;
                        tempObj.timeArea = resData.data.timeArea;
                        self.coinArr[self.coinArr.length] = tempObj;
                    }

                    self.ajaxFn(self.concatData(self.coinType), coinCB);
                }
            });

            this.coinPrev.on('click', function() {

                if($(this).hasClass('disabled')) {
                    return ;
                }

                self.coinCount--;

                var coinCB = function(reqData, resData, result) {
                    self.coinSelect.val(self.coinCount+1);
                    
                    $("#J_coinTable").html( _.template( $("#recordTpl").html())({datas: result}) );
                    
                    if(self.coinCount <= 0){
                        self.coinPrev.addClass('disabled');
                        // return;
                    }

                    
                    if(self.coinNext.hasClass('disabled')){
                        self.coinNext.removeClass('disabled');
                    }
                }
                self.ajaxFn(self.coinArr[self.coinCount], coinCB);

            });

            this.coinSelect.on('change', function() {
                self.coinCount = $(this).val() - 1;

                var coinCB = function(reqData, resData, result) {
                    $("#J_coinTable").html( _.template( $("#recordTpl").html())({datas: result}) );

                    if(self.coinCount < self.coinArr.length){
                        if(self.coinNext.hasClass('disabled')){
                            self.coinNext.removeClass('disabled');
                        }

                        if(self.coinPrev.hasClass('disabled')){
                            self.coinPrev.removeClass('disabled');
                        }
                    }

                    if(result.length < self.limit){
                        self.coinNext.addClass('disabled');
                    }

                    if(self.coinCount <= 0){
                        self.coinPrev.addClass('disabled');
                    }
                }
                self.ajaxFn(self.coinArr[self.coinCount], coinCB);
            })

            this.beanSelect.on('change', function() {
                self.beanCount = $(this).val() - 1;

                var beanCB = function(reqData, resData, result) {
                    $("#J_beanTable").html( _.template( $("#recordTpl").html())({datas: result}) );

                    if(self.beanCount < self.beanArr.length){
                        if(self.beanNext.hasClass('disabled')){
                            self.beanNext.removeClass('disabled');
                        }

                        if(self.beanPrev.hasClass('disabled')){
                            self.beanPrev.removeClass('disabled');
                        }
                    }

                    if(result.length < self.limit){
                        self.beanNext.addClass('disabled');
                    }

                    if(self.beanCount <= 0){
                        self.beanPrev.addClass('disabled');
                    }
                }
                self.ajaxFn(self.beanArr[self.beanCount], beanCB);
            })

            this.beanNext.on('click', function() {

                if($(this).hasClass('disabled')) {
                    return ;
                }

                self.beanCount++;

                // 判断请求的字段是否已存在数组中
                if(self.beanCount < self.beanArr.length-1){

                    var beanCB = function(reqData, resData, result) {
                        nextCB(reqData, resData, result);
                        self.beanSelect.val(self.beanCount+1);
                    }
                    self.ajaxFn(self.beanArr[self.beanCount], beanCB);
                }else{
                    var beanCB = function(reqData, resData, result) {
                        if(result.length == 0){
                            self.beanNext.addClass('disabled');
                            return false;
                        }

                        nextCB(reqData, resData, result);

                        self.beanSelect.append('<option value="'+(self.beanCount+1)+'">第'+(self.beanCount+1)+'页</option>');
                        self.beanSelect.val(self.beanCount+1);

                        if(result.length < self.limit){
                            return false;
                        }

                        var tempObj = {};
                        tempObj.offset = resData.data.offset;
                        tempObj.timeArea = resData.data.timeArea;
                        self.beanArr[self.beanArr.length] = tempObj;
                        // self.beanCount++;
                        
                    }

                    self.ajaxFn(self.concatData(self.beanType), beanCB);
                }
            });

            this.beanPrev.on('click', function() {

                if($(this).hasClass('disabled')) {
                    return ;
                }

                self.beanCount--;

                var beanCB = function(reqData, resData, result) {
                    self.beanSelect.val(self.beanCount+1);
                    
                    $("#J_beanTable").html( _.template( $("#recordTpl").html())({datas: result}) );
                    
                    if(self.beanCount <= 0){
                        self.beanPrev.addClass('disabled');
                        return;
                    }

                    
                    if(self.beanNext.hasClass('disabled')){
                        self.beanNext.removeClass('disabled');
                    }
                }

                self.ajaxFn(self.beanArr[self.beanCount], beanCB);
            });
        }

    };

    pagination.init();
})

