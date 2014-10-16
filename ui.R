library(shiny)
library(RNeo4j)

password = Sys.getenv("GRAPHENEDB_PASSWORD")
url = Sys.getenv("GRAPHENEDB_URL")
username = Sys.getenv("GRAPHENEDB_USERNAME")

graph = startGraph(url = url,
                   username = username,
                   password = password)

categories = getLabeledNodes(graph, "Category")
categories = sapply(categories, function(c) c$name)

terminals = getLabeledNodes(graph, "Terminal")
terminals = sapply(terminals, function(t) t$name)

shinyUI(fluidPage(
  titlePanel("DFW Food & Drink Finder"),
  sidebarLayout(
    sidebarPanel(
      strong("Show me food & drink places in the following categories"),
      checkboxGroupInput("categories",
                         label = "",
                         choices = categories,
                         selected = sample(categories, 3)),
      strong("closest to gate"),
      numericInput("gate", 
                   label = "", 
                   value = sample(1:30, 1)),
      br(),
      strong("in terminal"),
      selectInput("terminal", 
                  label = "", 
                  choices = terminals,
                  selected = sample(terminals, 1)),
      "Powered by", a("Neo4j", 
                      href = "http://www.neo4j.org/",
                      target = "_blank"), 
      "and", a("GrapheneDB",
               href = "http://www.graphenedb.com/",
               target = "_blank")
    ),
    mainPanel(
      tableOutput("restaurants")
    )
  )
))