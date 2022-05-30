---@generic T
---@param list T[]
---@return table<T,boolean>
local function to_map(list)
	local map = {}
	for _, key in ipairs(list) do
		map[key] = true
	end
	return map
end

local belts = { "linked-belt", "loader-1x1", "loader", "splitter", "transport-belt", "underground-belt" }
---@type table<string,boolean>
local is_belt = to_map(belts)

local vehicles = { "car", "artillery-wagon", "cargo-wagon", "fluid-wagon", "locomotive" }
---@type table<string,boolean>
local is_vehicle = to_map(vehicles)

local containers = { "container", "logistic-container", "infinity-container", "linked-container" }
---@type table<string,boolean>
local is_container = to_map(containers)

---@param inventory LuaInventory|nil
local function clear_inventory(inventory)
	if inventory then
		inventory.clear()
	end
end

---@class WiperOptions
---@field clear_belts boolean
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
		["furnace"] = { defines.inventory.furnace_source },
		["roboport"] = { defines.inventory.roboport_material },
		["construction-robot"] = { defines.inventory.robot_cargo, defines.inventory.robot_repair },
		["logistic-robot"] = { defines.inventory.robot_cargo, defines.inventory.robot_repair },
		["assembling-machine"] = { defines.inventory.assembling_machine_input },
		["rocket-silo"] = { defines.inventory.assembling_machine_input },
		["rocket-silo-socket"] = { defines.inventory.rocket_silo_rocket },
		["lab"] = { defines.inventory.lab_input },
		["car"] = { defines.inventory.car_trunk },
		["cargo-wagon"] = { defines.inventory.cargo_wagon },
		["ammo-turret"] = {},
		["artillery-turret"] = {},
		["artillery-wagon"] = {},
		["spider-vehicle"] = { defines.inventory.spider_trunk, defines.inventory.spider_trash },
	}
	if options.clear_ammo then
		table.insert(inventories["car"], defines.inventory.car_ammo)
		table.insert(inventories["ammo-turret"], defines.inventory.turret_ammo)
		table.insert(inventories["artillery-turret"], defines.inventory.artillery_turret_ammo)
		table.insert(inventories["artillery-wagon"], defines.inventory.artillery_wagon_ammo)
		table.insert(inventories["spider-vehicle"], defines.inventory.spider_ammo)
	end

	for _, ent in pairs(entities) do
		if is_belt[ent.type] then
			if options.clear_belts then
				ent.clear_items_inside()
			end
		else
			if (ent.type ~= "roboport" or options.clear_roboports) and
				(ent.type ~= "robot" or options.clear_robots) and
				(not is_vehicle[ent.type] or options.clear_vehicles) and
				(not is_container[ent.type] or options.clear_containers) then

				if options.clear_machine_items then
					if ent.type == "inserter" then
						ent.clear_items_inside()
					else
						clear_inventory(ent.get_output_inventory())
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
