import React, { Component } from 'react'
import { Link } from 'react-router'
import { Table, Modal } from 'antd'


class OptionModal extends Component {
  constructor(props) {
    super(props);

    this.state = {
      visible: false,
      list: []
    }
  }
  componentWillMount() {

  }
  componentWillReceiveProps(nextProps) {

  }
  handleCancel() {
    this.props.handleCancel();
  }
  render() {
    let columns = [];
    let list = [{}];

    this.props.data.map((item, index) => {
      columns.push({
        title: item.option,
        dataIndex: index,
        width: 200,
        key: index
      });

      list[0][index] = item.total_count
    });

    return (
      <div>
        <Modal
          title="具体选项"
          footer=""
          visible={this.props.visible}
          onCancel={this.handleCancel.bind(this)}
          >
            <Table
              columns={columns}
              pagination={false}
              dataSource={list}
              scroll={{ x: true }}
            />
        </Modal>
      </div>
    )
  }
}

OptionModal.defaultProps = {
  visible: false,
  handleCancel: () => {},
  data: {}
}

OptionModal.propTypes = {
  visible: React.PropTypes.bool,
  handleCancel: React.PropTypes.func,
  data: React.PropTypes.array
}

export default OptionModal;
