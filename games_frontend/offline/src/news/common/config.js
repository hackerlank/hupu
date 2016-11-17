/**
 * 模块配置文件
 *
 */
const settings = {
    "test":{
        "protocol": 'http',
        "host": 'test.mobileapi.hupu.com'
    },
    "pre":{
        "protocol": 'http',
        "host": 'games-pre.mobileapi.hupu.com'
    },
    "production":{
        "protocol": 'http',
        "host": 'games.mobileapi.hupu.com'
    }
}

export const name = "news"
/**
 * condition 环境变量
 *
 * test -> 测试环境
 * pre  -> 预发布
 * production  -> 生产环境
 */
export const condition = "test"

export const protocol = settings[condition]["protocol"]
export const host = settings[condition]["host"]
