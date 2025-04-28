$(document).ready(function() {
  // Smooth scrolling for anchor links
  $("a").on('click', function(event) {
    if (this.hash !== "") {
      event.preventDefault();
      var hash = this.hash;
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 800);
    }
  });

  // Example: adding a hover effect to the user box
  $(".user-box").hover(
    function() {
      $(this).css("background-color", "#2980b9");
    },
    function() {
      $(this).css("background-color", "#34495e");
    }
  );
});
