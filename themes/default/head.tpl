<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title><?php echo $this->title; ?></title>
	<link rel="stylesheet" href="./themes/default/style/stylesheet.css" />
	<link rel="stylesheet" href="./themes/default/style/custom.css">
        <?php 
		foreach($this->scripts as $script){
			echo $script;
		}
	?>
	<?php 
		foreach($this->styles as $style){
			echo $style;
		}
	?>
        
	<script src="./themes/default/javascript/jquery-ui-1.11.3.custom/external/jquery/jquery.js" type="text/javascript"></script>
	<script src="./themes/default/javascript/jquery-ui-1.11.3.custom/jquery-ui.min.js" type="text/javascript"></script>

	<link href="./themes/default/javascript/fancytree-master/src/skin-win8/ui.fancytree.css" rel="stylesheet" type="text/css">
	<script src="./themes/default/javascript/fancytree-master/src/jquery.fancytree.js" type="text/javascript"></script>

	<script src="./themes/default/javascript/fancytree-master/demo/sample.js" type="text/javascript"></script>

        <link rel='stylesheet' href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">


        <script src="./themes/default/javascript/lite-uploader-master/jquery.liteuploader.min.jsz"></script>        
        
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
       

<style type="text/css">

li#tree {
	position: absolute;
	height: 95%;
	width: 95%;
	padding: 5px;
	margin-right: 16px;
}
ul.fancytree-container {
	height: 100%;
	width: 100%;
	background-color: transparent;
}
span.fancytree-node span.fancytree-title {
	color: white;
	text-decoration: none;
}
span.fancytree-focused span.fancytree-title {
	outline-color: white;
}
span.fancytree-node:hover span.fancytree-title,
span.fancytree-active span.fancytree-title,
span.fancytree-active.fancytree-focused span.fancytree-title,
.fancytree-treefocus span.fancytree-title:hover,
.fancytree-treefocus span.fancytree-active span.fancytree-title {
	color: #39414A;
}
span.external span.fancytree-title:after {
	content: "";
	background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAMAAAC67D+PAAAAFVBMVEVmmcwzmcyZzP8AZswAZv////////9E6giVAAAAB3RSTlP///////8AGksDRgAAADhJREFUGFcly0ESAEAEA0Ei6/9P3sEcVB8kmrwFyni0bOeyyDpy9JTLEaOhQq7Ongf5FeMhHS/4AVnsAZubxDVmAAAAAElFTkSuQmCC") 100% 50% no-repeat;
	padding-right: 13px;
}
/* Remove system outline for focused container */
.ui-fancytree.fancytree-container:focus {
	outline: none;
}
.ui-fancytree.fancytree-container {
	border: none;
}
</style>



<script type="text/javascript">
$(function(){
		$("#tree").fancytree({
//			extensions: ["wide"],
			// canvas and video child nodes do not exist before the parent is
			// expanded, so we trigger rendering on demand
			expand: function(event, data) {
				var node = data.node;
				switch( node.key ) {
				case "videoParent1":
					var video = document.getElementById("video1");
					video.play();
					break;
				case "canvasParent1":
				setTimeout(drawCanvas, 1000);
					drawCanvas();
					break;
				}
			},
                        focus: function(event, data) {
			var node = data.node;
			// Auto-activate focused node after 1 second
			if(node.data.href){
				node.scheduleAction("activate", 1000);
			}
                        },
                        blur: function(event, data) {
                                data.node.scheduleAction("cancel");
                        },
                        activate: function(event, data){
                                var node = data.node,
                                        orgEvent = data.originalEvent || {};

                                if(node.data.href){
                                        window.open(node.data.href, (orgEvent.ctrlKey || orgEvent.metaKey) ? "_parent" : node.data.target);
                                        // or open target in iframe
                                        //$("[name=contentFrame]").attr("src", node.data.href);
                                }
                                if( window.parent &&  parent.history && parent.history.pushState ) {
                                        // Add #HREF to URL without actually loading content
                                        parent.history.pushState({title: node.title}, "", "#" + (node.data.href || ""));
                                }
                        },
                        click: function(event, data){ // allow re-loads
                                var node = data.node,
                                        orgEvent = data.originalEvent;

                                if(node.isActive() && node.data.href){
                                        // data.tree.reactivate();
                                        window.open(node.data.href, (orgEvent.ctrlKey || orgEvent.metaKey) ? "_parent" : node.data.target);
                                }
                        }
		});
		// Fancytree renders nodes 'lazily', i.e. when they are first expanded.
		// So we to use live event binding for embedded elements.
		$("#tree").on("click", "#btn1", function(){
			alert("Thank you for clicking.");
			return false;
		});
                $("#tree").fancytree("getRootNode").visit(function(node){
                    node.setExpanded(false);
                });

	});
</script>

<script>
function getopacity(elem) {
  var ori = $(elem).css('opacity');
  var ori2 = $(elem).css('filter');
  if (ori2) {
    ori2 = parseInt( ori2.replace(')','').replace('alpha(opacity=','') ) / 100;
    if (!isNaN(ori2) && ori2 != '') {
      ori = ori2;
    }
  }
  return ori;
}
</script>

                        
</head>


        
    

