
#
# GET home page.
#

exports.index = (req, res) ->
  res.render 'index', title: 'Welcome', description: ''

exports.about = (req, res) ->
  res.render 'about', title: 'Aspect'

exports.pricing = (req, res) ->
  res.render 'pricing', title: 'Price Out'

exports.appointments = (req, res) ->
  res.render 'appointments', title: 'Appointments'
