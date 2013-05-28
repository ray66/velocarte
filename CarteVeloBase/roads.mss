/**===================================================================================*/
/** Street names
/**===================================================================================*/

#road_label_minor[zoom>=14],
#road_label_major[zoom>=15]{
   	text-name:"[name]";
    [zoom<18][ratio<7]{
    	text-name:"[short_name]";
    }
    text-face-name: "DejaVu Sans Book";
    text-fill: #000;
    text-placement: line;
    text-halo-radius: 1;
    text-halo-fill: #fff;
    text-max-char-angle-delta: 40;
    text-placement-type: dummy;
    /*text-comp-op: src-in; requires mapnik 2.1 */
    text-min-distance: 400;
    text-avoid-edges: false;
    text-spacing: 0;
    text-wrap-width: 40;
    text-dy: 0;
    /*text-allow-overlap: true;*/
	 /*text-clip: false;*/
 	.major{
   		[zoom>=14]{
      		text-size: 11;
     		/*[junction!='roundabout']{text-dy: 12;}*/
      		text-placement-type: simple;
      		text-placements: 'X,11,10';
   		}
   		[zoom>=16][highway!='trunk'][highway!='motorway']{
      		text-size: 12;
      		/*[junction!='roundabout']{text-dy: 12;}*/
      		text-placement-type: simple;
      		text-placements: 'X,12,11,10';
   		}
	}
 	.minor{
	  	[zoom>=15]{
   			text-size: 10;
    		text-dy: 0;
    		text-min-distance: 400;
   			/*[junction!='roundabout']{text-dy: 9;}*/
   			/*[highway='pedestrian'][junction!='roundabout']{text-dy: 7;}*/
   			text-placement-type: simple;
   			text-placements: 'X,10';
   	  	}
   		[zoom>=17]{
      		text-size: 11;
      		/*[junction!='roundabout']{text-dy: 12;}*/
   		}
   		[zoom>=18]{
      		text-size: 12;
      		/*[junction!='roundabout']{text-dy: 12;}*/
      		text-placement-type: simple;
      		text-placements: 'N,12,11,10,9,8';
     	 	text-allow-overlap: false;
      		["cycleway:left"='opposite'],
      		[oneway='yes']{
      			[ratio<5]{text-dy: -12;text-allow-overlap:true;}
      		}
      	}
    }

}

/**===================================================================================*/
/** Tunnels
/**===================================================================================*/

.road.outline[zoom>=11][tunnel='yes']
{
    line-cap: butt;
    line-dasharray: 4,6;
}
/**===================================================================================*/
/** Bridges
/** todo: multiple layers
/**===================================================================================*/
/*.road.outline.bridge[zoom>=14][class='major'][bridge='yes'],
.road.outline.bridge[zoom>=16][bridge='yes']*/
.road.outline.bridge[zoom>=11]
{
    line-cap: butt;
}
.road.outline.bridge[zoom>=11]
{
    line-color: #888;
}
.road.outline.bridge[zoom>=18]
{
    line-color: #000;
}
.road.inline.bridge[zoom>=11]
{
    line-cap: round;
}



/*
.road.inline[zoom>=13][class='major'][bridge='yes'],
.road.inline[zoom>=13][class='major'][bridge=true]
{
    line-width: 1;
    line-color: #878787;
}
*/

/**===================================================================================*/
/** Road Weights **/
/**===================================================================================*/

.road.outline[zoom>=11],
.road.inline[zoom>=11]{
    line-cap: round;
    line-join: round;
    line-gamma: 1;
    line-gamma-method: power;
    line-width: 0;
  line-smooth: 0;
}

.road.inline[zoom>=11]{
   [highway='trunk'],[highway='motorway']    { line-width: 2; }
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 2;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 2; }
   [highway='tertiary_link'],[highway='residential'],[highway='unclassified'],[highway='grade1'],[highway='service']     { line-width: 0; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 0; }
}
.road.outline[zoom>=11]{
   [highway='trunk'],[highway='motorway']    { line-width: 6;}
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 4;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 4; }
   [highway='tertiary_link'],
   [highway='unclassified'] { line-width: 1; }
    [highway='residential'],
    [highway='grade1'],
    [highway='service']     { line-width: 0.5; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 0; }
}

.road.inline[zoom=13]{
   [highway='trunk'],[highway='motorway']    { line-width: 4; }
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 2;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 2; }
   [highway='tertiary_link'],[highway='residential'],[highway='unclassified'],[highway='grade1'],[highway='service']     { line-width: 1.5; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 1; }
}
.road.outline[zoom=13]{
   [highway='trunk'],[highway='motorway']    { line-width: 8;}
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 5;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 5; }
   [highway='tertiary_link'],
   [highway='residential'],
    [highway='unclassified'],
    [highway='grade1'],
    [highway='service']     { line-width: 3; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 3; }
}

