local username = game:GetService("Players").LocalPlayer.Name
local userid = game:GetService("Players").LocalPlayer.UserId
local icon = "https://www.roblox.com/headshot-thumbnail/image?userId="..userid.."&width=420&height=420&format=png"

local Headers = {["content-type"] = "application/json"} 
local Chat = game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller


Chat.ChildAdded:Connect(function(instance)
    if string.find(instance.TextLabel.Text,"Timothy") then
        local OSTime = os.time()
        local Webhook = _G.Webhook
        local Time = os.date('!*t', OSTime)

        local HatchText
        local Dontsend

        if string.find(instance.TextLabel.Text,"Shiny") then
            Dontsend = false
            HatchText = "DTimothyR Just Hatched A **Shiny** Pet!"
        end

        local SecretPing
        if string.find(instance.TextLabel.Text,"Shiny") then
            SecretPing = _G.Hatchping
        end

        if Dontsend == false then
            local Info = {
                ["content"] = SecretPing,
                ["embeds"] = {
                    {
                        ["description"] = HatchText,
                        ["author"] = {
                            ["name"] = username,
                            ["url"] = "https://www.roblox.com/users/".. userid .."/profile",
                            ["icon_url"] = icon,
                        },
                        ["thumbnail"] = {
                            ["url"] = "https://cdn.discordapp.com/attachments/960502448705925150/1015972653787512844/unknown.png"
                        },
                        ['timestamp'] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["color"] = "0xffd700"
                    }
                }
            }
                        local Info = game:GetService("HttpService"):JSONEncode(Info)
                        local HttpRequest = http_request;
                        if syn then HttpRequest = syn.request else HttpRequest = http_request end
                        HttpRequest({Url=Webhook, Body=Info, Method="POST", Headers=Headers})
        end
    end
end)
