import React from 'react';
import { Table, Icon, Button, Modal, Upload, Form, Input, Select, Checkbox, Radio, message, Row, Col } from 'antd';
import './GiftList.less';
import dataService from 'common/dataService';


const FormItem = Form.Item;
const RadioGroup = Radio.Group;

const giftAddApi = '/manage/gift';
const giftUploadApi = dataService.getApiBase() + '/manage/upload-file';

let AddForm = React.createClass({

    getInitialState() {
        return { 
            loading: false,
            coverFile: [],
            iconFile: [],
            gifFile: [],
            swfFile: [],
            money_type: 6,
            position: 1,
            enable: 1
        }
    },

    onPosChange(e) {
        this.setState({
            position: e.target.value,
        });
    },

    onTypeChange(e) {
        this.setState({
            money_type: e.target.value,
        });
    },

    onEnableChange(e) {
        this.setState({
            enable: e.target.value,
        });
    },

    handleCoverChange(info) {
        let coverFile = info.fileList;

        coverFile = coverFile.slice(-1);

        coverFile = coverFile.map((file) => {
            console.log(file);
            
            if (file.response) {
                // 组件会将 file.url 作为链接进行展示
                file.url = file.response.data.cover.url;
                file.md5 = file.response.data.cover.md5;
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
    },

    handleIconChange(info) {
        let iconFile = info.fileList;

        iconFile = iconFile.slice(-1);

        iconFile = iconFile.map((file) => {
            if (file.response) {
                // 组件会将 file.url 作为链接进行展示
                file.url = file.response.data.effect_file_icon.url;
                file.md5 = file.response.data.effect_file_icon.md5;
            }
            return file;
        });

        iconFile = iconFile.filter((file) => {
            if (file.response) {
                return file.response.code === 1;
            }
            return true;
        });

        this.setState({ iconFile: iconFile });
    },

    handleGifChange(info) {
        let gifFile = info.fileList;

        gifFile = gifFile.slice(-1);

        gifFile = gifFile.map((file) => {
            if (file.response) {
                // 组件会将 file.url 作为链接进行展示
                file.url = file.response.data.effect_file_gif.url;
                file.md5 = file.response.data.effect_file_gif.md5;
            }
            return file;
        });

        gifFile = gifFile.filter((file) => {
            if (file.response) {
                return file.response.code === 1;
            }
            return true;
        });

        this.setState({ gifFile: gifFile });
    },

    handleSwfChange(info) {
        let swfFile = info.fileList;

        swfFile = swfFile.slice(-1);

        swfFile = swfFile.map((file) => {
            if (file.response) {
                // 组件会将 file.url 作为链接进行展示
                file.url = file.response.data.effect_file_flash.url;
                file.md5 = file.response.data.effect_file_flash.md5;
            }
            return file;
        });

        swfFile = swfFile.filter((file) => {
            if (file.response) {
                return file.response.code === 1;
            }
            return true;
        });

        this.setState({ swfFile: swfFile });
    },
    handleReset(e) {
        e.preventDefault();
        this.props.form.resetFields();
    },

    handleSubmit(e) {
        e.preventDefault();

        this.props.form.validateFieldsAndScroll((errors, values) => {
            if(this.state.coverFile.length == 0){
                message.error('请选择封面');
                return;
            }

            if (!!errors) {
                console.log('Errors in form!!!');
                return;
            }

            if(this.state.iconFile.length == 0){
                message.error('请选择icon');
                return;
            }

            if(typeof this.props.form.getFieldValue('money_type') == 'undefined') {
                message.error('请选择礼物类型');
                return;
            }

            if(typeof this.props.form.getFieldValue('enable') == 'undefined') {
                message.error('请选择礼物状态');
                return;
            }

            if(this.props.form.getFieldValue('position') == 2){
                if(this.state.gifFile.length == 0){
                    message.error('请选择gif');
                    return;
                }
                if(this.state.swfFile.length == 0){
                    message.error('请选择swf文件');
                    return;
                }
            }
           
            let data = this.props.form.getFieldsValue();
            
            if( data.multi_send == true ){
                data.multi_send = 1;
            }
            if(this.state.coverFile[0]){
                data.cover = this.state.coverFile[0].md5;
            }

            if(this.state.iconFile[0]) {
                data.effect_file_icon = this.state.iconFile[0].md5;
            }
            
            if(this.state.gifFile[0]) {
                data.effect_file_gif = this.state.gifFile[0].md5;
            }

            if(this.state.swfFile[0]) {
                data.effect_file_flash = this.state.swfFile[0].md5;
            }
            
            console.log('收到表单值：', data);


            dataService.post(giftAddApi, data).then((result) =>{

                if(result.code == 1) {
                    message.success('提交成功');
                    setTimeout(() => {
                         this.props.history.replaceState(null, '/gift');
                    }, 300);
                }else{
                    message.error(result.msg);
                }
            })

        });
       
    },

    render() {
        const popData = this.props.popData;

        const { getFieldProps } = this.props.form;

        const coverProps = {
            name: 'cover',
            action: giftUploadApi,
            listType: 'picture',
            onChange: this.handleCoverChange
        };

        const iconProps = {
            name: 'effect_file_icon',
            action: giftUploadApi,
            listType: 'picture',
            onChange: this.handleIconChange
        };

        const gifProps = {
            name: 'effect_file_gif',
            action: giftUploadApi,
            listType: 'picture',
            onChange: this.handleGifChange
        };


        const swfProps = {
            name: 'effect_file_flash',
            action: giftUploadApi,
            onChange: this.handleSwfChange
        };

        const nameProps = getFieldProps('name', {
            rules: [
                { required: true, message: '请输入礼物名称' }
            ]
        });

        const priceProps = getFieldProps('price', {
            rules: [
                { required: true, message: '请输入礼物价格' }
            ]
        });

        const descProps = getFieldProps('description', {
            rules: [
                { required: true, message: '请输入礼物描述' }
            ]
        });

        const formItemLayout = {
            wrapperCol: { span: 24 }
        };

        const multisendProps = getFieldProps('multi_send', {
            valuePropName: 'checked'
        });

        const moneyTypeProps = getFieldProps('money_type', {
            onChange: this.onTypeChange
        });

        const positionProps = getFieldProps('position', {
            onChange: this.onPosChange
        });

        const enableProps = getFieldProps('enable', {
            onChange: this.onEnableChange
        });

        const radioStyle = {
            display: 'block',
            height: '25px',
            lineHeight: '25px'
        };


        let posStatus,
            gifStatus,
            swfStatus;

        if(this.state.position == 0){
            gifStatus = 'none';
            swfStatus = 'none';
        }else if(this.state.position == 1){
            gifStatus = 'block';
            swfStatus = 'none';
        }else{
            gifStatus = 'block';
            swfStatus = 'block';
        }

        if(this.state.money_type == 1) {
            posStatus = 'none';
            gifStatus = 'none';         
            swfStatus = 'none';         
        }else{
            posStatus = 'block';
            
        }

        let gifStyle = {
            display: gifStatus
        };

        let swfStyle = {
            display: swfStatus
        };

        let posStyle = {
            display: posStatus
        };

        return (

            <Form horizontal form={this.props.form} style={{ width: 400,padding: 20 }} >
                <Row style={{marginBottom: 24}}>
                    <Upload {...coverProps} fileList={this.state.coverFile}
                      >
                      <Button type="ghost">
                            <Icon type="upload" /> 点击上传封面图片 56*56 (PC)
                      </Button>
                    </Upload>
                </Row>

                <Row>
                    <FormItem
                        {...formItemLayout} >
                        <Input placeholder="请输入礼物名称" 
                            {...nameProps}/>
                    </FormItem>
                    
                    <FormItem
                        {...formItemLayout} >
                        <Input placeholder="请输入礼物价格"
                                {...priceProps} />
                    </FormItem>          

                    <FormItem
                        {...formItemLayout} >
                        <Input type="textarea" 
                            placeholder="请输入礼物描述" 
                            {...descProps} />
                    </FormItem> 
                </Row>

                <p style={{ color: '#a2a2a2' }}>说明：以上内容将显示于前端界面，请认真填写</p>
                <FormItem style={{marginBottom: 0}}>
                    <label className="ant-checkbox-inline">
                        <Checkbox {...multisendProps} />批量赠送
                    </label>
                </FormItem>

                <Row>
                    <FormItem>
                        <fieldset>
                            <legend>礼物类型</legend>
                            <RadioGroup {...moneyTypeProps} name="money_type">
                                <Radio value='6'>虎扑币礼物</Radio>
                                <Radio value='1'>金豆礼物</Radio>
                            </RadioGroup>
                        </fieldset>
                    </FormItem>
                </Row>

                <Row style={posStyle}>
                    <FormItem>
                        <fieldset>
                            <legend>礼物显示位置</legend>
                            <Row>
                                <label style={{display: 'block'}}>
                                    <Radio defaultChecked disabled={true}>热线 热线浮层</Radio>
                                </label>
                                <RadioGroup {...positionProps} name="position" >
                                    <Radio style={radioStyle} key="pos0" value='0'>默认 <span className="tips">热线浮层</span></Radio>
                                    <Radio style={radioStyle} key="pos1" value='1'>大屏幕1 <span className="tips">右上角tips从右至左展出再收回</span></Radio>
                                    <Radio style={radioStyle} key="pos2" value='2'>大屏幕2壕版 <span className="tips">下方中心位置由下至上</span></Radio>
                                </RadioGroup>
                            </Row>
                        </fieldset>
                    </FormItem>
                </Row>
                
                <Row>
                <FormItem>
                    <fieldset>
                    <legend>上传元素</legend>
                        <Row>
                            <Upload {...iconProps}  fileList={this.state.iconFile}>
                              <Button type="ghost">
                                    <Icon type="upload" /> 点击上传ICON 70*70
                              </Button>
                            </Upload>
                            
                        </Row>
                        <Row style={gifStyle}>
                            <Upload {...gifProps} fileList={this.state.gifFile}>
                              <Button type="ghost">
                                    <Icon type="upload" /> 点击上传GIF 120*120
                              </Button>
                            </Upload>
                        </Row>
                        <Row style={swfStyle}>
                            <Upload {...swfProps} fileList={this.state.swfFile}>
                              <Button type="ghost">
                                    <Icon type="upload" /> 点击上传全屏素材 swf
                              </Button>
                            </Upload>
                        </Row>
                    </fieldset>
                </FormItem>
                </Row>

                <Row>
                <FormItem>
                    <fieldset>
                    <legend>礼物状态</legend>
                        <RadioGroup {...enableProps} name="enable" >
                            <Radio key="enable1" value='1'>上架</Radio>
                            <Radio key="enable0" value='0'>下架</Radio>
                        </RadioGroup>
                    </fieldset>
                </FormItem>
                </Row>

                <FormItem
                  wrapperCol={{ span: 12, offset: 7 }} >
                  <Button type="primary" onClick={this.handleSubmit}>确定</Button>
                  &nbsp;&nbsp;&nbsp;
                  <Button type="ghost" onClick={this.handleReset}>重置</Button>
                </FormItem>
            </Form>
        );
    }
});

AddForm = Form.create()(AddForm);

export default AddForm;
