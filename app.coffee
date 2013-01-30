
#
# Module dependencies.
#

bootstrap = require 'bootstrap-stylus'
express = require 'express'
http = require 'http'
nib = require 'nib'
path = require 'path'
routes = require './routes'
stylus = require 'stylus'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require('connect-assets')
    src: __dirname + '/public'
    buildDir: __dirname + '/public'
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', routes.index
app.get '/aspect', routes.about
app.get '/pricing', routes.pricing
app.get '/appointments', routes.appointments

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
