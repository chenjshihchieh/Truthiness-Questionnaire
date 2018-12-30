## Set up the necessary variables for the shiny app to use


# Reads the list of questions and their question numbers
Qlist <- read.csv("Qlist.csv", header = TRUE, stringsAsFactors = FALSE)

# Reads the original, merged, data file
original <- read.csv(file.path("..", "truthScores.csv"), header = TRUE, stringsAsFactors = FALSE)

# Creates a vector with length = to the length of the original file
original.temp <- rep("", length(original))

# Gives name of the original data file to name of the empty vector
names(original.temp) <- names(original)
number.of.questions <- 16

# a Java script code saved for later
jscode <- "Shiny.addCustomMessageHandler('closeWindow', function(m) {window.close();});"

# Randomize the questions and makes sure that there are equal groups for all four conditions
group <- c(rep("A", 4), rep("B", 4), rep("AF", 4), rep("BF", 4))
Order.list <- paste0(sample(1:16, 16), sample(group, 16))

# Back end of the Shiny App
function(output, input, session){
  
  # This develops the user interface that changes based on the number of times the next button is clicked
  output$main.display <- renderUI({
    if(input$click == 0) {
      
      # all the inputs for the first page and the Introductory message
      list(textInput("RA", "RA"),
           textInput('PID', 'Participant ID'),
           textInput('Gender', 'Gender'),
           dateInput("DOB", "Date of Birth", value = "1990-01-01", max = Sys.Date(), startview = "decade"),
           h2("We're going to ask you some trivia questions, some with pictures and some without. Simply indicate whether the statements are 'True' or 'False' by clicking the corresponding option.", align = "center")
      )
    }else if(input$click > 0 & input$click <= number.of.questions){
      
      # The questions them selves with the Image, questions, and buttons
      list(
        imageOutput("Image", width = "400px", height = "300px"),
        h3(Qlist[Qlist$QNum == Order.list[[input$click]], 3], align = "center"),
        radioButtons(inputId = 'response', NULL, choiceNames = c("None Selected", "True", "False"), choiceValues = c(NA, "TRUE", "FALSE"), inline = TRUE)
      )
    }else{
      
      # Page after the question with the answers table, a message, and the javascript code for closing the browser
      list(h3("Your responses have been saved. If you are curious about the answers to the questions you were asked, they are available in a table below. You may press 'End' to end this task or close the browser."),
           tableOutput({"answers"}),
           tags$script(HTML(jscode))
           )
    }
     
  })

# Adjust the text on the "Next" button to show "End" when participant reaches the end
  output$button <- renderText({
    if(input$click <= number.of.questions){print("Next")
    }else{print("End")}
  })
  
  # Saves the participant inputs to the empty vector when a click is detected
  temp <- eventReactive(input$click,{
    if(input$click == 1){
      
      #first click will save the below inputs
      original.temp[input$click] <<- input$PID
      original.temp$RA <<- input$RA
      original.temp$Gender <<- input$Gender
      original.temp$Birthdate <<- as.character(input$DOB)
      original.temp$Order.of.Questions <<- paste(Order.list, collapse = ", ")
      original.temp$Time.of.Testing <<- as.character(Sys.time())
    }else if(input$click > 1 & input$click <= number.of.questions + 1){
      
      # Second click and beyond will save the results from the task. Also, combines the original results with the empty vector (now containing participant responses).
      original.temp[input$click+1] <<- input$response
      combined.result <- rbind(original, original.temp)
      
      # saves the combined results 
      write.csv(combined.result, file = file.path("..", "truthScores.csv"), row.names = FALSE)
      
      # Saves the empty vector (now with the participants response) to a new file with dependent names and datetime
      write.csv(original.temp, file = file.path("..", gsub(":", "", paste0("PID ", input$PID, " Date ", original.temp$Time.of.Testing, ".csv"))), row.names = FALSE)
      
      # Reset Radio buttons to "None selected
      updateRadioButtons(session, inputId = 'response', selected = 1)
    }
    
    ""
  })
  
  # Output so that Shiny will run the code to save participant responses
  output$b <- renderText({
    temp()
  })
  
  # This generates the image based on the current question
  output$Image <- renderImage({
    
    image.path <- file.path("www", Qlist[Qlist$QNum == Order.list[[input$click]], 4])
    list(src = image.path, width = "400px", height = "300px", border = "0", align = "center")
    
    key <- data.frame(Code = c("A", "B", "AF", "
  }, deleteFile = FALSE)
  
  # Generate the answers table
  output$answers <- renderTable({BF"), Value = c("TRUE", "TRUE", "FALSE", "FALSE"), stringsAsFactors = FALSE)
    no.number.order.list <- gsub("[^a-zA-Z]", "", Order.list)
    
    for(i in 1:number.of.questions){
      if(!exists("Question")){Question <- Qlist[Qlist$QNum == Order.list[[i]], 3]
      }else{Question <- c(Question, Qlist[Qlist$QNum == Order.list[[i]], 3])}
    }
    
    for(i in 1:number.of.questions){
      if(!exists("Answer")){Answer <- key[key[1] == no.number.order.list[i], 2]
      }else{Answer <- c(Answer, key[key[1] == no.number.order.list[i], 2])}
    }
    # Save response of participants for display at the end of survey (no longer used)
    #Response <- as.character(original.temp[1:number.of.questions + 1])
    
    
    print(data.frame(Question, Answer))
    
  })
  # Stops shiny app
  #observe({
    
    # Code for shutting down R and browser after the "End" button has been pressed
    #if (input$click > number.of.questions + 1){
     # session$sendCustomMessage(type = "closeWindow", message = "message")
      #stopApp()
    #}
  #})
    
  # Code for shutting down R when browser window is closed
  #session$onSessionEnded(function() {
   # q(save = "no")
  #})
  
}
