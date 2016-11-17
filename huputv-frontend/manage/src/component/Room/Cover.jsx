import React, { Component } from 'react';
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd'
import dataService from 'common/dataService';

const coverApi = `${dataService.getApiBase()}/upload`;
const roomInfoName = '/manage/room/:id';


class Cover extends Component {
    constructor(props) {
        super(props);
        this.state = {
            coverFile: [],
            loading: false
        }
    }

    handleCancel(e) {
        this.setState({
            coverFile: []
        })
        this.props.handleCancel();
    }

    handleOk() {
        let data = {};

        if(this.state.coverFile.length == 0) {
            message.error('还没有选择新的封面');
            return;
        }

        data.room_id = this.props.coverID;
        data.key = 'cover';
        data.value = this.state.coverFile[0].md5;
        data.url = this.state.coverFile[0].url;

        let api = roomInfoName.replace(':id', data.room_id);

        this.setState({
            loading: true
        })

        dataService.post(api, data).then((res) =>{
            if(res.code == 1){
                message.success('修改封面成功！');

                this.props.data.forEach(function(item) {
                    if(item.id == data.room_id) {
                        item.cover = data.url;
                    }
                })
                this.setState({
                    loading: false
                })

                this.handleCancel();
            }
        })
    }

    handleCoverChange(info) {
        let coverFile = info.fileList;

        coverFile = coverFile.slice(-1);

        coverFile = coverFile.map((file) => {
            if (file.response) {
                // 组件会将 file.url 作为链接进行展示
                file.url = file.response.data.url;
                file.md5 = file.response.data.md5;
            }
            return file;
        });

        coverFile = coverFile.filter((file) => {
            if (file.response) {
                return file.response.code === 1;
            }
            return true;
        });

        this.setState({ coverFile: coverFile });
    }

    render() {

        const coverProps = {
            name: 'cover',
            action: coverApi,
            listType: 'picture',
            onChange: this.handleCoverChange.bind(this),
            data:{
                file_key: 'cover'
            }
        };

        return (
            <Modal
                ref="modal"
                visible={this.props.visible}
                title="更换封面"
                onCancel={this.handleCancel.bind(this)}
                width="600"
                footer={[
                    <Button key="back" type="ghost" size="large" onClick={this.handleCancel.bind(this)}>返 回</Button>,
                    <Button key="submit" type="primary" size="large" onClick={this.handleOk.bind(this)} loading={this.state.loading}>提 交</Button>
                ]}>
                <Form horizontal form={this.props.form} >
                    <Row style={{marginBottom: 12}}>
                        <h3>当前封面：</h3>
                        <img src={this.props.cover} width="100" />
                    </Row>
                    <Row style={{marginBottom: 12}}>
                        <h3>上传新封面：</h3>
                        <Upload {...coverProps} fileList={this.state.coverFile} >
                            <Button type="ghost">
                                <Icon type="upload" /> 选择图片
                            </Button>
                        </Upload>
                    </Row>
                </Form>
            </Modal>
        )
    }
}

Cover = Form.create()(Cover);
export default Cover;
