if game.PlaceId == 8884433153 then
	local username = game:GetService("Players").LocalPlayer.Name
	local userid = game:GetService("Players").LocalPlayer.UserId
	local icon = "https://www.roblox.com/headshot-thumbnail/image?userId="..userid.."&width=420&height=420&format=png"
	local NewColor = (_G.Color == "" and "fffff") or _G.Color
	local number = 1
	local number2 = 1
	local number3 = 1
	
	if _G.SendNotifications == true then
    	game.StarterGui:SetCore(
               	"SendNotification",
                {
			Title = "MS2 Stats Tracker",
			Text = "Version 1.0.0, Updated and Maintained by PetSimulatorXPlayer#5011",
			Duration = 5
		}
	)
	elseif _G.SendNotifications == false then
        end
	
	function abb(Value)
		local Number
		local Formatted = Value
		while true do
        		Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        		if (Number == 0) then
            			break
        		end
    		end
    		return Formatted
	end
	
    local plr = game.Players.LocalPlayer
    local OnlyCount = {plr.Name}
    
    local count = 0 
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        for n,b in pairs(OnlyCount) do
            if string.find(v.Name, b) then
                count = v["Gold"].Value    
            end
        end
    end
   
    print("MS2 Stats Tracker V1.0.0, Maintained and Updated by PetSimulatorXPlayer#5011")
    
    while wait(_G.Intervals) do
        
        -- Eggs
        count1 = 0
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            for n,b in pairs(OnlyCount) do
                if string.find(v.Name, b) then
                    count1 = v["Gold"].Value    
                end
            end
        end
        local EggsHatchedPer1 = count1 - count
        count = count + EggsHatchedPer1

		
        local Webhooksss = _G.Webhookss
        local OSTime = os.time();
        local Time = os.date('!*t', OSTime);
        timestamp = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec);
        local msg = {
            ["embeds"] = {
                {
                    ["title"] = username .. "'s Collect All Pets Stat Data",
                    ["color"] = tonumber(tostring("0x" .. NewColor)),
                    ["description"] = "Some of these stats wont be exact. Some are just estimates",
                    ["thumbnail"] = {
                        ["url"] = icon
                    },
                    ["fields"] = {},
                    ["footer"] = {
                        ["text"] = "Updates every " .. _G.Intervals .. " Seconds | Collect All Pets"
                    },
                    ['timestamp'] = timestamp,
                }
            }
        }
        if _G.EggCount == true then
            local EggsCountEmbed = {
            	["name"] = "Gold Data",
            	["value"] = abb(count1) .. " Gold! | *+" .. abb(EggsHatchedPer1) .. " in the last " .. _G.Intervals .. " seconds*",
            	["inline"] = false
        	    }
            	table.insert(msg["embeds"][1]["fields"], EggsCountEmbed)
        end
        request = http_request or request or HttpPost or syn.request
        request({Url = Webhooksss, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})
    end
end