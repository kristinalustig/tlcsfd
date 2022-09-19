M = {}

function M.initialize()

  coffeeDrinks = {}

  coffeeDrinks[1] = {
    
    name = "Mud Cup",
    description = "As basic as basic can be. Two shots of dog-friendly espresso.",
    numIngredients = 2,
    ingredients = {
    
      1, 2
      
    }
    
  }

  dogInfo = {}

  dogInfo[1] = {
    
    name = "Patches",
    favoriteDrinkId = 1,
    hello = "Hi there! I'm so HAPPY there's a dog coffee shop here that I could JUST WAG MY TAIL OFF! I'd love a basic mud cup please, woof woof!",
    finishedPrompt = "Arrrrrr you finished yet? Bark, I'm thirsty!",
    positiveResponse = "Grrrrruff bark! So muddy! I love!",
    negativeResponse = "Grr... not exactly, but that's ok.",
    staying = "I think I'll grrrrrrab a table and slobber up my drink!",
    farewell = "I gotta go pee on a tree now!! Thank you, bark bark!",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2
    
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
    visitedToday = false,
    pastryWanted = 2
    
  }
  
  seating = {}
  
  seating[1] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
  }
  
  snacks = {}
  
  snacks[1] = {
    name = "Bone",
    img = boneImg
    }
  snacks[2] = {
    name = "Donut",
    img = donutImg
    }
  snacks[3] = {
    name = "Cookie",
    img = cookieImg
    }
  snacks[4] = {
    name = "Eclair",
    img = eclairImg
    }
  
  
end

return M
