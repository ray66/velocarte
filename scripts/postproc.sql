/*------------------------------------------------------------------------------
 * Ways
 *----------------------------------------------------------------------------*/
ALTER TABLE planet_osm_line DROP IF EXISTS priority;
ALTER TABLE planet_osm_line DROP IF EXISTS cycleway_left;
ALTER TABLE planet_osm_line DROP IF EXISTS cycleway_right;
ALTER TABLE planet_osm_line DROP IF EXISTS bicycle_access;
ALTER TABLE planet_osm_line DROP IF EXISTS bicycle_shared;
ALTER TABLE planet_osm_line ADD priority        integer;
ALTER TABLE planet_osm_line ADD cycleway_left   text;
ALTER TABLE planet_osm_line ADD cycleway_right  text;
ALTER TABLE planet_osm_line ADD bicycle_access  text;
ALTER TABLE planet_osm_line ADD bicycle_shared  text;

/*--- Set null values to empty value ---*/
Update planet_osm_line SET  junction = '' where junction is null;
Update planet_osm_line SET  tracktype = '' where tracktype is null;
Update planet_osm_line SET  cycleway = '' where cycleway is null;
Update planet_osm_line SET  "access" = '' where "access" is null;
Update planet_osm_line SET  "bicycle" = '' where "bicycle" is null;
Update planet_osm_line SET  psv = '' where psv is null;
Update planet_osm_line SET  bus = '' where bus is null;
Update planet_osm_line SET  tunnel = '' where tunnel is null;
Update planet_osm_line SET  highway = '' where highway is null;
Update planet_osm_line SET  waterway = '' where waterway is null;
Update planet_osm_line SET  service  = '' where service is null;
Update planet_osm_line SET  vehicle  = '' where vehicle is null;
Update planet_osm_line SET  motor_vehicle  = '' where motor_vehicle is null;
Update planet_osm_line SET  motorcar  = '' where motorcar is null;
Update planet_osm_line SET  motorcycle  = '' where motorcycle is null;
Update planet_osm_line SET  agricultural  = '' where agricultural is null;
Update planet_osm_line SET  oneway  = 'no' where oneway is null;
Update planet_osm_line SET  railway  = '' where railway is null;
Update planet_osm_line SET  "power"  = '' where "power" is null;
Update planet_osm_line SET  "bridge" = 'no' where "bridge" is null;
/*------------------------------------------------------------------------------
 * Pseudo-References VVV
 *----------------------------------------------------------------------------*/
CREATE or REPLACE FUNCTION agg_initials(text, text) RETURNS text  VOLATILE STRICT
AS $$
  DECLARE
     s1 text;
     s2 text;
  BEGIN
    s1 = substring($1 from 2 for 1);
    s2 = substring($2 from 2 for 1);
    IF s1 = lower(s1) THEN s1 = ''; END IF;
    IF s2 = lower(s2) THEN s2 = ''; END IF;
    IF  substring($1 from 1 for 1) != '(' THEN
       RETURN $1||s2 ;
    else
       RETURN s1||s2;
    END IF;
  END;
$$ LANGUAGE plpgsql;                           

DROP AGGREGATE IF EXISTS agg_initials(text);
CREATE AGGREGATE agg_initials(text)                                                                                    (                
  SFUNC = agg_initials,
  STYPE = text
);

/*--- Fix booleans ---*/
Update planet_osm_line SET  tunnel = (case when tunnel in ('yes','true','1') then 'yes'::text else tunnel::text end)
         WHERE coalesce(highway,'') != '' and tunnel in ('yes','true','1') ;

Update planet_osm_line SET  oneway = (case when oneway in ('yes','true','1') then 'yes'::text else oneway::text end)
         WHERE coalesce(highway,'') != '' and oneway in ('yes','true','1');

Update planet_osm_line SET  access = (case when access in ('yes','true','1') then 
                                                'yes'::text 
                                           when access in ('no','false','0') then 
                                                'no'::text 
                                           else 
                                                access 
                                           end)
         WHERE coalesce(highway,'') != '';

/*--- Set priority ---*/
Update planet_osm_line 
   SET priority = (CASE WHEN highway IN ('motorway', 'motorway_link') THEN 0 
                        WHEN highway IN ('trunk', 'primary','trunk_link', 'primary_link','trunk_link', 'primary_link') THEN 1 
                        WHEN highway = 'secondary' THEN 2 
                        WHEN highway = 'tertiary' THEN 3 
                        WHEN highway IN ('residential', 'unclassified','service') THEN 4
                        ELSE 5
                        END)
         WHERE coalesce(highway,'') != '';
                  
