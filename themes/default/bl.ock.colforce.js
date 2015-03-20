var json_str = '{"nodes":[{"name":"boudewijn","group":1},{"name":"boudewijn","group":1},{"name":"boudewijn","group":1},{"name":"boudewijn","group":0}],"links":[{"source":1,"target":0,"value":1},{"source":1,"target":0,"value":1},{"source":1,"target":0,"value":1}]}';



var    w = 955,
       h = 755,
       r = 4,
    fill = d3.scale.category20();
    
var json = eval( '(' + json_str + ')');

var vis = d3.select("#wrapper").append("svg:svg")
         .attr("width", w)
         .attr("height", h);

var force = d3.layout.force()
         .charge(-250)
         .gravity(.50)
         .linkDistance(25)
         .linkStrength(.2)
         .friction(.8)
         .nodes(json.nodes)
         .links(json.links)
         .size([w, h])
         .start();

var link = vis.selectAll("line.link")
         .data(json.links)
 .enter().append("svg:line")
         .attr("class", "link")
         .style("stroke-width", function(d) { return Math.sqrt(d.value); })
         .attr("x1", function(d) { return d.source.x; })
         .attr("y1", function(d) { return d.source.y; })
         .attr("x2", function(d) { return d.target.x; })
         .attr("y2", function(d) { return d.target.y; });

var node = vis.selectAll("g.node")
         .data(json.nodes)
 .enter().append("svg:a")
         .attr("class", "node") 
         .attr("xlink:href",function(d) { return d.URI;})
         .call(force.drag);

node.append("svg:circle")
         .attr("r", function(d) { return (d.company.length*2)+r; })            
         .style("fill","white");

node.append("svg:title")
         .text(function(d) { return (d.name+": "+d.company.toString().replace(new RegExp(",","g"),", ")); });
         //.text(function(d) { return (d.name;)); });

node.append("svg:text")
.attr("class", "nodetext")
.attr("dx", 12)
.attr("dy", ".35em")
//.text(function(d) { return d.company.length>1?d.name:"" });

var donut = d3.layout.pie(),
arc = d3.svg.arc().innerRadius(0).outerRadius(function(d) {
         value =  (this.parentNode.parentNode.__data__.company.length*2)+r;
         return value;
});

var arcs = node.selectAll("g.arc")
                .data(function(d, i) {
                                var c=0; var groups = [];
                                for(c=0; c<d.group.length; c++) {
                                        groups.push(1.0/d.group.length);
                                }
                                return donut(groups);
                })
                .enter().append("svg:g")
                .attr("class", "arc");

arcs.append("svg:path")
         .attr("fill", function(d, i) { return fill(this.parentNode.parentNode.__data__.group[i]); })
         .attr("d", arc);


force.on("tick", function() {   
 node.attr("cx", function(d) { return d.x = Math.max(((d.company.length*2)+r)*2, Math.min(w - (d.company.length*2)+r, d.x)); })
                 .attr("cy", function(d) { return d.y = Math.max(((d.company.length*2)+r)*2, Math.min(h - 2*((d.company.length*2)+r), d.y)); });
 link.attr("x1", function(d) { return d.source.x; })
                 .attr("y1", function(d) { return d.source.y; })
                 .attr("x2", function(d) { return d.target.x; })
                 .attr("y2", function(d) { return d.target.y; });

 node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });            
 arcs.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; }); 
});
force.start();


