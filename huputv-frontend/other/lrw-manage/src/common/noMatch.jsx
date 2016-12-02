import React from 'react';


import Header from 'CUI/header/header';

const NoMatch = React.createClass({
  getDefaultProps() {
    return {
      title : ''
    };
  },
  propTypes: {
    title: React.PropTypes.string.isRequired
  },
  getInitialState() {
    return {
      title: ''
    };
  },
  componentWillReceiveProps(nextProps) {
    
  },
  render() {
    let styles = {
      textAlign: 'center',
      paddingTop: '200px',
      color: '#999'
    }

    return (    
      <div style={styles}>
        {this.props.title}
      </div> 
    );
  }
});

const mapStateToProps = state => {
  return {
    basicInfo: state.basicInfo
  }
}

export default NoMatch;
