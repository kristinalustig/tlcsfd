require "conf"
local P = require "player"
local D = require "dog"
local C = require "coffee"
local GD = require "gameData"
local push = require "push"

function love.load()
  
  math.randomseed(os.time())
  
  textModifier = 1
  
  local gameWidth, gameHeight = 1032, 1032
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  if love.system.getOS() == "Web" then
    windowWidth, windowHeight = 700, 700
  elseif windowHeight >= 1032 then
    windowWidth, windowHeight = 1032, 1032
  else
    windowWidth, windowHeight = 700, 700
    textModifier = .8
  end
  
  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
      fullscreen = false,
      resizable = false,
      pixelperfect = true,
      stretched = true})
  
  gr = love.graphics
  ph = love.physics
  key = love.keyboard
  la = love.audio
  
  randomNum = math.random(10)
  
  -- global variables
  globalTimer = 0
  globalSceneNum = 10
  currentSceneState = 1
  doorOpen = false
  handCursor = love.mouse.getSystemCursor("hand")
  
  --game state - coffee order
  espressoFirst = true
  orderState = 1
  wasOrderGood = false
  currentDog = nil
  currentDogNum = 0
  showCupOnCounter = false
  pastDogs = {}
  possibleHeartNum = 20
  numHearts = 2
  orderUp = false
  pastryOnCounter = nil
  hasPastry = nil
  todaysDogLimit = 500
  
  --daily summary details
  dayNum = 1
  dayDogCount = 0
  dayHeartCount = 0
  dayDogSuccess = 0
  
  --audio
  dayTheme = la.newSource("/audio/day-theme.mp3", "stream")
  nightJingle = la.newSource("/audio/night-jingle.mp3", "stream")
  gameOverTheme = la.newSource("/audio/game-over-theme.mp3", "stream")
  
  bark = la.newSource("/audio/bark.wav", "static")
  doorBell = la.newSource("/audio/door-open.wav", "static")
  errorSound = la.newSource("/audio/error.wav", "static")
  morningFlourish = la.newSource("/audio/morning.mp3", "static")
  popClick = la.newSource("/audio/pop.wav", "static")
  rooster = la.newSource("/audio/rooster.wav", "static")
  successSound = la.newSource("/audio/success.wav", "static")
  
  --fonts
  testFont = gr.newFont(10)
  orderSlipPrintFont = gr.newFont("/fonts/BreeSerif-Regular.ttf", 20) -- only for the serif text @ top of order
  handwritingFont = gr.newFont("/fonts/Caveat-Medium.ttf", 25) -- only for order slip handwriting
  menuHeaderFont = gr.newFont("/fonts/ArimaMadurai-Black.ttf", 30)
  introHeaderFont = gr.newFont("/fonts/Quicksand-Bold.ttf", 40)
  introContentFont = gr.newFont("/fonts/Mali-Regular.ttf", 25)
  menuContentFont = gr.newFont("/fonts/Quicksand-Regular.ttf", 20)
  hintFont = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 30) -- only for places where UI gives user instructions
  hintFontMod = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 30*textModifier)
  hintFontSm = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 20) -- smaller instructions
  hintFontXSm = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 14) -- even smaller instructions
  overheadFont = gr.newFont("/fonts/Quicksand-Bold.ttf", 20) -- for E prompts
  dogFontSize = 24
  dogFonts = {}
  dogFonts[1] = gr.newFont("/fonts/Quicksand-Regular.ttf", dogFontSize)
  dogFonts[2] = gr.newFont("/fonts/Courgette-Regular.ttf", dogFontSize)
  dogFonts[3] = gr.newFont("/fonts/SpecialElite-Regular.ttf", dogFontSize)
  dogFonts[4] = gr.newFont("/fonts/Kalam-Regular.ttf", dogFontSize)
  dogFonts[5] = gr.newFont("/fonts/Dangrek-Regular.ttf", dogFontSize)
  dogFonts[6] = gr.newFont("/fonts/ComingSoon-Regular.ttf", dogFontSize)
  dogFonts[7] = gr.newFont("/fonts/MarckScript-Regular.ttf", dogFontSize)
  dogFonts[8] = gr.newFont("/fonts/PermanentMarker-Regular.ttf", dogFontSize)
  dogFonts[9] = gr.newFont("/fonts/PatrickHand-Regular.ttf", dogFontSize)
  dogFonts[10] = gr.newFont("/fonts/CutiveMono-Regular.ttf", dogFontSize)
  dogFonts[11] = dogFonts[2]
  dogFonts[12] = dogFonts[4]
  dogFonts[13] = dogFonts[5]
  dogFonts[14] = dogFonts[10]
  dogFonts[15] = dogFonts[8]
  dogFonts[16] = dogFonts[9]
  dogFonts[17] = dogFonts[7]
  dogFonts[18] = dogFonts[1]
  dogFonts[19] = dogFonts[3]
  dogFonts[20] = dogFonts[6]
  playerVoiceFont = gr.newFont("/fonts/Mali-Regular.ttf", 30) -- font for player's speech
  dayFont = gr.newImageFont("/fonts/dayFont.png", "1234567") -- font for day counter
  
  -- load static assets for main area
  background = gr.newImage("/assets/background.png")
  nightBackground = gr.newImage("/assets/nightBackground.png")
  
  
  --animated background stuff
  mushRedImg = gr.newImage("/assets/mush1.png")
  mushSprite = {
    cadence = 200,
    currentFrameNum = 1,
    maxFrameNum = 4
    }
  mushSprite[1] = gr.newQuad(0, 0, 116, 68, mushRedImg)
  mushSprite[2] = gr.newQuad(116, 0, 116, 68, mushRedImg)
  mushSprite[3] = gr.newQuad(232, 0, 116, 68, mushRedImg)
  mushSprite[4] = gr.newQuad(348, 0, 116, 68, mushRedImg)
  mushWhiteImg = gr.newImage("/assets/mush2.png")
  mushSprite2 = {
    cadence = 140,
    currentFrameNum = 1,
    maxFrameNum = 4
  }
  mushSprite2[1] = gr.newQuad(0, 0, 56, 28, mushWhiteImg)
  mushSprite2[2] = gr.newQuad(56, 0, 56, 28, mushWhiteImg)
  mushSprite2[3] = gr.newQuad(112, 0, 56, 28, mushWhiteImg)
  mushSprite2[4] = gr.newQuad(168, 0, 56, 28, mushWhiteImg)
  pumpkinImg = gr.newImage("/assets/pumpkin.png")
  pumpkin = {
    cadence = 40,
    currentFrameNum = 1,
    maxFrameNum = 4
  }
  pumpkin[1] = gr.newQuad(0, 0, 68, 60, pumpkinImg)
  pumpkin[2] = gr.newQuad(68, 0, 68, 60, pumpkinImg)
  pumpkin[3] = gr.newQuad(136, 0, 68, 60, pumpkinImg)
  pumpkin[4] = gr.newQuad(204, 0, 68, 60, pumpkinImg)
  
  finishedCoffeeImg = gr.newImage("/assets/finishedCoffee.png")
  finishedCoffee = {
    cadence = 10,
    currentFrameNum = 1,
    maxFrameNum = 6
  }
  finishedCoffee[1] = gr.newQuad(0, 0, 36, 60, finishedCoffeeImg)
  finishedCoffee[2] = gr.newQuad(36, 0, 36, 60, finishedCoffeeImg)
  finishedCoffee[3] = gr.newQuad(72, 0, 36, 60, finishedCoffeeImg)
  finishedCoffee[4] = gr.newQuad(108, 0, 36, 60, finishedCoffeeImg)
  finishedCoffee[5] = gr.newQuad(144, 0, 36, 60, finishedCoffeeImg)
  finishedCoffee[6] = gr.newQuad(180, 0, 36, 60, finishedCoffeeImg)
  
  
  chatBackground = gr.newImage("/assets/chat-bg.png")
  heartEmpty = gr.newImage("/assets/heart-empty.png")
  heartFull = gr.newImage("/assets/heart-full.png")
  heartHalf = gr.newImage("/assets/heart-half.png")
  
  counter = gr.newImage("/assets/furniture/counter.png")
  tablePurpleImg = gr.newImage("/assets/furniture/table-purple.png")
  tableGreenImg = gr.newImage("/assets/furniture/table-green.png")
  sofaImg = gr.newImage("/assets/furniture/sofa.png")
  doorImg = gr.newImage("/assets/furniture/door.png")
  
  menuBackground = gr.newImage("/assets/menu-bg.png")
  
  
  -- load assets for brew scene
  brewBackground = gr.newImage("/assets/brew/brew-bg.png")
  orderSlip = gr.newImage("/assets/brew/orderslip.png")
  emptyCup = gr.newImage("/assets/brew/emptycup.png")
  
  drinkIngredients = {}
    drinkIngredients[1] = C.new(1, "/assets/brew/oneshot.png", "shotOne")
    drinkIngredients[2] = C.new(2, "/assets/brew/twoshot.png", "shotTwo")
    drinkIngredients[3] = C.new(3, "/assets/brew/justmilk.png", "milk")
    drinkIngredients[4] = C.new(4, "/assets/brew/latte.png", "latte")
    drinkIngredients[5] = C.new(5, "/assets/brew/latteart.png", "art")
    drinkIngredients[6] = C.new(6, "/assets/brew/whippedcream.png", "whip")
    drinkIngredients[7] = C.new(7, "/assets/brew/sprinkles.png", "sprinkles")
    drinkIngredients[8] = C.new(8, "/assets/brew/vanilla.png", "vanilla")
    drinkIngredients[9] = C.new(9, "/assets/brew/caramel.png", "caramel")
    drinkIngredients[10] = C.new(10, "/assets/brew/raspberry.png", "raspberry")
    drinkIngredients[11] = C.new(11, "/assets/brew/rawhide.png", "rawhide")
  
  -- load consumables
  boneImg = gr.newImage("/assets/bone.png")
  donutImg = gr.newImage("/assets/donut.png")
  cookieImg = gr.newImage("/assets/cookie.png")
  eclairImg = gr.newImage("/assets/eclair.png")
  
  numBones = 2
  numDonuts = 4
  numCookies = 4
  numEclairs = 2
  
  -- load player and npcs
  player = P.new()
  dogs = {
    dog1 = D.new(1),
    dog2 = D.new(2),
    dog3 = D.new(3),
    dog4 = D.new(4),
    dog5 = D.new(5),
    dog6 = D.new(6),
    dog7 = D.new(7),
    dog8 = D.new(8),
    dog9 = D.new(9),
    dog10 = D.new(10),
    dog11 = D.new(11),
    dog12 = D.new(12),
    dog13 = D.new(13),
    dog14 = D.new(14),
    dog15 = D.new(15),
    dog16 = D.new(16),
    dog17 = D.new(17),
    dog18 = D.new(18),
    dog19 = D.new(19),
    dog20 = D.new(20)
  }
  
  -- load ui
  dayLabel = gr.newImage("/assets/ui/day-label.png")
  credits = gr.newImage("/assets/ui/credits.png")
  title = gr.newImage("/assets/ui/title.png")
  created = gr.newImage("/assets/ui/createdcard.png")
  storySoFar = gr.newImage("/assets/ui/storysofar.png")
  directions = gr.newImage("/assets/ui/directions.png")
  gameOverNeutral = gr.newImage("/assets/ui/gameoverneutral.png")
  gameOverLoss = gr.newImage("/assets/ui/gameoverloss.png")
  gameOverWin = gr.newImage("/assets/ui/gameoverwin.png")
  
  keyPrompt = gr.newImage("/assets/ui/keyprompt-e.png")
  keyPromptBone = gr.newImage("/assets/ui/keyprompt-e-bone.png")
  keyPromptEclair = gr.newImage("/assets/ui/keyprompt-e-eclair.png")
  keyPromptDonut = gr.newImage("/assets/ui/keyprompt-e-donut.png")
  keyPromptCookie = gr.newImage("/assets/ui/keyprompt-e-cookie.png")
  
  GD.initialize()
  
