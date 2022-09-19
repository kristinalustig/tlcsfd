M = {}

function M.initialize()

  coffeeDrinks = {}

  coffeeDrinks[1] = {
    
    name = "Test Drink",
    description = "Cool Description",
    numIngredients = 2,
    ingredients = {
    
      1, 2
      
    }
    
  }

  dogInfo = {}

  dogInfo[1] = {
    
    name = "Patches",
    favoriteDrinkId = 1,
    hello = "Hi there! I'd love a basic mud cup please, woof woof!",
    finishedPrompt = "Arrrrrr you finished yet? Bark, I'm thirsty!",
    positiveResponse = "Grrrrruff bark! So muddy! I love!",
    negativeResponse = "Grr... not exactly, but that's ok.",
    staying = "I think I'll grrrrrrab a table and slobber up my drink!",
    farewell = "I gotta go pee on a tree now!! Thank you, bark bark!",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false
    
  }
  
  dogInfo[2] = {
    
    name = "Ginger",
    favoriteDrinkId = 1,
    hello = "Hi there! I'd love a basic mud cup please, woof woof!",
    finishedPrompt = "Arrrrrr you finished yet? Bark, I'm thirsty!",
    positiveResponse = "Grrrrruff bark! So muddy! I love!",
    negativeResponse = "Grr... not exactly, but that's ok.",
    staying = "I think I'll grrrrrrab a table and slobber up my drink!",
    farewell = "I gotta go pee on a tree now!! Thank you, bark bark!",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false
    
  }
  
  seating = {}
  
  seating[1] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
    }
  
end

return M
