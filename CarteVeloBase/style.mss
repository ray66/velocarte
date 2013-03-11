Map {
  background-color: #B5D0D0;
  buffer-size: 768;
}

@color-land: #f6f3ee;
@color-outline-minor-lz: #888; /*#bbb*/
@color-outline-minor-hz: #888; /*lighten(#878787,15%);*/
@color-track: #888; /*#adadad #736200;*/
@color-building: #d7d5cf;

#land {
  ::outline {
    line-color: #85c5d3;
    line-width: 2;
    line-join: round;
  }
  polygon-fill: @color-land;
}









