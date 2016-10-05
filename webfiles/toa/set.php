<?php

//Turn off all error reporting
error_reporting(0);


   class MyDB extends SQLite3
   {
      function __construct()
      {
         $this->open('.data/wc.db');
      }
   }

$success = false;

while (($success != true) and ($tries < 3)){

   $db = new MyDB();

   if(!$db){
      //echo $db->lastErrorMsg();
   } else {
      //echo "Opened database successfully\n";
   }

  $status = isset($_GET['status']) ? strip_tags(trim($_GET['status'])):null;
  $bathroomID = isset($_GET['bathroomID']) ? strip_tags(trim($_GET['bathroomID'])):null;

  $time = date('Y-m-d H:i:s');

  if (($status != null) && ($bathroomID != null)) {

  $sql = "UPDATE data set status=".$status.", time='".$time."' where bathroomID=".$bathroomID;
    //echo $sql;
   $ret = $db->exec($sql);
   if(!$ret){
      //echo $db->lastErrorMsg();
   } else {
      echo $db->changes();
      $success = true;
   }

   }

   $db->close();

    $tries = $tries + 1;

} //end while
?>