end


function love.update(dt)
  
  if globalSceneNum >=10 or globalSceneNum == 1 and not dayTheme:isPlaying() then
    dayTheme:setLooping(true)
    dayTheme:play()
  end
  
  --the end
  if numHearts == possibleHeartNum then
    dayTheme:stop()
    if not gameOverTheme:isPlaying() then 
      gameOverTheme:setLooping(false)
      gameOverTheme:play() end
    globalSceneNum = 8
  elseif numHearts < 0 then
    dayTheme:stop()
    if not gameOverTheme:isPlaying() then 
      gameOverTheme:setLooping(false)
      gameOverTheme:play() end
    globalSceneNum = 5
  elseif dayNum == 8 then
    dayTheme:stop()
    if not gameOverTheme:isPlaying() then 
      gameOverTheme:setLooping(false)
      gameOverTheme:play() end
    globalSceneNum = 6
  end
  
  --if we hit the max count then stop and set the scene to 7
  if dayDogCount > todaysDogLimit and numHearts >= 0 and numHearts ~= possibleHeartNum then
    dayTheme:stop()
    errorSound:stop()
    if not nightJingle:isPlaying() then
      nightJingle:setLooping(false)
      nightJingle:play() 
    end
    globalSceneNum = 7
    return
  else
    if currentDogNum == 0 and globalSceneNum ~= 7 then
      if globalSceneNum == 1 then
        nightJingle:stop()
        if dayDogCount == 0 then
          morningFlourish:play()
          rooster:setVolume(.3)
          rooster:play()
        end
      end
      if not dayTheme:isPlaying() then
        dayTheme:play()
      end
      if dayDogCount == 0 then
        todaysDogLimit = 3
        findNewCurrentDog()
      else
        findNewCurrentDog()
      end
      
    end
    
    globalTimer = globalTimer + 1
    
    --calculations for obj animations
    mushSprite.currentFrameNum = getCurrentObjFrame(mushSprite, globalTimer)
    mushSprite2.currentFrameNum = getCurrentObjFrame(mushSprite2, globalTimer)
    pumpkin.currentFrameNum = getCurrentObjFrame(pumpkin, globalTimer)
    finishedCoffee.currentFrameNum = getCurrentObjFrame(finishedCoffee, globalTimer)
    
    --calculations for dog animations
    currentDog.currFrameNum = D.getCurrentFrame(currentDog, globalTimer)
    D.moveDog(currentDog)
    
     for k, v in pairs(pastDogs) do
      v.currFrameNum = D.getCurrentFrame(v, globalTimer)
      D.moveDog(v)
    end
    
    if orderState == 3 then
      -- check orders against each other here!
      wasOrderGood = testOrder(coffeeDrinks[dogInfo[currentDog.dogNum].favoriteDrinkId], dogInfo[currentDogNum].pastryWanted)
        
    end
  end
  
  
  
