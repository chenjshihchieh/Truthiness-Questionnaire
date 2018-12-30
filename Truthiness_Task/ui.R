fluidPage(
  tags$style("
      .radio { /* radio is a div class*/
        line-height: 30px;
        margin-bottom: 40px; /*set the margin, so boxes don't overlap*/
      }
      input[type='radio']{ /* style for radio */
        width: 30px; /*Desired width*/
        height: 30px; /*Desired height*/
        line-height: 30px; 
      }
      span { 
          margin-left: 15px;  /*set the margin, so boxes don't overlap labels*/
          line-height: 30px; 
      }
  "),
  align = "center",
  uiOutput('main.display'),
  actionButton(inputId = 'click', label = textOutput("button")),
  textOutput("b")
  )
