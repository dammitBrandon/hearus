var searchDescription = function () {
  $('div.search-description').css({"opacity": 1});
    console.log("event called!");
}

$(document).ready(function() {
  $('input#search').focus(
    searchDescription();
  )};
