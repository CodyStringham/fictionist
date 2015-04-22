$(document).ready ->
  if (contentGrid = $ '#fictionist-grid').length
    contentGrid.imagesLoaded ->
      contentGrid.doMasonry()

    $('.filter-btn').on 'click', (e) ->
      e.preventDefault()
      $('.filter-btn').removeClass('active')
      $(@).addClass('active')
      if $(@).attr('href') == 'filter_images'
        $('.item.music').hide().parent().css({margin:0, padding:0})
        $('.item.image').show().parent().css({margin:'5px', padding:'5px'})
      else if $(@).attr('href') == 'filter_music'
        $('.item.image').hide().parent().css({margin:0, padding:0})
        $('.item.music').show().parent().css({margin:'5px', padding:'5px'})
      else if $(@).attr('href') == 'filter_all'
        $('.item.image').show().parent().css({margin:'5px', padding:'5px'})
        $('.item.music').show().parent().css({margin:'5px', padding:'5px'})
      contentGrid.doMasonry()

    $.fn.doMasonry = () ->
      contentGrid.masonry
        itemSelector: '.box'
        isFitWidth: true
        columnWidth: 100
