
#
# GET home page.
#

mailer = require 'nodemailer'
mailTransport = mailer.createTransport('sendmail')


exports.index = (req, res) ->
  res.render 'index', title: 'Welcome', description: ''

exports.about = (req, res) ->
  res.render 'about', title: 'Aspect'

exports.pricing = (req, res) ->
  res.render 'pricing',
    title: 'Price Out'
    submittedPricing: req.cookies.submittedPricing

exports.pricingInfo = (req, res) ->
  userInfo = req.body.contact

  res.cookie 'submittedPricing', true

  if userInfo
    mail =
      from: 'noreply@gaaflora.com'
      to: 'gaaflora@gmail.com'
      subject: "[gaaflora] User visited pricing page (#{userInfo})"
      text: "Kari,\n\nA new user has visited the pricing page!\n\n\t#{userInfo}\n\nYou may contact the user with the above email or phone number."

    mailTransport.sendMail mail, (error, response) ->
      if error
        console.log error
        res.json
          status: 'error'
      else
        res.json
          status: 'success'
  else
    res.json
      status: 'success'

exports.appointments = (req, res) ->
  res.render 'appointments', title: 'Appointments'
