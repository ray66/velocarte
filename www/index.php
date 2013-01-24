<?
   ini_set ("display_errors", "");
   require 'functions.php';
   #phpinfo();
   initData();
?>
<!--<html debug="true">-->
<head>
    <title>
<?php
   echo getMapName();
?>
</title>
<link href="css/style.css" type="text/css" rel="stylesheet" />


    <script src="scripts/OpenLayers.js"></script>
     <script src="scripts/map-mb.js"></script>
    <script src="scripts/OpenStreetMap.js"></script>


</head>
<?
      print "<body onload='init([".getBbox()."],[".getBboxDetail()."]);' >";
?>    
    

      <div id="page">
          <div id="sidebar">
              <a href="osm">
                       <img title="Carte des aménagements cyclables"
                            alt="" 
                            src="logo.png">
              </a>
              <div class="titre">Carte des aménagements cyclables de Perpignan</div>
              <br>
              <img checked="true" title="Légende" alt="Légende" src="img/legende.png">
              <br>
              <div class="text">

                <a href="notice.html">Notice de la carte</a>
                <br><br><br>

                <a id'="contact" href="mailto:cvp66@sfr.fr">Contact</a>

            </div>
          </div>

          	<div id="basicMap"> 

          </div>

        </tbody>

      </div>
    </font>
  </body>
</html>
