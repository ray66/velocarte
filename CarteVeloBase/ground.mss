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
	.place[place='town'][zoom<17],
	.place[place='city'][zoom<16] {
		text-name:"[name]";
   		text-face-name: "DejaVu Sans Bold";
    	text-halo-radius: 1;
    	text-fill: #000;
    }
	[place='city'][zoom<16]{ 
  		text-size: 15;   	
		text-placement-type: simple;
  		text-placements: 'X,E,W,15,14,13,12,10';
	}
	[place='town'][zoom<17]{ 
	  	text-size: 12;
    	text-wrap-width: 20;
		text-placement-type: simple;
  		text-placements: 'X,E,W,12,11,10';
	}
  /*text-allow-overlap: true;*/
}

.place[place='village'][zoom>=12][zoom<=16],
.place[place='suburb'][zoom>=14][zoom<=16]
{
    text-name:"[name]";
    text-face-name: "DejaVu Sans Book";
    text-fill: #000;
  	text-halo-radius: 1;
    text-wrap-character: '-';
    text-wrap-width: 45;
}
.place[place='village'][zoom>=12][zoom<=13]  { text-size: 10; }
.place[place='village'][zoom>=14][zoom<=16]  { text-size: 12; }

.place[place='suburb'][zoom=14]  { text-size: 12; }
.place[place='suburb'][zoom>=15][zoom<=16]  { text-size: 14; }

/* ------------------------------------------------------------------ */
/* "Ground" labels
/* ------------------------------------------------------------------ */
.ground.label[size>80000][zoom=15][poi_category!='leisure'][poi_type!='school'] ,
.ground.label[size>80000][zoom=15][poi_type='park'] ,
.ground.label[size>25000][zoom=16][poi_category!='leisure'] ,
.ground.label[size>25000][zoom=16][poi_type='park'] ,
.ground.label[size>25000][zoom=16][poi_type='sports_centre'] ,
.ground.label[zoom>=17],
{
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