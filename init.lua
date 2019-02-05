
-- Version: 2.2
-- Autor:   Sokomine
-- License: GPLv3
--
-- Modified:
-- 27.07.15 Moved into its own repository.
--          Made sure textures and craft receipe indigrents are available or can be replaced.
--          Took care of "unregistered globals" warnings.
-- 23.01.14 Added conversion receipes in case of installed castle-mod (has its own anvil)
-- 23.01.14 Added hammer and anvil as decoration and for repairing tools.
--          Added hatches (wood and steel).
--          Changed the texture of the fence/handrail.
-- 17.01.13 Added alternate receipe for fences in case of interference due to xfences
-- 14.01.13 Added alternate receipes for roof parts in case homedecor is not installed.
--          Added receipe for stove pipe, tub and barrel.
--          Added stairs/slabs for dirt road, loam and clay
--          Added fence_small, fence_corner and fence_end, which are useful as handrails and fences
--          If two or more window shutters are placed above each other, they will now all close/open simultaneously.
--          Added threshing floor.
--          Added hand-driven mill.

cottages = {}

-- Boilerplate to support localized strings if intllib mod is installed.
if minetest.get_modpath( "intllib" ) and intllib then
	cottages.S = intllib.Getter()
else
	cottages.S = function(s) return s end
end

-- MineClone2 needs special treatment; default is only needed for
-- crafting materials and sounds (less important)
if( not( minetest.get_modpath("default"))) then
	default = {};
end
--cottages.config_use_mesh_barrel   = false;
--cottages.config_use_mesh_handmill = true;

-- set alternate crafting materials and textures where needed
-- (i.e. in combination with realtest)
dofile(minetest.get_modpath("cottages").."/adaptions.lua");

-- add to this table what you want the handmill to convert;
-- add a stack size if you want a higher yield
cottages.handmill_product = {};
cottages.handmill_product[ cottages.craftitem_seed_wheat ] = 'farming:flour 1';
cottages.handmill_product[ cottages.craftitem_seed_barley ] = 'farming:flour 1';

if farming.mod and farming.mod == "redo" then
	cottages.handmill_product[ "farming:seed_oat" ] = 'farming:flour 1';
	cottages.handmill_product[ "farming:seed_rye" ] = 'farming:flour 1';
	cottages.handmill_product[ "farming:seed_rice" ] = 'farming:rice_flour 1';
	cottages.handmill_product[ "farming:rice" ] = 'farming:rice_flour 1';
end

--[[ some examples:
cottages.handmill_product[ 'default:cobble' ] = 'default:gravel';
cottages.handmill_product[ 'default:gravel' ] = 'default:sand';
cottages.handmill_product[ 'default:sand'   ] = 'default:dirt 2';
cottages.handmill_product[ 'flowers:rose'   ] = 'dye:red 6';
cottages.handmill_product[ 'default:cactus' ] = 'dye:green 6';
cottages.handmill_product[ 'default:coal_lump'] = 'dye:black 6';
--]]
-- process that many inputs per turn
cottages.handmill_max_per_turn = 20;
cottages.handmill_min_per_turn = 0;

-- generalized function to register microblocks/stairs
cottages.derive_blocks = function( modname, nodename, nodedesc, tile, groups )
	
	if stairs and stairs.mod and stairs.mod == "redo" then

		stairs.register_all(nodename, modname .. ":" .. nodename,
			{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			{tile},
			cottages.S(nodedesc .. " stair"),
			cottages.S(nodedesc .. " slab"),
			default.node_sound_wood_defaults())
									
	elseif minetest.global_exists("stairsplus") then
															
		stairsplus:register_all(modname, nodename, modname .. ":" .. nodename, {
			description = cottages.S(nodedesc),
			tiles = {tile},
			groups = {snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			sounds = default.node_sound_wood_defaults(),
		})

	else

		stairs.register_stair_and_slab(nodename, modname .. ":" .. nodename,
			{snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3},
			{tile},
			cottages.S(nodedesc .. " stair"),
			cottages.S(nodedesc .. " slab"),
			default.node_sound_wood_defaults())
	
	end
	
end

-- uncomment parts you do not want
dofile(minetest.get_modpath("cottages").."/nodes_furniture.lua");
dofile(minetest.get_modpath("cottages").."/nodes_historic.lua");
dofile(minetest.get_modpath("cottages").."/nodes_feldweg.lua");
dofile(minetest.get_modpath("cottages").."/nodes_straw.lua");
dofile(minetest.get_modpath("cottages").."/nodes_anvil.lua");
dofile(minetest.get_modpath("cottages").."/nodes_doorlike.lua");
dofile(minetest.get_modpath("cottages").."/nodes_fences.lua");
dofile(minetest.get_modpath("cottages").."/nodes_roof.lua");
dofile(minetest.get_modpath("cottages").."/nodes_barrel.lua");
dofile(minetest.get_modpath("cottages").."/nodes_mining.lua");
dofile(minetest.get_modpath("cottages").."/nodes_fireplace.lua");
--dofile(minetest.get_modpath("cottages").."/nodes_chests.lua");

-- this is only required and useful if you run versions of the random_buildings mod where the nodes where defined inside that mod
dofile(minetest.get_modpath("cottages").."/alias.lua");

-- variable no longer needed
cottages.S = nil;
