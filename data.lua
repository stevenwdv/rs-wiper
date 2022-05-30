local select_filters = {
	"artillery-turret",
	"boiler",
	"burner-generator",

	"container",
	"logistic-container",
	"infinity-container",

	"assembling-machine",
	"rocket-silo",
	"furnace",

	"construction-robot",
	"logistic-robot",

	"generator",
	"inserter",
	"lab",
	"linked-container",
	"mining-drill",

	"offshore-pump",
	"pipe",
	"infinity-pipe",
	"pipe-to-ground",
	"pump",

	"reactor",
	"roboport",
	"storage-tank",

	"linked-belt",
	"loader-1x1",
	"loader",
	"splitter",
	"transport-belt",
	"underground-belt",

	"ammo-turret",
	"fluid-turret",

	"car",
	"artillery-wagon",
	"cargo-wagon",
	"fluid-wagon",
	"locomotive",
	"spider-vehicle",

	"rocket-silo-rocket",
}

data:extend {
	{
		type = "selection-tool",
		name = "rsw-select",
		order = "o[wiper]",

		selection_mode = "deconstruct",
		selection_cursor_box_type = "not-allowed",
		selection_color = { 1, 1, 0 },
		entity_type_filters = select_filters,

		alt_selection_mode = "deconstruct",
		alt_selection_cursor_box_type = "not-allowed",
		alt_selection_color = { 1, 0, 0 },
		alt_entity_type_filters = select_filters,

		subgroup = "tool",
		flags = { "only-in-cursor", "hidden", "not-stackable", "spawnable" },
		draw_label_for_cursor_render = true,
		stack_size = 1,
		icon = "__rs-wiper__/graphics/wiper.png",
		icon_size = 64,
	},

	{
		type = "shortcut",
		name = "rsw-select",
		order = "o[wiper]",

		action = "spawn-item",
		item_to_spawn = "rsw-select",
		associated_control_input = "rsw-select",
		icon = {
			filename = "__rs-wiper__/graphics/wiper-shortcut.png",
			priority = "extra-high-no-scale",
			size = 64,
			scale = 1,
			flags = { "icon" },
		},
	},
	{
		type = "custom-input",
		name = "rsw-select",

		key_sequence = "",
		action = "spawn-item",
		item_to_spawn = "rsw-select",
	}
}
