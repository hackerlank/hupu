import React from 'react';
import { connect } from 'react-redux';
import Header from './header/header';
import { bindActionCreators } from 'redux';

import * as IndexActions from 'ACTION/index';
import Util from 'UTIL';

const Api = {
  notice:'/m/passerbyking/game/:id'
};
const Wrap = React.createClass({
  getInitialState() {
    return {
      basicInfo: {
        stream: {
          publish: {},
          play: ''
        },
        game_info:{

        },
        title: '路人王',
        rank_url:"",
        top8_match_url:"",
        top8_rank_url:"",
        wheel_match_url:"",
        wheel_rank_url:""
      },
      game_id: Util.getGameId()
    };
  },
  componentWillMount() {
    this.setTitle();
  },
  componentWillReceiveProps(nextProps) {
    const { basicInfo, location } = nextProps;

    this.setTitle(nextProps);
  },
  setTitle(props = this.props) {
    const basicInfo = Object.assign(this.state.basicInfo, props.basicInfo);

    document.title = basicInfo.title;

    this.setState({
      basicInfo
    })
  },
  render() {
    return (
      <div>
        {this.props.children}
      </div>
    );
  }
});

const mapStateToProps = state => {
  return {
    basicInfo: state.basicInfo
  }
}

const mapDispatchToProps = dispatch => {
  return {
    actions: bindActionCreators(IndexActions, dispatch)
  }
}
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Wrap);
