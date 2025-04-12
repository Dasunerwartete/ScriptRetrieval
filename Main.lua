print("Script Running!")

return function(pathStr)
	local function resolvePath(pathStr)
		local current = game
		for part in string.gmatch(pathStr, "[^%.]+") do
			if current:FindFirstChild(part) then
				current = current[part]
			else
				warn("Path part not found:", part)
				return nil
			end
		end
		return current
	end

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
			warn("Couldn't access script source (maybe running outside Roblox?)")
		end
	else
		warn("Target is not a script.")
	end
end
