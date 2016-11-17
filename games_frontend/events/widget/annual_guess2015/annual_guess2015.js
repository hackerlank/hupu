var _ = require("underscore");

function getAnswerCount(desc){
	var reNum = /\d+/g;
	var result = desc.match(reNum);
	var res = {
		count: 0,
		n1: 0
	};
	if(result.length >= 2){
		res.count = parseInt(result[0], 10);
		res.n1 = parseInt(result[1], 10);
	}
	return res;
}

var annual_guess = {
	init: function(){
		this.render();
		this.bind();
	},

	render: function(){
		this.listContainer = $("#J-list");
		this.tplListRender = _.template($("#J-list-tpl").html());

		this.iHeight = $(window).height();
		this.counts = 0;
	},

	bind: function(){
		var self = this;
		//一分钟拉一次竞猜接口
		self.getData();
		setInterval(function(){
			self.getData();
		}, 60000);
		

		$("body").css({
			"height": self.iHeight,
			"overflow": "hidden"
		});

		var count = 0;
		setInterval(function(){
			count++;
			var index = count % Math.ceil(self.counts/2);
			self.listContainer.find(".list-container").css("top", -self.iHeight*index);
		}, 5000);
	},

	getData: function(callback){
		var self = this;
        $.ajax({
            url: "/1/7.0.5/quiz/getListByGame?client=xxx",
            type: "POST",
            dataType: "json",
            data: {
                "lid": GM.glid,
                "gid": GM.ggid,
                "client":"xxx"
            },
            success: function(data){
            	var guess = data.result.quiz.list[0].rs;
            	self.counts = guess.length;

            	
                $(guess).each(function(idx, item){
					var a1 = item.answer1;
					var a2 = item.answer2;
					var a1with = "「"+ a1 +"」";
					var a2with = "「"+ a2 +"」";

					if(item.desc){
						//答案一
						if(item.desc.indexOf(a1with) != -1){
							var res = getAnswerCount(item.desc);
							var count = res.count;
							item.answer1Count = res.n1;
							item.answer2Count = count - res.n1;
							item.answer1Percent = item.answer1Count / count * 100;
							item.answer2Percent = item.answer2Count / count * 100;
						}

						//答案二
						if(item.desc.indexOf(a2with) != -1){
							var res = getAnswerCount(item.desc);
							var count = res.count;
							item.answer2Count = res.n1;
							item.answer1Count = count - res.n1;
							item.answer1Percent = item.answer1Count / count * 100;
							item.answer2Percent = item.answer2Count / count * 100;
						}

						//福利题
						if(!item.answer1Count){
							var res = getAnswerCount(item.desc);
							var count = res.count;
							item.answer2Count = Math.floor(count/2);
							item.answer1Count = count - item.answer2Count;
							item.answer1Percent = item.answer1Count / count * 100;
							item.answer2Percent = item.answer2Count / count * 100;
						}
					}
				});

                var html = self.tplListRender({datas: guess});
				self.listContainer.html( html );
                callback && callback();
                
				self.listContainer.find(".list-wrap").each(function(){
					$(this).css({
						"height": self.iHeight
					});
				});
            }
        });
	}
}

module.exports = annual_guess;