function initUi()
  app.registerUi({["menu"] = "Grid snapping on/off", ["callback"] = "gridsnap", ["accelerator"] = "<Alt>g"});
  app.registerUi({["menu"] = "Rotation snapping on/off", ["callback"] = "rotsnap", ["accelerator"] = "<Alt>r"});
  app.registerUi({["menu"] = "Fill on/off", ["callback"] = "fill", ["accelerator"] = "<Alt>f"});
  app.registerUi({["menu"] = "Cycle through tools", ["callback"] = "tool", ["accelerator"] = "<Alt>t"});
  app.registerUi({["menu"] = "Cycle through line style", ["callback"] = "linestyle", ["accelerator"] = "<Alt>l"});
  app.registerUi({["menu"] = "Cycle through selection tools", ["callback"] = "select", ["accelerator"] = "<Alt>s"});
  app.registerUi({["menu"] = "Cycle through eraser type", ["callback"] = "eraser", ["accelerator"] = "<Alt>e"});
  app.registerUi({["menu"] = "Cycle through drawing type", ["callback"] = "drawingtype", ["accelerator"] = "<Alt>v"}); -- <Alt>d is already used for the menu "Datei" in German
  app.registerUi({["menu"] = "Cycle through colors", ["callback"] = "color", ["accelerator"] = "<Alt>c"});

  app.registerUi({["menu"] = "Color #1", ["callback"] = "color1", ["accelerator"] = "<Alt>1"});
  app.registerUi({["menu"] = "Color #2", ["callback"] = "color2", ["accelerator"] = "<Alt>2"});
  app.registerUi({["menu"] = "Color #3", ["callback"] = "color3", ["accelerator"] = "<Alt>3"});
  app.registerUi({["menu"] = "Color #4", ["callback"] = "color4", ["accelerator"] = "<Alt>4"});
end


local currentFill = false
local currentRotsnap = false
local currentGridsnap = false 

function gridsnap()
  currentGridsnap = not currentGridsnap
  app.uiAction({["action"]="ACTION_GRID_SNAPPING"})
  print("ACTION_GRID_SNAPPING: toggled")
end

function rotsnap()
  currentRotsnap = not currentRotsnap
  app.uiAction({["action"]="ACTION_ROTATION_SNAPPING"})
  print("ACTION_ROTATION_SNAPPING: toggled")
end

function fill()
  currentFill = not currentFill
  app.uiAction({["action"]="ACTION_TOOL_FILL", ["enabled"] = currentFill})
  print("ACTION_TOOL_FILL enabled: " .. tostring(currentFill))
end

local colorList = { 
  {"black", 0x000000},  
  {"green", 0x008000},
  {"lightblue", 0x00c0ff}, 
  {"lightgreen", 0x00ff00}, 
  {"blue", 0x3333cc},      
  {"gray", 0x808080},   
  {"red", 0xff0000},        
  {"magenta", 0xff00ff},
  {"orange", 0xff8000}, 
  {"yellow", 0xffff00},    
  {"white", 0xffffff}
}

local currentColor = 4 -- start with blue color 

local linestyleList = {"PLAIN", "DASH", "DASH_DOT", "DOT"}
local currentLinestyle = 1

local selectList = {"RECT", "REGION", "OBJECT"} -- don't use play selection tool
local currentSelect = 1

local toolList = {"PEN", "ERASER", "HILIGHTER", "SELECTION"}
local currentTool = 1

local eraserList = {"STANDARD", "DELETE_STROKE"} -- I don't use WHITEOUT
local currentEraser = 1

local drawingtypeList = {"TOOL_DRAW_RECT", "TOOL_DRAW_CIRCLE", "TOOL_DRAW_ARROW", "RULER", "TOOL_DRAW_SPLINE", "SHAPE_RECOGNIZER"} -- Don't include coordinate system and default tool
local currentDrawingtype = 1

-- function color()
--   currentColor = currentColor % #colorList + 1
--   app.changeToolColor({["color"] = colorList[currentColor][2], ["selection"] = true})
--   print("Color: " .. colorList[currentColor][1])
-- end

function colorN(currentColor)
  app.changeToolColor({["color"] = colorList[currentColor][2], ["selection"] = true})
  print("Color: " .. colorList[currentColor][1])
end

function color1()
  currentColor = 9 -- "orange"
  colorN(currentColor)
end

function color2()
  currentColor = 3 -- "lightblue"
  colorN(currentColor)
end

function color3()
  currentColor = 10 -- "yellow"
  colorN(currentColor)
end

function color4()
  currentColor = 8 -- "magenta"
  colorN(currentColor)
end

function linestyle()
  currentLinestyle = currentLinestyle % #linestyleList + 1
  app.uiAction({["action"] = "ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle]})
  print("ACTION_TOOL_LINE_STYLE_" .. linestyleList[currentLinestyle])
end

function select()
  currentSelect = currentSelect % #selectList + 1
  app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
  print("ACTION_TOOL_SELECT_" .. selectList[currentSelect])
end

function tool()
  currentTool = currentTool % #toolList + 1
  if (toolList[currentTool] == "SELECTION") then
    app.uiAction({["action"] = "ACTION_TOOL_SELECT_" .. selectList[currentSelect]})
    print("ACTION_TOOL_SELECT_" .. selectList[currentSelect])
  else   
    app.uiAction({["action"] = "ACTION_TOOL_" .. toolList[currentTool]})
    print("ACTION_TOOL_" .. toolList[currentTool])
  end
end

function eraser()
  currentEraser = currentEraser % #eraserList + 1
  app.uiAction({["action"] = "ACTION_TOOL_ERASER_" .. eraserList[currentEraser]})
  print("ACTION_TOOL_ERASER_" .. eraserList[currentEraser])
end

function drawingtype()
  currentDrawingtype = currentDrawingtype % #drawingtypeList + 1
  app.uiAction({["action"] = "ACTION_" .. drawingtypeList[currentDrawingtype]})
  print("ACTION_" .. drawingtypeList[currentDrawingtype])
end
