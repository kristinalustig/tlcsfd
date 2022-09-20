require "conf"
local P = require "player"
local D = require "dog"
local C = require "coffee"
local GD = require "gameData"
local push = require "push"

function love.load()
  
  local gameWidth, gameHeight = 1032, 1032
  local windowWidth, windowHeight = love.window.getDesktopDimensions()
  if windowHeight >= 1032 then
    windowWidth, windowHeight = 1032, 1032
  else
    windowWidth, windowHeight = 700, 700
  end
  
  push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {
      fullscreen = false,
      resizable = false,
      pixelperfect = true,
      stretched = true})
  
  gr = love.graphics
  ph = love.physics
  key = love.keyboard
  
  -- global variables
  globalTimer = 0
  globalSceneNum = 1
  currentSceneState = 1
  doorOpen = false
  handCursor = love.mouse.getSystemCursor("hand")
  
  --game state - coffee order
  espressoFirst = true
  orderState = 1
  wasOrderGood = false
  currentDog = 0
  currentDogNum = 0
  showCupOnCounter = false
  pastDogs = {}
  possibleHeartNum = 10
  numHearts = 1
  orderUp = false
  pastryOnCounter = nil
  hasPastry = nil
  
  --daily summary details
  dayNum = 1
  dayDogCount = 0
  dayHeartCount = 0
  dayDogSuccess = 0
  
  --testing
  mousex = 0
  mousey = 0
  
  --fonts
  testFont = gr.newFont(10)
  orderSlipPrintFont = gr.newFont("/fonts/BreeSerif-Regular.ttf", 20) -- only for the serif text @ top of order
  handwritingFont = gr.newFont("/fonts/Caveat-Medium.ttf", 25) -- only for order slip handwriting
  menuHeaderFont = gr.newFont("/fonts/ArimaMadurai-Black.ttf", 35)
  menuContentFont = gr.newFont("/fonts/Quicksand-Regular.ttf", 25)
  hintFont = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 30) -- only for places where UI gives user instructions
  hintFontSm = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 20) -- smaller instructions
  hintFontXSm = gr.newFont("/fonts/Quicksand-SemiBold.ttf", 14) -- even smaller instructions
  overheadFont = gr.newFont("/fonts/Quicksand-Bold.ttf", 20) -- for E prompts
  dogFont = gr.newFont(24) -- font for dogs convo text until I can get specific
  dog1Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog2Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog3Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog4Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog5Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog6Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog7Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog8Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog9Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
  dog10Font = gr.newFont("/fonts/Quicksand-Regular.ttf", 30)
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
  
  chatBackground = gr.newImage("/assets/chat-bg.png")
  finishedCoffee = gr.newImage("/assets/finishedCoffee.png")
  heartEmpty = gr.newImage("/assets/heart-empty.png")
  heartFull = gr.newImage("/assets/heart-full.png")
  
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
    dog6 = D.new(6)
  }
  
  -- load ui
  dayLabel = gr.newImage("/assets/ui/day-label.png")
  credits = gr.newImage("/assets/ui/credits.png")
  title = gr.newImage("/assets/ui/title.png")
  keyPrompt = gr.newImage("/assets/ui/keyprompt-e.png")
  keyPromptBone = gr.newImage("/assets/ui/keyprompt-e-bone.png")
  keyPromptBrew = gr.newImage("/assets/ui/keyprompt-e-brew.png")
  keyPromptChat = gr.newImage("/assets/ui/keyprompt-e-chat.png")
  keyPromptMenu = gr.newImage("/assets/ui/keyprompt-e-menu.png")
  keyPromptEclair = gr.newImage("/assets/ui/keyprompt-e-eclair.png")
  keyPromptDonut = gr.newImage("/assets/ui/keyprompt-e-donut.png")
  keyPromptCookie = gr.newImage("/assets/ui/keyprompt-e-cookie.png")
  keyPromptDrop = gr.newImage("/assets/ui/keyprompt-e-drop.png")
  
  GD.initialize()
  
end


