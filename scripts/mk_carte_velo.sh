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

AREA="PyreneesOrientales"
BBOX_TILES=""
YES=0
RENDER_ONLY=0
IMPORT_ONLY=0
OVERLAY_ONLY=0
LIGHT=0
DB=osm

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
  -d )
      shift;
      DB=$1
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

OSMFILE="${AREA}.pbf"

BBOXFILE="${SHARE}/${AREA}.bbox" 
if [[ ! -f $BBOXFILE ]] ;then
   echo "Datei $BBOXFILE nicht gefunden"
   exit
fi
BBOX=`cat $BBOXFILE | awk -F',' '{if(substr($1,1,1)!="#"){print $0;exit}}'`
echo "BBOX=$BBOX"

BBOXFILE="${SHARE}/${AREA}.bbox"
if [[ ! -f $BBOXFILE ]] ;then
   echo "Datei $BBOXFILE nicht gefunden"
   exit
fi
BBOX_DETAIL=`cat $BBOXFILE | awk -F',' '{if(substr($1,1,1)!="#"){print $0;exit}}'`
echo "BBOX_DETAIL=$BBOX_DETAIL"

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
   cmd="osm2pgsql -k -c -m -s -d $DB -U rainer -H localhost $OSMFILE -S $MYPATH/osm2pgsql.style"
   echo $cmd >> $LOG
   eval $cmd 2>&1 | tee -a $LOG

   # Datenbank nachbearbeiten
   cmd="psql -d $DB  -f $MYPATH/postproc.sql"
   echo $cmd >> $LOG
   eval $cmd 2>> $LOG | tee -a $LOG
fi

if [[ $IMPORT_ONLY -eq 1 ]];then
   exit
fi

# Tiles generieren
TMOPTS="--format=mbtiles --files=$TILEMILL_DATA --bbox=$BBOX --metatile=8"
LAYERS="Itin Chemins Routes"

for LAYER in $LAYERS;do
   TMP=`mktemp`
   awk '{if($1=="\"dbname\":"){print $1" \"$DB\","}else{print $0}}' $TILEMILL_DATA/project/CarteVelo${LAYER}/project.mml > $TMP
   mv -f $TMP $TILEMILL_DATA/project/CarteVelo${LAYER}/project.mml
   rm -f CarteVelo${LAYER}.mbtiles
   cmd="$TILEMILL export $TMOPTS --minzoom=11 --maxzoom=18 CarteVelo${LAYER} CarteVelo${LAYER}.mbtiles"
   echo $cmd | tee >> $LOG
   eval $cmd 2>> $LOG
done

if [[ $OVERLAY_ONLY -eq 0 ]];then
   LAYERS="Base"
   for LAYER in $LAYERS;do
      TMP=`mktemp`
      awk '{if($1=="\"dbname\":"){print $1" \"$DB\","}else{print $0}}' $TILEMILL_DATA/project/CarteVelo${LAYER}/project.mml > $TMP
      mv -f $TMP $TILEMILL_DATA/project/CarteVelo${LAYER}/project.mml
      rm -f CarteVelo${LAYER}_zoom_high.mbtiles
      cmd="$TILEMILL export --format=mbtiles --files=$TILEMILL_DATA --bbox=$BBOX_DETAIL --metatile=8"
      cmd="$cmd --minzoom=17 --maxzoom=18"
      cmd="$cmd CarteVelo${LAYER} CarteVelo${LAYER}_zoom_high.mbtiles"
      echo $cmd | tee >> $LOG
      eval $cmd 2>> $LOG
      
      rm -f CarteVelo${LAYER}_zoom_low.mbtiles
      cmd="$TILEMILL export --format=mbtiles --files=$TILEMILL_DATA --bbox=$BBOX --metatile=8"
      cmd="$cmd --minzoom=11 --maxzoom=16"
      cmd="$cmd CarteVelo${LAYER} CarteVelo${LAYER}_zoom_low.mbtiles"
      echo $cmd | tee >> $LOG
      eval $cmd 2>> $LOG
   done
fi

rm -rf CarteVeloBase_zoom_high
rm -rf CarteVeloBase

cmd="mb-util CarteVeloBase_zoom_high.mbtiles CarteVeloBase_zoom_high"
echo $cmd | tee >> $LOG
eval $cmd 2>> $LOG
cmd="mb-util CarteVeloBase_zoom_low.mbtiles CarteVeloBase"
echo $cmd | tee >> $LOG
eval $cmd 2>> $LOG

cp -rf CarteVeloBase_zoom_high/* CarteVeloBase

rm -f CarteVeloBase.mbtiles

cmd="mb-util CarteVeloBase CarteVeloBase.mbtiles"
echo $cmd | tee >> $LOG
eval $cmd 2>> $LOG

# rm -f CarteVeloBase_zoom*