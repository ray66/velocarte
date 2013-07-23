#transport_point{
   [point='station']{
      [zoom>=12]{
         point-file: url('img/transport_train_station2.p.16.png');
         point-allow-overlap: true;
         point-ignore-placement: true;
      }
      [zoom>=14]{
         point-file: url('img/transport_train_station2.p.20.png');
	     text-dy: -11;
      	text-name:"[name]";
      	text-wrap-width: 40;
      	text-fill: #000;
      	text-face-name: "DejaVu Sans Bold";
      	text-halo-fill: #fff;
      	text-halo-radius: 0;
      	text-avoid-edges: false;
      	text-placement-type: simple;
      	text-placements: 'X,E,W,10,9,8';
      }
      [zoom>=16]{
         point-file: url('img/transport_train_station2.p.24.png');
	     text-dy: -12;
      }
   }
   [point='bus_stop']{
      [zoom>=16]{
         point-file: url('img/transport_bus_stop.p.12.png');
         point-ignore-placement: false;
         point-allow-overlap: true;
      }
      [zoom>=17]{
       text-name:"[name]";
       text-wrap-width: 40;
       text-fill: #01317d;
       text-face-name: "DejaVu Sans Book";
       text-halo-fill: #fff;

       text-halo-radius: 0;
       text-avoid-edges: false;
       text-dy: -8;
       text-placement-type: simple;
       text-size: 9;
 	   text-placements: 'X,N,E,W,S,NE,SE,SW,NW,9,8';
       /*text-allow-overlap: true;*/
      }
   }
}
/*===================================================================================*/
/* Rail
/*===================================================================================*/
.rail
{
  [bridge='yes'][zoom>=13]{
     ::bridge_out{
      		/*line-color: k#d2d2d2;*/
      		line-color: #6f6f6f;
    		line-width: 7;
      	}
  ::bridge_in{
      		/*line-color: k#d2d2d2;*/
      		line-color: white;
    		line-width: 5;
      	}
    }
  [zoom>=11]{
  ::outline{
   		line-join: round;
   		line-color: darken(#999999,15%);
		[tunnel='yes']{
			line-color: lighten(#999999,10%);
        }
   		line-width: 3;
   }
   line-join: round;
   line-color: white;
   line-width: 1;
   line-dasharray: 0,11,8,1;
   [zoom=11]{
      line-dasharray: 0,5,4,1;
   }
    }
}

/*===================================================================================*/
/* Airports (tbd)
/*===================================================================================*/
.transit.point[aeroway=airport][zoom>=12][zoom<=13],
.transit.point[aeroway=aerodrome][zoom>=12][zoom<=13]
{
    point-file: url('img/icons/16x16/symbol/transport/amenity=airport.png');
    text-dy: 20;
}

.transit.point[aeroway=airport][zoom>=9][zoom<=11],
.transit.point[aeroway=aerodrome][zoom>=9][zoom<=11]
{
    point-file: url('img/icons/12x12/symbol/transport/amenity=airport.png');
    text-dy: 18;
}
/*===================================================================================*/
/* Power Lines
/*===================================================================================*/
#power_line{
  [zoom>=14]{
  	line-color: grey;
    line-width: 0.2;
  }
  [zoom>=15]{
  	line-color: darkgrey;
    line-width: 0.3;
  }
  [zoom>=16]{
    line-width: 0.5;
  }
}
#power_point{
  [power='tower']{
    [zoom>=14]{
	  	point-file: url('img/power_tower.svg');
        point-transform: 'scale(0.1)';
    }
    [zoom>=15]{
      point-transform: 'scale(0.2)';
    }
    [zoom>=16]{
      point-transform: 'scale(0.3)';
    }
  }

  [power='generator']["generator:source"='wind']{
    [zoom>=14]{
	  	point-file: url('img/wind_generator.svg');
        point-transform: 'scale(0.25)';
    }
    [zoom>=16]{
        point-transform: 'scale(0.5)';
    }

    [zoom>=17]{
        point-transform: 'scale(0.7)';
    }
  }
}
      
