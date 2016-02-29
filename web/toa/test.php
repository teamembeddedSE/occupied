<?php
$objDateTime = new DateTime('NOW');
echo date('Y-m-d H:i:s');
//echo $objDateTime->format('c'); // ISO8601 formated datetime
//echo $objDateTime->format(DateTime::ISO8601); // Another way to get an ISO8601 formatted string
?>
