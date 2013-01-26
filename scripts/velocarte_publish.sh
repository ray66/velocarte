#!/bin/bash
#
# Bereite Tiles für Veröffentlichung vor
#---------------------------------------------------------------------

# Tiles ausserhalb des Kernbereichs löschen (nur Basiskarte):
for f in CarteVeloBase;do
   rm -rf $f
   mb-util ${f}.mbtiles $f
   osm_clear_tiles.pl ~/Dokumente/OSM/Render/CarteVelo/project/data/Perpi-ville.bbox $f 16 19
   rm -f ${f}.mbtiles
   mb-util $f ${f}.mbtiles
done

#Tile-Dateien hochladen:

#for f in CarteVeloChemins CarteVeloBase CarteVeloRoutes; do
#  ftp
#done