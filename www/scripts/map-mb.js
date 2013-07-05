   var layerMarkers;
   var layerPois;
   var marker;
   var proj4326;
   var proj900913;
   var map;
   var restricted = false;
   var mousePixelX;
   var mousePixelY;
   var currentLayer;
   var currentZoom;
   var curPopup;



OpenLayers.Lang["fr"] = OpenLayers.Util.applyDefaults({
    'Permalink': "Permalien",
    'Overlays': "Options",
    'Base Layer': "Choix de la carte",
    'Scale = 1 : ${scaleDenom}': "Echelle ~ 1 : ${scaleDenom}",
    'W': "O",
    'E': "E",
    'N': "N",
    'S': "S"
   });


function mbtilesURLBase (bounds) {
   
   var z = this.map.getZoom()+zOffset;
/* if (z < 17) {
      var db = "CarteVeloBase_zoom_low.mbtiles";
   }else{
      var db = "CarteVeloBase_zoom_high.mbtiles";
   }*/
   var db = "CarteVeloBase.mbtiles";
      
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));

   //return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+((1 << z) - y - 1);
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+y;
   
}
function mbtilesURLItin (bounds) {
   var db = "CarteVeloItin.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+y;
}
function mbtilesURLChemins (bounds) {
   var db = "CarteVeloChemins.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;
   // Deal with Bing layers zoom difference...
   //if (this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.VirtualEarth' || this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.Bing') {
   //   console.log(z);
   //   z = z + 1;
   //}
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+y;
   
}
function mbtilesURLRoutes (bounds) {
   var db = "CarteVeloRoutes.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;
   // Deal with Bing layers zoom difference...
   //if (this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.VirtualEarth' || this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.Bing') {
   //   console.log(z);
   //   z = z + 1;
   //}
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+y;
   
}
function mbtilesURLContour (bounds) {
   var db = "CarteVeloContour.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;
   // Deal with Bing layers zoom difference...
   //if (this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.VirtualEarth' || this.map.baseLayer.CLASS_NAME == 'OpenLayers.Layer.Bing') {
   //   console.log(z);
   //   z = z + 1;
   //}
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+y;
   
}


