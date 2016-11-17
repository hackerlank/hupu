$(function(){
    function arr1(obj,str,thats){
        var array = {},$this = thats?thats:$(".team_qushi").eq(obj).find("a").eq(0);
        for(var i=0,len=str.length; i<len; i++){
            array[str[i]] = $this.attr(str[i]);
        }
        return array;
    }

    var higs_fun = function(obj1,arr){
        obj1.higs("line",{
            num:arr.arr,
            name:arr.name,
            text:arr.tit,
            pointStart:arr.pointStart,
            categories:arr.categories,
            measure: arr.measure
        });//调用走势图  arr为数据
    }

    var hig_funclick = function(obj,num){
        obj.delegate("a","click",function(){
            var arrs = arr1(num,["arr","name","tit","categories","pointStart","measure"],$(this));
            $(this).addClass("on");
            $(this).siblings().removeClass("on");
            $('.team_hig_js').eq(num).higs("line",{
                num:arrs.arr,
                name:arrs.name,
                text:arrs.tit,
                categories:arrs.categories,
                pointStart:arrs.pointStart,
                measure: arrs.measure
            });
        });
    }

    for(var k=0,len=$(".team_hig_js").length; k<len; k++){
        higs_fun($(".team_hig_js").eq(k),arr1(k,["arr","name","tit","categories","pointStart","measure"]));
        hig_funclick($(".team_qushi").eq(k),k);
    }

    var obj = $(".gamecenter_content_r").find(".video_box").find("li");
    obj.hover(function(){
        $(this).css({
            backgroundColor:"#f2f2f2"
        });
        },function(){
            $(this).css({
            backgroundColor:"#fff"
        });
    });
});
