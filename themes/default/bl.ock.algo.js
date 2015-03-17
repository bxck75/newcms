(function() {

var width = 960,
    height = 360;

var N = 1 << 0,
    S = 1 << 1,
    W = 1 << 2,
    E = 1 << 3;

var cells,
    active = 0;

var p = d3.select("#wrapper");

var canvas = p.append("canvas")
    .attr("width", width)
    .attr("height", height);

p.append("button")
    .text("▶ Play");

var context = canvas.node().getContext("2d");

whenFullyVisible(p.node(), function() {
  var worker = new Worker("./themes/default/generate-randomized-depth-first-traversal.js");
  worker.postMessage({width: width, height: height});
  worker.addEventListener("message", function(event) {
    worker.terminate();
    cells = event.data;
    p.on("click", click);
    click();
  });
});

function click() {
  var id = ++active;

  context.clearRect(0, 0, width, height);
  p.classed("animation--playing", true);

  var distance = 0,
      visited = new Array(width * height),
      frontier = [(height - 1) * width],
      image = context.createImageData(width, height);

  function flood() {
    var frontier1 = [],
        i0,
        n0 = frontier.length,
        i1,
        color = d3.rgb(floodColor(distance++));

    for (var i = 0; i < n0; ++i) {
      i0 = frontier[i] << 2;
      image.data[i0 + 0] = color.r;
      image.data[i0 + 1] = color.g;
      image.data[i0 + 2] = color.b;
      image.data[i0 + 3] = 255;
    }

    for (var i = 0; i < n0; ++i) {
      i0 = frontier[i];
      if (cells[i0] & E && !visited[i1 = i0 + 1]) visited[i1] = true, frontier1.push(i1);
      if (cells[i0] & W && !visited[i1 = i0 - 1]) visited[i1] = true, frontier1.push(i1);
      if (cells[i0] & S && !visited[i1 = i0 + width]) visited[i1] = true, frontier1.push(i1);
      if (cells[i0] & N && !visited[i1 = i0 - width]) visited[i1] = true, frontier1.push(i1);
    }

    frontier = frontier1;
    return !frontier1.length;
  }
 
  d3.timer(function() {
    if (id !== active) return true;
    for (var i = 0, done; i < 50 && !(done = flood()); ++i);
    context.putImageData(image, 0, 0);
    return done && p.classed("animation--playing", false);
  });
}

})()