function changelayerListener (event) {

      //console.log("changelayer", map.baseLayer.name,map.getZoom());
      if (map.baseLayer.name == "Carte Vélo"){
            //map.zoomTo (currentZoom);
      } 
      currentLayer = map.baseLayer.name;
}
function zoomendListener (event) {

   //console.log("zoomend", map.baseLayer.name, map.getZoom(),map.baseLayer.zoomOffset);
   currentZoom = map.getZoom();
}
function moveendListener (event) {
   var lastCenter;
   //if (map.baseLayer.name != "Carte Vélo"){
   //   return;
   //}

   map.events.un({'moveend': moveendListener});

   var zLevel = map.getZoom() + zOffset;     
   if( restricted && zLevel == detailZoom-1)
   {
         restricted = false;
         if (map.baseLayer.name == "Carte Vélo"){
            map.setOptions({restrictedExtent: restrExtent});
         }
   }
   if( !restricted && zLevel >= detailZoom)
   {
      pixel = new OpenLayers.Pixel(mousePixelX, mousePixelY);
      var lonlat = map.getLonLatFromPixel(pixel);
      if (lonlat.lon < detailExtent.left || lonlat.lon > detailExtent.right
            || lonlat.lat < detailExtent.bottom || lonlat.lat > detailExtent.top){
         if (map.baseLayer.name == "Carte Vélo"){
            if (lastCenter){
               var saveCenter = lastCenter; // zoomTo ruft diese Funktion auf und verändert lastCenter!!!
               map.setCenter(saveCenter);
            }
            map.zoomTo (detailZoom-zOffset-1);
         }
      }else{
         restricted = true;
         if (map.baseLayer.name == "Carte Vélo"){
            map.setOptions({restrictedExtent: detailExtent});
         }
      }
   }
   if (map.baseLayer.name == "Carte Vélo"){
      if (zLevel == detailZoom-1){
         lastCenter = map.getCenter();
      }
   }else{
      lastCenter = map.getCenter();     
   }
   map.events.on({'moveend': moveendListener});
} 
/*
function movestartListener (event) {

   if (map.baseLayer.name == "Aerial"){
      //console.log(map.baseLayer.name);
      return;
   }

   //map.events.un({'movestart': movestartListener});

   var zLevel = map.getZoom() + zOffset;     
   if( restricted && zLevel == detailZoom)
   {
         restricted = false;
         map.setOptions({restrictedExtent: restrExtent});
   }
   if( !restricted && zLevel == detailZoom-1)
   {
      pixel = new OpenLayers.Pixel(mousePixelX, mousePixelY);
      var lonlat = map.getLonLatFromPixel(pixel);
      if (lonlat.lon < detailExtent.left || lonlat.lon > detailExtent.right
            || lonlat.lat < detailExtent.bottom || lonlat.lat > detailExtent.top){
            return false;
      }else{
         restricted = true;
         map.setOptions({restrictedExtent: detailExtent});
      }
   }
   if (zLevel == detailZoom-1){
      lastCenter = map.getCenter();
   }
   //map.events.on({'movestart': movestartListener});
}
*/
function mousemoveListener(e) {
      mousePixelX = e.xy.x;
      mousePixelY = e.xy.y;
}
function init(bBox, bBoxDetail) {

// A quick solution without using regexp (to speed up a little).
var userAgent = navigator.userAgent.toString().toLowerCase();
//console.log(userAgent );
//console.log(userAgent.indexOf('msie 10.0'));
if (userAgent.indexOf('msie 10.0') > -1 ) {
   alert('Vous utilisez Internet Explorer 10.0. Cette application ne fonctionne pas correctement avec ce navigateur. Il est conseille d\'utiliser Firefox pour un fonctionnement correct.');
}



   proj4326 = new OpenLayers.Projection("EPSG:4326");
   proj900913 = new OpenLayers.Projection("EPSG:900913");

   maxRes = 76.43702827453613;
   zoomLevels = 8;
   zOffset = 11;
   restrExtent  = new OpenLayers.Bounds.fromArray(bBox).transform(proj4326, proj900913);
   //detailExtent     = new OpenLayers.Bounds(2.86,42.68,2.92,42.71).transform(proj4326, proj900913);
   detailExtent     = new OpenLayers.Bounds.fromArray(bBoxDetail).transform(proj4326, proj900913);
   if (bBoxDetail[0] <= bBox[0] || bBoxDetail[1] <= bBox[1] || bBoxDetail[2] >= bBox[2] || bBoxDetail[3] >= bBox[3]){
      detailExtent     = null;
   }
   detailZoom = 17;
   

   map = new OpenLayers.Map(
      "basicMap",
      {units: "degrees",
       controls: [
            new OpenLayers.Control.ArgParser(),
            new OpenLayers.Control.Attribution(),
            new OpenLayers.Control.Navigation(),
            new OpenLayers.Control.PanZoomBar(),
            new OpenLayers.Control.MousePosition(),
            new OpenLayers.Control.ScaleLine({geodesic: true}),
            new OpenLayers.Control.Permalink(),
            new OpenLayers.Control.Permalink('permalien'),
            new OpenLayers.Control.KeyboardDefaults(),
            new OpenLayers.Control.TouchNavigation({
               dragPanOptions: {
                  enableKinetic: true
               }
            })
      ],
      displayProjection : proj4326,
      resolutions: [76.43702827453613, 38.218514137268066, 19.1092570678711, 9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834],
      projection : proj900913}
   );

OpenLayers.Util.onImageLoadErrorColor = "transparent";
OpenLayers.Util.onImageLoadError = function() {this.src = '../img/empty.png';};
   // create TMS layer using MBTiles sqlite database
   var layerBase = new OpenLayers.Layer.OSM(
      "Carte Vélo", 
      "mbtiles.php?db=CarteVeloBase.mbtiles&z=${z}&x=${x}&y=${y}", 
      //"mbtiles.php", 
      {
         //getURL: mbtilesURLBase,
         transitionEffect: "resize",
         maxResolution : maxRes,
         zoomOffset :    zOffset,
         numZoomLevels:  zoomLevels,
         isBaseLayer: true,
            transitionEffect: "resize",
         tileOptions: {crossOriginKeyword: null}
      }
      
   );

   layerBase.transitionEffect = "resize";
   layerBase.attribution = "Données cartographiques: © les contributeurs d’<a href='http://www.openstreetmap.org'>OpenStreetMap</a>";

   layerOsmMapnik = new OpenLayers.Layer.OSM( 
                  "Openstreetmap Mapnik",
                  "",
                  {
                     maxResolution : maxRes,
                        //resolutions: [38.218514137268066, 19.1092570678711, 9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834],
                     zoomOffset : zOffset,
                     numZoomLevels: zoomLevels,
                     isBaseLayer: true,
                     transitionEffect: "resize",
                     tileOptions: {crossOriginKeyword: null}
                  }
               );
    layerOsmCycle = new OpenLayers.Layer.OSM(
               "OpenCycleMap",
               ["http://a.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png",
               "http://b.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png",
               "http://c.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png"],
                  {
                     maxResolution : maxRes,
                        //resolutions: [38.218514137268066, 19.1092570678711, 9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834],
                     zoomOffset : zOffset,
                     numZoomLevels: zoomLevels,
                     isBaseLayer: true,
                     transitionEffect: "resize",
                     tileOptions: {crossOriginKeyword: null}
                  }
   ); 
      
   /*
   var layerBingAerial = new OpenLayers.Layer.Bing({
         name: "Bing Aerial",
         key: "AtNt88v-17pJquFnJ65g7-4PH4Q3k9LdZCobdttQ5VpaxOLfnG0UTmuBi5e620T0",
         type: "Aerial",
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels
   });
   */
   var layerRoutes = new OpenLayers.Layer.OSM(
      "Petites routes",
      "mbtiles.php?db=CarteVeloRoutes.mbtiles&z=${z}&x=${x}&y=${y}", 
      {
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: false
      }
      
   );   
   layerRoutes.setVisibility(false);

   var layerItin = new OpenLayers.Layer.OSM(
      "Itinéraires cyclables",
      "mbtiles.php?db=CarteVeloItin.mbtiles&z=${z}&x=${x}&y=${y}", 
      {
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: false
      }
      
   );   
   layerItin.setVisibility(true);

   var layerChemins = new OpenLayers.Layer.OSM(
      "Chemins",
      "mbtiles.php?db=CarteVeloChemins.mbtiles&z=${z}&x=${x}&y=${y}", 
      {
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: false
      }
      
   );   
   layerChemins.setVisibility(false);

   var layerContour = new OpenLayers.Layer.OSM(
      "Courbes de niveau",
      "mbtiles.php?db=CarteVeloContour.mbtiles&z=${z}&x=${x}&y=${y}", 
      {
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels-2,
         isBaseLayer: false
      }
   );   
   layerContour.setVisibility(false);

               layerGoogle = new OpenLayers.Layer.Google(
                "Google Satellite",
                {type: google.maps.MapTypeId.SATELLITE, zoomOffset : zOffset, numZoomLevels: 22}
            )
   
   if (detailExtent != null){
      var layerBoxes  = new OpenLayers.Layer.Boxes( "Boxes" );
      box = new OpenLayers.Marker.Box(detailExtent,"red",1);         
      layerBoxes.addMarker(box);
      layerBoxes.displayInLayerSwitcher = false;
   }
   if (detailExtent != null){
      //console.log(deployed);
      map.events.on({'moveend': moveendListener});
      //map.events.on({'movestart': moveendListener});
      map.events.on({"mousemove": mousemoveListener});
   }
   //map.events.on({'zoomend': zoomendListener});
   
   //map.events.on({"changelayer": changelayerListener});
   
   map.restrictedExtent = restrExtent;
   
   if (detailExtent != null){
      map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerGoogle,  layerItin, layerRoutes, layerChemins, layerContour, layerBoxes ]);
   }else{
      map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerItin, layerRoutes, layerChemins, layerContour ]);
   }

   map.addControl(new OpenLayers.Control.LayerSwitcher());
   if (!map.getCenter()) {
      map.setCenter(new OpenLayers.LonLat((bBoxDetail[2] + bBoxDetail[0])/2, (bBoxDetail[3]+bBoxDetail[1])/2).transform(proj4326, proj900913));
   }
   if (!map.getCenter()) {
      map.zoomToMaxExtent();
   }

}
//------------------------------------------------------------------------------
// jQuery Stuff
//------------------------------------------------------------------------------

