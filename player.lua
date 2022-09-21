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
  
  if x > 480 and y <= 140 then
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

  if x > 260 and x < 450 and y >= 236 then
    return true
  else
    return false
  end
  
end

function M.isNearPastry(x, y)
  
  if x > 456 and y >= 236 then
    if x > 456 and x < 510 then
      return 1  
    elseif x >= 510 and x < 584 then
      return 2
    elseif x >= 584 and x < 664 then
      return 3
    elseif x >= 664 then
      return 4
    end
  else
    return nil
  end
  
end



return M