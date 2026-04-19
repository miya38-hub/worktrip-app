// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

function loadMap() {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  const address = mapElement.dataset.address;
  if (!address) return;

  const geocoder = new google.maps.Geocoder();

  geocoder.geocode({ address: address }, function (results, status) {
    if (status === "OK") {
      const map = new google.maps.Map(mapElement, {
        zoom: 15,
        center: results[0].geometry.location,
      });

      new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
      });
    } else {
      console.log("Geocode失敗:", status);
    }
  });
}

document.addEventListener("turbo:load", function () {
  if (window.google && window.google.maps) {
    loadMap();
  }
});

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