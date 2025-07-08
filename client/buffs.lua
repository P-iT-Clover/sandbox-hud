AddEventHandler("Buffs:Shared:DependencyUpdate", RetrieveComponents)
function RetrieveComponents()
	Buffs = exports["pt-base"]:FetchComponent("Buffs")
	Hud = exports["pt-base"]:FetchComponent("Hud")
	Callbacks = exports["pt-base"]:FetchComponent("Callbacks")
	Progress = exports["pt-base"]:FetchComponent("Progress")
	Action = exports["pt-base"]:FetchComponent("Action")
	Keybinds = exports["pt-base"]:FetchComponent("Keybinds")
	ListMenu = exports["pt-base"]:FetchComponent("ListMenu")
	Notification = exports["pt-base"]:FetchComponent("Notification")
	Minigame = exports["pt-base"]:FetchComponent("Minigame")
	Interaction = exports["pt-base"]:FetchComponent("Interaction")
	Utils = exports["pt-base"]:FetchComponent("Utils")
	Phone = exports["pt-base"]:FetchComponent("Phone")
	Inventory = exports["pt-base"]:FetchComponent("Inventory")
	Weapons = exports["pt-base"]:FetchComponent("Weapons")
	Jail = exports["pt-base"]:FetchComponent("Jail")
	Animations = exports["pt-base"]:FetchComponent("Animations")
	Admin = exports["pt-base"]:FetchComponent("Admin")
end

AddEventHandler("Core:Shared:Ready", function()
	exports["pt-base"]:RequestDependencies("Buffs", {
		"Buffs",
		"Hud",
		"Callbacks",
		"Action",
		"Progress",
		"Keybinds",
		"ListMenu",
		"Notification",
		"Minigame",
		"Interaction",
		"Utils",
		"Phone",
		"Inventory",
		"Weapons",
		"Jail",
		"Animations",
		"Admin",
	}, function(error)
		if #error > 0 then
			return
		end
		RetrieveComponents()
	end)
end)

local _runningIds = 1
local _buffDefs = {}

local _BUFFS = {
	RegisterBuff = function(self, id, icon, color, duration, type)
		_buffDefs[id] = {
			icon = icon,
			color = color,
			duration = duration,
			type = type,
		}
		SendNUIMessage({
			type = "REGISTER_BUFF",
			data = {
				id = id,
				data = {
					icon = icon,
					color = color,
					duration = duration,
					type = type,
				},
			},
		})
	end,
	ApplyBuff = function(self, buffId, val, override, options)
		SendNUIMessage({
			type = "BUFF_APPLIED",
			data = {
				instance = {
					buff = buffId,
					override = override,
					val = math.ceil(val or 0),
					options = options or {},
					startTime = GetCloudTimeAsInt(),
				},
			},
		})
	end,
	ApplyUniqueBuff = function(self, buffId, val, override, options)
		SendNUIMessage({
			type = "BUFF_APPLIED_UNIQUE",
			data = {
				instance = {
					buff = buffId,
					override = override,
					val = math.ceil(val or 0),
					options = options or {},
					startTime = GetCloudTimeAsInt(),
				},
			},
		})
	end,
	UpdateBuff = function(self, buffId, nVal)
		SendNUIMessage({
			type = "BUFF_UPDATED",
			data = {
				buff = buffId,
				val = nVal,
			},
		})
	end,
	IconOverride = function(self, buffId, override)
		SendNUIMessage({
			type = "BUFF_UPDATED",
			data = {
				buff = buffId,
				override = override,
			},
		})
	end,
	RemoveBuffType = function(self, buffId)
		SendNUIMessage({
			type = "REMOVE_BUFF_BY_TYPE",
			data = {
				type = buffId,
			},
		})
	end,
}

AddEventHandler("Proxy:Shared:RegisterReady", function()
	exports["pt-base"]:RegisterComponent("Buffs", _BUFFS)
end)

RegisterNetEvent("Characters:Client:Spawned", function()
    _BUFFS:RegisterBuff("prog_mod", "mug-hot", "#D6451A", -1, "timed")
    _BUFFS:RegisterBuff("stress_ticks", "joint", "#de3333", -1, "timed")
    _BUFFS:RegisterBuff("heal_ticks", "suitcase-medical", "#52984a", -1, "timed")
    _BUFFS:RegisterBuff("armor_ticks", "dumbbell", "#4056b3", -1, "timed")
end)

RegisterNetEvent("Characters:Client:Logout", function()
    _BUFFS:RemoveBuffType("prog_mod")
    _BUFFS:RemoveBuffType("stress_ticks")
    _BUFFS:RemoveBuffType("heal_ticks")
    _BUFFS:RemoveBuffType("armor_ticks")
end)
