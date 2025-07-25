AddEventHandler("Vehicles:Client:EnterVehicle", function(currentVehicle, currentSeat)
	GLOBAL_VEH = currentVehicle
	Hud.Vehicle:Show()
	--Hud.Minimap:Set()
end)

AddEventHandler("Vehicles:Client:ExitVehicle", function(currentVehicle, currentSeat)
	Hud.Vehicle:Hide()
	GLOBAL_VEH = nil
end)

AddEventHandler("Characters:Client:Spawn", function()
	SendNUIMessage({
		type = "SET_CONFIG",
		data = {
			config = LocalPlayer.state.Character:GetData("HUDConfig"),
		},
	})

	Hud:Show()

	DisplayRadar(hasValue(LocalPlayer.state.Character:GetData("States"), "GPS"))
	Hud:ShiftLocation(hasValue(LocalPlayer.state.Character:GetData("States"), "GPS"))
	Hud:ShowLocation(hasValue(LocalPlayer.state.Character:GetData("States"), "GPS"))
end)

RegisterNetEvent("UI:Client:Reset", function(manual)
	Hud:Hide()
	SendNUIMessage({
		type = "UI_RESET",
		data = {
			manual = manual,
		},
	})

	if LocalPlayer.state.Character ~= nil then
		SendNUIMessage({
			type = "SET_CONFIG",
			data = {
				config = LocalPlayer.state.Character:GetData("HUDConfig"),
			},
		})
	end

	Action:Hide()
	ListMenu:Close()
	Interaction:Hide()
	Notification:Clear()
	Confirm:Close()
	Input:Close()
	InfoOverlay:Close()
	Hud.Meth:Close()

	TriggerEvent("UI:Client:ResetFinished", manual)

	if manual then
		Citizen.Wait(2500)
		Hud:Show()
		if Phone:IsOpen() or hasValue(LocalPlayer.state.Character:GetData("States"), "GPS") then
			DisplayRadar(true)
		end
	end
end)

RegisterNetEvent("Characters:Client:Logout", function()
	TriggerEvent("UI:Client:Reset")
end)

AddEventHandler("Vehicles:Client:Seatbelt", function(state)
	SendNUIMessage({
		type = "UPDATE_SEATBELT",
		data = { seatbelt = state },
	})
end)

AddEventHandler("Vehicles:Client:Cruise", function(state)
	SendNUIMessage({
		type = "UPDATE_CRUISE",
		data = { cruise = state },
	})
end)

AddEventHandler("Vehicles:Client:Ignition", function(state)
	SendNUIMessage({
		type = "UPDATE_IGNITION",
		data = { ignition = state },
	})
end)

AddEventHandler("Vehicles:Client:Fuel", function(amount, show)
	SendNUIMessage({
		type = "UPDATE_FUEL",
		data = {
			fuel = amount,
			fuelHide = show,
		},
	})
end)

RegisterNetEvent("Status:Client:Update", function(status, value)
	SendNUIMessage({
		type = "UPDATE_STATUS_VALUE",
		data = { name = status, value = value },
	})
end)

RegisterNetEvent("Progress:Client:Progress", function(action, cb)
	Progress:Progress(action, cb)
end)

RegisterNetEvent("Progress:Client:ProgressWithStartEvent", function(action, start, finish)
	Progress:ProgressWithStartEvent(action, start, finish)
end)

RegisterNetEvent("Progress:Client:ProgressWithTickEvent", function(action, tick, finish)
	Progress:ProgressWithTickEvent(action, tick, finish)
end)

RegisterNetEvent("Progress:Client:ProgressWithStartAndTick", function(action, start, tick, finish)
	Progress:ProgressWithStartAndTick(action, start, tick, finish)
end)

RegisterNetEvent("Progress:Client:Cancel", function()
	Progress:Cancel()
end)

RegisterNetEvent("Progress:Client:Fail", function()
	Progress:Fail()
end)

RegisterNUICallback("Progress:Finish", function(data, cb)
	Progress:Finish()
	cb("ok")
end)

AddEventHandler("Targeting:Client:UpdateState", function(isTargeting, hasTarget)
	SendNUIMessage({
		type = (isTargeting and "SHOW_EYE" or "HIDE_EYE"),
		data = {
			icon = (type(hasTarget) == "string" and hasTarget or false),
		},
	})
end)

AddEventHandler("Targeting:Client:OpenMenu", function(menuData)
	SetNuiFocus(true, true)
	SetCursorLocation(0.5, 0.5)
	SendNUIMessage({
		type = "OPEN_MENU",
		data = {
			menu = menuData,
		},
	})
end)

AddEventHandler("Targeting:Client:CloseMenu", function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "CLOSE_MENU",
		data = {},
	})
end)

RegisterNetEvent("UI:Client:Configure", function()
	SetNuiFocus(true, true)
	SendNUIMessage({
		type = "TOGGLE_SETTINGS",
		data = {
			state = true,
		},
	})
end)

RegisterNUICallback("targetingAction", function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "CLOSE_MENU",
		data = {},
	})
	TriggerEvent("Targeting:Client:MenuSelect", data and data.event, data and data.data or {})
	cb("ok")
end)

RegisterNUICallback("CloseUI", function(data, cb)
	SetNuiFocus(false, false)
	cb("OK")
end)

RegisterNUICallback("SaveConfig", function(data, cb)
	Callbacks:ServerCallback("HUD:SaveConfig", data, function(s)
		cb(s)
	end)
end)
