config =
  development:
    env: 'development'
    dbURI: 'mongodb://localhost/<%= packageName %>'

  staging:
    env: 'staging'

  production:
    env: 'production'
    dbURI: global.process.env.MONGOHQ_URL


module.exports = if global.process.env.NODE_ENV then config[global.process.env.NODE_ENV] else config.development