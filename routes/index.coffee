
#
# GET home page.
#

exports.index = (req, res) ->
  res.render 'index', title: 'Gaaflora Galleries'

exports.about = (req, res) ->
  res.render 'about', title: 'Aspect :: Gaaflora Galleries'

exports.pricing = (req, res) ->
  res.render 'pricing', title: 'Price Out :: Gaaflora Galleries'

exports.appointments = (req, res) ->
  res.render 'appointments', title: 'Appointments :: Gaaflora Galleries'