end


function love.draw()
  
  push:start()
  
  --------INTRO CREDIT PAGE 1
  if globalSceneNum == 10 then
    --title page
    gr.draw(title, 0, 0)
    gr.setFont(hintFont)
    gr.printf("Press any key to continue", 0, 972, 1032, "center")
    
  --------INTRO CREDIT PAGE 2
  elseif globalSceneNum == 11 then
    --by kristina
    gr.draw(credits, 0, 0)
    gr.printf("Press any key to continue", 0, 972, 1032, "center")
  
  --------INTRO CREDIT PAGE 3
  elseif globalSceneNum == 12 then
    --created for jam
     gr.draw(created, 0, 0)
     gr.printf("Press any key to continue", 0, 972, 1032, "center")
  
  ---------INTRO CREDIT PAGE 4
  elseif globalSceneNum == 13 then
    --set the scene
    gr.draw(storySoFar, 0, 0)
    gr.setFont(introHeaderFont)
    gr.printf("This is you. Hello!", 340, 240, 500, "left")
    gr.setFont(introContentFont)
    gr.printf("Congrats! After saving for years, you've finally gone and opened up your own coffee shop for dogs. They said you couldn't do it, but here you are! Great work.", 100, 400, 800, "left")
    
    gr.printf("Your main goal right now is to get to know your customers. Learn their orders, make them correctly, and you could become an institution in this town. You can do it! I believe in you!", 100, 550, 800, "left")
    
    gr.setFont(hintFont)
    gr.setColor(1, 1, 1)
    gr.printf("Press any key to continue", 0, 972, 1032, "center")
    
  --------INTRO CREDIT PAGE 5
  elseif globalSceneNum == 14 then
    --instructions
    gr.draw(directions, 0, 0)
    
    gr.setFont(introHeaderFont)
    gr.printf("How to play:", 0, 200, 1032, "center")
    gr.setFont(hintFontMod)
    gr.printf("- Control your avatar with  W A S D", 100, 300, 800, "left")
    gr.printf("- Interact with objects by following on-screen prompts", 100, 360, 800, "left")
    gr.printf("- The only time you'll use your mouse is while you're brewing coffee.", 100, 420, 800, "left")
    gr.printf("Max out your heart-o-meter by the end of one week by listening closely, remembering orders, and then getting them right. There are no time limits, so take your time! If the heart-o-meter drops below zero, game over.", 100, 580, 800, "left")
    
    gr.setFont(hintFont)
    gr.setColor(1, 1, 1)
    gr.printf("Press any key to continue", 0, 972, 1032, "center")
    
  -------INTRO CREDIT PAGE 6  
  elseif globalSceneNum == 15 then
    gr.draw(directions, 0, 0)
    
    gr.setFont(introHeaderFont)
    gr.printf("One more thing...", 100, 200, 800, "center")
    gr.setFont(hintFontMod)
    gr.printf("Dogs will pretty quickly establish a 'usual' drink. Make sure you remember what their order is! Writing it down might help.", 100, 300, 800, "center")
    gr.printf("Three dogs will visit per day - I think I see one now! GOOD LUCK!", 100, 580, 800, "center")
    gr.printf("Press any key to start", 0, 972, 1032, "center")
  
  ---------HELP PAGE
  elseif globalSceneNum == 99 then
    gr.draw(directions, 0, 0)
    gr.setFont(introHeaderFont)
    gr.printf("How to play:", 0, 200, 1032, "center")
    gr.setFont(hintFontMod)
    gr.printf("- Control your avatar with  W A S D", 100, 300, 800, "left")
    gr.printf("- Interact with objects by following on-screen prompts", 100, 360, 800, "left")
    gr.printf("- The only time you'll use your mouse is while you're brewing coffee.", 100, 420, 800, "left")
    gr.printf("Max out your heart-o-meter by the end of one week by listening to orders carefully, remembering regulars, and fulfilling the orders correctly. If the heart-o-meter drops below zero, game over.", 100, 580, 800, "left")
    
    gr.setFont(hintFont)
    gr.setColor(1, 1, 1)
    gr.printf("Press any key to continue", 0, 972, 1032, "center")
  
  -----EARLY GAME OVER
  elseif globalSceneNum == 5 then
    --ran outta hearts
    gr.draw(gameOverLoss, 0, 0)
    gr.setFont(menuHeaderFont)
    gr.printf("You ran out of hearts! It's okay, your dog friends love you anyway. Maybe you could give the shop another try someday. If you want to play again to get a different ending, please close and reopen the game.", 100, 440, 800, "center")
    gr.setFont(menuContentFont)
    gr.printf("Thank you so much for playing my game, I spent a lot of time on it! All art, music, and code made by me, Kristina. Sound effects from FreeSound.org, please find the extended credits on this game's itch.io page. Have a lovely day!", 100, 700, 800, "center")
    
  -----EARLY GAME OVER - WIN!
  elseif globalSceneNum == 8 then
      --maxed out hearts
    gr.draw(gameOverWin, 0, 0)
    gr.setColor(love.math.colorFromBytes(74, 55, 120))
    gr.setFont(menuHeaderFont)
    gr.printf("In less than a week's time, you won the hearts and minds of the neighborhood pups. They love you and are so proud of you. Wonderful work. If you want to play again to get a different ending, please close and reopen the game.", 100, 340, 800, "center")
    gr.setFont(menuContentFont)
    gr.printf("Thank you so much for playing my game, I spent a lot of time on it! All art, music, and code made by me, Kristina. Sound effects from FreeSound.org, please find the extended credits on this game's itch.io page. Have a lovely day!", 100, 600, 800, "center")
  
  -----------GAME OVER - NEUTRAL!
  elseif globalSceneNum == 6 then
    --finished the week
    gr.draw(gameOverNeutral, 0, 0)
    drawHearts(150, 300)

    gr.setFont(menuHeaderFont)
    gr.printf("You made it an entire week! Great work - you're well on your way to winning over every pup in town. If you want to play again to get a different ending, please close and reopen the game.", 100, 440, 800, "center")
    gr.setFont(menuContentFont)
    gr.printf("Thank you so much for playing my game, I spent a lot of time on it! All art, music, and code made by me, Kristina. Sound effects from FreeSound.org, please find the extended credits on this game's itch.io page. Have a lovely day!", 100, 700, 800, "center")
  
  
  -------END OF DAY
  elseif globalSceneNum == 7 then
    gr.draw(nightBackground, 0, 0)
    gr.setFont(menuHeaderFont)
    gr.printf("End of day summary:", 0, 300, 946, "center")
    gr.printf("Dogs served: "..dayDogCount-1, 0, 400, 946, "center") 
    gr.printf("Hearts earned (net): "..dayHeartCount, 0, 450, 946, "center") 
    gr.printf("Slobber marks cleaned off tables: "..randomNum*5, 0, 500, 946, "center")
    gr.printf("Head pats given: "..randomNum*11, 0, 550, 946, "center")
    gr.printf("Press 'T' to start tomorrow!", 0, 650, 946, "center")
  
  
  -----CAFE
  elseif globalSceneNum == 1 then

    if currentSceneState == 1 or currentSceneState == 4 then
      
      gr.draw(background, 0, 0)
      
      gr.draw(dayLabel, 100, 20)
      gr.setFont(dayFont)
      gr.printf(dayNum, 260, 24, 50, "left")
      
      drawHearts(300, 30)
      
      P.checkMovement(player)
      gr.draw(player.sheet, player.currImg, player.x, player.y)
      if hasPastry then
        gr.draw(snacks[hasPastry].img, player.x+30, player.y + 50)
      end
      gr.draw(counter, 210, 320)
      
      if pastryOnCounter then
        gr.draw(snacks[pastryOnCounter].img, 442, 343)
      end
      
      
      gr.draw(sofaImg, 590, 500)
      
      for i=1, numBones do
        gr.draw(boneImg, 506, 350 - (10*i))
      end
      
      for i=1, numDonuts do
        if i<=2 then
          gr.draw(donutImg, 598, 348 - (10*i))
        else
          gr.draw(donutImg, 631, 348 - (10*(i-2)))
        end
      end
      
      for i=1, numCookies do
        if i<= 2 then
          gr.draw(cookieImg, 675, 358 - (10*i))
        else
          gr.draw(cookieImg, 700, 358 - (10*(i-2)))
        end
        
      end
      
      for i=1, numEclairs do
        gr.draw(eclairImg, 750, 360 - (10*i))
      end
    
      if doorOpen == false then
        gr.draw(doorImg, 460, 680)
      end
    
      gr.draw(mushRedImg, mushSprite[mushSprite.currentFrameNum], 710, 790)
      gr.draw(mushWhiteImg, mushSprite2[mushSprite2.currentFrameNum], 265, 782)
      gr.draw(pumpkinImg, pumpkin[pumpkin.currentFrameNum], 218, 324)
      
      gr.draw(currentDog.sheet, currentDog.frames[currentDog.currFrameNum], currentDog.x, currentDog.y)
      
      for k, v in pairs(pastDogs) do
        if dogInfo[v.dogNum].sitChoiceOneId ~=2 and dogInfo[v.dogNum].sitChoiceOneId ~=3 then
          gr.draw(v.sheet, v.frames[v.currFrameNum], v.x, v.y)
        end
      end
    
      showOverheadPromptsBasedOnLocation()
      
      for k, v in pairs(pastDogs) do
        if dogInfo[v.dogNum].showCupAtSeat == true and dogInfo[v.dogNum].sitChoiceOneId ~=2 then
          gr.draw(finishedCoffeeImg, finishedCoffee[finishedCoffee.currentFrameNum], seating[dogInfo[v.dogNum].sitChoiceOneId].cupX, seating[dogInfo[v.dogNum].sitChoiceOneId].cupY-20)
        end
      end
      
      gr.draw(tablePurpleImg, 240, 510)
      gr.draw(tableGreenImg, 600, 400)
      
      for k, v in pairs(pastDogs) do
        if dogInfo[v.dogNum].sitChoiceOneId ==2 or dogInfo[v.dogNum].sitChoiceOneId ==3 then
          gr.draw(v.sheet, v.frames[v.currFrameNum], v.x, v.y)
        end
      end
      
      for k, v in pairs(pastDogs) do
        if dogInfo[v.dogNum].showCupAtSeat == true then
          gr.draw(finishedCoffeeImg, finishedCoffee[finishedCoffee.currentFrameNum], seating[dogInfo[v.dogNum].sitChoiceOneId].cupX, seating[dogInfo[v.dogNum].sitChoiceOneId].cupY-20)
        end
      end
    
      
      if showCupOnCounter == true then
        gr.draw(finishedCoffeeImg, finishedCoffee[finishedCoffee.currentFrameNum], 420, 328)
      end
      
    elseif currentSceneState == 2 then
      gr.draw(brewBackground, 0, 0)
      gr.draw(dayLabel, 100, 20)
      gr.setFont(dayFont)
      gr.printf(dayNum, 260, 24, 50, "left")
      for i=1, numHearts do
        gr.draw(heartFull, 300 + (58*i), 30)
      end
      for i=numHearts+1, 10 do
        gr.draw(heartEmpty, 300 + (58*i), 30)
      end
      
      gr.draw(orderSlip, 360, 708)
      gr.draw(emptyCup, 278, 250)
      
      --TODO: if there's an order up
      if orderUp == true then
        gr.setFont(orderSlipPrintFont)
        gr.setColor(love.math.colorFromBytes(158, 32, 129))
        gr.printf("ORDER SLIP", 370, 718, 230, "center")
        gr.setFont(handwritingFont)
        gr.setColor(0, 0, 0, 1)
        if dogInfo[currentDogNum].visitedTimes == 0 then
          gr.printf("- "..coffeeDrinks[dogInfo[currentDogNum].favoriteDrinkId].name, 390, 750, 230, "left")
          gr.printf("- "..snacks[dogInfo[currentDogNum].pastryWanted].name, 390, 810, 224, "left")
        else
          gr.printf("what's "..dogInfo[currentDogNum].name .. "'s usual?", 390, 750, 224, "left")
        end
      else
        gr.printf("No orders right now", 380, 740, 224, "center")
      end
      
      C.showDrinkIngredientsIfSelected()
      
      C.showBrewPromptsBasedOnMouseLocation()
      
      
    elseif currentSceneState == 3 then
      
      gr.draw(menuBackground, 0, 0)
      gr.setFont(menuHeaderFont)
      --drink 1
      local menuCol = 188
      local secondCol = 0
      for i=1, 10 do
        if i > 5 then
          menuCol = 600
          secondCol = 800
        end
        gr.setColor(love.math.colorFromBytes(173, 130, 207)) -- light purple
        gr.printf(coffeeDrinks[i].name, menuCol, 110 + (160*(i-1) - secondCol), 400, "left")
        gr.setColor(love.math.colorFromBytes(255, 216, 169)) -- light yellow
        gr.setFont(menuContentFont)
        gr.printf(coffeeDrinks[i].description, menuCol, 152 + (160*(i-1) - secondCol), 360, "left")
        gr.setColor(love.math.colorFromBytes(255, 179, 102)) -- yellow
        gr.setFont(menuHeaderFont)
        if i % 5 ~= 0 then
          gr.printf(" * ~ * ~ * ~ * ~ * ~ *", menuCol, 220 + (160*(i-1) - secondCol), 350, "center")
        end
        
      end
      
      gr.setFont(menuContentFont)
      gr.printf("super coffee tip: 'latte' drinks always have milk in them!", 50, 890, 1032, "center")
      gr.setColor(1, 1, 1)
      gr.setFont(hintFontSm)
      gr.printf("('esc' or 'e' to leave)", 0, 950, 1032, "center")
      
    end
    
    if currentSceneState == 4 then
      
      dogFont = dogFonts[currentDogNum]
      
      gr.draw(chatBackground, 0, 0)
      gr.draw(player.sheet, player.currImg, 760, 540)
      if orderState >= 3 then
        if wasOrderGood then
          gr.draw(currentDog.chatSheet, currentDog.chatHappy, 126, 280)
        else
          gr.draw(currentDog.chatSheet, currentDog.chatSad, 126, 280)
        end
      else
        gr.draw(currentDog.chatSheet, currentDog.chatHappy, 126, 280)
      end
      gr.setFont(hintFont)
      gr.printf(dogInfo[currentDogNum].name, 120, 426, 172, "center")
      gr.printf("You", 738, 470, 180, "center")
      
      --not started
      if orderState == 1 then
        gr.setFont(dogFont)
        if dogInfo[currentDogNum].visitedTimes == 0 then
          gr.printf(dogInfo[currentDogNum].hello1, 316, 250, 598, "left")
          gr.setFont(playerVoiceFont)
          gr.printf("Thanks for visiting my new shop. Coming right up!", 125, 500, 580, "left")
        elseif dogInfo[currentDogNum].visitedTimes == 1 then
          gr.printf(dogInfo[currentDogNum].hello2, 316, 250, 598, "left")
          gr.setFont(playerVoiceFont)
          gr.printf("So glad you came back! I'll have it ready in a jiffy.", 125, 500, 580, "left")
        else
          gr.printf(dogInfo[currentDogNum].hello3, 316, 250, 598, "left")
          gr.setFont(playerVoiceFont)
          gr.printf("You're sort of a regular now, huh? Your usual will be ready in just a moment.", 125, 500, 580, "left")
        end
        gr.setFont(hintFont)
        gr.printf("(Press 'E' to continue)", 98, 660, 832, "center")
        
      --in progress  
    elseif orderState == 2 then
        gr.setFont(dogFont)
        gr.printf(dogInfo[currentDogNum].finishedPrompt, 316, 250, 598, "left")
        gr.setFont(hintFont)
        gr.printf("'Y' for yes, 'N' for no", 98, 560, 832, "center")
        
      --finished  
    elseif orderState == 3 then
      gr.setFont(dogFont)
      if wasOrderGood then
        gr.printf(dogInfo[currentDogNum].positiveResponse, 316, 250, 598, "left")
        gr.setFont(playerVoiceFont)
        gr.printf("Enjoy your treat! Good dog.", 125, 500, 580, "left")
      else
        gr.printf(dogInfo[currentDogNum].negativeResponse, 316, 250, 598, "left")
        gr.setFont(playerVoiceFont)
        gr.printf("Oh no, I'm sorry. I'll get it right next time.", 125, 500, 580, "left")
      end
      gr.setFont(hintFont)
      gr.printf("(Press 'E' to continue)", 98, 660, 832, "center")
      --farewell  
    elseif orderState == 4 then  
        gr.setFont(dogFont)
        if currentDog.isStayingToday == true then
          gr.printf(dogInfo[currentDogNum].staying, 316, 250, 598, "left")
        else
          gr.printf(dogInfo[currentDogNum].farewell, 316, 250, 598, "left")
        end
        gr.setFont(playerVoiceFont)
        gr.printf("Come back again soon!", 125, 500, 580, "left")
        gr.setFont(hintFont)
        gr.printf("('E' to end conversation)", 98, 660, 832, "center")
      end
      
    end
    
    gr.setFont(hintFontSm)
    gr.printf("Press 'h' to see instructions", 0, 990, 1032, "center")
  end

  push:finish()

