let map;

function initMap() {
  geocoder = new google.maps.Geocoder()

  // マップを作成
  map = new google.maps.Map(document.getElementById('map'), {
    // マップの中心に表示するプレイスの緯度経度を指定
    center: {
      lat: gon.place.latitude,
      lng: gon.place.longitude
    },
    zoom: 14,
  });

  // マーカーを立てるプレイスの緯度経度を指定
  marker = new google.maps.Marker({
    position: {
      lat: gon.place.latitude,
      lng: gon.place.longitude
    },
    map: map
  });
}
