$ ->
  if (contentGrid = $ '#fictionist-grid').length

    contentGrid.imagesLoaded ->
      contentGrid.masonry
        itemSelector: '.box'
        isFitWidth: true
        columnWidth: 100

    $('.filter-btn').on 'click', (e) ->
      e.preventDefault()
      $('.filter-btn').removeClass('active')
      $(@).addClass('active')
      if $(@).attr('href') == 'filter_video'
        $('.item.music').hide().parent().parent().css({margin:0, padding:0})
        $('.item.photo').hide().parent().parent().css({margin:0, padding:0})
        $('.item.video').show().parent().parent().css({margin:'5px', padding:'5px'})
      else if $(@).attr('href') == 'filter_images'
        $('.item.video').hide().parent().parent().css({margin:0, padding:0})
        $('.item.music').hide().parent().parent().css({margin:0, padding:0})
        $('.item.photo').show().parent().parent().css({margin:'5px', padding:'5px'})
      else if $(@).attr('href') == 'filter_music'
        $('.item.video').hide().parent().parent().css({margin:0, padding:0})
        $('.item.photo').hide().parent().parent().css({margin:0, padding:0})
        $('.item.music').show().parent().parent().css({margin:'5px', padding:'5px'})
      else if $(@).attr('href') == 'filter_all'
        $('.item.video').show().parent().parent().css({margin:'5px', padding:'5px'})
        $('.item.photo').show().parent().parent().css({margin:'5px', padding:'5px'})
        $('.item.music').show().parent().parent().css({margin:'5px', padding:'5px'})
      contentGrid.masonry
        itemSelector: '.box'
        isFitWidth: true
        columnWidth: 100

    $('.grid-box').on 'mouseenter mouseleave', ->
      captionBox = $(@).children('.hover-caption')
      if captionBox.is(":visible")
        $(@).children('.hover-caption').fadeOut()
      else
        $(@).children('.hover-caption').fadeIn()
