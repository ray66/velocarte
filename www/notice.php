<?
   ini_set ("display_errors", "");
   require 'functions.php';
   #phpinfo();
   initData();
?>
<!DOCTYPE html>



<html>
<head>
  <meta name="generator" content="Bluefish 2.2.3" >
  <meta charset="utf-8">

   <link href = "css/style.css" type = "text/css" rel = "stylesheet">
   <title>
<?php
   echo getMapName();
?>
	</title>
</head>

<body>
  <div id = "page">

   <div id="sidebar">
      <h2> <a href="index.php"><img title = "Carte des aménagements cyclables" alt = "Accueil" src="logo.png"></a> </h2>
      <div class="titre">
         Carte des aménagements cyclables de Perpignan
      </div>
      <br>
      <img title = "Légende" alt ="Légende" src = "img/legende.png"><br><br>
      <div class = "text">  
       <a id="contact" href="mailto:cvp66@sfr.fr" >Contact</a>
      </div>
   </div>
   <div class="content" >
        <h1>Notice de la carte</h1>
			<h4 class="sommaire"><a href="#InfoGen" >Informations générales</a></h4>
			<h4 class="sommaire"><a href="#Navig" >Naviguer dans la Carte</a></h4>
			<h4 class="sommaire"><a href="#Calques">Calques supplémentaires</a></h4>
			<h4 class="sommaire"><a href="#Contact">Comment signaler une erreur, faire une proposition, etc.?</a></h4>
			<h4 class="sommaire"><a href="#Licences">Conditions d'utilisations, licences, remerciements</a></h4>
			<h4 class="sommaire"><a href="#InfoTech">Informations techniques</a></h4>
        <h2 id="InfoGen">Informations générales</h2>
        <p>Cette carte a été créée grâce au projet <a href="http://www.openstreetmap.fr/" target="_blank">OpenStreetMap</a>. 
    		  OpenStreetMap (OSM) est un projet international fondé en 2004 dans le but de créer une carte libre du monde. 
    		  Des milliers de volontaires dans le monde entier collectent des données sur les routes, voies ferrées, les rivières, 
    		  les forêts, les bâtiments et bien plus encore. Les données cartographiques ainsi collectées sont ré-utilisables sous 
    		  licence libre ODbL. 
        </p>
        <p>Tous les éléments présent sur la carte sont dessinés à partir des données du projet OpenStreetMap. 
           Ce qui n'existe pas dans la base de données OSM ne peut donc pas être sur la carte. Mais toutes les données OpenStreetMap 
           ne sont pas présent sur la carte, comme c'est le cas pour certains équipements destinés aux automobilistes tel que les 
           parkings et stations-service. Par-contre, vous trouvez des éléments sur cette carte qui ne sont pas présent sur d'autres 
           cartes basés sur OSM, comme par exemple les parkings à vélo et les bandes cyclables.    
        </p>
        <p>Des informations techniques sur la réalisation de cette carte se trouvent <a href="#InfoTech" >ici</a>.</p> 
        <h2 id="Navig">Naviguer dans la Carte</h2>
        <dl>
          <dt>Zoom avant/arrière</dt>

          <dd>Vous pouvez zoomer avec la molette de votre souris,
          en cliquant sur les icônes 
          <img src="scripts/img/zoom-plus-mini.png" height="14" alt=""> et 
          <img src="scripts/img/zoom-minus-mini.png" height="14" alt="">
          dans le coin en haut à gauche ou en
          déplaçant la barrette glissante
          entre ces deux icônes.</dd>

          <dt>Déplacer la carte</dt>

          <dd>Faites simplement glisser la carte avec la souris en
          appuyant sur le bouton gauche.</dd>

<!--
         <dt>Zoom dans la zone détaillée</dt>

          <dd>Au centre de la carte, entouré d'un cadre
          rouge, se trouve une zone qui dispose de niveaux de zooms
          plus détaillées que le reste de la
          carte. Positionnez le curseur à
          l'intérieur du cadre pour accéder
          aux niveaux détaillés.</dd>
