import Mock from 'mockjs';

// 登录
Mock.mock('/zhubo/id', 'get', {
   'code': 1,
   'data': {
     'userId': '@STRING(number, 16)',
     'userName': '@CHINESENAME(2)'
	}
});
