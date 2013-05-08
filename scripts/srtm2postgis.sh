#!/bin/bash
#set verbose

psql -d osm -c 'drop table if exists contours;'
for X in *.hgt.zip; do
   echo $X
	yes | ./srtm_generate_hdr.sh $X
	unzip -u $X
	#rm -f "${X%%.zip}"
	
	
	# Import 10m contours
	rm -f "${X%%.hgt.zip}.shp" "${X%%.hgt.zip}.shx" "${X%%.hgt.zip}.dbf"
	gdal_contour -i 10 -snodata 32767 -a height "${X%%.hgt.zip}.hgt" "${X%%.hgt.zip}.shp"
	shp2pgsql -p -I -g way "${X%%.hgt.zip}" contours | psql -q osm
	shp2pgsql -a -i -g way "${X%%.hgt.zip}" contours | psql -q osm
	
	rm -f "${X%%.hgt.zip}.shp" "${X%%.hgt.zip}.shx" "${X%%.hgt.zip}.dbf"
	rm -f "${X%%.hgt.zip}.bil"
	rm -f "${X%%.hgt.zip}.hdr"
	rm -f "${X%%.hgt.zip}.prj"
	rm -f "${X%%.hgt.zip}.tif"
done

