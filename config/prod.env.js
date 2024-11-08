'use strict'
module.exports = {
  NODE_ENV: '"production"',
  BASE_API: `"${process.env.BASE_API || 'https://admin-api.macrozheng.com'}"` // 设置一个默认值，防止变量为空
}
