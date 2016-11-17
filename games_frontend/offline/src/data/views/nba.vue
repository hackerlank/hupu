<template>
  <div class="basketball mod-rank-wrap">
      <loading :show="isLoading" position="absolute"></loading>
      <basketball-tab :type.sync="pagename" :tab.sync="tab" :lasttab.sync="pagelasttab" @tab-change="onTabClick"></basketball-tab>
      <section class="swiper-container">
         <nba-tab-team-rank :rankings.sync="rankings" :ranking.sync="ranking" v-if="tab =='team' && !isLoading"></nba-tab-team-rank>
         <basketball-tab-player-data :datas.sync="regularData" :night.sync="night" match="nba" v-if="tab =='regular' && regularData.length" :pagetab.sync="pagetab"></basketball-tab-player-data>
         <basketball-tab-daily-data :datas.sync="dailyData" :night.sync="night" match="nba" v-if="tab =='daily' && dailyData.length" :pagetab.sync="pagetab"></basketball-tab-daily-data>
         <nba-tab-hurt-info :datas.sync="injuryData" :night.sync="night" v-if="tab =='injury' && injuryData.length"></nba-tab-hurt-info>
      </section>
 </div>
</template>

<script>
import { getNBATeam, getNBAPlayerInGeneral } from '../common/models'
import { info } from 'common/app'

import { Loading } from 'components'
import {
    basketballTab,
    basketballTabPlayerData,
    basketballTabDailyData,
    nbaTabHurtInfo,
    nbaTabTeamRank
} from '../components'

export default {
  components: {
      Loading,
      basketballTab,
      basketballTabPlayerData,
      basketballTabDailyData,
      nbaTabTeamRank,
      nbaTabHurtInfo
  },
  ready(){
      getNBATeam.execute(({data}) => {
          this.rankings = data.rankings instanceof Array ? {} : data.rankings
          this.ranking = data.ranking
          this.pagelasttab = data.pageLastTab
          this.pagetab = data.pageTab
          this.isLoading = false
      })
  },
  data () {
    return {
	  pagename: "nba",
      pagelasttab: "daily",
      pagetab: "regular",
      rankings: {},
      isLoading: true,
      tab: "",
      ranking: {
          east: [],
          west: []
      },
      night: !!info.night,
      regularData: [],
      dailyData: [],
      injuryData: []
    }
  },
  methods: {
    onTabClick(type){
        if(!this[`${type}Status`] && type != 'team'){
            this.getData(type)
        }
    },
    getData(type){
        this.isLoading = true
        getNBAPlayerInGeneral.bind({type}).execute(res => {
            this[`${type}Data`] = res.data
            this[`${type}Status`] = true
            this.isLoading = false
        })
    }
  },
  route: {
    data ({to, next}) {
        this.tab = this.$route.query.tab || "team"
    }
  }
}
</script>

<style lang="less" scoped>
@import '../styles/common.less';
@import '../styles/basketball.less';
</style>
