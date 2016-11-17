<template>
    <section class="team-rank mod-rank">
    	<div class="nav">
        <scroller lock-x scrollbar-y>
    		<ul>
            <li v-if="item.data" v-for="(index, item) in rank[2].ranks_data" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
    		</ul>
        </scroller>
    	</div>

      <div class="main">
      <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
    	<ul>
    		<li v-if="item.data" v-for="(index, item) in rank[2].ranks_data" class="mod-scroller-con">
    			<table class="mod-title title">
    				<thead>
    					<tr>
    						<td width="70%" colspan="2" class="type"><span>{{item.name}}榜</span></td>
    						<td width="30%" align="center">{{item.title}}</td>
    					</tr>
    				</thead>
    			</table>
    			<table class="mod-table">
    				<tbody>
    					<tr class="tap" v-for="(subIndex, subItem) in item.data" v-if="subIndex < 5" @click="goto(subItem)">
    						<td width="70%" align="left">
                                <span class="num" :class="{red: subIndex === 0}">{{subIndex+1}}</span>
                                <span class="soccer-logo">
                                    <img width="34" :src="subItem.team_logo" />
                                </span>
    							<span class="name">{{subItem.team_name}}</span>
    						</td>
    						<td width="30%" align="center">
    							{{last(item.field, item.rank_type, subItem)}}
    						</td>
    					</tr>
    					<tr class="last-tr">
    						<td colspan="3" align="center">
    							<span class="view-all tap" @click="gotoAll(item)">查看全部 &gt;</span>
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
        night: Boolean,
        rank: Array,
        leaguename: String,
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
    methods:{
        goto(data) {
            go(`kanqiu://soccerleagues/${this.leaguename}/team/${data.team_id}`)
        },
        gotoAll(data){
            go(`${getHost()}/data/footballAllRank?league_name=${this.leaguename}&rank_type=${data.rank_type}&page=1&client=${info.client}`);
        },
        last(field, rank_type, subItem){
            if  (rank_type== "pass_per"){
                return subItem[field] * 100
            }else{
                return subItem[field]
            }
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
        onScroll(e) {
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