/*--- Set cycleway_left ---*/
Update planet_osm_line SET "cycleway:left" =
                  CASE WHEN ((oneway='' or oneway = 'no') and junction != 'roundabout' and cycleway = 'lane') 
                              or "cycleway:left" = 'lane' or "cycleway" = 'opposite_lane' THEN
                            'lane'::text 
                       WHEN (oneway='yes' and cycleway = 'opposite') THEN
                            'opposite'::text 
                       WHEN "cycleway:left" = 'share_busway' THEN
                            'share_busway'::text 
                       ELSE 
                            ''::text
                       END
         WHERE coalesce(highway,'') != '';
                       
/*--- Set cycleway_right ---*/
Update planet_osm_line SET "cycleway:right" =
                  CASE WHEN  cycleway = 'lane' or "cycleway:right" = 'lane' THEN
                           'lane'::text 
                       WHEN  cycleway = 'share_busway' or "cycleway:right" = 'share_busway' THEN
                           'share_busway'::text  
                       WHEN (access='no' and (psv='yes' or bus='yes') or access='psv') and bicycle='yes' THEN
                           'share_busway'
                       ELSE 
                           ''::text
                       END
         WHERE coalesce(highway,'') != '';
                       
 /*--- Set bicycle_access ---*/
Update planet_osm_line SET bicycle_access =
                  CASE WHEN highway='cycleway' THEN 'designated'
                       WHEN bicycle!='' THEN bicycle
                       WHEN highway in ('path', 'footway') and bicycle = '' THEN 'no'
                       WHEN access IN ('', 'yes', 'vehicle') and vehicle in ('', 'yes', 'designated', 'destination') THEN 'yes'
                       WHEN access ='no' and vehicle in ('yes', 'designated', 'destination') THEN 'yes'
                       ELSE 'no'
                  END
         WHERE coalesce(highway,'') != '';
                  
Update planet_osm_line SET bicycle_access = 'yes' where bicycle_access=''          WHERE coalesce(highway,'') != '';

Update planet_osm_line SET bicycle_shared =
                  CASE WHEN highway in ('path', 'footway')
                       THEN 'no'
                       WHEN coalesce(access,'yes') in ('','yes','designated', 'destination', 'vehicle','motor_vehicle','motorcar','motorcycle')
                            and coalesce(motor_vehicle,'yes') != 'no' 
                            and coalesce(motorcar,'yes')      != 'no' 
                            and coalesce(motorcycle,'yes')    != 'no'
                       THEN 'motor_vehicle'
                        WHEN    motor_vehicle not in ('', 'no') 
                             or motorcar      not in ('', 'no') 
                             or motorcycle    not in ('', 'no') 
                       THEN 'motor_vehicle'
                       WHEN access='agricultural' or agricultural='yes'
                       THEN 'agricultural'
                       WHEN access='psv' or access='no' and psv='yes'
                       THEN 'psv'
                       ELSE 'no'
                   END
         WHERE coalesce(highway,'') != '';

ALTER TABLE planet_osm_line DROP IF EXISTS in_agglo;
ALTER TABLE planet_osm_line ADD in_agglo text;

update planet_osm_line set in_agglo='no';
update planet_osm_line set in_agglo='yes' where exists (select way.osm_id,land.osm_id,land.name,land.landuse 
      from planet_osm_polygon as land, 
           planet_osm_line as way
      where land.landuse in ('military','industrial','commercial','landfill','residential','retail','construction','harbour')
      and way.osm_id=planet_osm_line.osm_id
            and st_isvalid(land.way) and st_intersects(way.way,land.way)) ;

            
update planet_osm_point set amenity='' where amenity='bicycle_parking' and  bicycle_parking='ground_slots';
update planet_osm_polygon set amenity='' where amenity='bicycle_parking' and  bicycle_parking='ground_slots';
            
/*------------------------------------------------------------------------------
 * Join connected cycleways with identical attributes
 *------------------------------------------------------------------------------*/
drop table if exists cycleways;
create table cycleways (id bigserial PRIMARY KEY, 
                        way geometry, 
                        cycleway_right text, 
                        cycleway_left text, 
                        highway text,
                        oneway text,
                        priority integer,
                        z_order integer);
