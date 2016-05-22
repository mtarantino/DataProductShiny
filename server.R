
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(DT)
library(ggplot2)
data(diamonds)


shinyServer(function(input, output, session) {
    
    data <- reactive({
        data <- diamonds[ diamonds$carat >= input$caratRange[1] &
                            diamonds$carat <= input$caratRange[2],]
        if(input$color != "all") {
            data <- data[ data$color == input$color,]
        }
        return(data)
    })
    
    fit <- reactive({
        if( input$enableLM) {
            lm(price ~ carat, data=data())
        } else  {
            NULL
        }

    })
    
    output$plot <- renderPlot({
        p <- ggplot(data(), aes(x=carat, y=price, color=color))
        p <- p + geom_point()
        if( !is.null(fit())) {
            p <- p + geom_line(aes(x=data()$carat, y=predict(fit())), colour = "red")
        }
        p
    })
    
    output$summary <- renderPrint({
        summary(data())
    })
    
    output$data = renderDataTable({
        data()
    }, options = list(lengthMenu = c(15, 30, 50), pageLength = 15))
    
    
})