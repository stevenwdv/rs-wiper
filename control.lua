local wiper = require "wiper"

local select_item = "rsw-select"

script.on_event({ defines.events.on_player_selected_area, defines.events.on_player_alt_selected_area },
	---@param event EventData.on_player_selected_area|EventData.on_player_alt_selected_area
	function(event)
		if event.item ~= select_item then
			return
		end

		local player = game.players[event.player_index]
		if not player.admin and settings.global["rsw-only-admins"].value then
			player.print { "rsw-message.not-admin" }
			return
		end

		local is_alt = event.name == defines.events.on_player_alt_selected_area
		if not is_alt and player.mod_settings["rsw-require-alt"].value then
			player.print { "rsw-message.ask-confirmation" }
			return
		end

		---@type PlayerSettings
		local player_settings = player.mod_settings
		wiper.wipe_area(event.entities, {
			clear_belts = player_settings["rsw-clear-belts"].value,
			clear_items_on_ground = player_settings["rsw-clear-items-on-ground"].value,
			clear_machine_items = player_settings["rsw-clear-machine-items"].value,
			clear_fluids = player_settings["rsw-clear-fluids"].value,
			clear_roboports = player_settings["rsw-clear-roboports"].value,
			clear_robots = player_settings["rsw-clear-robots"].value,
			clear_ammo = player_settings["rsw-clear-ammo"].value,
			clear_vehicles = player_settings["rsw-clear-vehicles"].value,
			clear_containers = player_settings["rsw-clear-containers"].value,
		})
	end)

if __Profiler then
	-- justarandomgeek/vscode-factoriomod-debug#60
	script.on_event(defines.events.on_tick, function() end)
end
