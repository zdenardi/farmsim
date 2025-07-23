function repl_act_t(new_t)
	-- new tile spr
	mset(f.action_tile.x, f.action_tile.y, new_t)
end
function add_wtr_parts()
	local wx, wy = tile_to_pixel(f.action_tile.x, f.action_tile.y)

	for i = 0, 2 do
		w = {
			x = wx + i * 2,
			y = wy,
			c = rnd({ 12, 6 }),
			r = rnd(2),
			die = 4 + i * 3
		}
		add(f.water, w)
	end
end

local sell_spr = { 14, 15, 30, 31 }
local water_spr = { 50, 52 }

obj_tbl = {
	[0] = {
		str = 'plow',
		action = function()
			repl_act_t(49)
		end
	},
	{
		num = 0,
		str = 'plow',
		action = function()
			repl_act_t(49)
		end
	},
	{
		num = 18,
		str = 'cut',
		action = function()
			repl_act_t(17)
		end
	},
	{
		num = 49,
		str = 'plant',
		action = function()
			if f.inv.seeds['potato'] > 0 then
				f.inv.seeds['potato'] -= 1
				n.add_i(n, 30, f.action_tile.x, f.action_tile.y, { 50, 52, 54 })
			end
		end
	},
	{
		num = 54,
		str = 'harvest',
		action = function()
			repl_act_t(49)
			n.del_i(n, f.action_tile.x, f.action_tile.y)
			f.harv_c(f, "potato")
		end
	}
}

-- sell sprites in obj tbl
for s in all(sell_spr) do
	add(
		obj_tbl, {
			num = s,
			str = 'sell',
			action = function()
				f.sell_c(f, "potato")
			end
		}
	)
end

for s in all(water_spr) do
	add(
		obj_tbl, {
			num = s,
			str = 'water',
			action = function()
				add_wtr_parts()
				n.water_i(n, f.action_tile.x, f.action_tile.y)
			end
		}
	)
end