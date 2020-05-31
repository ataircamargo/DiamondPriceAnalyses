library(shiny)
shinyUI(fluidPage(
  titlePanel("Diamond Price Analyses"),
    h3("Please choose the Characteristcs of your Diamond"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "Please choose the Diamond Carat: ", 0.5, 5.5, value = 1),
      selectInput("boxcut", "Please choose the Diamond Cut: ", c("Fair", "Good", "Very Good", "Premium","Ideal"), selected = "Fair"),
      selectInput("boxcolor", "Please choose the Diamond Color: ", c("D", "E", "F", "G", "H","I", "J"), selected = "D"),
      selectInput("boxclarity", "Please choose the Diamond Clarity: ", c("SI1", "VS1", "VS2", "SI2", "VVS2"), selected = "SI1"),
      br()
),
    mainPanel(
      br(),
      h4(p(textOutput("carat"))),
      br(),
      h4(p(textOutput("cut"))),
      br(),
      h4(p(textOutput("color"))),
      br(),
      h4(p(textOutput("clarity"))),
      br(),
      h4(p(textOutput("mean"))),
      br(),
      h4(p(textOutput("pred1"))),
      br(),
      h4(p(textOutput("pred2"))),
      br(),
      h4(p(textOutput("pred3"))),
      br(),
      h4(p(textOutput("pred4"))),
      br(),
      )
  )
))