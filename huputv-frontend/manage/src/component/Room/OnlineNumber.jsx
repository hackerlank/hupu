import React from 'react';
import { Table, Button } from 'antd';
import { Link, History } from 'react-router';
import ECharts from 'react-echarts';
import $ from 'jquery';

import dataService from 'common/dataService';


const apiUrl = {
  online: '/manage/room-online-number'
}

let OnlineNumber = React.createClass({
  mixins: [History],
  getInitialState() {
    return {
      number: [],
      dates: []
    }
  },
  componentWillMount() {
    this.setState({
      room_id: this.props.location.query.room_id,
      match_id: this.props.location.query.match_id
    });

    this.pageUpload();
  },
  /**
   * 分页更新列表
   * @return {[type]} [description]
   */
  pageUpload() {
    let params = {
      room_id: this.props.location.query.room_id,
      match_id: this.props.location.query.match_id
    }
    dataService
      .get(apiUrl.online, params)
      .then((result) => {
        if(result.code === 1){
          let number = [];
          let dates = [];

          result.data.map((value, index) => {
            number.push(value.num);
            dates.push(value.time);
          });

          this.setState({
            number,
            dates
          })

        }else{
          message.error(result.msg);
        }
      })
  },
  render(){
    console.log(this.state);  

    let option = {
        title: {
            text: '在线人数统计'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data:['在线人数']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        toolbox: {
            feature: {
                saveAsImage: {}
            }
        },
        xAxis: {
          type: 'category',
          splitLine: {
            show: false
          },
          boundaryGap: false,
          data: this.state.dates
        },
        yAxis: {
          type: 'value',
          boundaryGap: [0, '100%'],
          splitLine: {
            show: false
          }
        },
        series: [
            {
                name:'在线人数',
                type:'line',
                stack: '总量',
                data: this.state.number
            }
        ]
    };

    return(
      <div>
        <div style={{marginBottom:10}}>
          <Button type="primary" onClick={this.history.goBack} style={{marginBottom:15}}>返回列表</Button>
        </div>
        <ECharts 
          option={option}
          style={{ width: ($(window).width() - 50) + 'px', height: ($(window).height() - 50) + 'px' }}
           />
      </div>
    );

  }

});

export default OnlineNumber;
