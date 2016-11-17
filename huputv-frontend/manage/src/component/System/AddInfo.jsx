import React, {Component} from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import dataService from 'common/dataService';
import RoomPop from './RoomPop';
import CatalogPop from './CatalogPop';
import RoomResult from './RoomResult';
import CatalogResult from './CatalogResult';
import _ from 'common/underscore';

const FormItem = Form.Item;
const RadioGroup = Radio.Group;

const Api = {
    room: '/manage/room',
    message: '/manage/message',
    catalog: '/manage/catalog'
}

class AddInfo extends Component {
    constructor(props) {
        super(props);

        this.state = {
            roomVisible: false,
            catalogVisible: false,
            range: 'room',
            roomData: [],
            roomDataCount: 0,
            roomDataPage: 1,
            catalogData: [],
            roomDataResult: [],
            catalogDataResult: [],
            loading: false
        };
    }

    componentDidMount() {
       
    }

    handleSubmit() {
        this.props.form.validateFieldsAndScroll((errors, values) => {

            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            let data = this.props.form.getFieldsValue();
            
            console.log(this.state.roomDataResult);
            if(this.state.range == 'room') {
                var detail = this.state.roomDataResult.map(function(item) {
                    return item.id;
                })    
            }else if(this.state.range == 'type'){
               var detail = this.state.catalogDataResult.map(function(item) {
                    return item.id;
                })   
            }else{
                var detail = [];
            }

            data.detail = detail;


            if(this.state.range != 'total' && data.detail.length == 0 ){
                message.error('请选择发送分类');
                return;
            }

            dataService.post(Api.message, data).then((res) =>{
                if(res.code == 1) {
                    message.success("系统消息发送成功");
                    this.props.history.replaceState(null, '/other/system');
                }
            })

        });
    }

    handleReset(e) {
        e.preventDefault();
        this.props.form.resetFields();
    }

    onRangeChange(e) {
        this.setState({
            range: e.target.value,
        });
    }

    fetchRoomData(page=1) {
        this.setState({
            loading: true
        })

        dataService.get(Api.room, {page, limit: 10}).then((res) =>{
            let roomList = [];

            res.data.list.forEach(function(item, i) {
                roomList.push({
                    key: i,
                    id: item.id,
                    uid: item.uid,
                    roomName: item.room_name,
                    zhuboName: item.anchor_nickname
                });
            })

            this.setState({
                roomDataCount: res.data.count,
                roomData: roomList,
                roomVisible: true,
                loading: false
            })
        })
    }

    fetchCatalogData(page=1) {
        this.setState({
            loading: true
        })

        dataService.get(Api.catalog, {page, limit: 10}).then((res) =>{
            let catalogList = [];

            res.data.list.forEach(function(item, i) {
                catalogList.push({
                    key: i,
                    id: item.sid,
                    catalogName: item.sname,
                });
            })

            this.setState({
                catalogDataCount: res.data.count,
                catalogData: catalogList,
                catalogVisible: true,
                loading: false
            })
        })
        
    }

    handleSearch(resultArr, count) {
        let roomList = [],
            list = resultArr;

        for (let i = 0, len = list.length; i < len; i++) {
            roomList.push({
                key: i,
                id: list[i].id,
                uid: list[i].uid,
                roomName: list[i].room_name,
                zhuboName: list[i].anchor_nickname,
            });
        }

        this.setState({
            roomData: roomList,
            roomDataCount: count,
        })
    }

    handleRoomLine(row) {
        let roomResultLine = this.state.roomDataResult;

        console.log(row);

        if( roomResultLine.length == 0 ) {
            for(var i = 0; i < row.length; i++) {
                roomResultLine.push({
                    'id': `${row[i].id}`,
                    'uid': `${row[i].uid}`,
                    'roomInfo': `${row[i].roomName} (${row[i].zhuboName})`
                });  
            }


        }else{
            for(var i = 0; i < row.length; i++) {
                if( _.findWhere(roomResultLine, {id: row[i]['id']}) == undefined ) {
                    roomResultLine.push({
                        'id': `${row[i].id}`,
                        'uid': `${row[i].uid}`,
                        'roomInfo': `${row[i].roomName} (${row[i].zhuboName})`
                    });  
                }
            }
        }
        

        this.setState({
            roomDataResult: roomResultLine
        })
        this.handleCancelRoom();
    }

