require 'lsmodule'
require 'args'
require 'evar'


local exec = lslua.exec

-- Evars
evar.mnStartMenuShown = false
evar.mnSysTrayShown = false
evar.mnWeatherShown = true

-- Weather Code Translation Table
local weatherTrans = {
	[0] = 'Tornado',
	[1] = 'Tropical Storm',
	[2] = 'Hurricane',
	[3] = 'Severe Thunderstorms',
	[4] = 'Thunderstorms',
	[5] = 'Mixed Rain and Snow',
	[6] = 'Mixed Rain and Sleet',
	[7] = 'Mixed Snow and Sleet',
	[8] = 'Freezing Drizzle',
	[9] = 'Drizzle',
	[10] = 'Freezing Rain',
	[11] = 'Showers',
	[12] = 'Showers',
	[13] = 'Snow Flurries',
	[14] = 'Light Snow Showers',
	[15] = 'Blowing Snow',
	[16] = 'Snow',
	[17] = 'Hail',
	[18] = 'Sleet',
	[19] = 'Dust',
	[20] = 'Foggy',
	[21] = 'Haze',
	[22] = 'Smoky',
	[23] = 'Blustery',
	[24] = 'Windy',
	[25] = 'Cold',
	[26] = 'Cloudy',
	[27] = 'Mostly Cloudy',
	[28] = 'Mostly Cloudy',
	[29] = 'Partly Cloudy',
	[30] = 'Partly Cloudy',
	[31] = 'Clear',
	[32] = 'Sunny',
	[33] = 'Fair',
	[34] = 'Fair',
	[35] = 'Mixed Rain and Hail',
	[36] = 'Hot',
	[37] = 'Isolated Thunderstorms',
	[38] = 'Scattered Thunderstorms',
	[39] = 'Scattered Thunderstorms',
	[40] = 'Scattered Showers',
	[41] = 'Heavy Snow',
	[42] = 'Scattered Snow Showers',
	[43] = 'Heavy Snow',
	[44] = 'Partly Cloudy',
	[45] = 'Thundershowers',
	[46] = 'Snow Showers',
	[47] = 'Isolated Thundershowers',
	[3200] = 'Not Available'
}

-- Modules
local labels = lsmodule.xlabel

-- Module Instances
local taskbar = lsmodule.xtaskbar.xtaskbar
local tray = lsmodule.xtray.xtray

-- Module Instance Tables
local weather = {
	labels.mnWeatherNow,
	labels.mnWeatherToday,
	labels.mnWeatherTomorrow
}

local startMenu = {
	labels.mnMyComputer,
	labels.mnControlPanel,
	labels.mnVolume,
	labels.mnTrash,
	labels.mnShutdown
}

-- Local Functions
local function average(a, b)
	local a, b = tonumber(a), tonumber(b)
	
	return math.floor(((a + b) / 2) + 0.5)
end


-- Start Menu Toggle
function bang_mnToggleStartMenu()
	if evar.toboolean('mnStartMenuShown') then
		for i = #startMenu, 1, -1 do 
			local item = startMenu[i]
			
			local x = item.CurrentWidth * -1
			
			item:moveby(x, 0, 20, 5)
		end
		
		evar.mnStartMenuShown = false
	else
		for _, item in ipairs(startMenu) do
			local x = item.CurrentWidth
			
			item:moveby(x, 0, 20, 5)
		end
		
		evar.mnStartMenuShown = true
	end
end

-- Sys Tray Toggle
function bang_mnToggleSysTray()
	if evar.toboolean('mnSysTrayShown') then
		local y = (tray.CurrentHeight + 10) * -1
		
		tray:moveby(0, y, 15, 1)
		
		if taskbar.CurrentButtonCount > 6 then
			taskbar:moveby(0, y, 20, 5)
			taskbar:refresh('AutoSize', 1453)
			taskbar:moveby(0, y * -1, 20, 5)
		else
			taskbar:refresh('AutoSize', 1453)
		end
		
		evar.mnSysTrayShown = false
	else
		local y = tray.CurrentHeight + 10
		local tWidth = 1453 - (tray.CurrentWidth + 5)
		
		tray:moveby(0, y, 15, 1)
		
		if taskbar.CurrentWidth > tWidth then
			taskbar:moveby(0, y * -1, 20, 5)
			taskbar:refresh('AutoSize', tWidth)
			taskbar:moveby(0, y, 20, 5)
		else
			taskbar:refresh('AutoSize', tWidth)
		end
		
		evar.mnSysTrayShown = true
	end
end

-- Weather Toggle
function bang_mnToggleWeather()
	if evar.toboolean('mnWeatherShown') then
		for _, item in ipairs(weather) do
			local x = item.CurrentWidth
			
			item:moveby(x, 0, 20, 5)
		end
		
		evar.mnWeatherShown = false
	else
		for i = #weather, 1, -1 do
			local item = weather[i]
			
			local x = item.CurrentWidth * -1
			
			item:moveby(x, 0, 20, 5)
		end
		
		evar.mnWeatherShown = true
	end
end

-- Weather Update
function bang_mnUpdateWeather(data)
	local now = weather[1]
	local today = weather[2]
	local tomorrow = weather[3]
	
	local nowTemp, nowCode, todayDay, todayLow, todayHi, todayCode, tomorrowDay, tomorrowLow, tomorrowHi, tomorrowCode = args.mstrsplit(data, ' ')
	
	local todayTemp = tostring(average(todayLow, todayHi))
	local tomorrowTemp = tostring(average(tomorrowLow, tomorrowHi))
	
	exec('!SetEvar', 'mnWeatherNowTempText', '"' .. nowTemp .. '"')
	exec('!SetEvar', 'mnWeatherNowIconImage', '"weather/' .. nowCode .. '.png"')
	now:refreshoverlay('mnWeatherNowIcon', 'Tooltip', '"[upperCase(\'' .. weatherTrans[tonumber(nowCode)] .. '\')]"')
	
	exec('!SetEvar', 'mnWeatherTodayDayText', '"<font color=#$mnBlue$>[[</font> [upperCase(\'' .. todayDay .. '\')] <font color=#$mnBlue$>]]</font>"')
	exec('!SetEvar', 'mnWeatherTodayTempText', '"' .. todayTemp .. '"')
	exec('!SetEvar', 'mnWeatherTodayIconImage', '"weather/' .. todayCode .. '.png"')
	today:refreshoverlay('mnWeatherTodayIcon', 'Tooltip', '"[upperCase(\'' .. weatherTrans[tonumber(todayCode)] .. '\')]"')
	
	exec('!SetEvar', 'mnWeatherTomorrowDayText', '"<font color=#$mnBlue$>[[</font> [upperCase(\'' .. tomorrowDay .. '\')] <font color=#$mnBlue$>]]</font>"')
	exec('!SetEvar', 'mnWeatherTomorrowTempText', '"' .. tomorrowTemp .. '"')
	exec('!SetEvar', 'mnWeatherTomorrowIconImage', '"weather/' .. tomorrowCode .. '.png"')
	tomorrow:refreshoverlay('mnWeatherTomorrowIcon', 'Tooltip', '"[upperCase(\'' .. weatherTrans[tonumber(tomorrowCode)] .. '\')]"')
end