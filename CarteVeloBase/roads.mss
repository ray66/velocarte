/**===================================================================================*/
/** Global properties
/**===================================================================================*/


.road.label.major[zoom>=14],
.road.label.minor[zoom>=15],
{
    text-name:"[name]";
    text-face-name: "DejaVu Sans Book";
    text-fill: #000;
    text-placement: line;
    text-halo-radius: 1;
    text-halo-fill: #fff;
    text-max-char-angle-delta: 40;
    text-placement-type: dummy;
	text-comp-op: src-in; /*requires mapnik 2.1 */
    text-min-distance: 400;
  	text-avoid-edges: false;
    text-spacing: 0;
    text-wrap-width: 40;
    text-dy: 1;
	/*text-clip: false;*/
}
.road.label.major[zoom>=14]
{
    text-size: 11;
    /*[junction!='roundabout']{text-dy: 12;}*/
  	text-placement-type: simple;
  	text-placements: 'X,11,10';
}
.road.label.major[zoom>=16][highway!='trunk'][highway!='motorway']
{
   text-size: 12;
    /*[junction!='roundabout']{text-dy: 12;}*/
  	text-placement-type: simple;
  	text-placements: 'X,12,11,10';
}
.road.label.minor[zoom>=15],
{
    text-size: 10;
    /*[junction!='roundabout']{text-dy: 9;}*/
    /*[highway='pedestrian'][junction!='roundabout']{text-dy: 7;}*/
   text-placement-type: simple;
  text-placements: 'X,10';
}
.road.label.minor[zoom=17],
{
    text-size: 11;
    /*[junction!='roundabout']{text-dy: 12;}*/
}
.road.label.minor[zoom>=18],
{
    text-size: 13;
    /*[junction!='roundabout']{text-dy: 12;}*/
    text-placement-type: simple;
  text-placements: 'X,S,12,11,10,9,8'
}


/**===================================================================================*/
/** Tunnels
/**===================================================================================*/

.road.outline[zoom>=12][tunnel='yes']
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
.road.outline.bridge[zoom>=12]
{
    line-cap: butt;
}
.road.outline.bridge[zoom>=12]
{
    line-color: #888;
}
.road.outline.bridge[zoom>=18]
{
    line-color: #000;
}
.road.inline.bridge[zoom>=12]
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

.road.outline[zoom>=12],
.road.inline[zoom>=12]{
    line-cap: round;
    line-join: round;
    line-gamma: 1;
    line-gamma-method: power;
    line-width: 0;
  line-smooth: 0;
}

.road.inline[zoom>=12]{
   [highway='trunk'],[highway='motorway']    { line-width: 2; }
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 2;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 2; }
   [highway='tertiary_link'],[highway='residential'],[highway='unclassified'],[highway='grade1'],[highway='service']     { line-width: 0; }
   [highway='pedestrian'] { line-width: 0; }
}
.road.outline[zoom>=12]{
   [highway='trunk'],[highway='motorway']    { line-width: 4;}
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 4;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 4; }
   [highway='tertiary_link'],
   [highway='unclassified'] { line-width: 1; }
    [highway='residential'],
    [highway='grade1'],
    [highway='service']     { line-width: 0.5; }
   [highway='pedestrian'] { line-width: 0; }
}

.road.inline[zoom=13]{
   [highway='trunk'],[highway='motorway']    { line-width: 5; }
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 2;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 2; }
   [highway='tertiary_link'],[highway='residential'],[highway='unclassified'],[highway='grade1'],[highway='service']     { line-width: 1.5; }
   [highway='pedestrian'] { line-width: 1; }
}
.road.outline[zoom=13]{
   [highway='trunk'],[highway='motorway']    { line-width: 7;}
   [highway='motorway_link'],[highway='trunk_link'],[highway='primary'],[highway='secondary']  { line-width: 4;}
   [highway='tertiary'],[highway='primary_link'],[highway='secondary_link']   { line-width: 4; }
   [highway='tertiary_link'],
   [highway='residential'],
    [highway='unclassified'],
    [highway='grade1'],
    [highway='service']     { line-width: 3; }
   [highway='pedestrian'] { line-width: 3; }
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
   [highway='pedestrian'] { line-width: 2; }
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
   [highway='pedestrian'] { line-width: 2.5; }
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
   [highway='pedestrian'] { line-width: 4; }
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
   [highway='pedestrian'] { line-width: 6; }
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
   [highway='pedestrian']      { line-width: 4; }
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
   [highway='pedestrian']      { line-width: 6; line-cap:butt;}
}

  
.road.inline[zoom=17]{
   [highway='trunk'],
   [highway='motorway']        { line-width: 8; }
   [highway='motorway_link'],
   [highway='trunk_link'],
   [highway='primary'],
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
   [highway='pedestrian']      { line-width: 7; }
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
   [highway='pedestrian']      { line-width: 10; }
}

