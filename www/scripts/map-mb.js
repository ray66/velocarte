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


OpenLayers.Lang["fr"] = OpenLayers.Util.applyDefaults({
    'Permalink': "Permalien",
    'Overlays': "Options",
    'Base Layer': "Choix de la carte",
    'Scale = 1 : ${scaleDenom}': "Echelle ~ 1 : ${scaleDenom}",
    'W': "O",
    'E': "E",
    'N': "N",
    'S': "S",
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
// See: http://www.maptiler.org/google-maps-coordinates-tile-bounds-projection
function mbtilesURLBase (bounds) {
   var db = "CarteVeloBase.mbtiles";
   var res = this.map.getResolution();
   var x = Math.round ((bounds.left - this.maxExtent.left) / (res * this.tileSize.w));
   var y = Math.round ((this.maxExtent.top - bounds.top) / (res * this.tileSize.h));
   var z = this.map.getZoom()+zOffset;

   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+((1 << z) - y - 1);
   
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
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+((1 << z) - y - 1);
   
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
   return this.url+"?db="+db+"&z="+z+"&x="+x+"&y="+((1 << z) - y - 1);
   
}
function changelayerListener (event) {

      console.log("changelayer", map.baseLayer.name,map.getZoom());
      if (map.baseLayer.name == "Carte Vélo"){
            //map.zoomTo (currentZoom);
      } 
      currentLayer = map.baseLayer.name;
}
function zoomendListener (event) {

   console.log("zoomend", map.baseLayer.name, map.getZoom(),map.baseLayer.zoomOffset);
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
      if (lonlat.lon < detailExtend.left || lonlat.lon > detailExtend.right
            || lonlat.lat < detailExtend.bottom || lonlat.lat > detailExtend.top){
         if (map.baseLayer.name == "Carte Vélo"){
            var saveCenter = lastCenter; // zoomTo ruft diese Funktion auf und verändert lastCenter!!!
            map.zoomTo (detailZoom-zOffset-1);
            map.setCenter(saveCenter);
         }
      }else{
         restricted = true;
         if (map.baseLayer.name == "Carte Vélo"){
            map.setOptions({restrictedExtent: detailExtend});
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
      console.log(map.baseLayer.name);
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
      if (lonlat.lon < detailExtend.left || lonlat.lon > detailExtend.right
            || lonlat.lat < detailExtend.bottom || lonlat.lat > detailExtend.top){
            return false;
      }else{
         restricted = true;
         map.setOptions({restrictedExtent: detailExtend});
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
   proj4326 = new OpenLayers.Projection("EPSG:4326");
   proj900913 = new OpenLayers.Projection("EPSG:900913");

   if (deployed){
      maxRes = 38.218514137268066;
      zoomLevels = 7;
      zOffset = 12;
      restrExtent  = new OpenLayers.Bounds.fromArray(bBox).transform(proj4326, proj900913);
      //detailExtend     = new OpenLayers.Bounds(2.86,42.68,2.92,42.71).transform(proj4326, proj900913);
      detailExtend     = new OpenLayers.Bounds.fromArray(bBoxDetail).transform(proj4326, proj900913);
      detailZoom = 16;
   }else{
   //            resolutionLevels = [76.43702827453613, 38.218514137268066, 19.1092570678711, 
   //                                9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834];
      maxRes = 38.218514137268066;
      zOffset = 12;
      zoomLevels = 7;
      restrExtent  = new OpenLayers.Bounds.fromArray(bBox).transform(proj4326, proj900913);
      detailExtend     = restrExtent;
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
            }),
      ],
      displayProjection : proj4326,
      resolutions: [38.218514137268066, 19.1092570678711, 9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834],
      projection : proj900913}
   );


   // create TMS layer using MBTiles sqlite database

   var layerBase = new OpenLayers.Layer.OSM(
      "Carte Vélo", 
      "mbtiles.php", 
      {
         getURL: mbtilesURLBase,
         attribution: "Tiles Courtesy of <a href='http://tiles.mapbox.com/mapbox/map/geography-class' target='_blank'>MapBox</a>",
         transitionEffect: "resize",
         maxResolution : maxRes,
         zoomOffset : 0, //zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: true,
            transitionEffect: "resize",
         tileOptions: {crossOriginKeyword: null},
      }
      
   );

   /*layerBase.transitionEffect = "resize";*/
   layerBase.attribution = "Crée avec <a href='http://mapnik.org/' target='_blank'>Mapnik/Tilemill</a><br/>Données cartographiques: <a href='http://www.openstreetmap.org'>OpenStreetMap</a>";

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
                     tileOptions: {crossOriginKeyword: null},
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
                     tileOptions: {crossOriginKeyword: null},
                  }
   ); 
      
   var layerBingAerial = new OpenLayers.Layer.Bing({
         name: "Bing Aerial",
         key: "AtNt88v-17pJquFnJ65g7-4PH4Q3k9LdZCobdttQ5VpaxOLfnG0UTmuBi5e620T0",
         type: "Aerial",
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
   });

   var layerOverlay1 = new OpenLayers.Layer.TMS(
      "Petites routes et chemins",
      "mbtiles.php", 
      {
         getURL: mbtilesURLChemins,
         attribution: "Tiles Courtesy of <a href='http://tiles.mapbox.com/mapbox/map/geography-class' target='_blank'>MapBox</a>",
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: false,
      }
      
   );   
   layerOverlay1.setVisibility(false);

   var layerContour = new OpenLayers.Layer.TMS(
      "Courbes de niveau",
      "mbtiles.php", 
      {
         getURL: mbtilesURLContour,
         attribution: "Tiles Courtesy of <a href='http://tiles.mapbox.com/mapbox/map/geography-class' target='_blank'>MapBox</a>",
         /*transitionEffect: "resize",*/
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
         isBaseLayer: false,
      }
   );   
   layerContour.setVisibility(false);
   var layerBoxes  = new OpenLayers.Layer.Boxes( "Boxes" );
   box = new OpenLayers.Marker.Box(detailExtend,"red",1);         
   layerBoxes.addMarker(box);
   layerBoxes.displayInLayerSwitcher = false;
 
   if (deployed){
      console.log(deployed);
      map.events.on({'moveend': moveendListener});
      //map.events.on({'movestart': moveendListener});
      map.events.on({"mousemove": mousemoveListener});
   }
   //map.events.on({'zoomend': zoomendListener});
   
   //map.events.on({"changelayer": changelayerListener});
   
   map.restrictedExtent = restrExtent;
   
   if (deployed){
      map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerOverlay1, layerContour, layerBoxes ]);
   }else{
      map.addLayers([layerBase, layerOsmMapnik, layerOsmCycle, layerBingAerial, layerOverlay1, layerContour, layerBoxes ]);
   }

   map.addControl(new OpenLayers.Control.LayerSwitcher());
   map.setCenter(new OpenLayers.LonLat((bBoxDetail[2] + bBoxDetail[0])/2, (bBoxDetail[3]+bBoxDetail[1])/2).transform(proj4326, proj900913));

   if (!map.getCenter()) {
      map.zoomToMaxExtent();
   }

}