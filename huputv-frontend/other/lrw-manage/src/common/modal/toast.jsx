import React, {Component, PropTypes} from 'react';
import ReactDOM, {render} from 'react-dom';
import Animate from 'rc-animate';

class Notice extends Component {
  constructor(props) {
    super();

    this.state = {
      duration: 1.5
    }

    this.closeTimer = null;
  }
  componentWillMount() {
    // this.setProps();
  }
  componentWillReceiveProps(nextProps) {
    // this.setProps(nextProps);
  }
  componentDidMount() {
    if (this.props.duration) {
      this.closeTimer = setTimeout(() => {
        this.close();
      }, this.props.duration * 1000);
    }
  }
  clearCloseTimer() {
    if (this.closeTimer) {
      clearTimeout(this.closeTimer);
      this.closeTimer = null;
    }
  }
  close() {
    this.clearCloseTimer();
    this.props.onClose();
  }

  render() {
    const props = this.props;

    console.log(props);

    return (
      <div className="ui-notice">
        <div className="ui-notice-text">
          {props.children}
        </div>
      </div>
    );
  }
};



function Toast(content = "", duration = 1.5) {
  const div = document.createElement('div');
  document.body.appendChild(div);

  function onClose() {
    ReactDOM.unmountComponentAtNode(div);
    div.parentNode.removeChild(div);
  }

  const notification = render(
    <Notice 
      duration={duration}
      onClose={onClose}
      >
      {content}
    </Notice>, div); 
}

export default {
  show(content, duration) {
    return Toast(content, duration);
  }
};
