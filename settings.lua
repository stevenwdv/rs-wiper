---@class MapSettings : {[string]:nil}
---@field rsw-only-admins {value:boolean}

---@class PlayerSettings : {[string]:nil}
---@field rsw-require-alt {value:boolean}
---@field rsw-clear-belts {value:boolean}
---@field rsw-clear-items-on-ground {value:boolean}
---@field rsw-clear-machine-items {value:boolean}
---@field rsw-clear-fluids {value:boolean}
---@field rsw-clear-roboports {value:boolean}
---@field rsw-clear-robots {value:boolean}
---@field rsw-clear-ammo {value:boolean}
---@field rsw-clear-vehicles {value:boolean}
---@field rsw-clear-containers {value:boolean}

data:extend {
	{
		type = "bool-setting",
		name = "rsw-only-admins",
		setting_type = "runtime-global",
		default_value = true,
	},

	{
		type = "bool-setting",
		name = "rsw-require-alt",
		setting_type = "runtime-per-user",
		default_value = true,
	},

	{
		type = "bool-setting",
		name = "rsw-clear-belts",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-items-on-ground",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-machine-items",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-fluids",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-roboports",
		setting_type = "runtime-per-user",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-robots",
		setting_type = "runtime-per-user",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-ammo",
		setting_type = "runtime-per-user",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-vehicles",
		setting_type = "runtime-per-user",
		default_value = false,
	},
	{
		type = "bool-setting",
		name = "rsw-clear-containers",
		setting_type = "runtime-per-user",
		default_value = true,
	},
}
