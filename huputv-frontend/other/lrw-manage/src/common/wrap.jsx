import React from 'react';
import { connect } from 'react-redux';
import Header from 'CUI/header/header';
import Auth from './auth';


const Wrap = React.createClass({
  getInitialState() {
    return {
      title: '',
      game_id: 0
    };
  },
  componentWillMount() {
    this.setTitle();
  },
  componentWillReceiveProps(nextProps) {
    this.setTitle(nextProps);
  },
  setTitle(props = this.props) {
    const { basicInfo } = props;

    this.setState({
      title: basicInfo.title,
      game_id: basicInfo.id
    })
  },
  render() {

    return (
      <div>
        <Header
          title= {this.state.title}
          game_id= {+this.state.game_id}
         />
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

export default connect(
  mapStateToProps
)(Wrap);
