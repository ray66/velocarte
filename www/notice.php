<!DOCTYPE html>
<?
   ini_set ("display_errors", "");
   require 'functions.php';
   #phpinfo();
   initData();
?>




<html>
<head>
  <meta name="generator" content="Bluefish 2.2.3" >
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
   <link href = "css/style.css" type = "text/css" rel = "stylesheet">
   <title>
<?php
   echo getMapName();
?>
	</title>
</head>

<body>
  <div id = "page">
	<div id="topbar">
		  <h1 class="titre">Vélocarte de Perpignan</h1>
   </div>

   <div id="sidebar">
      <h2> <a href="index.php">Accueil</a> </h2>
      <br>
      <!--<img title = "Légende" alt ="Légende" src = "img/legende.png"><br><br>-->
      <div class = "text">  
       <a id="contact" href="mailto:cvp66@sfr.fr" >Contact</a>
      </div>
   </div>
   <div class="content" >
        
			<h4 class="sommaire"><a href="#InfoGen" >Informations générales</a></h4>
			<h4 class="sommaire"><a href="#Navig" >Naviguer dans la Carte</a></h4>
			<h4 class="sommaire"><a href="#Calques">Calques supplémentaires</a></h4>
			<h4 class="sommaire"><a href="#Contact">Comment signaler une erreur, faire une proposition, etc.?</a></h4>
			<h4 class="sommaire"><a href="#Licences">Conditions d'utilisations, licences, remerciements</a></h4>
			<h4 class="sommaire"><a href="#InfoTech">Informations techniques</a></h4>
        <p>
            En signalant une erreur ou un élément manquant, vous contribuez non seulement à améliorer la qualité de cette carte
            mais de toutes les cartes et applications qui utilisent les données OpenStreetMap. Quelques exemples:
         </p>
          <ul>
            <li>Cartes spécialisés:
              <ul>
                 <li><a href="http://wheelmap.org/" target="_blank">Wheelmap.org</a>
                 </li>
                 <li><a href="http://cycling.waymarkedtrails.org/" target="_blank">Waymarked Trails</a>, la carte des circuits de randonnée cyclistes
                 </li>
              </ul>
            </li>
            <li>Applications de calcul d'itineraire:
              <ul>
                 <li>en ligne: <a href="http://openrouteservice.org/" target="_blank">OpenRouteService</a>
                 </li>
                 <li>mobile: <a href="http://osmand.net/" target="_blank">Osmand</a>
                 </li>
              </ul>
            </li>
            <li>Cartes pour GPS Garmin:
              <ul>
                 <li><a href="http://fredericbonifas.free.fr/osm/garmin.html" target="_blank">France</a>
                 </li>
                 <li>mobile: <a href="http://garmin.openstreetmap.nl/" target="_blank">Monde</a>
                 </li>
              </ul>
            </li>
          </ul>
        </dd>
        </dl>


        <h2 id="Contact">Comment signaler une erreur, faire une proposition, etc.?</h2>
      	   <p>Si vous rencontrez un problème avec l'utilisation de ce site ou si vous voulez proposer une amélioration du site 
      	      ou de la carte	vous pouvez envoyer un mail par le lien <a href="mailto:cvp66@sfr.fr" >Contact</a> sur la gauche de la page.
        		</p>  
        		<p>Si vous constatez qu'une voie ou un équipement que vous connaissez n'est pas visible sur la carte ou bien présenté de fa₵on incorrecte,
        		  vous pouvez signaler par mail. Si vous pensez qu'un objet n'est pas présent ou incorrect dans les données OSM,  
        		  vous pouvez utiliser l'outil <a href="http://openstreetbugs.schokokeks.org/?lon=2.83208&amp;lat=42.70477&&amp;zoom=12&&amp;layers=B0" target="_blank">OpenStreetBugs</a> pour le signaler à la communauté OSM. 
        		  Vous pouvez aussi corriger et saisir vous-même par l'intermédiaire du site <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> (onglet "modifier")
              ou avec un éditeur OSM hors-ligne tel que <a href="http://josm.openstreetmap.de/">JOSM</a>. 
            </p>

        </p>
        <h2 id="InfoTech">Informations techniques</h2>
        <p>Ces informations s'adressent à des personnes qui maîtrisent les outils osmosis, PostGis, Tilemill et Openlayers. 
           Les fichiers de configuration et de style utilisés sont libre de tout droit et peuvent être reprises et modifiées. 
           La seule chose que je demande, c'est de m'informer de tout projet qui reprend une partie du mien, 
           qui s'en inspire ou qui après l'avoir regardé prend une voie différente. 
           J'apprécie aussi tout commentaire critique.
         </p>
           <dl>
				<dt>Avis</dt>
				<dd>Initialement, ce projet n'était pas destiné à être publié et les fichiers ne sont donc 
           		 pas très bien structurés et documentés. Ils ne répondent en aucun cas à mes propres exigences en matière 
           		 de génie logiciel.
           	</dd>
			  </dl>
        <p> La carte a été réalisée avec la chaîne d'outils suivante:</p>
            <ul>
               <li>Import des données OSM dans une base de données PostGIS avec osm2pgsql:
                  <div class='pre'><pre>osm2pgsql -c -m -s -d osm -U &lt;user&gt; -W -H localhost &lt;osmfile&gt; -S osm2pgsql.style</pre></div>
                  &lt;osmfile&gt; est le fichier au format OSM (.osm, .osm.bz2 ou .pbf) qui contient les données OSM de la zone à couvrir. 
                  Il peut être créé avec osmosis à partir d'un extrait <a href="http://download.geofabrik.de/">geofabrik.</a>
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
        <p>Fichiers configuration et style: <a href="files/cartevelo.tgz">cartevelo.tgz</a>.
        Cet archive contient les fichiers suivants:</p>
        <ul>
           <li>osm2pgsql.style: Fichier style pour l'import des données OSM avec osm2pgsql.style</li>
           <li>postproc.sql: postproc.sql: fichier de commande sql pour le post-traitement de la base de données PostGis</li>
           <li>CarteVeloBase/*: Fichiers projet et style pour la carte de base. À copier dans le répertoire "project' de Tilemill</li>
           <li>CarteVeloChemins/*": Fichiers projet et style pour le calque "petites routes et chemins". À copier dans le répertoire "project' de Tilemill</li>
        </ul>
    </div>
  </div>
</body>
</html>
