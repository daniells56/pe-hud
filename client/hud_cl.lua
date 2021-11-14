local showMap, showBars, showArmor, showOxygen, isOpen, cinematicHud, isPaused
local pulseHealth, pulseArmor, pulseStamina, pulseOxygen
local healthActive, armorActive, hungerActive, thirstActive, stressActive, staminaActive, oxygenActive, microphoneActive, timeActive, cinematicActive, idActive
local healthSwitch, armorSwitch, hungerSwitch, thirstSwitch, stressSwitch, staminaSwitch, oxygenSwitch, microphoneSwitch, timeSwitch, cinematicSwitch, idSwitch


local whisper, normal, shout = 33, 66, 100 




local x, y = guiGetScreenSize()
local link = "http://mta/"..getResourceName(getThisResource()).."/html/ui.html"
local browser = createBrowser(x, y, true, true)
local microphone = false
local inWater = false

setDevelopmentMode(true, true)

addEventHandler("onClientBrowserCreated", browser, function()
   loadBrowserURL(source, link)
end)


function SendNUIMessage(browser, table)
   if isElement(browser) and type(table) == "table" then
      return executeBrowserJavascript(browser, 'window.postMessage('..toJSON(table)..'[0])')
   end
end


function dxNUI()

    dxDrawImage(0, 0, x, y, browser)

	local health = getElementHealth(localPlayer)
	local armor = getPedArmor(localPlayer)
	local hunger = getElementData(localPlayer, Config.Fome) or 100
	local thirst = getElementData(localPlayer, Config.Sede) or 100
	local oxygen = getPedOxygenLevel ( localPlayer ) / 10
	local time = getRealTime()
	hour = time.hour
	second = time.second

	if isElementInWater(localPlayer) then
		if not inWater then 
			triggerEvent('change', localPlayer, 'oxygen' )
			inWater = true
		end
	else
		if inWater then
			triggerEvent('change', localPlayer, 'oxygen' )
			inWater = false
		end
	end
	
	local id = getElementData(localPlayer, Config.id) or 0


	SendNUIMessage(browser, {
		action = "hud",
		health = health,
		armor = armor,
		hunger = hunger,
		thirst = thirst,
		stamina = 10,
		oxygen = oxygen,
		id = id,
		time = hour .. " : " .. second,
		microphone = a
	})

end
addEventHandler('onClientRender', getRootElement(), dxNUI) 


function VoiceStart()
	SendNUIMessage(browser, {action = 'microphoneShow'})
 end
 addEventHandler("onClientPlayerVoiceStart", localPlayer, VoiceStart)
 
 function VoiceStop()
	SendNUIMessage(browser, {action = 'microphoneHide'})
 end
 addEventHandler("onClientPlayerVoiceStop", localPlayer, VoiceStop)


