#ground
{
    //polygon-fill: darken(#eeeeee,0%);
    //line-color: darken(#eeeeee,10%);
    polygon-fill: @color_lu_industrial;
    [power='generator'],
    [power='station'], 
    [power='sub_station']{
    	polygon-fill: gainsboro;
    }
	[poi_type='school'],
	[poi_type='college'],
	[poi_type='university']{
    	polygon-fill: lighten(#d2caba,15%);
    	line-color: lighten(#d2caba,5%);
	}

	[landuse='residential']{
	   //[zoom>=12]{polygon-fill: darken(#F0ECE5,7%);line-width: 0.5; }
   		//[zoom>=13]{polygon-fill: darken(#F0ECE5,5%);}
   		//[zoom>=16]{polygon-fill: darken(#F0ECE5,5%);line-width: 1; }
   		//line-color: darken(#F0ECE5,17%);
  		polygon-fill: @color_lu_residential;
	}
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
	[ground='village_green'],
    [ground='camp_site']{
    	polygon-fill: #B5D29C;
       	line-color: darken(#B5D29C,15%);
	}
	[ground='cemetery']{
    	polygon-fill: #94b580;
    }
	[ground='stadium']{
  		polygon-fill: #91DCAA;
   		line-width: 0.5;
    }
   [ground='pitch']{
        polygon-fill: #DCF5D7;
        line-width: 0.5;
        [zoom>=17]{line-width: 1;}
        line-color: darken(#DCF5D7,20%);
    }
  
	[ground='track']{
        //[sport='athletics']{
      	//	polygon-fill: lighten(#bb2244,20%);
        //}
  		polygon-fill: darken(#DCF5D7,5%);
   		line-width: 0.5;
    	[zoom>=17]{line-width: 1;}
    	line-color: darken(#DCF5D7,20%);
    }
}

#building_area{
   [zoom>=13]{
      polygon-fill: @color-building;
      //line-color:  darken(@color-building,5%);
      line-color:  @color_building_line;
      line-width: 0;
      [relevance='high'],
      [relevance='medium']{
         polygon-fill: #ababab;
		 [zoom>=17]{
        	polygon-fill: lighten(#ababab,10%);
         }
      }
   }
	[zoom=15]{
  	  line-width: 0.8;
    }
	[zoom=16]{
  	  //line-width: 0.5;
  	  line-width: 1;
    }
	[zoom>=17]{
   	  line-width: 1;
    }  
}
/* ------------------------------------------------------------------ */
/* Barrier lines
/* ------------------------------------------------------------------ */
#barrier_line{
  [barrier='city_wall'][zoom>=13]{
    line-width: 1;
	[zoom>=15]{ line-width: 1.5;}
	[zoom>=16]{ line-width: 1.5;}
	[zoom>=17]{ line-width: 3;}
    line-color: #ababab;
		 [zoom>=17]{
        	line-color: lighten(#ababab,10%);
         }
    line-smooth: 0.1;
  }
  [barrier='fence'][zoom>=16]{
    ::out{
      line-width: 2;
      line-offset: 1;
      line-dasharray: 2,15;
      line-color: #004400;
    }
    line-width: 1;
    line-color: #004400;
  }
 } 
/* ------------------------------------------------------------------ */
/* Place labels
/* ------------------------------------------------------------------ */
.place
{
	[place='town'][zoom<17],
	[place='city'][zoom<16], 
    [place='village'][zoom>=11][zoom<=16],
    [place='suburb'][zoom>=14][zoom<=16],
    [place='neighbourhood'][zoom>=12][zoom<=16],
    [place='hamlet'][zoom>=14][zoom<=17],
    [place='isolated_dwelling'][zoom>=14][zoom<=17],
    [place='farm'][zoom>=14][zoom<=17],
    [place='locality'][zoom>=14][zoom<=17]
    {
		text-name:"[name]";
		text-face-name: "DejaVu Sans Book";
    	text-halo-radius: 1;
    	text-fill: #000;
		text-placement-type: simple;
    }

    [place='city']{
       [zoom<16]{ 
  		text-size: 15;   	
   		text-face-name: "DejaVu Sans Bold";
  		text-placements: 'X,E,W,15,14,13,12,10';
       }
	   [zoom<11]{ 
  		text-size: 12;   
       }
    }

    [place='town']{
       [zoom<17]{ 
    	text-wrap-width: 20;
	  	text-size: 12;
     	text-face-name: "DejaVu Sans Bold";
		text-placements: 'X,E,W,12,11,10';
        }
       [zoom<11]{ 
	  	text-size: 10;
		text-face-name: "DejaVu Sans Book";
       }
	}

	
  /*text-allow-overlap: true;*/
	[place='village'][zoom>=11][zoom<=16],
	[place='suburb'][zoom=14][zoom<=16],
  	[place='neighbourhood'][zoom>=12][zoom<=16],
    [place='hamlet'][zoom>=14][zoom<=17],
    [place='isolated_dwelling'][zoom>=14][zoom<=17],
    [place='farm'][zoom>=14][zoom<=17]
	{
	    text-wrap-character: '-';
    	text-wrap-width: 45;
    }
	[place='village'][zoom>=11][zoom<=16],
	[place='suburb'][zoom=14][zoom<=16]{
  		text-placements: 'X,E,W,11,10,9,8';
	}
  	[place='village'][zoom=11]            { text-size: 10; }
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
