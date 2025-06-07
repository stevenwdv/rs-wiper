local lualib_util = require "__core__.lualib.util"

local belts = {
	"lane-splitter",
	"linked-belt",
	"loader-1x1",
	"loader",
	"splitter",
	"transport-belt",
	"underground-belt",
}
local is_belt = lualib_util.list_to_map(belts)

local vehicles = {
	"artillery-wagon",
	"car",
	"cargo-pod",
	"cargo-wagon",
	"fluid-wagon",
	"locomotive",
	"spider-vehicle",
}
local is_vehicle = lualib_util.list_to_map(vehicles)

local containers = {
	"cargo-landing-pad",
	"container",
	"infinity-container",
	"linked-container",
	"logistic-container",
	"proxy-container",
	"space-platform-hub",
	"temporary-container",
}
local is_container = lualib_util.list_to_map(containers)

local turrets = {
	"ammo-turret",
	"artillery-turret",
	"artillery-wagon",
	"fluid-turret",
}
local is_turret = lualib_util.list_to_map(turrets)

local robots = {
	"capture-robot",
	"construction-robot",
	"logistic-robot",
}
local is_robot = lualib_util.list_to_map(robots)

---@param inventory LuaInventory|nil
local function clear_inventory(inventory)
	if inventory then
		inventory.clear()
	end
end

---@class (exact) WiperOptions
---@field clear_belts boolean
---@field clear_items_on_ground boolean
---@field clear_machine_items boolean
---@field clear_fluids boolean
---@field clear_roboports boolean
---@field clear_robots boolean
---@field clear_ammo boolean
---@field clear_vehicles boolean
---@field clear_containers boolean

---@param entities LuaEntity[]
---@param options WiperOptions
local function wipe_area(entities, options)
	---@type table<string,defines.inventory[]>
	local inventories = {
		["agricultural-tower"] = { defines.inventory.agricultural_tower_input },
		["assembling-machine"] = { defines.inventory.crafter_input, defines.inventory.crafter_trash },
		["capture-robot"] = { defines.inventory.robot_cargo },
		["car"] = { defines.inventory.car_trash },
		["cargo-landing-pad"] = { defines.inventory.cargo_landing_pad_trash },
		["cargo-pod"] = { defines.inventory.cargo_unit },
		["cargo-wagon"] = { defines.inventory.cargo_wagon },
		["construction-robot"] = { defines.inventory.robot_cargo, defines.inventory.robot_repair },
		["furnace"] = { defines.inventory.crafter_input, defines.inventory.crafter_trash },
		["lab"] = { defines.inventory.lab_trash },
		["logistic-container"] = { defines.inventory.logistic_container_trash },
		["logistic-robot"] = { defines.inventory.robot_cargo },
		["roboport"] = { defines.inventory.roboport_material },
		["rocket-silo"] = { defines.inventory.crafter_input, defines.inventory.rocket_silo_trash },
		["space-platform-hub"] = { defines.inventory.hub_trash },
		["spider-vehicle"] = { defines.inventory.spider_trunk, defines.inventory.spider_trash },
	}
	if options.clear_ammo then
		table.insert(inventories["car"], defines.inventory.car_ammo)
		table.insert(inventories["spider-vehicle"], defines.inventory.spider_ammo)
	end

	for _, ent in pairs(entities) do
		if is_belt[ent.type] then
			if options.clear_belts then
				ent.clear_items_inside()
			end
		elseif ent.type == "item-entity" then
			if options.clear_items_on_ground then
				ent.destroy()
			end
		else
			if (ent.type ~= "roboport" or options.clear_roboports) and
				(not is_robot[ent.type] or options.clear_robots) and
				(not is_vehicle[ent.type] or options.clear_vehicles) and
				(not is_container[ent.type] or options.clear_containers) and
				(not is_turret[ent.type] or options.clear_ammo) then
				if options.clear_machine_items then
					if ent.type == "inserter" then
						ent.clear_items_inside()
					else
						if ent.type ~= "rocket-silo" or options.clear_containers then
							clear_inventory(ent.get_output_inventory())
						end
						clear_inventory(ent.get_fuel_inventory())
						clear_inventory(ent.get_burnt_result_inventory())
						for _, inventory in pairs(inventories[ent.type] or {}) do
							clear_inventory(ent.get_inventory(inventory))
						end
					end
				end
				if options.clear_fluids and (ent.type ~= "fluid-turret" or options.clear_ammo) then
					ent.clear_fluid_inside()
				end
			end
		end
	end
end

return { wipe_area = wipe_area }
