#water_area[tunnel='']
{
  	[basin!='detention']{
       	[size>10000],
		[size>5000][zoom>=15],
		[zoom>=16]{
  			line-width: 0;
    		line-color: #7eaac1;
    		/*polygon-fill: #8cb6d3;*/
  			polygon-fill:   #7eaac1;
            [leisure != 'swimming_pool']{
    		   polygon-smooth: 0.5;
            }
		}
  	}
   	[basin='detention']{
		[size>5000][zoom>=16]{
  			/*line-width: .5;*/
  			polygon-fill:   transparent;
    		/*line-color: #7eaac1;*/
	    	polygon-pattern-file: url('img/basin.png');
        	[zoom<16]{
           		polygon-opacity: 0.5;
           		polygon-pattern-opacity: 0.5;
    		}
      	}
   	}  
}
#water_area_label[tunnel='']
{ 
  [size>350000][zoom>=13],
	[size>80000][zoom>=15],
  	[size>25000][size<=80000][zoom>=16],
	[zoom>=17]{
		[waterway!='riverbank']{
  			text-name:"[name]";
	    	text-wrap-width: 40;
    		text-face-name: "DejaVu Sans Book";
    		text-fill: #2F4F4F;
	    	text-halo-fill: #fff;
    		text-halo-radius: 0;
    		text-avoid-edges: false;
	    	text-placement: interior;
  			text-size: 12;
   			text-placement-type: simple;
	    	text-placements: 'X,E,S,W,12,11,10,9,8';
    		/*text-clip: false;*/
      	}
  }
}

#water_line[tunnel='']
{
    line-color: #7eaac1;
    line-join: round;
    line-cap: round;
    line-smooth: 0.5;


   [zoom>=11][zoom<=12] { line-width: 2; }
   [zoom>=11][zoom<=12][waterway!='river'] { line-width: 1; }

   [zoom=13] { line-width: 3; }
   [zoom=13][waterway='stream'] { line-width: 1; }

   [zoom=14] { line-width: 5; }
   [zoom=14][waterway!='river'] { line-width: 2; }

   [zoom=15] { line-width: 7; }
   [zoom=15][waterway!='river'] { line-width: 3; }

   [zoom=16] { line-width: 9; }
   [zoom=16][waterway!='river'] { line-width: 4; }

   [zoom>=17] { line-width: 12; }
   [zoom>=17][waterway!='river'] { line-width: 5; }
}

#water_line_label[tunnel='']{
	[zoom>=14][waterway='river'],
	[zoom>=17]{
		text-name:"[name]";
	    text-wrap-width: 40;
      	text-face-name: "DejaVu Sans Book";
	    text-fill: #2f4f4f;
    	text-halo-fill: #fff;
	    text-halo-radius: 0;
	    text-avoid-edges: false;
	    text-placement: line;
	  	text-size: 10;
        [zoom>=16] {	text-size: 11;}
        [zoom>=17] {	
           text-size: 12;
	  	   text-placement-type: simple;
	       text-placements: 'X,E,S,W,12,13,12,11,10,9,8';
        }
	  	text-min-distance: 400;
    	/*text-clip: false;*/
    }
 }
