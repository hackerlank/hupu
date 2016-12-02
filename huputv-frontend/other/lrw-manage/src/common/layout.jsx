import React, { Component } from 'react';

class Layout extends Component {
  constructor(props) {
    super();
    this.state = {}
  }
  componentWillMount() {
  }
  componentWillReceiveProps(nextProps) {
  }
  render() {
    return (
      <div>
        {this.props.children}
      </div>
    );
  }
};

export default Layout;
