import React, { Component } from 'react';
import { Link } from 'react-router';
import Modal, { Toast } from 'MODAL';
import dataService from 'DATASERVICE';

import "./header.scss"

const Api = {
    matchBack: '/passerbyking/game/match/back'
};

class Header extends Component {
  constructor(props) {
    super();

    this.state = {
    }
  }
  componentWillMount() {
  }
  handleMatchBack() {
    let url = Api.matchBack;
    let params = {
      game_id: this.props.game_id
    }

    Modal.alert('确认回溯到上一场', '', () => {
      dataService
        .post(url, params)
        .then(result => {
          if(result.code == 1){
            window.location.reload();
          }
        })
    })
  }
  render() {
    return (
      <header className="ui-header">
        <a href="javascript:" onClick={this.handleMatchBack.bind(this)} className="button-match-back">回溯</a>
        <h1 className="headerline">{this.props.title}</h1>
        <Link to="bulletin" className="button-bulletin">公告</Link>
      </header>
    );
  }
};

Header.defaultProps = {
  title: '',
  game_id: 0
}

Header.propTypes = {
  title: React.PropTypes.string,
  game_id: React.PropTypes.number
}

export default Header;
