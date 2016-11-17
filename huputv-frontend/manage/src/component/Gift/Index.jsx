import React from 'react'
import { Link } from 'react-router'
import { Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, DatePicker, Menu } from 'antd'
import Table from 'rc-table'
import RankPop from './RankPop'
import ConfigPop from './ConfigPop'
import 'rc-table/assets/index.css'
import dataService from 'common/dataService'
import SearchMixin from 'common/mixin/SearchMixin'

const FormItem = Form.Item;


const giftApi = '/manage/gift';
const giftOrderList = '/manage/gift/order';
const giftOrderApi = '/manage/order';
const editApi = '/manage/gift-status/:id';


/**
 * 搜索
 */
const SearchInput = React.createClass({
  mixins: [SearchMixin],
  onChange(field, value) {
    console.log(field, 'change', value);
    this.setState({
      [field]: value
    });
  },
  /**
   * 搜索提交
   * @param  {[type]} event [description]
   * @return {[type]}       [description]
   */
  handleSubmit(event){
    this.props.handlePageUpload({
      start_date: this.format(this.state.startValue),
      end_date: this.format(this.state.endValue)
    });

  }
});


const GiftIndex = React.createClass({
    getInitialState() {
        return {
            start_date: '',
            end_date: '',
            data: [],
            rankData: {cards: []},
            rankVisible: false,
            beanVisible: false,
            renderAction: this.renderAction,
            configVisible: false,
            loading: false
        }
    },

    fetch(params = {}) {
        let self = this;

        dataService.get(giftApi, params).then((result) =>{
            let data = result.data.list;
                self.setState({
                    data: data,
                    rankData: {cards: []}
                });
        })
    },

    componentDidMount() {
        this.fetch();
    },

    ShowGiftConfig() {
        this.setState({configVisible: true});
    },

    handleSubmit(params={}) {
        dataService.post(giftApi, params).then((result) =>{
            this.state.data.push(result.data);
            this.setState({
                data: this.state.data,
                visible: false
            });
        })
    },

    handleCancel2(e) {
        this.setState({
            rankVisible: false
        });
    },

    handleCancelConfig() {
       this.setState({
            configVisible: false
        }); 
    },

    handleEnable: function(index, ground) {
        this.editGround(index, ground);
    },

    handleEdit: function(id) {
        this.props.history.replaceState(null, '/gift/' + id);
        
    },

    editGround: function(index, ground) {

        let id = this.state.data[index].id;
        let status = ground == '下架' ? 0 : 1;
        let self = this;

        dataService.post(`/manage/gift-stat/${id}`,{status}).then((result) =>{
            if(result.code == 1){
                message.success(`${ground}成功`);
                self.setState({
                    data: result.data.list,
                });
            }
        })
    },

    renderAction: function(o, row, index) {
        let ground = this.state.data[index].enable == '已上架' ? '下架' : '上架';
        return (
            <span>
                <Button type="primary" style={{ marginRight: 10 }} onClick={this.handleEnable.bind(this, index, ground)}>{ground}</Button>
                <Button type="primary" style={{ marginRight: 10 }} onClick={this.handleEdit.bind(this, row.id)}>编辑</Button>
                <Link to={`gift/gift-detail/${row.id}`}  className="ant-btn">送物明细</Link>
            </span>
        );
    },

    renderSort: function(o, row, index) {
        return (
            <span>{index+1}</span>
        );
    },

    renderCover: function(o, row, index) {
        let coverSrc = this.state.data[index].cover;
        return (
            <span><img src={coverSrc} width="70" /></span>
        );
    },
    /**
     * 更新
     * @return {[type]} [description]
     */
    handlePageUpload(params) {
        this.setState({
            ...params
        });

        this.fetch(params);
    },
    render() {
        const columns = [
            { title: '礼物ID', dataIndex: 'id', key: 'id' },
            { title: '排序位置', dataIndex: 'sort', key: 'sort', render: this.renderSort },
            { title: '礼物图片', dataIndex: 'cover', key: 'cover', render: this.renderCover },
            { title: '礼物名称', dataIndex: 'name', key: 'name' },
            { title: '礼物类型', dataIndex: 'money_type', key: 'money_type' },
            { title: '礼物价值', dataIndex: 'price', key: 'price' },
            { title: '礼物描述', dataIndex: 'description', key: 'description' },
            { title: '礼物位置', dataIndex: 'position', key: 'position' },
            { title: '礼物状态', dataIndex: 'enable', key: 'enable' },
            { title: '赠送个数', dataIndex: 'number', key: 'number' },
            { title: '赠送总额', dataIndex: 'total_cost', key: 'allValue' },
            { title: '操作', dataIndex: '', key: 'operation', render: this.state.renderAction }];

        return (
          <div className="gift-list">
            <div style={{marginBottom:15 }}>
              <Link className="ant-btn ant-btn-primary" style={{marginRight:15}} to='gift/add'>添加礼物</Link>
              <Button type="primary" onClick={this.ShowGiftConfig} style={{marginRight:15}} loading={this.state.loading}>礼物设置</Button>
              <Link className="ant-btn ant-btn-primary" to='bean' style={{marginRight:15 }}>金豆购买阶梯管理</Link>
              <Link to='gift/history' className="ant-btn" style={{marginRight:15 }}>礼物记录</Link>
              <Link to='gift/top' className="ant-btn">查看送礼用户排行</Link>
            </div>
            <div style={{marginBottom: 10}}>
              <SearchInput handlePageUpload={this.handlePageUpload} />
            </div>

            <Table 
                columns={columns} 
                data={this.state.data} 
                pagination={false} 
                rowKey={record => record.id}
            />

            <RankPop
                visible = {this.state.rankVisible}
                rankData = {this.state.rankData}
                handleRank = {this.handleRank}
                handleCancel = {this.handleCancel2}
            />

            <ConfigPop 
                visible = {this.state.configVisible}
                handleCancel = {this.handleCancelConfig}
            />

          </div>
        );
    }
});

GiftIndex.key = 'gift';

export default GiftIndex;