insert into cycleways (cycleway_right, way, highway, oneway) 
                      (SELECT "cycleway:right", 
                              ST_Linemerge(ST_union(way)),
                              highway,
                              oneway 
                         FROM planet_osm_line 
                         WHERE "cycleway:right" !='' 
                         GROUP BY "cycleway:right",highway,oneway);
insert into cycleways (cycleway_left, way, highway, oneway) 
                      (SELECT "cycleway:left", 
                              ST_Linemerge(ST_union(way)),
                              highway,
                              oneway 
                         FROM planet_osm_line 
                         WHERE "cycleway:left" !='' 
                         GROUP BY "cycleway:left",highway,oneway);
/*------------------------------------------------------------------------------
 * Join connected cycleways with identical attributes
 *------------------------------------------------------------------------------*/
drop table if exists cycleroutes;
create table cycleroutes (id bigserial PRIMARY KEY, 
                        way geometry, 
                        "network" text, 
                        ref text,
                        route text,
                        route_name text,
                        ref_length integer);

update planet_osm_line 
   set ref = (select agg_initials(i::text) from (select regexp_split_to_table(tags->'route_name','[ '']')) as i) 
   where route='bicycle' and ref is null;                        
   
insert into cycleroutes ("network", ref, way, route, route_name, ref_length) 
                        (select "network",
                                ref,
                                ST_Linemerge(ST_union(way)),
                                route, 
                                case when exist(tags,'route_name:fr') then  tags->'route_name:fr' else  tags->'route_name' end as route_name,
                                CASE WHEN ref is not null THEN CHAR_LENGTH(ref) ELSE 0 END AS ref_length
                         from planet_osm_line where route='bicycle' and network in ('ncn','rcn','lcn')
                         group by "network",ref,route,route_name
                        );
/*------------------------------------------------------------------------------
 * Create a table with the segments of unclassified roads and tracks which are
 * outside of settlements
 *------------------------------------------------------------------------------*/
drop table small_roads;
create table small_roads (id serial PRIMARY KEY,osm_id bigint,name text,ref text,highway text,tracktype text,way geometry);
drop table small_roads2;
create table small_roads2 (id serial PRIMARY KEY,osm_id bigint,name text,ref text,highway text,tracktype text,way geometry);

insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
 (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,st_difference(l.way,p.way) 
 from (select * from planet_osm_line where highway in ('unclassified','track')) as l, 
 (select way from planet_osm_polygon where landuse in ('commercial')) as p 
 where st_isvalid(p.way) and st_intersects(l.way,p.way));

 
insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
   (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,l.way 
      from planet_osm_line as l 
      where highway in ('unclassified','track') 
            and not exists (select * from planet_osm_polygon as p where p.landuse in ('commercial') 
                                     and st_isvalid(p.way) and st_intersects(l.way,p.way)));


insert into small_roads2 (osm_id, name, ref,highway,tracktype,way) 
 (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,st_difference(l.way,p.way) 
 from (select * from small_roads) as l, 
 (select way from planet_osm_polygon where landuse in ('residential')) as p 
 where st_isvalid(p.way) and st_intersects(l.way,p.way));

insert into small_roads2 (osm_id, name, ref,highway,tracktype,way) 
   (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,l.way 
      from small_roads as l 
      where not exists (select * from planet_osm_polygon as p where p.landuse in ('residential') 
            and st_isvalid(p.way) and st_intersects(l.way,p.way)));

delete from small_roads;

insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
 (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,st_difference(l.way,p.way) 
 from (select * from small_roads2) as l, 
 (select way from planet_osm_polygon where landuse in ('industrial')) as p 
 where st_isvalid(p.way) and st_intersects(l.way,p.way));

insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
   (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,l.way 
      from small_roads2 as l 
      where not exists (select * from planet_osm_polygon as p where p.landuse in ('industrial') 
            and st_isvalid(p.way) and st_intersects(l.way,p.way)));

delete from small_roads2;
insert into small_roads2 (osm_id, name, ref,highway,tracktype,way) 
 (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,st_difference(l.way,p.way) 
 from (select * from small_roads) as l, 
 (select way from planet_osm_polygon where landuse in ('retail')) as p 
 where st_isvalid(p.way) and st_intersects(l.way,p.way));

insert into small_roads2 (osm_id, name, ref,highway,tracktype,way) 
   (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,l.way 
      from small_roads as l 
      where not exists (select * from planet_osm_polygon as p where p.landuse in ('retail') 
            and st_isvalid(p.way) and st_intersects(l.way,p.way)));

