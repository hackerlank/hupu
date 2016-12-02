import Mock from 'mockjs';

// 登录
Mock.mock('\/zhubo\/id', 'get', {
  "code": 1,
  "msg": "操作成功",
  "data": {
    "id": "10272",
    "name": "122112",
    "lid": "11",
    "gid": "200006610",
    "cover": "http://b3.hoopchina.com.cn/wl/nativeapp/games/zhubo/images/frontCover_img.jpg",
    "cover_review": "1",
    "begin_date": null,
    "uid": "5365981",
    "anchor_nickname": "前端军哥",
    "is_relevance": "0",
    "online_plus": "0",
    "sort": "0",
    "is_casino": "0",
    "is_live": "1",
    "name_review": "1",
    "status": "0",
    "live_type": "2",
    "allow_ban_user": "0",
    "allow_nba_video": "0",
    "announce": "",
    "announce_review": "0",
    "notice": "",
    "notice_review": "0",
    "create_time": "1453278503",
    "update_time": "1461222572",
    "room_type": "29",
    "transcoding": "2500",
    "recommend": "0",
    "recommend_tag": null,
    "anchor": {
        "id": "10274",
        "uid": "5365981",
        "nickname": "nevergivejun",
        "anchor_nickname": "前端军哥",
        "status": "0",
        "create_time": "1453278503",
        "update_time": "1458804244",
        "allow_lids": "[]",
        "tips": "军哥威武",
        "following": "1"
    },
    "video": {
        "id": "265",
        "room_id": "10272",
        "push_url": "",
        "push_code": "",
        "game_url": "",
        "auth_code": "",
        "expire_time": "0",
        "icloud_id": "9f270aad0cf2cc98da10063e"
    }
  }
});
