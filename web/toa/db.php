<?php
   class MyDB extends SQLite3
   {
      function __construct()
      {
         $this->open('wc.db');
      }
   }
   $db = new MyDB();
   if(!$db){
      echo $db->lastErrorMsg();
   } else {
      //echo "Opened database successfully\n";
   }


   $sql = "SELECT * from data;";


   $ret = $db->query($sql);
   while($row = $ret->fetchArray(SQLITE3_ASSOC) ){
      echo "ID = ". $row['id'] . "\n";
      echo "bathroomID = ". $row['bathroomID'] ."\n";
      echo "time = ". $row['time'] ."\n";
      echo "status =  ".$row['status'] ."\n\n";
      echo "<br>";

   }
   //echo "Operation done successfully\n";
   $db->close();
?>
