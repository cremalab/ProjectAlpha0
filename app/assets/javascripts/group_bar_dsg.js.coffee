# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $.getJSON '/daily_stage_values','json', (data) ->
    w = 850
    h = 500
    padding = {top: 100, right: 100, bottom: 100, left:100}
    stack = d3.layout.stack(data)

    color_hash = {
      0: ["Done", "#653A3C"],
      1: ["Deployed - Production", "#936264"],
      2: ["Ready for Production", "#B48889"],
      3: ["Deployed - Staging", "#DAB8B9"],
      4: ["Merged", "#325230"],
      5: ["In Progress", "#527950"],
      6: ["To Do", "#71936F"],
      7: ["(No Heading)", "#98B296"]
    }

    data_structure = {
      "Done": [],
      "Deployed - Production": [],
      "Ready for Production": [],
      "Deployed - Staging": [],
      "Merged": [],
      "In Progress": [],
      "To do": [],
      "(No Heading)": []
    }


    for i in [0..data.length - 1]
      if data[i].task_board.name == "LC - Task Board"
        data_structure[data[i].name].push data[i]

    final_structure = []
    for k, v of data_structure
      final_structure.push v

    # Set up scales


    for i in [0..final_structure.length - 1]
      for j in [0..final_structure[i].length - 1]
        final_structure[i][j].y = final_structure[i][j].total_hours
        final_structure[i][j].time = final_structure[i][j].created_at

    stack(final_structure)

    first_date = new Date(final_structure[0][0].created_at)

    last_date = new Date(final_structure[0][final_structure[0].length-1].created_at)

    xScale = d3.time.scale()
      .domain([first_date, d3.time.day.offset(last_date,14)])
      .rangeRound([0, w - padding.left - padding.right]);

    yScale = d3.scale.linear()
      .domain([0,
        d3.max final_structure, (d)  ->
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

    svg = d3.select("#mbars")
      .append("svg")
      .attr("width", w)
      .attr("height", h)


    console.log final_structure

    console.log svg.selectAll("g").data()


    groups = svg.selectAll("g")
      .data(final_structure)
      .enter()
      .append("g")
      .attr("class", "rgroups")
      .attr("transform", "translate(" + padding.left + "," + (h - padding.bottom) + ")")
      .style("fill", (d, i) ->
        return color_hash[final_structure.indexOf(d)][1]
      )


    rects = groups.selectAll("rect")
        .data (d) ->
          console.log d
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
          console.log xScale(new Date(d.time))
          return xScale(new Date(d.time))
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

      legend.selectAll("g").data(final_structure)
        .enter()
        .append('g')
        .each (d,i) ->
          g = d3.select(this);
          g.append("rect")
            .attr("x", w - padding.right - 65)
            .attr("y", i*25 + 10)
            .attr("width", 10)
            .attr("height",10)
            .style("fill",color_hash[String(i)][1])

          g.append("text")
           .attr("x", w - padding.right - 50)
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