function love.update(dt)
  
  --the end
  if numHearts == possibleHeartNum then
    globalSceneNum = 4
  elseif numHearts < 0 then
    globalSceneNum = 5
  elseif dayNum == 8 then
    globalSceneNum = 6
  end
  
  if currentDogNum == 0 then
    findNewCurrentDog()
    dayDogCount = dayDogCount + 1
  end
  
  if dayDogCount == 4 then
    globalSceneNum = 7
  else
  
    globalTimer = globalTimer + 1
    
    --calculations for obj animations
    mushSprite.currentFrameNum = getCurrentObjFrame(mushSprite, globalTimer)
    mushSprite2.currentFrameNum = getCurrentObjFrame(mushSprite2, globalTimer)
    pumpkin.currentFrameNum = getCurrentObjFrame(pumpkin, globalTimer)

    
    --calculations for dog animations
    currentDog.currFrameNum = D.getCurrentFrame(currentDog, globalTimer)
    D.moveDog(currentDog)
    
     for k, v in pairs(pastDogs) do
      v.currFrameNum = D.getCurrentFrame(v, globalTimer)
      D.moveDog(v)
    end
    
    if orderState == 3 then
      -- check orders against each other here! but for now,
      wasOrderGood = testOrder(coffeeDrinks[dogInfo[currentDog.dogNum].favoriteDrinkId], dogInfo[currentDogNum].pastryWanted)
        
    end
  end
  
end


function love.draw()
  
  push:start()
  
  if globalSceneNum == 7 then
    gr.draw(nightBackground, 0, 0)
    gr.setFont(menuHeaderFont)
    gr.printf("End of day summary:", 0, 300, 946, "center")
    gr.printf("Dogs served: "..dayDogCount, 0, 400, 946, "center") 
    gr.printf("Hearts earned: "..dayHeartCount, 0, 450, 946, "center") 
    gr.printf("Slobber marks cleaned off tables: 17", 0, 500, 946, "center")
    gr.printf("Press 'T' to start tomorrow!", 0, 600, 946, "center")
  
  elseif globalSceneNum == 1 then

    if currentSceneState == 1 or currentSceneState == 4 then
      
      gr.draw(background, 0, 0)
      
      gr.draw(dayLabel, 100, 20)
      gr.setFont(dayFont)
      gr.printf(dayNum, 260, 24, 50, "left")
      for i=1, numHearts do
        gr.draw(heartFull, 300 + (58*i), 30)
      end
      for i=numHearts+1, 10 do
        gr.draw(heartEmpty, 300 + (58*i), 30)
      end
      
      
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
        gr.draw(v.sheet, v.frames[v.currFrameNum], v.x, v.y)
      end
      
    
      showCoords(player) --TODO remove after testing
    
      showOverheadPromptsBasedOnLocation()
      
      gr.draw(tablePurpleImg, 240, 510)
      gr.draw(tableGreenImg, 600, 400)
      
      if showCupOnCounter == true then
        gr.draw(finishedCoffee, 430, 360)
      end
      
      for k, v in pairs(pastDogs) do
      if v.showCupAtSeat == true then
        gr.draw(finishedCoffee, seating[dogInfo[v.dogNum].sitChoiceOneId].cupX, seating[dogInfo[v.dogNum].sitChoiceOneId].cupY)
      end
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
        gr.printf("- "..coffeeDrinks[dogInfo[currentDogNum].favoriteDrinkId].name, 390, 750, 224, "left")
        gr.printf("- "..snacks[dogInfo[currentDogNum].pastryWanted].name, 390, 810, 224, "left")
      else
        gr.printf("No orders right now", 380, 740, 224, "center")
      end
      
      C.showDrinkIngredientsIfSelected()
      
      C.showBrewPromptsBasedOnMouseLocation()
      
      
    elseif currentSceneState == 3 then
      
      gr.draw(menuBackground, 0, 0)
      --TODO - create menu page
      
    end
    
    if currentSceneState == 4 then
      
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
        gr.printf(dogInfo[currentDogNum].hello, 316, 250, 598, "left")
        gr.setFont(playerVoiceFont)
        gr.printf("Coming right up!", 125, 500, 580, "left")
        gr.setFont(hintFont)
        gr.printf("(Press 'F' to continue)", 98, 660, 832, "center")
        
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
      gr.printf("(Press 'F' to continue)", 98, 660, 832, "center")
      --farewell  
    elseif orderState == 4 then  
        gr.setFont(dogFont)
        gr.printf(dogInfo[currentDogNum].staying, 316, 250, 598, "left")
        gr.setFont(hintFont)
        gr.printf("(Press 'F' to continue)", 98, 660, 832, "center")
      end
      
    end
    
    gr.setFont(testFont)
    gr.printf(""..mousex..", "..mousey, mousex, mousey-10, 200, "left")
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
  
  --reset dog count
  dayDogCount = 0
  
  --remove dogs from pastDogs
  pastDogs = {}
  
  --reset dog's visitedToday
  for k, v in pairs(dogInfo) do
    v.visitedToday = false
  end
  
  --add one to dayNum
  dayNum = dayNum + 1
  
  dayHeartCount = 0
  
  globalSceneNum = 1
  
