(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();


var margin = {top:10, left: 30, right: 30, bottom: 30};
var w = 960 - margin.left - margin.right; 
var h = 700 - margin.top - margin.bottom;

var svg = d3.select("#wrapper")
	.select(".svgcontainer")
	.append("svg")
	.attr("width", w + margin.left + margin.right)
	.attr("height", h + margin.top + margin.bottom)
	.append("g")
	// .style("background-color", "black")
	.attr("fill", "black")
	.attr("transform", "translate(" + margin.left + ", " + margin.top + ")");// will only need to use width and height directily, since it has been transformed

var x = d3.scale.linear()
	.range([0, w]);

var y = d3.scale.linear()
	.range([h, 0]); //since the height 0 is top    

	// {
	// 	objA:{
	// 		count:1, 
	// 		relat:{objB: 3, objC: 2, objD: 1}
	// 	},
	// 	objD:{
	// 		count:2,
	// 		relat:{}
	// 	}
	// }

var parseTagSpace = function(string){
	// return string.split(".").join("dot").split(" ").join("_");
	return string.split(".").join("").split(" ").join("").toLowerCase();
}


var containsObj = function(a, obj){
	for(var i = 0; i < a.length; i++){
		if(a[i] === obj){
			return true;
		}
	}
	return false;
}



d3.json("./themes/default/data/dataconselation.json", function(error, jsonData){
	 console.log(jsonData);


	var graph = {};
	graph.nodes = [];
	graph.links = [];
	//conver json to an array base

	//assign index
	var ind = 0;
	for(var key in jsonData){
		if(jsonData.hasOwnProperty(key)){ // avoid logging inherited properies
			jsonData[key]["index"] = ind;
			jsonData[key]["status"] = [0, 0, 0]; // [0] related; [1] over; [2] down
			jsonData[key]["color"] = d3.rgb("#2B1B17").brighter(Math.pow(jsonData[key]["count"], 0.4) )
			ind++;

			var r = {name: key, count: jsonData[key]["count"]};
			graph.nodes.push(r);			
		}
	}

	for(var key in jsonData){
		for(var link in jsonData[key]["relat"]){
			var r = {
				source: jsonData[key]["index"], 
				target: jsonData[link]["index"],
				strength: jsonData[key]["relat"][link]
			};
			graph.links.push(r);
		}
	}

	// A = jsonData;
	// console.log(graph);

	var alphaScale = d3.scale.pow().exponent(0.5).domain(d3.extent(graph.links, function(d){ return d.strength;})).range([0.05, 0.7]);

	// 2 down; 1 over; 0 related; -1 nothing
	var getStatus = function(_key){
		// console.log(jsonData[_key]["status"]);		
		for(var i = 2; i >= 0; i--){
			if(jsonData[_key]["status"][i]){
				return i;
			}
		}
		return -1;
	}

// drawing	

	var color = d3.scale.category20();
	var force = d3.layout.force()
		.charge(-80)
		// .linkDistance(100)
		.linkDistance(200)
		.size([w, h]);

	var dragstart = function(d){
		d.fixed = true;
		d3.select(this).classed("fixed", true);
	}

	var drag = force.drag()
    	.on("dragstart", dragstart);

	force.nodes(graph.nodes)
		.links(graph.links)
		.start();

	var link = svg.selectAll(".link")
		.data(graph.links)
		.enter()
		// .append("line")
		.append("svg:path")
		.attr("class", function(d){
			return "l" + parseTagSpace(d.target.name) + 
				" " + 
				//"l" + parseTagSpace(d.source.name) +  
				" link";
		})
		.style("stroke-width", function(d){
			return 1.5;
			// return Math.max(1, Math.sqrt(d.strength));
		})
		.style("stroke", "rgb(218, 211, 211)")
			// return d3.rgb("rgba(218, 211, 211, " + (0.14 + Math.pow(d.strength, 0.1)) + ")");
		.style("opacity", function(d){
			// return 0.14 + Math.pow(d.strength, 0.1);
			return alphaScale(d.strength);
		})
		// stroke: rgba(218, 211, 211, 0.14);

	var node = svg.selectAll(".node")
		.data(graph.nodes)
		.enter().append("circle")
		.attr("class", "node")
		.attr("r", function(d){ return Math.sqrt(d.count); })
		.style("fill", "orange")
		.call(drag);


	force.on("tick", function(){
		link.attr("d", function(d){
			var dx = d.target.x - d.source.x;
			var dy = d.target.y - d.source.y;
			var dr = Math.sqrt(dx * dx + dy * dy);

			return "M" + 
			d.source.x + "," + 
			d.source.y + "A" +
			dr + "," + dr + " 0 0,1 " + 
			d.target.x + "," + 
			d.target.y;
		})

		node.attr("cx", function(d){ return d.x; })
			.attr("cy", function(d){ return d.y; });

		description
			.attr("x", function(d){ return d.x + 10; })
			.attr("y", function(d){ return d.y + 5; } );
	})

	var text = svg.append("svg:g")
		.selectAll("g")
		.data(graph.nodes)
		.enter().append("svg:g");

	// text.append("svg:text")
	// 	.attr("x", 8)
	// 	.attr("y", ".31em")
	// 	.attr("class", "shadow")
	// 	.attr("font-size", function(d){ 
	// 		// return 12;
	// 		return 6 + Math.floor(d.count / 4);
	// 	})
	// 	.text(function(d){ return d.name; });

	// var selectedTag = [];
	// var relatedTag = [];	

	var infocus = 0; // 0 is normal mode, > 0 is focus mode
	var refresh = function(){
		// console.log(infocus);
		if(infocus){
			d3.selectAll(".tags")
				.attr("display", function(d){
					// console.log(d.name + getStatus(d.name));
					if(getStatus(d.name)>= 0){
						return "inline";
					}
					else{
						return "none";
					}					
				});

			d3.selectAll(".tags")
				.transition()
				.attr("fill", function(d){
					if(getStatus(d.name) >= 1){

						d3.selectAll(".l" + parseTagSpace(d.name))
							.transition()
							.style("display", "inline");

						return "white";
					}
					else{

						d3.selectAll(".l" + parseTagSpace(d.name))
							.transition()
							.style("display", "none");

						return d3.rgb(jsonData[d.name]["color"]).brighter();
					}
				});
		}
		else{
			d3.selectAll(".tags")
				.attr("display", "inline");

			d3.selectAll(".tags")

				// .transition() //shut down flashy animation
				.attr("fill", function(d){
					if(getStatus(d.name) >= 1){

						d3.selectAll(".l" + parseTagSpace(d.name))
							.transition()
							.style("display", "inline");

						return "white";
					}
					else{

						d3.selectAll(".l" + parseTagSpace(d.name))
							.transition()
							.style("display", "none");

						return jsonData[d.name]["color"];
					}
				});
		}


	}

	var mouseOver = function(d){
		// console.log(d.name);
		jsonData[d.name]["status"][1]++;
		for(var related in jsonData[d.name]["relat"]){
			// if already value; then do nothing;
			jsonData[related]["status"][0]++;
		}
		infocus++;
		refresh();
	}

	var mouseOut = function(d){

		// console.log(jsonData[d.name]["status"]);
		jsonData[d.name]["status"][1]--;
		for(var related in jsonData[d.name]["relat"]){
			jsonData[related]["status"][0]--;
		}
		infocus--;				
		refresh();
	}
	var mouseDown = function(d){
		if(jsonData[d.name]["status"][2]){
			jsonData[d.name]["status"][2] = 0;
			for(var itm in jsonData[d.name]["relat"]){
				jsonData[itm]["status"][0]--;	
			}
			infocus--;
		}
		else{
			jsonData[d.name]["status"][2] = 1;
			for(var itm in jsonData[d.name]["relat"]){
				jsonData[itm]["status"][0]++;	
			}
			infocus++;
		}
		refresh();
	}

	var description = text.append("svg:text")
		// .attr("x", 8)
		// .attr("y", ".31em")
		.attr("class", function(d){
			// console.log(d.name);
			return "n" + parseTagSpace(d.name) + " tags";
		})
		.attr("font-size", function(d){ 
			return 14;
			// return 6 + Math.floor(d.count / 4);
		})
		.attr("fill", function(d){
				return jsonData[d.name]["color"];
		})
		.text(function(d){ return d.name; })
		.on("mouseover", mouseOver)
		.on("mouseout", mouseOut)
		.on("mousedown", mouseDown)
		.call(drag)
		.style("cursor", "pointer");


	if (annyang) {
		var commands = {
			'*text':function(_input){
				console.log(_input);
				// console.log(d3.select(".n" + parseTagSpace(_input)));

				// console.log($(".n" + parseTagSpace(_input)));
				// $(".n" + parseTagSpace(_input)).trigger("mouseover");

				d3.select(".n" + parseTagSpace(_input))
					.each(mouseDown);
					// .call(mouseOver);
				// mouseOver(d3.select(".n" + parseTagSpace(_input)));
			}

		};
		annyang.init(commands);
		annyang.start();
	}

})