delete from small_roads;

insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
 (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,st_difference(l.way,p.way) 
 from (select * from small_roads2) as l, 
 (select way from planet_osm_polygon where landuse in ('military')) as p 
 where st_isvalid(p.way) and st_intersects(l.way,p.way));

insert into small_roads (osm_id, name, ref,highway,tracktype,way) 
   (select l.osm_id,l.name,l.ref,l.highway,l.tracktype,l.way 
      from small_roads2 as l 
      where not exists (select * from planet_osm_polygon as p where p.landuse in ('military') 
            and st_isvalid(p.way) and st_intersects(l.way,p.way)));

drop table small_roads2;



/*------------------------------------------------------------------------------
 * Polygons
 *----------------------------------------------------------------------------*/

/*--- Set null values to empty value ---*/
Update planet_osm_polygon SET  building = '' where building is null;
Update planet_osm_polygon SET  leisure = '' where leisure is null;
Update planet_osm_polygon SET  historic = '' where historic is null;
Update planet_osm_polygon SET  amenity = '' where amenity is null;
Update planet_osm_polygon SET  landuse = '' where landuse is null;
Update planet_osm_polygon SET  boundary = '' where boundary is null;
Update planet_osm_polygon SET  shop    = '' where shop is null;
Update planet_osm_polygon SET  waterway = '' where waterway is null;
Update planet_osm_polygon SET  railway  = '' where railway is null;
Update planet_osm_polygon SET  aeroway = '' where aeroway is null;
Update planet_osm_polygon SET  "power" = '' where "power" is null;
Update planet_osm_polygon SET  "natural" = '' where "natural" is null;
Update planet_osm_polygon SET  "wheelchair" = '' where "wheelchair" is null;
Update planet_osm_polygon SET  "capacity:disabled" = '0' where "capacity:disabled" is null;

/*------------------------------------------------------------------------------
 * Points
 *----------------------------------------------------------------------------*/

/*--- Set null values to empty value ---*/
Update planet_osm_point SET  leisure = '' where leisure is null;
Update planet_osm_point SET  historic = '' where historic is null;
Update planet_osm_point SET  amenity = '' where amenity is null;
Update planet_osm_point SET  shop    = '' where shop is null;
Update planet_osm_point SET  tourism = '' where tourism is null;
Update planet_osm_point SET  highway = '' where highway is null;
Update planet_osm_point SET  aeroway = '' where aeroway is null;
Update planet_osm_point SET  place = '' where place is null;
Update planet_osm_point SET  "wheelchair" = '' where "wheelchair" is null;
Update planet_osm_point SET  "capacity:disabled" = '0' where "capacity:disabled" is null;

/*------------------------------------------------------------------------------
 * POI
 *----------------------------------------------------------------------------*/

ALTER TABLE planet_osm_point   ADD poi_category text;
ALTER TABLE planet_osm_polygon ADD poi_category text;
ALTER TABLE planet_osm_point   ADD poi_type text;
ALTER TABLE planet_osm_polygon ADD poi_type text;
ALTER TABLE planet_osm_point   ADD relevance text;
ALTER TABLE planet_osm_polygon ADD relevance text;

Update planet_osm_point Set poi_category = 
      CASE WHEN amenity != '' THEN 'amenity'
           WHEN leisure != '' THEN 'leisure'
           WHEN historic != '' THEN 'historic'
           WHEN tourism != '' THEN 'tourism'
           WHEN aeroway != '' THEN 'aeroway'
           WHEN shop != '' THEN 'shop'
           WHEN tags->'office' != '' THEN 'office'
           WHEN "natural" != '' THEN 'natural'
           ELSE ''
       END 
    where name != '';
Update planet_osm_polygon Set poi_category = 
      CASE WHEN amenity != '' THEN 'amenity'
           WHEN leisure != '' THEN 'leisure'
           WHEN historic != '' THEN 'historic'
           WHEN tourism != '' THEN 'tourism'
           WHEN aeroway != '' THEN 'aeroway'
           WHEN shop != '' THEN 'shop'
           WHEN tags->'office' != '' THEN 'office'
           WHEN "natural" != '' THEN 'natural'
           ELSE ''
       END
    where name != '';
