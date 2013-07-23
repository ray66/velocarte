<?
   ini_set ("display_errors", "");
   require 'functions.php';
   #phpinfo();
   initData();
?>
<!DOCTYPE html>
<html lang="fr">
<!--<html debug="true">-->
<head>
    <title>
<?php
   echo getMapName();
?>
</title>
<link href="css/style.css" type="text/css" rel="stylesheet" />
<link href="css/lightbox.css" rel="stylesheet" />
<!--     <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>-->
  <script src="js/jquery-1.7.2.min.js"></script> 
   <script src="js/lightbox.js"></script>   

        <script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
    <script src="scripts/OpenLayers.js"></script>
     <script src="scripts/map-mb.js"></script>
    <script src="scripts/OpenStreetMap.js"></script>
   <script src="google-v3.js"></script>
   <META NAME="description" CONTENT="Carte cycliste de Perpignan et ses environs. La vélocarte est une carte qui s'adresse particulièrement à ceux qui favorisent le vélo comme moyen de transport dans le quotidien et pour les loisirs.">
   <META NAME="revisit-after" CONTENT="After 7 days">
   <META NAME="Keywords" CONTENT="openstreetmap, carte, velocarte, map, karte, velo, cyclisme, cycliste, bicycle, perpignan, roussillon, pyrenees, orientales, 66">
   <META NAME="Description" CONTENT="La vélocarte est une carte qui s'adresse particulièrement à ceux qui favorisent le vélo comme moyen de transport dans le quotidien et pour les loisirs.">
  
</head>

<?
      print "<body onload='init([".getBbox()."],[".getBboxDetail()."]);' >";