    handleCatalogLine(row) {
        let catalogResultLine = this.state.catalogDataResult;

        if( catalogResultLine.length == 0 ) {
            for(var i = 0; i < row.length; i++) {
                catalogResultLine.push({
                    'id': `${row[i].id}`,
                    'catalogName': `${row[i].catalogName}`
                }); 
            }
        }else{
            for(var i = 0; i < row.length; i++) {
                if( _.findWhere(catalogResultLine, {id: row[i]['id']}) == undefined ) {
                    catalogResultLine.push({
                        'id': `${row[i].id}`,
                        'catalogName': `${row[i].catalogName}`
                    }); 
                }
            }
        }
        // for(var i = 0; i < row.length; i++) {
        //     catalogResultLine.push({
        //         'id': `${row[i].id}`,
        //         'catalogName': `${row[i].catalogName}`
        //     });    
        // }
        
        this.setState({
            catalogDataResult: catalogResultLine
        })
        this.handleCancelCatalog();
    }    

    handleCancelRoom() {
        this.setState({
            loading: false,
            roomVisible: false
        })
    }

    handleCancelCatalog() {
        this.setState({
            loading: false,
            catalogVisible: false
        })
    }

    render() {
        const { getFieldProps } = this.props.form;

        const rangeProps = getFieldProps('range', {
            initialValue: this.state.range,
            onChange: this.onRangeChange.bind(this)
        });

        const contentProps = getFieldProps('content', {
            rules: [
                { required: true, message: '请输入消息内容' }
            ]
        });

        let rangeItem;
        if(this.state.range == 'room') {
            rangeItem = 
                    <div>
                        <FormItem
                            label="发送分类"
                            labelCol={{ span: 6 }}
                            wrapperCol={{ span: 18 }} >
                            <div>
                                <span>显示直播间名称和主播名称</span>
                                <Button type="primary" size="small" style={{marginLeft:10}} onClick={this.fetchRoomData.bind(this, 1)} loading={this.state.loading}>选择</Button>
                            </div>
                        </FormItem>
                        <RoomResult
                            roomDataResult = {this.state.roomDataResult}
                        />
                    </div>
        }else if(this.state.range == 'type') {
            rangeItem = 
                    <div>    
                        <FormItem
                            label="发送分类"
                            labelCol={{ span: 6 }}
                            wrapperCol={{ span: 18 }} >
                            <div>
                                <span>显示分类名称</span>
                                <Button type="primary" size="small" style={{marginLeft:10}} onClick={this.fetchCatalogData.bind(this, 1)} loading={this.state.loading}>选择</Button>
                            </div>
                        </FormItem>
                        <CatalogResult
                            catalogDataResult = {this.state.catalogDataResult}
                        />
                    </div>
        }else{
            rangeItem = null;
        }

        return (
            <div style={{width:'40%',marginTop:'30px'}}>
                <Form horizontal form={this.props.form} >
                    <FormItem
                          label="发送范围"
                          labelCol={{ span: 6 }}
                          wrapperCol={{ span: 18 }} >
                          <RadioGroup {...rangeProps} >
                            <Radio value="room">指定直播间</Radio>
                            <Radio value="type">指定分类</Radio>
                            <Radio value="total">全部直播间</Radio>
                          </RadioGroup>
                    </FormItem>

                    {rangeItem}

                    <FormItem
                        id="control-textarea"
                        label="消息内容"
                        labelCol={{ span: 6 }}
                        wrapperCol={{ span: 14 }}>
                        <Input type="textarea" id="control-textarea" rows="3" {...contentProps} />
                    </FormItem>

                    <FormItem
                        id="control-input"
                        label="链接地址"
                        labelCol={{ span: 6 }}
                        wrapperCol={{ span: 14 }}>
                        <Input id="control-input" {...getFieldProps('url')} />
                    </FormItem>

                    <FormItem wrapperCol={{ span: 12 }}>
                        <Button type="primary" onClick={this.handleSubmit.bind(this)}>确定</Button>
                        &nbsp;&nbsp;&nbsp;
                        <Button type="ghost" onClick={this.handleReset.bind(this)}>重置</Button>
                    </FormItem>
                </Form>

                <RoomPop
                    visible = {this.state.roomVisible}
                    roomData = {this.state.roomData}
                    count = {this.state.roomDataCount}
                    loading = {this.state.loading}
                    handleChange = {this.fetchRoomData.bind(this)}
                    handleCancel = {this.handleCancelRoom.bind(this)}
                    handleRoomLine = {this.handleRoomLine.bind(this)}
                    handleSearch = {this.handleSearch.bind(this)}
                />
                <CatalogPop
                    visible = {this.state.catalogVisible}
                    catalogData = {this.state.catalogData}
                    count = {this.state.catalogDataCount}
                    loading = {this.state.loading}
                    handleChange = {this.fetchCatalogData.bind(this)}
                    handleCancel = {this.handleCancelCatalog.bind(this)}
                    handleCatalogLine = {this.handleCatalogLine.bind(this)}
                />
            </div>
        )   
    }
}

AddInfo = Form.create()(AddInfo);
AddInfo.key = 'system';

export default AddInfo;
