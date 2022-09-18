require "conf"
local P = require "player"
local D = require "dog"

function love.load()
  
  gr = love.graphics
  ph = love.physics
  key = love.keyboard
  
  
  
  -- global variables
  globalTimer = 0
  currentSceneState = 1
  doorOpen = false
  handCursor = love.mouse.getSystemCursor("hand")
  
  
  --testing
  mousex = 0
  mousey = 0
  
  -- load static assets for main area
  background = gr.newImage("/assets/background.png")
  keyPromptFont = gr.newImageFont("/assets/font.png", 'ABCDEFGHIJ')
  keyLabelFont = gr.newImageFont("/assets/ui/keylabelfont.png", 'WASDEQudlrP`/ ')
  labelFont = gr.newImageFont("/assets/ui/labelfont.png", 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ')
  testFont = gr.newFont(10)
  brewFont = gr.newFont(40)
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
  oneShot = gr.newImage("/assets/brew/oneshot.png")
  twoShot = gr.newImage("/assets/brew/twoshot.png")
  justMilk = gr.newImage("/assets/brew/justmilk.png")
  latte = gr.newImage("/assets/brew/latte.png")
  latteArt = gr.newImage("/assets/brew/latteart.png")
  whippedCream = gr.newImage("/assets/brew/whippedcream.png")
  sprinkles =gr.newImage("/assets/brew/sprinkles.png")
  
  
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
  brewButton = gr.newImage("/assets/ui/brew.png")
  chatButton = gr.newImage("/assets/ui/chat.png")
  pauseButton = gr.newImage("/assets/ui/pause.png")
  dayLabel = gr.newImage("/assets/ui/day-label.png")
  credits = gr.newImage("/assets/ui/credits.png")
  title = gr.newImage("/assets/ui/title.png")
  keyPromptE = gr.newImage("/assets/ui/keyprompt-e.png")
  keyPromptBrew = gr.newImage("/assets/ui/keyprompt-e.png")
  keyPrompt = gr.newImage("/assets/ui/keyprompt-e.png")
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
    if v.isInScene == true then
      v.currFrameNum = v:getCurrentFrame(globalTimer)
      v:moveDog()
    end
  end
  
  
end


function love.draw(t)


  if currentSceneState == 1 then
    
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
      if v.isInScene == true then
        gr.draw(v.sheet, v.frames[v.currFrameNum], v.x, v.y)
      end
    end
  
    showCoords(player)
  
    showOverheadPromptsBasedOnLocation()
    
  elseif currentSceneState == 2 then
    gr.draw(brewBackground)
    
    
    --if there's an order up
    if true then
      gr.draw(emptyCup, 278, 250)
      gr.draw(orderSlip, 360, 708)
    end
    
    showBrewPromptsBasedOnMouseLocation()
    
    
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

function showBrewPromptsBasedOnMouseLocation()
  
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  
  gr.setColor(love.math.colorFromBytes(74, 55, 120))
  gr.setFont(brewFont)
  
  --whipped cream
  if x > 750 and x < 938 and y > 167 and y < 494 then
    gr.printf("add whipped cream", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
  
  --sprinkles
  elseif x > 828 and x < 938 and y > 520 and y < 745 then
    gr.printf("add sprinkles", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
  
  --espresso
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("add espresso shot", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
  
  --caramel
  elseif x > 210 and x < 370 and y > 110 and y < 292 then
    gr.printf("add caramel syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
  
  --vanilla
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("add vanilla syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    
  --raspberry
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("add raspberry syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
  
  --rawhide
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("add rawhide syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    
  --get milk
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("add milk", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    
  --dump out drink
  elseif x > 98 and x < 205 and y > 150 and y < 750 then
    gr.printf("dump drink down sink", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    
  --TODO: make finish icon
  
  else
    love.mouse.setCursor()
  end
  
  gr.reset()
  
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



