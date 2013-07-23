Map {
  background-color: #B5D0D0;
  buffer-size: 768;
}
@color-land: #f6f3ee;
@color-outline-minor-lz: #888; /*#bbb*/
@color-outline-minor-hz: #888; /*lighten(#878787,15%);*/
@color-track: #888; /*#adadad #736200;*/
@color-track-4-5: #9B4C14;//#8B4513;


// Colors from Maxim Rylov's style
//@color-building: #d7d5cf;
//@color-building: #E0E0DF;
@color-building: #DFDEDE;
@color_building_line: #D0CDCD;
@color_lu_residential: #ECEAE8;
@color_lu_industrial:  #E2E1DD;

@color_cycleway:    #008B00; /*#034ad8*/
@color_cycleway_outline: #004400;
@color-path: #8B4513;
#land {
  ::outline {
    line-color: #85c5d3;
    line-width: 2;
    line-join: round;
  }
  polygon-fill: @color-land;
}







