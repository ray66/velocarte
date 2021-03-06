#!/bin/bash
#-------------------------------------------------------
# Parameter:  <bbox-Datei> 
#-------------------------------------------------------
#set -v 
USAGE=`cat << 'EOF'
Usage: $0 [-r] [-i] [-o] [-b bbox] [<area>]
   -i import only
   -o overlay layers only
   -r render only
EOF`

LOG=mk_carte_velo.log
echo "$0 $*" > $LOG

MYPATH=`ls  -l $0|awk '{print $NF}'`
MYPATH=`dirname $MYPATH`

echo $MYPATH

SHARE="$MYPATH/../data/"
TILEMILL="/home/rainer/appli/node.js/node_modules/.bin//tilemill"
TILEMILL_DATA="/home/rainer/Dokumente/OSM/Render/CarteVelo"

AREA="Perpi-environs"
BBOX_TILES=""
YES=0
RENDER_ONLY=0
IMPORT_ONLY=0
OVERLAY_ONLY=0
LIGHT=0

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
  -i )
      IMPORT_ONLY=1
      ;;
  -o )
      OVERLAY_ONLY=1
      ;;
  -l )
      LIGHT=1
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

if [[ $RENDER_ONLY -eq 0 && $OVERLAY_ONLY -eq 0 ]];then
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
      cmd="osm_extract.sh"
      if [[ $LIGHT -eq 1 ]];then
         cmd="$cmd -b"
      fi
      cmd="$cmd -y -s /data/OSM/Maps/osm/languedoc-roussillon.osm.pbf -s /data/OSM/Maps/osm/midi-pyrenees.osm.pbf -s /data/OSM/Maps/osm/andorra.osm.pbf -s /data/OSM/Maps/osm/spain.osm.pbf -p $BBOXFILE"
      echo $cmd | tee>> $LOG
      eval $cmd 2>> $LOG
   fi
   export PGPASS="osm"
   # PostGis-Datenbank erstellen
   cmd="osm2pgsql -k -c -m -s -d osm -U rainer -W -H localhost $OSMFILE -S $MYPATH/osm2pgsql.style"
   echo $cmd   | tee >> $LOG
   eval $cmd 2>> $LOG

   # Datenbank nachbearbeiten
   cmd="psql -d osm  -f $MYPATH/postproc.sql"
   echo $cmd | tee >> $LOG
   eval $cmd 2>> $LOG
fi

if [[ $IMPORT_ONLY -eq 1 ]];then
   exit
fi

# Tiles generieren
TMOPTS="--format=mbtiles --files=$TILEMILL_DATA --bbox=$BBOX --metatile=8"

if [[ $OVERLAY_ONLY -eq 0 ]];then
   LAYERS="Itin Chemins Routes Base"
else
   LAYERS="Itin Chemins Routes"
fi

for LAYER in $LAYERS;do
   rm -f CarteVelo${LAYER}.mbtiles
   cmd="$TILEMILL export $TMOPTS CarteVelo${LAYER} CarteVelo${LAYER}.mbtiles"
   echo $cmd | tee >> $LOG
   eval $cmd 2>> $LOG
done
