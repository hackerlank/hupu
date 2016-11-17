
$(function(){
	var buyBeans = {
		init: function() {
			this.wrap = $('.choise_content');
			this.list = $('#J-get-beans');
			this.$radio = $('.c_radio');
			this.cancelBtn = $('#cancel');
			this.buyBtn = $('#confirm');
			this.errorTips = $('.error-tips');
			this.bind();
			if(!isEnough){
				this.showTips();
			}
		},
		bind: function() {
			var self = this;

			var tpl = '<div class="fail-tips">\
			        <div class="fail-content">购买失败，你可以尝试重新购买或<a href="http://b.qq.com/webc.htm?new=0&sid=800021359&o=hupu.tv&q=7">联系客服</a></div>\
			        <div class="button-inner">\
			            <a href="javascript:;" class="button button-cancel" id="J_failButtonCancel">取消</a>\
			            <a href="#" class="button button-confirm" id="J_failButtonConfirm">重新购买</a>\
			        </div>\
			    </div>' ;

			
			$('.c_radio').on('change', function(e) {
				var coin  = $(this).val(),
					index = $(this).parents('li').index();

				if(self.errorTips.is(':visible')){
					self.errorTips.html('').hide();
				}

				self.removeCoin();
				self.showCoin(coin,index);
			})

			this.cancelBtn.on('click', function() {
				if($('.prompt').length > 0){
					$('.prompt').remove();
				}
			})

			this.buyBtn.on('click', function(e) {
				e.preventDefault();
				var amount = $('.c_radio:checked').val();

				if(self.list.find('li:eq(0)').hasClass('disabled')){
					self.errorTips.html('<span class="buying_fails">你的虎扑币余额不足，请先<a href="'+recharge_url+'">充值虎扑币</span>').show();
					return;
				}

				if(!amount) {
					self.errorTips.html('<span class="buying_fails">请选择您需要购买的金豆数额</span>').show();
					return;
				}

				$.ajax({
					type: 'post',
					url: "/wallet/beans-recharge",
					data: {
						amount: amount
					},
					dataType: 'json',
					success:function(data){
						if(data.code == 1){
							self.successCB(amount, data.data['1'], data.data['6']);
						}else{
							$.colorbox({
								width: '450px',
								height: '200px',
								fixed: true,
								html: tpl
							});

							$('#J_failButtonCancel')
							    .off('click')
							    .on('click', function() {
							        $.colorbox.close();
							    });

							$('#J_failButtonConfirm')
							    .off('click')
							    .on('click', function() {
							        location.reload();
							    });
						}
			        },
			        error:function(){
			       	    $("#buying_fails").css("display","block");
			        }
		        });

			})
		},
		showCoin: function(coin, index) {
			var self = this;
			var tpl = '<div class="prompt">共需要<span>'+coin+'</span>个虎扑币</div>';

			this.list.find('li').eq(index).append($(tpl));
		},
		removeCoin: function() {
			if($('.prompt').length > 0){
				$('.prompt').remove();
			}
		},
		showTips: function() {
			var self = this;
			var tpl = '<div class="tips">提示：你的虎扑币余额为 <em>'+restCoin+'</em>，'
					+ '如需购买更多，请<a href="'+recharge_url+'">充值虎扑币</a>。</div>';

			$(tpl).appendTo(this.list.find('li.disabled').eq(0)).show();

		},

		successCB: function(coin, restBean, restCoin) {
			var self = this;
			var tpl = '<div id="buy_success">'
		   			+ '<p>你已成功使用<span>'+coin+'</span>个虎扑币购买了<span>'+coin+'</span>个金豆</p>'
					+ '<a href="javascript:;" id="continue_btn">继续购买</a>'
					+ '<a href="'+referer+'"id="return_h">返回</a>'
					+ '</div>';

			$('#J_bean').html(restBean);
			$('#J_coin').html(restCoin);

			$(tpl).appendTo($('.buy_choise')).show(100);

			$('#continue_btn').on('click', function() {
				location.reload();
			})
		}
	};

	buyBeans.init();
	
});

    
