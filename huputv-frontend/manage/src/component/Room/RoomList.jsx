import React, {Component} from 'react'
import { Link } from 'react-router'
import './RoomList.less'
import RecommendPop from './RecommendPop'
import Forbid from './Forbid'
import Cover from './Cover'
import VideoParam from './VideoParam'
import NameChange from './NameChange'
import TypeChange from './TypeChange'
import OnlineChange from './OnlineChange'
import VideoJJ from './VideoJJ'
import ShowGift from './ShowGift'
import _ from 'common/underscore'
import $ from 'jquery'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Button, Select, Table, Popconfirm, message, Modal } from 'antd'

const FormItem = Form.Item;
const Option = Select.Option;
const roomType = [];

const Api = {
    list: '/manage/room',
    type: '/manage/catalog',
    roomInfoName: '/manage/room/:id',
    recommend: '/manage/room-recommend',
    ban: '/manage/room/ban',
    close: '/manage/room/close',
    giftOrderList: '/manage/gift/order',
    cancelRecommend: '/manage/room-recommend/:id'
};

class Room extends Component {
    constructor(props) {
        super(props);

        this.state = {
            data: [],
            count: 0,
            pageSize: 0,
            roomType: [],
            typeNum: '',
            changeType:'',
            RecommendData: {cards: []},
            ForbidVisible: false,
            coverVisible: false,
            forbidID: 0,
            RecommendVisible: false,
            nameVisible: false,
            typeVisible: false,
            onlineVisible: false,
            paramVisible: false,
            flashVisible: false,
            room_name: '',
            cover: '',
            RTMP_URL: '',
            RTMPHd_URL: '',
            RTMPSd_URL: '',
            Stream_Name: '',
            loading: false,
            typeId: 0,
            roomId: 0,
            status: 0,
            search: '',
            searchResult: '',
            streamInfo: {},
            page: 1,
            author: 1,
            appkey: "",
            referer: "",
            source: 'hupu',
            type: 0,
            userID: "",
            userPwd: "",
            giftVisible: false,
            giftData: []
        };
    }

    fetch() {
        let dataList = [];


        this.fetchList();

        dataService.get(Api.type, {display: 1}).then((res) =>{
            this.setState({
                roomType: res.data.list,
                loading: false
            })
        })
    }

    fetchList(page = 1) {
        let data = this.props.form.getFieldsValue();
        this.setState({ loading: true, page: page });

        data.search = this.state.searchResult;
        data.room_type = this.state.typeNum;
        data.page = page;

        this.setState({ loading: true });

        dataService.get(Api.list, data).then((res) =>{
            this.setState({
                data: res.data.list,
                count: res.data.count,
                pageSize: res.data.limit,
                loading: false
            })
        })
    }

    componentDidMount() {
        this.fetch();
    }

    showRecommend() {

        this.setState({ loading: true });

        dataService.get(Api.recommend, {page: 1}).then((res) =>{
            if(res.count != 0){
                var RecommendData = res.list.reduce(function(result, item, index) {
                    if(item.recommend != 0) {
                        result.push(
                            {
                                "sort": item.recommend,
                                "roomId": item.id,
                                "room_name": item.room_name,
                                "zhuboName": item.anchor_nickname,
                                "roomType": item.room_type_text,
                                "tag": item.recommend_tag
                            }
                        )
                    }
                    return result;
                }, []);

                RecommendData.sort(function(item1, item2) {
                    return (item1.sort - item2.sort);
                })

                RecommendData = {cards: RecommendData};

                this.setState({
                    RecommendVisible: true,
                    loading: false,
                    RecommendData: RecommendData
                })

            }else{
                message.warn('目前没有推荐的直播间');
                this.setState({
                    loading: false
                })
            }
        })

    }

    handleRecommend(index) {
        let roomId = this.state.data[index].id;
        this.setState({ loading: true });

        dataService.post(Api.recommend, {room_id: roomId}).then((res) =>{
            if(res.code == 1){
                this.state.data[index].recommend = res.data.sort;

                this.setState({
                    data: this.state.data,
                    loading: false
                })
                message.success("推荐成功");
            }
        })
    }

