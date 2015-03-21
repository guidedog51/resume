# Module dependencies.
express = require('express')
routes  = require('./routes')
http    = require('http')
path    = require('path')

app = express()

app.configure () ->
  # Personal info
  app.set "name"       , "Michael Conner"
  app.set "homepage"   , "www.michaelconner.com"
  app.set "email"      , "nordl2@pacbell.com"
  app.set "phone"      , "+1.510.325.2698"
  app.set 'title'      , "#{app.get('name')} — Resume"

  app.use(express.logger('dev'))
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.favicon(path.join(__dirname, '/public/img/favicon.ico')))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(path.join(__dirname, '/public')))

app.configure 'development', () ->
  app.use(express.errorHandler())

app.get('/', routes.index)

http.createServer(app).listen app.get('port'), () ->
  console.log("Express server listening on port " + app.get('port'))
