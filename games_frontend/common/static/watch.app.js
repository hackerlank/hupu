(function(t,e){var r=5,n=0,a={},i=false,o="",c=Array.prototype.slice,s=["(http:)?//b[1-3].hoopchina.com.cn","(http:)?//w[1-3].hoopchina.com.cn","(http:)?//m.hupu.com","(http:)?//www.google-analytics.com","(http:)?//res.wx.qq.com","(http:)?//hm.baidu.com"];var l=function(t){var e="e_";if(typeof t==="string"&&t.length){var r=t.split(""),n=0,a=0,i=r.length;for(;n<i;n++){a+=r[n]!=""&&r[n].charCodeAt?r[n].charCodeAt():0}e+=a+"_"+i}return e};var u={version:"1.0.8",start:function(){var e=this;this.watchDomInsert();try{var a=document.getElementById("watch_script");o=a.getAttribute("data-mid");if(!!o){i=!localStorage.getItem("watch_debug")}else{i=false}this.watchScript()}catch(c){i=false}var s=i?function(a,i,o,c,s){if(n++>=r){t.onerror=function(){};return true}var l=i||location.href;if(a=="Script error."||!i){return true}setTimeout(function(){var r={};c=c||t.event&&t.event.errorCharacter||0;r.ju=l;r.l=o;r.c=c;if(!!s&&!!s.stack){r.m=s.stack.toString()}else if(!!arguments.callee){var n=[];var i=arguments.callee.caller,u=3;while(i&&--u>0){n.push(i.toString());if(i===i.caller){break}i=i.caller}n=n.join(",");r.m=n}r.m=r.m||a;e.send(r)},0);return true}:function(){};t.onerror=s},watchScript:function(){var e=this;var r=function(){var t=document.getElementsByTagName("script");t=c.call(t);var r=[];for(var n=0;n<t.length;n++){var a=t[n].getAttribute("src");if(a){var i=false;for(var o=0;o<s.length;o++){var l=new RegExp("^"+s[o],"i");if(l.test(a)){i=true}}if(!i){r.push(a)}}}if(r.length>0){e.record("js:["+r.join("|")+"]",2,t.length);e.watchLastNode()}};var n=function(){r();e.hideHtml();setTimeout(r,1e4)};try{if(t.addEventListener){t.addEventListener("load",n,false)}}catch(a){}},watchLastNode:function(){var t=document.body.lastChild;var e=t.previousSibling;var r=e.previousSibling;var n=[t,e,r];var a="";for(var i in n){var o=n[i];if(o.nodeType==1){var s=c.call(o.getElementsByTagName("a"));if(s&&s.length||o.tagName==="A"){a+=o.outerHTML}}}if(a.length){this.record("last:["+a+"]",3)}},watchDomInsert:function(){var e=this;var r=function(t){setTimeout(function(){e.hideHtml()},10)};try{t.addEventListener("DOMNodeInserted",r)}catch(n){}},hideHtml:function(){var t=this;setTimeout(function(){var e=document.getElementsByTagName("iframe");e=c.call(e);for(var r=0;r<e.length;r++){var n=e[r];if(n.src&&n.src.indexOf("http")===0){n.style.cssText="display:none";t.record("iframe:["+n.src+"]",1)}}},0)},mergeDevice:function(r){var n=t.screen;r.appid=1;r.u=e.location.href;r.mid=o;r.s=n?n.width+"x"+n.height:"-";r.pid="-1";return r},send:function(t){var e=this.mergeDevice(t);this.reportlog(e)},record:function(t,e,r,n){var a=this.mergeDevice({});a.mid=n||o;a.m=t||"-";a.c=r;a.l=0;a.pid=e;a.ju="-";this.reportlog(a)},reportlog:function(t){var e=l(t.ju+t.l+t.c+t.m+t.pid);if(a[e])return;a[e]=true;var r="http://js.pub.hupu.com/a.gif?";var n=[];for(var i in t){n.push(i+"="+encodeURIComponent(t[i]))}r+=n.join("&");var o=new Image;o.src=r;o.onload=o.onerror=function(){o.onload=o.onerror=null;o=null}}};u.start();t.Jswatch={record:function(){u.record.apply(u,arguments)}}})(window,document);