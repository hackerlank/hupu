import React from 'react';
import {Link} from 'react-router';
import {Table, Row, Popconfirm, Message, Modal, Button, Form, Radio, Input, Col} from 'antd';
import './Index.less';
import RankPop from './RankPop';
import dataService from 'common/dataService';


const FormItem = Form.Item;
const RadioGroup = Radio.Group;

const index_api = '/manage/catalog';
const add_api = '/manage/catalog';
const edit_api = '/manage/catalog/:sid';
const delete_api = '/manage/catalog/:sid';
const hide_api = '/manage/catalog/display/:sid';

class CatalogIndex extends React.Component {
    static key = 'catalog';

    constructor(props) {
        super(props);
        this.state = {
            columns: [
                { title: 'sid', dataIndex: 'sid', key: 'sid' },
                { title: '名称', dataIndex: 'sname', key: 'sname' },
                { title: '路由', dataIndex: 'sroute', key: 'sroute' },
                { title: '排序', dataIndex: 'sorder', key: 'sorder' },
                {
                    title: '是否分类显示',
                    dataIndex: 'display',
                    key: 'display',
                    render: (text, record) => { return (record.display == 1 ? '显示' : '隐藏')}
                },
                {
                    title: '是否首页显示',
                    dataIndex: 'displayIndex',
                    key: 'displayIndex',
                    render: (text, record) => { return (record.displayindex == 1 ? '显示' : '隐藏')}
                },
                {
                    title: '操作',
                    dataIndex: 'handle',
                    key: 'handle',
                    render: (text, record, index) => {
                        return (
                            <Row>
                                <a type="primary" onClick={this.editCatalog.bind(this, record)}>修改</a><br/>
                                <Popconfirm title="确定吗？" onConfirm={this.hideCatalog.bind(this, record)}>
                                    <a href="#">{record.display == 1 ? '分类中隐藏' : '分类中显示'}</a>
                                </Popconfirm> <br/>
                                <Popconfirm title="确定吗？" onConfirm={this.toggleCatalog.bind(this, record)}>
                                    <a href="#">{record.displayindex == 1 ? '首页中隐藏' : '首页中显示'}</a>
                                </Popconfirm> <br/>
                                <Popconfirm title="确定要删除吗？" onConfirm={this.deleteCatalog.bind(this, record)}>
                                    <a href="#">删除</a>
                                </Popconfirm>
                            </Row>
                        );
                    }
                }
            ],
            dataSource: [],
            loading: true,
            visible: false,
            action: '',
            rankData: {cards: []},
            rankVisible: false,
        };
    }

    componentDidMount () {
        this.getCatalogList();
    }

    // 获取数据列表
    getCatalogList() {

        dataService.get(index_api).then((response) =>{
            this.setState({
                dataSource: response.data.list,
                loading: false
            });
        })
    }

    // 删除分类
    deleteCatalog (record) {
        let api = delete_api.replace(':sid', record.sid);

        dataService.delete(api).then((response) =>{
            if (response && response.code == 1) {
                Message.success(response.msg);
                this.getCatalogList();
            }
            else {
                Message.error(response.msg||'网络故障');
            }
        })

    }

    // 分类中隐藏/显示分类
    hideCatalog (record) {
        let api = hide_api.replace(':sid', record.sid);
        let params = {
            display: record.display == 1 ? 0 : 1
        }
        dataService.put(api, params).then((response) =>{
            if (response && response.code == 1) {
                Message.success(response.msg);
                this.getCatalogList();
            }
            else {
                Message.error(response.msg);
            }
        })

    }

    // 首页中隐藏/显示分类
    toggleCatalog (record) {
        let api = hide_api.replace(':sid', record.sid);
        let params = {
            display: record.displayindex == 1 ? 0 : 1
        }
        dataService.put(api, params).then((response) =>{
            if (response && response.code == 1) {
                Message.success(response.msg);
                this.getCatalogList();
            }
            else {
                Message.error(response.msg);
            }
        })

    }

