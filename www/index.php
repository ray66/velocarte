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
              <h1 class="titre">Vélocarte de Perpignan</h1>
              <br>
              <div class="trigger trigger_active">Légende</div>
						<div class="toggle_container">
              			<img title="Légende" alt="Légende" src="img/legende.png">
                     <div class="toggle-container-bottom"></div>
						</div>
              <div class="trigger">Points d'interêt</div>
						<div class="toggle_container">
	                  <form id="poiSelect">
         	            <div class="checkbox"><input type="checkbox" class="poi" id="parkings"></div><div class="checkbox-text"> Parkings vélo</div>
            	         <div class="checkbox"><input type="checkbox" class="poi" id="locations"></div><div class="checkbox-text"> Location vélo</div>
                  	</form>
              <div class="toggle-container-bottom"></div>
              		</div>
              <div class="trigger">Circuits  </div>
              <div class="toggle_container">
         	        <form id="overlaySelect">
         	            <div class="checkbox"><input type="checkbox" class="overlay" id="astuces"></div>
         	            <div class="checkbox-text"> <em>Les »Astuces«</em> 
         	                                        <p>Quand on circule à vélo, il faut parfois chercher longtemps un itinéraire pour traverser 
         	                                        une autoroute, une route dangereuse, emmener des enfants avec soi. Voici quelques itinéraires
         	                                        qui empruntent de très petites routes ou des pistes, et qui devraient vous aider à rejoindre 
         	                                        à bicyclette, et souvent avec le plaisir d'une balade,des endroits parfois difficiles à 
         	                                        atteindre en toute sécurité<br>Une partie de ces itinéraires a été repris des "Astuces cyclables" de 
         	                                        l'association <a href="http://veloentet.free.fr/spip.php?breve55&var_recherche=astuces" target="_blank">Vélo En Tet</a></p>
        	               </div>

            	         <div class="checkbox"><input type="checkbox" class="overlay" id="propositions"></div>
            	         <div class="checkbox-text"> Propositions d'aménagement</div>
                   	   
                   	   <div class="toggle-container-bottom"></div>
                  	</form>
              		</div>
              <div class="text">
                <br>
                <a href="notice.php">En savoir plus...</a>
                <br><br>

                <a id="contact" href="mailto:cvp66@sfr.fr">Contact</a>

            </div>
          </div>
 			 <div id="sidebar2" > <a class="sidebar2Close" href="#">Fermer</a> 
 			 	<div id="sidebar2Content"></div>
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
