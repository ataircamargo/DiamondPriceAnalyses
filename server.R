library(shiny)
library(ggplot2)
#Subset non relevant columns
d1 <- subset(diamonds, select=-c(x,y,z,table,depth))
#Transform to Data Frame
d1 <- as.data.frame(d1)


# Define server logic required 
shinyServer(function(input, output) {
    #This session subsets the dataframe according to a given variable and calculates the mean.  
    #Then it passes the result to UI
    output$carat <- renderText({
      caratinput <- input$sliderCarat
    
      m.carat <- aggregate(. ~ carat, d1[which(d1$carat == caratinput), ], mean)
        m.carat$price <- round(m.carat$price, digits = 2)
        paste("In Average, a Diamond with this Carat costs ", m.carat$price)
})
  
    output$cut <- renderText({
      cutinput <- input$boxcut
    
      m.cut <- aggregate(. ~ cut, d1[which(d1$cut == cutinput), ], mean)
        m.cut$price <- round(m.cut$price, digits = 2)
        paste("In Average, a Diamond with this Cut costs ", m.cut$price)
})
  
    output$color <- renderText({
      colorinput <- input$boxcolor
    
      m.color <- aggregate(. ~ color, d1[which(d1$color == colorinput), ], mean)
        m.color$price <- round(m.color$price, digits = 2)
        paste("In Average, a Diamond with this Color costs ", m.color$price)
})
    
    output$clarity <- renderText({
      clarityinput <- input$boxclarity
      
      m.clarity <- aggregate(. ~ clarity, d1[which(d1$clarity == clarityinput), ], mean)
        m.clarity$price <- round(m.clarity$price, digits = 2)
        paste("In Average, a Diamond with this Clarity costs ", m.clarity$price)
})

    #This session recalculates all the variables to create the total mean    
    output$mean <- renderText({
      caratinput <- input$sliderCarat
        m.carat <- aggregate(. ~ carat, d1[which(d1$carat == caratinput), ], mean)
        m.carat$price

      cutinput <- input$boxcut
        m.cut <- aggregate(. ~ cut, d1[which(d1$cut == cutinput), ], mean)
        m.cut$price

      colorinput <- input$boxcolor
        m.color <- aggregate(. ~ color, d1[which(d1$color == colorinput), ], mean)
        m.color$price

      clarityinput <- input$boxclarity
        m.clarity <- aggregate(. ~ clarity, d1[which(d1$clarity == clarityinput), ], mean)
        m.clarity$price

      inputs <- c(m.carat$price, m.cut$price, m.color$price, m.clarity$price)
        mean.total <- mean(inputs)
        mean.total <- round(mean.total, digits = 2)
        paste("In Average, a Diamond with all these Characteristics cost ", mean.total)
})
    
      #This session calculates the ideal price using Linear Model considering only Carat
      output$pred1 <- renderText({
      
        caratinput <- input$sliderCarat
      
        lm1<-lm(price ~ carat, data = d1)
    
      n.pred1<-predict(lm1, newdata=data.frame(carat = caratinput))
        pred1 <- round(n.pred1, digits = 2)
        paste("Considering this Carat, the Linear Model suggest this price ", pred1)
})

      #This session calculates the ideal price using Linear Model considering only Carat
      output$pred2 <- renderText({
      
        caratinput <- input$sliderCarat
        cutinput <- input$boxcut
      
      lm1 <-lm(price ~ carat, data = d1)
      lm2 <- update(lm1, ~ . + cut, data= d1)
      
      n.pred2 <-predict(lm2, newdata=data.frame(carat = caratinput, cut = cutinput))
        pred2 <- round(n.pred2, digits = 2)
        paste("Considering this Carat and Cut, the Linear Model suggest this price ", pred2)
})

      #This session calculates the ideal price using Linear Model considering only Carat
      output$pred3 <- renderText({
        caratinput <- input$sliderCarat
        cutinput <- input$boxcut
        colorinput <- input$boxcolor
      
      lm1 <-lm(price ~ carat, data = d1)
      lm2 <- update(lm1, ~ . + cut, data= d1)
      lm3 <- update(lm2, ~ . + color, data= d1)
      
      n.pred3 <-predict(lm3, newdata=data.frame(carat = caratinput, cut = cutinput, color = colorinput))
        pred3 <- round(n.pred3, digits = 2)
        paste("Considering this Carat, Cut and Color, the Linear Model suggest this price ", pred3)
})
      #This session calculates the ideal price using Linear Model considering only Carat
      output$pred4 <- renderText({
        caratinput <- input$sliderCarat
        cutinput <- input$boxcut
        colorinput <- input$boxcolor
        clarityinput <- input$boxclarity
      
      lm1 <-lm(price ~ carat, data = d1)
      lm2 <- update(lm1, ~ . + cut, data= d1)
      lm3 <- update(lm2, ~ . + color, data= d1)
      lm4 <- update(lm3, ~ . + clarity, data= d1)
      
      n.pred4 <-predict(lm4, newdata=data.frame(carat = caratinput, cut = cutinput, color = colorinput, clarity = clarityinput))
        pred4 <- round(n.pred4, digits = 2)
        paste("Considering this Carat, Cut, Color and Clarity, the Linear Model suggest this price ", pred4)
})
})
