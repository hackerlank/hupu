import React from 'react';
import ReactDOM, {render} from 'react-dom';
import Modal from './modal';

export default function (...args) {
  const title = args[0];
  const content = args[1];
  const onOk = args[2] || function(){};

  let div = document.createElement('div');
  document.body.appendChild(div);

  function close() {
    ReactDOM.unmountComponentAtNode(div);
    div.parentNode.removeChild(div);
  }

  function handleOk() {
    onOk();
    close();
  }

  render(
    <Modal
      visible
      title={title}
      onCancel={close}
      onOk={handleOk}
    >
      <div style={{ zoom: 1, overflow: 'hidden' }}>{content}</div>
  </Modal>, div);
};


