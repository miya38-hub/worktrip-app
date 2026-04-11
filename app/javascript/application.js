// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "@hotwired/turbo-rails"

document.addEventListener("turbo:load", function() {

  $('#star-rating').raty({
    score: 0,
    click: function(score) {
      $('#rating-input').val(score);
    },
    starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png",
    starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png"
  });

  $('#star-wifi').raty({
    click: function(score) {
      $('#wifi-input').val(score);
    },
    starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png",
    starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png"
  });

  $('#star-power').raty({
    click: function(score) {
      $('#power-input').val(score);
    },
    starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png",
    starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png"
  });

  $('#star-quiet').raty({
    click: function(score) {
      $('#quiet-input').val(score);
    },
    starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png",
    starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png"
  });

  $('#star-work').raty({
    click: function(score) {
      $('#work-input').val(score);
    },
    starOn: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-on.png",
    starOff: "https://cdnjs.cloudflare.com/ajax/libs/raty/3.1.1/images/star-off.png"
  });

});