(function() {
    var _ = require('common:static/js/underscore/underscore.js');

    var api = {
        list: '/predict/rank/list'
    };

    var rankList = {
        init: function() {
            this.dayList = $('#J_dayList');
            this.monthList = $('#J_monthList');
            this.dMList = $("#J_moreRecord");
            this.hiddenData = $("#N_Data");
            this.dayPage = 2;
            this.monthPage = 2;
            this.pageSize = 20;
            this.currentDayList = true;
            this.currentMonthList = true;
            this.rank=false;
            this.bind();
        },

        bind: function() {
            var self = this;

            this.dMList.on('click', function() {
                    if (self.currentDayList) {
                        $.get(api.list, {
                            type: 1,
                            page: self.dayPage,
                            pageSize: self.pageSize,
                            is_api: 1,
                            need_count:1
                        }, function(res) {
                            if (res.code == 1) {
                                var dayTpl = _.template($("#day-tpl").html(), {
                                    datas: res.data.rankList
                                });
                                self.dayList.append(dayTpl);
                                self.dayPage++;
                            }
                            self.currentDayList = !!res.data.next;
                            if(self.dayPage==11&&self.currentDayList){                                
                                self.rank=true;
                                self.currentDayList=false;                                   
                            }
                            self.hideBtn();
                        }, "json");
                    }

                    if (self.currentMonthList){
                        $.get(api.list, {
                            type: 2,
                            page: self.monthPage,
                            pageSize: self.pageSize,
                            is_api: 1,
                            need_count:1
                        }, function(res) {
                            if (res.code == 1) {
                                var monthTpl = _.template($("#month-tpl").html(), {
                                    datas: res.data.rankList
                                });
                                self.monthList.append(monthTpl);
                                self.monthPage++;
                            }
                            self.currentMonthList = !!res.data.next;
                            if(self.monthPage==11&&self.currentMonthList){                                
                                self.rank=true;
                                self.currentMonthList=false;
                            }
                            self.hideBtn();
                        }, "json");
                    }
                });
        },

        hideBtn: function(){
            if (!this.currentDayList && !this.currentMonthList) {
                this.dMList.hide();
                if(!this.rank){
                    this.hiddenData.show();
                }              
            }
        }
    };

    rankList.init();

})()
