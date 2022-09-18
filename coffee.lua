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

function M.showDrinkIngredientsIfSelected()
  
  for k, v in pairs(drinkIngredients) do
    if v.isInDrink == true then
      gr.draw(v.img, v.x, v.y)
    end
  end
  
end


function M.showBrewPromptsBasedOnMouseLocation()
  
  local x = love.mouse.getX()
  local y = love.mouse.getY()
  
  gr.setColor(love.math.colorFromBytes(74, 55, 120))
  gr.setFont(brewFont)
  
  --whipped cream
  if x > 750 and x < 938 and y > 167 and y < 494 then
    gr.printf("add whipped cream", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "whip"
  
  --sprinkles
  elseif x > 828 and x < 938 and y > 520 and y < 745 then
    gr.printf("add sprinkles", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "sprinkles"
  --espresso
elseif x > 98 and x < 205 and y > 350 and y < 750 then
    if drinkIngredients[2].isInDrink == true then
      gr.printf("two shots is plenty", 115, 948, 835, "center")
    elseif espressoFirst == false then
      gr.printf("can't add espresso after other ingredients", 115, 948, 835, "center")
    else
      gr.printf("add espresso shot", 115, 948, 835, "center")
    end
    love.mouse.setCursor(handCursor)
    brewHover = "espresso"
  
  --caramel
  elseif x > 210 and x < 370 and y > 110 and y < 279 then
    gr.printf("add caramel syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "espresso"
  
  --vanilla
  elseif x > 377 and x < 493 and y > 110 and y < 257 then
    gr.printf("add vanilla syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "vanilla"
    
  --raspberry
  elseif x > 520 and x < 597 and y > 110 and y < 220 then
    gr.printf("add raspberry syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "raspberry"
  
  --rawhide
  elseif x > 614 and x < 689 and y > 110 and y < 220 then
    gr.printf("add rawhide syrup", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "rawhide"
    
  --get milk
  elseif x > 114 and x < 200 and y > 124 and y < 256 then
    gr.printf("add milk", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "milk"
    
  --dump out drink
  elseif x > 837 and x < 921 and y > 776 and y < 872 then
    gr.printf("dump drink down sink", 115, 948, 835, "center")
    love.mouse.setCursor(handCursor)
    brewHover = "dump"
    
  --TODO: make finish icon
  
  else
    love.mouse.setCursor()
    brewHover = nil
  end
  
  gr.reset()
  
end


return M