var selectedTrack;
var overlayActive = new Object();
var selControl;
var trackLayers = new Array();

$(document).ready(function(){
   
   var winHeight = $(window).height();
   var divHeight = winHeight - 30;

   $('#basicMap').height(divHeight);      
   $('#sidebar').height(divHeight);   
   $('#sidebarMini').height(divHeight);   
   $(window).bind('resize', function() {
      $('#basicMap').height(divHeight);      
      $('#sidebar').height(divHeight);   
      $('#sidebarMini').height(divHeight);   
   });   
   
   // Sidebar Open/Close
   $("#closeSidebar").click(function(){
      $("#sidebar").css("visibility", "hidden");
      $("#basicMap").css("left", "20px");
      map.updateSize();
   });

   $("#openSidebar").click(function(){
      $("#sidebar").css("visibility", "visible");
      $("#basicMap").css("left", "400px");
      map.updateSize();
   });

   // Sidebar Container
   $('.trigger').not('.trigger_active').next('.toggle_container').hide();
   $('.trigger').click( function() {
      var trig = $(this);
      if ( trig.hasClass('trigger_active') ) {
         trig.next('.toggle_container').slideToggle('800');
         trig.removeClass('trigger_active');
      } else {
         $('.trigger_active').next('.toggle_container').slideToggle('800');
         $('.trigger_active').removeClass('trigger_active');
         trig.next('.toggle_container').slideToggle('800');
         trig.addClass('trigger_active');
      };
      return false;
   });
   //--------------------------------------------------------    
   // POI Selector      
   //--------------------------------------------------------    
   $("input[type=checkbox][class=poi]").each( 
      function() { 
      $(this).attr('checked', false);  
     } 
    );
   $('#poiSelect').click(function(){
        $("input[type=checkbox][class=poi]").each( 
        function() { 
          setMarkerPoi($(this).attr('id'),$(this).is(':checked'));
        } 
       );
    });
   //--------------------------------------------------------    
   // Overlay Selection
   //--------------------------------------------------------    
   // Set all checkboxes to unchecked on startup
   $("input[type=checkbox][class=overlay]").each( 
      function() { 
         $(this).attr('checked', false);  
         overlayActive[$(this).attr('id')] = false;
     } 
    );  
   selectedOverlay = null; 
   
   //--------------------------------------------------------    
   // Circuits
   //--------------------------------------------------------    
   $('#circuitSelect').click(function(){
      /* Remove current overlay: */
      $("input[type=checkbox][class=overlay]").each(function() {
         if ($(this).is(':checked')){
            // checked item
            //console.log ('checked: ', $(this).attr('id'), overlayActive[$(this).attr('id')]);
            if (!overlayActive[$(this).attr('id')]){
               // new overlay
               createOverlay("itin", $(this).attr('id'), $(this).attr('data-color'));
               overlayActive[$(this).attr('id')] = true;
            }
         }else{
             // unchecked item
            if (overlayActive[$(this).attr('id')]){
               // remove overlay
              destroyOverlay($(this).attr('id'));
              overlayActive[$(this).attr('id')] = false;
            }
         }
      });
    });
    
   //--------------------------------------------------------    
   // Propositions
   //--------------------------------------------------------    
    $('#propositionsSelect').click(function(){
      /* Remove current overlay: */
      $("input[type=checkbox][class=overlay]").each(function() {
         if ($(this).is(':checked')){
            // checked item
            //console.log ('checked: ', $(this).attr('id'), overlayActive[$(this).attr('id')]);
            if (!overlayActive[$(this).attr('id')]){
               // new overlay
               createOverlay("itin", $(this).attr('id'), $(this).attr('data-color'));
               overlayActive[$(this).attr('id')] = true;
            }
         }else{
             // unchecked item
            if (overlayActive[$(this).attr('id')]){
               // remove overlay
              destroyOverlay($(this).attr('id'));
              overlayActive[$(this).attr('id')] = false;
            }
         }
      });
    });
    
   //--------------------------------------------------------    
   // Projets
   //--------------------------------------------------------    
    $('#projetsSelect').click(function(){
      /* Remove current overlay: */
      $("input[type=checkbox][class=overlay]").each(function() {
         if ($(this).is(':checked')){
            // checked item
            if (!overlayActive[$(this).attr('id')]){
               // new overlay
               createOverlay("itin", $(this).attr('id'), $(this).attr('data-color'));
               overlayActive[$(this).attr('id')] = true;
            }
         }else{
             // unchecked item
            if (overlayActive[$(this).attr('id')]){
               // remove overlay
              destroyOverlay($(this).attr('id'));
              overlayActive[$(this).attr('id')] = false;
            }
         }
      });
    });  
    //--------------------------------------------------------    
    // Optional sidebar
    //--------------------------------------------------------    
    $("#sidebar2").hide();
    
    $(".trackInfo a").click(function () {
       if($("#sidebar2").is(':hidden')){ 
          $("#basicMap").css("left", "340px");
          $("#sidebar2Content").html("test text text Text");
         $("#sidebar2").slideToggle("slow");
      }else{
         $("#sidebar2").slideToggle("slow");
         $("#basicMap").css("left", "170px");
      }
    });
    
    $("a.sidebar2Close").click(function () {
      $("#sidebar2").slideToggle("slow");
      $("#basicMap").css("left", "170px");

    });

    
})
//------------------------------------------------------------------------------
function setMarkerPoi (poi, checked){
//------------------------------------------------------------------------------

   layername = 'poi_' + poi;
   var layers = map.getLayersByName(layername);
   //console.log(layers);
   if (!checked){
      if (layers[0]){
         destroyOverlay(layername);
         layers[0].destroy();
         
      }
   }else{
      if (!layers[0]){

         var layer = new OpenLayers.Layer.Vector(layername, {
            strategies: [new OpenLayers.Strategy.BBOX({resFactor: 1.1})],
            protocol: new OpenLayers.Protocol.HTTP({
               url: "./files/"+poi+".txt",
               format: new OpenLayers.Format.Text(),

            }),
            'displayInLayerSwitcher':false
         }); 

         map.addLayer(layer);

         // This feature connects the click events to the functions defined above, such that they are invoked when the user clicks on the map.
         trackLayers[trackLayers.length] = layer; 
         map.removeControl(selControl);
         selControl = new OpenLayers.Control.SelectFeature(trackLayers, {
            onSelect: createPopup,
            onUnselect: destroyPopup
            //hover: true
         });
         map.addControl(selControl);
         selControl.activate();
      }
   }
}
//------------------------------------------------------------------------------
// Overlays mit Track
//------------------------------------------------------------------------------
function destroyOverlay (overlay) {
   //var layers = map.getLayersByName(new RegExp(overlay+'.*'));
   var layers = map.getLayersByName(overlay);
   for (i=0; i<layers.length; i++){
      currentLayer = layers[i];
      for (var j = (currentLayer.selectedFeatures.length - 1); j >= 0; j--) {
            var selectedFeature = currentLayer.selectedFeatures[j];
         currentLayer.selectedFeatures = OpenLayers.Util.removeItem(currentLayer.selectedFeatures, selectedFeature);
         currentLayer.renderer.eraseGeometry(selectedFeature.geometry);
      }

         if (currentLayer.selectedFeatures.length > 0) {
            currentLayer.destroySelectedFeatures();
            } else {
               currentLayer.destroyFeatures();
            } //if (currentLayer.selectedFeatures...
   
      
      if (curPopup){
         curPopup.destroy();
         curPopup = null;
      }
      //map.removeControl(selControl);
      map.removeLayer(currentLayer);
      //layers[0].destroyFeatures(); 
      //layers[0].destroy();

      for (var j = 0; j < trackLayers.length; j++) {
         if (trackLayers[j].name == currentLayer.name){
            trackLayers.splice(j,1);
            j--;
         }
      }
      map.removeControl(selControl);
      selControl = new OpenLayers.Control.SelectFeature(trackLayers, {
         onSelect: createPopup,
         onUnselect: destroyPopup
         //hover: true
      });
      map.addControl(selControl);
      selControl.activate();
   }
}   
   
