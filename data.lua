local select_filters = {
	"agricultural-tower",
	"artillery-turret",
	"asteroid-collector",
	"boiler",
	"burner-generator",
	"cargo-landing-pad",
	"cargo-pod",
	"container",
	"logistic-container",
	"infinity-container",
	"temporary-container",
	"assembling-machine",
	"rocket-silo",
	"furnace",
	"capture-robot",
	"construction-robot",
	"logistic-robot",
	"fusion-generator",
	"fusion-reactor",
	"generator",
	"inserter",
	"lab",
	"linked-container",
	"mining-drill",
	"offshore-pump",
	"pipe",
	"infinity-pipe",
	"pipe-to-ground",
	"proxy-container",
	"pump",
	"reactor",
	"roboport",
	"space-platform-hub",
	"storage-tank",
	"thruster",
	"lane-splitter",
	"linked-belt",
	"loader-1x1",
	"loader",
	"splitter",
	"transport-belt",
	"underground-belt",
	"ammo-turret",
	"fluid-turret",
	"valve",
	"car",
	"artillery-wagon",
	"cargo-wagon",
	"infinity-cargo-wagon",
	"fluid-wagon",
	"locomotive",
	"spider-vehicle",
	"item-entity",
}

---@type data.SelectionToolPrototype
local selection_tool = {
	type = "selection-tool",
	name = "rsw-select",
	order = "o[wiper]",

	select = {
		mode = "any-entity",
		cursor_box_type = "not-allowed",
		border_color = { 1, 1, 0 },
		entity_type_filters = select_filters,
	},
	alt_select = {
		mode = "any-entity",
		cursor_box_type = "not-allowed",
		border_color = { 1, 0, 0 },
		entity_type_filters = select_filters,
	},

	subgroup = "tool",
	flags = { "only-in-cursor", "not-stackable", "spawnable" },
	hidden = true,
	draw_label_for_cursor_render = true,
	stack_size = 1,

	icon = "__rs-wiper__/graphics/wiper.png",
	icon_size = 64,
	small_icon = "__rs-wiper__/graphics/wiper.png",
	small_icon_size = 64,
}

---@type data.ShortcutPrototype
local shortcut = {
	type = "shortcut",
	name = "rsw-select",
	order = "o[wiper]",

	action = "spawn-item",
	item_to_spawn = "rsw-select",
	associated_control_input = "rsw-select",

	icon = "__rs-wiper__/graphics/wiper.png",
	icon_size = 64,
	small_icon = "__rs-wiper__/graphics/wiper.png",
	small_icon_size = 64,
}

---@type data.CustomInputPrototype
local custom_input = {
	type = "custom-input",
	name = "rsw-select",

	key_sequence = "",
	action = "spawn-item",
	item_to_spawn = "rsw-select",
}

data:extend { selection_tool, shortcut, custom_input }
