velocarte
=========

This repository contains the tools and files for the rendering and pulishing of the cycling-oriented, 
OpenStreetMap based slippy map at http://velocarte66.fr.

Requirements:
   - osm2pgsql
   - PostgreSql 9.1.9
   - PostGis 1.5
   - Mapnik 2.1
   - Tilemill 0.10.1
   - OpenLayers 2.11

The map is composed of several layers:

   - CarteVeloBase    - the base layer
   - CarteVeloItin    - cyclotourism itineraries
   - CarteVeloRoutes  - Small roads overlay
   - CarteVeloChemins - Tracks overlay
   - CarteVeloContour - Contour lines
   
The map is created under Linux with the following tool chain:

   - creation of a coast line shape file:
       . download the file land-polygons-split-4326.zip from http://data.openstreetmapdata.com/
       . open the file with QGis: Layer - Add vector layer
       . select the polygons which cover the area of the map
       . save the selection with "Layer - save selection as vector file" as CarteVeloBase/layers/land/coast.shp
       
   - create a file default.bbox for the map area in the data subdirectory. Have a look at the sample files for the format.
   
   - launch the mk_cartevelo.sh script. This should do the job. 
   
   
TODO:
   - describe ho to create the contour lines layer