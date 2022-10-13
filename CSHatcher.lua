-- Getting The Text color
function toHex(x) 
    local hex =  string.format("%x", x)
    return hex:len() == 1 and "0"..hex or hex
end
function RGB2HEX(r,g,b) 
    return "0x" .. toHex(r) .. toHex(g) .. toHex(b)
end

-- Comma's
function comma_value(amount)
    local formatted = amount
    while true do  
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k==0) then
            break
        end
    end
    return formatted
end

-- Abbreviating
local abbreviations = {
    Ud = 10^36;
    De = 10^33;
	N = 10^30;
	O = 10^27;
	Sp = 10^24;
	Sx = 10^21;
	Qn = 10^18;
	Qd = 10^15;
	T = 10^12;
	B = 10^9;
	M = 10^6;
	K = 10^3
}


function abb(number)
	
	
	local abbreviatedNum = number
	local abbreviationChosen = 0
	
	
	for abbreviation, num in pairs(abbreviations) do
		
		if number >= num and num > abbreviationChosen then
			
			local shortNum = number / num
			local intNum = math.floor(shortNum)
				
			abbreviatedNum = tostring(intNum) .. abbreviation .. "+"
			abbreviationChosen = num
		end
	end
	
	return abbreviatedNum
end

-- User Info
local HttpService = game:GetService("HttpService")
local Player = game:GetService("Players").LocalPlayer
local username = game:GetService("Players").LocalPlayer.Name
local userid = game:GetService("Players").LocalPlayer.UserId
local icon = "https://www.roblox.com/headshot-thumbnail/image?userId="..userid.."&width=420&height=420&format=png"


local playerNames = {_G.playerNames}


-- Chat Connection
local Headers = {["content-type"] = "application/json"}
local Chat = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller

-- The Hatcher
Chat.ChildAdded:Connect(function(instance)
    for _, playerName in pairs(_G.playerNames) do
        if string.find(instance.TextLabel.Text, "Server") then
            if string.find(instance.TextLabel.Text, playerName) then
                
                local OSTime = os.time()
                local Webhook = _G.WebhookLink
                local Time = os.date('!*t', OSTime)
                local TextColor3 = instance.TextLabel.TextColor3
                local SecretPing
                if string.find(instance.TextLabel.Text, "Secret") then
                    SecretPing = _G.SecretPing
                else
                    SecretPing = ""
                end
                
                -- Webhook
                local Data = {
                    ["content"] = SecretPing,
                    ["embeds"] = {{
                        ["description"] = instance.TextLabel.Text,
                        ["author"] = {
                            ["name"] = username,
                            ["url"] = "https://www.roblox.com/users/".. userid .."/profile",
                            ["icon_url"] = icon,
                        },
                        ["thumbnail"] = {
                            ["url"] = ""
                        },
                        ["color"] =  tonumber(RGB2HEX(unpack({TextColor3.R*255,TextColor3.G*255,TextColor3.B*255}))),
                        ["footer"] = {
                            ["text"] = "Eggs Hatched:" .. comma_value(game:GetService("Players")[playerName].leaderstats.Eggs.Value) .. " | Total Pet Power: " .. abb(game:GetService("Players")[playerName].leaderstats["Pet Power"].Value),
                        },
                        ['timestamp'] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),

                    }}
                }
                local HttpRequest = syn and syn.request or http_request
                HttpRequest({Url=Webhook, Body=HttpService:JSONEncode(Data), Method="POST", Headers=Headers})
            end
        
        end       
    end
end)
