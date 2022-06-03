local wiper = require "wiper"

local select_item = "rsw-select"

---@param event on_player_selected_area|on_player_alt_selected_area
local function handle_select_event(event)
	if event.item ~= select_item then
		return
	end

	local player = game.get_player(event.player_index)
	if not player.admin and settings.global["rsw-only-admins"].value then
		player.print { "rsw-message.not-admin" }
		return
	end

	local is_alt = event.name == defines.events.on_player_alt_selected_area
	if not is_alt and player.mod_settings["rsw-require-alt"].value then
		player.print { "rsw-message.ask-confirmation" }
		return
	end

	wiper.wipe_area(event.entities, {
		clear_belts = player.mod_settings["rsw-clear-belts"].value,
		clear_machine_items = player.mod_settings["rsw-clear-machine-items"].value,
		clear_fluids = player.mod_settings["rsw-clear-fluids"].value,
		clear_roboports = player.mod_settings["rsw-clear-roboports"].value,
		clear_robots = player.mod_settings["rsw-clear-robots"].value,
		clear_ammo = player.mod_settings["rsw-clear-ammo"].value,
		clear_vehicles = player.mod_settings["rsw-clear-vehicles"].value,
		clear_containers = player.mod_settings["rsw-clear-containers"].value,
	})
end

script.on_event(defines.events.on_player_selected_area, handle_select_event)
script.on_event(defines.events.on_player_alt_selected_area, handle_select_event)

if __Profiler then
	-- justarandomgeek/vscode-factoriomod-debug#60
	script.on_event(defines.events.on_tick, function() end)
end
