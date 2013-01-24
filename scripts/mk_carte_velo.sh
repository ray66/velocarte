#!/bin/bash
#-------------------------------------------------------
# Parameter:  <bbox-Datei> 
#-------------------------------------------------------
#set -v 
USAGE=`cat << 'EOF'
Usage: $0 [-r] [-b bbox] [<area>]
EOF`

SHARE="$HOME/Dokumente/OSM/Render/share"
TILEMILL="/home/rainer/appli/node.js/node_modules/.bin//tilemill"
TILEMILL_DATA="/home/rainer/Dokumente/OSM/Render/CarteVelo"

AREA="Perpi-environs"
BBOX_TILES=""
YES=0
RENDER_ONLY=0

while [[ $# -gt 0 && ${1:0:1} == "-" ]]; do
  # options
  case $1 in
  -y | --yes )
      YES=1
      ;;
  -r | --render-only )
      RENDER_ONLY=1
      ;;
  -b )
      shift;
      BBOX_TILES=$1
      ;;
   *)
     echo "invalid option: $1"
     echo $USAGE
     exit
     ;;
  esac
  shift
done

if [[ $# -gt 0 ]];then
   AREA=$1
   shift
fi


if [[ $# -ne 0 ]];then
     echo $USAGE
     exit
fi

BBOXFILE="${SHARE}/${AREA}.bbox"  # für Testzwecke
OSMFILE="${AREA}.pbf"

if [[ ! -f $BBOXFILE ]] ;then
   echo "Datei $BBOXFILE nicht gefunden"
   exit
fi
BBOX=`cat $BBOXFILE | awk -F',' '{if(substr($1,1,1)!="#"){print $0;exit}}'`
echo "BBOX=$BBOX"

if [[ $RENDER_ONLY -eq 0 ]];then
   # Extrakt aus OSM-Datei erstellen
   ANSW="Y"
   echo $OSMFILE
   echo $YES
   if [[ -f $OSMFILE  && $YES -eq 0 ]];then
      beep
      read -p "$OSMFILE already exists. Overwrite[Y/N]/Abort? ([N]/Y/A) " -n 1 ANSW
      echo
   fi
   case $ANSW in
      A | a )
         exit
         ;;
      Y | y )
         ANSW="Y"
         ;;
      N | n | "" )
         ANSW="N"
         ;;
      *)
         exit
         ;;
   esac
   if [[ "$ANSW" == "Y" ]];then
      cmd="osm_extract.sh -y -s  /data/OSM/Maps/osm/languedoc-roussillon.osm.pbf -p $BBOXFILE"
      echo $cmd
      eval $cmd
   fi
   export PGPASS="osm"
   # PostGis-Datenbank erstellen
   cmd="osm2pgsql -c -m -s -d osm -U rainer -W -H localhost $OSMFILE -S $SHARE/osm2pgsql.style"
   echo $cmd
   eval $cmd

   # Datenbank nachbearbeiten
   cmd="psql -d osm  -f $SHARE/postproc.sql"
   echo $cmd
   eval $cmd
fi
# Tiles generieren
TMOPTS="--format=mbtiles --files=$TILEMILL_DATA --bbox=$BBOX --metatile=8"
rm -f CarteVeloChemins.mbtiles
cmd="$TILEMILL export $TMOPTS CarteVeloChemins CarteVeloChemins.mbtiles"
echo $cmd
eval $cmd
rm -f CarteVeloBase.mbtiles
cmd="$TILEMILL export $TMOPTS CarteVeloBase CarteVeloBase.mbtiles"
echo $cmd
eval $cmd

