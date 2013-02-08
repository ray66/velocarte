<?
   ini_set ("display_errors", "");
   require 'functions.php';
   #phpinfo();
   initData();
?>
<!DOCTYPE html>
<html>
<!--<html debug="true">-->
<head>
    <title>
<?php
   echo getMapName();
?>
</title>
<link href="css/style.css" type="text/css" rel="stylesheet" />

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>

    <script src="scripts/OpenLayers.js"></script>
     <script src="scripts/map-mb.js"></script>
    <script src="scripts/OpenStreetMap.js"></script>

   <link rel="canonical" href="http://velocarte66.fr" />
   <META NAME="Title" CONTENT="Carte cycliste de Perpignan et ses environs">
   <META NAME="Revisit" CONTENT="After 7 days">
   <META NAME="Keywords" CONTENT="openstreetmap, carte, velocarte, map, karte, velo, cyclisme, cycliste, bicycle, perpignan, roussillon, pyrenees-orientales">
   <META NAME="Description" CONTENT="La vélocarte est une carte qui s'adresse particulièrement à ceux qui favorisent le vélo comme moyen de transport dans le quotidien et pour les loisirs.">
   <META NAME="Abstract" CONTENT="La vélocarte est une carte qui s'adresse particulièrement à ceux qui favorisent le vélo comme moyen de transport dans le quotidien et pour les loisirs.">
   <META NAME="page-topic" CONTENT="Umwelt">
   <META NAME="page-topic" CONTENT="Karte Plan">
   <META NAME="Language" CONTENT="French">

   
</head>

<?
      print "<body onload='init([".getBbox()."],[".getBboxDetail()."]);' >";
?>    
      <div id="page">
          <div id="sidebar">
<!--
              <a href="osm">
                       <img title="Carte des aménagements cyclables"
                            alt="" 
                            src="logo.png">
              </a>
-->
              <div class="titre">Vélocarte de Perpignan</div>
              <br>
              <div class="trigger">Légende</div>
						<div class="toggle_container">
              			<img title="Légende" alt="Légende" src="img/legende.png">
						</div>
              <div class="trigger">Points d'interêt</div>
						<div class="toggle_container">
	                  <form id="poiSelect">
      	               <p>
         	            <input type="checkbox" class="poi" id="parkings"> Parkings vélo<br>
            	         <input type="checkbox" class="poi" id="locations"> Location vélo<br>
               	      </p>
                  	</form>
              		</div>
              <div class="text">
                <br>
                <a href="notice.php">En savoir plus...</a>
                <br><br>

                <a id="contact" href="mailto:cvp66@sfr.fr">Contact</a>

            </div>
          </div>
 
          <div id="basicMap"> 

      <noscript>
    <div style="position: absolute;top: 15px;left: 15px;z-index: 20000000;" id="noscript">
    <p>Vous utilisez soit un navigateur qui ne supporte pas Javascript soit vous avez désactivé Javascript.</p>
    <p>Désactiver Javascript pour des raisons de securité est une bonne chose, mais ce site utilise Javascript pour ses cartes glissantes. </p>
    <p>Si vous voulez voir les cartes, activez Javascript dans les préférences de votre navigateur. Si vous utilisez une extension tel que NoScript,
    autorisez Javascript pour ce site.</p>
  </div>
</noscript>
</div>

      </div>

      
      
  </body>
</html>