    cancelRecommend(index) {
        let roomId = this.state.data[index].id,
            api = Api.cancelRecommend.replace(':id', roomId);

        this.setState({ loading: true });
        dataService.delete(api).then((res) => {
            if(res.code == 1){
                this.state.data[index].recommend = 0;
                this.setState({
                    data: this.state.data,
                    loading: false
                })
                message.success("取消推荐成功");
            }
        })

    }

    handleCover(data, callback) {
        let api = Api.roomInfoName.replace(':id', data.room_id);
        dataService.post(api, data).then((res) =>{
            if(res.code == 1){
                message.success('修改封面成功！');
                this.state.data.forEach(function(item) {
                    if(item.id == data.room_id) {
                        item.cover = data.url;
                    }
                })

                this.setState({
                    coverVisible: false
                })
            }
        })
    }

    handleCancel(e) {
        this.setState({
            RecommendVisible: false
        });
    }

    handleCancel2(e) {
        this.setState({
            ForbidVisible: false
        });
    }

    handleCancel3(e) {
        this.setState({
            coverVisible: false
        });
    }

    handleCancel4(e) {
        this.setState({
            paramVisible: false
        });
    }

    handleCancel5(e){
        this.setState({
            flashVisible: false
        })
    }

    handleCancelGift() {
        this.setState({
            giftVisible: false
        })
    }

    release(index) {
        let id = this.state.data[index].id;
        let status = this.state.data[index].status == 0 ? 1 : 0;

        let data = {};

        data.room_id = id;
        data.status = status;
        this.setState({ loading: true });

        dataService.get(Api.ban, data).then((res) =>{
            if(res.code == 1) {
                this.state.data.forEach(function(item) {
                    if(item.id == data.room_id) {
                        item.status = data.status
                    }
                })

                message.success("解禁成功");

                this.setState({
                    ForbidVisible: false,
                    loading: false
                })

            }

        })

    }

    showForbid(index) {
        let id = this.state.data[index].id;
        let status = this.state.data[index].status;

        this.setState({
            ForbidVisible: true,
            forbidID: id,
            status: status
        })
    }

    handleForid(data, form){
        dataService.get(Api.ban, data).then((res) =>{
            if(res.code == 1) {
                this.state.data.forEach(function(item) {
                    if(item.id == data.room_id) {
                        item.status = data.status;
                        item['ban_duration'] = data.duration;
                    }
                })

                this.setState({
                    ForbidVisible: false
                })

                message.success("封禁成功");
            }

        })
    }

    filterType(id, e){

        let data = this.props.form.getFieldsValue();
        this.setState({ loading: true, typeNum: id });

        data.search = this.state.searchResult;
        data.room_type = id;
        data.page = 1;

        dataService.get(Api.list, data).then((res) =>{
            this.setState({
                data: res.data.list,
                count: res.data.count,
                loading: false
            });

        })


    }

    showCover(index){
        this.setState({
            cover: this.state.data[index].cover,
            coverID: this.state.data[index].id,
            coverVisible: true
        })
    }

    showParam(index){
        let params = this.state.data[index].stream;

        if(params.streamName){
            this.setState({
                RTMP_URL: params.play.rtmp,
                RTMPHd_URL: params.play.rtmpHd,
                RTMPSd_URL: params.play.rtmpSd,
                Stream_Name: params.streamName,
                paramVisible: true
            });
        }else{
            message.warn('视频参数为空');
        }
    }

    showVideojj(index){
        let params = this.state.data[index].stream;

        if(params.streamName){
            this.setState({
                author: 1,
                appkey: "",
                referer: "",
                source: 'hupu',
                type: 0,
                userID: "",
                userPwd: "",
                streamInfo: params.play,
                flashVisible: true
            });
        }else{
            message.warn('视频参数为空');
        }
    }

    closeLive(index) {
        let roomId = this.state.data[index].id;
        this.setState({ loading: true });

        dataService.get(Api.close, {room_id: roomId}).then((res) =>{
            if(res.code == 1){
                if(this.state.data[index].is_live == 1){
                    this.state.data[index].is_live = 0;
                    this.state.data[index].is_live_text = '休息'
                }else{
                    this.state.data[index].is_live = 1;
                    this.state.data[index].is_live_text = '直播中'
                }

                this.setState({
                    data: this.state.data,
                    loading: false
                })
            }
        })
    }

