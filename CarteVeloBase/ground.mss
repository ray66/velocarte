.citylike.area
{
    polygon-fill: darken(#eeeeee,0%);
    line-color: darken(#eeeeee,10%);
}

.citylike.area[poi_type='school'],
.citylike.area[poi_type='college'],
.citylike.area[poi_type='university']
{
    polygon-fill: lighten(#d2caba,15%);
    line-color: lighten(#d2caba,5%);
}

.citylike.area[landuse='residential']
{
   [zoom>=12]{polygon-fill: darken(#F0ECE5,7%);line-width: 0.5; }
   [zoom>=13]{polygon-fill: darken(#F0ECE5,5%);}
   [zoom>=16]{polygon-fill: darken(#F0ECE5,5%);line-width: 1; }
   line-color: darken(#F0ECE5,17%);
}

.parklike.area{
  	[ground='forest']{
    	polygon-fill: #CBD8C3;
  	}

  	[ground='scrub']{
    	polygon-fill: lighten(#CBD8C3,5%);
  	}

  	[ground='vineyard']{
    	polygon-fill: lighten(#CBD8C3,10%);
  	}

  	[ground='orchard']{
    	polygon-fill: lighten(#CBD8C3,10%);
  	}
	[ground='grassland']{
  		polygon-fill: #DCF5D7;
   		line-width: 1;
    	line-color: lighten(#DCF5D7,15%);
    }
	[ground='park'],
	[ground='village_green']{
    	polygon-fill: #B5D29C;
	}
	[ground='cemetery']{
    	polygon-fill: #94b580;
    }
	[ground='pitch']{
  		polygon-fill: #DCF5D7;
   		line-width: 1;
    	line-color: darken(#DCF5D7,20%);
    }
}

.building .area{
   [zoom>=13]{
      polygon-fill: @color-building;
      line-color:  darken(@color-building,5%);
      line-width: 0;
   }
   [zoom=15]{
      [poi_type='place_of_worship'],
      [poi_type='townhall'],
      [poi_type='historic']{
         polygon-fill: #ababab;
      }
   }
	[zoom=16]{
  	  line-width: 0.5;
    }
	[zoom>=17]{
   	  line-width: 1;
    }  
}

/* ------------------------------------------------------------------ */
/* Place labels
/* ------------------------------------------------------------------ */
.place
{
	[place='town'][zoom<17],
	[place='city'][zoom<16], 
    [place='village'][zoom>=12][zoom<=16],
    [place='suburb'][zoom>=14][zoom<=16],
    [place='neighbourhood'][zoom>=12][zoom<=16],
    [place='hamlet'][zoom>=14][zoom<=17],
    [place='isolated_dwelling'][zoom>=14][zoom<=17],
    [place='farm'][zoom>=14][zoom<=17],
    [place='locality'][zoom>=14][zoom<=17]
    {
		text-name:"[name]";
   		text-face-name: "DejaVu Sans Bold";
    	text-halo-radius: 1;
    	text-fill: #000;
		text-placement-type: simple;
    }
	[place='city'][zoom<16]{ 
  		text-size: 15;   	
  		text-placements: 'X,E,W,15,14,13,12,10';
	}
	[place='town'][zoom<17]{ 
    	text-wrap-width: 20;
	  	text-size: 12;
  		text-placements: 'X,E,W,12,11,10';
	}

    .major[place='mountain_pass'][zoom>=13]{
        	point-file: url('img/poi_mountain_pass.p.12.png');
        	[zoom>=17]{point-file: url('img/poi_mountain_pass.p.16.png');}
            point-allow-overlap: true;
    		point-placement: interior;
			text-name:"[name]";
   			text-face-name: "DejaVu Sans Oblique";
    		text-fill: brown;
    		text-halo-radius: 1;
  			text-size: 10;   	
        	text-placement: interior;
    		text-dy: 8;
    		[zoom>=17]{text-dy: 10;}
  	    	ele/text-name: "[ele_text]";
    		ele/text-size: 9;
      		ele/text-fill: brown;
      		ele/text-dy: 6;
      		ele/text-face-name: "DejaVu Sans Oblique";
      		ele/text-halo-radius: 1;
      		ele/text-placement: interior;
      		[name != ''] {
        		ele/text-dy: 18;
        		[zoom>=17]{ele/text-dy: 22;}
    		}
      }
    .major[place='peak'][zoom>=13]{
        	point-file: url('img/peak.png');
        	point-allow-overlap: true;
    		point-placement: interior;
			text-name:"[name]";
   			text-face-name: "DejaVu Sans Oblique";
    		text-fill: brown;
    		text-halo-radius: 1;
  			text-size: 10;   	
        	text-placement: interior;
    		text-dy: 6;
  	    	ele/text-name: "[ele_text]";
    		ele/text-size: 9;
      		ele/text-fill: brown;
      		ele/text-dy: 6;
      		ele/text-face-name: "DejaVu Sans Oblique";
      		ele/text-halo-radius: 1;
      		ele/text-placement: interior;
      		[name != ''] {
        		ele/text-dy: 18;
        	}
			[zoom<=11]{
        		text-size: 9;
        		ele/text-size: 9;
          	}
         
    }	
  /*text-allow-overlap: true;*/
	[place='village'][zoom>=12][zoom<=16],
	[place='suburb'][zoom=14][zoom<=16],
  	[place='neighbourhood'][zoom>=12][zoom<=16],
    [place='hamlet'][zoom>=14][zoom<=17],
    [place='isolated_dwelling'][zoom>=14][zoom<=17],
    [place='farm'][zoom>=14][zoom<=17]
	{
	    text-wrap-character: '-';
    	text-wrap-width: 45;
    }
	[place='village'][zoom>=12][zoom<=16],
	[place='suburb'][zoom=14][zoom<=16]{
		text-face-name: "DejaVu Sans Book";
  		text-size: 14;
  		text-placements: 'X,E,W,11,10,9,8';
	}
  	[place='village'][zoom>=12][zoom<=13]  { text-size: 11; }
	[place='village'][zoom>=14][zoom<=16]  { text-size: 13; }
	[place='suburb'][zoom=14]  			   { text-size: 12; }
	[place='suburb'][zoom>=15][zoom<=16]   { text-size: 14; }
	[place='neighbourhood'][zoom>=12][zoom<=16],
    [place='hamlet'][zoom>=14][zoom<=17]
	{
	    text-face-name: "DejaVu Sans Oblique";
	  	text-size: 11;
    	text-placement: interior;
  		text-placements: 'X,E,W,11,10,9,8';
    }
    [place='isolated_dwelling'][zoom>=14][zoom<=17],
    [place='farm'][zoom>=14][zoom<=17],
    [place='locality'][zoom>=14][zoom<=17]
	{
	    text-face-name: "DejaVu Sans Oblique";
	  	text-size: 10;
    	text-placement: interior;
  		text-placements: 'X,E,W,10,10,9,8';
    }
}
/* ------------------------------------------------------------------ */
/* "Ground" labels
/* ------------------------------------------------------------------ */
.ground.label[size>80000][zoom=15][poi_category!='leisure'][poi_type!='school'] ,
.ground.label[size>80000][zoom=15][poi_type='park'] ,
.ground.label[size>25000][zoom=16][poi_category!='leisure'] ,
.ground.label[size>25000][zoom=16][poi_type='park'] ,
.ground.label[size>25000][zoom=16][poi_type='sports_centre']{
    text-name: "[name_low_zoom]";
    text-wrap-width: 40;
    text-face-name: "DejaVu Sans Book";
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
}

.ground.label[zoom>=17]{
    text-name:"[name]";
    text-wrap-width: 40;
    text-face-name: "DejaVu Sans Book";
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
}
/* ------------------------------------------------------------------ */
/* Boundaries
/* ------------------------------------------------------------------ */
#admin{
	[admin_level = '6'][zoom >= 11] {
    	line-color: purple;
    	line-width: 2;
    	line-dasharray: 6,3,2,3;
    	line-opacity: 0.3;
  	}
}
