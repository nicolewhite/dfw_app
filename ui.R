shinyUI(fluidPage(
  titlePanel("DFW Food & Drink Finder"),
  sidebarLayout(
    sidebarPanel(
      strong("Show me food & drink places in the following categories"),
      checkboxGroupInput("categories",
                         label = "",
                         choices = list("American Cuisine" = "American Cuisine", 
                                        "Asian" = "Asian", 
                                        "Bar" = "Bar", 
                                        "Barbecue" = "Barbecue", 
                                        "Coffee" = "Coffee", 
                                        "Desserts & Snacks" = "Desserts & Snacks", 
                                        "Fast Food" = "Fast Food", 
                                        "Grand Hyatt Dining" = "Grand Hyatt Dining", 
                                        "Italian/Pizza" = "Italian/Pizza",
                                        "Mexican/Southwest" = "Mexican/Southwest",
                                        "Power Charging" = "Power Charging",
                                        "Sandwich/Deli" = "Sandwich/Deli",
                                        "Seafood" = "Seafood"),
                         selected = c("Coffee", "Power Charging")),
      strong("closest to gate"),
      numericInput("gate", 
                   label = "", 
                   value = 10),
      br(),
      strong("in terminal"),
      selectInput("terminal", 
                  label = "", 
                  choices = list("A" = "A", 
                                 "B" = "B",
                                 "C" = "C",
                                 "D" = "D",
                                 "E" = "E"),
                                 selected = "A"),
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