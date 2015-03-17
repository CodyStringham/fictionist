$ ->
  $('#fictionist-grid').imagesLoaded ->
    $('#fictionist-grid').masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 100

  $('.filter-btn').on 'click', (e) ->
    e.preventDefault()
    $('.filtered-thing').remove()
    $('#fictionist-grid').masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 100
