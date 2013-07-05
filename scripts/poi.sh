#!/bin/bash
# Parkings vélo
psql -d osm -c "copy (select st_y(way),st_x(way),name,capacity,bicycle_parking from planet_osm_point where amenity='bicycle_parking' UNION select st_y(way),st_x(way),name,capacity,bicycle_parking from planet_osm_polygon where amenity='bicycle_parking' UNION select st_y(st_centroid(way)),st_x(st_centroid(way)),name,capacity,network from planet_osm_polygon where amenity='bicycle_parking') to stdout with csv delimiter '|';"|\

awk -F\| 'BEGIN{print "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid"}\
          {if($5=="stands"){$5="Râteliers"};\
           printf $1"\t"$2"\t"$3" \tParking vélo<br>Capacité: "$4"<br>Type: "$5"\t";\
           printf "img/bicycle_parking.png\t21,25\t-10,-25\t103\n"}' > ../www/files/parkings.txt
           
# Location vélo     
psql -d osm -c "copy (select st_y(way),st_x(way),name,capacity,network from planet_osm_point where amenity='bicycle_rental' UNION select st_y(st_centroid(way)),st_x(st_centroid(way)),name,capacity,network from planet_osm_polygon where amenity='bicycle_rental') to stdout with csv delimiter '|';"|\

awk -F\| 'BEGIN{print "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid"}\
          {\
           printf $1"\t"$2"\tLocation vélos\t"$3"<br>Capacité: "$4"<br>Réseau: "$5"\t";\
           printf "img/bicycle_rental.png\t21,25\t-10,-25\t103\n"}'  > ../www/files/locations.txt      
           
# Magasins/Ateliers vélo
           psql -d osm -c "copy (select st_y(way),st_x(way),name,operator from planet_osm_point where shop='bicycle' UNION select st_y(st_centroid(way)),st_x(st_centroid(way)),name,operator from planet_osm_polygon where shop='bicycle') to stdout with csv delimiter '|';"|\

awk -F\| 'BEGIN{print "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid"}\
          {\
           printf $1"\t"$2"\tMagasin vélo\t"$3"<br>"$4"\t";\
           printf "img/bicycle_shop.png\t21,25\t-10,-25\t103\n"}'  > ../www/files/shops.txt         
