import request from './request'
import Model from 'common/model'
import { isIOS, info } from 'common/app'
import { name, protocol, host } from './config'

// 默认接口数据5分钟过期, 线下测试接口可以改为0
const defaultExpire = 0 // "5m"

export const getHost = `${protocol}://${host}`

function createModel(modelName, option = {}){
    const client = isIOS ? 3 : 1
    const version = info.version
    option.url = `/${client}/${version}${option.url}`
    const storeName = `${name}_${modelName}`
    return new Model(storeName, request, option.url, option.method, option.expire)
}
/**
 * 新闻正文
 */
export const getNewsArticle = createModel("article_detail", {
    url: '/news/createNewsDetailH5',
    expire: defaultExpire
})

/**
 * 新闻评论
 */
export const getNewsComment = createModel("article_comment", {
    url: '/data/nba',
    expire: defaultExpire
})
