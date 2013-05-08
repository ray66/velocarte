Map {
  background-color: transparent;
  buffer-size: 768;
}

@color-rcn: #990000;
@color-ncn:#ff8000;
/*===================================================================================*/
/* Bicycle Routes
/*===================================================================================*/
#cycleroute_line{
  ::nat[network='ncn']{
    [zoom>=13]{
      text-name:"[route_name]";
      text-face-name: "DejaVu Sans Bold";
      text-fill: @color-ncn;
      text-halo-fill: #fff;
      text-halo-radius: 1;
	  text-size: 10;
  	  text-dy: 10;
      text-placement: line;
      text-max-char-angle-delta: 40;
    }
    line-cap: round;
    line-join: round;
    line-color: @color-ncn;
    line-opacity: 0.7;
  	
	[zoom>=11]{ line-width: 5; 	}
	[zoom>=14]{ line-width: 8;  	}
	[zoom>=16]{ line-width: 11;  	}
	[zoom>=17]{ line-width: 13;  	}
	[zoom>=18]{ line-width: 15;  	}
  }
  ::reg[network='rcn']{
    [zoom>=13]{
      text-name:"[route_name]";
      text-face-name: "DejaVu Sans Bold";
      text-fill: @color-rcn;
      text-halo-fill: #fff;
      text-halo-radius: 1;
	  text-size: 10;
  	  text-dy: 10;
      text-placement: line;
      text-max-char-angle-delta: 40;
    }
    line-cap: round;
    line-join: round;
    line-color: @color-rcn;
    line-opacity: 0.7;
  	
	[zoom>=11]{ line-width: 2; 	}
	[zoom>=14]{ line-width: 4;  	}
	[zoom>=16]{ line-width: 6;  	}
	[zoom>=17]{ line-width: 7;  	}
	[zoom>=18]{ line-width: 8;  	}
  }
}
#cycleroute_shield{
  ::ncn["network"='ncn'],
  ::rcn["network"='rcn'],
  ::lcn["network"='lcn'] {
    shield-name:"[ref]";
    shield-face-name: "DejaVu Sans Bold";
    shield-size: 10;
    shield-fill: #fff;
    shield-avoid-edges: false;
    shield-placement: line;
    shield-dx: 5;
    shield-dy: 5;
  }

  ::ncn["network"='ncn']{
    [zoom>=11]{shield-min-distance: 50;}
    [zoom>=13]{shield-min-distance: 0;}
    shield-spacing: 870;
    shield-file: url('img/cartouche_ncn-2.png');
	[ref_length=3] { shield-file: url('img/cartouche_ncn-3.png');}
	[ref_length=4] { shield-file: url('img/cartouche_ncn-4.png');}
	[ref_length=5] { shield-file: url('img/cartouche_ncn-5.png');}
	[ref_length=6] { shield-file: url('img/cartouche_ncn-6.png');}
   }
  ::rcn["network"='rcn']{
    [zoom>=11]{shield-min-distance: 0;}
    [zoom>=13]{shield-min-distance: 0;}
  	shield-file: url('img/cartouche_rcn-2.png');
	[ref_length=3] { shield-file: url('img/cartouche_rcn-3.png');}
	[ref_length=4] { shield-file: url('img/cartouche_rcn-4.png');}
	[ref_length=5] { shield-file: url('img/cartouche_rcn-5.png');}
	[ref_length>=6] { shield-file: url('img/cartouche_rcn-6.png');}
  }
  ::lcn["network"='lcn']{
    [zoom>=11]{shield-min-distance: 00;}
    [zoom>=13]{shield-min-distance: 00;}
    shield-min-padding: 10;
    shield-spacing: 310;
  	shield-file: url('img/cartouche_rcn-2.png');
	[ref_length=3] { shield-file: url('img/cartouche_rcn-3.png');}
	[ref_length=4] { shield-file: url('img/cartouche_rcn-4.png');}
	[ref_length=5] { shield-file: url('img/cartouche_rcn-5.png');}
	[ref_length>=6] { shield-file: url('img/cartouche_rcn-6.png');}
  }
}


