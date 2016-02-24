Fiber = Npm.require('fibers')
http = Meteor.npmRequire 'http'
httpProxy = Meteor.npmRequire 'http-proxy'
proxy = httpProxy.createProxyServer({})

server = http.createServer (req, res) ->
  Fiber ->

    config = Config.findOne()

    rule = Rules.findOne
      method: req.method.toLowerCase()
      url: req.url
      active: true
    ,
      sort:
        priority: 1

    unless rule
      setTimeout ->
        proxy.web req, res, target: config.target
      , config.delay
      return

    res.writeHead(rule.code, {"Content-Type": "application/json"})
    res.end(rule.body)
  .run()

server.listen(process.env.PROXY_PORT)
