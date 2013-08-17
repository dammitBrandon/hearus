function geoLocate() {
  var output = document.getElementById("latlng");

  if (!navigator.geolocation){
    output.innerHTML = "<p>Geolocation is supported";
    return;
  }

  function success(position) {
    var latitude  = position.coords.latitude;
    var longitude = position.coords.longitude;

    output.innerHTML = '<p>Lat is ' + latitude + '° <br>Lng is ' + longitude + '°';

    var img = new Image();
    img.src = "http://maps.googleapis.com/maps/api/staticmap?center=" + latitude + "," + longitude + "&zoom=13&size=300x300&sensor=false";

    output.appendChild(img);
  };

  function error() {
    output.innerHTML = "Unable to retrieve your location";
  };

  output.innerHTML = "<p>Locating...";

  navigator.geolocation.getCurrentPosition(success, error);
}
