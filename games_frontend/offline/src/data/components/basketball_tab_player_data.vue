<template>
    <section class="player-data mod-rank">
		<div class="nav">
            <scroller lock-x scrollbar-y>
			<ul>
				<li v-for="(index,item) in datas" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
			</ul>
            </scroller>
		</div>

        <div class="main">
            <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
        		<ul>
        			<li v-for="(index, item) in datas" class="mod-scroller-con">
        				<table class="mod-title title">
        					<thead>
        						<tr>
        							<td width="66%" class="type">{{item.name}}排行榜</td>
        							<td width="20%" align="center">球队</td>
        							<td width="14%" align="center">数据</td>
        						</tr>
        					</thead>
        				</table>
        				<table class="mod-table">
        					<tbody>
        						<tr v-for="(subIndex,subItem) in item.data" @click="goto(subItem)">
        							<td width="66%">
        								<span class="num" :class="{red: subItem.rank === 1}" v-text="subItem.rank"></span>
        								<span class="logo">
                                            <img v-bind:src="subItem.player_header" />
                                            <span class="mask" v-if="night"></span>
                                        </span>
        								<span class="detail">
        									<span class="name">{{subItem.player_name}}</span>
        									<span class="others">
        										{{subItem.pts}}分
        										{{subItem.reb}}板
        										{{subItem.asts}}助
        									</span>
        								</span>
        							</td>
        							<td width="20%" align="center">{{subItem.team_name}}</td>
        							<td width="14%" align="center">{{subItem.val}}</td>
        						</tr>

        						<tr v-if="match == 'nba' && item.is_more" class="last-tr">
        							<td colspan="3" align="center">
        								<span class="view-all" @click="gotoAll(item)">查看全部 &gt;</span>
        							</td>
        						</tr>
                                <tr v-if="match == 'nba' && item.data.length == 0" class="last-tr">
                                    <td colspan="3" align="center">
										暂无数据
									</td>
        						</tr>
        					</tbody>
        				</table>
        			</li>
        		</ul>
            </scroller>
        </div>
    </section>
</template>

<script>
import { Scroller } from 'components'
import { go } from 'common/router'
import { getHost } from '../common/models'
import { info } from 'common/app'

export default {
    components: {
        Scroller
    },
    props: {
        datas: Array,
        night: Boolean,
        match: String,
        pagetab: String,
        tabIndex: 0,
        scrollTops: [],
        lastIndex: 0,
        lockScroll: false,
        initScrollStatus: false
    },
    ready(){
        this.tabIndex = 0
    },
    methods: {
        goto(data) {
            if(this.match == 'nba'){
                go(`kanqiu://nba/nba/player/${data.player_id}`)
            } else{
                go(`kanqiu://cba/cba/player/${data.player_id}`)
            }
        },
        gotoAll(data){
            go(`${getHost()}/nba/getDailyPlayer?category=${this.pagetab}&type=${data.en}&page=1&client=${info.client}`);
        },
        initScroll(){
            if(this.initScrollStatus) return
            this.initScrollStatus = true

            this.scrollTops = []


            let childs = this.$refs.scroller.$el.querySelectorAll(".mod-scroller-con");

            for(let i = 0, len = childs.length;i < len;i++){
                this.scrollTops.push(childs[i].offsetTop)
            }
        },
        updatePos(index) {
            this.initScroll()

            this.tabIndex = index
            this.lastIndex = index

            this.lockScroll = true
            this.$nextTick(() => {
                let top = this.scrollTops[index]
                this.$refs.scroller.reset({
                  top: top
                })
                this.lockScroll = false
            })
        },
        onScroll(e){
            if(this.lockScroll) return;
            this.initScroll()

            this.$nextTick(() => {
                const scrollTops = this.scrollTops
                const lastTop = scrollTops[this.lastIndex];
                let index = 0,
                    min = 0,
                    max = scrollTops.length

                if(e.scrollTop > lastTop){
                    min = this.lastIndex
                } else{
                    max = this.lastIndex
                }

                for(let i = min;i < max; i++){
                    const scrollTop = scrollTops[i];
                    if(scrollTop <= e.scrollTop){
                        index = i
                    }
                }
                this.tabIndex  = index
                this.lastIndex = index
            })
        }
    }
}
</script>

<style lang="less">

</style>
