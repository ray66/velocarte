   var deployed = false;

   var layerMarkers;
   var layerPois;
   var marker;
   var proj4326;
   var proj900913;
   var map;
   var restricted = false;
   var mousePixelX;
   var mousePixelY;


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
function moveendListener (event) {

   if (map.baseLayer.name == "Aerial"){
      console.log(map.baseLayer.name);
      return;
   }

   map.events.un({'moveend': moveendListener});

   var zLevel = map.getZoom() + zOffset;     
   if( restricted && zLevel == detailZoom-1)
   {
         restricted = false;
         map.setOptions({restrictedExtent: restrExtent});
   }
   if( !restricted && zLevel == detailZoom)
   {
      pixel = new OpenLayers.Pixel(mousePixelX, mousePixelY);
      var lonlat = map.getLonLatFromPixel(pixel);
      if (lonlat.lon < detailExtend.left || lonlat.lon > detailExtend.right
            || lonlat.lat < detailExtend.bottom || lonlat.lat > detailExtend.top){
            var saveCenter = lastCenter; // zoomTo ruft diese Funktion auf und verändert lastCenter!!!
            map.zoomTo (zLevel-zOffset-1);
            map.setCenter(saveCenter);
      }else{
         restricted = true;
         map.setOptions({restrictedExtent: detailExtend});
      }
   }
   if (zLevel == detailZoom-1){
      lastCenter = map.getCenter();
   }
   map.events.on({'moveend': moveendListener});
} 
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
function mousemoveListener(e) {
      mousePixelX = e.xy.x;
      mousePixelY = e.xy.y;
}

function init() {
   proj4326 = new OpenLayers.Projection("EPSG:4326");
   proj900913 = new OpenLayers.Projection("EPSG:900913");

   var options = {
         units: "degrees",
         controls: [
               new OpenLayers.Control.ArgParser(),
               new OpenLayers.Control.Attribution(),
               new OpenLayers.Control.Navigation(),
               new OpenLayers.Control.PanZoomBar(),
               //new OpenLayers.Control.LayerSwitcher(),
               //new OpenLayers.Control.Measure(),
               new OpenLayers.Control.MousePosition(),
               new OpenLayers.Control.ScaleLine({geodesic: true}),
               new OpenLayers.Control.Permalink(),
               new OpenLayers.Control.Permalink('permalien'),
               new OpenLayers.Control.KeyboardDefaults(),
               // new
               new OpenLayers.Control.TouchNavigation({
                  dragPanOptions: {
                     enableKinetic: true
                  }
               }),
            ],
         displayProjection : proj4326,
         projection : proj900913,
   };

   //OpenLayers.Util.onImageLoadErrorColor = "transparent"; 

   map = new OpenLayers.Map("basicMap", options);
   if (deployed){
      maxRes = 38.218514137268066;
      zoomLevels = 6;
      zOffset = 12;
      restrExtent = new OpenLayers.Bounds(2.656,42.569,3.046,42.801).transform(proj4326, proj900913);
      //detailExtend     = new OpenLayers.Bounds(2.86,42.68,2.92,42.71).transform(proj4326, proj900913);
      detailExtend     = new OpenLayers.Bounds(2.767,42.649,2.987,42.757).transform(proj4326, proj900913);
      detailZoom = 15;
   }else{
   //            resolutionLevels = [76.43702827453613, 38.218514137268066, 19.1092570678711, 
   //                                9.55462853393555,4.77731426696777,2.3886571335,1.1943285667,0.5971642834];
      maxRes = 38.218514137268066;
      zOffset = 12;
      zoomLevels = 7;
      restrExtent  = new OpenLayers.Bounds(2.656,42.569,3.046,42.801).transform(proj4326, proj900913);
      detailExtend     = restrExtent;
      detailZoom = 12;
   }
   var layerBase = new OpenLayers.Layer.OSM(
      "Carte",
      "CarteVeloBase/${z}/${x}/${y}.png",
      {
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
            transitionEffect: "resize",
         tileOptions: {crossOriginKeyword: null},
      });
   layerBase.transitionEffect = "resize";
   layerBase.attribution = "Crée avec <a href='http://mapnik.org/' target='_blank'>Mapnik/Tilemill</a><br/>Données cartographiques: <a href='http://www.openstreetmap.org'>OpenStreetMap</a>";
   var layerBingAerial = new OpenLayers.Layer.Bing({
         name: "Aerial",
         key: "AtNt88v-17pJquFnJ65g7-4PH4Q3k9LdZCobdttQ5VpaxOLfnG0UTmuBi5e620T0",
         type: "Aerial",
         maxResolution : maxRes,
         zoomOffset : zOffset,
         numZoomLevels: zoomLevels,
   });

   var layerOverlay1 = new OpenLayers.Layer.TMS(
      "Petites routes et chemins",
      "CarteVeloChemins/",
      {
         type:'png',
            getURL: GetOsmUrl,
            maxResolution : maxRes,
            displayOutsideMaxExtent: true,
            'buffer':1,
        isBaseLayer: false,
         tileOptions: {crossOriginKeyword: null},
      });
   layerOverlay1.setVisibility(false);

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

   map.restrictedExtent = restrExtent;
   
   if (deployed){
      map.addLayers([layerBase, layerOverlay1, layerBoxes]);
   }else{
     map.addLayers([layerBase, layerBingAerial, layerOverlay1, layerBoxes]);
   }

   map.addControl(new OpenLayers.Control.LayerSwitcher());
   if (!map.getCenter()) {
      map.zoomToMaxExtent();
   }

}