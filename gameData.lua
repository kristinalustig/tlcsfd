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
    description = "So! Pumped! For this double-shot latte and whipped cream.",
    numIngredients = 4,
    ingredients = {
    
      1, 2, 4, 6
      
    }
  }
  
  coffeeDrinks[4] = {
    
    name = "Puppacino",
    description = "Classic with a twist. Just whipped cream with rawhide syrup.",
    numIngredients = 2,
    ingredients = {
    
      6, 11
      
    }
  }
  
  coffeeDrinks[5] = {
    
    name = "Zoomies Coffee",
    description = "Must zoom to get this drink with one shot of espresso and caramel syrup! Hurry!",
    numIngredients = 2,
    ingredients = {
    
      1, 9
      
    }
  }
  
  coffeeDrinks[6] = {
    
    name = "Fetch It For Me Latte",
    description = "A two shot latte with beautiful latte art and sprinkles. Go fetch!",
    numIngredients = 5,
    ingredients = {
    
      1, 2, 4, 5, 7
      
    }
  }
  
  coffeeDrinks[7] = {
    
    name = "Sweetie Sweet Latte",
    description = "One shot latte with every syrup and lovely art. Only for the sweetest of pups.",
    numIngredients = 7,
    ingredients = {
    
      1, 4, 5, 8, 9, 10, 11
      
    }
  }
  
  coffeeDrinks[8] = {
    
    name = "Sssssprrrrinkles!",
    description = "Do you love sprinkles? I love sprinkles. Whipped cream and sprinkles.",
    numIngredients = 2,
    ingredients = {
    
      6, 7
      
    }
  }
  
  coffeeDrinks[9] = {
    
    name = "Bone Milk",
    description = "Bone milk for a bone-lovin' dog. Rawhide syrup and milk.",
    numIngredients = 2,
    ingredients = {
    
      3, 11
      
    }
  }
  
  coffeeDrinks[10] = {
    
    name = "Bury This Vanilla Delite",
    description = "So good you'll want to bury it for later. Vanilla, one shot, and whipped cream.",
    numIngredients = 3,
    ingredients = {
    
      1, 6, 8
      
    }
  }
  
  coffeeDrinks[11] = {
    
    name = "Bury This Vanilla Delite, no whip",
    description = "",
    numIngredients = 2,
    ingredients = {
    
      1, 8
      
    }
  }
  
  coffeeDrinks[12] = {
    
    name = "GRRRaspberry Milk, add sprinkles",
    description = "A delicately flavored beveRRRage: just milk and raspberry syrup.",
    numIngredients = 3,
    ingredients = {
    
      3, 10, 7
      
    }
  }
  
  coffeeDrinks[13] = {
    
    name = "Super Peppy Puppy Latte, just one shot",
    description = "So! Pumped! For this double-shot latte and whipped cream.",
    numIngredients = 3,
    ingredients = {
    
      1, 4, 6
      
    }
  }
  
  coffeeDrinks[14] = {
    
    name = "Puppacino, no rawhide, add vanilla",
    description = "Classic with a twist. Just whipped cream with rawhide syrup.",
    numIngredients = 2,
    ingredients = {
    
      6, 8
      
    }
  }
  
  coffeeDrinks[15] = {
    
    name = "Zoomies Coffee, two shots",
    description = "Must zoom to get this drink with one shot of espresso and caramel syrup! Hurry!",
    numIngredients = 3,
    ingredients = {
    
      1, 2, 9
      
    }
  }
  
  coffeeDrinks[16] = {
    
    name = "Fetch It For Me Latte, no sprinkles",
    description = "A two shot latte with beautiful latte art and sprinkles. Go fetch!",
    numIngredients = 4,
    ingredients = {
    
      1, 2, 4, 5
      
    }
  }
  
  coffeeDrinks[17] = {
    
    name = "Sweetie Sweet Latte, extra shot",
    description = "One shot latte with every syrup and lovely art. Only for the sweetest of pups.",
    numIngredients = 8,
    ingredients = {
    
      1, 2, 4, 5, 8, 9, 10, 11
      
    }
  }
  
  coffeeDrinks[18] = {
    
    name = "Sssssprrrrinkles!, add milk",
    description = "Do you love sprinkles? I love sprinkles. Whipped cream and sprinkles.",
    numIngredients = 3,
    ingredients = {
    
      3, 6, 7
      
    }
  }
  
  coffeeDrinks[19] = {
    
    name = "Bone Milk, add sprinkles",
    description = "Bone milk for a bone-lovin' dog. Rawhide syrup and milk.",
    numIngredients = 3,
    ingredients = {
    
      3, 7, 11
      
    }
  }
  
    coffeeDrinks[20] = {
    
    name = "Mud Cup Woof Woof!, one shot",
    description = "As basic as basic can be. Two shots of dog-friendly espresso.",
    numIngredients = 1,
    ingredients = {
    
      1
      
    }
  }
  


  dogInfo = {}

  dogInfo[1] = {
    
    name = "Patches",
    favoriteDrinkId = 1,
    hello1 = "Hi there! I'm so HAPPY there's a dog coffee shop here that I could JUST WAG MY TAIL OFF! I'd love a mud cup please, woof woof! And a diggity-dang donut, too!",
    hello2 = "Oh boy oh boy oh boy! I can't wait! Can I have what I had last time, pretty please? WOOF!",
    hello3 = "Oh I am always So! HAPPY! To see you, bark bark! My usual, my usual, my usual! I am drooling just thinking of it!",
    finishedPrompt = "Arrrrrr you finished yet? Bark, I'm thirsty!",
    positiveResponse = "Grrrrruff bark! So MUDDY! I love!",
    negativeResponse = "Grr... not exactly right, but that's ok.",
    staying = "I think I'll grrrrrrab a table and slobber up my drink!",
    farewell = "I gotta go pee on a tree now!! Thank you, bark bark!",
    sitChoiceOneId = 1,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[2] = {
    
    name = "Ginger",
    favoriteDrinkId = 2,
    hello1 = "Good morrow, madam. 'Tis I, Miss Ginger. Would you be everrrRRr so kind and fetch me a raspberry milk? Perhaps with a dainty little cookie. I do love cookies so.",
    hello2 = "So good to see you again, madam. I'll have what I ordered last time, please, if you could.",
    hello3 = "Splendid to see you. I'll have my usual, please. And, I must say, having been here a few times now, I am simply over the moon that your little shop has come here.",
    finishedPrompt = "Have you completed my orderrrruff? I'm starting to get hungrrRRRRy, I can't contain myself!",
    positiveResponse = "Heavens, what a treat! I must have been such a good girl to get such a treat.",
    negativeResponse = "My word, this isn't correct at all. Grrrr. I guess it shall have to do.",
    staying = "I suppose I'll stay here and nibble it all down.",
    farewell = "Must run, see you again soon darrRRRling, toodle-oo!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[3] = {
    
    name = "Willow",
    favoriteDrinkId = 3,
    hello1 = "Willow here. Keep this between us, but I have a lot of work today for my job at the DIA - Dog Intelligence Agency. I need my Super Peppy Doggy Latte, stat! And a sneaky cookie.",
    hello2 = "I think I can tell you a bit more about my work at the DIA, if you promise not to tell anyone. Ready? ...Squirrels? THEY SEEM SUSPICIOUS. Must do further RRRresearch. Anyway, what I ordered last time, please.",
    hello3 = "I've been here a few times now. I think I can let you in on another DIA secret: DO. NOT. SNIFF. FIRE. HYDRANTS. I can't tell you why but it's not safe anymore. Can I have my usual?",
    finishedPrompt = "I'm getting urgent messages on my dogphone, are you done?",
    positiveResponse = "My dog bosses at the DIA will be wagging their tails at this service. Thank you.",
    negativeResponse = "Are you a secret agent working for the cats, determined to undermine the work that the DIA does? I hope this doesn't mess up my stakeout today.",
    staying = "",
    farewell = "I have to hurry, time waits for no dog!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[4] = {
    
    name = "Penelope",
    favoriteDrinkId = 4,
    hello1 = "Oh, I'm so busy, can't you get me a puppacino? and quickly! My pups waiting outside want a bone, too.",
    hello2 = "Ah, you know how Honey and Peanut are. They were eyeing up the mailman on my way in. Hope you're not waiting for anything important? Anyway, my previous order was lovely, so I'd like that again, please.",
    hello3 = "I hear that my children have been in to see you. I hope you're not giving them too much espresso! Anyway, the usual, please. Your front yard is such a nice place for the children to play.",
    finishedPrompt = "I think I can see my puppies digging something up outside, oh no, is it done?",
    positiveResponse = "Wonderful, wonderful. Ah, crap. Honey! Peanut! Don't you eat that!",
    negativeResponse = "First my pups won't stop climbing all over me, and now this? I can't deal.",
    staying = "",
    farewell = "Gotta go!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[5] = {
    
    name = "Oskar",
    favoriteDrinkId = 5,
    hello1 = "Ohhhhhhh my gosh! I am so so so jazzed for some coffeeeee! Yip yip yip! I wanna run around in circles! Zoomie coffee for me, please please? And DONUT!",
    hello2 = "Did! You! See! That! Rabbit! Out! Side! Quick quick, same order! Gotta chase, gotta chase! Ruff ruff!",
    hello3 = "Iiiiii couldn't catch the rabbit last time but HE IS BACK and I will get him this time! ArooooOOOO! The usual please! I need to be ready to zoom!",
    finishedPrompt = "Ohboyohboyohboy is it my DRINK?",
    positiveResponse = "YES! I am a good boy! I got a good drink! I got a good snack!",
    negativeResponse = "This isn't what I wanted but IT CAN STILL HELP ME ZOOM!",
    staying = "Time to run in circles around your table while I snack. And while I keep an eye on that RABBIT.",
    farewell = "Wait, what was that outside? Gotta go gotta go! Thank youuuuuOOOooo!",
    sitChoiceOneId = 3,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[6] = {
    
    name = "Buddy",
    favoriteDrinkId = 6,
    hello1 = "Hiya, pardner. Yer talkin' to Buddy. Been playin' fetch a loooong, long while. Come sniffin 'round here for one-a-them fetch latte deals. You got 'em? And an eclair? Don't act like I ain't fancy. Woof woof!",
    hello2 = "Great to see ya, pardner! Been giddy-yuppin' my way all over town, peein' on every phone pole, and fig'red I'd stop by for that same concoction I order'd last, quick as y'can, ma'am.",
    hello3 = "Well, pardner, I must confess, I'm durn pleased you've hung up yer boots here in town. Real good drinks, with real nice people. What more can a good dog ask fer, I wonder? Speakin' of, the usual, please, ma'am",
    finishedPrompt = "Them fire hydrants won't sniff themselves, if ya catch my drift. You done yet?",
    positiveResponse = "Well scratch my ears and call me a kitty! What a hootin' delight, bark bark! Thankee kindly!",
    negativeResponse = "Doggone it, this ain't right. Ah well, a drink's a drink.",
    staying = "Think I'll sniff around here for a spell. Got any good slippers for chewin'? Heh.",
    farewell = "Gotta skedaddle. Bark ya later.",
    sitChoiceOneId = 5,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 4,
    visitedTimes = 0
    
  }
  
  dogInfo[7] = {
    
    name = "Lil Cutie",
    favoriteDrinkId = 7,
    hello1 = "Yip yiiiiip! I am the one, the only, Lil Cutie! I'm on my way to the groomers, and I simply *must* have the sweetest drink on your menu. I can pair it with a donut and put it on dogstagram!",
    hello2 = "Yip yip! Hi again! My dogstagram posts are going BARKING MAD! Can I have that same order again? I might put a lil video on Snif Snof this time!",
    hello3 = "Omg, girl, that Snif Snof video from last time has gotten SO MANY BARKS. I'm basically famous! Thank you so much! To celebrate, my usual, please.",
    finishedPrompt = "My camera's ready, my nails are trimmed, and I've licked my paws. I'm ready, is my drink?",
    positiveResponse = "This drink is so. Fetch. Wonderful, sweetie, just wonderful. Yip yip!",
    negativeResponse = "Um, I'm sorry, but this is definitely not the right order. Maybe it was for some other dog? Anyway, I'll still take it.",
    staying = "The lighting over there is just perfect, I think I'll stay. Don't forget to follow me on DogChat!",
    farewell = "Oh my god, *THE* Fuzzy Fernanda just liked my photo! Gotta run and tell *everyone* I've ever met! Yip yiiiiip!",
    sitChoiceOneId = 4,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[8] = {
    
    name = "T-Rex",
    favoriteDrinkId = 8,
    hello1 = "BORK. REX WANT SPRINKLES JUICE. REX WANT BONE. BORK BORK.",
    hello2 = "BORK. REX HAPPY TO SEE YOU. REX STILL WANT SAME FOOD. REX WILL NOT SLOBBER ON TABLE THIS TIME.",
    hello3 = "BARK. FRIEND TOLD REX IS BARK, NOT BORK. BARK, CAN REX HAVE USUAL STUFFS? REX WILL PROBLY FORGET BARK NOT BORK.",
    finishedPrompt = "AM SO HUNGRY. BORK READY BORK?",
    positiveResponse = "BORK BORK! SO BORK! HAPPY REX!",
    negativeResponse = "OH BORK. NO GOOD. REX SAD.",
    staying = "REX SIT COUCH NOW. REX NOT ACCIDENTlY EAT CUSHION. REX PROMISE. BORK.",
    farewell = "REX CHASE KIDS ON BIKES NOW. BORK BYE!",
    sitChoiceOneId = 4,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[9] = {
    
    name = "Banana",
    favoriteDrinkId = 9,
    hello1 = "Baaaaaark hello! I'm Banana. I am not banana color I just love bananas. I also love BONES! Bones. Barknana. Beautiful. Can I have a bone beverage and bite?",
    hello2 = "Bark bark bark, Barknana here again! Oops, Banana. Barkin' same bev, barkin' same bite, bark?!",
    hello3 = "I was so blissful about coming bark here I almost borgot my banana! Usual bites and bevs, bestie?",
    finishedPrompt = "Didja bring me the drink and snack JUST for Banana??",
    positiveResponse = "Bagnificent! Barvelous! Bantastic! Banana's beloved beverage and bite.",
    negativeResponse = "Banana feels bad because bwrong bev and bite.",
    staying = "Basking in the boffee shop for a bit.",
    farewell = "Banana has to bounce. Bye-bye, bark!",
    sitChoiceOneId = 2,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[10] = {
    
    name = "Rufus",
    favoriteDrinkId = 10,
    hello1 = "Greetings and salutations. Did you know that 200 degrees Fahrenheit is the optimal temperature for brewing coffee? I hope so. I'd like your best coffee, please. 'Bury the Vanilla,' or something. And a cookie as well.",
    hello2 = "Greetings! You know, it's so tough to do math when there are no calculators built for paws. Cheer me up with the same order as last we spoke?",
    hello3 = "Great news from afar! Someone has made a dog calculator, and it's not in an alternate universe, it's right here in this one! I am positively jubilant. My usual, intended for celebration, please.",
    finishedPrompt = "Did you brew it at its optimal temperature? Is it prepared?",
    positiveResponse = "Ahhh, satisfaction. 200 degrees exactly. Marvelous work.",
    negativeResponse = "Something is off. Did you make the coffee at 201 degrees instead? I can tell.",
    staying = "I shall sit and observe further workings of this coffee shop.",
    farewell = "I must go work on my PhD. It's on alternate universes. I believe there are some universes in which dogs cannot talk, let alone do math? Preposterous.",
    sitChoiceOneId = 3,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[11] = {
    
    name = "Dorothy",
    favoriteDrinkId = 11,
    hello1 = "Hello hello hello! I'm Dorothy. The Vanilla Delite sounds, well, delightful, but I absolutely refuse to consume whipped cream, so none of that on there please. A donut, too, thanks.",
    hello2 = "Hello friend-o, bark bark! Dorothy here, but you can totally call me Dottie. Could I just get the very same exact thing again? Also, will there be any other dogs here because I don't think I can handle it. Thanks, woof!",
    hello3 = "Friend-a-rino! Dottie back again for more of the usual!",
    finishedPrompt = "Goody, does that delicious smell mean you have treats for me?!",
    positiveResponse = "AroooooOOOooo! Delicious! Thank you friend!",
    negativeResponse = "Bow-wow, that's not quite what I wanted. But, I still love you! Head pats now please?",
    staying = "",
    farewell = "Actually, oh gosh, I think I see another dog coming. Grrrrrr...ood bye friend!!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[12] = {
    
    name = "Filbert",
    favoriteDrinkId = 12,
    hello1 = "Um... hi? I heard this coffee shop is good? Um, I am scared of coffee though so can I have one without coffee? With some fruit maybe, and milk? But can you add sprinkles? Do you have that on your menu? Oh, and, maybe a donut... um...",
    hello2 = "Er, hello... not to bother you or anything but could I please have the same order? I am still scared of coffee. Why is it so dark? You can't see through it! That is very suspicious and too scary.",
    hello3 = "Good news, um, I found out what is below coffee is just the bottom of the cup. I am, um, a little less scared now. But I still just want my usual, it's, uh, it's really very good!",
    finishedPrompt = "Um, I hate to ask, but is my stuff done yet?",
    positiveResponse = "Oh, wow, you listened to me! I... that doesn't usually happen. Thank you, this is great.",
    negativeResponse = "Oh, that's... this is fine. It maybe isn't what I ordered but that's okay.",
    staying = "",
    farewell = "I have to go, um, thank you again, I... hopetoseeyouagainokaybye!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[13] = {
    
    name = "Honey",
    favoriteDrinkId = 13,
    hello1 = "HELLO! My mommy, um, she said I could have a DRINK FROM YOU and I am, like, SO EXCITED! I would like a Super! Peppy! Puppy! Latte! But mommy says I can't have TOO much coffee so maybe just make it with half as much coffee. And a COOKIE, Arf arf ARF!",
    hello2 = "HI AGAIN! It's Honey again! You remember, the dog?! Mommy said something about bouncing off walls and I wasn't allowed here again but I CAME BACK ANYWAY and really want the same thing so can I please have it?",
    hello3 = "HI I'm HONEY do you remember me?! I think we are friends now, what do you think? Mommy didn't even notice last time I got a drink, heehee, so MORE PLEASE! SAME ONE!",
    finishedPrompt = "Oh boy I am so excited for this! I'm like a real grown dog! Is it ready? Ooooh, tell me tell me tell me! Bark bark!",
    positiveResponse = "Oh wow, this is so good! So tasty, the whipped cream is so good! I love it!!",
    negativeResponse = "Wow, this is what that drink tastes like? I thought it would be different. But that's okay, mommy says I am still learning because I am still a puppy.",
    staying = "",
    farewell = "Ok I am only allowed to be gone for a little bit so I have to go!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  dogInfo[14] = {
    
    name = "Champion",
    favoriteDrinkId = 14,
    hello1 = "Grrruff ruff ruff! Thank you for making your shop so accessible, I lost a paw in Doggy War IV and sometimes these shops have too many steps! I am CHUFFED to be here! What to get, what to get... ah yes, a Puppy-cheeno? But YIP no rawhide please. Maybe vanilla! And a donut. Woofity woof!",
    hello2 = "Ruffy-ruff ruff! So good to see you again. The ol' phantom paw has been acting up, so I really need a pick-me-up, grrrrUFF! Could I have the same order as last time?",
    hello3 = "Grrarrr! Guess what? I've just heard that my prosthetic paw is finally on the way! Let's celebrate! My usual, please! Your shop has cheered up this grrufff old dog so much. Thank you.",
    finishedPrompt = "Your sofa is calling to me, is my drink ready yet?",
    positiveResponse = "Oh wow, so this is what these fancy pupperchinis are like? Hot DOG that's good! Thank you!",
    negativeResponse = "Hmm, I don't get what the big deal is with these pupplecones or whatever. Is this even right? Oh well.",
    staying = "I'm coming, sofa, I'm on my way!",
    farewell = "Agh, I wanted to stay and relax, but looks like the best spot is taken, so I'll just head home.",
    sitChoiceOneId = 4,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 2,
    visitedTimes = 0
    
  }
  
  dogInfo[15] = {
    
    name = "Cinnamon",
    favoriteDrinkId = 15,
    hello1 = "Bark woof! Grrrruff! Ruff bark! Zoobark Coffbark? But wif Double Eswoofo. And a barkbone.",
    hello2 = "Hello, bark bark dimension?? Grrrr dogs can't talk where bark from! Grrrr learning. Same bark.",
    hello3 = "My name is Cinnamon. Friend Rufus has been teaching bark! Grrr... usual? Thank bark!",
    finishedPrompt = "Bark bark done?",
    positiveResponse = "YUMMY! Thank bark.",
    negativeResponse = "Grrrrr.... no. grrrr.",
    staying = "Grr... sofa? Bark!",
    farewell = "Bark later!",
    sitChoiceOneId = 5,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[16] = {
    
    name = "Fart Machine",
    favoriteDrinkId = 16,
    hello1 = "Hi there, welcome to the neighborhood. My name is, ugh, Fart Machine. But PLEASE don't call me that, I do NOT know what my owner was thinking. Grrrrr. Please just call me Frank. I'd like an eclair and a Go Fetch with no sprinkles, please.",
    hello2 = "Thank you so much for calling me Frank! I'm honestly just tired and could use a pick-me-up. The same order, please?",
    hello3 = "So good to see you again! I love this coffee shop, everyone is so nice and nobody calls me Fart Machine. I'll have my usual.",
    finishedPrompt = "Thanks for not calling my name out. Is my order up?",
    positiveResponse = "Oh, lovely! This drink is SO good, and the eclair is so fluffy!",
    negativeResponse = "Not quite right, but at least my order has 'Frank' written on it, right? Right?",
    staying = "Gonna go relax in this lovely quiet room next to that lovely flower.",
    farewell = "Grrrrugh, I guess I should get going. Thanks again.",
    sitChoiceOneId = 1,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 4,
    visitedTimes = 0
    
  }
  
  dogInfo[17] = {
    
    name = "Priscilla",
    favoriteDrinkId = 17,
    hello1 = "My, my, your front lawn is a tad... messy, is it not? Anyway, I'm Priscilla, please do not shorten it. How often do you wipe down your counter, by the way? Can I have your drink with the most ingredients in it? And then add one more shot of espresso, please. And a CLEAN bone. Run along!",
    hello2 = "Hello again, I see your lawn looks... the same! Hmm. Alright, well, what I had last time was adequate, so. That again, please.",
    hello3 = "Hello, it's Priscilla. Well, I suppose your lawn isn't too bad. Has a bit of character, no? I suppose it's overall a positive thing that you opened up here. Can you please give me, erm... my usual?",
    finishedPrompt = "Well, it's been absolutely ages, are you done yet?",
    positiveResponse = "This is the order that I requested. Thank you.",
    negativeResponse = "Well, I shouldn't be surprised, but this is NOT correct. Tsk.",
    staying = "",
    farewell = "I need to pour my drink in a crystal dog bowl before I drink it, so, ta.",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[18] = {
    
    name = "Constance",
    favoriteDrinkId = 18,
    hello1 = "Have you seen those hooligans Peanut and Honey running around? I tell you, if I were their teacher, I would give them such a talking to. What rambunctious little pups. Anyway. Sprinkles and milk and whipped cream, please. Is that a drink? No matter. Oh, also, an eclair sounds lovely.",
    hello2 = "Hello dear, Constance here again. Teaching at the doggergarten is pretty tiring, I tell you. At least Penelope's pups aren't in my class, am I right? Anyway, can I have the same order?",
    hello3 = "Well, it happened! They joined my classroom. Oops, where are my manners? I hope you're well, dear. I need 700 of my usuals, but I'll just have one, please. So happy you are here.",
    finishedPrompt = "My class starts just after the mailman hour, is my order complete?",
    positiveResponse = "A+ work, dear. I will be certain to recommend this place at my next Doggy/Teacher conference.",
    negativeResponse = "Not quite right, is it? No time to wait, so this'll do.",
    staying = "I suppose I can curl up on this nice sofa here for a while.",
    farewell = "The mailman is going past right now, gotta go! Thanks again!",
    sitChoiceOneId = 4,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 4,
    visitedTimes = 0
    
  }
  
  dogInfo[19] = {
    
    name = "Garfield",
    favoriteDrinkId = 19,
    hello1 = "I know, I know. My parents had *such* a great sense of humor, right. Grrugh. Yeah, Garfield is a cat, I get it. Anyway. Can I have what a DOG would order? A bone milk? But add sprinkles? Also a bone. Because I'm a DOG. Ugh.",
    hello2 = "Hi, Garfield again. I'm starting to go by Gary, though, actually! Makes me happier. Still a dog though, heh. Ruff ruff. Can I get the same order?",
    hello3 = "Gary here! The usual, please? I can't wait to come here all the time forever!",
    finishedPrompt = "Grrruff ruff ruff! Ready?!",
    positiveResponse = "Oh wowie-wow! DELIGHTFUL!",
    negativeResponse = "Well this isn't right. What is this, lasagna? Do you think this is funny?",
    staying = "",
    farewell = "Gonna head out now!",
    sitChoiceOneId = 9,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 1,
    visitedTimes = 0
    
  }
  
  dogInfo[20] = {
    
    name = "Mrs. Wiggles",
    favoriteDrinkId = 20,
    hello1 = "Mrs. Wiggles was my mother. So, please, call me Wiggles. Or Wiggly-poo, Wiggle-waggle, Wiggly-doo... my owners have so many odd names for me. I'm kind of unsure about this newfangled coffee nonsense, so can I just have one thing of, hrm, expresso? And a donut, grrruff! I know what that is. Please and thank you, dearie.",
    hello2 = "Oh I'm so glad you're still open, I wasn't sure! Can I have another of the same thing, the stuff I ordered last time? Goodness gracious it was tasty.",
    hello3 = "I might just make this place part of my morning routine, dear! Sniffing grass at the park and then coming here for my usual. Thank you for being here, dearie.",
    finishedPrompt = "Oh, is it ready?",
    positiveResponse = "Golly! What an extraordinary trip for the senses! Bitter yet somehow warming! I love it!",
    negativeResponse = "Oh, so, this is an expresso, huh? Hm. I do not love it. Are you sure?",
    staying = "I will just go ahead and savor this beverage and snack here.",
    farewell = "Must go sniff some grass now.",
    sitChoiceOneId = 1,
    showCupAtSeat = false,
    visitedToday = false,
    pastryWanted = 3,
    visitedTimes = 0
    
  }
  
  
  --TODO - update all seating stuff and fix layering in the dining area
  seating = {}
  
  --purple table back
  seating[1] = 
  {
    
    x = 260,
    y = 485,
    cupX = 270,
    cupY = 510,
    occupied = false
    
  }
  
  --purple table front
  seating[2] = 
  {
    
    x = 368,
    y = 540,
    cupX = 270,
    cupY = 540,
    occupied = false
    
  }
  
  --green table front
  seating[3] = 
  {
    
    x = 648,
    y = 445,
    cupX = 630,
    cupY = 410,
    occupied = false
    
  }
  
  --sofa left
  seating[4] = 
  {
    
    x = 625,
    y = 575,
    cupX = 760,
    cupY = 506,
    occupied = false
    
  }
  
   --sofa right
  seating[5] = 
  {
    
    x = 702,
    y = 580,
    cupX = 790,
    cupY = 518,
    occupied = false
    
  }
  
   --leaving
  seating[9] = 
  {
    
    x = 450,
    y = 1200,
    cupX = 1200,
    cupY = 1200,
    occupied = false
    
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
