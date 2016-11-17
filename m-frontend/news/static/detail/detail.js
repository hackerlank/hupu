/*
 * @file 新闻内页js
 **/
!function(){
	var _ = require('underscore');
    var dace = require("common:widget/ui/page-dace/page-dace.js");

    var pageId = __daceDataNameOfPage;

	var voteFn = {
		init: function(){
			this.$vote = $('.choice-item');
			this.$tips = $('.tips');
			this.$toolbar = $('.choice-item2');
			this.nid = $('.choice').attr('news-id');
			this.flag = true;
			this.bind();	

		},

		bind: function(){
			var that = this;
			this.$vote.bind('click',function(){
	            if(that.flag){
					that.ajaxFn($(this));
	            }
			});
			this.$toolbar.bind('click',function(e){
				that.ajaxFn($(this));
				e.preventDefault();

			});

		},

		ajaxFn: function(item){
			var that = this;
			var	_type = $(item).hasClass('support') ? 1 : 2,
				index = _type == 1 ? 0 : 1;

            // 未登录
            if ( !HPM.isLogin ) {
                HPM.popLogin();
                return;
            }

            $.ajax({
                type: 'POST',
                url: '/news/supportagaist/nid/'+that.nid+'/type/'+_type,
                dataType: 'json',
                timeout: 3000,
                beforeSend: function(){
                    that.flag = false;
                },
                success: function(data){
                    if(data.status == 200){
                        if ( _type === 1 ) {
                            dace.send(pageId + "_for");
                        } else {
                            dace.send(pageId + "_against");
                        }

                        that.voteBind(item,index,data.msg,data.support,data.against,data.type);
                    }
                    else if(data.status == 400){
                         HPM.popLogin();
                         that.flag = true;
                    }else{
                        that.showTips(data.msg);
                        that.flag = true;
                    }

                },
                error: function(xhr, type){
                    that.showTips("您点的太快了，休息一下!");
                    that.flag = true;
                }
            })

		},

		voteBind: function(item,index,tips,num1,num2,type){
			var that = this;
			if( type == 2 ){
				this.$vote.eq(index).removeClass('cur');
				this.$toolbar.eq(index).removeClass('cur');
				that.showTips(tips);
			}else{
				this.$vote.removeClass('cur').eq(index).addClass('cur').find('i').addClass('cur');
				this.$toolbar.removeClass('cur').eq(index).addClass('cur').find('i').addClass('cur');
				that.showTips(tips);
				
				setTimeout(function(){
					that.$vote.eq(index).find('i').removeClass('cur');
				},500);			
			}

			if(num1 == 0){
				this.$vote.eq(0).find('span').html('');
			}else{
				this.$vote.eq(0).find('span').html('('+num1+')');
			}

			if(num2 == 0){
				this.$vote.eq(1).find('span').html('');
			}else{
				this.$vote.eq(1).find('span').html('('+num2+')');
			}

			that.flag = true;
		},

		showTips: function(str){
			var that = this;
			this.$tips.html(str).show();
			setTimeout(function(){
				that.$tips.hide();
			},1000);
		}
	}

	voteFn.init();
}();



