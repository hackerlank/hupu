import redux, { combineReducers } from 'redux';

import { ADD_BASIC, DELETE_BASIC } from 'ACTION/index'

function basicInfo(state = ADD_BASIC, action) {
  switch (action.type) {
    case ADD_BASIC:
      return action.item
    case DELETE_BASIC:
      return state
      // return state.filter(todo =>
      //   todo.id !== action.id
      // );
    default:
      return {}
  }
}

const todoApp = combineReducers({
  basicInfo
})

export default todoApp