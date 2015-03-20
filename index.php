<?php 

if(isset($_GET['debug'])){
    error_reporting(1);
    //set_error_handler('error_handler');
}else{
    error_reporting(0);
    //set_error_handler('error_handler');
}
require_once('./config.php');

// AS 2015-02-07
// Index herschreven zodat men op de homepagina komt bij geen of een ongeldige route.

// Defaults
$module = 'category';
$action = 'index';

// If route is set, update $module and $action.
if(isset($_GET['route']) && $_GET['route'] != ''){
	//correcte class instantiëren
	$route = explode('/', $_GET['route']);

	if(isset($route[0])){
		$module = $route[0];
	}

	if(isset($route[1])){
		$action = $route[1];
	}else{
		$action = 'index';
	}

	//controleren of het bestand bestaat en indien wel, includen

        //echo './module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php';
	if(!file_exists('./module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php')){
		$module = 'category';
	}
        // Startup
        require_once('./system/startup.php');	

        // Get the required controller
        $controllerName = $module.'Controller';
        //echo './module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php';
        require_once('./module/'.STANDARD_BACKEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php');

}else{
    $module = "fancy";
    
    // Startup
    require_once('./system/startup.php');	

    // Get the required controller
    $controllerName = $module.'Controller';
    //echo './module/'.STANDARD_FRONTEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php';
    require_once('./module/'.STANDARD_FRONTEND_MODULE_FOLDER.'/'.$module.'/'.$module.'Controller.php');
}



$obj = new $controllerName();

// Check if action's method exists or default back to index
if (!method_exists($obj, $action)) {	$action = 'index'; }

$obj->$action();

function error_handler($errno, $errstr, $errfile, $errline){
	//hier gaan we loggen
	$fh = fopen('./system/logs/error.txt', 'a+');
	
 	fwrite($fh, date('Y-m-d H:i:s').' PHP ' . $errno . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline."\n");
 	
 	echo '[[error]] ';
}
