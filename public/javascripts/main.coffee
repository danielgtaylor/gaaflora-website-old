class @Pricing
  @submitWall: (contact) ->
    $.ajax
      url: '/pricing'
      type: 'POST'
      data:
        contact: contact
      success: ->
        location.reload()

class @Gallery
  @currentItem = 0
  @windowWidth = $(window).width()
  @windowHeight = $(window).height()

  @init: (items) ->
    $('#gallery').fadeIn()
    $('#gallery .autoplay i').addClass('icon-pause').removeClass('icon-play')

    @items = items
    @currentItem = 0

    $('#gallery .pane').html('').css('transform', 'none').css('width', @windowWidth * items.length)

    for item, i in items
      img = new Image()
      img.pos = i
      img.onload = ->
        #left = @pos * Gallery.windowWidth
        #left += (Gallery.windowWidth / 2) - (@width / 2)
        #$(@).css 'left', left
        #top = (Gallery.windowHeight / 2) - (@height / 2)
        #$(@).css 'top', top
        container = document.createElement 'div'
        $(container).addClass('frame').css('width', Gallery.windowWidth).append(@)
        $('#gallery .pane').append(container)

      img.src = item.src

    @autoplay()

  @autoCallback: ->
    if Gallery.currentItem < Gallery.items.length - 1
      Gallery.next()
    else
      Gallery.currentItem = 0
    Gallery.move()

  @next: ->
    @currentItem++ if @currentItem < @items.length - 1
    @move()

  @previous: ->
    @currentItem-- if @currentItem > 0
    @move()

  @move: ->
    $('#gallery .pane').css 'transform', "translateX(-#{@windowWidth * @currentItem}px)"

  @fullscreen: ->
    current = document.fullScreen or document.webkitIsFullScreen or document.mozfullScreen or document.msFullScreen
    element = current and document or document.body
    method = current and 'cancelFullScreen' or 'requestFullScreen'
    for prefix in ['', 'webkit', 'moz', 'ms']
      if prefix.length
        attr = prefix + method.charAt(0).toUpperCase() + method.slice(1)
      else
        attr = method
      if element[attr]
        $(element).resize()
        return element[attr]()

  @autoplay: ->
    if @autoInterval
      $('#gallery .autoplay i').removeClass('icon-pause').addClass('icon-play')
      clearInterval(@autoInterval)
      @autoInterval = null
      return false
    else
      $('#gallery .autoplay i').addClass('icon-pause').removeClass('icon-play')
      @autoInterval = setInterval @autoCallback, 5000
      return true

  @hide: ->
    $('#gallery').hide()
    if @autoInterval
      clearInterval(@autoInterval)
      @autoInterval = null
    @currentItem = 0
    @move()

$(document).ready ->
  $('.call').click (event) ->
    $('#phone').addClass 'show'

  $('#phone').click (event) ->
    $('#phone').removeClass 'show'
  
  $('#phone').show()

  $('#pricingWallSubmit').click (event) ->
    Pricing.submitWall $('#pricingWallValue').val()

  $('#pricingWallSkip').click (event) ->
    Pricing.submitWall ''

  $('#gallery').click (event) ->
    Gallery.hide()

  $('#gallery .prev').click (event) ->
    Gallery.previous()
    event.stopPropagation()

  $('#gallery .next').click (event) ->
    Gallery.next()
    event.stopPropagation()

  $('#gallery .fullscreen').click (event) ->
    event.stopPropagation()
    Gallery.fullscreen()

  $('#gallery .autoplay').click (event) ->
    event.stopPropagation()
    Gallery.autoplay()

  $(window).resize (event) ->
    Gallery.windowWidth = $(window).width()
    Gallery.windowHeight = $(window).height()

  $('#weddings, #events, #baby, #bands, #portraits, #around').click (event) ->
    Gallery.init [{src: '/images/guitar_800.jpg'}, {src: '/images/rings_800.jpg'}, {src: '/images/water_800.jpg'}, {src: '/images/boat_800.jpg'}]

  $(document).keydown (event) ->
    console.log event
    switch event.which
      when 27 then Gallery.hide()
      when 32 then Gallery.autoplay()
      when 39 then Gallery.next()
      when 37 then Gallery.previous()
  
# Javascripts from other services
`
// Chat
window.$zopim||(function(d,s){var z=$zopim=function(c){
z._.push(c)},$=z.s=
d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
_.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute('charset','utf-8');
$.src='//cdn.zopim.com/?y5A1C3JQQal2FlVzs2MDI5wEppKC3o7B';z.t=+new Date;$.
type='text/javascript';e.parentNode.insertBefore($,e)})(document,'script');

// Facebook
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=100850346690554";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

// Twitter
!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
`