-->
          <dt>Créer des liens vers la carte</dt>

          <dd>Vous pouvez créer un lien à
          partir de la carte actuellement affichée en
          cliquant sur <b><i>Permalien</i></b> dans le coin en bas
          à droite. Ceci aura pour effet de
          rafraîchir l'adresse URL dans la barre
          d'adresse de votre navigateur internet, laquelle pourra
          ensuite être copiée dans vos emails
          ou commentaires de forums/blog, etc.</dd>
        </dl>
        <h2 id="Calques">Calques supplémentaires</h2>
        <p>L'onglet <img src="scripts/img/layer-switcher-maximize.png" height="14" alt=""> en haut à droite de la
        carte permet de changer de carte et de superposer la carte avec des calques
        supplémentaires
        </p>

        <h3>Calques "Routes" et "Chemins"</h3>

        <p>Ces calque met en valeur des routes mineures et des chemins agricoles et forestiers  
        qui se prêtent particulièrement pour une utilisation avec le vélo.
        </p>
        <div>
            <div class='legende_img'><img src="img/pr_unclassified.png" alt=""></div>
            <div class='legende_img_text'>Petite route de campagne </div>
        </div>
        <div>
            <div class='legende_img'><img src="img/pr_track1.png" alt=""></div>
            <div class='legende_img_text'>
                  Chemin rural, agricole ou forestier, avec un revêtement dur de type asphalte ou composée de matériaux
                  très compactés.
            </div>
        </div>
        <div>
            <div class='legende_img'><img src="img/pr_track2.png" alt=""></div>
            <div class='legende_img_text'>
                  Chemin rural, agricole ou forestier, avec une surface en gravier ou en terre/sable. 
            </div>
        </div>
        <div style='clear: both;'></div>
        <h3>Calque "Courbes de niveau"</h3>
        <p>Ce calque a été créé avec les données 
           <a href="http://fr.wikipedia.org/wiki/Shuttle_Radar_Topography_Mission" target="_blank">SRTM</a>
           du site <a href="http://www.viewfinderpanoramas.org/" target="_blank">viewfinderpanoramas.org</a>.
           Ce calque n'est pas disponible dans les niveaux de zoom détaillés. 
        </p>
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

        <h2 id="Licences">Conditions d'utilisations, licences, remerciements</h2>
        <h3>Licences</h3>
        <table>
           <tr valign="top">
				<td width="30%">Données de la carte "Vélo" et des calques "Routes" et "Chemins":</td>
				<td>© les contributeurs d’<a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a>, disponibles sous la licence ODbL </td>
			  </tr>
			  <tr valign="top">
				<td>Données SRTM:</td>
				<td><a href="http://www2.jpl.nasa.gov/srtm/" target="_blank">NASA SRTM</a> et <a href="http://www.viewfinderpanoramas.org/" target="_blank">viewfinderpanoramas.org</a></td>
			  </tr>
			</table>
        <h3>Conditions d'utilisation</h3>
        <p>Les tuiles de la carte vélo, du calque "OpenStreetMap Mapnik" et du calque "OpenCycleMap" sont disponibles sous la licence 
           <a href="http://creativecommons.org/licenses/by-sa/2.0/">Creative Commons paternité – partage à l’identique 2.0</a> (CC-BY-SA).
        </p>
        <h3>Remerciements</h3>
        <p>Cette carte a été inspiré des cartes des associations <a href="http://carte.apicy.fr/" target="_blank">APiCy</a>, 
           <a href="http://carte.velobesancon.info/" target="_blank">AVB</a> et 
           <a href="http://carte.lavilleavelo.org/" target="_blank">La Ville à Vélo</a>. 
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
                  <pre>osm2pgsql -c -m -s -d osm -U &lt;user&gt; -W -H localhost &lt;osmfile&gt; -S osm2pgsql.style</pre>
                  &lt;osmfile&gt; est le fichier au format OSM (.osm, .osm.bz2 ou .pbf) qui contient les données OSM de la zone à couvrir. 
                  Il peut être créé avec osmosis à partir d'un extrait <a href="http://download.geofabrik.de/">geofabrik.</a>
                  On peut aussi utiliser un extrait "région" ou "pays" et utiliser osm2pgsql avec l'option --bbox pour extraire une zone géographique. 
               </li>
               <li>Traitement de la base de données pour faciliter l'exploitation avec Tilemill/Mapnik:
                  <pre>psql -d osm -f postproc.sql</pre>
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
                			 <pre>tilemill export --format=mbtiles --files=&lt;répertoire tilemill&gt; --metatile=8 CarteVeloBase CarteVeloBase.mbtiles</pre>
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