end


-- adds a lil hop to a walking entity - dogs or player. returns value to bobble
function walkBobble(obj)
  if obj.atBottomOfStep == true and obj.stepCount == 8 then
    
    obj.atBottomOfStep = false
    obj.stepCount = 0
    return 2
  elseif obj.atBottomOfStep == false and obj.stepCount == 8 then
    obj.atBottomOfStep = true
    obj.stepCount = 0
    return -2
  else
    obj.stepCount = obj.stepCount + 1
    return 0
  end
end


function endDay()
  
  --reset random num
  randomNum = math.random(10)

  --reset dog count
  dayDogCount = 0
  
  --remove dogs from pastDogs
  pastDogs = {}
  
  --reset dog's visitedToday
  for k, v in pairs(dogInfo) do
    v.visitedToday = false
  end
  
  --reset seating occupied status
  for k, v in pairs(seating) do
    v.occupied = false
  end
  
  --reset dogs x and y info
  for k, v in pairs(dogs) do
    v.x = v.originalX
    v.y = v.originalY
    v.destinationX = v.originalDestX
    v.destinationY = v.originalDestY
    v.isMoving = true
  end
    
  
  --add one to dayNum
  dayNum = dayNum + 1
  
  dayHeartCount = 0
  
  globalSceneNum = 1
  
  currentDogNum = 0
  
