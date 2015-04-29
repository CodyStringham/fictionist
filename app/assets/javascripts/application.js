//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation/foundation
//= require foundation/foundation.topbar
//= require foundation/foundation.reveal
//= require foundation/foundation.alert
//= require foundation/foundation.dropdown
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require isotope/jquery.isotope
//= require turbolinks
//= require_tree .

$(function() {
  $(document).foundation();
  Turbolinks.pagesCached(0);
});
