$ ->
  $('#fictionist-grid').imagesLoaded ->
    $('#fictionist-grid').masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 100
