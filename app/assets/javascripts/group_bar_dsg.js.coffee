# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $.getJSON '/daily_stage_values','json', (data) ->
    final_structure = setup_data(data)

    build_graph(final_structure)


    d3.selectAll(".m")
      .on( "click", () ->
        project = this.getAttribute("value")
        console.log project
        final_structure = setup_data(data)

        console.log final_structure

        build_graph(final_structure)

      )

setup_data = (data) ->
  stack = d3.layout.stack(data)
  data_structure = {
    "Done": [],
    "Deployed - Production": [],
    "Ready for Production": [],
    "Deployed - Staging": [],
    "Merged": [],
    "In Progress": [],
    "To do": [],
    "To-Do": [],
    "(No Heading)": []
  }


  for i in [0..data.length - 1]
    if data[i].task_board.name == "LC - Task Board"
      data_structure[data[i].name].push data[i]

  final_structure = []
  for k, v of data_structure
    if v.length > 0
      final_structure.push v

  # Set up scales


  for i in [0..final_structure.length - 1]
    for j in [0..final_structure[i].length - 1]
      final_structure[i][j].y = final_structure[i][j].total_hours
      final_structure[i][j].time = new Date(final_structure[i][j].created_at).setHours(0, 0, 0)

  stack(final_structure)



build_graph = (data) ->
  svg = d3.select("#mbars")
    .append("svg")
    .attr("width", w)
    .attr("height", h)


  console.log svg.selectAll("g")
  console.log svg.selectAll("g")[0].length

  if svg.selectAll("g") > 0
    console.log "Here"
    rect
      .exit()
      .transition()
      .duration(1000)
      .ease("circle")
      .attr("x",w)
      .remove()

    groups
      .exit()
      .transition()
      .duration(1000)
      .ease("circle")
      .attr("x",w)
      .remove()

  color_hash = {
    7: ["(No Heading)", "#98B296"],
    6: ["To Do", "#71936F"],
    8: ["To Do", "#71936F"],
    5: ["In Progress", "#527950"],
    4: ["Merged", "#325230"],
    3: ["Deployed - Staging", "#DAB8B9"],
    2: ["Ready for Production", "#B48889"],
    1: ["Deployed - Production", "#936264"],
    0: ["Done", "#653A3C"]
  }

  w = 900
  h = 500
  padding = {top: 100, right: 150, bottom: 100, left:100}

  first_date = new Date(data[0][0].created_at)

  last_date = new Date(data[0][data[0].length-1].created_at)

  xScale = d3.time.scale()
    .domain([d3.time.day.offset(last_date,-14), last_date])
    .rangeRound([0, w - padding.left - padding.right])

  yScale = d3.scale.linear()
    .domain([0,
      d3.max data, (d)  ->
          return d3.max d, (d) ->
            return d.y + d.y0;
    ])
    .range([h-padding.bottom-padding.top,0]);


  xAxis = d3.svg.axis()
    .scale(xScale)
    .orient("bottom")
    .ticks(d3.time.days,1)

  yAxis = d3.svg.axis()
    .scale(yScale)
    .orient("left")
    .ticks(10)

  colors = d3.scale.category10()

  # svg = d3.select("#mbars")
  #   .append("svg")
  #   .attr("width", w)
  #   .attr("height", h)

  groups = svg.selectAll("g")
    .data(data)
    .enter()
    .append("g")
    .attr("class", "rgroups")
    .attr("transform", "translate(" + padding.left + "," + (h - padding.bottom) + ")")
    .style("fill", (d, i) ->
      return color_hash[data.indexOf(d)][1]
    )


  rects = groups.selectAll("rect")
      .data (d) ->
        return d
      .enter()
      .append("rect")
      .attr("width", 2)
      .style("fill-opacity",1e-6)

  rects.transition()
    .duration (d,i) ->
      return 500 * i;
    .ease("linear")
    .attr "x", (d) ->
        return xScale(new Date(d.time)) - 9
    .attr "y", (d) ->
      return -(- yScale(d.y0) - yScale(d.y) + (h - padding.top - padding.bottom)*2);
    .attr "height", (d) ->
      return -yScale(d.total_hours) + (h - padding.top - padding.bottom)
    .attr("width", 15)
    .style("fill-opacity",1)

    svg.append("g")
      .attr("class","x axis")
      .attr("transform","translate(100," + (h - padding.bottom) + ")")
      .call(xAxis)



    svg.append("g")
      .attr("class","y axis")
      .attr("transform","translate(" + padding.left + "," + padding.top + ")")
      .call(yAxis);


    # Adding a legend
    legend = svg.append("g")
      .attr("class","legend")
      .attr("x", w - padding.right - 65)
      .attr("y", 25)
      .attr("height", 100)
      .attr("width",100)

    legend.selectAll("g").data(data)
      .enter()
      .append('g')
      .each (d,i) ->
        g = d3.select(this);
        g.append("rect")
          .attr("x", w - padding.right + 0)
          .attr("y", i*25 + 10)
          .attr("width", 10)
          .attr("height",10)
          .style("fill",color_hash[String(i)][1])

        g.append("text")
         .attr("x", w - padding.right + 15)
         .attr("y", i*25 + 20)
         .attr("height",30)
         .attr("width",100)
         .style("fill",color_hash[String(i)][1])
         .text(color_hash[String(i)][0])

    svg.append("text")
      .attr("transform","rotate(-90)")
      .attr("y", 50 - 5)
      .attr("x", 0-(h/2))
      .attr("dy","1em")
      .text("Total Project Hours")

    svg.append("text")
      .attr("class","xtext")
      .attr("x",w/2 - padding.left)
      .attr("y",h - 55)
      .attr("text-anchor","middle")
      .text("Days")