?>    
<div id="mapPage">
	<div id="topbar">
		<table>
		<tr><td class="left"></td>
		<td class="center"><h1 class="titre">Vélocarte des Pyrénées-Orientales</h1></td>
      <td id="right">
         <ul class="menu">
             <li class="menuitem"><a id="contact" href="mailto:cvp66@sfr.fr">Contact</a></li>
              <li class="menuitem"><a id="blog" href="http://blog.velocarte66.fr" target="_blank">Blog</a></li>
          </ul>
      </td></tr>
		</table>
   </div>
   <div id="sidebarMini">
      <div class="left"><a id="openSidebar" href="#"><img src="img/openSidebar.png" alt=">>" title="Ouvrir la barre d'outils"></a></div>
   </div>
   <div id="sidebar">
      <div class="right"> <a id="closeSidebar" href="#">Fermer</a></div>
      <div class="content">
         <!--<div class="trigger trigger_active">Légende</div>-->
         <div class="trigger">Actualité</div>
         <div class="toggle_container">
            <?php
               require($DOCUMENT_ROOT . "actualite.html");
            ?>                     
            <div class="toggle-container-bottom"></div>
         </div>
         <div class="trigger">Légende</div>
         <div class="toggle_container">
            <?php
               require($DOCUMENT_ROOT . "legende.html");
            ?>                     
            <div class="toggle-container-bottom"></div>
         </div>
         <div class="trigger">Points d'interêt</div>
            <div class="toggle_container">
	                  <form id="poiSelect">
         	            <div class="checkbox"><input type="checkbox" class="poi" id="parkings"></div><div class="checkbox-text"> <h3>Parkings vélo</h3></div>
            	         <div class="checkbox"><input type="checkbox" class="poi" id="locations"></div><div class="checkbox-text"> <h3>Location vélo</h3></div>
            	         <div class="checkbox"><input type="checkbox" class="poi" id="shops"></div><div class="checkbox-text"> <h3>Magasins vélo</h3></div>            	         
                  	</form>
              <div class="toggle-container-bottom"></div>
              		</div>
         <div class="trigger" id="itineraires">Itinéraires  </div>
         <div class="toggle_container">
            <?php
               require($DOCUMENT_ROOT . "itineraires.html");
            ?>                     
            <div class="toggle-container-bottom"></div>
         </div>
         <div class="trigger">Propositions d'aménagement</div>
         <div class="toggle_container">
            <?php
               require($DOCUMENT_ROOT . "propositions.html");
            ?>
                   	   <div class="toggle-container-bottom"></div>
                  	</form>
              	</div>
              <div class="trigger">Voies Vertes et Véloroutes</div>
              <div class="toggle_container">
                <p>
                </p>
         	        <form id="projetsSelect">   
                        <h3>Véloroute du Piémont Pyrénéen - V81</h3>
                        <p>Cette véĺoroute n'est pas encore aménagé entre les Gorges de Galamus et Rivesaltes. </p>
                        <div style='margin-left: 20px'>
                        <div class="checkbox"><input type="checkbox" class="overlay" id="V81-AF3V" data-color="red"></div>
                        <div class="checkbox-text"> <h4>proposition AF3V</h4></div>
                        <div class="checkbox"><input type="checkbox" class="overlay" id="V81-CG66" data-color="blue"></div>
                        <div class="checkbox-text"> <h4>proposition du CG66</h4> </div>
                        </div><div style='clear:both;padding-top: 1em'></div>
             	         <div class="checkbox"><input type="checkbox" class="overlay" id="VvPaysPyreneesMediterranee" data-color="darkmagenta"></div>
            	         <div class="checkbox-text"> <h3>Voie Verte en Pays Pyrénées Méditerranée</h3>
            	                      <p>Projet à l'étude par le Conseil Général 66, tracé arrêté, enquête publique terminée.
       											 </p>
       						</div>
             	         <div class="checkbox"><input type="checkbox" class="overlay" id="Pirinexus" data-color="darkcyan"></div>
            	         <div class="checkbox-text"> <h3>Pirinexus</h3>
            	                      <p>Itinéraire cyclotouristique transfrontalier de 353 km</p>
       						</div>
                   	   
                   	   <div class="toggle-container-bottom"></div>
                  	</form>
              	</div>
              <div class="trigger">Aide</div>
              <div class="toggle_container">
        				<h3 id="Navig">Naviguer dans la Carte</h3>
        				<dl>
          				<dt>Zoom avant/arrière</dt>
          				<dd><p>Vous pouvez zoomer avec la molette de votre souris, en cliquant sur les icônes 
          					 <img src="scripts/img/zoom-plus-mini.png" height="14" alt=""> et 
          					 <img src="scripts/img/zoom-minus-mini.png" height="14" alt=""> dans le coin en haut à gauche ou en
          					 déplaçant la barrette glissante entre ces deux icônes.</p></dd>
			          	<dt>Déplacer la carte</dt>
			          	<dd><p>Faites simplement glisser la carte avec la souris en appuyant sur le bouton gauche.</p></dd>
			         	<dt>Zoom dans la zone détaillée</dt>
		          		<dd><p>Au centre de la carte, entouré d'un cadre rouge, se trouve une zone qui dispose de niveaux de zooms
          			  		 plus détaillées que le reste de la carte. Positionnez le curseur à l'intérieur du cadre pour accéder
          				    aux niveaux détaillés.</p>
          				</dd>
			          	<dt>Créer des liens vers la carte</dt>
          				<dd><p>Vous pouvez créer un lien à partir de la carte actuellement affichée en
          					 cliquant sur <b><i>Permalien</i></b> dans le coin en bas à droite. Ceci aura pour effet de
          					 rafraîchir l'adresse dans la barre d'adresse de votre navigateur internet, laquelle pourra
          					 ensuite être copiée dans vos emails ou commentaires de forums/blog, etc.</p>
          				</dd>
        				</dl>
        				<h3 id="Calques">Calques supplémentaires</h3>
        				<p>L'onglet <img src="scripts/img/layer-switcher-maximize.png" height="14" alt=""> en haut à droite de la
       					 carte permet de changer de carte et de superposer la carte avec des calques supplémentaires</p>
        				<dl>
        					<dt>Calques "Routes" et "Chemins"</dt>
							<dd><p>Ce calque met en valeur des routes mineures et des chemins agricoles et forestiers  
        								qui se prêtent particulièrement pour une utilisation avec le vélo.</p>
						 </dd>
						 <dt>Calque "Courbes de niveau"</dt>
        				<dd><p>Ce calque a été créé avec les données 
           				<a href="http://fr.wikipedia.org/wiki/Shuttle_Radar_Topography_Mission" target="_blank">SRTM</a>
           				du site <a href="http://www.viewfinderpanoramas.org/" target="_blank">viewfinderpanoramas.org</a>.
           				Ce calque n'est pas disponible dans les niveaux de zoom détaillés. 
        					</p>
        				</dd>
        				</dl>
        		  </div>
              <div class="trigger">En savoir plus...</div>
              <div class="toggle_container">
        			  <dl>
							<dt>Qu'est-ce que c'est une »<strong>vélocarte</strong>« ?</dt>
        					<dd>
        						<p>La vélocarte est une carte qui s'adresse particulièrement à ceux qui favorisent le vélo comme moyen de transport dans 
        						le quotidien et pour les loisirs. Pour cela, elle met en valeur les aménagements et équipements destinés aux cyclistes: 
        						pistes et bandes cyclables, voies vertes, véloroutes, stations de location, parkings à vélo, magasins de vélo.
        						En dehors des agglomérations, la carte expose particulièrement les routes de faible densité de trafic automobile 
        						et les chemins ruraux classés par la qualité de leur revêtement. </p>
        						<p>La carte couvre la partie est du département des Pyrénées-Orientales (66).</p>
        					</dd> 
        					<dt>Comment est réalisée cette carte ?</dt>
        					<dd><p>Cette carte a été créée grâce au projet <a href="http://www.openstreetmap.fr/" target="_blank">OpenStreetMap</a>. 
    		  					 OpenStreetMap (OSM) est un projet international fondé en 2004 dans le but de créer une carte libre du monde. 
    		  					 Des milliers de volontaires dans le monde entier collectent des données sur les routes, voies ferrées, les rivières, 
    		  					 les forêts, les bâtiments et bien plus encore. Les données cartographiques ainsi collectées sont ré-utilisables sous 
    		  					 licence libre ODbL.</p>
           					 <p>Tous les éléments présent sur la carte sont dessinés à partir des données du projet OpenStreetMap. 
          					 Ce qui n'existe pas dans la base de données OSM ne peut donc pas être sur la carte. Mais toutes les données OpenStreetMap 
        					    ne sont pas présent sur la carte, comme c'est le cas pour certains équipements destinés aux automobilistes tel que les 
        					    parkings et stations-service. Par-contre, vous trouvez des éléments sur cette carte qui ne sont pas présent sur d'autres 
        					    cartes basés sur OSM, comme par exemple les parkings à vélo et les bandes cyclables.    </p>
								<dl>
									<dt class="kleingedruckt">Avis</dt>
									<dd class="kleingedruckt"><p>Le classement des routes et pistes est donnée à titre indicatif. Il est le résultat d'une évaluation par un ou plusieurs 
				 						 contributeurs du projet Openstreetmap. Bien que ceux-ci essayent d'assurer une classification homogène, 
										 il peut y avoir des erreurs de classifications. </p>  
           						</dd>
			  					</dl>
			  				</dd>
			  			</dl>
			  			<h2 id="InfoTech">Informations techniques</h2>
        <p>Ces informations s'adressent à des personnes qui maîtrisent les outils osmosis, PostGis, Tilemill et Openlayers. 
           Les fichiers de configuration et de style utilisés sont libre de tout droit et peuvent être reprises et modifiées. 
           La seule chose que je demande, c'est de m'informer de tout projet qui reprend une partie du mien, 
           qui s'en inspire ou qui après l'avoir regardé prend une voie différente. 
           J'apprécie aussi tout commentaire critique.
         </p>
           <dl>
				<dt>Avis</dt>
				<dd><p>Initialement, ce projet n'était pas destiné à être publié et les fichiers ne sont donc 
           		 pas très bien structurés et documentés. Ils ne répondent en aucun cas à mes propres exigences en matière 
           		 de génie logiciel.</p>
           	</dd>
			  </dl>
        <p> La carte a été réalisée avec la chaîne d'outils suivante:</p>
            <ul>
               <li>Import des données OSM dans une base de données PostGIS avec osm2pgsql:
                  <div class='pre'><pre>osm2pgsql -c -m -s -d osm -U &lt;user&gt; -W -H localhost &lt;osmfile&gt; -S osm2pgsql.style</pre></div>
                  &lt;osmfile&gt; est le fichier au format OSM (.osm, .osm.bz2 ou .pbf) qui contient les données OSM de la zone à couvrir. 
                  Il peut être créé avec osmosis à partir d'un extrait <a href="http://download.geofabrik.de/" target="_blank">geofabrik.</a>
                  On peut aussi utiliser un extrait "région" ou "pays" et utiliser osm2pgsql avec l'option --bbox pour extraire une zone géographique. 
               </li>
               <li>Traitement de la base de données pour faciliter l'exploitation avec Tilemill/Mapnik:
                  <div class='pre'><pre>psql -d osm -f postproc.sql</pre></div>
                  Actuellement ce traitement consomme beaucoup de temps, plus que le processus de rendu lui-même.  
               </li>
               <li>Si la zone à couvrir comprend la ligne côtiere: création d'un fichier shp pour la ligne côtiere, 
                   qui sera utilisé pour le calque "land" dans Tilemill:
               	<ul>
                  	<li>Télécharger le fichier shape du site de Jochen Topf: <a href="http://data.openstreetmapdata.com/land-polygons-split-4326.zip" target="_blank">land-polygons-split-4326.zip</a></li>
                  	<li>Ouvrir ce fichier dans QGis: 
                  		<ul>
                  			<li>"Couche / Ajouter une couche vecteur"</li>
                  			<li>Sélectionner les polygones qui couvrent la zone de la future carte.  </li>
                  			<li>Sauvgarder avec "Couche / save selection as vector file" dans layers/land/coast.shp 
                  			    dans le répertoire projet de Tilemill</li>
                  		</ul>
                  	</li>
               	</ul>
               	Si vous connaissez une façon plus simple pour créer le fichier .shp ou une source avec des fichiers 
               	ligne côtière par pays/région, merci de me le signaler. 
               </li>
               <li>Géneration de la carte avec Tilemill:
                	<ul>
	                	<li>Un projet pour le calque de base "Carte Velo Base" et un projet pour le calque overlay "Carte Velo Chemins"</li>
                		<li>Pour la génération des tuiles à déployer, on peut lancer Tilemill en mode "batch":
                			 <div class='pre'><pre >tilemill export --format=mbtiles --files=&lt;répertoire tilemill&gt; --metatile=8 CarteVeloBase CarteVeloBase.mbtiles</pre></div>
                			 Pour éviter des artefacts aux limites entre deux tuiles, tel que des libellés tronqués, 
                			 et une répétition des noms de rue non-conforme avec le paramètre text-spacing, 
                			 il faut choisir une valeur metatile de >= 8 et une buffer-size de 768 ou plus dans le style "Map";
                		</li>
               	 </ul>
               	 Le résultat est un fichier .mbtiles.
               </li>
               <li>
                  Publication sur le site avec OpenLayers. On peut utiliser directement le fichier .mbtiles avec un layer du type TMS
                  ou bien les tuiles extraites du fichier .mbtiles à l'aide de l'outil mb-util avec un layer OSM. 
                  Comme les fichiers .mbtiles sont plus compactes que les tuiles extraites, j'ai opté pour la première solution.
               </li>
            </ul>
            <p>Vous trouvez des informations plus détaillées sur quelques points spécifiques, en particulier le traitement des données PostGis, sur <a href="http://blog.velocarte66.fr" target="_blank">mon 
               blog</a> (en allemand pour l'instant)</p>
        <p>Tous les fichiers utiliés pour générer et publier la carte sont disponibles sur <a href="https://github.com/ray66/velocarte" target="_blank">GitHub</a>.</p>
              </div>
       <div class="trigger">Conditions d'utilisations, licences, remerciements</div>
       <div class="toggle_container">
               <h3>Licences</h3>
         	      <p>Données de la carte de base et des calques "Routes" et "Chemins" : © les contributeurs d’<a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a>, disponibles sous la licence ODbL </p>
				      <p>Données SRTM (courbes de niveau) : <a href="http://www2.jpl.nasa.gov/srtm/" target="_blank">© NASA SRTM</a> et <a href="http://www.viewfinderpanoramas.org/" target="_blank">viewfinderpanoramas.org</a></p>
		   
        			<h3>Conditions d'utilisation</h3>
        			<p>Les tuiles de la carte vélo, du calque "OpenStreetMap Mapnik" et du calque "OpenCycleMap" sont disponibles sous la licence 
          			 <a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">Creative Commons paternité – partage à l’identique 2.0</a> (CC-BY-SA).
        			</p>
        <br/>
        <h3>Remerciements</h3>
        <p>Cette carte a été inspiré des cartes des associations <a href="http://carte.apicy.fr/" target="_blank">APiCy</a>,
           <a href="http://carte.velobesancon.info/" target="_blank">AVB</a> et 
           <a href="http://carte.lavilleavelo.org/" target="_blank">La Ville à Vélo</a> et 
           du <a href ="http://wiki.openstreetmap.org/wiki/File:L%C3%BCbeckerFahrradStadtplan-Ausschnitt.jpg" target="_blank">plan de ville de l'ADFC de Lübeck</a>. 
        </p>
        <p>Certains icônes proviennet de <a href="http://mapicons.nicolasmollet.com">Mapicons Collection</a> de Nicolas Mollet sous license <a href="http://creativecommons.org/licenses/by-sa/3.0/">
           CC BY SA 3.0</a>. Des elements du style de la carte, les couleurs du terrain et des bâtiments en particulier, ont été inspirés de la carte 
           <a href="http://openmapsurfer.uni-hd.de/">OpenMapSurfer</a>, merci à à Maxim Rylov pour l'autorisation.
        <p>L'association <a href="http://veloentet.free.fr/" target="_blank">Vélo en Têt</a> et ses adhérents fournissent des informations
        précieuses sur l'état des aménagements cyclables de Perpignan et ses environs et permettent ainsi d'améliorer les données du projet OpenStreetMap
        et de cette carte.                
 				</p>
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
