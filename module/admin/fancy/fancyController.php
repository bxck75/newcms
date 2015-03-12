<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of fancycontroller
 *
 * @author Boudewijnwerk
 */
class fancycontroller extends Controller{
    //put your code here
    public function vectorjs(){?>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>arbor.js » echolalia</title>
	<meta name="generator" content="TextMate http://macromates.com/">
	<meta name="author" content="Christian Swinehart">
	<!-- Date: 2010-12-15 -->
	<link rel="stylesheet" href="style/echolalia.css" type="text/css">
</head>
<body>
  <a class="back" href="/">back</a>
  <canvas id="viewport" width="800" height="600"></canvas>
  <a class="another" href="#">see another »</a>
  <div id="label"><span></span> <a target="_blank" href="http://samizdat.cc/projects/echolalia/final/">about...</a></div>

  <script src="./themes/default/javascript/arbor-v0.92/jquery-1.6.1.min.js"></script>
  <script src="./themes/default/javascript/arbor-v0.92/lib/arbor.js"></script>
  <script src="./themes/default/javascript/arbor-v0.92/demos/echolalia/echolalia.js"></script>

</body>
</html>
<?php
    }
}

?>
