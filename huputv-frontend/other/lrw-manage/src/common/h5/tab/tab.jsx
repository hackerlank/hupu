import React, { Component } from 'react';
import { Link } from 'react-router';

import "./tab.scss"


class Tab extends Component {
  constructor(props) {
    super();

    this.state = {
      list: [
        {
          text: '车轮战',
          url: '/'
        },
        {
          text: '8强赛',
          url: 'semifinal'
        },
        {
          text: '战绩表',
          url: 'top'
        }
      ]
    }
  }
  componentWillMount() {
  }
  handleClick() {

  }
  render() {
    const isActive = number => {
      let name = '';

      if(this.props.active == number + 1) {
        name = 'active'
      }

      return name
    }

    return (
      <div className="ui-inner-tab">
      	<ul className="ui-inner-tab-list">
          {
            this.state.list.map((item, key) => {
              return (
                <li key={key} className={`${isActive(key)}`}>
                  <Link to={{ pathname: `${item.url}`, query: { tab: `${key}` } }} >{item.text}</Link>
                </li>
              )
            })
          }
      	</ul>
      </div>
    );
  }
};

Tab.defaultProps = {
  active: '',
}

Tab.propTypes = {
  active: React.PropTypes.string
}
export default Tab
