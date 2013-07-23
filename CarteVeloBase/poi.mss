/* ------------------------------------------------------------------ */
/* Icons
/* ------------------------------------------------------------------ */
.building.icon,
.ground.icon,
.point.icon{

   [poi_type='bicycle_rental']{
      [zoom>=16]{
         point-file: url('img/rental_bicycle.p.20.png');
         point-allow-overlap: true;
         point-ignore-placement: false;
      }
   }
   [poi_type='bicycle_parking']{
      [zoom>=15]{
         point-file: url('img/parking_bicycle.p.20.png');
         point-allow-overlap: true;
         point-ignore-placement: false;
      }
   }
   [poi_type='parking_space']["capacity:disabled"!='0'],
   [poi_type='parking_space'][wheelchair='yes'] {
      [zoom>=17]{
         /*point-file: url('img/parking_wheelchair_only_12.png');*/
          point-file: url('img/parking_disabled.png');
         point-allow-overlap: true;
         point-ignore-placement: false;
      }
      [zoom>=18]{
         point-file: url('img/parking_disabled.png');
      }
   }
   [poi_type='toilets']{
      [zoom>=16]{
         point-file: url('img/amenity_toilets.p.20.png');
         point-allow-overlap: true;
         point-ignore-placement: true;
      }
   }
   [poi_type='place_of_worship'][religion='christian']{
      [zoom>=15]{
         point-file: url('img/christian3.p.14.png');
         point-allow-overlap: true;
         //point-ignore-placement: true;
      }
   }
   [poi_type='school'],
   [poi_type='kindergarten']{
      [zoom>=16]{
         point-file: url('img/education_school.p.16.png');
         //point-file: url('img/school22.png');
    
         point-ignore-placement: true;
      }
      [zoom>=18]{
         point-file: url('img/education_school.p.20.png');
      }
   }
   [poi_type='post_office']{
      [zoom>=16]{
         point-file: url('img/amenity_post_office.p.16.png');
         point-ignore-placement: false;
         point-allow-overlap: false; 
      }
      [zoom>=17]{point-file: url('img/amenity_post_office.p.16.png');}
      [zoom>=18]{point-file: url('img/amenity_post_office.p.20.png');}
   }
   [poi_type='townhall']{
      [zoom>=16]{
         point-file: url('img/congress.png');
         point-ignore-placement: true;
         point-allow-overlap: false;
      }
   }
   [poi_type='police']{
      [zoom>=17]{
         point-file: url('img/police.png');
         point-ignore-placement: true;
         point-allow-overlap: false;
      }
   }

   [poi_type='courthouse']{
      [zoom>=17]{
         point-file: url('img/amenity_court.p.16.png');
         point-ignore-placement: true;
         point-allow-overlap: false;
      }
   }
   [poi_type='bicycle']{
      [zoom>=15]{
         point-file: url('img/shopping_bicycle.p.20.png');
         point-allow-overlap: true;
         point-ignore-placement: true;
      }
      [zoom>=16]{
         point-file: url('img/shopping_bicycle.p.24.png');
      }
   }
   [poi_type='picnic_site']{
      [zoom>=14]{
         point-file: url('img/tourist_picnic.p.16.png');
      }
      [zoom>=17]{
         point-file: url('img/tourist_picnic.p.20.png');
      }
   }
   [poi_type='camp_site']{
      [zoom>=14]{
         [zoom < 16]{
        	point-transform: 'scale(0.7)';
         }
         point-file: url('img/camp_site.png');
      	point-placement: interior;
         point-ignore-placement: true;
         point-allow-overlap: false;
      }
   }
   [poi_type='caravan_site']{
      [zoom>=16]{
         point-file: url('img/caravan_site.png');
      }
   }
   [poi_type='castle']{
      [zoom>=15]{
         point-file: url('img/citywalls_18.png');
         point-ignore-placement: true;
         point-allow-overlap: false;
      }
      [zoom>=17]{
         point-file: url('img/citywalls_22.png');
      }
   }
   /* [poi_type='sub_station']{
        [zoom>=16]{
        	point-file: url('img/powersubstation.png');
      		point-placement: interior;
         point-ignore-placement: true;
         point-allow-overlap: false;
    	}
    }*/
 }  
/* ------------------------------------------------------------------ */
/* Labels
/* ------------------------------------------------------------------ */
.building.label,
.ground.label,
.point.label{
      .ground[size>80000][zoom=15][poi_category!='leisure'][poi_type!='school'] ,
      .ground[size>80000][zoom=15][poi_type='park'] ,
      .ground[zoom>=16],
      .building[zoom>=16][relevance='high'][label_length<=40],
      .point[zoom>=16][relevance='high'][label_length<=40],
      .building[zoom>=17][relevance='medium'][label_length<=50],
      .point[zoom>=17][relevance='medium'][label_length<=50],
      .building[zoom>=18][relevance='low'][label_length<=30],
      .point[zoom>=18][relevance='low'][label_length<=30] {
         text-name:"[name]";
         text-wrap-width: 40;
         text-fill: #000;
         [poi_category='historic']{
            text-fill: brown;
         }
         text-face-name: "DejaVu Sans Book";
         text-halo-fill: #fff;
         text-halo-radius: 0;
         text-avoid-edges: false;
         [poi_type='bicycle_rental'],
         [poi_type='bicycle_parking'],
         [poi_type='toilets'],
         [poi_type='place_of_worship'][religion='christian'],
         [poi_type='school'],
         [poi_type='kindergarten'],
         [poi_type='post_office'],
         [poi_type='townhall'],
         [poi_type='police'],
         [poi_type='courthouse'],
         [poi_type='bicycle'],
         [poi_type='picnic_site'],
         [poi_type='camp_site'],
         [poi_type='caravan_site'],
         [poi_type='castle']{
            text-dy: 8;
         }
         [zoom>=16][relevance='high']{
            text-size: 10;
            text-placement-type: simple;
            text-placements: 'X,N,E,S,W,10,9,8';
         }
         [zoom>=17][relevance='medium']{
            text-size: 10;
            text-placement-type: simple;
            text-placements: 'X,N,S,E,W,10,9,8';
         }
         [zoom>=18][relevance='low']{
            text-size: 10;
            text-placement-type: simple;
            text-placements: 'X,N,E,S,W,10,9,8';
         }
         .ground[poi_type='park'] ,
         .ground[poi_type='sports_centre'],
         .ground[poi_type='camp_site'],{
            text-name: "[name_low_zoom]";
            text-wrap-width: 40;
            text-face-name: "DejaVu Sans Oblique";
            text-fill: #000;
            text-halo-fill: #fff;
            text-halo-radius: 1;
            text-avoid-edges: false;
            text-placement: interior;
            text-placement-type: simple;
            text-size: 12;
            text-placements: 'X,N,E,S,W,12,11,10';
            text-dy: -5;
            text-line-spacing: 0;
            [zoom>=16]{
               text-name:"[name]";
               text-wrap-width: 40;
               text-face-name: "DejaVu Sans Oblique";
               text-fill: #000;
               text-placement-type: simple;
               text-size: 11;
               text-placements: 'X,N,E,S,W,12,11,10';
               text-dy: -5;
               text-line-spacing: 0;
            }
        }
      }      

} 

