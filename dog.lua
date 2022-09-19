M = {}
M.__index = M

function M.new(num)
  
  local self = setmetatable({
      
      dogNum = num,
      sheet = gr.newImage("/assets/dogs/dog" .. num .. ".png"),
      name = getName(num),
      chatImg = gr.newImage("/assets/dogs/dog" .. num .. "-chat.png"),
      isInScene = false,
      isFacingUp = true,
      frames = {},
      x = 480,
      y = 860,
      isMoving = true,
      destinationX = 480,
      destinationY = 400,
      speed = 5
      
    }, M)

  self.frames[1] = gr.newQuad(0, 0, 64, 64, self.sheet)
  self.frames[2] = gr.newQuad(64, 0, 64, 64, self.sheet)
  self.frames[3] = gr.newQuad(128, 0, 64, 64, self.sheet)
  self.frames[4] = gr.newQuad(192, 0, 64, 64, self.sheet)
  self.frames[5] = gr.newQuad(0, 64, 64, 64, self.sheet)
  self.frames[6] = gr.newQuad(64, 64, 64, 64, self.sheet)
  self.frames[7] = gr.newQuad(128, 64, 64, 64, self.sheet)
  self.frames[8] = gr.newQuad(192, 64, 64, 64, self.sheet)
  self.currFrameNum = 1
  
  return self
  
end

function M.getCurrentFrame(dog, t)
  
  local n = dog.currFrameNum
  
  if t % 10 ~= 0 then
    return n
  end
  
  if dog.isMoving == false then
    return n
  end
  
  
  -- first just move to the next frame within the "up" and "down" frames
  if n >= 1 and n < 8 and n ~= 4 then
    n = n + 1
  elseif n == 4 then
    n = 1
  elseif n == 8 then
    n = 5
  end
  
  
  --check to see if direction changed, if so, move to corresponding frame in opposite direction
  if dog.isFacingUp == true and n < 5 then
    n = n + 4
  elseif dog.isFacingDown == true and n > 4 then
    n = n - 4
  end
  
  return n
  
end

function M.moveDog(self)
  
  --avoid the weird wiggles when it gets soooo close but not quite there
  if math.abs(self.destinationX - self.x) < 10 and math.abs(self.destinationY- self.y) < 10 then
      self.isMoving = false
      self.currFrameNum = 1
      return
    end
    
  if self.isMoving then
    local deltaX = self.destinationX - self.x
    local deltaY = self.destinationY - self.y
    local distance = math.sqrt((deltaX*deltaX) + (deltaY*deltaY))
    local pace = distance/self.speed
    local x = self.x + deltaX/pace
    local y = self.y + deltaY/pace
    
    
    -- quick n dirty open the door if you need
    if math.abs(self.x - 460) < 60 and math.abs(self.y - 680) < 100 then
      doorOpen = true
    else
      doorOpen = false
    end
    
    
    if self.destinationX == x and self.destinationY == y then
      return
    else
      self.x = x
      self.y = y
    end
  end
  
end


function getSpriteSheet(num)
  
  local filename = "/assets/dogs/dog" .. num .. ".png"
  
  return gr.newImage(filename)
  
end

function getName(num)
  
  return "fido"
  
end

function M.getTextTable(num)
  
  
  
end


return M