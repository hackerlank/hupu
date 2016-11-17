let _events = {};

const Message = {
  on(eventName = "", handler){
      _events[eventName] = handler
  },
  fire(eventName = "", ...args){
    if(_events[eventName]){
      _events[eventName].apply(null, args);
    }
  }
}
export default Message
