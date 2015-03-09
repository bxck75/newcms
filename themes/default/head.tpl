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

        <script src="./themes/default/javascript/spritely/src/jquery.spritely.js"></script>

        
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
<!--
<script type="text/javascript">
  $.ui.fancytree.debugLevel = 1; // silence debug output

  function logEvent(event, data, msg){
//        var args = $.isArray(args) ? args.join(", ") :
    msg = msg ? ": " + msg : "";
    $.ui.fancytree.info("Event('" + event.type + "', node=" + data.node + ")" + msg);
  }
  $(function(){
    $("#tree").fancytree({
      checkbox: true,
      // --- Tree events -------------------------------------------------
      blurTree: function(event, data) {
        logEvent(event, data);
      },
      

      create: function(event, data) {
        logEvent(event, data);
      },
      init: function(event, data, flag) {
        logEvent(event, data, "flag=" + flag);
      },
      focusTree: function(event, data) {
        logEvent(event, data);
      },
      restore: function(event, data) {
        logEvent(event, data);
      },
      // --- Node events -------------------------------------------------
      activate: function(event, data) {
        logEvent(event, data);
        var node = data.node;
        // Use <a> href and target attributes to load the content:
        if( node.data.href ){
          // Open target
          //window.open(node.data.href, node.data.target);
          // or open target in iframe
                $("[name=contentFrame]").attr("src", node.data.href);
        }
      },
      
      
//      activate: function(event, data) {
//        logEvent(event, data);
//        var node = data.node;
//        // acces node attributes
//        $("#echoActive").text(node.title);
//        if( !$.isEmptyObject(node.data) ){
//          alert("custom node data: " + JSON.stringify(node.data));
 //       }
 //     },
      beforeActivate: function(event, data) {
        logEvent(event, data, "current state=" + data.node.isActive());
        // return false to prevent default behavior (i.e. activation)
//              return false;
      },
      beforeExpand: function(event, data) {
        logEvent(event, data, "current state=" + data.node.isExpanded());
        // return false to prevent default behavior (i.e. expanding or collapsing)
//        return false;
      },
      beforeSelect: function(event, data) {
//        console.log("select", event.originalEvent);
        logEvent(event, data, "current state=" + data.node.isSelected());
        // return false to prevent default behavior (i.e. selecting or deselecting)
//        if( data.node.isFolder() ){
//          return false;
//        }
      },
      blur: function(event, data) {
        logEvent(event, data);
        $("#echoFocused").text("-");
      },
      click: function(event, data) {
        logEvent(event, data, ", targetType=" + data.targetType);
        // return false to prevent default behavior (i.e. activation, ...)
        //return false;
      },
      collapse: function(event, data) {
        logEvent(event, data);
      },
      createNode: function(event, data) {
        // Optionally tweak data.node.span or bind handlers here
        logEvent(event, data);
      },
      dblclick: function(event, data) {
        logEvent(event, data);
//        data.node.toggleSelect();
      },
      deactivate: function(event, data) {
        logEvent(event, data);
        $("#echoActive").text("-");
      },
      expand: function(event, data) {
        logEvent(event, data);
      },
      focus: function(event, data) {
        logEvent(event, data);
        $("#echoFocused").text(data.node.title);
      },
      keydown: function(event, data) {
        logEvent(event, data);
        switch( event.which ) {
        case 32: // [space]
          data.node.toggleSelected();
          return false;
        }
      },
      keypress: function(event, data) {
        // currently unused
        logEvent(event, data);
      },
      lazyLoad: function(event, data) {
        logEvent(event, data);
        // return children or any other node source
        //data.result = {url: "ajax-sub2.json"};
        data.result = [
          {title: "A Lazy node", lazy: true},
          {title: "Another node", selected: true}
          ];
      },
      loadChildren: function(event, data) {
        logEvent(event, data);
      },
      loadError: function(event, data) {
        logEvent(event, data);
      },
      postProcess: function(event, data) {
        logEvent(event, data);
        // either modify the ajax response directly
        data.response[0].title += " - hello from postProcess";
        // or setup and return a new response object
//        data.result = [{title: "set by postProcess"}];
      },
      removeNode: function(event, data) {
        // Optionally release resources
        logEvent(event, data);
      },
      renderNode: function(event, data) {
        // Optionally tweak data.node.span
//              $(data.node.span).text(">>" + data.node.title);
        logEvent(event, data);
      },
      renderTitle: function(event, data) {
        // NOTE: may be removed!
        // When defined, must return a HTML string for the node title
        logEvent(event, data);
//        return "new title";
      },
      select: function(event, data) {
        logEvent(event, data, "current state=" + data.node.isSelected());
        var s = data.tree.getSelectedNodes().join(", ");
        $("#echoSelected").text(s);
      }
    }).bind("fancytreeactivate", function(event, data){
      // alternative way to bind to 'activate' event
//        logEvent(event, data);
    }).on("mouseenter mouseleave", ".fancytree-title", function(event){
      // Add a hover handler to all node titles (using event delegation)
      var node = $.ui.fancytree.getNode(event);
      node.info(event.type);
    });

    $("#btnSelect").click(function(event){
      var node = $("#tree").fancytree("getActiveNode");
      node.setSelected( !node.isSelected() );
    });
    $("#btnRemove").click(function(event){
      var node = $("#tree").fancytree("getActiveNode");
      node.remove();
    });
  });
</script>
-->


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
                                        //window.open(node.data.href, (orgEvent.ctrlKey || orgEvent.metaKey) ? "_parent" : node.data.target);
                                        // or open target in iframe
                                        $("[name=contentFrame]").attr("src", node.data.href);
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
                    node.setExpanded(true);
                });

	});
</script>
<!--  <script type="text/javascript">
    $(function(){
      $("#tree1").fancytree({
        extensions: ["dnd"],
        dnd: {
          focusOnClick: true,
          dragStart: function(node, data) {
            return true;
          },
          dragEnter: function(node, data) {
            return true;
          },
          dragDrop: function(node, data) {
            data.otherNode.moveTo(node, data.hitMode);
          }
        },
        init: function(event, data){
          // Set RTL attribute on init
          $(this).find(".fancytree-container").attr("DIR", "RTL").addClass("fancytree-rtl");
        },
        keydown: function(event, data) {
          var KC = $.ui.keyCode,
            oe = event.originalEvent;

          // Swap LEFT/RIGHT keys
          switch( event.which ) {
          case KC.LEFT:
            oe.keyCode = KC.RIGHT;
            oe.which = KC.RIGHT;
            break;
          case KC.RIGHT:
            oe.keyCode = KC.LEFT;
            oe.which = KC.LEFT;
            break;
          }
        }
      });
    });
  </script>-->

            
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


        
    

