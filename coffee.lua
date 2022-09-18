M = {}
M.__index = M

function M.new(imgString, name)
  
  local self = setmetatable({
      
      name = name,
      isInDrink = false,
      img = gr.newImage(imgString),
      x = 278,
      y = 250
      
    }, M)
  
  return self
  
end

return M