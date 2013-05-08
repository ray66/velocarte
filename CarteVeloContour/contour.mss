#contours{
	[step=100],
    [step=200]{
    	[zoom>=11]{
      		line-smooth: 1;
  			line-color: #9cb197;
	  		line-width: 0.7;
      		polygon-fill: transparent;
        }
    
    	[zoom>=12][step=200],
        [zoom>=13][step=100]{
      		text-name: '[height]';
      		text-face-name: 'DejaVu Sans Book';
      		text-size: 8;
  			text-fill: darken(#9cb197,25%);
      		text-placement: line;
      		text-spacing: 400;
    	}
  
    	[zoom>=13]{
  			line-color: #747b90;
  			text-fill: darken(#747b90,25%);
      		text-size: 8;
	  		line-width: 0.7;
      		text-spacing: 400;
    	}
    	[zoom>=14]{
  			line-color: #855d62;
  			text-fill: #855d62;
	  		line-width: 0.7;
    	}
    	[zoom>=15]{
          	text-size: 10;
        }
  }
    
	[step=50]{
    	[zoom=13]{
      		line-smooth: 1;
  			line-color: #9cb197;
	  		line-width: 0.6;
    	}
    	[zoom>=15]{
  			line-color: #747b90;
      		line-smooth: 1;
	  		line-width: 0.6;
      		text-name: '[height]';
      		text-face-name: 'DejaVu Sans Book';
      		text-size: 9;
  			text-fill: #747b90;
      		text-placement: line;
      		text-spacing: 200;
    	}
    }

	[step=20]{
    	[zoom>=14]{
      		line-smooth: 1;
  			line-color: #9cb197;
	  		line-width: 0.5;
    	}
    }
    [step=10]{
    	[zoom>=15]{
      		line-smooth: 1;
  			line-color: #9cb197;
	  		line-width: 0.5;
    	}
    }
    [step=20],
    [step=10]{
    	[zoom>=17]{
    	    text-name: '[height]';
      		text-face-name: 'DejaVu Sans Book';
      		text-size: 9;
  			text-fill: #9cb197;
      		text-placement: line;
      		text-spacing: 200;
		}
    }
    	


}
