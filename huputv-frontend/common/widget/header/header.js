var User = require("common:widget/login/login.js");

var header = {
	init: function(){
		this.login = $('#J_loginUrl');
		this.register = $('#J_registerUrl');
		this.bind();
	},

	bind: function(){
		var self = this;
		var headerContainer = $("#J-w-header");
		headerContainer.find(".link-myfollow").one("mouseover", function(){
			self.soon(function(){
				headerContainer.find(".myfollow .num").hide(500);
			});
		});

		if(this.login.length == 0){
			return;
		}

		this.login.on('click', function(e) {
			e.preventDefault();
    		User.login();
		});

		if(this.register.length == 0){
			return;
		}

		this.register.on('click', function(e) {
			e.preventDefault();
    		User.register();
		});


	},

	soon: function(callback){
		$.ajax({
			url: "/live/soon",
			type: "GET",
			dataType: "json",
			data: {
				"uid": HTV.getUserId,
				"read": 1
			},
			success: function(data){
				if(data.code == 1){
					callback && callback();
				}
			}
		});
	}
}

module.exports = header;



