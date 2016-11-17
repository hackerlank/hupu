$(function(){

	var _ = require("underscore");

	var NbaMap = {
		init: function(){
			this.render();
			this.bind();
		},

		render: function(){
			this.mapContainer = $("#J-map-wrap");
			this.tabs = $("#J-tabs");
			this.datasContainer = $("#J-datas-wrap");
			this.datasTpl = _.template( $("#J-datas-tpl").html() );
			this.iWidth = $(".iwidth").width()*0.84;

			this.dataWidth = 50; //数据坐标相对的背景图宽
			//this.dataHeight = 47; //数据坐标相对的背景图高

			this.scale = this.iWidth / this.dataWidth; //由于背景的比例和数据坐标相对的背景比例不一

			this.allData = $(".all-data").html();
		},

		bind: function(){
			var self = this;

			self.autoPosition();
			self.tabs.find("span").on("click", function(){
				$(this).addClass("active").siblings("span").removeClass("active");
				if($(this).find("a").data("section") != 0){
					self.sectionAjax($(this).find("a").data("section"));
				}else{
					self.datasContainer.html( self.allData );
					self.autoPosition();
				}
			});

			self.mapContainer.delegate(".link", "click", function(e){
				var current = $(e.currentTarget);
				window.location.href = current.attr("link");
			});

			$("#J-close").on('click', function(){
				HupuBridge.send("hupu.ui.pageclose", {}, function(){ 
				});
			})
		},

		sectionAjax: function(section, callback){
			var self = this;
			$.ajax({
				url: "/nba/showPlayerAjax",
				type: "GET",
				dataType: "json",
				data: {
					gid: GM.gid,
					player_id: GM.player_id,
					section: section,
					client: GM.client
				},
				success: function(data){
					data.datas = data.player_score.fgStats;
					var html = self.datasTpl(data);

					self.datasContainer.html( html );
					self.autoPosition();
					callback && callback();
				}
			});
		},

		autoPosition: function(){
			var self = this;

			self.datasContainer.find(".dot").each(function(){
				$(this).css("left", self.scale * parseFloat($(this).css("left")) - 4.5);
				$(this).css("top", self.scale * parseFloat($(this).css("top")) - 4.5 );
			});
		}
	}

	NbaMap.init();

})
