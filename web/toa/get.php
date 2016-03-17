<?php

// Turn off all error reporting
error_reporting(0);


   class MyDB extends SQLite3
   {
      function __construct()
      {
         $this->open('.data/wc.db');
      }
   }
   $db = new MyDB();
   if(!$db){
      //echo $db->lastErrorMsg();
   } else {
      //echo "Opened database successfully\n";
   }

   $sql = "SELECT * from data;";

   $ret = $db->query($sql);
   while($row = $ret->fetchArray(SQLITE3_ASSOC) ){
      switch ($row['status']) {
        case 0:
            echo "sign_green|Ledig|";
        break;
        case 1:
            echo "sign_red|Upptagen|";
        break;
        case 2:
            echo "sign_orange|Troligen ledig|";
        default:
            echo "";
        break;
        }

   }

   //echo "Operation done successfully\n";
   $db->close();
?>