server <- function (input, output, session) {
  output$hcontainer <- renderHighchart ({
    
    #if(input$country==inf$region)
    #{
    df<-datavend %>% filter(datavend$Vendeur==input$vendeur)
    
    hchart(df, "line",color="#DC270C",hcaes(x=Date,y=Montant))  %>%
      
      hc_exporting(enabled = TRUE) %>% 
      hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5",
                 shared = TRUE, borderWidth = 2) %>%
      hc_title(text="Evolution des prix",align="center") %>%
      hc_subtitle(text="nricher",align="center") %>%
      hc_add_theme(hc_theme_elementary())
    
  })
  
  output$hc2<-renderHighchart({
    highchart() %>% 
      hc_xAxis(categories=datavend$Date) %>% 
      hc_add_series(name = "vendeur 3", data = vend3_sum$Montant) %>% 
      hc_add_series(name = "vendeur 1", data = vend1_sum$Montant) %>%
      hc_add_series(name = "vendeur 4", data = vend4_sum$Montant) %>%
      hc_add_series(name = "vendeur 5", data = vend5_sum$Montant) %>%
      hc_add_series(name = "vendeur 6", data = vend6_sum$Montant) %>%
      hc_add_series(name ="vendeur 2", data = vend2_sum$Montant) %>%
      #to add colors
      hc_colors(c("red","blue","green","purple","darkpink","orange")) %>%
      hc_add_theme(hc_theme_elementary())
    
  })
  
  output$vente <- renderPlotly({
    fig <- plot_ly(quant_matela, labels = ~Vendeur, values = ~Quantité, type = 'pie')
    fig <- fig %>% layout(title = 'Répartition de la quantité des matelas vendus pour chaque vendeur ',
                          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    fig
  })
  
  output$prix <- renderHighchart ({
    hc <- prix_matela %>%
      hchart(
        "pie", hcaes(x = Vendeur, y = prix),
        name = "Somme"
      ) %>%
      hc_title(text = "Répartition des prix matelas vendus pour chaque vendeur")
    
    hc

    
  })
  
  
}
  

shinyApp(ui = ui, server = server)