    // 添加分类
    addCatalog () {
        this.showModal('add')
    }

    // 修改分类
    editCatalog (record) {
        this.showModal('edit');

        this.props.form.setFieldsValue(record);
    }

    // 点击取消
    popCancel() {
        this.hideModal();
    }

    // 处理表单提交
    handleSubmit (e) {
        let data = this.props.form.getFieldsValue();
        console.log(data);
        let api = add_api;
        let method = 'post';

        if (this.state.action == 'edit') {
            api = edit_api.replace(':sid', data.sid);
            method = 'put';
        }

        dataService[method](api, this.props.form.getFieldsValue()).then((response) =>{
            if (response && response.code == 1) {
                this.hideModal();
                Message.success(response.msg);
                this.getCatalogList();
            }
            else {
                Message.error(response.msg);
            }
        })

    }

    // 隐藏弹出, 清空数据
    hideModal(action = '') {
        this.setState({
            visible: false,
            action: action
        });

        this.props.form.setFieldsValue({sid: '', display: '0', displayindex: '0', sname: '', sroute: '', sorder: 0});
    }

    // 显示弹出
    showModal(action = '') {
        this.setState({
            visible: true,
            action: action
        });
    }

    rankCatalog() {
        var rankData = {cards: this.state.dataSource};

        this.setState({
            rankVisible: true,
            rankData: rankData
        })
    }

    handleCancel2() {
        this.setState({
            rankVisible: false
        })
    }

    render () {
        const { getFieldProps } = this.props.form;

        const formItemLayout = {
            labelCol: { span: 6 },
            wrapperCol: { span: 8 }
        };

        return (
            <Row>
                <Button className="addCatalog" type="primary" onClick={this.addCatalog.bind(this)} style={{marginRight:'10px'}}>添加分类</Button>
                {/*<Button className="addCatalog" type="primary" onClick={this.rankCatalog.bind(this)}>分类排序</Button>*/}

                <Modal title="添加分类" visible={this.state.visible}
                       onOk={this.handleSubmit.bind(this)}
                       onCancel={this.popCancel.bind(this)}>

                    <Form horizontal form={this.props.form}>
                        <Input type="hidden" {...getFieldProps('sid')} />

                        <FormItem
                            {...formItemLayout}
                            label="是否在分类显示：">
                            <RadioGroup {...getFieldProps('display', {initialValue: '0'})}>
                                <Radio value='1'>显示</Radio>
                                <Radio value='0'>不显示</Radio>
                            </RadioGroup>
                        </FormItem>

                        <FormItem
                            {...formItemLayout}
                            label="是否在首页显示：">
                            <RadioGroup {...getFieldProps('displayindex', {initialValue: '0'})}>
                                <Radio value='1'>显示</Radio>
                                <Radio value='0'>不显示</Radio>
                            </RadioGroup>
                        </FormItem>

                        <FormItem
                            {...formItemLayout}
                            label="名称：" required>
                            <Input type="text" {...getFieldProps('sname')} placeholder="请输入名称" />
                        </FormItem>

                        <FormItem
                            {...formItemLayout}
                            label="路由：" required>
                            <Input type="text" {...getFieldProps('sroute')} placeholder="请输入路由" />
                        </FormItem>

                        <FormItem
                            {...formItemLayout}
                            label="排序：">
                            <Input type="text" {...getFieldProps('sorder')} placeholder="请输入排序" />
                        </FormItem>
                    </Form>

                </Modal>

                <Table
                    key={record => record.sid}
                    rowKey={record => record.sid}
                    dataSource={this.state.dataSource}
                    columns={this.state.columns}
                    pagination={false}
                    loading={this.state.loading}
                    bordered />

                <RankPop
                    visible = {this.state.rankVisible}
                    rankData = {this.state.rankData}
                    handleRank = {this.handleRank}
                    handleCancel = {this.handleCancel2.bind(this)}
                />
            </Row>
        );
    }
}

CatalogIndex = Form.create()(CatalogIndex);
export default CatalogIndex;
