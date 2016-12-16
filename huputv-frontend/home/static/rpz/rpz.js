(function() {

    var _ = require('common:static/js/underscore/underscore.js');
    var api = {
        list: '/predict/user/topic/list',
        zrplist:'/predict/user/record/list'
    };

    var recordList = {
        initTable: function(){
          //不支持canvas
          if(!this.canvasSupport()){
            return;
          }
          //暂无数据
          if(!HTV.rpzDays || !HTV.rpzDatas || !HTV.rpzDays.length){
            return;
          }
          //无容器
          if(!document.getElementById('grid-main')){
            return;
          }

          // 基于准备好的dom，初始化echarts实例
          var myChart = echarts.init(document.getElementById('grid-main'));
          var tables = [];
          for(var x in HTV.rpzDatas){
            var val = HTV.rpzDatas[x];
            var item = {
              name : x,
              value: HTV.rpzDatas[x]
            };

            if(val > 0){
              item.itemStyle = {
                  normal: {
                      color: '#ff9fa5'
                  },
                  emphasis: {
                      color: '#d22f33'
                  }
              }
            } else{
              item.itemStyle = {
                  normal: {
                      color: '#88e691'
                  },
                  emphasis: {
                      color: '#68ba70'
                  }
              }
            }
            tables.push(item);
          }

          // 指定图表的配置项和数据
          var option = {
              xAxis: {
                  data: HTV.rpzDays
              },
              yAxis: {},
              series: [
              {
                  name: '人品值',
                  type: 'bar',
                  data: tables,
                  barWidth: 6
              }]
          };
          myChart.setOption(option);
        },
        init: function() {
            //初始化图表
            this.initTable();

            this.moreBtn = $('#J_more');
            this.recordList = $('#J_recordList');
            this.moreFinish = $("#J_loadmore");
            this.zrpTab = $(".zrp-record");
            this.zrpContent = $(".zrp-detail");
            this.zrpDetailNav = $("#J-rpz-detail-head");
            this.zrpDetailWrap = $("#J-rpz-detail");
            this.zrpDetailTpl = $("#J-detail-tpl").html();
            this.zrpDetailMore = $("#J_more_rpz");
            this.nextDate = HTV.nextDate;
            this.bind();
            this.index = 0;
        },
        canvasSupport: function() {
            return !!document.createElement('canvas').getContext;
        },
        bind: function() {
            var self = this;

            this.moreBtn.on('click', function() {
                $.get(api.list, {
                    next: self.nextDate
                },function(data) {

                    if(data.code == 1) {
                        var recordTpl = _.template( $("#record-tpl").html(), {datas: data.data} );
                        self.recordList.append( recordTpl );
                        if(data.data.next){
                          self.nextDate = data.data.next;
                        } else{
                          self.moreBtn.hide();
                          self.moreFinish.show();
                        }
                    }else{
                        self.moreBtn.hide();
                        self.moreFinish.show();
                    }
                },"json")
            });
            this.zrpTab.on('click',function(){             
              var index = $(this).index();

              $(this).addClass("active").siblings().removeClass("active");              
              self.zrpContent.removeClass("active").eq(index).addClass("active");
              if( index >0 && !$(this).hasClass("visited")){
                $(this).addClass("visited");
                self.getzrpdata();
              }
                      
            })

        },
        getzrpdata:function(next_id){     
          var self = this;     
          var id = next_id ? next_id :"";
          $.get(api.zrplist,
            {next_id:id},
            function(res){
              if(res.code == 1){                
                var rate = res.data.list.length ? res.data.list.length%2 : '-1';
                
                var data  = self.arrayList(res.data.list);
                var temp = _.template( self.zrpDetailTpl, {datas:data ,rate:rate} );                 
                self.zrpDetailWrap.append( temp );
               
                if(res.data.next_id){                  
                  self.zrpDetailMore.show();
                  if(self.index < 1){
                    self.getMoreRpz(res.data.next_id);
                    self.index++;
                  }
                }else{
                  self.zrpDetailMore.hide();
                }
              }
            }
          )
        },
        getMoreRpz:function(next_id){
          var self = this;          
          this.zrpDetailMore.on('click',function(){
            self.getzrpdata(next_id);               
          })
        },
        arrayList:function(data){
          var listDate = []; 
          if(!data.length){
            return;
          }             

          data.map(function(item,index){ 
            var obj = {};            
            for(var key in item){
              if(key == 'title'){
                var arr = item.title.split('-');
                obj['title'] = arr[0] ? arr[0]: "";
                obj['name'] = arr[1] ? arr[1] :"";
              }else{                
                obj[key] = item[key];                
              }
            }
            listDate.push(obj);
          })          
          return listDate;
        },

    };

    recordList.init();

})()
