import "@hotwired/turbo-rails"
import "controllers/index"

console.log("🔥 application.js 読み込み確認");

// ========================
// Google Map
// ========================
function loadMapByLatLng() {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  const lat = parseFloat(mapElement.dataset.lat);
  const lng = parseFloat(mapElement.dataset.lng);

  if (!lat || !lng) return;

  const position = { lat, lng };

  const map = new google.maps.Map(mapElement, {
    zoom: 15,
    center: position,
  });

  new google.maps.Marker({
    position: position,
    map: map,
  });
}

document.addEventListener("turbo:load", function () {
  if (window.google && window.google.maps) {
    loadMapByLatLng();
  }
});

function initRaty() {
  if (typeof $ === "undefined") return;
  if (typeof $.fn.raty === "undefined") return;

  const setup = (selector, inputId) => {
    const el = $(selector);
    if (!el.length) return;

    // 🔥 ここ重要：毎回初期化リセット
    el.empty();

    el.raty({
      starType: 'i',
      starOn: 'fa fa-star text-warning',
      starOff: 'fa fa-star text-secondary',
      score: 0,
      click: function(score) {
        $(inputId).val(score);
        console.log("⭐ set:", inputId, score);
      }
    });
  };

  setup('#star-rating', '#rating-input');
  setup('#star-wifi', '#wifi-input');
  setup('#star-power', '#power-input');
  setup('#star-quiet', '#quiet-input');
  setup('#star-work', '#work-input');
}

// ========================
// Turbo読み込み
// ========================
document.addEventListener("turbo:load", function () {
  loadMapByLatLng();
  initRaty();
});