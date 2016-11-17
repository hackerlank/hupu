import React, { Component } from 'react';
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd'
import CopyToClipboard from 'react-copy-to-clipboard';

const giftAddApi = '/manage/gift';

class VideoParam extends Component {
    constructor(props) {
        super(props);
        this.state = {
            RTMPCopied : false,
            RTMPHdCopied : false,
            RTMPSdCopied : false,
            StreamCopied : false
        }
    }

    handleCancel(e) {
        e.preventDefault();
        this.props.handleCancel();
    }

    handleCopy1() {
        this.setState({RTMPCopied: true});
        message.success("复制RTMP链接成功");
    }

    handleCopy2() {
        this.setState({RTMPHdCopied: true});
        message.success("复制RTMPHd链接成功");
    }

    handleCopy3() {
        this.setState({RTMPSdCopied: true});
        message.success("复制RTMPSd链接成功");
    }

    handleCopy4() {
        this.setState({StreamCopied: true});
        message.success("复制Stream链接成功");
    }

    render() {
        return (
            <Modal 
                ref="modal"
                visible={this.props.visible}
                title="视频参数" 
                onCancel={this.handleCancel.bind(this)}
                width="600"
                footer={[
                    <Button key="submit" type="primary" size="large" onClick={this.handleCancel.bind(this)}>确定</Button>
                ]}>
                <Row>
                    <strong style={{fontSize: '14px'}}>RTMP URL: </strong>&nbsp;<span style={{fontSize: '14px'}}>{this.props.RTMP}</span><br/>
                    <CopyToClipboard text={this.props.RTMP}
                        onCopy={this.handleCopy1.bind(this)} 
                        style={{marginBottom: '15px'}}>
                        <button className="ant-btn ant-btn-primary">复制RTMP URL</button>
                    </CopyToClipboard>
                </Row>
                <Row>
                    <strong style={{fontSize: '14px'}}>RTMPHd URL: </strong>&nbsp;<span style={{fontSize: '14px'}}>{this.props.RTMPHd}</span><br/>
                    <CopyToClipboard text={this.props.RTMPHd}
                        onCopy={this.handleCopy2.bind(this)} 
                        style={{marginBottom: '15px'}}>
                        <button className="ant-btn ant-btn-primary">复制RTMPHd URL</button>
                    </CopyToClipboard>
                </Row>

                <Row>
                    <strong style={{fontSize: '14px'}}>RTMPSd URL: </strong>&nbsp;<span style={{fontSize: '14px'}}>{this.props.RTMPSd}</span><br/>
                    <CopyToClipboard text={this.props.RTMPSd}
                        onCopy={this.handleCopy3.bind(this)} 
                        style={{marginBottom: '15px'}}>
                        <button className="ant-btn ant-btn-primary">复制RTMPSd URL</button>
                    </CopyToClipboard>
                </Row>
                <Row>
                    <strong style={{fontSize: '14px'}}>Stream Name: </strong>&nbsp;<span style={{fontSize: '14px'}}>{this.props.Stream}</span><br/>
                    <CopyToClipboard text={this.props.Stream}
                        onCopy={this.handleCopy4.bind(this)} 
                        style={{marginBottom: '15px'}}>
                        <button className="ant-btn ant-btn-primary">复制Stream Name</button>
                    </CopyToClipboard>
                </Row>
            </Modal>
        )
    }
}

VideoParam = Form.create()(VideoParam);
export default VideoParam;