end


-- return correct index for any animated non-npc sprite
function getCurrentObjFrame(obj, t)
  if (t % obj.cadence == 0) then
    if obj.currentFrameNum == obj.maxFrameNum then
      obj.currentFrameNum = 1
      if obj.cadence ~= finishedCoffee.cadence then
        obj.cadence = obj.cadence * 5
      end
    else
      obj.currentFrameNum = obj.currentFrameNum + 1
      if obj.currentFrameNum == 2 then
        if obj.cadence ~= finishedCoffee.cadence then
          obj.cadence = obj.cadence / 5
        end
      end
    end
  end
  return obj.currentFrameNum
end




function love.keypressed(key, scancode, isrepeat)
  
  if globalSceneNum >= 10 and globalSceneNum < 15 then
    globalSceneNum = globalSceneNum + 1
  elseif globalSceneNum == 15 then
    globalSceneNum = 1
    morningFlourish:play()
    rooster:setVolume(.3)
    rooster:play()
  elseif globalSceneNum == 99 then
    globalSceneNum = 1
  else

    if key == "e" and currentSceneState ~= 4 then
      changeSceneState()
      return
    end
    
    if key == "t" and globalSceneNum == 7 then
      endDay()
      return
    end
    
    if key == "h" then
      globalSceneNum = 99
      return
    end

    
    if key == "escape" and not isrepeat then
      if currentSceneState == 2 or currentSceneState == 3 then
        currentSceneState = 1
        return
      end
    end
    
    if key == "e" and not isrepeat then
      if currentSceneState == 4 then
        if orderState == 1 then
          orderState = orderState + 1
          currentSceneState = 1
        elseif orderState == 3 then
          orderState = orderState + 1
        elseif orderState == 4 then
          if wasOrderGood == true then
            --successSound:play()
            numHearts = numHearts + 1
            dayHeartCount = dayHeartCount + 1
          else
            --errorSound:play()
            numHearts = numHearts - 1
            dayHeartCount = dayHeartCount - 1
          end
          orderState = 1
          pastryOnCounter = nil
          hasPastry = nil
          orderUp = false
          wasOrderGood = false
          currentSceneState = 1
          showCupOnCounter = false
          if seating[dogInfo[currentDogNum].sitChoiceOneId].occupied == true then
            currentDog.isStayingToday = false
            currentDog.destinationX = seating[9].x
            currentDog.destinationY = seating[9].y
          else
            if dogInfo[currentDogNum].sitChoiceOneId ~= 9 then
              seating[dogInfo[currentDogNum].sitChoiceOneId].occupied = true
            end
            currentDog.destinationX = seating[dogInfo[currentDogNum].sitChoiceOneId].x
            currentDog.destinationY = seating[dogInfo[currentDogNum].sitChoiceOneId].y
          end
          currentDog.isMoving = true
          dogInfo[currentDogNum].showCupAtSeat = true
          dogInfo[currentDogNum].visitedTimes = dogInfo[currentDogNum].visitedTimes + 1
          table.insert(pastDogs, currentDog)
          for k, v in pairs(drinkIngredients) do
            v.isInDrink = false
          end
          currentDog = nil
          currentDogNum = 0
          if dayDogCount > todaysDogLimit then 
            globalSceneNum = 7 
          end
        end
      end
    end
    
    if key == "y" and not isrepeat then
      if currentSceneState == 4 and orderState == 2 then
        if testOrder(coffeeDrinks[dogInfo[currentDog.dogNum].favoriteDrinkId], dogInfo[currentDogNum].pastryWanted) == true then
          successSound:play()
        else
          errorSound:play()
        end
        orderState = 3
      end
    end
    
    if key == "n" and not isrepeat then
      if currentSceneState == 4 and orderState == 2 then
        currentSceneState = 1
      end
    end
  end