    roomShow(index) {
        let roomId = this.state.data[index].id;
        let api = Api.roomInfoName.replace(':id', roomId);

        this.setState({ loading: true });

        dataService.post(api, {key: 'is_show', value: 1}).then((res) =>{
            if(res.code == 1){
                this.state.data[index].is_show = 1;
                this.setState({
                    data: this.state.data,
                    loading: false
                })
                message.success("取消隐藏成功");
            }
        })
    }

    roomHide(index) {
        let roomId = this.state.data[index].id;
        let api = Api.roomInfoName.replace(':id', roomId);

        this.setState({ loading: true });

        dataService.post(api, {key: 'is_show', value: 0}).then((res) => {
            if(res.code == 1){
                this.state.data[index].is_show = 0;
                this.setState({
                    data: this.state.data,
                    loading: false
                })
                message.success("房间隐藏成功");
            }
        })

    }

    showGift(roomId) {
        this.setState({
            loading: true
        });

        dataService.get(Api.giftOrderList, {room_id: roomId}).then((res) =>{
            let arr = [];
            if(res.code == 1) {

                if(res.data.length == 0){
                    message.warn('暂时没有上架礼物可以设置');
                    this.setState({
                        loading: false
                    })
                    return;
                }

                if(res.data.giftOrder.length > 6) {
                    arr = res.data.giftOrder.slice(0, 6);
                }else{
                    arr = res.data.giftOrder;
                }

                this.setState({
                    giftVisible: true,
                    loading: false,
                    giftData: arr,
                    roomIdForGift: roomId
                })

            }else{
                message.error(res.msg);
            }

        })
    }

    handleSeachChange(e) {
        this.setState({
            search: e.target.value
        })
    }

    handleSearch() {
        let data = this.props.form.getFieldsValue();
        this.setState({ loading: true });

        data.search = this.state.search;
        data.room_type = this.state.typeNum;
        data.page = 1;

        dataService.get(Api.list, data).then((res) =>{
            this.setState({
                data: res.data.list,
                count: res.data.count,
                searchResult: this.state.search,
                loading: false
            })
        })
    }

    renderName(o, row, index) {
        return ( <span> {o} <Button size = "small" onClick={this.changeName.bind(this, index)}> 修改 </Button> </span>)
    }

    changeName(index) {
        this.setState({
            nameVisible: true,
            room_name: this.state.data[index].room_name,
            roomId: this.state.data[index].id
        })
    }

    handleNameOk(name, roomId) {
        let api = Api.roomInfoName.replace(':id', roomId);
        dataService.post(api, { key: 'room_name',value: name }).then((res) =>{
            if(res.code == 1){
                this.state.data.map(function(item) {
                    if(item.id == roomId) {
                        item.name = name;
                    }
                })
                message.success('修改直播间名称成功！');
                this.setState({
                    nameVisible: false
                })
            }else{
                message.error(res.msg);
            }
        })
    }

    handleNameCancel() {
        this.setState({
            nameVisible: false
        })
    }

    renderType(text, record, index) {
        return (
            <span>
                <span>{text}</span><Button style={{ marginLeft: 10 }} onClick={this.typeChange.bind(this, record)}>修改</Button>
            </span>
        );
    }

    typeChange(record) {
        this.setState({
            typeVisible: true,
            typeId: record.room_type,
            roomId: record.id,
            typeName: record.category
        })
    }

    handleTypeOk(){
        this.fetchList(this.state.current);
        this.handleTypeCancel();
        // let api = Api.roomInfoName.replace(':id', roomId);
        // dataService.post(api, { key: 'room_type',value: typeId }).then((res) =>{
        //     if(res.code == 1){
        //         let typeName = '';

        //         this.state.roomType.forEach(function(item) {
        //             if(item.sid == typeId){
        //                 typeName = item.sname;
        //             }
        //         })

        //         this.state.data.forEach(function(item) {
        //             if(item.id == roomId) {
        //                 item['room_type_text'] = typeName;
        //             }
        //         })

        //         message.success('修改直播间分类成功！');

        //         this.setState({
        //             data: this.state.data,
        //             typeVisible: false
        //         })
        //     }
        // })
    }

