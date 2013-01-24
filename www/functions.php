<?
function lon2x($lon) { return deg2rad($lon * 6378137.0); }
function lat2y($lat) { return log(tan(M_PI_4 + deg2rad($lat) / 2.0)) * 6378137.0; }
function x2lon($x) { return rad2deg($x / 6378137.0); }
function y2lat($y) { return rad2deg(2.0 * atan(exp($y / 6378137.0)) - M_PI_2); }
#---------------------------------------------------------
# initData
#---------------------------------------------------------
function initData(){
   global $strassen,
          $pois,
          $bBox,
          $bBoxDetail,
          $mapName;
          /*
   $fh = fopen("streets.txt", 'r');
   $id = 1;
   if ($fh) {
       while (($buffer = fgets($fh, 4096)) !== false) {
           $buffer = rtrim($buffer, "\a\n\r");
           list ($name, $lat, $lon) = split ("\|", $buffer);
           $strassen[] = array("name"=>$name, "lat"=>$lat, "lon"=>$lon, "id"=>$id);
           $id++;
           //echo $name." ".$lat." ".$lon."<br>\n";
       }
       fclose($fh);
   }
   $fh = fopen("pois.txt", 'r');
   $id = 1;
   if ($fh) {
       while (($buffer = fgets($fh, 4096)) !== false) {
           $buffer = rtrim($buffer, "\a\n\r");
           list ($group, $cat, $type, $name, $lat, $lon) = split ("\|", $buffer);
           $pois[] = array("group"=>$group, "name"=>$name, "lat"=>$lat, "lon"=>$lon, "type"=>$type, "id"=>$id);
           $id++;
           //echo $name." ".$lat." ".$lon."<br>\n";
       }
       fclose($fh);
   }
*/
   $fh = fopen("config.txt", 'r');
   if ($fh) {
       if (($buffer = fgets($fh, 4096)) !== false) {
           $buffer = rtrim($buffer, "\a\n\r");
           list ($mapName, $lon1, $lat1, $lon2, $lat2, $lon3, $lat3, $lon4, $lat4) = split (",", $buffer);
           $bBox = "$lon1,$lat1,$lon2,$lat2";
           $bBoxDetail = "$lon3,$lat3,$lon4,$lat4";
       }
       fclose($fh);
   }
}
#---------------------------------------------------------
# get writePoiFile
#---------------------------------------------------------
function writePoiFile($poiId, $poiCat){
   global $pois;

   $filename = $poiCat.".txt";
   if (file_exists($filename)){
      $stat = stat($filename);
      if ($stat){
         $diff = time()-$stat['mtime'];
         #echo 'Diff:      ' . $diff."<br/>";
         if ($diff < 24*3600){
            return;
         }
      }
   }
   $fh = fopen($filename, 'w');
   fputs($fh, "lat\tlon\ttitle\tdescription\ticon\ticonSize\ticonOffset\tid");
   foreach ($pois as $poi){
      if ($poi["id"] == $poiId or $poi["group"] == $poiCat){
         $iconfile = "icons/".$poi["type"].".png";
         if (file_exists($iconfile)){
            $icon = $iconfile;
         }else{
            #$icon = "http://www.openlayers.org/dev/img/marker.png";
            #echo $poi["type"]."<br/>";
            $icon = "icons/default.png";
         }
         //fputs($fh, "\n".$poi["lat"]."\t".$poi["lon"]."\t".$poi["name"]."\t".$poi["type"]."\thttp://www.openlayers.org/dev/img/marker.png\t21,25\t-10,-25");
         fputs($fh, "\n".lat2y($poi["lat"])."\t".lon2x($poi["lon"])."\t".$poi["name"]."\t".$poi["type"]."\t".$icon."\t21,25\t-10,-25\t".$poi["id"]);
      }
   }
   fputs($fh, "\n");
   fflush ($fh);
   fclose($fh);
}   
#---------------------------------------------------------
# get Bbox
#---------------------------------------------------------
function getBbox(){
   global $bBox;
   return $bBox;
}
function getBboxDetail(){
   global $bBoxDetail;
   return $bBoxDetail;
}
#---------------------------------------------------------
# getName
#---------------------------------------------------------
function getMapName(){
   global $mapName;
   return $mapName;
}
#---------------------------------------------------------
# searchStreet
#---------------------------------------------------------
function searchStreet($searchstring){
  global $strassen,
         $pois;
  $searchstring1 = strtr($searchstring, array("à"=>"a","á"=>"a","â"=>"a",
                                                "é"=>"e","è"=>"e","ê"=>"e",
                                                "ô"=>"o",
                                                "ú"=>"u","ù"=>"u",
                                                "ç"=>"c"));
   $s = $searchstring1;
   //echo htmlspecialchars($s);
   $lev_min = 9999;
   $i = 1;
   foreach ($strassen as $strasse){
      $strasseName = strtr($strasse["name"], array("à"=>"a","á"=>"a","â"=>"a",
                                                   "é"=>"e","è"=>"e","ê"=>"e",
                                                   "ô"=>"o",
                                                   "ú"=>"u","ù"=>"u",
                                                   "ç"=>"c"));
      $n = $strasseName;
      $lev = levenshtein($s, $n);
      //echo $lev." ".$s." ".$n."<br>";
      if (strncmp($n, "Rue ", 4) == 0){
         $n = substr($n, 4);
      }elseif (strncmp($n, "Place ", 6) == 0){
         $n = substr($n, 6);
      }elseif (strncmp($n, "Impasse ", 8) == 0){
         $n = substr($n, 8);
      }            
      if (strncmp($n, "de la ", 6) == 0){
         $n = substr($n, 6);
      }elseif (strncmp($n, "de l'", 5) == 0){
         $n = substr($n, 5);
      }elseif (strncmp($n, "du ", 3) == 0){
         $n = substr($n, 3);
      }elseif (strncmp($n, "des ", 4) == 0){
         $n = substr($n, 4);
      }
      if (strncmp($s, "Rue ", 4) == 0){
         $s = substr($s, 4);
      }elseif (strncmp($s, "Place ", 6) == 0){
         $s = substr($s, 6);
      }elseif (strncmp($s, "Impasse ", 8) == 0){
         $s = substr($s, 8);
      }            
      if (strncmp($s, "de la ", 6) == 0){
         $s = substr($s, 6);
      }elseif (strncmp($s, "de l'", 5) == 0){
         $s = substr($s, 5);
      }elseif (strncmp($s, "du ", 3) == 0){
         $s = substr($s, 3);
      }elseif (strncmp($s, "des ", 4) == 0){
         $s = substr($s, 4);
      }
      $lev1 = levenshtein($s, $n);
      if ($lev1 < $lev){
         $lev = $lev1;
      }
      if (strlen($n) > strlen($s)){
         $n = substr($n, strlen($n)-strlen($s));
         $lev1 = levenshtein($s, $n);
         if ($lev1 < $lev){
            $lev = $lev1;
         }
      }
      if ($lev < 6){
         $a_name[] = $strasse["name"];
         $a_lev[] = $lev;
         $a_id[] = $i;
         //echo $i." ".$lev."-".$strasse["name"]."<br>";
      }
      if ($lev < $lev_min){
         $lev_min = $lev;
      }
      if ($lev_min > 1){
         $s = $searchstring1;
         $n = $strasseName;
         //echo $n."|".$s."|".stristr($n, $s)."<br>" ;
         if(! stristr($n, $s) === false) {
            $a_name[] = $strasse["name"];
            $a_lev[] = 1;
         }
      }
      $i++;
   }
   return array ($a_name, $a_lev, $a_id);
}
