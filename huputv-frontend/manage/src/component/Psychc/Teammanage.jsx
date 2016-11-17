import React from 'react';
import { Link, withRouter } from 'react-router';
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
      editTeamId: null,
      editTeam:{
        cn_name: "",
        en_name: "",
        url: "",
        team_description: ""
      }
    };
  },
  addTeam(){
    this.setState({
      visible: true,
      priviewImage: [],
      editTeamId: null,
      editTeam:{
        cn_name: "",
        en_name: "",
        url: "",
        team_description: ""
      }
    })
  },
  editTeam( info, e ){
    e.preventDefault();
    let editTeam = {
      cn_name: info.cn_name,
      en_name: info.en_name,
      url: info.team_logo,
      team_description: info.team_description
    };
    this.setState({
      editTeamId: info.id,
      priviewImage: [],
      editTeam: editTeam,
      visible: true
    })
  },
  showTeam( info, e){
    e.preventDefault();
    this.props.router.replace(`/psychc/teammatch/${info.id}`);
  },
  deleteTeam(info, e){
    e.preventDefault();
    dataService.post('/chaoneng/teams/delete',{ id: info.id }).then(res=>{
      if(res.code == 1){
        notification.success({message: "删除成功"})
        this.getTeams();
      } else{
        notification.error({message: res.msg})
      }
    })
  },
  getTeams(){
    dataService.get('/chaoneng/teams/getAll', {with_power : true}).then(res=>{
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
    this.getTeams();
  },
  handleSubmit(){
      let isPassForm = true;
      this.props.form.validateFields((errors, values) => {
          if (!!errors) {
            isPassForm = false;
            return;
          }
      });
      if(!this.state.priviewImage.length){
          isPassForm = false;
          alert("必须上传球队图标");
      }
     if(!isPassForm) return;

    let formData = this.props.form.getFieldsValue();
    let teamId = this.state.editTeamId;
    formData.team_logo = this.state.priviewImage;
    if(teamId){
      formData.id = teamId;
      dataService.post('/chaoneng/teams/update',formData).then(res=>{
        if(res.code == 1){
          this.getTeams();
        } else{
          notification.error({message: res.msg})
        }
      })
    } else{
      dataService.post('/chaoneng/teams/create',formData).then(res=>{
        if(res.code == 1){
          this.getTeams();
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
      title: '球队ID',
      dataIndex: 'id',
    },{
      title: '球队名称',
      dataIndex: 'cn_name',
    },{
      title: '球队缩写',
      dataIndex: 'en_name',
    },{
      title: '球队图片',
      width: 100,
      name: 'team_logo',
      render(text, record){
        return <img src={record.team_logo} width="60" height="60" />
      }
    },{
      title: '球队剩余资产',
      name: 'team_left_power',
      render(text, record){
          return <span>{record.team_left_power}虎扑币</span>
      }
    },{
      title: '球队描述',
      dataIndex: 'team_description',
      width: 150
    },{
      title: '创建时间',
      dataIndex: 'created_at',
    },{
      title: '操作',
      key :'skillcon',
      render(text, record){
        return (
          <p>
            <a href="#" onClick={self.editTeam.bind(null, record)}>编辑</a>
            <span className="ant-divider"></span>
            <a href="#" onClick={self.showTeam.bind(null, record)}>比赛明细</a>
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
          let editTeam = this.state.editTeam;
          editTeam.url = "";
          this.setState({ priviewImage: gifFile, editTeam: editTeam });
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
          <Button type="primary" onClick={this.addTeam}><Icon type="plus" />新建球队</Button>
        </div>
        <Table
          rowKey={team => team.id}
          columns={columns}
          dataSource={this.state.data}
          pagination={pagination} />
        <Modal
          onOk={this.handleOk}
          title="新建球队"
          onCancel={this.handleCancel}
          visible={this.state.visible}>
          <Form inline form={this.props.form}>
            <Row>
              <Col span={10}>
                  {this.state.editTeam.url ? <img src={this.state.editTeam.url} /> : ''}
                  <Upload {...props} fileList={this.state.priviewImage}>
                    <Button type="ghost">
                      <Icon type="upload" /> 上传照片(100 * 100)
                    </Button>
                  </Upload>
              </Col>
              <Col span={14}>
                <FormItem
                  label="球队名称："
                  labelCol={{ span: 10 }}
                  wrapperCol={{ span: 12 }}>
                  <Input {...getFieldProps('cn_name',{
                      initialValue: this.state.editTeam.cn_name,
                      rules: [
                         { required: true, message: '请填写球队名称' }
                      ]
                    })} size="large" />
                </FormItem>
                <FormItem
                  label="球队英文名："
                  labelCol={{ span: 10 }}
                  wrapperCol={{ span: 12 }}>
                  <Input {...getFieldProps('en_name',{
                      initialValue: this.state.editTeam.en_name,
                      rules: [
                         { required: true, message: '请填写球队英文名' }
                      ]
                    })} size="large" />
                </FormItem>
              </Col>
            </Row>
            <FormItem>
              <Input type="textarea" {...getFieldProps('team_description',{
                  initialValue: this.state.editTeam.team_description,
                  rules: [
                     { required: true, message: '请填写球队备注' }
                  ]
              })} placeholder="球队备注" rows="3" cols="74" />
            </FormItem>
          </Form>
        </Modal>
      </QueueAnim>
    );
  }
});

export default withRouter(Form.create()(App))
