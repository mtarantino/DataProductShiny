
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(DT)
library(markdown)

shinyUI(navbarPage("Data Product Assignment",
    tabPanel("Plot",
        sidebarLayout(
            sidebarPanel(
                h3("Diamon Color"),
                selectInput("color", label = "diamond colour, from J (worst) to D (best)", 
                            choices = list("All"="all", "D"="D", "E"="E",  
                                           "F"="F", "G"="G", "H"="H", "I"="I",
                                           "J"="J"), 
                            selected = 1),
                sliderInput("caratRange", label = h3("Carat Range"), min = 0, 
                            max = 5, value = c(0, 5)),
                h4("Linear Regression"),
                checkboxInput("enableLM", label = "Show linear regression", value = FALSE)
            ),
            mainPanel(
                h4("Price of diamons depending on carat and color"),
                plotOutput("plot"),
                h4("Summary table of the filtered dataset"),
                verbatimTextOutput("summary")
            )
        )
    ),
    tabPanel("Data",
        dataTableOutput("data")
    ),
    tabPanel("Documentation",
        fluidRow(
            column(6,
                includeMarkdown("documentation.md")
            )
        )
    )
))
