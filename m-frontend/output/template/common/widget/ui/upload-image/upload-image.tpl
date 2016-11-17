<div class="upload-image">
<div class="title">
最多可上传 6 张图片</div>
<div class="list" id="J_uploadImageWrap">
<a href="javascript:" class="add-image" dace-node="{%$id4dace|f_escape_xml%}_image" id="J_addImage">
<span class="border-add"></span>
<span class="border-white">
<span class="border-white-bd"></span>
</span>
<input type="file" name="files[]" class="button-upload-image J_buttonUploadImage" accept="image/*">
</a>
</div>
</div>
{%script%}
var uploadImage = require("common:widget/ui/upload-image/upload-image.js");

$(function(){
    uploadImage.init();
})
{%/script%}