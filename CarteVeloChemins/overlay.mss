/**===================================================================================
 * Unclassified/Track
/**===================================================================================*/

/** Path Colors **/

.road {
  line-color: #00428a;
  line-cap: butt;
  line-opacity: 0.8;
  [zoom>=12]{ line-width: 3; }
  [zoom>=14]{ line-width: 3; }   
  [zoom>=15]{ line-width: 5; }   
  [zoom>=16]{ line-width: 6; }   
  [zoom>=17]{ line-width: 7; }   
  [zoom>=18]{ line-width: 8; }   
}
.path {line-color: brown; 
  line-opacity: 0.8;
  [zoom>=12]{
       line-dasharray: 3,3;
       line-width: 1;
  }
  [zoom>=15]{
       line-dasharray: 5,4;
       line-width: 2;
  }
}
.road[tracktype='grade2'],
.road[tracktype='grade3']
{
  line-color: brown;
  [zoom>=12]{ line-width: 1; }  
  [zoom>=14]{ line-width: 2; }  
  [zoom>=15]{ line-width: 3; }
  [zoom>=16]{ line-width: 5; }
  [zoom>=17]{ line-width: 6; }
}
.road[tracktype='grade3']
{
  [zoom>=12]{
      line-dasharray: 4,4;
  }
  [zoom>=16]{
      line-dasharray: 8,8;
  }
}

.road[highway='unclassified'][zoom>=12]{ line-dasharray: 4,4;}
.road[highway='unclassified'][zoom>=14]{ line-dasharray: 6,6;}
.road[highway='unclassified'][zoom>=16]{ line-dasharray: 8,8;}
