require "conf"
local P = require "player"
local D = require "dog"
local C = require "coffee"

function love.load()
  
  gr = love.graphics
  ph = love.physics
  key = love.keyboard
  
  -- global variables
  globalTimer = 0
  currentSceneState = 1
  doorOpen = false
  handCursor = love.mouse.getSystemCursor("hand")
  espressoFirst = true
  
  --testing
  mousex = 0
  mousey = 0
  
  -- load static assets for main area
  background = gr.newImage("/assets/background.png")
  testFont = gr.newFont(10)
  brewFont = gr.newFont(30)
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
  
  counter = gr.newImage("/assets/furniture/counter.png")
  tablePurpleImg = gr.newImage("/assets/furniture/table-purple.png")
  tableGreenImg = gr.newImage("/assets/furniture/table-green.png")
  sofaImg = gr.newImage("/assets/furniture/sofa.png")
  doorImg = gr.newImage("/assets/furniture/door.png")
  
  -- load assets for brew scene
  brewBackground = gr.newImage("/assets/brew/brew-bg.png")
  orderSlip = gr.newImage("/assets/brew/orderslip.png")
  emptyCup = gr.newImage("/assets/brew/emptycup.png")
  
  drinkIngredients = {}
    drinkIngredients[1] = C.new("/assets/brew/oneshot.png", "shotOne")
    drinkIngredients[2] = C.new("/assets/brew/twoshot.png", "shotTwo")
    drinkIngredients[3] = C.new("/assets/brew/justmilk.png", "milk")
    drinkIngredients[4] = C.new("/assets/brew/latte.png", "latte")
    drinkIngredients[5] = C.new("/assets/brew/latteart.png", "art")
    drinkIngredients[6] = C.new("/assets/brew/whippedcream.png", "whip")
    drinkIngredients[7] = C.new("/assets/brew/sprinkles.png", "sprinkles")
  
  -- load consumables
  boneImg = gr.newImage("/assets/bone.png")
  
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
  keyPromptBrew = gr.newImage("/assets/ui/keyprompt-e.png")
  keyPromptBone = gr.newImage("/assets/ui/keyprompt-e-bone.png")
  keyPromptBrew = gr.newImage("/assets/ui/keyprompt-e-brew.png")
  keyPromptChat = gr.newImage("/assets/ui/keyprompt-e-chat.png")
  keyPromptMenu = gr.newImage("/assets/ui/keyprompt-e-menu.png")
  keyPromptEclair = gr.newImage("/assets/ui/keyprompt-e-eclair.png")
  keyPromptDonut = gr.newImage("/assets/ui/keyprompt-e-donut.png")
  keyPromptCookie = gr.newImage("/assets/ui/keyprompt-e-cookie.png")
  
end


function love.update(dt)
  
  globalTimer = globalTimer + 1
  
  --calculations for obj animations
  mushSprite.currentFrameNum = getCurrentObjFrame(mushSprite, globalTimer)

  
  --calculations for dog animations
  for k, v in pairs(dogs) do
    if v.dogNum == 1 then
      v.currFrameNum = D.getCurrentFrame(v, globalTimer)
      D.moveDog(v)
    end
  end
  
  
end


function love.draw(t)


  if currentSceneState == 1 or currentSceneState == 3 then
    
    gr.draw(background)
    P.checkMovement(player)
    gr.draw(player.sheet, player.currImg, player.x, player.y)
    gr.draw(counter, 210, 320)
    gr.draw(tablePurpleImg, 240, 510)
    gr.draw(tableGreenImg, 600, 400)
    gr.draw(sofaImg, 590, 500)
  
    if doorOpen == false then
      gr.draw(doorImg, 460, 680)
    end
  
    gr.draw(mushRedImg, mushSprite[mushSprite.currentFrameNum], 710, 790)
  
    for k, v in pairs(dogs) do
      if v.dogNum == 1 then
        gr.draw(v.sheet, v.frames[v.currFrameNum], v.x, v.y)
      end
    end
  
    showCoords(player) --TODO remove after testing
  
    showOverheadPromptsBasedOnLocation()
    
    --TODO: show coffee cup on counter if coffee is done
    
  elseif currentSceneState == 2 then
    gr.draw(brewBackground)
    
    --TODO: if there's an order up
    if true then
      gr.draw(emptyCup, 278, 250)
      gr.draw(orderSlip, 360, 708)
    end
    
    C.showDrinkIngredientsIfSelected()
    
    C.showBrewPromptsBasedOnMouseLocation()
    
    --TODO - "finish drink" button
    
  elseif currentSceneState == 4 then
    
    --TODO - create menu page
    --TODO - esc to return
    
  end
  
  if currentSceneState == 3 then
    --TODO add in lil text chat thing. probably with a black overlay so you can focus on it. f to continue.
    --TODO - "are you finished with the order? y/n"
  end
  
  gr.setFont(testFont)
  gr.printf(""..mousex..", "..mousey, mousex, mousey-10, 200, "left")

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

end




function changeSceneState()
  
  local x = player.x
  local y = player.y
  
  --brew UI (even when there's no active request)
  if P.isNearBrewTable(x, y) == true then
    currentSceneState = 2
  --menu UI (even when there's no active request)
  elseif P.isNearMenu(x, y) == true then
    currentSceneState = 3
  --chat UI (only when there's a dog there)
  elseif P.isNearDog(x, y) == true then
    currentSceneState = 4
  --pick up pastry (only when there's a dog there)
  elseif P.isNearPastry(x, y) == true then
    currentSceneState = 5
  end
  
end




function showOverheadPromptsBasedOnLocation()
  
  local x = player.x
  local y = player.y
  
  if P.isNearBrewTable(x, y) == true then
    gr.draw(keyPromptBrew, x+20, y-20, 0, .6, .6)
  elseif P.isNearMenu(x, y) == true then
    gr.draw(keyPromptMenu, x+20, y-20, 0, .6, .6)
  elseif P.isNearDog(x, y) == true then
    gr.draw(keyPromptChat, x+20, y-20, 0, .6, .6)
  elseif P.isNearPastry(x, y) == true then
    gr.draw(keyPromptBone, x+20, y-20, 0, .6, .6)
  end
  
end


--TODO - add in a "finish drink" button interaction here
function love.mousereleased(x, y, button, istouch, presses)
  
  if brewHover == "espresso" then
    
    for k, v in pairs(drinkIngredients) do
      if v.isInDrink == true and v.name ~= "shotOne" then
        espressoFirst = false
      end
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
    drinkIngredients[1].isInDrink = true
    
  elseif brewHover == "caramel" then
    drinkIngredients[1].isInDrink = true
    
  elseif brewHover == "raspberry" then
    drinkIngredients[1].isInDrink = true
    
  elseif brewHover == "rawhide" then
    drinkIngredients[1].isInDrink = true
    
  elseif brewHover == "whip" then
    drinkIngredients[6].isInDrink = true
    
  elseif brewHover == "sprinkles" then
    drinkIngredients[7].isInDrink = true
    
  elseif brewHover == "dump" then
    for k, v in pairs(drinkIngredients) do
      v.isInDrink = false
    end
    espressoFirst = true
  end
  
end





--TESTING ONLY
function showCoords(obj)
  
  gr.setFont(testFont)
  gr.printf(""..obj.x..", "..obj.y, obj.x+30, obj.y+30, 100, "left")
  
end

function love.mousemoved(x, y, dx, dy, istouch)
  
  mousex = x
  mousey = y
  
end




