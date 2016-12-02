import React, {Component, PropTypes} from 'react';
import Animate from 'rc-animate';

class Dialog extends Component {
  constructor(props) {
    super();

    this.state = {
      // 显示状态
      visible: false,
      // 标题
      title: "",
      // 内容
      children: "",
      // 取消事件
      onCancel: () => {},
      // 确认事件
      onOk: () => {},
      // 底部按扭方案
      footer: [
        "取消", "确认"
      ]
    }
  }
  componentWillMount() {
    this.setProps();
  }
  componentWillReceiveProps(nextProps) {
    this.setProps(nextProps);
  }
  setProps(props = this.props) {
    // let state = Object.assign(
    //   this.state,
    //   // {
    //   //   ...props
    //   // }
    // );

    this.setState({
      ...props
    })
  }
  /**
   * 隐藏对话框
   * @return {[type]} [description]
   */
  hideModal() {
    this.setState({
      visible: false
    })
  }
  /**
   * 确认事件
   * @return {[type]} [description]
   */
  handleOkClick() {
    this.hideModal();
    
    this.props.onOk && this.props.onOk();
  }
  /**
   * 取消事件
   * @return {[type]} [description]
   */
  handleCancelClick() {
    this.hideModal();
    this.props.onCancel && this.props.onCancel();
  }
  getMaskElement() {
    let maskElement;

     const styles = {
      // display: this.state.visible ? "block" : "none"
      // backgroundColor: "red"
    }

    if(this.state.visible) {
      maskElement = (
        <Animate
          component=""
          showProp="maskvisible"
          transitionName="fade"
          >
          {this.state.visible ? <div className="ui-modal-mask"  style={styles} /> : null}
        </Animate>
      )
    }

    return maskElement;
  }
  getDialogElement() {
    let DialogElement;

    if(this.state.visible) {
      DialogElement = (
        <div className="ui-modal-wrap">
          <div className="ui-modal">
            <div className="ui-modal-header">
              {this.state.title}
            </div>
            <div className="ui-modal-body">
              {this.state.children}
            </div>
            {
              (this.state.footer.length >= 2) ? (
                <div className="ui-modal-footer">
                  <a href="javascript:" className="ui-modal-button" onClick={this.handleCancelClick.bind(this)}>{this.state.footer[0]}</a>
                  <a href="javascript:" className="ui-modal-button" onClick={this.handleOkClick.bind(this)}>{this.state.footer[1]}</a>
                </div>
              ) : (
                <div className="ui-modal-footer">
                  <a href="javascript:" className="ui-modal-button" onClick={this.handleOkClick.bind(this)}>{this.state.footer[0]}</a>
                </div>
              )
            }
          </div>
        </div>
      );
    }

    return DialogElement;
  }
  render() {    
    return (
      <div>
        {this.getMaskElement()}
        {this.getDialogElement.call(this)}
      </div>
    );
  }
};


Dialog.propTypes = {
  visible: PropTypes.bool,
  title: PropTypes.string,
  onCancel: PropTypes.func,
  onOk: PropTypes.func,
  footer: PropTypes.array
}

export default Dialog;
