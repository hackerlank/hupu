{%block name="content"%}
    <p style="text-align: center;">登录成功，正在跳转...</p>
    <script>
        function getQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        var jumpUrl = getQueryString('absurl');

        parent.location.href = jumpUrl;
    </script>
{%/block%}