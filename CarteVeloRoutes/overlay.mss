/**===================================================================================
 * Unclassified/Track Grade1
/**===================================================================================*/

/** Path Colors **/

.road {
  line-color: #007200;
  line-cap: butt;
  line-opacity: 0.6;
  [zoom>=12]{ line-width: 1.5; }
  [zoom>=13]{ line-width: 3; }
  [zoom>=14]{ line-width: 4; }   
  [zoom>=15]{ line-width: 6; }   
  [zoom>=16]{ line-width: 8; }   
  [zoom>=17]{ line-width: 10; }   
  [zoom>=18]{ line-width: 12; }   
}

.road[highway='unclassified'][zoom>=12]{ line-dasharray: 2,2;}
.road[highway='unclassified'][zoom>=13]{ line-dasharray: 3,5;}
.road[highway='unclassified'][zoom>=14]{ line-dasharray: 5,5;}
.road[highway='unclassified'][zoom>=15]{ line-dasharray: 10,10;}
.road[highway='unclassified'][zoom>=16]{ line-dasharray: 14,14;}
.road[highway='track'][zoom>=12]{ line-dasharray: 2,2;}
.road[highway='track'][zoom>=13]{ line-dasharray: 3,5;}
.road[highway='track'][zoom>=14]{ line-dasharray: 5,5;}
.road[highway='track'][zoom>=15]{ line-dasharray: 10,10;}
.road[highway='track'][zoom>=16]{ line-dasharray: 14,14;}
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
    line-color: darken(orange,10%);
    line-opacity: 1;
  	line-dasharray: 4,16;
  	
	[zoom>=12]{line-width: 3;}
	[zoom>=14]{line-width: 3;}
	[zoom>=16]{line-width: 3;}
	[zoom>=18]{line-width: 4;}
 }