function createOverlay (overlay, id, color) {   
   if (curPopup){
      curPopup.destroy();
      curPopup = null;
   }
   layer1 = addTracklayer(overlay, id, color);

   trackLayers[trackLayers.length] = layer1; 

   // This feature connects the click events to the functions defined above, such that they are invoked when the user clicks on the map.
   map.removeControl(selControl);
   selControl = new OpenLayers.Control.SelectFeature(trackLayers, {
      onSelect: createPopup,
      onUnselect: destroyPopup
      //hover: true
   });
   map.addControl(selControl);
   selControl.activate();
}
      
   // This function creates a popup window. In this case, the popup is a cloud containing the "name" and "desc" elements from the GPX file.
   function createPopup(feature) {
      empty=true;
      //console.log(feature.attributes);
      content = '<div>';
      if (feature.layer.name.substr(0,3) == "poi"){
         if (feature.attributes.title){
            content = content + '<h3>' + feature.attributes.title + '</h3>';
            empty = false;
         }
         if (feature.attributes.description){
              content = content + '<p>' + feature.attributes.description + '</p>'
              empty = false;
         }
      }else{
         if (feature.attributes.desc){
            content = content + '<h3>' + feature.attributes.desc + '</h3>';
            empty = false;
         }
         if (feature.attributes.cmt){
              cmt = feature.attributes.cmt;
              p1 = cmt.indexOf('[img ');
              if (p1 >= 0){
                 img = cmt.slice(p1);
                 p2 = img.indexOf(']');
                 if (p2 >= 0){
                    img = img.slice(5,p2);
                    cmt = cmt.slice(0,p1) + '<a href="files/tracks/images/' + img + '" target="_blank" rel="lightbox"><img src="files/tracks/thumbs/' 
                                          + img + '"></a>' + cmt.slice(p1+p2+1);
                    //console.log(cmt);
                 }
              }
              content = content + '<p>' + cmt + '</p>'
              empty = false;
         }
      }
      content = content + '</div>';
      if (!empty){
         pixel = new OpenLayers.Pixel(mousePixelX, mousePixelY);
         var lonlat = map.getLonLatFromPixel(pixel);
         feature.popup = new OpenLayers.Popup.FramedCloud("gpx",
               //feature.geometry.getBounds().getCenterLonLat(),
               lonlat,
               null,
               content,
               null,
               true, /* closeBox */
               function() { selControl.unselectAll(); }
            );
            map.addPopup(feature.popup);
            curPopup = feature.popup;
       }
   }
 
   // This function destroys the popup when the user clicks the X.
   function destroyPopup(feature) {
      if (feature.popup != null){
         feature.popup.destroy();
         feature.popup = null;
      }
      curPopup = null;
   }
   
