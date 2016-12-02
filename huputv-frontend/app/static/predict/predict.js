
!function(){
  "use strict";

	var Toast = require("app:widget/ui-toast/ui-toast.js");
	var _ = require("app:static/js/underscore/underscore");
	var common = require("app:widget/ui-common/ui-common.js");
  	var refresh = require("app:widget/ui-refresh/ui-refresh.js");

	var apiUrl = {
	    // 获取列表
	    list: '/predict/topic/list/:id',
	    // 预测
	    predict: '/m/predict/join',
      statusLogin: '/m/predict/check/login'
	};

	var Predict={
		init:function(){
			//var self=this;
			this.predTplWrap = $("#rpz_predict");
			this.predict = $("#J-rpz-predict");
			this.predictMain = $("#J_rpz_main_refresh");
			this.bind();
			this.render();
		},
		bind:function(){
      		var self = this;

			//进行中预测题选择
			this.optionItem = $(".rpz_option_item");

			this.optionItem.on("click",function(e) {
		        if(GM.islogin) {
		          var current = $(e.currentTarget);
		        	self.handleSelect(current);
		        }else{
		          // 使用scheme 无回调、页面未刷新做兼容
		          if(common.isInApp){
		            $.ajax({
		              url: apiUrl.statusLogin,
		              type: "GET",
		              dataType: "json",
		              success: function(data){
		                if(data.code == 1) {
		                  if(data.data.is_login) {
		                    window.location.reload();
		                  }else{
		                    common.schemeLogin();
		                  }
		                }
		              }
		            });
		          }else{
		            common.schemeLogin();
		          }
		        }
			})

		    
		},
		render:function(){
			var self = this;
			var pHeight = self.predictMain.height();
			var pWindow = $(window).height();
			if(pHeight < pWindow-10){
				self.predictMain.height(pWindow-10);				
			}			
			refresh({
		        contentEl: '#J_rpz_main',
		        isRefresh: true,
		        isLoadingMore: false,
		        refreshCallback: function(complete) {
	                setTimeout(function() {
	                   complete();
	                   location.reload();
	                }, 1000);
		        }
		    });
			/*var template = _.template($("#J-rpz-predict").html(), {datas:datas});

	        this.predTplWrap.html(template);*/

		},
		handleSelect:function(ev) {
	      if(ev.data("status") == 0 && ev.attr("class").indexOf("unselected") > -1){
	  			this.elem = ev;
	  			this.predictId = ev.data("id");
			    this.predictOption = ev.data("option");
			    this.optionId = ev.data("sid");
			    this.score = ev.data("score");
			    this.handleSubmit();
	      }
		},
		handleSubmit:function() {
		    var self = this;

		    var content = '<div class="popup-pred-game"><div class="content">该题人品值基准分为' + self.score + '分，您的当前赢率为' + HTV.magnification + '，确认后将无法修改答案  </div></div>';
		    var Title="确认选择"+self.predictOption;

		    Toast.confirm(
		    	{
		          title:Title,
		          content: content,
		          align: "center",
		          submitHandler: function(){
		          	$.post(
		          		apiUrl.predict,
		          		{
		          			topic_id : self.predictId,
		          			option : self.optionId,
		          			platform : HTV.platform
		          		},function(data){
		          			if(data.code == 1){			          			
			          			self.elem.removeClass("unselected");
								self.elem.addClass("selected").siblings().removeClass("unselected");
								var temphtml = "<div>你的选择“" + self.predictOption + "”</div>";
								self.elem.parents(".rpz_predict_item").find(".rpz_predict_selected").html(temphtml);
					            Toast.toast(data.msg);

				          		return;
					        }else{

					        	Toast.toast(data.msg);
					        }
		          		}
		          	)
		          },
		          submitText: "确认",
		          cancelText: "取消",
		          cancelHandler: function(){

		          }
		        }
		    )

	  },
	}

  $(function(){
      Predict.init();
  })
}();
