{
   if(i==0){
      if($1=="\"extent\":" && $2=="["){
         i=1
      }else if($1!="\"extent\":"){
         print $0     
      }
   }else if(substr($1,0,1)=="]"){
      i=0
   }
}