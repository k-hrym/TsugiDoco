function initMapRoute() {
  let map_route;
  var places = gon.places;

  // マップを作成
  map_route = new google.maps.Map(document.getElementById('map_route'), {
    // マップの中心に表示する場所の緯度経度を指定
    center: {
      lat: places[0].latitude,
      lng: places[0].longitude
    },
    zoom: 14,
  });

  // マーカーを立てる場所の緯度経度を指定
  for(var i = 0; i < places.length ; i ++){
    var  marker = `${places[i].name}`;
    marker = new google.maps.Marker({
      position: {
        lat: places[i].latitude,
        lng: places[i].longitude
      },
      map: map_route,
      // マーカーを1から順に採番
      icon: new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld="+ (i + 1) + "|ff7e73|000000")
    });
  }

var rendererOptions = {
    // マーカーの重複をしない
    suppressMarkers : true,
    map: map_route
}
// console.log('不明な変数:',google.maps.DirectionsRenderer())
var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
var directionsService = new google.maps.DirectionsService();

// 複数地点のルートを検索

// 2地点以上のとき
if (places.length >= 2){
    var origin; // 開始地点
    var destination; // 終了地点
    var waypoints = []; // 経由地点

    // origin, destination, waypointsを設定する
    for (var i = 0; i < places.length; i++) {
        places[i] = new google.maps.LatLng(places[i].latitude,places[i].longitude);
        if (i == 0){
            origin = places[i];
        } else if (i == places.length-1){
            destination = places[i];
        } else {
            waypoints.push({ location: places[i], stopover: true });
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
