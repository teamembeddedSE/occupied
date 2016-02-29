<script>
    $("#map").width(screen.width-15);
    $("#map").height(400);
</script>
    <script>
      function initMap() {
        var myLatLng = {lat: 58.396128, lng: 15.557189};
        var mapDiv = document.getElementById('map');
        var map = new google.maps.Map(mapDiv, {
          center: myLatLng,
          zoom: 15
        });
        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            title: 'Team Embedded!'
          });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?callback=initMap"
        async defer></script>

