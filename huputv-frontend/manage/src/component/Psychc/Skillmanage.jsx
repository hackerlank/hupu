import React from 'react';
import { Link } from 'react-router';
import { Icon, QueueAnim, Table, Button, Popconfirm, Modal, notification, Upload, Form, Row, Col, Input} from 'antd';
import dataService from 'common/dataService';
const FormItem = Form.Item;

const giftUploadApi = dataService.getApiBase() + '/manage/upload-file';

const App = React.createClass({
  getInitialState() {
    return {
      data: [],
      visible: false,
      priviewImage: [],
      skill:{
        id: null,
        name: "",
        value: "",
        desc: "",
        url: ""
      }
    };
  },
  addSkill(){
    this.setState({
      visible: true,
      priviewImage: [],
      skill:{
        id: null,
        name: "",
        value: "",
        desc: "",
        url: ""
      }
    })
  },
  editSkill(skill, e){
    e.preventDefault();
    let editSkill = {
      id: skill.id,
      name: skill.skill_name,
      value: skill.skill_value,
      url: skill.skill_logo,
      desc: skill.skill_description
    };
    this.setState({
      skill: editSkill,
      priviewImage: [],
      visible: true
    })
  },
  removeSkill(skill){
    dataService.post('/chaoneng/skills/delete',{ id: skill.id }).then(res=>{
      if(res.code == 1){
        notification.success({message: "删除成功"})
        this.getSkills();
      } else{
        notification.error({message: res.msg})
      }
    })
  },
  getSkills(){
    dataService.get('/chaoneng/skills/getAll').then(res=>{
      if(res.code == 1){
        this.setState({
          data: res.data
        })
      } else{
        notification.error({message: res.msg})
      }
    })
  },
  componentDidMount(){
    this.getSkills();
  },
  handleSubmit(){
     let isPassForm = true;
     this.props.form.validateFields((errors, values) => {
         if (!!errors) {
           isPassForm = false;
           return;
         }
         console.log(values);
     });
    if(!this.state.priviewImage.length){
        isPassForm = false;
        alert("必须上传技能图标");
    }
    if(!isPassForm) return;

    let formData = this.props.form.getFieldsValue();
    let skillid = this.state.skill.id;
    formData.skill_logo = this.state.priviewImage;
    formData.skill_visible = 1;
    if(skillid){
      formData.id = skillid;
      dataService.post('/chaoneng/skills/update', formData).then(res=>{
        if(res.code == 1){
          this.getSkills();
        } else{
          notification.error({message: res.msg})
        }
      })
    } else{
      dataService.post('/chaoneng/skills/create', formData).then(res=>{
        if(res.code == 1){
          this.getSkills();
        } else{
          notification.error({message: res.msg})
        }
      })
    }
    this.handleCancel();
  },
  handleOk(){
    this.handleSubmit();
  },
  handleCancel(){
    this.props.form.resetFields();
    this.setState({
      visible: false
    })
  },
  render() {
    const { getFieldProps } = this.props.form;
    const self = this;
    const columns = [{
      title: '技能ID',
      dataIndex: 'id',
    },{
      title: '图标',
      name: 'skill_logo',
      render(text, record){
        return <img src={record.skill_logo} width="60" height="60" />
      }
    },{
      title: '名称',
      dataIndex: 'skill_name',
    },{
      title: '价值',
      dataIndex: 'skill_value',
    },{
      title: '操作',
      key :'skillcon',
      render(text, record){
        return (
          <p>
            <a href="#" onClick={self.editSkill.bind(null, record)}>编辑</a>
            {/*<span className="ant-divider">
            </span>
            <Popconfirm
              title="确定要删除该技能吗？"
              onConfirm={self.removeSkill.bind(null, record)}>
              <a href="#">删除</a>
            </Popconfirm>*/}
          </p>
        )
      }
    }];
    const props = {
      name: 'effect_file_gif',
      action: giftUploadApi,
      listType: 'picture',
      onChange: (info) =>{
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
          let skill = this.state.skill;
          skill.url = "";
          this.setState({ priviewImage: gifFile, skill: skill});
      }
    };
    const pagination = {
      total: this.state.data.length,
      showSizeChanger: true,
      pageSize: 20
    };
    return (
      <QueueAnim delay={500}>
        <div className="tb10">
          <Button type="primary" onClick={this.addSkill}><Icon type="plus" />添加新技能</Button>
        </div>
        <Table
          rowKey={skill => skill.id}
          columns={columns}
          dataSource={this.state.data}
          pagination={pagination} />
        <Modal
          onOk={this.handleOk}
          title="添加技能"
          onCancel={this.handleCancel}
          visible={this.state.visible}>
          <Form inline form={this.props.form}>
            <Row>
              <Col span={10}>
                {this.state.skill.url ? <img src={this.state.skill.url} /> : ''}
                <Upload {...props} fileList={this.state.priviewImage}>
                  <Button type="ghost">
                    <Icon type="upload" /> 上传照片(60 * 60)
                  </Button>
                </Upload>
              </Col>
              <Col span={14}>
                <FormItem
                  label="名称："
                  labelCol={{ span: 6 }}
                  wrapperCol={{ span: 14 }}>
                  <Input {...getFieldProps('skill_name', {
                          initialValue: this.state.skill.name,
                          rules: [
                             { required: true, message: '请填写技能名称' }
                          ]
                         })} />
                </FormItem>
                <FormItem
                  label="价值："
                  labelCol={{ span: 6 }}
                  wrapperCol={{ span: 14 }}>
                  <Input {...getFieldProps('skill_value',{
                          initialValue: this.state.skill.value,
                          rules: [
                             { required: true, message: '请填写技能价值' }
                          ]
                         })} />
                </FormItem>
              </Col>
            </Row>
            <FormItem>
              <Input type="textarea" {...getFieldProps('skill_description',{
                      initialValue: this.state.skill.desc,
                      rules: [
                         { required: true, message: '请填写技能备注' }
                      ]
                  })} placeholder="技能备注" rows="3" cols="46" />
            </FormItem>
          </Form>
        </Modal>
      </QueueAnim>
    );
  }
});

export default Form.create()(App);;
