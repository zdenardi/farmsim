-- class and utils--
entity = {
	x = 0,
	y = 0,
	w = 1,
	h = 1,
	sprite = 0,
	speed = 1,
	fx = false,
	fy = false,
	dly = 3, -- Delay for animation
	si = 1, -- index for going through animation tbl
	draw_funcs = {},

	new = function(self, tbl)
		tbl = tbl or {}
		setmetatable(
			tbl, {
				__index = self
			}
		)
		return tbl
	end,


	walking = function(self, tbl)
		self.dly = self.dly - 1
		if self.dly < 0 then
			self.sprite = tbl[self.si]
			self.si += 1
			if self.si > #tbl + 1 then
				self.sprite = tbl[1]
				self.si = 1
			end

			self.dly = 3
		end
	end,

	add_draw_fn = function(self, fn)
		add(self.draw_funcs, fn)
	end,

	draw = function(self)
		for fn in all(self.draw_funcs) do
			fn(self)
		end
		spr(
			self.sprite,
			self.x,
			self.y,
			self.w,
			self.h,
			self.fx,
			self.fy
		)
	end
}

function draw_arr(ar)
	for a in all(ar) do
		a.draw(a)
	end
end

function update_ents(ar)
	for e in all(ar) do
		e.update(e)
	end
end

function get_n_cell(x, y, dir)
	tile_x = flr(x + 4) / 8
	tile_y = flr(y + 4) / 8
	if (dir == 0) then
		tile_x -= 1
	elseif (dir == 1) then
		tile_x += 1
	elseif (dir == 2) then
		tile_y -= 1
	elseif (dir == 3) then
		tile_y += 1
	end

	return { x = flr(tile_x), y = flr(tile_y) }
end

function float_text(txt, start_x, start_y, t)
	for i = 0, t do
		print(t, start_x, start_y + (8 * i))
	end
end

-- Convert tile coordinates to pixel coordinates
function tile_to_pixel(tile_x, tile_y)
	return tile_x * 8, tile_y * 8
end

-- Convert pixel coordinates to tile coordinates
function pixel_to_tile(pixel_x, pixel_y)
	return flr(pixel_x / 8), flr(pixel_y / 8)
end