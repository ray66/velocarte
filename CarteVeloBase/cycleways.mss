#lane_join{
  line-color: red;
  [cycleway_right != '']{
     line-offset: -10;
  }
  [cycleway_left != '']{
     line-offset: 10;
  }
  line-width: 3;
  text-name:"[id]";
  text-face-name: "DejaVu Sans Book";
}


