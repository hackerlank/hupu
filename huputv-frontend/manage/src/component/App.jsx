import React from 'react';
import { Menu, Icon, Breadcrumb } from 'antd';
import { Link } from 'react-router';
import DataService from 'common/dataService';

import Nav from '../common/Nav';

const App = React.createClass({
    getInitialState() {
        return {
            current: this.props.children.type.key
        };
    },

    handleClick(e) {
        this.setState({
            current: e.key
        });
    },

    render() {
        return (
            <div>
              <div className="ant-layout-top">
                <div className="ant-layout-header">
                  <div className="ant-layout-wrapper">
                    <div className="ant-layout-logo">
                      <Link to="/">亮了网专用后台</Link>
                    </div>
                    <Menu
                      theme="dark"
                      mode="horizontal"
                      onClick={this.handleClick}
                      selectedKeys={[this.state.current]}
                      defaultSelectedKeys={['2']} style={{height: 64, lineHeight: '64px'}}>
                        <Menu.Item key="room">
                          <Link to="/room"><Icon type="caret-circle-right" />直播间列表</Link>
                        </Menu.Item>

                        <Menu.Item key="catalog">
                            <Link to="/catalog"><Icon type="edit" />直播间分类</Link>
                        </Menu.Item>

                        <Menu.Item key="anchor">
                            <Link to="/anchor"><Icon type="smile" />主播列表</Link>
                        </Menu.Item>

                        <Menu.Item key="gift">
                            <Link to="/gift"><Icon type="inbox" />礼物列表</Link>
                        </Menu.Item>

                        <Menu.Item key="task">
                            <Link to="/task"><Icon type="bars" />任务</Link>
                        </Menu.Item>

                        <Menu.Item key="psychc">
                            <Link to="/psychc"><Icon type="team" />超能篮球</Link>
                        </Menu.Item>

                        <Menu.Item key="predict">
                            <Link to="/predict"><Icon type="eye" />比赛预测</Link>
                        </Menu.Item>

                        <Menu.Item key="other">
                            <Link to="/other"><Icon type="setting" />其它管理</Link>
                        </Menu.Item>
                    </Menu>
                  </div>
                </div>
              </div>
              <div className="ant-layout-container">
                {this.props.children}
              </div>
            </div>
        );
    }
});

// <Menu.Item key="lrw">
//                             <Link to="/lrw"><Icon type="user" />路人王</Link>
//                         </Menu.Item>

export default App;
