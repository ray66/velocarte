   var deployed = true;

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
   var selControl;
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

function GetOsmUrl (bounds) {
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom();
   z = z+zOffset;
   var limit = Math.pow(2, z);
   if (y < 0 || y >= limit)
   {
      return null;
   } else {
      var url = this.url + z + "/" + x + "/" + y + "." + this.type;
      return this.url + z + "/" + x + "/" + y + "." + this.type;
   }
}

function mbtilesURLBase (bounds) {
   var db = "CarteVeloBase.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;

   //return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+((1 << z) - y - 1);
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
            var saveCenter = lastCenter; // zoomTo ruft diese Funktion auf und verändert lastCenter!!!
            map.zoomTo (detailZoom-zOffset-1);
            map.setCenter(saveCenter);
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

   if (deployed){
      maxRes = 38.218514137268066;
      zoomLevels = 7;
      zOffset = 12;
      restrExtent  = new OpenLayers.Bounds.fromArray(bBox).transform(proj4326, proj900913);
      //detailExtent     = new OpenLayers.Bounds(2.86,42.68,2.92,42.71).transform(proj4326, proj900913);
      detailExtent     = new OpenLayers.Bounds.fromArray(bBoxDetail).transform(proj4326, proj900913);
      if (bBoxDetail[0] <= bBox[0] || bBoxDetail[1] <= bBox[1] || bBoxDetail[2] >= bBox[2] || bBoxDetail[3] >= bBox[3]){
         detailExtent     = null;
      }
      detailZoom = 16;
   }else{
   //            resolutionLevels = [76.43702827453613, 38.218514137268066, 19.1092570678711, 
   //                                9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834];
      maxRes = 38.218514137268066;
      zOffset = 12;
      zoomLevels = 7;
      restrExtent  = new OpenLayers.Bounds.fromArray(bBox).transform(proj4326, proj900913);
      detailExtent     = restrExtent;
      detailZoom = 12;
   }
   

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
      resolutions: [38.218514137268066, 19.1092570678711, 9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834],
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
         zoomOffset : 12, //zOffset,
         numZoomLevels: zoomLevels,
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
                     zoomOffset : zOffset,
                     isBaseLayer: true,
                     transitionEffect: "resize",
                     tileOptions: {crossOriginKeyword: null}
                  }
   ); 
      
   var layerBingAerial = new OpenLayers.Layer.Bing({
         name: "Bing Aerial",
         key: "AtNt88v-17pJquFnJ65g7-4PH4Q3k9LdZCobdttQ5VpaxOLfnG0UTmuBi5e620T0",
         type: "Aerial",
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels
   });

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
   
   if (deployed){
      if (detailExtent != null){
         map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerRoutes, layerChemins, layerContour, layerBoxes ]);
      }else{
         map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerRoutes, layerChemins, layerContour ]);
      }
   }else{
      map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerBingAerial, layerRoutes, layerChemins, layerContour, layerBoxes ]);
   }

   map.addControl(new OpenLayers.Control.LayerSwitcher());
   map.setCenter(new OpenLayers.LonLat((bBoxDetail[2] + bBoxDetail[0])/2, (bBoxDetail[3]+bBoxDetail[1])/2).transform(proj4326, proj900913));

   if (!map.getCenter()) {
      map.zoomToMaxExtent();
   }

}
//------------------------------------------------------------------------------
// jQuery-Code
//------------------------------------------------------------------------------
$(document).ready(function(){

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
   // POI Layer      
   $('#poiSelect').click(function(){
        $("input[type=checkbox][class=poi]").each( 
        function() { 
          setMarkerPoi($(this).attr('id'),$(this).is(':checked'));
        } 
       );
    });
    // Track Layer
    $('#trackSelect').click(function(){
        $("input[type=checkbox][class=track]").each( 
        function() { 
          showTrack($(this).attr('id'),$(this).is(':checked'));
        } 
       );
    });

})
//------------------------------------------------------------------------------
function setMarkerPoi (poi, checked){
//------------------------------------------------------------------------------

   var layers = map.getLayersByName(poi);
   //console.log(layers);
   if (!checked){
      if (layers[0]){
         layers[0].destroy();
      }
   }else{
      if (!layers[0]){
         var pois = new OpenLayers.Layer.Text( poi,
                        { location:"./files/"+poi+".txt",
                           projection: new OpenLayers.Projection("EPSG:900913"),
                           'displayInLayerSwitcher':false,
                           selectedFeature: OpenLayers.Popup.FramedCloud
                        });
			// Darstellung der Markierungen so aehnlich wie bei Google-Maps (runde
			// Ecken, Pfeil auf die Markierung...)
         AutoSizeFramedCloud = new OpenLayers.Class(OpenLayers.Popup.FramedCloud,
            {'closeBox': true, 'autoSize': true, 'minSize': new OpenLayers.Size(120,40)}); 
            OpenLayers.Feature.prototype.popupClass = AutoSizeFramedCloud;
         map.addLayer(pois);
      }
   }
}
//------------------------------------------------------------------------------
// Overlay mit Track
//------------------------------------------------------------------------------
function showTrack (track, checked) {

   var layers = map.getLayersByName(track);
   //console.log("showTracks: ", track, checked,layers.length);
   if (!checked){
      if (layers[0]){
      	currentLayer = layers[0];
         for (var i = (currentLayer.selectedFeatures.length - 1); i >= 0; i--) {
           	var selectedFeature = currentLayer.selectedFeatures[i];
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
				feature.popup = null;
			}
      	//map.removeControl(selcontrol);
      	map.removeLayer(layers[0]);
      	//layers[0].destroyFeatures(); 
         //layers[0].destroy();
      }
   }else{
      if (!layers[0]){
      	//console.log("add track layer");
         var trackLayer = new OpenLayers.Layer.Vector(track,
                             {protocol:   new OpenLayers.Protocol.HTTP({   
                                                       url:    "files/"+track+".gpx",
                                                       format: new OpenLayers.Format.GPX({
                                                         extractWaypoints: true, 
                                                         extractAttributes: true})
                                                       }),
                              styleMap:   new OpenLayers.StyleMap({ 
                                                       strokeColor:     "darkblue", 
                                                       strokeWidth:     3, 
                                                        pointRadius:    8,
                                                       externalGraphic: "img/iconPointRouge.png",
                                                       strokeDashstyle: "solid",
                                                       strokeOpacity:   0.8}),
                              strategies: [new OpenLayers.Strategy.Fixed()],
                             //'displayInLayerSwitcher':false,
                              projection: new OpenLayers.Projection("EPSG:4326")
                              });
         // This will perform the autozoom as soon as the GPX file is loaded.
         //trackLayer.events.register("loadend", trackLayer, setExtent);
         map.addLayer (trackLayer);
			// This function creates a popup window. In this case, the popup is a cloud containing the "name" and "desc" elements from the GPX file.
			function createPopup(feature) {
            //console.log (feature.attributes);
				var lonlat = feature.geometry.getBounds().getCenterLonLat().clone();
				lonlat.transform(new OpenLayers.Projection("EPSG:900913"), new OpenLayers.Projection("EPSG:4326"));
				content = '<div><h3>' + feature.attributes.desc + '</h3>';
				if (feature.attributes.cmt){
               content = content + '<p>' + feature.attributes.cmt + '</p>'
            }
            content = content + '</div>'
				feature.popup = new OpenLayers.Popup.FramedCloud("gpx",
					feature.geometry.getBounds().getCenterLonLat(),
					null,
					content,
					null,
					true,
					function() { selcontrol.unselectAll(); }
				);
				map.addPopup(feature.popup);
				curPopup = feature.popup;
			}
 
			// This function destroys the popup when the user clicks the X.
			function destroyPopup(feature) {
				feature.popup.destroy();
				feature.popup = null;
            curPopup = feature.popup;
			}
 
			// This feature connects the click events to the functions defined above, such that they are invoked when the user clicks on the map.
			selcontrol = new OpenLayers.Control.SelectFeature(trackLayer, {
				onSelect: createPopup,
				onUnselect: destroyPopup
			});
			map.addControl(selcontrol);
			selcontrol.activate();
          
      }
   }
}
