M = {}
M.__index = M

function M.new()
  
  local self = setmetatable({
      
      sheet = gr.newImage("/assets/cafe-owner-a.png"),
      x = 200,
      y = 180,
      stepCount = 0,
      atBottomOfStep = false
      
    }, M)
  
  self.downImg = gr.newQuad(0, 0, 128, 136, self.sheet)
  self.upImg = gr.newQuad(128, 0, 128, 136, self.sheet)
  self.currImg = self.downImg
  
  return self
  
end

function M.checkMovement(player)
  
  if key.isDown("d") and player.x <= 740 then
    player.x = player.x + 4
    player.y = player.y + walkBobble(player)
    player.currImg = player.downImg
  elseif key.isDown("s") and player.y <= 240 then
    player.y = player.y + 4
    player.y = player.y + (walkBobble(player)*2)
    player.currImg = player.downImg
  elseif key.isDown("a") and player.x >= 180 then
    player.x = player.x - 4
    player.y = player.y + walkBobble(player)
    player.currImg = player.downImg
  elseif key.isDown("w") then
    if player.y >= 140 then
      player.y = player.y - 4
      player.y = player.y + (walkBobble(player)*2)
    end
    player.currImg = player.upImg
  end
  
end

function M.isNearBrewTable(x, y)
  
  if x > 500 and y <= 140 then
    return true
  else
    return false
  end
  
end


--menu has x coords of 200 - 399 and y coord of 180
function M.isNearMenu(x, y)

  if x < 440 and x > 300 and y <= 140 then
    return true
  else
    return false
  end

end

function M.isNearDog(x, y)

  if x > 260 and x < 450 and y >= 240 then
    return true
  else
    return false
  end
  
end

function M.isNearPastry(x, y)
  
  if x > 450 and y >= 240 then
    return true
  else
    return false
  end
  
end

return M