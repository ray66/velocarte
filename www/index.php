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
<div id="mapPage">
	<div id="topbar">
		  <h1 class="titre">Vélocarte de Perpignan</h1>
   </div>
   <div id="sidebarMini">
      <div class="left"><a id="openSidebar" href="#"><img src="img/openSidebar.png" alt=">>" title="Ouvrir la barre d'outils"></a></div>
   </div>
   <div id="sidebar">
      <div class="content">
   	   <div class="right"> <a id="closeSidebar" href="#">Fermer</a></div>
         <!--<div class="trigger trigger_active">Légende</div>-->
         <div class="trigger">Légende</div>
						<div class="toggle_container">
              			<img title="Légende" alt="Légende" src="img/legende.png">
                     <div class="toggle-container-bottom"></div>
						</div>
              <div class="trigger">Points d'interêt</div>
						<div class="toggle_container">
	                  <form id="poiSelect">
         	            <div class="checkbox"><input type="checkbox" class="poi" id="parkings"></div><div class="checkbox-text"> <h3>Parkings vélo</h3></div>
            	         <div class="checkbox"><input type="checkbox" class="poi" id="locations"></div><div class="checkbox-text"> <h3>Location vélo</h3></div>
                  	</form>
              <div class="toggle-container-bottom"></div>
              		</div>
              <div class="trigger">Itinéraires  </div>
              <div class="toggle_container">
						<p>Quand on circule à vélo, il faut parfois chercher longtemps un itinéraire pour traverser 
         	         une autoroute, une route dangereuse, emmener des enfants avec soi. Voici quelques itinéraires
         	         qui empruntent de très petites routes ou des pistes, et qui devraient vous aider à rejoindre 
         	         à bicyclette, et souvent avec le plaisir d'une balade,des endroits parfois difficiles à 
         	         atteindre en toute sécurité<br>Une partie de ces itinéraires a été repris des "Astuces cyclables" de 
         	         l'association <a href="http://veloentet.free.fr/spip.php?breve55&var_recherche=astuces" target="_blank">Vélo En Tet</a>
         	       </p>
         	         <form id="circuitSelect">
         	            <div class="checkbox"><input type="checkbox" class="overlay" id="PerpignanCanet"></div>
         	            <div class="checkbox-text"> <h3>Perpignan - Canet par le Mas LLaro</h3> </div>
         	            <div class="checkbox"><input type="checkbox" class="overlay" id="PerpignanCanetParJardinsStJacques"></div>
         	            <div class="checkbox-text"> <h3>Perpignan - Canet par les Jardins St.Jacques</h3> </div>
         	            <div class="checkbox"><input type="checkbox" class="overlay" id="PerpignanMillas"></div>
         	            <div class="checkbox-text"> <h3>Perpignan - Millas</h3> </div>
                   	   <div class="toggle-container-bottom"></div>
                  	</form>
              		</div>
              <div class="trigger">Propositions d'aménagement</div>
              <div class="toggle_container">
                <p>Vous trouvez ici quelques propositions d'aménagements cyclables faites par 
                   l'association <a href="http://veloentet.free.fr" target="_blank">Vélo En Tet</a>
                </p>
         	        <form id="propositionsSelect">
             	         <div class="checkbox"><input type="checkbox" class="overlay" id="RecDelMoli"></div>
            	         <div class="checkbox-text"> <h3>Le Rec del Molí</h3>
            	                      <p>Le “Rec del Molí” est un ancien canal d’irrigation qui prend son eau dans la Basse, et la mène jusqu’à Canet-en-Roussillon. 
                                        Vélo en Têt propose qu’il soit aménagé en itinéraire piéton et cyclable du centre de Perpignan jusqu’au littoral. 
       											 </p><p>Plus d'informations sur le site de <a href=http://veloentet.free.fr/spip.php?article200 target=_blank>Vélo en Têt</a>.</p>
       						</div>
                   	   
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
