#!/bin/bash

psql -d osm -c "copy (select st_y(way),st_x(way),name,capacity,bicycle_parking from planet_osm_point where amenity='bicycle_parking') to stdout with csv delimiter '|';"|\

awk -F\| 'BEGIN{print "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid"}\
          {if($5=="stands"){$5="Râteliers"};\
           printf $1"\t"$2"\t"$3" \tParking vélo<br>Capacité: "$4"<br>Type: "$5"\t";\
           printf "img/bicycle_parking.png\t21,25\t-10,-25\t103\n"}' > ../www/files/parkings.txt
           
           
psql -d osm -c "copy (select st_y(way),st_x(way),name,capacity,network from planet_osm_point where amenity='bicycle_rental') to stdout with csv delimiter '|';"|\

awk -F\| 'BEGIN{print "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid"}\
          {\
           printf $1"\t"$2"\t"$3" \tLocation vélos<br>Capacité: "$4"<br>Réseau: "$5"\t";\
           printf "img/bicycle_rental.png\t21,25\t-10,-25\t103\n"}'  > ../www/files/locations.txt         