require "conf"
local P = require "player"
-- local D = require "dog"

function love.load()
  
  gr = love.graphics
  ph = love.physics
  key = love.keyboard
  
  globalTimer = 0
  
  
  -- load static assets
  background = gr.newImage("/assets/background.png")
  keyPromptFont = gr.newImageFont("/assets/font.png", 'ABCDEFGHIJ')
  keyLabelFont = gr.newImageFont("/assets/ui/keylabelfont.png", 'WASDEQudlrP`/ ')
  
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
  
  
  -- load consumables
  boneImg = gr.newImage("/assets/bone.png")
  
  
  -- load player and npcs
  player = P.new()
  
  
  -- load ui
  brewButton = gr.newImage("/assets/ui/brew.png")
  chatButton = gr.newImage("/assets/ui/chat.png")
  pauseButton = gr.newImage("/assets/ui/pause.png")
  dayLabel = gr.newImage("/assets/ui/day-label.png")
  credits = gr.newImage("/assets/ui/credits.png")
  title = gr.newImage("/assets/ui/title.png")
  keyPrompt = gr.newImage("/assets/ui/keyprompt.png")
  
end


function love.update(dt)
  
  globalTimer = globalTimer + 1
  
  mushSprite.currentFrameNum = getCurrentFrame(mushSprite, globalTimer)
  
end


function love.draw(t)

  gr.draw(background)
  
  P.checkMovement(player)
  
  gr.draw(player.sheet, player.currImg, player.x, player.y)
  
  gr.draw(counter, 210, 320)
  
  gr.draw(tablePurpleImg, 240, 510)
  gr.draw(tableGreenImg, 600, 400)
  gr.draw(sofaImg, 590, 500)
  gr.draw(doorImg, 460, 680)
  
  gr.draw(mushRedImg, mushSprite[mushSprite.currentFrameNum], 710, 790)
  
  --font testing
  --gr.setFont(keyPromptFont)
  --.printf("ABCDEFGHIJ", 200, 210, 200, "center")
  --gr.draw(keyPrompt, 200, 200)
  --gr.setFont(keyLabelFont)
  --gr.printf(" ", 208, 202, 34, "left")

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

-- return correct index for any animated sprite
function getCurrentFrame(obj, t)
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

