import React, {Component} from 'react';
import { Table, Button, message, Row, Col } from 'antd';
import { Link, History } from 'react-router';

import SearchMixin from 'common/mixin/SearchMixin';
import dataService from 'common/dataService';

const Api = {
    hotline: '/manage/hotline'
}

/**
 * 搜索
 */
const SearchInput = React.createClass({
    mixins: [SearchMixin],
    onChange(field, value) {
        // console.log(field, 'change', value);
        this.setState({
            [field]: value
        });
    },
    /**
    * 搜索提交
    * @param  {[type]} event [description]
    * @return {[type]}       [description]
    */
    handleSubmit(event){
        console.log(this.props.startTime);
        console.log(this.format(this.state.startValue));
        this.props.handlePageUpload({
            startTime: this.format(this.state.startValue),
            endTime: this.format(this.state.endValue)
        });
    }
});


class Hotline extends Component {
    constructor(props) {
        super(props);

        this.state = {
            list: [],
            count: 0,
            page: 1,
            per: 20,
            loading: false,
            room_id: this.props.location.query.room_id,
            match_id: this.props.location.query.match_id,
            startTime: 0,
            endTime: 0
        }

    }

    componentWillMount() {
        this.renderPage();
    }

    handlePageUpload(params) {
        console.log({...params});
        this.setState({
            startTime: params.startTime,
            endTime: params.endTime
        });

        this.renderPage(1, params.startTime, params.endTime);
    }

    renderPage(page = 1, startTime = this.state.startTime, endTime = this.state.endTime) {

        var url = Api.hotline;

        this.setState({
            loading: true
        });

        dataService
            .get(url, {
                room_id: this.props.location.query.room_id,
                match_id: this.props.location.query.match_id,
                startTime: startTime,
                endTime: endTime,
                page: page
            })
            .then((result) => {
                this.setState({
                    list: result.list,
                    count: result.count,
                    page: +result.page,
                    loading: false
                });
            })
    }

    render() {
        const columns = [
            { title: '发言内容', dataIndex: 'content', key: 'content',
                render(text, record, index) {
                    return <span>{text}</span>;
                }
            }, 

            { title: '发言人', dataIndex: 'username', key: 'username',
                render(text, record, index) {
                    return <span>{text}</span>;
                }
            },

            { title: '发言时间', dataIndex: 'create_time', key: 'create_time',
                render(text, record, index) {
                    return <span>{text}</span>;
                }
            },

            { title: '操作', dataIndex: 'operation', key: 'operation',
                render(text, record, index) {
                    return  <a target="_blank" href={"http://ugcaduit.hupu.com/user/login"}>信息治理</a>
                }
            }
        ];

        const pagination = {
            total: this.state.count,
            pageSize: 20,
            onChange: function(current) {
                this.setState({
                    page: current
                })
                this.renderPage(current);
            }.bind(this),
            current: this.state.page
        };

        return(
            <div>
                <h2 style={{marginBottom: 10}}>主播-热线</h2>
                <div style={{marginBottom: 10}}>
                    <Row>
                        <Col span="16">
                            <SearchInput 
                                handlePageUpload={this.handlePageUpload.bind(this)} 
                            />
                        </Col>
                        <Col span="8" style={{textAlign: "right"}}>
                            <a className="ant-btn ant-btn-primary" href={`${Api.hotline}?room_id=${this.state.room_id}&match_id=${this.state.match_id}&startTime=${this.state.startTime}&endTime=${this.state.endTime}&export=1`}>导出</a>
                        </Col>
                    </Row>
                </div>
                <Table
                    rowKey={record => record.id}
                    columns = {columns}
                    dataSource = {this.state.list}
                    pagination = {pagination} 
                    loading={this.state.loading}
                />
            </div>
        )
    }
}

export default Hotline;