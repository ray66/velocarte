#!/bin/bash
#
# Bereite Tiles für Veröffentlichung vor
#---------------------------------------------------------------------

# Tiles ausserhalb des Kernbereichs löschen (nur Basiskarte):
#for f in CarteVeloBase CarteVeloContour;do
for f in CarteVeloBase;do
   rm -rf $f
   mb-util ${f}.mbtiles $f
   mv -f ${f}.mbtiles ${f}-complet.mbtiles
   osm_clear_tiles.pl ~/Dokumente/OSM/Render/CarteVelo/project/data/Perpi-ville.bbox $f 17 19
   mb-util $f ${f}.mbtiles
done

#Tile-Dateien hochladen:

#for f in CarteVeloChemins CarteVeloBase CarteVeloRoutes; do
#  ftp
#done
