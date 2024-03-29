
  library(lubridate)
  library(plyr)
  
  setwd("D:/KEEP_ISKAR/R/datos/TICKETS/TICKETS2015/datos/SM1")
  readdata <- read.csv(paste(mes,".csv",sep="")

  colnames(combined) <<- c("Fecha", "Sesion", "Cajero", "Total", "Tienda")
  datatickets <<- c(combined$Total, na.rm= TRUE)
  numerodatos <- nrow(combined)
  soloventas <<- subset (datatickets, datatickets > 0)
  ventastotales <<- sum(soloventas)
  combinedmean <<- mean(soloventas)
  ventamin <<- min(soloventas)
  ventamax <<- max(soloventas)
  
  dataticketsplit <<- split(combined, combined$Cajero)
  dataticketsplit2 <<- list2env(dataticketsplit, envir = .GlobalEnv)
  
  c1 <- as.matrix(subset (soloventas, soloventas <= 20))
  c2 <- as.matrix(subset (soloventas, soloventas > 20 & soloventas <= 50))
  c3 <- as.matrix(subset (soloventas, soloventas > 50 & soloventas <= 100))
  c4 <- as.matrix(subset (soloventas, soloventas > 100 & soloventas <= 200))
  c5 <- as.matrix(subset (soloventas, soloventas > 200 & soloventas <= 400))
  c6 <- as.matrix(subset (soloventas, soloventas > 400))
  
  cuentas1 <- nrow(c1)
  cuentas2 <- nrow(c2)
  cuentas3 <- nrow(c3)
  cuentas4 <- nrow(c4)
  cuentas5 <- nrow(c5)
  cuentas6 <- nrow(c6)
  Frecuencia <- c(cuentas1, cuentas2, cuentas3, cuentas4, cuentas5, cuentas6)
  Clases <- c("Menor a $20.00", "$21.00 a $50.00", "$51.00 a $100.00",
              "$101.00 a $200.00", "$201.00 a $400.00", "Mayor a $400.00")
  
  tabla <<- data.frame(Clases, Frecuencia)
  tablabonita <<- format (tabla, width = 20, justify = "right")
  
  resumen <<- c(numerodatos, ventastotales, combinedmean, ventamin, ventamax)
  resumentitle <- c("Numero de Tickets", "Ventas Totales", "Promedio de Venta", "Venta Baja", "Venta Alta") 
  resumentabla <<- data.frame(resumentitle, resumen)
  
  promedio_cajeros <<- ddply (combined, "Cajero", summarise, promediocajero = mean(Total))
  numero_de_ventas <<- ddply (combined, "Cajero", summarise, ticketstotal = length(Total))
  suma_cajeros <<- ddply (combined, "Cajero", summarise, ventatotal = sum(Total))
  
  cajeros <<- cbind(promedio_cajeros, numero_de_ventas[,2], suma_cajeros[,2])



shinyServer(
  function(input, output) {
    #input$mes <- renderPrint({input$mes})
    output$mes <- renderPrint({input$mes})

  }
)
