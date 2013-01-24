#!/usr/bin/perl 
use Math::Trig;
use File::Path;
use English;
#--------------------------------------------------------
# Löschen aller Tiles, die ausserhalb einer BBox liegen
#--------------------------------------------------------
sub help{
   print "Aufruf: $PROGRAM_NAME bbox-Datei tile-dir [min-zoom [max_zoom]]\n";
   print "     Löscht die Tiles im der angegebenen Zone ab Zoomlevel min_zoom\n";
   print "     und alle Tiles mit Zoomlevel größer max_zoom\n";
}

#--------------------------------------------------------
# Tile x/y to coordinates
#--------------------------------------------------------
sub Project {
  my ($X,$Y, $Zoom) = @_;
  my $Unit = 1 / (2 ** $Zoom);
  my $relY1 = $Y * $Unit;
  my $relY2 = $relY1 + $Unit;
 
  # note: $LimitY = ProjectF(degrees(atan(sinh(pi)))) = log(sinh(pi)+cosh(pi)) = pi
  # note: degrees(atan(sinh(pi))) = 85.051128..
  #my $LimitY = ProjectF(85.0511);
 
  # so stay simple and more accurate
  my $LimitY = pi;
  my $RangeY = 2 * $LimitY;
  $relY1 = $LimitY - $RangeY * $relY1;
  $relY2 = $LimitY - $RangeY * $relY2;
  my $Lat1 = ProjectMercToLat($relY1);
  my $Lat2 = ProjectMercToLat($relY2);
  $Unit = 360 / (2 ** $Zoom);
  my $Long1 = -180 + $X * $Unit;
  return ($Lat2, $Long1, $Lat1, $Long1 + $Unit); # S,W,N,E
}
sub ProjectMercToLat($){
  my $MercY = shift;
  return rad2deg(atan(sinh($MercY)));
}
sub ProjectF
{
  my $Lat = shift;
  $Lat = deg2rad($Lat);
  my $Y = log(tan($Lat) + sec($Lat));
  return $Y;
}

#-------------------------------------------------------
# coordinates to tile x/y 
#--------------------------------------------------------
sub getTileNumber {
  my ($lat,$lon,$zoom) = @_;
  my $xtile = int( ($lon+180)/360 * 2**$zoom ) ;
  my $ytile = int( (1 - log(tan(deg2rad($lat)) + sec(deg2rad($lat)))/pi)/2 * 2**$zoom ) ;
  return ($xtile, $ytile);
}

#-------------------------------------------------------
# Main
#
# Parameter:  <bbox-Datei> <tile-dir> [<zoom-min> [<zoom-may>]]
#-------------------------------------------------------

   if ($#ARGV < 1){
      help;
      exit;
   }
   my $c;
   open (INFILE, "<$ARGV[0]") or die ;
   while (my $line = <INFILE>){
      if (substr($line,0,1) != '#'){
         print $line;
         @c = split /,/, $line;
         if ($#c < 3){
            print "Fehlerhafte Bboxdatei\n";
            exit -1;
         }
         last;
      }
   }
   if ($#c < 3){
      print "Fehlerhafte oder keine Bboxdatei\n";
      exit -1;
   }   
   $lonMin = $c[0];
   $latMin = $c[1];
   $lonMax = $c[2];
   $latMax = $c[3];

   shift @ARGV;
   my $tiledir=$ARGV[0];

   $zoom_min = 16;
   $zoom_max = 17;
   shift @ARGV;
   if ($#ARGV >= 0){
      $zoom_min = $ARGV[0];
      shift @ARGV;
      if ($#ARGV >= 0){
         $zoom_max = $ARGV[0];
      }
   }
   printf "**** Lösche Tiles ausserhalb von (%f,%f,%f,%f) und Zoomlevel $zoom_min bis $zoom_max\n",$lonMin,$latMin,$lonMax,$latMax;
   printf "**** Lösche alle Tiles der Zoomlevel >= %d\n",$zoom_max+1; 
   opendir(DIR, $tiledir) || die "Ungültiges Tile-Verzeichnis $ARGV[2]";
   while (defined(my $zoom = readdir(DIR))) {
      next if($zoom =~ /^\./);
      if ( not (-d $tiledir."/".$zoom)) {
         print "***Not a directory***: $zoom\n";
         next;
      }
      #print "$zoom\n";
      if ($zoom > $zoom_max){
          rmtree ($tiledir."/".$zoom);
      }elsif ($zoom >= $zoom_min and $zoom <= $zoom_max){
         opendir(ZOOMDIR, $tiledir."/".$zoom) || die "cannot opendir $zoom";
         while (defined(my $x = readdir(ZOOMDIR))) {
            next if($x =~ /^\./);
            #print "\t$x\n";
            opendir(XDIR, $tiledir."/".$zoom."/".$x) || die "cannot opendir $x";
            while (defined(my $tilefile = readdir(XDIR))) {
               next if($tilefile =~ /^\./);
               #print "\t\t$tilefile\n";
               $tilefile_full = $tiledir."/".$zoom."/".$x."/".$tilefile;
               if (!-f $tilefile_full || !$tilefile =~ /png$/) {
                  print "***Keine PNG-Datei***: $tilefile_full\n";
                  next;
               }
               # Tile gefunden, prüfen ob in Bbox:
               $y = $tilefile;
               $y =~ s/.png$//;
               #print "$zoom/$x/$y\n";
               my ($latMin2, $lonMin2, $latMax2, $lonMax2) = Project($x, $y, $zoom);
               #printf "\t%2.5f %2.5f %2.5f %2.5f\n", $lonMin, $latMin, $lonMax, $latMax;
               #printf "\t%2.5f %2.5f %2.5f %2.5f\n", $lonMin2, $latMin2, $lonMax2, $latMax2;
               if (   $latMax2 < $latMin
                     or $latMin2 > $latMax
                     or $lonMax2 < $lonMin
                     or $lonMin2 > $lonMax){
                     # Tile liegt ausserhalb der BBox
                     #print "delete $tilefile_full\n";
                     unlink ($tilefile_full);
               }
            }
         }
      }
   }
   # Lösche leere Verzeichnisse
   opendir(DIR, $tiledir) || die "Ungültiges Tile-Verzeichnis $ARGV[2]";
   while (defined(my $zoom = readdir(DIR))) {
      next if($zoom =~ /^\./);
      if ( not (-d $tiledir."/".$zoom)) {
         print "***Not a directory***: $zoom\n";
         next;
      }
      #print "$zoom\n";
      if ($zoom > $zoom_max){
          rmtree ($tiledir."/".$zoom);
      }elsif ($zoom >= $zoom_min and $zoom <= $zoom_max){
         opendir(ZOOMDIR, $tiledir."/".$zoom) || die "cannot opendir $zoom";
         while (defined(my $x = readdir(ZOOMDIR))) {
            next if($x =~ /^\./);
            opendir(XDIR, $tiledir."/".$zoom."/".$x) || die "cannot opendir $x";
            $empty = 1;
            while (defined(my $tilefile = readdir(XDIR))) {
               next if($tilefile =~ /^\./);
               $empty = 0;
               last;
            }
            if ($empty){
               rmtree ($tiledir."/".$zoom."/".$x);
            }
         }
      }
   }