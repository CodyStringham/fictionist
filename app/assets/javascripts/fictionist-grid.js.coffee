$ ->
  $('#fictionist-grid').imagesLoaded ->
    $('#fictionist-grid').masonry
      itemSelector: '.box'
      isFitWidth: true
      columnWidth: 200
      # set columnWidth a fraction of the container width
      # columnWidth: ( containerWidth ) ->
      #   return containerWidth / 5
