local Players = game:GetService("Players")

local function resolvePath(pathStr)
    local current = game
    for part in string.gmatch(pathStr, "[^%.]+") do
      if current:FindFirstChild(part) then
        current = current[part]
      else
        return nil
      end
    end
    return current
end

Players.PlayerAdded:Connect(function(player)
    players.Chatted:Connect(function(msg)
        local prefix = "!source"
        if msg:sub(1, #prefix):lower() == prefix then
          local pathStr = msg:sub(#prefix + 1)

          local target = resolvePath(pathStr)
          if not target then
              warn("Target not found at path:", pathStr)
              return
          end

          if target:IsA("Script") or target:IsA("LocalScript") or target:IsA("ModuleScript") then
              local source
              pcall(function()
                  source = target.Source
              end)

              if source then
                  print("Source of " .. pathStr .. ":\n" .. source)
              else
                warn("Couldn't access source of script (might be protected or run outside of Roblox).")
              end
          else
              warn("Target is not a script.")
          end
      end
  end)
end)
