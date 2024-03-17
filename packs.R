require(tidyverse)
require(patchwork) # combine ggplot2 plots into one object, plot_layout() to 
#   adjust components
#ggiraph makes ggplot2 plots interactive with new geoms
#dygraphs - create html/javascript graphs of time series, one-line cmd on xts objs
require(googleVis) #google charts API, useful for moving/interactive
#taucharts good for scatterplots to view multiple regression options
#metricsgraphics - imports javascript library for
#   bare-bones line, scatter, bar chart/plot
#RColorBrewer helps select color palettes if not designer
#Shiny - R data into interactive web apps
#flexdashboard - simpler than shiny, less robust, based on R Markdown
#rcdimple - dimple JavaScript lib with customization options for JavaScript vi
#Plotly - easy to learn and vis with, ggplotly() turns ggplot2 graphs interactive
#highcharter presentation-quality interactive graphics (license for profitable use)
#echarts4r wrapper for ECharts in JS, versatile visualization types
#geofacet - vis in same-sized blocks with geospatially appropriate locations 
#   e.g. france chart on top of spain chart
require(gganimate) # for animation
require(gifski) #render for gganimate