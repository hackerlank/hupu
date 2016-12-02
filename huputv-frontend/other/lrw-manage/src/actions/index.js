/*
 * action 类型
 */

export const ADD_BASIC = 'ADD_BASIC';
export const DELETE_BASIC = 'DELETE_BASIC';

/*
 * action 创建函数
 */

export const addBasic = item => {
  return {
    type: ADD_BASIC,
    item
  }
}

export const deleteBasic = item => {
  return {
    type: DELETE_BASIC,
    item
  }
}
