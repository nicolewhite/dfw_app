library(RNeo4j)

password = Sys.getenv("GRAPHENEDB_PASSWORD")

graph = startGraph("http://dfw.sb02.stations.graphenedb.com:24789/db/data/",
                   username = "dfw",
                   password = password)

query1 = "MATCH (c:Category)<-[:IN_CATEGORY]-(p:Place)-[:AT_GATE]->(g:Gate)-[:IN_TERMINAL]->(t:Terminal {name:{terminal}})"
          
query2 = "WITH c, p, g, t, g.gate - {gate} AS dist
          ORDER BY ABS(dist)
          RETURN p.name AS Name, c.name AS Category, g.gate AS Gate, t.name AS Terminal"

shinyServer(function(input, output) {
  output$restaurants <- renderTable({
    if(length(input$categories) > 1) {
      query = paste(query1, "WHERE c.name IN {categories}", query2)
    } else if(length(input$categories == 1)) {
      query = paste(query1, "WHERE c.name = {categories}", query2)
    } else {
      query = paste(query1, query2)
    }
    data = cypher(graph, 
                  query,
                  categories = input$categories,
                  terminal = input$terminal,
                  gate = input$gate)
    if(is.null(data)){
      return(data)
    } else{
      data$Gate = as.integer(data$Gate)
      return(data)
    }
  })
}
)