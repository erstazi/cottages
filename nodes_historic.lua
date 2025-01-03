---------------------------------------------------------------------------------------
-- decoration and building material
---------------------------------------------------------------------------------------
-- * includes a wagon wheel that can be used as decoration on walls or to build (stationary) wagons
-- * dirt road - those are more natural in small old villages than cobble roads
-- * loam - no, old buildings are usually not built out of clay; loam was used
-- * straw - useful material for roofs
-- * glass pane - an improvement compared to fence posts as windows :-)
---------------------------------------------------------------------------------------

local S = cottages.S

-- can be used to buid real stationary wagons or attached to walls as decoration
minetest.register_node("cottages:wagon_wheel", {
	description = S("Wagon wheel"),
	drawtype = "signlike",
	tiles = {"cottages_wagonwheel.png"}, -- done by VanessaE!
	inventory_image = "cottages_wagonwheel.png",
	wield_image = "cottages_wagonwheel.png",
	paramtype = "light",
	paramtype2 = "wallmounted",

	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	is_ground_content = false,
})


-- people didn't use clay for houses; they did build with loam
minetest.register_node("cottages:loam", {
	description = S("Loam"),
	tiles = {"cottages_loam.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
})

-- register derivative blocks (stairs etc)

cottages.derive_blocks( "cottages", "loam", "Loam", "cottages_loam.png", {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2} )


-- straw is a common material for places where animals are kept indoors
-- right now, this block mostly serves as a placeholder
minetest.register_node("cottages:straw_ground", {
	description = S("Straw ground for animals"),
	tiles = {"cottages_darkage_straw.png","cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png","cottages_loam.png"},
	groups = {snappy=2,crumbly=3,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_dirt_defaults(),
	is_ground_content = false,
})


-- note: these houses look good with a single fence pile as window! the glass pane is the version for 'richer' inhabitants
minetest.register_node("cottages:glass_pane", {
		description = S("Simple glass pane (centered)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_glass_pane.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.05,  0.5, 0.5,  0.05},
			},
		},
		is_ground_content = false,
})


minetest.register_node("cottages:glass_pane_side", {
		description = S("Simple glass pane"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_glass_pane.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		use_texture_alpha = "clip",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.40,  0.5, 0.5, -0.50},
			},
		},
		is_ground_content = false,
})


---------------------------------------------------------------------------------------
-- a very small wooden slab
---------------------------------------------------------------------------------------
minetest.register_node("cottages:wood_flat", {
		description = S("Flat wooden planks"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		is_ground_content = false,
		on_place = minetest.rotate_node,
})

---------------------------------------------------------------------------------------
-- useful for building tents
---------------------------------------------------------------------------------------
minetest.register_node("cottages:wool_tent", {
		description = S("Wool for tents"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_wool.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.5, -0.5, -0.50,  0.5, -0.5+1/16, 0.50},
			},
		},
		is_ground_content = false,
		on_place = minetest.rotate_node,
})

-- a fallback for cases in which there is no wool
if not minetest.get_modpath("wool") then
	minetest.register_node("cottages:wool", {
			description = S("Wool"),
			tiles = {"cottages_wool.png"},
			is_ground_content = false,
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3,wool=1},
	})
end


---------------------------------------------------------------------------------------
-- crafting receipes
---------------------------------------------------------------------------------------
minetest.register_craft({
	output = "cottages:wagon_wheel 4",
	recipe = {
		{cottages.craftitem_iron, cottages.craftitem_stick,       cottages.craftitem_iron },
		{cottages.craftitem_stick,     cottages.craftitem_steel, cottages.craftitem_stick },
		{cottages.craftitem_iron, cottages.craftitem_stick,       cottages.craftitem_iron }
	}
})

-- run a wagon wheel over dirt :-)
minetest.register_craft({
	output = "cottages:feldweg 12",
	recipe = {
		{"",            "cottages:wagon_wheel", "" },
		{cottages.craftitem_dirt,cottages.craftitem_dirt,cottages.craftitem_dirt }
	},
	replacements = { {'cottages:wagon_wheel', 'cottages:wagon_wheel'}, }
})

minetest.register_craft({
	output = "cottages:loam 4",
	recipe = {
		{cottages.craftitem_sand},
		{cottages.craftitem_clay}
	}
})

minetest.register_craft({
	output = "cottages:straw_ground 2",
	recipe = {
		{"cottages:straw_mat" },
		{"cottages:loam"}
	}
})

minetest.register_craft({
	output = "cottages:glass_pane 4",
	recipe = {
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_stick },
		{cottages.craftitem_stick, cottages.craftitem_glass, cottages.craftitem_stick },
		{cottages.craftitem_stick, cottages.craftitem_stick, cottages.craftitem_stick }
	}
})

minetest.register_craft({
	output = "cottages:glass_pane_side",
	recipe = {
		{"cottages:glass_pane"},
	}
})

minetest.register_craft({
	output = "cottages:glass_pane",
	recipe = {
		{"cottages:glass_pane_side"},
	}
})

minetest.register_craft({
	output = "cottages:wood_flat 16",
	recipe = {
		{cottages.craftitem_stick, "farming:string",cottages.craftitem_stick },
		{cottages.craftitem_stick, "",              cottages.craftitem_stick },
	}
})

minetest.register_craft({
	output = "cottages:wool_tent 2",
	recipe = {
		{"farming:string", "farming:string"},
		{"",cottages.craftitem_stick}
	}
})

minetest.register_craft({
	output = "cottages:wool",
	recipe = {
		{"cottages:wool_tent", "cottages:wool_tent"}
	}
})
