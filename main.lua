function love.load()
  pig = love.graphics.newImage("pig.png")
  drawPig = false
  clickCount = 0
  love.graphics.setColor(213, 213, 213, 200)
  
  path = {
      x = {},
      y = {},
      color = {}
  }
  
  c = {
    ax = 0, ay = 0,
    bx = 0, by = 0, 
    cx = 0, cy = 0,
    dx = 0, dy = 0,
    drawA = false, drawB = false,
    drawC = false, drawD = false,
    all = false
  }
end

function love.draw()
  love.graphics.print("Press 'P' for pig")
  if c.drawA then
    love.graphics.circle("line", c.ax, c.ay, 5)
    love.graphics.print("A.("..c.ax..","..c.ay..")", c.ax + 10, c.ay + 10)
  end
  if c.drawB then
    love.graphics.circle("line", c.bx, c.by, 5)
    love.graphics.print("B.("..c.bx..","..c.by..")", c.bx + 10, c.by + 10)
    love.graphics.line(c.ax, c.ay, c.bx, c.by)
  end
  if c.drawC then
    love.graphics.circle("line", c.cx, c.cy, 5)
    love.graphics.print("C.("..c.cx..","..c.cy..")", c.cx + 10, c.cy + 10)
  end
  if c.drawD then
    love.graphics.circle("line", c.dx, c.dy, 5)
    love.graphics.print("D.("..c.dx..","..c.dy..")", c.dx + 10, c.dy + 10)
    love.graphics.line(c.cx, c.cy, c.dx, c.dy)
  end
  
  -- Draw curve
  if c.all then
    for key, val in pairs(path.x) do
       --love.graphics.print(key .. " -> ".. val, 100, y + 10 + i)
      if drawPig then
        love.graphics.draw(pig, path.x[key], path.y[key], 0 , 0.5, 0.5)
      else
        love.graphics.point(path.x[key], path.y[key])
        love.graphics.circle("line", path.x[key], path.y[key], 5)
        if key < table.getn(path.x) then
          love.graphics.line(path.x[key], path.y[key], path.x[key+1], path.y[key+1])
        end
      end
    end
  end
end


function love.update()
  
end

function love.mousepressed(x, y, button)
  if love.mouse.isDown("l") then 
      if clickCount == 0 then
        c.ax = x
        c.ay = y
        c.drawA = true
        c.all = false
        clickCount = clickCount + 1
      elseif clickCount == 1 then
        c.bx = x
        c.by = y
        c.drawB = true
        clickCount = clickCount + 1
      elseif clickCount == 2 then
        c.cx = x
        c.cy = y
        c.drawC = true
        clickCount = clickCount + 1
      elseif clickCount == 3 then
        c.dx = x
        c.dy = y
        c.drawD = true
        c.all = true
        clickCount = 0
        updateCurve()
      end
  end
end

function love.keypressed(key)
  if key == "escape" then
    love.event.push("quit")
  end
  
  if key == " " then
    xMax, yMax = love.window.getDimensions()
    c.ax = math.random(xMax)
    c.ay = math.random(yMax)
    c.bx = math.random(xMax)
    c.by = math.random(yMax)
    c.cx = math.random(xMax)
    c.cy = math.random(yMax)
    c.dx = math.random(xMax)
    c.dy = math.random(yMax)
    updateCurve()
    clickCount = 0
    c.all = true
  end
  
  if key == "p" then
    if drawPig then
      drawPig = false
    else
      drawPig = true
    end
  end
end


function updateCurve() 
  local i = 0
  local a = 1.0
  local b = 1.0 - a
  while a >= 0 do
     path.x[i] = c.ax*a*a*a + c.bx*3*a*a*b + c.cx*3*a*b*b + c.dx*b*b*b;
     path.y[i] = c.ay*a*a*a + c.by*3*a*a*b + c.cy*3*a*b*b + c.dy*b*b*b;
     path.color[i] = love.graphics.getColor(math.random(255), math.random(255), math.random(255))
     a = a - 0.03
     b = 1.0 - a 
     i = i + 1
  end
end
    