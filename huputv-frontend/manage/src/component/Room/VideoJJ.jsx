import React, { Component } from 'react';
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd'
import ReactSWFCompat from 'react-swf/compat';


class VideoJJ extends Component {
    constructor(props) {
        super(props);
    }

    handleCancel(e) {
        e.preventDefault();
        this.props.handleCancel();
    }

    initVideo() {
        window.HTV = window.HTV || {};
        const stream = this.props.streamInfo.hls ? [{
            name: "普清",
            hls : this.props.streamInfo.hls,
            rtmp: this.props.streamInfo.rtmp
        }] : [];
        HTV.flashStreamAddress = () => stream;

        const conf = {
            author: this.props.author,
            appkey: this.props.appkey,
            referer: this.props.referer,
            source: this.props.source,
            type: this.props.type,
            userID: this.props.userID,
            userPwd: this.props.userPwd
        };
        HTV.getVideoJJ = () => conf;
    }

    render() {
        this.initVideo();
        return (
            <Modal
                ref="modal"
                visible={this.props.visible}
                title="视频画面"
                onCancel={this.handleCancel.bind(this)}
                width="840"
                footer={[
                    <Button key="submit" type="primary" size="large" onClick={this.handleCancel.bind(this)}>确定</Button>
                ]}>
            <ReactSWFCompat
              container={<div style={{background: '#ffffff'}} />}
              src="/huputv.swf"
              width="800"
              height="600"
              wmode="transparent"
            />
         </Modal>
        )
    }
}

VideoJJ = Form.create()(VideoJJ);
export default VideoJJ;
