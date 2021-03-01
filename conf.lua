

-- config file

-- configuration
  -- active les traces dans la console
  io.stdout:setvbuf('no')




  -- permet de faire du debug pas à pas dans ZeroBraneStudio
-- if arg[#arg] == '-debug' then require('mobdebug').start() end

  -- Debug dans vscode
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
  require("lldebugger").start()
end
io.stdout:setvbuf("no")
if arg[#arg] == "-debug" then require("mobdebug").start() end -- debug pas à pas


function love.conf(t)
  
  t.window.width = 1024
  t.window.height = 768
  t.window.highdpi = false
  t.window.fullscreen = true         -- Enable fullscreen (boolean)
    
  t.window.title = "Spatial Vessel"
  
end
