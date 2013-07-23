<?php
$zoom = $_GET['z'];
$column = $_GET['x'];
$row1 = $_GET['y'];
$row = (1 << $zoom) - $row1 -1;
$db = $_GET['db'];
  try
  {
    // Open the database
    //echo $db;
    if($db == "CarteVeloBase.mbtiles"){
       if($zoom<11){
         $url = sprintf("http://otile1.mqcdn.com/tiles/1.0.0/map/%d/%d/%d.png",$zoom,$column,$row1);
         //echo $url;
         $data= file_get_contents($url);
         header("Content-Type: image/png");
         echo $data;
         return;       
       }else if($zoom<17){
          $db="CarteVeloBase_zoom_low.mbtiles";
       }else{
          $db="CarteVeloBase_zoom_high.mbtiles";
       }
    }
    //echo $db;
    //return;
    $conn = new PDO("sqlite:$db");

    // Query the tiles view and echo out the returned image
	$sql = "SELECT * FROM tiles WHERE zoom_level = $zoom AND tile_column = $column AND tile_row = $row";
	$q = $conn->prepare($sql);
	$q->execute();
	$q->bindColumn(1, $zoom_level);
	$q->bindColumn(2, $tile_column);
	$q->bindColumn(3, $tile_row);
	$q->bindColumn(4, $tile_data, PDO::PARAM_LOB);

	if($q->fetch())
	{
      $data=$tile_data;
	}else{
      $fh = fopen("img/empty.png", 'r');
      if ($fh) {
         $data= fread($fh, 99999);
         fclose($fh);
      }	
      //data = header("HTTP/1.0 404 Not Found");
      //echo "###";
   }
   header("Content-Type: image/png");
   echo $data;
  }
  catch(PDOException $e)
  {
    print 'Exception : '.$e->getMessage();
  }
?>