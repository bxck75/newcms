(function() {
	var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();


var margin = {top:10, left: 100, right: 30, bottom: 30};
var w = 1000 - margin.left - margin.right; 
var h = 2000 - margin.top - margin.bottom;

var svg = d3.select("#wrapper")
	.append("svg")
	.attr("width", w + margin.left + margin.right)
	.attr("height", h + margin.top + margin.bottom)
	.append("g")
	.attr("transform", "translate(" + margin.left + ", " + margin.top + ")");// will only need to use width and height directily, since it has been transformed

var x = d3.scale.linear()
	.range([0, w]);

var y = d3.scale.linear()
	.range([h, 0]); //since the height 0 is top    

// Your beautiful D3 code will go here


//d3.tsv("colorname_ch.tsv", function(err, tsvData){
d3.tsv("./themes/default/data/colorname.tsv", function(err, tsvData){
	// console.log(tsvData);

	var colorObj = {};
	var colorName = [];
	var repeated;


	// console.log(colorObj);
	tsvData.forEach(function(d,i){
		// console.log(d);
		// var typeBool = 0;
// /\s+/g
		d["name"] = d["name"].replace(/\(+/g, ""); //strange that (Golden didn't get replaced)
		d["name"] = d["name"].replace(/\)+/g, "");
		d["name"] = d["name"].replace(/'+/g, "");
		d["name"] = d["name"].replace(/\/+/g, "");
		d["name"] = d["name"].replace(/\-+/g, " ");
		d["name"] = d["name"].toLowerCase();


		var split = d["name"];
		// var split = d["name"].split(" ");

		var usedcolor = {};

		
		// repeated = d[name];

		for(var c = 0; c < split.length; c++){
			(colorObj[split[c]])?  null : colorObj[split[c]] = [];
			if(!usedcolor[split[c]]){
				colorObj[split[c]].push(d);	
				usedcolor[split[c]] = 0;
			}			
		}



		// for(var c = 0; c < split.length; c++){
		// 	(colorObj[split[c]])?  null : colorObj[split[c]] = [];
		// 	if(!usedcolor[split[c]]){
		// 		colorObj[split[c]].push(d);	
		// 		usedcolor[split[c]] = 0;
		// 	}			
		// }
	});

	console.log(JSON.stringify(colorObj));
	console.log(colorObj);

	for(var attr in colorObj){
		(colorObj[attr]["length"] === 1)? delete colorObj[attr] : null;
	}
	delete colorObj["色"];

	var colorArray = d3.entries(colorObj);
	colorArray.sort(function(a, b){ 
		return b.value.length - a.value.length;
	});
	console.log(colorArray);
	
	

	

var r = 8;
var p = 3;


var parseName = function(_string, _pre){
	// return (_pre + "-" + escape(_string.replace(/\s+/g, "")));
	return (_pre + "-" + _string);
};
	var g = svg.selectAll("colorName")
		.data(colorArray)
		.enter()
		.append("g")
		.attr({
			"transform": function(d, i){ 
				// console.log(d);
				return "translate(0," + ((i * (r + p) * 2)) +")"; 
			},
			"class": function(d, i){ 
				console.log(d);
				return "n-" + d["key"]; }			
		});

	var dots = 	g.selectAll("dots")
		.data(function(d){ 
			 console.log(d);
			return d["value"];})
		.enter();

	dots.append("circle")
		.attr({
			"cx": function(d, i){ return i * 2 * r ;},
			"cy": r,
			"r": r,
			"fill": function(d, i){ return d["color"];},
			"class":  function(d){ 
				// console.log(d);
				return parseName(d["name"], "c");}

		})
		.on("mouseover",function(d){

			// d3.select(this)
			// 	.attr("r", r * 3);
			d3.selectAll("." + this.className.animVal)
				.transition(500)
				.attr("r",r * 10)
				.transition()
				.attr("r",r * 3);
			// console.log(this.className.animVal);
			// console.log(d3.selectAll((".t" + this.className.animVal.split("c")[1])));
			d3.selectAll((".t" + this.className.animVal.split("c")[1]))
				.style("display", "inline");

		})
		.on("mouseout", function(d){
			// d3.select(this)
			// 	.attr("r",r);
			d3.selectAll("." + this.className.animVal)
				.transition()
				.attr("r",r);
			d3.selectAll((".t" + this.className.animVal.split("c")[1]))
				.style("display", "none");
		})


	dots.append("text")
		.attr({
			"y": 2 * r - 2,
			"x": function(d, i){ return i * 2 * r + 10 ;},
			"class": function(d){ return parseName(d["name"], "t");},
			"stroke": "white",
			"stroke-width": "4px"

		})
		.style({
			"display":"none",
			"font-size": "12px" 
		})
		.text(function(d){
			return d["name"];
		})

	dots.append("text")
		.attr({
			"y": 2 * r - 2,
			"x": function(d, i){ return i * 2 * r + 10;},
			"class": function(d){ return parseName(d["name"], "t");}
		})
		.style({
			"display":"none",
			"font-size": "12px" 
		})
		.text(function(d){
			return d["name"];
		})


	g.append("text")
		.attr({
			"y": 2 * r - 2,
			"x": - margin.left
		})
		.text(function(d){ return d.key; })
		.on("mouseover", function(d, i){
			// console.log(d);
			console.log(parseName(d["key"], "n"));

			d3.selectAll("." + parseName(d["key"], "n")).selectAll("circle")
				.transition(50)
				.delay(function(d, i){
					// return i * 500; 
					return i * 100; 
				})
				.attr("r", 50)
				.transition(50)
				.attr("r", 8)
		})



})