end

function findNewCurrentDog()
  if dayDogCount > todaysDogLimit then return false end
  local foundDog = false
  local tries = 0
  while foundDog == false and tries < 10 do
    local rand = math.random(20)
    if dogInfo[rand].visitedToday == false and dogInfo[rand].visitedTimes < 3 then
      currentDogNum = rand
      currentDog = dogs["dog"..currentDogNum]
      dogInfo[currentDogNum].visitedToday = true
      if seating[dogInfo[currentDogNum].sitChoiceOneId].occupied == true or dogInfo[currentDogNum].sitChoiceOneId == 9 then
        currentDog.isStayingToday = false
      else
        currentDog.isStayingToday = true
      end
      foundDog = true
      dayDogCount = dayDogCount + 1
    else
      tries = tries + 1
    end
  end
  return true
    
end



function changeSceneState()
  
 if currentSceneState == 3 then
   currentSceneState = 1
   return
 elseif currentSceneState == 2 then
   currentSceneState = 1
   return
 end
  
  local x = player.x
  local y = player.y
  local pastry = P.isNearPastry(x, y)
  
  --brew UI (even when there's no active request)
  if P.isNearBrewTable(x, y) == true then
    currentSceneState = 2
  --menu UI (even when there's no active request)
  elseif P.isNearMenu(x, y) == true then
    currentSceneState = 3
  --chat UI (only when there's a dog there)
  elseif P.isNearDog(x, y) == true then
    if hasPastry then
      pastryOnCounter = hasPastry
      hasPastry = nil
    else
      if currentSceneState ~= 4 then bark:play() end
      currentSceneState = 4
    end
  --pick up pastry (only when there's a dog there)
  elseif pastry then
    hasPastry = pastry
  end
  
end

function showOverheadPromptsBasedOnLocation()
  
  local x = player.x
  local y = player.y
  local pastry = P.isNearPastry(x, y)
  local scaling = .7
  
  gr.setFont(overheadFont)
  
  if P.isNearBrewTable(x, y) == true then
    gr.draw(keyPrompt, x+20, y-20, 0, scaling, scaling)
    gr.setColor(love.math.colorFromBytes(74, 55, 120))
    gr.printf("BREW", x+46, y-21, 100, "left")
  elseif P.isNearMenu(x, y) == true then
    gr.draw(keyPrompt, x+20, y-20, 0, scaling, scaling)
    gr.setColor(love.math.colorFromBytes(74, 55, 120))
    gr.printf("MENU", x+46, y-21, 100, "left")
  elseif P.isNearDog(x, y) == true then
    if hasPastry then
      gr.draw(keyPrompt, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("DROP", x+46, y-21, 100, "left")
    else
      gr.draw(keyPrompt, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("CHAT", x+46, y-21, 100, "left")
    end
  elseif pastry then
    
    if pastry == 1 then
      gr.draw(keyPromptBone, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("TAKE", x+46, y-21, 100, "left")
    elseif pastry == 2 then
      gr.draw(keyPromptDonut, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("TAKE", x+46, y-21, 100, "left")
    elseif pastry == 3 then
      gr.draw(keyPromptCookie, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("TAKE", x+46, y-21, 100, "left")
    elseif pastry == 4 then
      gr.draw(keyPromptEclair, x+20, y-20, 0, scaling, scaling)
      gr.setColor(love.math.colorFromBytes(74, 55, 120))
      gr.printf("TAKE", x+46, y-21, 100, "left")
    end
    
  end
  
  gr.setColor(1, 1, 1)
  
end

function drawHearts(x, y)
  
  local wholeHearts = math.floor(numHearts / 2.0)
  local halfHeart = numHearts % 2
  
  if wholeHearts ~= 0 then
    for i=1, wholeHearts do
      gr.draw(heartFull, x+(58*i), y)
    end
  end
  if halfHeart ~= 0 then
    gr.draw(heartEmpty, x+(58*(wholeHearts+1)), y)
    gr.draw(heartHalf, x+(58*(wholeHearts+1)), y)
  end
  
  for i=wholeHearts+halfHeart+1, 10 do
    gr.draw(heartEmpty, x + (58*i), y)
  end
end


function love.mousepressed(x, y, button, istouch, presses)
  
  if brewHover then popClick:play() end
  
  if brewHover == "espresso" then
    
    --6, 3, 4
    if drinkIngredients[6].isInDrink == true or drinkIngredients[3].isInDrink == true or drinkIngredients[4].isInDrink == true then
      espressoFirst = false
    end
    
    if espressoFirst == true then
      if drinkIngredients[1].isInDrink == true then
        drinkIngredients[2].isInDrink = true
      else
        drinkIngredients[1].isInDrink = true
      end
    end
    
  elseif brewHover == "milk" then
    if drinkIngredients[1].isInDrink == true then
      drinkIngredients[4].isInDrink = true
    else
      drinkIngredients[3].isInDrink = true
    end
    
  elseif brewHover == "vanilla" then
    drinkIngredients[8].isInDrink = true
    
  elseif brewHover == "caramel" then
    drinkIngredients[9].isInDrink = true
    
  elseif brewHover == "raspberry" then
    drinkIngredients[10].isInDrink = true
    
  elseif brewHover == "rawhide" then
    drinkIngredients[11].isInDrink = true
    
  elseif brewHover == "whip" then
    drinkIngredients[6].isInDrink = true
    
  elseif brewHover == "sprinkles" then
    drinkIngredients[7].isInDrink = true
    
  elseif brewHover == "dump" then
    for k, v in pairs(drinkIngredients) do
      v.isInDrink = false
    end
    espressoFirst = true
  elseif brewHover == "finish" then
    currentSceneState = 1
    showCupOnCounter = true
  elseif brewHover == "art" then
    if drinkIngredients[4].isInDrink then
      drinkIngredients[5].isInDrink = true
    end
    
  end
  
end


function testOrder(requested, pastry)
  
  local numItems = 0
  
  for k, v in pairs(drinkIngredients) do
    if v.isInDrink == true then
      numItems = numItems + 1
    end
  end
  
  if numItems ~= requested.numIngredients then
    return false
  end

  for k, v in pairs(requested.ingredients) do
    if not drinkIngredients[v].isInDrink then
      return false
    end
  end
  
  if pastryOnCounter ~= pastry then
    return false
  end
  
  return true
  
end

function love.resize(w, h)
  push:resize(w, h)
end





