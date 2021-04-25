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
  app.registerUi({["menu"] = "Color #5", ["callback"] = "color5", ["accelerator"] = "<Alt>5"});
  app.registerUi({["menu"] = "Color #6", ["callback"] = "color6", ["accelerator"] = "<Alt>6"});
  app.registerUi({["menu"] = "Color #7", ["callback"] = "color7", ["accelerator"] = "<Alt>7"});
  app.registerUi({["menu"] = "Color #8", ["callback"] = "color8", ["accelerator"] = "<Alt>8"});
  app.registerUi({["menu"] = "Color #9", ["callback"] = "color9", ["accelerator"] = "<Alt>9"});
  app.registerUi({["menu"] = "Color #0", ["callback"] = "color0", ["accelerator"] = "<Alt>0"});

  app.registerUi({["menu"] = "Set up keyboard shortcuts", ["callback"] = "showDialog2"});

  sourcePath = debug.getinfo(1).source:match("@?(.*/)")
  print(sourcePath)
end


local currentFill = false
local currentRotsnap = false
local currentGridsnap = false 



function showDialog2()
  print("0 llega hasta aca")
  local hasLgi, lgi = pcall(require, "lgi")
  if not hasLgi then
    app.msgbox("You need to have the Lua lgi-module installed and included in your Lua package path in order to use the GUI for migrating font sizes. \n\n", {[1]="OK"})
    return
  end
  print("1")
  --lgi module has been found
  local Gtk2 = lgi.Gtk
  print("1.1")
  local Gdk = lgi.Gdk
  print("1.2")
  local assert = lgi.assert
  print("2")
  local builder = Gtk.Builder()
  assert(builder:add_from_file(sourcePath .. "dialog.glade"))
  local ui = builder.objects
  print("3")
  local dialog = ui.dlgKeys

  print("99 llega hasta aca")

  -- if not currDpi then 
  --   currDpi = app.getDisplayDpi()
  -- end
  -- ui.spbtOldDpi:set_value(currDpi)
  -- ui.lblCurrentDpi:set_text(app.getDisplayDpi())
  -- ui.spbtScaleFactor:set_value(currDpi/72)

-- Connect actions
  function ui.btSave.on_clicked()
    local a = 0
    -- local factor = ui.spbtScaleFactor:get_value()
    -- resize(factor)
  end

  function ui.btCancel.on_clicked()
    dialog:destroy()
  end

  -- function ui.spbtScaleFactor.on_value_changed()
  --   factor = ui.spbtScaleFactor:get_value()
  --   currDpi = math.floor(factor*72+0.5)
  --   ui.spbtOldDpi:set_value(currDpi)
 --  end

  -- function ui.spbtOldDpi.on_value_changed()
  --   oldDpi = ui.spbtOldDpi:get_value()
  --   ui.spbtScaleFactor:set_value(oldDpi/72)
  -- end

  dialog:show_all()
end 

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

-- function colorN(currentColor)
--   app.changeToolColor({["color"] = colorList[currentColor][2], ["selection"] = true})
--   print("Color: " .. colorList[currentColor][1])
-- end

function colorN(hexColor)
  app.changeToolColor({["color"] = hexColor, ["selection"] = true})
  print("Color: " .. hexColor)
end

function color1()
  hexColor = 0xFFFFFF -- "white"
  colorN(hexColor)
end

function color2()
  hexColor = 0xFF8000 -- "orange"
  colorN(hexColor)
end

function color3()
  hexColor = 0x00C0FF -- "light blue"
  colorN(hexColor)
end

function color4()
  hexColor = 0xFFEC30 -- "yellow"
  colorN(hexColor)
end

function color5()
  hexColor = 0xF61F1F -- "red"
  colorN(hexColor)
end
function color6()
  hexColor = 0x73D216 -- "green"
  colorN(hexColor)
end
function color7()
  hexColor = 0xA44D9C -- "violet"
  colorN(hexColor)
end
function color8()
  hexColor = 0xFF43ED -- "pink"
  colorN(hexColor)
end
function color9()
  hexColor = 0x6C67FF -- "blue"
  colorN(hexColor)
end

function color0()
  hexColor = 0x656565 -- "gray"
  colorN(hexColor)
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
