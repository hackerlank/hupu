<section class="t-content hotline">
		<div class="system-info" id="J-system-info">
			<div class="hd">系统通知</div>
			<div class="bd">
				为给大家提供更好的直播服务，虎扑TV现更名为［亮了网］；并将于近期对服务器进行升级操作，升级期间送礼服务将暂停使用，为大家带来的不便，尽请谅解。请大家期待即将发布的新版本！
			</div>
			<i class="icon icon-close" id="J-system-close"></i>
		</div>
		<div class="hotline-info">
		    <header class="hd hotline-hd">
		    	<div class="content" id="J-hotline-wrap"></div>
		    	<!--主播信息datas.et==3001 -->
		    	<!--datas.et==2001 送技能礼物datas.lt == '2'  送金豆datas.mt == "1" 否则送礼物-->
		    	<!--攒人品datas.et==2002 -->
		    	<!--datas.puid != userInfo 用户发言datas.et==2000 否则 自己发言-->
		    		<script id="J-hotline-tpl" type="text/template">

			    		<@if(datas.et==3001){@>
				    		<div class="info">
						    	<div class="anchor-name">
						    		<img src="./icon-anchor.png" alt="" />
						    		<b><@=nickname@></b>
						    		<span><@=datas.cnt@></span>
						    	</div>
					    	</div>
				    	<@}@>

				    	<@if(datas.et==2001){@>
				    		<@if(datas.lt == '2'){@>
						    	<div class="info">
						    		<b><@=datas.un@></b>
						    		<span class="info-num <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
						    		<span>
						    			送出<i><@=datas.giftn@></i>个
											<span class="gift-name"><@=datas.giftname@></span>给
											<span class="ball-name"><@=datas.teamn@></span>本场排行第<i><@=datas.ur@></i>
						    		</span>
						    	</div>
					    	<@}else{@>
					    		<@if(datas.mt == "1"){@>
							    	<div class="info">
							    		<b><@=datas.un@></b>
							    		<span class="info-num  <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
							    		<span>
							    			送出<i><@=datas.giftn@></i>个
												<span class="gift-name"><@=datas.giftname@></span>
												给主播
							    		</span>
							    	</div>
							    <@}else{@>
							    	<div class="info">
							    		<b><@=datas.un@></b>
							    		<span class="info-num  <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
							    		<span>
							    			送出<i><@=datas.giftn@></i>个
												<span class="gift-name"><@=datas.giftname@></span>
												给主播
												，本场排行第<i><@=datas.ur@></i>
							    		</span>
							    	</div>
							    <@}@>
					    	<@}@>
				    	<@}@>

				    	<@if(datas.et==2002){@>
					    	<div class="info">
					    		<b><@=datas.un@></b>
					    		<span class="info-num  <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
					    		<span>
					    			为
										<span class="ball-name"> <@=datas.option@></span>攒了
										<i><@=datas.score@></i>点人品
					    		</span>
					    	</div>
				    	<@}@>

				    	<@if(datas.et==2000){@>
				    		<@if(datas.puid != userInfo){@>
						    	<div class="info user-say">
						    		<b><@=datas.un@></b>
						    		<span class="info-num  <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
						    		<span><@=datas.cnt@></span>
						    	</div>
						    <@}else{@>
						    	<div class="info my-say">
						    		<b><@=datas.un@></b>
						    		<span class="info-num  <@if(datas.rp>=0){@>info-num－plus<@}else{@>info-num－minus<@}@>"><@=datas.rp@></span>
						    		<span><@=datas.cnt@></span>
						    	</div>
					    	<@}@>
					    <@}@>
			    	</script>
			    	<!--系统消息
			    	<div class="system-info">

			    		<div class="system-name">
			    			<span class="sys-ballname">购买技能：球队名称</span>
			    			购买了
			    			<i>N</i>个
			    			<span class="skill-name">技能名称</span>
			    		</div>

			    		<div class="system-name">
			    			<span class="sys-ballname">使用技能：球队名称</span>
			    			正在使用
			    			<span class="skill-name">技能名称</span>
			    		</div>
			    	</div>
			    	-->
			    	<!--
					<div class="no-text">
						<div class="img"></div>
						<p>抢沙发</p>
					</div>
					-->
		    </header>
		    <!--
		    <footer  class="send-info">
	    		<div class="writer-btn">
	    			<i></i>
	    			<input type="text" class="write-btn-input" placeholder="说点什么吧...">
	    		</div>
	    		<div class="writer-info" style="display:none;">
	  				<div class="event-info">
	  					<div class="writer-cancel">取消</div>
	  					<div class="writer-num">热线发言&nbsp;<b>0</b>/60</div>
	  					<div class="writer-submit">提交</div>
	  				</div>
	  				<div class="edit-info">
	  					<input type="text" class="edit-info-input" maxlength="60"  placeholder="和大家说点什么…" >
	  				</div>
	    		</div>
		    </footer>
		    -->
		   </div>
</section>
{%script%}
    var hotLine = require("./hotline.js");
    hotLine.init();
{%/script%}