function addTracklayer(overlay, track, trackcolor){   
   //console.log("addTracklayer",overlay, track, trackcolor);   
      
   var trackLayer = new OpenLayers.Layer.Vector(//overlay+"_"+track,
                                                track,
                             {protocol:   new OpenLayers.Protocol.HTTP({   
                                                       url:    "files/tracks/"+track+".gpx",
                                                       format: new OpenLayers.Format.GPX({
                                                         extractWaypoints: true, 
                                                         extractAttributes: true})
                                                       }),
                              styleMap:   new OpenLayers.StyleMap({ 
                                                       strokeColor:     trackcolor, 
                                                       strokeWidth:     5, 
                                                       pointRadius:    12,
                                                       graphicYOffset: -16,
                                                       externalGraphic: "img/iconInfo.png",
                                                       strokeDashstyle: "solid",
                                                       strokeOpacity:   0.7}),
                              strategies: [new OpenLayers.Strategy.Fixed()],
                              'displayInLayerSwitcher':false,
                              projection: new OpenLayers.Projection("EPSG:4326")
                              });

       
      
         map.addLayer (trackLayer);
         // This will perform the autozoom as soon as the GPX file is loaded.(merci à Nicolas Dumoulin)
         trackLayer.events.register("loadend", trackLayer, function() { this.map.zoomToExtent(this.getDataExtent()) } );

      return trackLayer;
      
          
}
