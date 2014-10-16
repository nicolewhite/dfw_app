library(RNeo4j)

password = Sys.getenv("GRAPHENEDB_PASSWORD")
url = Sys.getenv("GRAPHENEDB_URL")
username = Sys.getenv("GRAPHENEDB_USERNAME")

graph = startGraph(url = url,
                   username = username,
                   password = password)

query = "
MATCH (p:Place)-[:IN_CATEGORY]->(c:Category),
      (p)-[:AT_GATE]->(g:Gate),
      (g)-[:IN_TERMINAL]->(t:Terminal)
WHERE c.name IN {categories} AND t.name = {terminal}
WITH c, p, g, t, ABS(g.gate - {gate}) AS dist
ORDER BY dist
RETURN p.name AS Name, c.name AS Category, g.gate AS Gate, t.name AS Terminal
"

shinyServer(function(input, output) {
  output$restaurants <- renderTable({
    data = cypher(graph, 
                  query,
                  categories = as.list(input$categories),
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