addEvent('PE:change', true)
addEventHandler('PE:change', getRootElement(), function(action)
	if Config.useESX then
		if action == "hunger" then
			if not hungerActive then
				hungerActive = true
				hungerSwitch = true
				SendNUIMessage(browser,{action = 'hungerHide'})
			else
				hungerActive = false
				hungerSwitch = false
				SendNUIMessage(browser,{action = 'hungerShow'})
			end
		elseif action == "thirst" then
			if not thirstActive then
				thirstActive = true
				thirstSwitch = true
				SendNUIMessage(browser,{action = 'thirstHide'})
			else
				thirstActive = false
				thirstSwitch = false
				SendNUIMessage(browser,{action = 'thirstShow'})
			end
		end
		if Config.useStress then
			if action == "stress" then
				if not stressActive then
					stressActive = true
					stressSwitch = true
					SendNUIMessage(browser,{action = 'stressHide'})
				else
					stressActive = false
					stressSwitch = false
					SendNUIMessage(browser,{action = 'stressShow'})
				end
			end
		end
	end
    if action == "health" then
		if not healthActive then
			healthActive = true
			healthSwitch = true
			SendNUIMessage(browser,{action = 'healthHide'})
		else
			healthActive = false
			healthSwitch = false
			SendNUIMessage(browser,{action = 'healthShow'})
		end
    elseif action == "armor" then
		if not armorActive then
			armorActive = true
			armorSwitch = true
			SendNUIMessage(browser,{action = 'armorHide'})
		else
			armorActive = false
			armorSwitch = false
			SendNUIMessage(browser,{action = 'armorShow'})
		end
    elseif action == "stamina" then
		if not staminaActive then
			staminaActive = true
			staminaSwitch = true
			SendNUIMessage(browser,{action = 'staminaHide'})
		else
			staminaActive = false
			staminaSwitch = false
			SendNUIMessage(browser,{action = 'staminaShow'})
		end
	elseif action == "oxygen" then
		if not oxygenActive then
			oxygenActive = true
			oxygenSwitch = true
			SendNUIMessage(browser,{action = 'oxygenShow'})
		else
			oxygenActive = false
			oxygenSwitch = false
			SendNUIMessage(browser,{action = 'oxygenHide'})
		end
	elseif action == "id" then
		if not idActive then
			idActive = true
			idSwitch = true
			SendNUIMessage(browser,{action = 'idShow'})
		else
			idActive = false
			idSwitch = false
			SendNUIMessage(browser,{action = 'idHide'})
		end
		
	elseif action == "map" then
		if not showMap then
			showMap = true
			setPlayerHudComponentVisible ( 'radar', true )
		else
			showMap = false
			setPlayerHudComponentVisible ( 'radar', false )
		end
	elseif action == "cinematic" then
		if not cinematicActive then
			cinematicActive = true
			cinematicSwitch = true
			cinematicHud = true
			if not healthActive then
				healthActive = true
				SendNUIMessage(browser,{action = 'healthHide'})
			end
			if not armorActive then
				armorActive = true
				SendNUIMessage(browser,{action = 'armorHide'})
			end
			if not staminaActive then
				staminaActive = true
				SendNUIMessage(browser,{action = 'staminaHide'})
			end
			if Config.useESX then
				if not hungerActive then
					hungerActive = true
					SendNUIMessage(browser,{action = 'hungerHide'})
				end
				if not thirstActive then
					thirstActive = true
					SendNUIMessage(browser,{action = 'thirstHide'})
				end
				if Config.useStress then
					if not stressActive then
						stressActive = true
						SendNUIMessage(browser,{action = 'stressHide'})
					end
				end
			end
			if oxygenActive then
				oxygenActive = false
				SendNUIMessage(browser,{action = 'oxygenHide'})
			end
			if microphoneActive then
				microphoneActive = false
				SendNUIMessage(browser,{action = 'microphoneHide'})
			end
			if timeActive then
				timeActive = false
				SendNUIMessage(browser,{action = 'timeHide'})
			end
			if idActive then
				idActive = false
				SendNUIMessage(browser,{action = 'idHide'})
			end
			SendNUIMessage(browser,{action = 'cinematicShow'})
		else
			cinematicActive = false
			cinematicSwitch = false
			cinematicHud = false
			if healthActive and not healthSwitch then
				healthActive = false
				SendNUIMessage(browser,{action = 'healthShow'})
			end
			if armorActive and not armorSwitch and not showArmor then
				armorActive = false
				SendNUIMessage(browser,{action = 'armorShow'})
			end
			if staminaActive and not staminaSwitch then
				staminaActive = false
				SendNUIMessage(browser,{action = 'staminaShow'})
			end
			if Config.useESX then
				if hungerActive and not hungerSwitch then
					hungerActive = false
					SendNUIMessage(browser,{action = 'hungerShow'})
				end
				if thirstActive and not thirstSwitch then
					thirstActive = false
					SendNUIMessage(browser,{action = 'thirstShow'})
				end
				if Config.useStress then
					if stressActive and not stressSwitch then
						stressActive = false
						SendNUIMessage(browser,{action = 'stressShow'})
					end
				end
			end
			if not oxygenActive and oxygenSwitch and showOxygen then
				oxygenActive = true
				SendNUIMessage(browser,{action = 'oxygenShow'})
			end
			if not microphoneActive and microphoneSwitch then
				microphoneActive = true
				SendNUIMessage(browser,{action = 'microphoneShow'})
			end
			if not timeActive and timeSwitch then
				timeActive = true
				SendNUIMessage(browser,{action = 'timeShow'})
			end
			if not cinematicActive and cinematicSwitch then
				cinematicActive = true
				SendNUIMessage(browser,{action = 'cinematicShow'})
			end
			if not idActive and idSwitch then
				idActive = true
				SendNUIMessage(browser,{action = 'idShow'})
			end
			SendNUIMessage(browser,{action = 'cinematicHide'})
		end
	elseif action == "time" then
		if not timeActive then
			timeActive = true
			timeSwitch = true
			SendNUIMessage(browser,{action = 'timeShow'})
		else
			timeActive = false
			timeSwitch = false
			SendNUIMessage(browser,{action = 'timeHide'})
		end
	elseif action == "microphone" then
		if not microphoneActive then
			microphoneActive = true
			microphoneSwitch = true
			SendNUIMessage(browser,{action = 'microphoneShow'})
		else
			microphoneActive = false
			microphoneSwitch = false
			SendNUIMessage(browser,{action = 'microphoneHide'})
		end
    end
end)

addCommandHandler(Config.openCommand, function()
	if not isOpen then 
	SendNUIMessage(browser, { action = 'show' })
	isOpen = true 
	else 
		isOpen = false
		SendNUIMessage(browser, { action = 'hide' })
	end
end)


bindKey(Config.openKey, 'down', function()
	if not isOpen then 
	SendNUIMessage(browser, { action = 'show' })
	isOpen = true 
	showCursor(true)
	else 
		isOpen = false
		SendNUIMessage(browser, { action = 'hide' })
		showCursor(false)
	end
end)

addEvent('change', true)
addEventHandler('change', getRootElement(), function(data)
    triggerEvent('PE:change', getRootElement(), data)
end)




addEventHandler("onClientClick", root,
function(button, state)
	if state == "down" then
		injectBrowserMouseDown(browser, button)
	else
		injectBrowserMouseUp(browser, button)
	end 
end
)

addEventHandler("onClientCursorMove", root,
	function (relativeX, relativeY, absoluteX, absoluteY)
		injectBrowserMouseMove(browser, absoluteX, absoluteY)
	end
)