end


-- return correct index for any animated non-npc sprite
function getCurrentObjFrame(obj, t)
  if (t % obj.cadence == 0) then
    if obj.currentFrameNum == obj.maxFrameNum then
      obj.currentFrameNum = 1
      obj.cadence = obj.cadence * 5
    else
      obj.currentFrameNum = obj.currentFrameNum + 1
      if obj.currentFrameNum == 2 then
        obj.cadence = obj.cadence / 5
      end
    end
  end
  return obj.currentFrameNum
end




function love.keypressed(key, scancode, isrepeat)

  if key == "e" and not isrepeat then
    changeSceneState()
  end
  
  if key == "t" and globalSceneNum == 7 then
    endDay()
  end
  
  if key == "escape" and not isrepeat then
    if currentSceneState == 2 or currentSceneState == 3 then
      currentSceneState = 1
    end
  end
  
  if key == "f" and not isrepeat then
    if currentSceneState == 4 then
      if orderState == 1 then
        orderState = orderState + 1
        currentSceneState = 1
      elseif orderState == 3 then
        orderState = orderState + 1
      elseif orderState == 4 then
        if wasOrderGood == true then
          numHearts = numHearts + 1
          dayHeartCount = dayHeartCount + 1
        else
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
        currentDog.destinationX = seating[dogInfo[currentDogNum].sitChoiceOneId].x
        currentDog.destinationY = seating[dogInfo[currentDogNum].sitChoiceOneId].y
        currentDog.isMoving = true
        currentDog.showCupAtSeat = true
        currentDog.visitedToday = true
        table.insert(pastDogs, currentDog)
        for k, v in pairs(drinkIngredients) do
          v.isInDrink = false
        end
        --addHeartRating()
        findNewCurrentDog()
        dayDogCount = dayDogCount + 1
        --TODO - what else do i need to put here to restart the order?
      end
    end
  end
  
  if key == "y" and not isrepeat then
    if currentSceneState == 4 and orderState == 2 then
      orderState = 3
    end
  end
  
  if key == "n" and not isrepeat then
    if currentSceneState == 4 and orderState == 2 then
      currentSceneState = 1
    end
  end

end

function findNewCurrentDog()
  
  local foundDog = false
  local tries = 0
  while foundDog == false and tries < 10 do
    local rand = math.random(2)
    if dogInfo[rand].visitedToday == false then
      tries = tries + 1
      currentDogNum = rand
      currentDog = dogs["dog"..currentDogNum]
      dogInfo[currentDogNum].visitedToday = true
      foundDog = true
    end
  end
    
end



function changeSceneState()
  
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


--TODO - add in a "finish drink" button interaction here
function love.mousereleased(x, y, button, istouch, presses)
  
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



--TESTING ONLY
function showCoords(obj)
  
  gr.setFont(testFont)
  gr.printf(""..obj.x..", "..obj.y, obj.x+30, obj.y+30, 100, "left")
  
end

function love.mousemoved(x, y, dx, dy, istouch)
  
  local x, y = push:toGame(love.mouse.getX(), love.mouse.getY())
  
  mousex = x
  mousey = y
  
end




