<template>
    <section class="transfer-player mod-rank">
    	<div class="nav">
        <scroller lock-x scrollbar-y>
    		<ul>
            <li v-if="item.data" v-for="(index, item) in rank[3].ranks_data" @click="updatePos(index)" :class="{active: index == tabIndex}"><a href="javascript:void(0);">{{item.name}}</a></li>
    		</ul>
        </scroller>
    	</div>

      <div class="main">
        <scroller lock-x scrollbar-y :use-scroll="true" @scroll="onScroll" v-ref:scroller>
    	  <ul>
        <li class="item-team mod-scroller-con" v-for="(index, item) in rank[3].ranks_data" v-if="item.name == '最近' || item.name == 'TOP20'">
                <table class="mod-title title">
                    <thead>
                        <tr>
                            <td width="50%" colspan="2" class="type"><span>{{item.name}}</span></td>
                            <td width="20%" align="center">转会至</td>
                            <td width="30%" align="center">转会费(欧元)</td>
                        </tr>
                    </thead>
                </table>
                <table class="mod-table">
                    <tbody>
                        <tr v-if="item.data.length" v-for="subItem in item.data">
                            <td width="14%">
                                <span class="logo">
                                    <img width="34" :src="subItem.photo" />
                                    <span class="mask" v-if="night"></span>
                                </span>
                            </td>
                            <td width="36%" class="td2">
                                <div class="name">{{subItem.name}}</div>
                                <div class="old-team">{{subItem.from_team_name}}(原)</div>
                            </td>
                            <td width="20%" align="center" class="td3">{{subItem.to_team_name}}</td>
                            <td width="30%" align="center" class="td4">{{subItem.fee}}
                                <i class="icon" v-if="subItem.memo" data-memo="{{subItem.memo}}"></i>
                            </td>
                        </tr>
                        <tr class="last-tr" v-if="item.is_more">
                            <td colspan="4" align="center">
                                <span class="view-all tap" @click="gotoAll(item)">查看全部 &gt;</span>
                            </td>
                        </tr>
                        <tr v-else>
                            <td colspan="4" align="center" class="no-result">暂无球员变动</td>
                        </tr>
                    </tbody>
                </table>
            </li>
    		<li class="item-team mod-scroller-con" v-for="(index, item) in rank[3].ranks_data" v-if="item.name != '最近' && item.name != 'TOP20'">
    			<table class="mod-title title">
    				<thead>
    					<tr>
    						<td width="40%" colspan="2" class="type">
    							<span class="team-logo">
    								<img v-bind:src="item.logo" width="30" >
    							</span>
    							<span class="team-name">{{item.name}}</span>
    						</td>
    					</tr>
    				</thead>
    			</table>
                <div v-if="item.data.join.length || item.data.leave.length">
    				<table class="mod-table" v-if="item.data.join.length">
    					<thead>
    						<tr>
    							<td width="50%" colspan="2" class="type"><span class="join">加入</span></td>
    							<td width="20%" align="center">原球队</td>
    							<td width="30%" align="center">转会费(欧元)</td>
    						</tr>
    					</thead>
    					<tbody>
    						<tr v-for="(subIndex, subItem) in item.data.join">
    							<td width="14%">
    								<span class="logo">
    									<img v-bind:src="subItem.photo" >
    									<span class="mask" v-if="night"></span>
    								</span>
    							</td>
    							<td width="36%" class="td2">
    								<div class="name">{{subItem.name}}</div>
    							</td>
    							<td width="20%" align="center" class="td3">
    								<div class="old-team">{{subItem.from_team_name}}</div>
    								<div class="league">{{subItem.from_league_name}}</div>
    							</td>
    							<td width="30%" align="center" class="td4">{{subItem.fee}}
                                    <i class="icon" v-if="subItem.memo" data-memo="{{subItem.memo}}"></i>
                                </td>
    						</tr>
    					</tbody>
    				</table>

    				<table class="mod-table" v-if="item.data.leave.length">
    					<thead>
    						<tr>
    							<td width="50%" colspan="2" class="type"><span class="leave">离开</span></td>
    							<td width="20%" align="center">新球队</td>
    							<td width="30%" align="center">转会费(欧元)</td>
    						</tr>
    					</thead>
    					<tbody>
    						<tr v-for="(subIndex, subItem) in item.data.leave">
    							<td width="14%">
    								<span class="logo">
    									<img v-bind:src="subItem.photo" />
    									<span class="mask" v-if="night"></span>
    								</span>
    							</td>
    							<td width="36%" class="td2">
    								<div class="name">{{subItem.name}}</div>
    							</td>
    							<td width="20%" align="center" class="td3">
    								<div class="old-team">{{subItem.to_team_name}}</div>
    								<div class="league">{{subItem.from_league_name}}</div>
    							</td>
    							<td width="30%" align="center" class="td4">{{subItem.fee}}
                                    <i class="icon" v-if="subItem.memo" data-memo="{{subItem.memo}}"></i>
                                </td>
    						</tr>
    					</tbody>
    				</table>
                </div>
				<table class="mod-table" v-else>
					<td colspan="4" align="center" class="no-result">暂无球员变动</td>
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
           go(`kanqiu://soccerleagues/${this.leaguename}/team/${data.team_id}`)
       },
       gotoAll(data){
           go(`${getHost()}/data/footballAllTransfer?league_name=${this.leaguename}&rank_type=${data.rank_type}&page=1&client=${info.client}`);
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
@import "../styles/theme.less";

.transfer-player {
	.td2, .td3, .td4 { line-height: normal;}
	.td4 { word-break: break-all;}

	.logo {
		margin-left: 6px;
		margin-right: 6px;
	}
    .mod-table .old-team, .league {
		font-size: 11px;
		color: @morning_gray2_cor;
	}

	.icon {
		position: relative;
		top: 2px;
		left: 2px;
		display: inline-block;
		width: 13px;
		height: 13px;
		background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/football_tab_transfer_player/icon_468d079.png);
        -webkit-background-size: cover;
        background-size: cover;
	}

	.item-team {
		thead td:nth-of-type(1) {
			padding-left: 0;
		}

		.mod-table thead tr {
			font-weight: bold;
		    color: @morning_gray3_cor;
		    background-color: @morning_white_cor;
		}

		.mod-table tbody tr {
			border-bottom: none;
		}

		.mod-table tbody tr:last-child {
			border-bottom: 1px solid @morning_gray0_cor;
		}

		.mod-table thead td {
			line-height: 22px;
			padding-top: 2px;
			padding-bottom: 2px;
		}

		.mod-table thead td:nth-of-type(1) {
			padding-left: 6px;
		}

		.team-name {
			position: relative;
			top: 2px;
		}

		.team-logo {
			margin-left: 2px;
		}

		.old-team {
			font-size: 13px;
			color: @morning_gray3_cor;
		}

		.last-tr {
			border-top: 1px solid @morning_gray1_cor;
		}
	}

	.cost {
		padding-right: 15px;
		font-weight: normal;
		font-size: 12px;
		color: @morning_gray2_cor;
	}

	.join { color: #2d991b;}
	.leave { color: @morning_red_cor;}

	.no-result { color: @morning_gray2_cor;}
}

.night{
    .transfer-player {
        .mod-table .old-team, .league {
    		color: @night_gray2_cor;
    	}

    	.icon {
    		background-image: url(http://w10.hoopchina.com.cn/hybrid/static/match/widget/football_tab_transfer_player/icon_night_af354b4.png);
    	}

    	.item-team {
    		.mod-table thead tr {
    		    color: @night_gray3_cor;
    		    background-color: @night_white_cor;
    		}

    		.mod-table tbody tr:last-child {
    			border-bottom-color: @night_gray0_cor;
    		}

    		.old-team {
    			color: @night_gray3_cor;
    		}

    		.last-tr {
    			border-top-color: @night_gray1_cor;
    		}
    	}

    	.cost {
    		color: @night_gray2_cor;
    	}

    	.join { color: #1b5c10;}
    	.leave { color:  @night_red_cor;;}

    	.no-result { color: @night_gray2_cor;}
    }
}
</style>
