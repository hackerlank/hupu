/**
 * @file 上传图片
 * @author wangjun@hupu.com
 * @date 2015-07-21
 */
    "use strict";

    var _ = require("underscore");
    var Tips = require('common:widget/ui/tips/tips.js');
    var resizeIMG = require('common:widget/ui/upload-image/resize-image.js');
    var dace = require("common:widget/ui/page-dace/page-dace.js");
    var pageId = __daceDataNameOfPage;

    /**
     * 接口地址
     */
    var apiUrl = {
        // 上传图片
        uploadIMG: '/bbs/uploadimg'
    };

    var UploadImage = {
        init: function(){
            var that = this;

            this.$wrap = $('#J_uploadImageWrap');

            if(!this.$wrap.length){
                return;
            }

            this.maxCount = 0;

            this.$buttonAdd = $('#J_addImage');

            new resizeIMG($('.J_buttonUploadImage'),{
                width: 640,
                quality: 0.8,
                successCallback: function(result){
                    that.createList(result);
                }
            });

            //this.$wrap.off("uploadIMG").on("uploadIMG", function(event, callback) {
            //    that.uploadIMG(callback);
            //});
        },
        bind: function(){
            var that = this;

            $('.J_buttonDeleteImage')
                .off('tap')
                .on('tap', function(){
                    var $parent = $(this).parents('.has-upload-list');
                    that.maxCount--;

                    $parent.remove();
                    that.$buttonAdd.show();
                    dace.send(pageId + "_delete");
            });

            new resizeIMG($('.J_buttonNewImage'),{
                width: 640,
                quality: 0.8,
                successCallback: function(result, elem){

                    if(result.status === 200){
                        var $loadImg = elem.parents('.has-upload-list').find('.J_loadImage');

                        $loadImg
                            .attr('data-url', result.data.base64)
                            .css({
                                'background-image': 'url('+ result.data.base64 +')'
                            });

                        return;
                    }

                    Tips(result.message);
                }
            });

        },
        createList: function(result){
            var that = this;

            var list_tpl = [
                '<div class="has-upload-list">',
                    '<div class="load-image J_loadImage" data-url="<@=img@>" style="background-image: url(<@=img@>)"></div>',
                    '<span class="button-delete J_buttonDeleteImage"></span>',
                    '<input type="file" name="files[]" class="button-upload-image J_buttonNewImage" accept="image/*">',
                '</div>'
            ].join('');

            var img = '';

            if(result.status === 200) {
                img = result.data.base64;

                var tpl = _.template( list_tpl, {img: img} );

                this.$buttonAdd.before(tpl);

                this.maxCount++;
                // 最多可上传 6 张图片
                if(this.maxCount >= 6){
                    this.$buttonAdd.hide();
                }

                this.bind();

                dace.send(pageId + "_photo");
                return;
            }

            Tips(result.message);
        },
        uploadIMG: function(callback){
            var $list = this.$wrap.find('.J_loadImage');

            if($list.length){
                var files = [];

                $list.each(function(){
                    files.push($(this).attr('data-url'));
                });

                $.ajax({
                    url: apiUrl.uploadIMG,
                    type: "POST",
                    data: {
                        files: files
                    },
                    dataType: 'json',
                    success: function(data) {
                        callback && callback();
                    }
                });
            }else{
                callback && callback();
            }
        }
    }

module.exports = UploadImage;