<section class="tab">
	{%if $video.video_type != 1%}
    <a href="javascript:;" class="active">视频介绍</a>
    {%if $video.video_type == 2%}
    	<a href="javascript:;">球员统计</a>
    {%/if%}
    {%if $video.tid >= 0%}
    	<a href="javascript:;">赛后讨论</a>
    {%/if%}
  {%/if%}
</section>
