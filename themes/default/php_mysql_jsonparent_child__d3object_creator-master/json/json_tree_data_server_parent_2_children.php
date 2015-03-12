<?php
// this program will create a json data structure for D3 tree rendering. I provides for a parent and two children depth
require_once('db-config_system_audit.php');

$tablename = "category";
$parent_level = '1';
$child_level1 = '2';
$child_level2 = '3';

$counterid = 10000;
$jsonchild_level1 =array();

$json =array();



$con = mysql_connect(DBHOST, DBUSER, DBPASS) or die('Could not connect to database server.');
mysql_select_db(DBNAME) or die('Could not select database.');

//*******************build child level 1************************************************************
// build query to get all distinct data centers
// for each data center create a child node


$query_child_level1 = "SELECT distinct $parent_level FROM {$tablename} where environment like '%dfw%'  order by $parent_level  ";
$result_child_level1 = mysql_query($query_child_level1) or die(mysql_error());

//var_dump($result_child_level1);


while ($row_child_level1 = mysql_fetch_array($result_child_level1)) {
// for each ip address, child level 2 finds unique key names groups
    $parent_values = $row_child_level1[$parent_level ];
    $query_child_level2 = "SELECT distinct {$child_level1} FROM {$tablename} where {$parent_level} like ('%{$parent_values}%') AND $child_level1  like '%Run%' ";
    $result_child_level2 = mysql_query($query_child_level2) or die(mysql_error());
    // loop through distinct server groups for that data center and add as child level 2
    //var_dump($result_child_level2);
    $jsonchild_level2 =array(); // clear array
    while ($row_of_child_level2 = mysql_fetch_array($result_child_level2)) {
        // loop through each server group and find distinct ips
        $child1_values = $row_of_child_level2[$child_level1];
        $query_child_level3 = "SELECT distinct {$child_level2}  FROM {$tablename} where $child_level1 like ('%{$child1_values}%') and $parent_level  like ('%{$parent_values}%')   ";
        $result_child_level3 = mysql_query($query_child_level3) or die(mysql_error());
        // loop through distinct server groups for that data center and add as child level 3
        $jsonchild_level3 =array(); // clear array
         //var_dump($result_child_level3);
        while ($row_of_child_level3 = mysql_fetch_array($result_child_level3)) {
           $counterid++;
           $child_level3_group_array = array(
           'id' => $counterid,
           'name' => $row_of_child_level3[$child_level2]
        );
        array_push($jsonchild_level3, $child_level3_group_array); // add array of tests as $jsonchild
        }
        //var_dump($jsonchild_level3);
         //**********************************
        $counterid++;
        $child_level2_group_array = array(
            'name' => $child1_values,
            'children'=> $jsonchild_level3

        );
        array_push($jsonchild_level2, $child_level2_group_array); // add array of tests as $jsonchild
    }
    //var_dump($jsonchild_level2);

    $counterid++;
    $parent_values_array = array(
        'name' => $row_child_level1[$parent_level],
        'children' => $jsonchild_level2
    );
    array_push($jsonchild_level1, $parent_values_array); // add array of tests as $jsonchild
}
$counterid++;
$parentarray = array(
    'name' => "Chef Nodes",
    "children" => $jsonchild_level1
);
array_push($json, $parentarray);
echo json_encode($parentarray);




mysql_close($con);
?>