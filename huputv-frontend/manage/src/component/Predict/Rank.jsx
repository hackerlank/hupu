import React, {Component} from 'react'
import { Link } from 'react-router'
import dataService from 'common/dataService'
import { Form, Input, Row, Col, Radio, Button, Tabs, Table, Popconfirm, Select, message, Modal, DatePicker, Checkbox } from 'antd'

const MonthPicker = DatePicker.MonthPicker;
const FormItem = Form.Item;
const Option = Select.Option;


class Rank extends Component {
    constructor() {
        super();

        this.state = {
            loading: false,
            typeValue: 1,
            type: '日',
            dataSource: [],
            page: 1
        }
    }

    handleChange(value, label) {
        this.setState({
            typeValue: value,
            type: label
        })
    }

    handleDate(value) {
        this.setState({
            date: value
        })
    }

    handleDate2(value) {
        this.setState({
            date: value
        })
    }

    handleSubmit() {
        if(!this.state.date) {
            message.warn('请选择日期');
            return ;
        }
        let date = parseInt(new Date(this.state.date).getTime() / 1000);

        dataService.get('/manage/topic/searchrank', {
            date: date,
            type: this.state.typeValue,
            page: 1,
            pageSize: 200
        }).then((res) => {
            if(res.code == 1) {
                this.setState({
                    dataSource: res.data,
                    page: 1
                })
            }else{
                message.error(res.msg);
            }
        })
    }


    changePage(current) {
        this.setState({
            page: current
        })
    }




    render() {
        const { getFieldProps } = this.props.form;

        const columns = [
            { title: '用户名', dataIndex: 'username', key: 'username' },
            { title: 'PassportUid', dataIndex: 'puid', key: 'puid' },
            { title: '人品值', dataIndex: 'score', key: 'score' }
        ];

        const typeProps = getFieldProps('type', {
                initialValue: this.state.type
            }
        );

        const dateProps = getFieldProps('date', {
            onChange: this.handleDate.bind(this)
        });

        const date2Props = getFieldProps('date', {
            onChange: this.handleDate2.bind(this)
        });

        let pagination = {
            pageSize: 10,
            current: this.state.page,
            onChange: this.changePage.bind(this)
        }

        return (
            <div>
                <h3 style={{marginBottom: 10}}> 人品值排行 </h3>
                <Form  inline form={this.props.form} >
                    <FormItem 
                        labelCol={{ wrapperCol: 12 }}
                    >
                        <Select id="select"  value={this.state.type} style={{ width: 200 }} onChange={this.handleChange.bind(this)} >
                            <Option value="1">日</Option>
                            <Option value="2">月</Option>
                        </Select>
                    </FormItem>

                    <FormItem 
                        labelCol={{ wrapperCol: 12 }}
                    >
                        {
                            this.state.typeValue == 1 ? 
                                <DatePicker 
                                    value={this.state.date}
                                    onChange={this.handleDate.bind(this)}  
                                /> : 
                                <MonthPicker 
                                    value={this.state.date}
                                    onChange={this.handleDate.bind(this)} 
                                />
                        }
                        
                    </FormItem>

                    <Button 
                        type = "primary"
                        htmlType = "submit"
                        onClick = {this.handleSubmit.bind(this)}
                        > 查询
                    </Button>
                </Form>
                <Table
                    rowKey={record => record.id}
                    columns = {columns}
                    pagination = {pagination}
                    dataSource = {this.state.dataSource}
                    loading={this.state.loading}
                    style={{marginTop: 30}}
                />
            </div>
        )
    }
}

Rank = Form.create()(Rank);

export default Rank;

