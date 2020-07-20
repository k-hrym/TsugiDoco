let map_route;

function initMapRoute() {
  geocoder = new google.maps.Geocoder()

  // マップを作成
  map_route = new google.maps.Map(document.getElementById('map_route'), {
    // マップの中心に表示する場所の緯度経度を指定
    center: {
      lat: gon.places[0].latitude,
      lng: gon.places[0].longitude
    },
    zoom: 14,
  });

  // マーカーを立てる場所の緯度経度を指定
  console.log(gon.places[0]);
  for(place in gon.places){
    var  marker = `${gon.places[place].name}`;
    console.log('name:',marker);
    marker = new google.maps.Marker({
      position: {
        lat: gon.places[place].latitude,
        lng: gon.places[place].longitude
      },
      map: map_route
    });
  }

var rendererOptions = {
    suppressMarkers : true,
    map: map_route
}
// console.log('不明な変数:',google.maps.DirectionsRenderer())
var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
var directionsService = new google.maps.DirectionsService();

// 複数地点のルートを検索する
var spots = gon.places

// 2地点以上のとき
if (spots.length >= 2){
    var origin; // 開始地点
    var destination; // 終了地点
    var waypoints = []; // 経由地点

    // origin, destination, waypointsを設定する
    for (var i = 0; i < spots.length; i++) {
        spots[i] = new google.maps.LatLng(spots[i].latitude,spots[i].longitude);
        if (i == 0){
            origin = spots[i];
        } else if (i == spots.length-1){
            destination = spots[i];
        } else {
            waypoints.push({ location: spots[i], stopover: true });
        }
    }
    // リクエスト作成
    var request = {
        origin:      origin,
        destination: destination,
        waypoints: waypoints,
        travelMode:  google.maps.TravelMode.WALKING
    };
    // ルートサービスのリクエスト
    directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            // 結果を表示する
            directionsDisplay.setDirections(response);
        }
    });
  }
}