.road.inline[zoom=14]{
   [highway='trunk'],
    [highway='motorway']    { line-width: 4; }
   [highway='motorway_link'],
    [highway='trunk_link'],
    [highway='primary'],
    [highway='secondary']  { line-width: 4;}
   [highway='tertiary'],
    [highway='primary_link'],
    [highway='secondary_link']   { line-width: 4; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified'] { line-width: 2; }
    [highway='grade1'],
    [highway='service']     { line-width: 2; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 2; }
}
.lane[zoom=14],
.road.outline[zoom=14]{
   [highway='trunk'],
    [highway='motorway']    { line-width: 7;}
   [highway='motorway_link'],
    [highway='trunk_link'],
    [highway='primary'],
    [highway='secondary']  { line-width: 7;}
   [highway='tertiary'],
    [highway='primary_link'],
    [highway='secondary_link']   { line-width: 6; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified']{ line-width: 4; }
    [highway='grade1'],
    [highway='service']     { line-width: 4 }
   [highway='pedestrian'],[highway='living_street'] { line-width: 2.5; }
}
  
.road.inline[zoom=15]{
   [highway='trunk'],
   [highway='motorway']    { line-width: 4; }
   [highway='motorway_link'],
   [highway='trunk_link'],
   [highway='primary'],
   [highway='secondary']  { line-width: 4;}
   [highway='tertiary'],
    [highway='primary_link'],
    [highway='secondary_link']   { line-width: 5; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified']{ line-width: 4; }
    [highway='grade1'],
    [highway='service']     { line-width: 3; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 4; }
}
.lane[zoom=15],
.road.outline[zoom=15]{
   [highway='trunk'],
   [highway='motorway']    { line-width: 7;}
   [highway='motorway_link'],
   [highway='trunk_link'],
   [highway='primary'],
   [highway='secondary']  { line-width: 7;}
   [highway='tertiary'],
    [highway='primary_link'],
    [highway='secondary_link']   { line-width: 7; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified'] { line-width: 6; }
    [highway='grade1'],
    [highway='service']     { line-width: 5; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 6; }
}
  
.road.inline[zoom>=16]{
   [highway='trunk'],
   [highway='motorway']        { line-width: 4; }
   [highway='motorway_link'],
   [highway='trunk_link']      { line-width: 4; }
   [highway='primary'],
   [highway='secondary'],
   [highway='primary_link'],
   [highway='secondary_link']  { line-width: 4.5;}
   [highway='tertiary']        { line-width: 5; }
   [highway='tertiary_link'],
   [highway='residential'],
   [highway='unclassified']    { line-width: 6; }
   [highway='grade1'],
   [highway='service']         { line-width: 4; }
   [highway='pedestrian'],[highway='living_street']      { line-width: 4; }
}
.lane[zoom>=16],
.road.outline[zoom>=16]{
   [highway='trunk'],
   [highway='motorway']        { line-width: 7;}
   [highway='motorway_link'],
   [highway='trunk_link']      { line-width: 7;}
   [highway='primary'],
   [highway='primary_link'],
   [highway='secondary_link'], 
   [highway='secondary']      { line-width: 7;}
   [highway='tertiary']       { line-width: 7; }
   [highway='tertiary_link'],
   [highway='residential'],
   [highway='unclassified']   {line-width: 8; }
   [highway='grade1'],
   [highway='service']         { line-width: 6; }
   [highway='pedestrian'],[highway='living_street']      { line-width: 6; line-cap:butt;}
}

  
.road.inline[zoom=17]{
   [highway='trunk'],
   [highway='motorway']        { line-width: 8; }
   [highway='motorway_link'],
   [highway='trunk_link'],
   [highway='primary'] 			{ line-width: 7;}
   [highway='secondary']       { line-width: 9;
    								[oneway='yes']{line-width: 8;}
  								}
   [highway='primary_link'],
   [highway='secondary_link']   { line-width: 9; }
   [highway='tertiary']         { line-width: 9; }
   [highway='tertiary_link'],
   [highway='residential'],
   [highway='unclassified']    { line-width: 9; }
   [highway='grade1'],
   [highway='service']         { line-width: 5; }
   [highway='pedestrian'],[highway='living_street']      { line-width: 7; }
}
.lane[zoom=17],
.road.outline[zoom=17]{
   [highway='trunk'],
   [highway='motorway']        { line-width: 11;}
   [highway='motorway_link'], 
   [highway='trunk_link'],
   [highway='primary'],
   [highway='secondary']        { line-width: 11;
    								[oneway='yes']{line-width: 10;}
  								}
   [highway='tertiary'],
   [highway='primary_link'],
   [highway='secondary_link']   { line-width: 11; }
   [highway='tertiary_link'],
   [highway='residential'],
   [highway='unclassified']    { line-width: 11; }
   [highway='grade1'],
   [highway='service']         { line-width: 7; }
   [highway='pedestrian'],[highway='living_street']      { line-width: 10; }
}

.road.inline[zoom=18]{
   [highway='trunk'],
   [highway='motorway']    { line-width: 11; }
   [highway='motorway_link'],
    [highway='trunk_link'],
    [highway='primary']    { line-width: 11;}
    [highway='secondary']  { line-width: 13;
    						 [oneway='yes']{line-width: 12;}
   }
   [highway='tertiary'],
   [highway='primary_link'],
    [highway='secondary_link']   { line-width: 11; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified']{ line-width: 11; }
    [highway='grade1'],
    [highway='service']     { line-width: 7; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 8; }
}
.lane[zoom=18],
.road.outline[zoom=18]{
   [highway='trunk'],
   [highway='motorway']    { line-width: 15;}
   [highway='motorway_link'],
   [highway='trunk_link'],
   [highway='primary'],
   [highway='secondary']  { line-width: 15;
    						 [oneway='yes']{line-width: 14;}
   }
   [highway='tertiary'],
    [highway='primary_link'],
    [highway='secondary_link']   { line-width: 13; }
   [highway='tertiary_link'],
    [highway='residential'],
    [highway='unclassified']    { line-width: 13; }
    [highway='grade1'],
    [highway='service']     { line-width: 9; }
   [highway='pedestrian'],[highway='living_street'] { line-width: 12; }
}

.road.outline[highway='construction']{
	[zoom>=11]{
   		line-color: #999;
 		line-width: 1;
    	line-dasharray: 1,2;
		line-cap: round;
    	line-opacity: 0.3;
    }
	[zoom>=15]{
 		line-width: 2;
    	line-dasharray: 2,4;
  	}
	[zoom>=17]{
   		line-color: #888;
 		line-width: 4;
    	line-dasharray: 3,10;
  	}
}
.road.inline[highway='construction'][zoom>=11]{
	line-width: 0;
}
.road.outline[highway='raceway'][zoom>=11],
.road.inline[highway='raceway'][zoom>=11]{
	line-width: 0;
}
/**===================================================================================*/
/** Road Colors 
/**===================================================================================*/
.road.inline[zoom>=11][highway='motorway']
{
    /*line-color: #ff5559;*/
    line-color: #FD923A;
}
.road.outline[zoom>=11][highway='motorway']
{
    line-color: darkred; /*#02317d*/
}
.road.outline[zoom>=11][highway='motorway_link'] { line-color: #999999; }
.road.inline[zoom>=11][highway='motorway_link']  { line-color: #ff9460; }

.road.outline[zoom>=11][highway='motorway_link']{  line-color: #6d8aa7;}

/* lighten the motorways up a bit at 'high'er zoom levels 
.road.inline[zoom=16][highway='motorway'] { line-color: #fd923a; }
.road.inline[zoom>=17][highway='motorway'] { line-color: #fd923a; }
.road.outline[zoom>=16][highway='motorway'] { line-color: #6c7dd5; }
.road.inline[zoom=16][highway='motorway_link'] { line-color: #fd923a; }
.road.inline[zoom>=17][highway='motorway_link'] { line-color: #fd923a; }
*/
.road.inline[zoom>=11][highway='trunk'],
.road.inline[zoom>=11][highway='trunk_link']    { line-color: #FD923A;/*darken(#ffec9f,10%)*/}

.road.inline[zoom>=11][highway='primary'],
.road.inline[zoom>=11][highway='primary_link']  { line-color: #FD923A;/*#ffec9f;*/}

.road.outline[zoom>=11][highway='trunk'],
.road.outline[zoom>=11][highway='trunk_link'],
.road.outline[zoom>=11][highway='primary'],
.road.outline[zoom>=11][highway='primary_link']
{
    line-color: darken(#b1a67b,20%);
}
.road.inline[highway='secondary'][zoom>=11],  
.road.inline[highway='secondary_link'][zoom>=11] { line-color: darken(#F9F6A6,5%); }
.road.outline[highway='secondary'][zoom>=14],
.road.outline[highway='secondary_link'][zoom>=14] { line-color: #736200; }
.road.outline[highway='secondary'][zoom>=11],
.road.outline[highway='secondary_link'][zoom>=11] { line-color: lighten(#736200,15%); }




/* all repeated from above but applicable to bridges specifically 
.road.inline { outline-color: #d2d2d2; }
.road.inline[highway='tertiary'] { outline-color: #c3c3c3; }
.road.inline[highway='secondary'] { outline-color: #b5b880; }
.motorway.inline[highway='trunk'], .road.inline[highway='trunk'], .road.inline[highway='primary'] { outline-color: #b1a67b; }
.road.inline[highway='motorway_link'] { outline-color: #6d8aa7; }
.motorway.inline[highway='motorway'], .road.inline[highway='motorway'] { outline-color: #02317d; }
.road.inline[highway='motorway'] { outline-color: #02317d; }
.road.inline[zoom>=16][highway='motorway'] { outline-color: #6c7dd5; }
*/

/* untergeordnete Strassen  */
.road.inline [zoom>=11] [highway='tertiary'],
.road.inline [zoom>=11] [highway='tertiary_link']
{
      line-color: #F9F6A6;
}
.road.outline [zoom>=11] [highway='tertiary'],
.road.outline [zoom>=11] [highway='tertiary_link']
{
      line-color: #aaa;
}
.road.inline [zoom>=11] [highway='secondary_link'],
.road.inline [zoom>=11] [highway='residential'],
.road.inline [zoom>=11] [highway='unclassified'],
.road.inline [zoom>=11] [highway='grade1'],
.road.inline [zoom>=11] [highway='service']
{
      line-color: #fff;
}
.road.outline[highway='residential'],
.road.outline[highway='unclassified'],
.road.outline[highway='grade1'],
.road.outline[highway='service'],
.road.outline[highway='primary_link'],
.road.outline[highway='secondary_link']{
  	[zoom>=11] { line-color: @color-outline-minor-lz;}
	[zoom>=15] { line-color: @color-outline-minor-hz}
}

.road.inline[zoom>=13][highway='pedestrian'] {  line-color: #fff;}
.road.outline[zoom>=13][highway='pedestrian'] {  line-color: #7B84FF;}

.road.inline[zoom>=13][highway='living_street']  {  line-color: #fff;}
.road.outline[zoom>=13][highway='living_street'] {
  line-color: #7B84FF;
  line-dasharray: 12,3;
}

/**===================================================================================
 * Cycleways
/**===================================================================================*/
#cycleway{
 [bicycle_access='designated'][bicycle_shared='no']{
    line-cap: round;
    line-join: round;
    line-color: @color_cycleway;
    line-opacity: 1.0;
    [tunnel='yes']{ line-opacity: 0.3;}
    [zoom>=11] {line-width: 2;}
	[zoom>=14] {line-width: 3;}
	[zoom>=16]{line-width: 3;}
	[zoom>=17]{line-width: 4;}
	[zoom>=18]{line-width: 5;}
 }
 
 [bicycle_access='yes'][bicycle_shared='agricultural'],
 [bicycle_access='designated'][bicycle_shared!='no']{
	line-color: @color_cycleway;
    line-opacity: 1;
    line-cap: butt;
    [zoom>=11] {line-width: 2;}
	[zoom>=14] {line-width: 2;}
	[zoom>=16]{line-width: 2;}
	[zoom>=17]{line-width: 4;}
	[zoom>=18]{line-width: 5;}
    line-dasharray: 2,1;
	[zoom>=13]{	line-dasharray: 3,2;}
  	[zoom>=16]{ line-dasharray: 4,2;}
	[zoom>=17]{ line-dasharray: 8,4;}
 }
 [bicycle_access='yes'][bicycle_shared='psv']{
	::outline{
         line-color: black;
         line-cap: butt;
    	[zoom>=11] {line-width: 2;}
		[zoom>=14] {line-width: 3;}
		[zoom>=16]{line-width: 3;}
		[zoom>=17]{line-width: 4;}
		[zoom>=18]{line-width: 5;}
    }        
	line-color: @color_cycleway;
    line-opacity: 1;
    line-cap: butt;
    line-dasharray: 4,2;
    [zoom>=11] {line-width: 2;}
	[zoom>=14] {line-width: 3;}
	[zoom>=16]{line-width: 3;line-dasharray: 4,2;}
	[zoom>=17]{line-width: 4;}
	[zoom>=18]{line-width: 5;}
	[zoom>=15]{	line-dasharray: 8,4;}
	[zoom>=14]{ line-dasharray: 12,6;}
 }
/**-----------------------------------------------------------------
 ** Für Radfahrer zugelassen, ohne motorisiertem Verkehr
 **-----------------------------------------------------------------*/
 [bicycle_access='yes'][bicycle_shared='no'][highway!='pedestrian']{
	line-color: @color_cycleway;
    line-opacity: 1;
    line-cap: butt;
    [zoom>=11] {
    	line-width: 2;
   		line-dasharray: .1,3;
    }
	[zoom>=13] {
    	line-width: 1;
    	line-dasharray: 0,8;
  	}
	[zoom>=15]{
    	line-width: 3;
    	line-dasharray: .1,7;
        line-cap: round;
  	}
	[zoom>=16] {
    	line-width: 3.5;
    	line-dasharray: .1,7;
  	}
	[zoom>=17]{
    	line-width: 4.5;
    	line-dasharray: .2,10;
  	}
	[zoom>=18]{
    	line-width: 5;
    	line-dasharray: .2,12;
  	}
 }
}
/**===================================================================================
 * Paths & steps
/**===================================================================================*/
/** Path Colors **/

.path[zoom>=14]
{
    ::bridge[bridge='yes']{
         line-color: #d2d2d2;
         line-width: 6;
    }
    line-color: @color-path;
    line-opacity: 1;
}

.path[highway!='steps'][zoom>=14]
{
    line-cap: butt;
    line-join: round;
}

.path[highway='steps'][zoom>=14]
{
    line-cap: butt;
    line-join: miter;
    line-color: #111111;
    line-opacity: 0.8;
}

.path[zoom>=14][highway!='steps']
{
    line-width: 1;
    line-dasharray: 2, 2;
}
.path[zoom=15][highway!='steps']
{
    line-width: 1;
    line-dasharray: 2, 2;
}
.path[zoom>=16][highway!='steps']
{
    line-width: 1;
    line-dasharray: 3, 3;
 }

.path[zoom>=14][zoom<=15][highway='steps']
{
    line-width: 3;
    line-dasharray: 1, 2;
}
.path[zoom>=16][highway='steps']
{
    line-width: 8;
    line-dasharray: 1, 2;
}

/**===================================================================================
 * Areas (places)
/**===================================================================================*/

.road.area.fill[zoom>=15]{
   polygon-fill: #f6f3ee;
   line-color: #d2d2d2;
   line-width: 1;
}
.road.area.fill[zoom>=15][highway='pedestrian']{
   /*line-color: #7B84FF;*/
   line-color: #7B84FF;
   line-width: 2;
}

.road.area.fill[zoom=16][highway='pedestrian']{ line-width: 1.5; }
.road.area.fill[zoom=17][highway='pedestrian']{ line-width: 1.5; }
.road.area.fill[zoom=18][highway='pedestrian']{ line-width: 1.5; }


.road.area.label[zoom>=17] {
    text-name:"[name]";
   text-placement: interior;
   text-face-name: "DejaVu Sans Book";
    text-wrap-width: 25;
    text-fill: #000000;
    text-halo-radius: 0;
    text-halo-fill: #000;
  	text-size: 10;
    text-avoid-edges: true;
	text-placement-type: simple;
  	text-placements: 'X,9,8';
}

.road.area.label[zoom>=17] {
  	text-placements: 'X,11,10,9';
}
/**===================================================================================
 * Oneway arrows
/**===================================================================================*/
#road_marker_lowz[zoom>=15][zoom<=17]{
      ["cycleway:left"='opposite']{
         marker-file: url('img/arrow-contresens.svg');
      }
      ["cycleway:left"!='opposite'][oneway='yes']{
         marker-file: url('img/oneway-arrow.svg');
      }
         marker-placement: line;
         marker-transform: 'scale(0.3)';
         [zoom>=16]{marker-transform: 'scale(0.35)';}
         [zoom>=17]{marker-transform: 'scale(0.4)';}
         marker-spacing: 120;
         marker-max-error: 0.99;
         marker-ignore-placement: true;
   		 [length<150.0]{
 	  			marker-spacing: 60;
      			marker-transform: 'scale(0.3)';
         }
    	 [length<50]{
   	  			marker-spacing: 30;
      			marker-transform: 'scale(0.4)';
    			/*marker-comp-op:src-atop;*/
      	  }
	      marker-allow-overlap:true;
}
#road_marker_highz[zoom=18]{
      	["cycleway:left"='opposite']{
         	marker-file: url('img/arrow-contresens.svg');
      	}
      	["cycleway:left"!='opposite'][oneway='yes']{
         	marker-file: url('img/oneway-arrow.svg');
      	}
      	["cycleway:left"='opposite'],
      	[oneway='yes']{
    		marker-placement: line;
   	 		marker-transform: 'scale(0.5)';
    		marker-spacing: 100;
    		marker-max-error: 0.99;
   	 		marker-allow-overlap: false;
    		marker-ignore-placement: true;
       		[ratio<5]{
   				marker-allow-overlap: true;
   			}
   			[length<150][ratio>=5]{
 	  			marker-spacing: 60;
      			marker-transform: 'scale(0.4)';
            }
   			[length<120][ratio>=5]{
 	  			marker-spacing: 30;
      			marker-transform: 'scale(0.4)';
            }
    		[length<50]{
   	  			marker-spacing: 30;
      			marker-transform: 'scale(0.3)';
      		}
      	}
}
/*===================================================================================*/
/* Tracks
/*===================================================================================*/
  
.road.outline[highway='grade2']{
	[zoom>=11]{
	   		line-color: lighten(@color-track,5%);
    		line-cap: butt;
    		line-width: 0.5;
    }
    [zoom=13]{
    		line-width: 1;
    }

	[zoom>=14]{
      	::le2{
        	line-color: darken(@color-track,20%);
        	line-width: 0.7;
        	line-offset: 1;
        	line-dasharray: 6,3;
      	}
      	::ri2{
        	line-color: darken(@color-track,20%);
        	line-width: 0.7;
        	line-offset: -1.5;
        }
    	line-width: 0;
	}
  	[zoom>=15]{ 
      		::le2{
        		line-width: .7;
          		line-dasharray: 10,5;
        		line-offset: 1.2;
        	}
      		::ri2{
        		line-width: .7;
        		line-offset: -1.2;
        	}
    }
	[zoom>=16]{
		::le2{
        	line-width: .8;
        	line-offset: 1.5;
        	line-dasharray: 12,6;
        }
		::ri2{
        	line-width: .8;
        	line-offset: -1.5;
        }
	}
	[zoom>=17]{ 
		::le2{
        	line-width: 1;
        	line-offset: 2;
        	line-dasharray: 14,7;
        }
		::ri2{
        	line-width: 1;
        	line-offset: -2;
        }
	}
}

.road.outline[highway='grade3']{
	[zoom>=11]{
	   		line-color: lighten(@color-track,5%);
    		line-cap: butt;
    		line-width: 0.5;
        	line-dasharray: 3,2;
    }
    [zoom=13]{
    		line-width: 1;
    }

	[zoom>=14]{
      	::le2{
        	line-color: darken(@color-track,20%);
        	line-width: 0.7;
        	line-offset: 1;
        	line-dasharray: 4,2;
      	}
      	::ri2{
        	line-color: darken(@color-track,20%);
        	line-width: 0.7;
        	line-offset: -1
        ;
        	line-dasharray: 4,2;
        }
    	line-width: 0;
	}
  	[zoom>=15]{ 
      		::le2{
        		line-width: .7;
          		line-dasharray: 6,3;
        		line-offset: 1.2;
        	}
      		::ri2{
        		line-width: .7;
        		line-offset: -1.2;
          		line-dasharray: 6,3;
        	}
    }
	[zoom>=16]{
			::le2{
          		line-width: .8;
        		line-offset: 1.5;
          	}
			::ri2{
          		line-width: .8;
        		line-offset: -1.5;
          	}
	}
	[zoom>=17]{ 
		::le2{
        	line-width: 1;
        	line-offset: 2;
          	line-dasharray: 10,3;
        }
		::ri2{
        	line-width: 1;
        	line-offset: -2;
          	line-dasharray: 10,3;
        }
	}
}
.road.outline[highway='grade4'],
.road.outline[highway='grade5']{
   [zoom>=14]{
	line-cap: butt;
    	line-width: 0.5;
       	line-color: @color-track-4-5;
   }
   [zoom>=15]{
    	line-width: 1.5;
       	line-color: @color-track-4-5;
  	}
   [zoom>=16]{
    	line-width: 2;
       	line-color: @color-track-4-5;
  	}
   [zoom>=17]{
    	line-width: 2;
       	line-color: @color-track-4-5;
  	}
} 

  
/* offset requires mapnik 2.1
.road.outline[tracktype='grade2']
{
  ::left{line-color: #d2d2d2;line-offset: 1;}
    line-color: #d2d2d2;
    line-opacity: 1;
    line-offset: -1;
    line-dasharray: 6,6;
}
.road.inline[class='low'][zoom=14][tracktype='grade2']   { line-width: 1; }
.road.outline[class='low'][zoom=14][tracktype='grade2']  { line-width:  1; ::left{line-width:  1;}}
.road.inline[class='low'][zoom=15][tracktype='grade2']   { line-width: 1; }
.road.outline[class='low'][zoom=15][tracktype='grade2']  { line-width:  1; ::left{line-width:  1;}}
.road.inline[class='low'][zoom=16][tracktype='grade2']   { line-width: 4; }
.road.outline[class='low'][zoom=16][tracktype='grade2']  { line-width:  4; ::left{line-width:  4;}}
.road.inline[class='low'][zoom>=17][tracktype='grade2']   { line-width: 7; }
.road.outline[class='low'][zoom>=17][tracktype='grade2']  { line-width:  7; ::left{line-width:  7;}}
*/


/**===================================================================================*/
/** Road Refs **/
/**===================================================================================*/

.road.ref[zoom>=11][highway='motorway']{
    shield-name:"[ref_content]";
    shield-file: url('img/cartouche_autoroute-3.png');
    shield-face-name: "DejaVu Sans Bold";
    shield-min-distance: 100;
    shield-size: 10;
	shield-fill: #fff;
   shield-size: 10;
   shield-fill: #000;
  shield-avoid-edges: true;
  	[ref_length=2] { shield-file: url('img/cartouche_autoroute-2.png');}
	[ref_length=3] { shield-file: url('img/cartouche_autoroute-3.png');}
	[ref_length=4] { shield-file: url('img/cartouche_autoroute-4.png');}
	[ref_length=5] { shield-file: url('img/cartouche_autoroute-5.png');}
	[ref_length=6] { shield-file: url('img/cartouche_autoroute-6.png');}
}

.road.ref[zoom>=14][highway='trunk'],
.road.ref[zoom>=14][highway='primary'],
.road.ref[zoom>=14][highway='secondary']{
    shield-name:"[ref_content]";
    shield-file: url('img/horizontal-shield-2.png');
    shield-face-name: "DejaVu Sans Bold";
    shield-min-distance: 100;
   shield-size: 9;
   shield-fill: #000;
  shield-avoid-edges: true;
	[ref_length=2] { shield-file: url('img/horizontal-shield-2.png'); }
	[ref_length=3] { shield-file: url('img/horizontal-shield-3.png'); }
	[ref_length=4] { shield-file: url('img/horizontal-shield-4.png'); }
	[ref_length=5] { shield-file: url('img/horizontal-shield-5.png'); }
	[ref_length=6] { shield-file: url('img/horizontal-shield-6.png'); }
	[ref_length=7] { shield-file: url('img/horizontal-shield-7.png'); }
	[ref_length=8] { shield-file: url('img/horizontal-shield-8.png'); }
	[ref_length=9] { shield-file: url('img/horizontal-shield-9.png'); }
}


.road.ref[zoom>=14][highway='tertiary'],
.road.ref[zoom>=15][highway='unclassified']{
    shield-name:"[ref_content]";
    shield-file: url('img/horizontal-shield-2.png');
    shield-face-name: "DejaVu Sans Bold";
    shield-min-distance: 100;
    shield-size: 9;
	shield-fill: #000;
  shield-avoid-edges: true;
	[ref_length=2] { shield-file: url('img/horizontal-shield-2.png'); }
	[ref_length=3] { shield-file: url('img/horizontal-shield-3.png'); }
	[ref_length=4] { shield-file: url('img/horizontal-shield-4.png'); }
	[ref_length=5] { shield-file: url('img/horizontal-shield-5.png'); }
	[ref_length=6] { shield-file: url('img/horizontal-shield-6.png'); }
	[ref_length=7] { shield-file: url('img/horizontal-shield-7.png'); }
	[ref_length=8] { shield-file: url('img/horizontal-shield-8.png'); }
	[ref_length=9] { shield-file: url('img/horizontal-shield-9.png'); }
}

/**===================================================================================*/
/** Cycle lanes
/**===================================================================================*/
.lane.right[zoom>=14] {line-offset: -1.5;}
.lane.right[zoom>=15] {line-offset: -2;}
.lane.right[zoom>=16] {line-offset: -2.25;}
.lane.right[zoom>=17] {line-offset: -2.75;}
.lane.right[zoom>=18] {line-offset: -3;}

.lane.left[zoom>=14] {line-offset: 1.5;}
.lane.left[zoom>=15] {line-offset: 2;}
.lane.left[zoom>=16] {line-offset: 2.25;}
.lane.left[zoom>=17] {line-offset: 2.75;}
.lane.left[zoom>=18] {line-offset: 3;}

.lane.outline[zoom>=14]
{
   line-color: black;
   line-cap: butt;
}
.lane.inline[zoom>=14]
{
   line-color: @color_cycleway;
   line-cap: butt;
}

.lane.inline[zoom>=14]["cycleway_right"='lane'],
.lane.inline[zoom>=14]["cycleway_left"='lane']
{
   line-dasharray: 2,2;
}
.lane.inline[zoom>=15]["cycleway_right"='lane'],
.lane.inline[zoom>=15]["cycleway_left"='lane']
{
   line-dasharray: 3,3;
}
.lane.inline[zoom>=17]["cycleway_right"='lane'],
.lane.inline[zoom>=17]["cycleway_left"='lane']
{
   line-dasharray: 4,4;
}



.lane.inline[zoom>=14]["cycleway_right"='share_busway'],
.lane.inline[zoom>=14]["cycleway_left"='share_busway']
{
   line-dasharray: 4,2;
}
.lane.inline[zoom>=15]["cycleway_right"='share_busway'],
.lane.inline[zoom>=15]["cycleway_left"='share_busway']
{
   line-dasharray: 8,4;
}
.lane.inline[zoom>=17]["cycleway_right"='share_busway'],
.lane.inline[zoom>=17]["cycleway_left"='share_busway']
{
   line-dasharray: 12,6;
}

/*===================================================================================*/
/* Access (to be improved !!!!!!!!)
/*===================================================================================*/
#road_access[zoom>=14]{
  
   /* roads other than track grade 2-5 get their width through inline style */
   [highway='grade2'],
   [highway='grade3'],
   [highway='grade4'],
    [highway='grade5']
    {
    	line-width: 4;
   }
   line-color: transparent;
   [bicycle='no'],
   [bicycle='private']{
      line-opacity:   1;
      line-color:     #efa9a9;
      line-cap:       butt;
      line-dasharray: 2,5;
   }
   
   [bicycle!='yes']
   [bicycle!='permissive']{
     [access='no'],
     [access='private'],
     [vehicle='no'],
     [vehicle='private'] {
         line-opacity:   1;
         line-color:     lightgrey;
         line-cap:       butt;
         line-dasharray: 5,3;
      }
   }
}
/*===================================================================================*/
/* Bicycle Routes
/*===================================================================================*/
#cycleroute{
    text-name:"[route_name]";
    text-face-name: "DejaVu Sans Bold";
    text-fill: green;
    text-halo-fill: #fff;
    text-halo-radius: 1;
	text-size: 10;
  	text-dy: 8;
    text-placement: line;
    text-max-char-angle-delta: 40;

    line-cap: round;
    line-join: round;
    line-color: red;
    line-opacity: 1;
  	
	[zoom>=11]{
	  	line-dasharray: 3,8;
    	line-width: 2.5;
  	}
	[zoom>=14]{
	  	line-dasharray: 4,10;
    	line-width: 3;
  	}
	[zoom>=16]{
	  	line-dasharray: 8,16;
    	line-width: 3.5;
  	}
	[zoom>=17]{
    	line-width: 4;
  	}
	[zoom>=18]{
	  	line-dasharray: 8,16;
    	line-width: 5;
  	}
 
}
  
/*===================================================================================*/
/* Points on roads
/*===================================================================================*/
#barrier{
  [barrier='cycle_barrier']{
     [zoom>=16]{
         point-file: url('img/cycle-barrier.svg');
         point-ignore-placement: true;
         point-allow-overlap: true;
      	 point-transform: 'rotate([angle]) scale(0.75)';
      }
     [zoom>=18]{
      	 point-transform: 'rotate([angle]) ';
      }
    }
  [barrier='gate']{
     [zoom>=18]{
         point-file: url('img/gate.svg');
      	 point-transform: 'rotate([angle])';
      }
    }
  [barrier='lift_gate']{
     [zoom>=16]{
         point-file: url('img/lift-gate.svg');
         point-ignore-placement: true;
         point-allow-overlap: true;
      	 point-transform: 'rotate([angle]) scale(0.75)';
      }
     [zoom>=18]{
         point-file: url('img/lift-gate.svg');
      	 point-transform: 'rotate([angle])';
      }
    }
  [barrier='bollard']{
     [zoom>=18]{
         point-file: url('img/bollard.svg');
         point-transform: 'scale(1)';
      }
    }
  [barrier='block']{
     [zoom>=18]{
         point-file: url('img/barrier.svg');
      	 point-transform: 'rotate([angle])';
      }
    }
}