Update planet_osm_point Set poi_type = 
      CASE WHEN amenity != '' THEN amenity
           WHEN leisure != '' THEN leisure
           WHEN historic != '' THEN historic
           WHEN tourism != '' THEN tourism
           WHEN aeroway != '' THEN aeroway
           WHEN shop != '' THEN shop
           WHEN tags->'office' != '' THEN 'office'
           WHEN "natural" != '' THEN "natural"
           ELSE ''
       END
    where name != '';
Update planet_osm_polygon Set poi_type = 
      CASE WHEN amenity != '' THEN amenity
           WHEN leisure != '' THEN leisure
           WHEN historic != '' THEN historic
           WHEN tourism != '' THEN tourism
           WHEN aeroway != '' THEN aeroway
           WHEN shop != '' THEN shop
           WHEN tags->'office' != '' THEN tags->'office'
           WHEN "natural" != '' THEN "natural"
           ELSE ''
       END
    where name != '';
      

Update planet_osm_point Set relevance =
     CASE When amenity in (
                           'bicycle_parking',
                           'bicycle_rental',
                           'drinking_water',
                           'hospital',
                           'place_of_worship',
                           'police',
                           'theatre',
                           'toilets',
                           'townhall',
                           'university',
                           'exhibition_hall'
                           ) 
                  or shop='bicycle'
                  or tourism in ('camp_site',
                                 'information',
                                 'museum',
                                 'picnic_site',
                                 'viewpoint')
                  or leisure in ('sports_centre',
                                 'picnic_table',
                                 'stadium')
                  or (historic!='' and historic != 'memorial')
                  or (amenity='parking_space' and ("capacity:disabled"!='0' or wheelchair='yes'))
             Then 'high'
             When amenity in ('arts_centre',
                           'bus_station',
                           'community_centre',
                           'courthouse',
                           'fire_station',
                           'kindergarten',
                           'library',
                           'nursery',
                           'post_office',
                           'post_box',
                           'public_building',
                           'recycling',
                           'school',
                           'telephone') 
                  or (amenity='recycling' and recycling_type='centre')
                  or leisure in ('swimming_pool')
                  or "power" in ('generator')
                  or poi_type in ('ngo', 'administrative','foundation','government')
             Then 'medium'
             When amenity in ('cinema',
                              'fountain',
                              'gallery',
                              'pharmacy',
                              'taxi',
                              'waste_transfer_station'
                              ) 
               or tourism in ('artwork',
                              /*'bed_and_breakfast',*/
                              'caravan_site'
                              /*'chalet',
                              'hotel'*/)
               or (sport is not null and sport!='')
               or shop='supermarket'
               or (leisure is not null and leisure!='')
               or historic != ''
             Then 'low' 
             Else ''
             End
    where name != '';

Update planet_osm_polygon Set relevance =
     CASE When amenity in (
                           'bicycle_parking',
                           'bicycle_rental',
                           'drinking_water',
                           'hospital',
                           'place_of_worship',
                           'police',
                           'post_office',
                           'theatre',
                           'toilets',
                           'townhall',
                           'exhibition_hall',
                           'university') 
                  or shop='bicycle'
                  or tourism in ('camp_site',
                                 'information',
                                 'museum',
                                 'picnic_site',
                                 'viewpoint')
                  or leisure in ('sports_centre',
                                 'picnic_table',
                                 'stadium')
                  or (historic!='' and historic != 'memorial')
                  or (amenity='parking_space' and ("capacity:disabled"!='0' or wheelchair='yes'))
             Then 'high'
             When amenity in ('arts_centre',
                           'bus_station',
                           'community_centre',
                           'courthouse',
                           'fire_station',
                           'kindergarten',
                           'library',
                           'nursery',
                           'public_building',
                           'post_box',
                           'recycling',
                           'school',
                           'telephone',
                           'waste_transfer_station'
                           ) 
                  or (amenity='recycling' and recycling_type='centre')
                  or leisure in ('swimming_pool')
                  or "power" in ('generator')
                  or poi_type in ('ngo', 'administrative','foundation','government')
             Then 'medium'
             When amenity in ('cinema',
                              'fountain',
                              'gallery',
                              'pharmacy',
                              'taxi') 
               or tourism in ('artwork',
                              /*'bed_and_breakfast',*/
                              'caravan_site'
                              /*'chalet',
                              'hotel'*/)
               or shop='supermarket'
               or (sport is not null and sport!='')
               or (leisure is not null and leisure!='')
               or historic != ''
             Then 'low' 
             Else ''
             End
    where name != '';

Update planet_osm_polygon Set name = network where amenity = 'bicycle_rental';

