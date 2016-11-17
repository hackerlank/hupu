<template>
    <section class="team-rank">
      <scroller lock-x scrollbar-y>
    	<div class="main">
          <nba-vs v-if="rankings && rankings.east && rankings.west" :east.sync="rankings.east" :west.sync="rankings.west"></nba-vs>
        	<table class="mod-title">
        		<thead>
        			<tr>
        				<td width="38%" class="type">东部排行</td>
        				<td width="7%" align="center">胜</td>
        				<td width="7%" align="center">负</td>
        				<td width="14%" align="center">胜场差</td>
                        <td width="10%" align="center">胜率</td>
        				<td width="14%" align="center">近况</td>
        			</tr>
        		</thead>
        	</table>

        	<table class="mod-table">
        		<tbody>
        			<tr @click="goto(item)" v-for="(index, item) in ranking.east" v-if="ranking.east.length">
        				<td width="38%">
        					<span class="num" :class="{red: index+1 <= 8}" v-text="index+1"></span>
        					<span class="logo"><img :src="'http://b1.hoopchina.com.cn/games/teams/nba/1_'+item.tid+'_2x_alpha.png'" width="28" /></span>
                            <span class="name">{{item.name}}</span>
        				</td>
        				<td width="7%" align="center">{{item.win}}</td>
        				<td width="7%" align="center">{{item.lost}}</td>
        				<td width="14%" align="center">{{item.gb}}</td>
                        <td width="10%" align="center">{{item.win_rate}}%</td>
        				<td width="14%" align="center">{{item.strk}}</td>
        			</tr>
        		</tbody>
        	</table>
        	<table class="mod-title title">
        		<thead>
        			<tr>
        				<td width="38%" class="type">西部排行</td>
        				<td width="7%" align="center">胜</td>
        				<td width="7%" align="center">负</td>
        				<td width="14%" align="center">胜场差</td>
                        <td width="10%" align="center">胜率</td>
        				<td width="14%" align="center">近况</td>
        			</tr>
        		</thead>
        	</table>
        	<table class="mod-table west-table">
        		<tbody>
        			<tr @click="goto(item)" v-for="(index, item) in ranking.west" v-if="ranking.west.length">
        				<td width="38%">
        					<span class="num" :class="{red: index+1 <= 8}" v-text="index+1"></span>
        					<span class="logo"><img v-bind:src="'http://b1.hoopchina.com.cn/games/teams/nba/1_'+item.tid+'_2x_alpha.png'" width="28" /></span>
                            <span class="name">{{item.name}}</span>
        				</td>
                        <td width="7%" align="center">{{item.win}}</td>
        				<td width="7%" align="center">{{item.lost}}</td>
        				<td width="14%" align="center">{{item.gb}}</td>
                        <td width="10%" align="center">{{item.win_rate}}%</td>
        				<td width="14%" align="center">{{item.strk}}</td>
        			</tr>
        		</tbody>
        	</table>
    	</div>
      </scroller>
    </section>
</template>

<script>
import NbaVs from './nba_vs'
import { Scroller } from 'components'
import { go } from 'common/router'

export default {
  components: {
    NbaVs,
    Scroller
  },
  props: {
    rankings: Object,
    ranking: Object
  },
  methods: {
    goto(data) {
        go(`kanqiu://nba/nba/team/${data.tid}`)
    }
  }
}
</script>