.road.inline[zoom=18]{
   [highway='trunk'],
   [highway='motorway']    { line-width: 12; }
   [highway='motorway_link'],
    [highway='trunk_link'],
    [highway='primary'],
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
   [highway='pedestrian'] { line-width: 8; }
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
   [highway='pedestrian'] { line-width: 12; }
}

.road.outline[highway='construction']{
	[zoom>=12]{
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
.road.inline[highway='construction'][zoom>=12]{
	line-width: 0;
}
.road.outline[highway='raceway'][zoom>=12],
.road.inline[highway='raceway'][zoom>=12]{
	line-width: 0;
}
/**===================================================================================*/
/** Road Colors 
/**===================================================================================*/
.road.inline[zoom>=12][highway='motorway']
{
    /*line-color: #ff5559;*/
    line-color: #FD923A;
}
.road.outline[zoom>=12][highway='motorway']
{
    line-color: #02317d;
}
.road.outline[zoom>=12][highway='motorway_link'] { line-color: #999999; }
.road.inline[zoom>=12][highway='motorway_link']  { line-color: #ff9460; }

.road.outline[zoom>=12][highway='motorway_link']{  line-color: #6d8aa7;}

/* lighten the motorways up a bit at 'high'er zoom levels */
.road.inline[zoom=16][highway='motorway'] { line-color: #fd923a; }
.road.inline[zoom>=17][highway='motorway'] { line-color: #fd923a; }
.road.outline[zoom>=16][highway='motorway'] { line-color: #6c7dd5; }
.road.inline[zoom=16][highway='motorway_link'] { line-color: #fd923a; }
.road.inline[zoom>=17][highway='motorway_link'] { line-color: #fd923a; }

.road.inline[zoom>=12][highway='trunk'],
.road.inline[zoom>=12][highway='trunk_link']    { line-color: darken(#ffec9f,10%);}

.road.inline[zoom>=12][highway='primary'],
.road.inline[zoom>=12][highway='primary_link']  { line-color: #ffec9f;}

.road.outline[zoom>=12][highway='trunk'],
.road.outline[zoom>=12][highway='trunk_link'],
.road.outline[zoom>=12][highway='primary'],
.road.outline[zoom>=12][highway='primary_link']
{
    line-color: #b1a67b;
}
.road.inline[highway='secondary'][zoom>=12],  
.road.inline[highway='secondary_link'][zoom>=12] { line-color: darken(#F9F6A6,5%); }
.road.outline[highway='secondary'][zoom>=14],
.road.outline[highway='secondary_link'][zoom>=14] { line-color: #736200; }
.road.outline[highway='secondary'][zoom>=12],
.road.outline[highway='secondary_link'][zoom>=12] { line-color: lighten(#736200,15%); }




.road.outline[zoom>=12][highway='primary'],


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
.road.inline [zoom>=12] [highway='tertiary'],
.road.inline [zoom>=12] [highway='tertiary_link']
{
      line-color: #F9F6A6;
}
.road.outline [zoom>=12] [highway='tertiary'],
.road.outline [zoom>=12] [highway='tertiary_link']
{
      line-color: #aaa;
}
.road.inline [zoom>=12] [highway='secondary_link'],
.road.inline [zoom>=12] [highway='residential'],
.road.inline [zoom>=12] [highway='unclassified'],
.road.inline [zoom>=12] [highway='grade1'],
.road.inline [zoom>=12] [highway='service']
{
      line-color: #fff;
}
.road.outline[highway='residential'],
.road.outline[highway='unclassified'],
.road.outline[highway='grade1'],
.road.outline[highway='service'],
.road.outline[highway='primary_link'],
.road.outline[highway='secondary_link']{
  	[zoom>=12] { line-color: @color-outline-minor-lz;}
	[zoom>=15] { line-color: @color-outline-minor-hz}
}

.road.inline[zoom>=13][highway='pedestrian'] {  line-color: #fff;}
.road.outline[zoom>=13][highway='pedestrian'] {  line-color: #7B84FF;}

/**===================================================================================
 * Cycleways
/**===================================================================================*/
@color_cw_fill:    #008B00;
@color_cw_outline: #004400;

.cycleway
{
    line-cap: round;
    line-join: round;
    line-color: @color_cw_fill;
    line-opacity: 1.0;
    [tunnel='yes']{ line-opacity: 0.3;}
}

.cycleway[zoom>=12] {line-width: 3;}
.cycleway[zoom>=14] {line-width: 3;}
.cycleway[zoom>=16]{line-width: 3;}
.cycleway[zoom>=17]{line-width: 4;}
.cycleway[zoom>=18]{line-width: 5;}

/** Path Colors **/

.cycleway[bicycle_access='designated']
{
  line-color: @color_cw_fill;
}
.cycleway[bicycle_access='designated_shared']
{
    line-cap: butt;
}
.cycleway[bicycle_access='designated_shared'][zoom>=12]
{
   line-width: 2;
    line-opacity: 1;
    line-dasharray: 2,2;
}
.cycleway[bicycle_access='designated_shared'][zoom>=13]
{
   line-width: 3;
    line-opacity: 1;
    line-dasharray: 3,3;
}
.cycleway[bicycle_access='designated_shared'][zoom>=14]
{
    line-opacity: 0.8;
    line-dasharray: 2,3;
}

/*
.cycleway[access='yes']
{
    line-cap: butt;
}
.cycleway[access='yes'][zoom>=12]
{
  	line-width: 2;
    line-opacity: 1;
    line-dasharray: 2,2;
}
.cycleway[access='yes'][zoom>=13]
{
  	line-width: 3;
    line-opacity: 1;
    line-dasharray: 3,3;
}
.cycleway[access='yes'][zoom>=14]
{
    line-opacity: 0.8;
    line-dasharray: 2,3;
}
*/
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
    line-color: #8B4513;
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

#road_access[zoom>=15]["cycleway:left"!='opposite'][oneway='yes'][highway!='motorway'][highway!='trunk'][highway!='motorway_link'][highway!='trunk_link']
{
    line-pattern-file: url('img/oneway-arrow.png');
}

/* Vélos à contresens */

#road_access[zoom>=15]["cycleway:left"='opposite']{
    line-pattern-file: url('img/arrow_contresens_mini.png');
  
}

#road_access[zoom>=19]["cycleway:left"='opposite']
{
    line-pattern-file: url('img/arrow_contresens_small.png');
}
#road_access[zoom=20]["cycleway:left"='opposite']
{
    line-pattern-file: url('img/arrow_contresens_medium.png');
}

/*===================================================================================*/
/* Tracks
/*===================================================================================*/
  
.road.outline[highway='grade2']{
	[zoom>=12]{
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
	[zoom>=12]{
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
       	line-color: darken(@color-track,20%);
   }
   [zoom>=15]{
    	line-width: 1.5;
       	line-color: lighten(@color-track,15%);
  	}
   [zoom>=16]{
    	line-width: 2;
       	line-color: lighten(@color-track,15%);
  	}
   [zoom>=17]{
    	line-width: 2;
       	line-color: lighten(@color-track,15%);
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

.road.ref[zoom>=12][highway='motorway']{
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
    shield-file: url('img/cartouche_autoroute-3.png');
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
    shield-file: url('img/cartouche_autoroute-3.png');
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
@color_cyclelane:    #008B00; /*#034ad8*/
@color_share_bus:    #008B00;

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
   line-color: @color_cyclelane;
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
      [access='no'],
      [access='permissive'],
      [access='private']{
         [bicycle!='yes']{
            line-opacity:   1;
            line-color:     #efa9a9;
            line-cap:       butt;
            line-dasharray: 1,3;
         }
         [bicycle='yes']{
            line-opacity:   0.5;
            line-color:     #cf9;
            line-cap:       butt;
            line-dasharray: 6,8;
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
  	
	[zoom>=12]{
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
     [zoom>=16]{
         point-file: url('img/gate.svg');
         point-ignore-placement: true;
         point-allow-overlap: true;
      	 point-transform: 'rotate([angle]) scale(0.75)';
      }
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
     [zoom>=17]{
         point-file: url('img/lift-gate.svg');
      	 point-transform: 'rotate([angle])';
      }
    }
  [barrier='bollard']{
     [zoom>=16]{
         point-file: url('img/bollard.svg');
         point-ignore-placement: true;
         point-allow-overlap: true;
      	 point-transform: 'scale(0.75)';
      }
     [zoom>=17]{
         point-file: url('img/bollard.svg');
         point-transform: 'scale(1)';
      }
    }
  [barrier='block']{
     [zoom>=16]{
         point-file: url('img/barrier.svg');
         point-ignore-placement: true;
         point-allow-overlap: true;
      	 point-transform: 'rotate([angle]) scale(0.75)';
      }
     [zoom>=17]{
         point-file: url('img/barrier.svg');
      	 point-transform: 'rotate([angle])';
      }
    }
}

