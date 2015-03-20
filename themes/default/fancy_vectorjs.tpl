

<style>
.node {
    fill: #ccc;
    stroke: #ccc;
    stroke-width: 2px;
}

.link {
    stroke: #777;
    stroke-width: 1px;
}

</style>

<script src="http://d3js.org/d3.v3.min.js"></script>
<!--<script src="./themes/default/bl.ock.forcecluster.js"></script>
<script src="./themes/default/bl.ock.csvnodes.js"></script>
<script src="./themes/default/bl.ock.colforce.js"></script>
<script src="./themes/default/bl.ock.colforce.js"></script>-->
<script type="text/javascript" src="./themes/default/javascript/CodeFlower/javascripts/d3/d3.js"></script>
<script type="text/javascript" src="./themes/default/javascript/CodeFlower/javascripts/d3/d3.geom.js"></script>
<script type="text/javascript" src="./themes/default/javascript/CodeFlower/javascripts/d3/d3.layout.js"></script>
<script type="text/javascript" src="./themes/default/javascript/CodeFlower/javascripts/CodeFlower.js"></script>
<script type="text/javascript" src="./themes/default/javascript/CodeFlower/javascripts/dataConverter.js"></script>
<script type="text/javascript">
  var currentCodeFlower;
  var createCodeFlower = function(json) {
    var total = countElements(json);
    w = parseInt(Math.sqrt(total) * 40, 10);
    h = parseInt(Math.sqrt(total) * 50, 10);
    console.log(json);
    // create a new CodeFlower
    currentCodeFlower = new CodeFlower("#wrapper", w, h).update(json);
  };
    //d3.json('./themes/default/javascript/CodeFlower/data/wordpress.json', createCodeFlower);
    d3.json('./themes/default/data/newcms.json', createCodeFlower);
</script>
<!--<script src="./themes/default/bl.ock.algo.js"></script>-->
     
