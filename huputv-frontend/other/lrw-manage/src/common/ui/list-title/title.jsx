import React, {Component} from 'react';
import {Link} from 'react-router';


import "./title.scss"

class Title extends Component {  
  constructor(props) {
    super();

    this.state = {
      title: ""
    }
  }
  render() {
    return (
      <div className="ui-list-title">
        <h4>{this.props.title}</h4>
      </div>
    );
  }
};

Title.defaultProps = {
  title: ''
}

Title.propTypes = {
  title: React.PropTypes.string
}

export default Title;

