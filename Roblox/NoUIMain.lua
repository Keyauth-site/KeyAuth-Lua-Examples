local License = "" --* Your License to use this script.

print(' EpicAuth Lua Example - https://github.com/mazk5145/')
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "EpicAuth Lua Example"

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Intializing Authentication...",
	Duration = 5
})

--* Configuration *--
local initialized = false
local sessionid = ""


--* Application Details *--
Name = "" --* Application Name
Ownerid = "" --* OwnerID
APPVersion = "1.0"     --* Application Version

local req = game:HttpGet('https://EpicAuth.cc/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=init&ver=' .. APPVersion)

if req == "EpicAuth_Invalid" then 
   print(" Error: Application not found.")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Application not found.",
	   Duration = 3
   })

   return false
end

local data = HttpService:JSONDecode(req)

if data.success == true then
   initialized = true
   sessionid = data.sessionid
   --print(req)
elseif (data.message == "invalidver") then
   print(" Error: Wrong application version..")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Wrong application version..",
	   Duration = 3
   })

   return false
else
   print(" Error: " .. data.message)
   return false
end

print("\n\n Licensing... \n")
local req = game:HttpGet('https://EpicAuth.cc/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=license&key=' .. License ..'&ver=' .. APPVersion .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)


if data.success == false then 
    StarterGui:SetCore("SendNotification", {
	    Title = LuaName,
	    Text = " Error: " .. data.message,
	    Duration = 5
    })

    return false
end

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = " Successfully Authorized :)",
	Duration = 5
})


--* Your code here *--

--* Example Code to show user data *-- 
print(' Logged In!')
print(' User Data')
print(' Username:' .. data.info.username)
print(' IP Address:' .. data.info.ip)
print(' Created at:' .. data.info.createdate)
print(' Last login at:' .. data.info.lastlogin)