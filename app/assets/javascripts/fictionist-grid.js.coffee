$.fn.reloadGrid = () ->
  $(@).imagesLoaded ->
    $(@).masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 100

$.fn.hideBlocks = () ->
  $(@).hide().parent().parent().css({margin:0, padding:0})

$.fn.showBlocks = () ->
  $(@).show().parent().parent().css({margin:'5px', padding:'5px'})

$ ->
  if (contentGrid = $ '#fictionist-grid').length
    contentGrid.reloadGrid()
    $('.filter-btn').on 'click', (e) ->
      e.preventDefault()
      $('.filter-btn').removeClass('active')
      $(@).addClass('active')
      if $(@).attr('href') == 'filter_video'
        $('.item.music, .item.image').hideBlocks()
        $('.item.video').showBlocks()
      else if $(@).attr('href') == 'filter_images'
        $('.item.video, .item.music').hideBlocks()
        $('.item.image').showBlocks()
      else if $(@).attr('href') == 'filter_music'
        $('.item.video, .item.image').hideBlocks()
        $('.item.music').showBlocks()
      else if $(@).attr('href') == 'filter_all'
        $('.item.video, .item.image, .item.music').showBlocks()
      contentGrid.reloadGrid()

    $('.grid-box').on 'mouseenter', ->
      $(@).children('.hover-caption').fadeIn(150)

    $('.grid-box').on 'mouseleave', ->
      $(@).children('.hover-caption').fadeOut(150)
