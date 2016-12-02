import React, {Component} from 'react';
import {Link , hashHistory} from 'react-router';
import "./header.scss"


class Header extends Component {
  constructor(props) {
    super();

    this.state = {
      game_id: 1,
      title: ''
    }
  }
  componentWillMount() {
  }
  handreFresh(e) {   
    window.location.reload();
    //console.log(hashHistory);
  }
  render() {
    return (
      <header className="ui-header">        
          <h1 className="headerline">{this.props.title}</h1>
        <a href="javascript:" className="button-refresh" onClick={this.handreFresh.bind(this)}></a>           
      </header>
    );
  }
};

Header.defaultProps = {
  title: '',
 
}

Header.propTypes = {
  title: React.PropTypes.string,
}
export default Header
