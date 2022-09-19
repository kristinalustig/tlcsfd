M = {}

function M.initialize()

  coffeeDrinks = {}

  coffeeDrinks[1] = {
    
    name = "Mud Cup Woof Woof!",
    description = "As basic as basic can be. Two shots of dog-friendly espresso.",
    numIngredients = 2,
    ingredients = {
    
      1, 2
      
    }
  }
  
  coffeeDrinks[2] = {
    
    name = "GRRRaspberry Milk",
    description = "A delicately flavored beveRRRage: just milk and raspberry syrup.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[3] = {
    
    name = "Super Peppy Puppy Latte",
    description = "So! Pumped! For this double-shot latte with milk and whipped cream.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[4] = {
    
    name = "Puppacino",
    description = "Classic with a twist. Whipped cream with rawhide syrup.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[5] = {
    
    name = "Zoomies Coffee",
    description = "Must zoom to get this drink with one shot of espresso and caramel syrup! Hurry!",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[6] = {
    
    name = "Fetch Me A Latte",
    description = "Two shots with milk, beautiful latte art, and sprinkles. Go fetch!",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[7] = {
    
    name = "Sweetie Sweet Latte",
    description = "One shot espresso, milk, and every syrup, with lovely art. Only for the sweetest of pups.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[8] = {
    
    name = "Sssssprrrrinkles!",
    description = "Do you love sprinkles? I love sprinkles. Whipped cream and sprinkles.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[9] = {
    
    name = "Bone Milk",
    description = "Bone milk for a bone-lovin' dog. Rawhide syrup and milk.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }
  
  coffeeDrinks[10] = {
    
    name = "Bury This Vanilla Delite",
    description = "So good you'll want to bury it for later. Vanilla, one shot, and whipped cream.",
    numIngredients = 2,
    ingredients = {
    
      3, 10
      
    }
  }

  dogInfo = {}

  dogInfo[1] = {
    
    name = "Patches",
    favoriteDrinkId = 1,
    hello = "Hi there! I'm so HAPPY there's a dog coffee shop here that I could JUST WAG MY TAIL OFF! I'd love a mud cup please, woof woof! And a diggity-dang donut, too!",
    helloLate = "Oh boy oh boy oh boy! I can't wait! Can I have what I always have, pretty please? WOOF!",
    finishedPrompt = "Arrrrrr you finished yet? Bark, I'm thirsty!",
    positiveResponse = "Grrrrruff bark! So MUDDY! I love!",
    negativeResponse = "Grr... not exactly right, but that's ok.",
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
    favoriteDrinkId = 2,
    hello = "Good morrow, madam. 'Tis I, Miss Ginger. Would you be everrrrr so kind and fetch me a raspberry milk? Perhaps with a dainty little cookie. I do love cookies so.",
    helloLate = "So good to see you again, madam. I'll have my usual, please, if you could.",
    finishedPrompt = "Have you completed my orderrrruff? I'm starting to get hungrrRRRRy, I can't contain myself!",
    positiveResponse = "Heavens, what a treat! I must have been such a good girl to get such a treat.",
    negativeResponse = "My word, this isn't correct at all. Grrrr. I guess it shall have to do.",
    staying = "I suppose I'll stay here and nibble it all down.",
    farewell = "Must run, see you again soon darrRRRling, toodle-oo!",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[3] = {
    
    name = "Willow",
    favoriteDrinkId = 3,
    hello = "Willow here. Keep this between us, but I have a lot of work today for my job at the DIA - Dog Intelligence Agency. I need my Super Peppy Doggy Latte, stat! And a sneaky cookie.",
    helloLate = "I think I can tell you a bit more about my work at the DIA, if you promise not to tell anyone. Ready? ...Squirrels? THEY SEEM SUSPICIOUS. Must do further RRRresearch. Anyway, the usual, please.",
    finishedPrompt = "I'm getting urgent messages on my dogphone, are you done?",
    positiveResponse = "My dog bosses at the DIA will be wagging their tails at this service. Thank you.",
    negativeResponse = "Are you a secret agent working for the cats, determined to undermine the work that the DIA does? I hope this doesn't mess up my stakeout today.",
    staying = "",
    farewell = "I have to hurry, time waits for no dog!",
    sitChoiceOneId = nil,
    sitChoiceTwoId = nil,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[4] = {
    
    name = "Penelope",
    favoriteDrinkId = 4,
    hello = "Oh, I'm so busy, can't you get me a puppacino? and quickly! My pups waiting outside want a bone, too.",
    helloLate = "Ah, you know how Honey and Peanut are. They were eyeing up the mailman on my way in. Hope you're not waiting for anything important? Anyway, the usual, please.",
    finishedPrompt = "I think I can see my puppies digging something up outside, oh no, is it done?",
    positiveResponse = "Wonderful, wonderful. Ah, crap. Honey! Peanut! Don't you eat that!",
    negativeResponse = "",
    staying = "",
    farewell = "Gotta go!",
    sitChoiceOneId = nil,
    sitChoiceTwoId = nil,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[5] = {
    
    name = "Oskar",
    favoriteDrinkId = 5,
    hello = "Ohhhhhhh my gosh! I am so so so jazzed for some coffeeeee! Yip yip yip! I wanna run around in circles! Zoomie coffee for me, please please? And DONUT!",
    helloLate = "Did! You! See! That! Rabbit! Out! Side! Quick quick, my usual! Gotta chase, gotta chase! Ruff ruff!",
    finishedPrompt = "Ohboyohboyohboy is it my DRINK?",
    positiveResponse = "YES! I am a good boy! I got a good drink! I got a good snack!",
    negativeResponse = "This isn't what I wanted but IT CAN STILL HELP ME ZOOM!",
    staying = "Time to run in circles around your table while I snack. And while keep an eye on that RABBIT.",
    farewell = "",
    sitChoiceOneId = 3,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[6] = {
    
    name = "Buddy",
    favoriteDrinkId = 6,
    hello = "Hiya, pardner. Yer talkin' to Buddy. Been playin' fetch a loooong, long while. Come sniffin round here for one-a-them fetch latte deals. You got 'em? And an eclair? Don't act like I ain't fancy. Woof woof!",
    helloLate = "Great to see ya, pardner! Been giddy-yuppin' my way all over town, peein' on every phone pole, and fig'red I'd stop by for my usual, quick as y'can, ma'am.",
    finishedPrompt = "Them fire hydrants won't sniff themselves if ya catch my drift. You done yet?",
    positiveResponse = "Well scratch my ears and call me Buster! What a hootin' delight, bark bark! Thankee kindly!",
    negativeResponse = "Doggone it, this ain't right. Ah well, a drink's a drink.",
    staying = "Think I'll sniff around here for a spell. Got any good slippers for chewin'? Heh.",
    farewell = "Gotta skedaddle. Bark ya later.",
    sitChoiceOneId = 5,
    sitChoiceTwoId = 4,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[7] = {
    
    name = "Lil Cutie",
    favoriteDrinkId = 7,
    hello = "Yip yiiiiip! I am the one, the only, Lil Cutie! I'm on my way to the groomers, and I simply *must* have the sweetest drink on your menu. I can pair it with a donut and put it on dogstagram!",
    helloLate = "Yip yip! Hi again! My dogstagram posts are going BARKING MAD! Can I have my usual? I might put a lil video on Snif Snof this time!",
    finishedPrompt = "My camera's ready, my nails are trimmed, and I've licked my paws. I'm ready, is my drink?",
    positiveResponse = "This drink is so. Fetch. Wonderful, sweetie, just wonderful. Yip yip!",
    negativeResponse = "Um, I'm sorry, but this is definitely not the right order. Maybe it was for some other dog? Anyway, I'll still take it.",
    staying = "The lighting over there is just perfect, I think I'll stay. Don't forget to follow me on DogChat!",
    farewell = "Oh my god, *THE* Fuzzy Fernanda just liked my photo! Gotta run and tell *everyone* I've ever met! Yip yiiiiip!",
    sitChoiceOneId = 4,
    sitChoiceTwoId = 3,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[8] = {
    
    name = "T-Rex",
    favoriteDrinkId = 8,
    hello = "BORK. REX WANT SPRINKLES JUICE. REX WANT BONE. BORK BORK.",
    helloLate = "BORK. REX HAPPY TO SEE YOU. REX STILL WANT SAME FOOD. REX WILL NOT SLOBBER ON TABLE THIS TIME.",
    finishedPrompt = "AM SO HUNGRY. BORK READY BORK?",
    positiveResponse = "BORK BORK! SO BORK! HAPPY REX!",
    negativeResponse = "OH BORK. NO GOOD. T REX SAD.",
    staying = "REX SIT COUCH NOW. REX NOT ACCIDENT EAT CUSHION. REX PROMISE. BORK.",
    farewell = "REX CHASE KIDS ON BIKES NOW. BORK BYE!",
    sitChoiceOneId = 4,
    sitChoiceTwoId = 5,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[9] = {
    
    name = "Banana",
    favoriteDrinkId = 9,
    hello = "",
    helloLate = "",
    finishedPrompt = "",
    positiveResponse = "",
    negativeResponse = "",
    staying = "",
    farewell = "",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[10] = {
    
    name = "Rufus",
    favoriteDrinkId = 10,
    hello = "",
    helloLate = "",
    finishedPrompt = "",
    positiveResponse = "",
    negativeResponse = "",
    staying = "",
    farewell = "",
    sitChoiceOneId = 1,
    sitChoiceTwoId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  
  --TODO - update all seating stuff and fix layering in the dining area
  seating = {}
  
  --purple table back
  seating[1] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
  }
  
  --purple table front
  seating[2] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
  }
  
  --green table front
  seating[3] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
  }
  
  --sofa left
  seating[4] = 
  {
    
    x = 260,
    y = 495,
    cupX = 270,
    cupY = 510
    
  }
  
   --sofa right
  seating[5] = 
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