    handleTypeCancel() {
        this.setState({
            typeVisible: false
        })
    }

    addOnlineNum(index) {
        this.setState({
            onlineVisible: true,
            num: this.state.data[index].online_plus,
            roomId: this.state.data[index].id
        })
    }

    handleOnlineOk(num, roomId) {
        let api = Api.roomInfoName.replace(':id', roomId);
        dataService.post(api, { key: 'online_plus',value: num }).then((res) =>{
            if(res.code == 1){
                this.state.data.map(function(item) {
                    if(item.id == roomId) {
                        item['online_plus'] = num;

                    }
                })
                message.success('修改在线人数成功！');
                this.setState({
                    onlineVisible: false
                })
            }
        })
    }

    handleOnlineCancel() {
        this.setState({
            onlineVisible: false
        })
    }

    handleChangePage(current) {
        this.setState({
            current: current
        })
        this.fetchList(current);
    }

    renderOnline(o, row, index) {
        return(
            <span onClick={this.addOnlineNum.bind(this,index)}>{row.online} <span style={{color: 'red'}}>+{row.online_plus}</span></span>
        )
    }

    renderMessage(o, row, index) {
        return(
            <Link to={`/room/hotline/${row.id}`} query={{room_id: `${row.id}`, match_id: `${row.match_id}`}} className="ant-btn">{row.message}</Link>
        )
    }

    renderAction(o, row, index) {
        let renderButton = function() {
            if(row.is_live == 1) {
                if(row.recommend == 0) {
                   return (
                        <span>
                            <span className = "ant-divider"></span>
                            <Button className = "ant-btn-primary" onClick={this.handleRecommend.bind(this, index)}>推荐</Button>
                        </span>
                    )
                }else{
                    return (
                        <span>
                            <span className = "ant-divider"></span>
                            <Button className = "ant-btn" onClick={this.cancelRecommend.bind(this, index)}>取消推荐</Button>
                        </span>
                    )
                }
            }
        }.bind(this);

        let showButton = function() {
            if(row.is_show == 0) {
               return (
                    <span>
                        <span className = "ant-divider"></span>
                        <Popconfirm title="确定要显示房间吗？" onConfirm={this.roomShow.bind(this, index)}>
                            <Button className = "ant-btn-primary">显示房间</Button>
                        </Popconfirm>
                    </span>
                )
            }else{
                return (
                    <span>
                        <span className = "ant-divider"></span>
                        <Popconfirm title="确定要显示房间吗？" onConfirm={this.roomHide.bind(this, index)}>
                            <Button className = "ant-btn">隐藏房间</Button>
                        </Popconfirm>
                    </span>
                )
            }
        }.bind(this);

        return (
            <span>
                {
                    row.status == 0 ? <Button className = "ant-btn-primary" onClick={this.showForbid.bind(this, index)} > 封禁 </Button> :
                                    <Popconfirm title="确定要解禁吗？" onConfirm={this.release.bind(this, index)} >
                                            <Button> 解禁</Button>
                                    </Popconfirm>
                }
                <span className = "ant-divider"></span>
                <Button className = "ant-btn-primary" onClick={this.showCover.bind(this,index)} > 修改封面 </Button>
                <span className = "ant-divider"></span>
                <Button className = "ant-btn-primary" onClick={this.showParam.bind(this,index)} > 视频参数 </Button>
                <span className = "ant-divider"></span>
                <Link to={`/room/detail/${row.id}`} className="ant-btn ant-btn-primary">直播间明细</Link>

                {
                    renderButton()
                }
                {
                    row.is_live == 1 ?
                                        <span><span className = "ant-divider"></span>
                                        <Popconfirm title="确定要关闭直播吗？" onConfirm={this.closeLive.bind(this, index)}>
                                            <Button className = "ant-btn-primary"> 关闭直播</Button>
                                        </Popconfirm></span> : ''
                }
                {
                    showButton()
                }
                <span className = "ant-divider"></span>
                <Button className = "ant-btn-primary" onClick={this.showGift.bind(this,row.id)} > 礼物管理 </Button>

            </span>
        );
    }

