$.fn.reloadGrid = () ->
  $(@).imagesLoaded ->
    $(@).masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 100

$.fn.hideBlocks = () ->
  $(@).hide().parent().parent().removeClass('show-icon').css({margin:0, padding:0})

$.fn.showBlocks = () ->
  $(@).show().parent().parent().addClass('show-icon').css({margin:'5px', padding:'5px'})

$ ->
  if (contentGrid = $ '#fictionist-grid').length
    contentGrid.reloadGrid()

    videoBlocks = $('.item.video')
    imageBlocks = $('.item.image')
    musicBlocks = $('.item.music')
    lockedBlocks = $('.item.locked')
    unlockedBlocks = $('.item.unlocked')

    lockedBlocks.parent().parent().addClass("show-icon locked-block")

    $('.filter-btn').on 'click', (e) ->
      e.preventDefault()
      $('.filter-btn').removeClass('active')
      $(@).addClass('active')
      if $(@).attr('href') == 'filter_video'
        musicBlocks.hideBlocks()
        imageBlocks.hideBlocks()
        videoBlocks.showBlocks()
      else if $(@).attr('href') == 'filter_images'
        musicBlocks.hideBlocks()
        videoBlocks.hideBlocks()
        imageBlocks.showBlocks()
      else if $(@).attr('href') == 'filter_music'
        videoBlocks.hideBlocks()
        imageBlocks.hideBlocks()
        musicBlocks.showBlocks()
      else if $(@).attr('href') == 'filter_locked'
        unlockedBlocks.hideBlocks()
        lockedBlocks.showBlocks()
      else if $(@).attr('href') == 'filter_unlocked'
        lockedBlocks.hideBlocks()
        unlockedBlocks.showBlocks()
      else if $(@).attr('href') == 'filter_all'
        videoBlocks.showBlocks()
        imageBlocks.showBlocks()
        musicBlocks.showBlocks()
      contentGrid.reloadGrid()

    $('.grid-box').on 'mouseenter', ->
      $(@).children('.hover-caption').fadeIn(150)

    $('.grid-box').on 'mouseleave', ->
      $(@).children('.hover-caption').fadeOut(150)
