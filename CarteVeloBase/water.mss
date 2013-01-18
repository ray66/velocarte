
.water.area[size>10000],
.water.area[size>5000][zoom>=15],
.water.area[zoom>=16],
{
  	line-width: 2;
    line-color: #7eaac1;
    /*polygon-fill: #8cb6d3;*/
  	polygon-fill:   #7eaac1;
    line-join: round;
}
.water.area[size>350000][zoom>=13],
.water.area[size>80000][zoom>=15],
.water.area[size>25000][size<=80000][zoom>=16],
.water.area[zoom>=17]
{
	[waterway!='riverbank']{
  		text-name:"[name]";
    	text-wrap-width: 40;
    	text-face-name: "DejaVu Sans Book";
    	text-fill: #2F4F4F;
    	text-halo-fill: #fff;
    	text-halo-radius: 0.5;
    	text-avoid-edges: false;
    	text-placement: interior;
  		text-size: 12;
   		text-placement-type: simple;
    	text-placements: 'X,E,S,W,12,11,10,9,8';
    	/*text-clip: false;*/
  }
}

.water.line
{
    line-color: #7eaac1;
    line-join: round;
    line-cap: round;
}

.water.line[zoom>=13],
.water.line[zoom>=16][waterway='stream']
{
    line-color: #7eaac1;

    /*outline-width: 1;
    outline-color: #7eaac1;
    outline-join: round;*/
}

.water.line[zoom>=11][zoom<=12] { line-width: 2; }
.water.line[zoom>=11][zoom<=12][waterway!='river'] { line-width: 1; }

.water.line[zoom=13] { line-width: 3; }
.water.line[zoom=13][waterway='stream'] { line-width: 1; }

.water.line[zoom=14] { line-width: 5; }
.water.line[zoom=14][waterway!='river'] { line-width: 2; }

.water.line[zoom=15] { line-width: 7; }
.water.line[zoom=15][waterway!='river'] { line-width: 3; }

.water.line[zoom=16] { line-width: 9; }
.water.line[zoom=16][waterway!='river'] { line-width: 5; }

.water.line[zoom>=17] { line-width: 12; }
.water.line[zoom>=17][waterway!='river'] { line-width: 8; }

.water.line[zoom>=14][waterway='river'],
.water.line[zoom>=17]
{
	text-name:"[name]";
    text-wrap-width: 40;
    text-face-name: "DejaVu Sans Book";
    text-fill: #000;
    text-halo-fill: #fff;
    text-halo-radius: 0;
    text-avoid-edges: false;
    text-placement: line;
  	text-size: 14;
  	text-placement-type: simple;
    text-placements: 'X,E,S,W,14,13,12,11,10,9,8';
  	text-min-distance: 400;
    /*text-clip: false;*/
 }