    render() {
        let self = this;
        const { getFieldProps } = this.props.form;
        const columns = [
            { title: '排序', dataIndex: 'sort', key: 'sort',
                render(text, record, index) {
                    return <span>{index}</span>;
                }
            },
            { title: '直播间ID', dataIndex: 'id', key: 'id' },
            { title: '直播间名称', dataIndex: 'room_name', key: 'room_name',
                render: this.renderName.bind(this)
            },
            { title: '主播名称', dataIndex: 'anchor_nickname', key: 'anchor_nickname' },
            { title: '所属分类', dataIndex: 'category', key: 'category',
                render: this.renderType.bind(this)
            },
            { title: '关注人数', dataIndex: 'following', key: 'following' },
            { title: '直播状态', dataIndex: 'is_live_text', key: 'is_live_text' },
            { title: '在线人数', dataIndex: 'online_num', key: 'online_num',
                render: this.renderOnline.bind(this)
            },
            { title: '礼物收益', dataIndex: 'income', key: 'income' },
            { title: '热线条数', dataIndex: 'message', key: 'message',
                render: this.renderMessage.bind(this)
            },
            { title: '直播间状态', dataIndex: 'room_status', key: 'room_status',
                render: function(o, row, index) {
                    let status = row.status == 0 ? '正常' : '封禁<br>'+ row["ban_duration"]+ '小时';
                    return (
                        <div style={{textAlign:'center'}} dangerouslySetInnerHTML={{__html: status}}>

                        </div>
                    )
                }
            },
            { title: '列表展示', dataIndex: 'is_show', key: 'is_show',
                render: function(o, row, index) {
                    let show_str = row.is_show == 0 ? '隐藏' : '显示<br>';
                    return (
                        <div style={{textAlign:'center'}} dangerouslySetInnerHTML={{__html: show_str}}>

                        </div>
                    )
                }
            },
            { title: '操作', dataIndex: 'operation', key: 'operation',
                render: this.renderAction.bind(this)
            }];

        let pagination = {
            total: this.state.count,
            pageSize: this.state.pageSize,
            onChange(current) {
                self.handleChangePage(current);
            }
        };

        return (
            <div>
                <div>
                    <h3 className = "page-title" > 直播间列表 </h3>
                    <span className = "page-link">
                        <Link to = 'room/huiti/main'> 慧体直播间列表 </Link>
                    </span>
                </div>
                <div className = "form-room">
                    <div className = "form-search"></div>
                    <Form horizontal className = "advanced-search-form form-search" form={this.props.form} >
                        <Row>
                        <Col span = "6" >
                            <FormItem label = "关键字搜索："
                                labelCol = {{ span: 7 }}
                                wrapperCol = {{ span: 14 }} >
                                <Input placeholder = "输入直播间名字或ID"
                                    {...getFieldProps('search')} value={this.state.search} onChange={this.handleSeachChange.bind(this)} />
                            </FormItem>
                        </Col>
                        <Col span = "6" >
                            <FormItem label = "选择直播间状态："
                                labelCol = {{ span: 10 }}
                                wrapperCol = {{ span: 12 }} >
                                <Select
                                    style = {{ width: 120 }}
                                    {...getFieldProps('status', { initialValue: '' })} >
                                    <Option value = ""> 全部 </Option>
                                    <Option value = "0"> 正常 </Option>
                                    <Option value = "1"> 封禁 </Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span = "5">
                            <FormItem label = "选择直播状态："
                                labelCol = {{ span: 10 }}
                                wrapperCol = {{ span: 12 }} >
                                <Select
                                    style = {{ width: 120 }}
                                    {...getFieldProps('is_live', { initialValue: '' })} >
                                    <Option value = ""> 全部 </Option>
                                    <Option value = "1"> 直播中 </Option>
                                    <Option value = "0"> 休息 </Option>
                                </Select>
                            </FormItem>
                        </Col>
                        <Col span = "5">
                            <Button className = "btn-room"
                                type = "primary"
                                htmlType = "submit"
                                onClick={ this.handleSearch.bind(this) }> 搜索
                            </Button>
                        </Col>
                        </Row>
                    </Form>
                    <div className = "sort-room">
                            {
                                this.state.roomType.map((item, key) => {
                                    if(item.sid == this.state.typeNum) {
                                        return <Button className="ant-btn ant-btn-primary" onClick={this.filterType.bind(this, item.sid)} style={{marginRight: 5,marginBottom: 5}}> {item.sname} </Button>
                                    }else{
                                        return <Button className="ant-btn" onClick={this.filterType.bind(this, item.sid)} style={{marginRight: 5,marginBottom: 5}}> {item.sname} </Button>
                                    }
                                })
                            }
                            <Button className="ant-btn-primary" onClick={this.showRecommend.bind(this)} style={{marginBottom: 5}}> 推荐管理 </Button>
                    </div>
                    <Table
                        rowKey={record => record.id}
                        columns = {columns}
                        dataSource = {this.state.data}
                        pagination = {pagination}
                        loading={this.state.loading}
                    />

                </div>


                <NameChange
                    visible= {this.state.nameVisible}
                    name = {this.state.room_name}
                    roomId = {this.state.roomId}
                    handleNameOk = {this.handleNameOk.bind(this)}
                    handleNameCancel = {this.handleNameCancel.bind(this)}
                />

                <OnlineChange
                    visible= {this.state.onlineVisible}
                    num = {this.state.num}
                    roomId = {this.state.roomId}
                    handleOnlineOk = {this.handleOnlineOk.bind(this)}
                    handleOnlineCancel = {this.handleOnlineCancel.bind(this)}
                />

                <TypeChange
                    visible= {this.state.typeVisible}
                    typeId = {this.state.typeId}
                    roomId = {this.state.roomId}
                    typeList = {this.state.roomType}
                    typeName = {this.state.typeName}
                    handleTypeOk = {this.handleTypeOk.bind(this)}
                    handleTypeCancel = {this.handleTypeCancel.bind(this)}
                />

                <RecommendPop
                  visible = {this.state.RecommendVisible}
                  RecommendData = {this.state.RecommendData}
                  handleCancel = {this.handleCancel.bind(this)}
                />

                <Forbid
                  visible = {this.state.ForbidVisible}
                  forbidID = {this.state.forbidID}
                  status = {this.state.status}
                  handleForid = {this.handleForid.bind(this)}
                  handleCancel = {this.handleCancel2.bind(this)}
                />

                <Cover
                    visible = {this.state.coverVisible}
                    cover = {this.state.cover}
                    coverID = {this.state.coverID}
                    handleCover = {this.handleCover.bind(this)}
                    data = {this.state.data}
                    handleCancel = {this.handleCancel3.bind(this)}
                />

                <VideoParam
                    visible = {this.state.paramVisible}
                    RTMP = {this.state.RTMP_URL}
                    RTMPHd = {this.state.RTMPHd_URL}
                    RTMPSd = {this.state.RTMPSd_URL}
                    Stream = {this.state.Stream_Name}
                    handleCancel = {this.handleCancel4.bind(this)}
                />

                <VideoJJ
                    visible = {this.state.flashVisible}
                    author = {this.state.author}
                    appkey = {this.state.appkey}
                    referer = {this.state.referer}
                    source = {this.state.source}
                    type = {this.state.type}
                    userID = {this.state.userID}
                    userPwd = {this.state.userPwd}
                    streamInfo = {this.state.streamInfo}
                    handleCancel = {this.handleCancel5.bind(this)}
                />

                <ShowGift
                    visible = {this.state.giftVisible}
                    giftData = {this.state.giftData}
                    handleCancel = {this.handleCancelGift.bind(this)}
                    roomId = {this.state.roomIdForGift}
                />

            </div>

        );
    }
};





Room = Form.create()(Room);

Room.key = 'room';
export default Room;
