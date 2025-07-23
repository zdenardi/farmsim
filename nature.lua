--nature

nature = entity:new({
    items = {},
    add_i = function(self, t, ix, iy, sprs)
        add(
            self.items, {
                timer = t, -- crop timer
                timeLeft = t, -- time left
                x = ix, -- x location
                y = iy, -- y location
                spr_cyc = sprs, -- sprite cycle tbl
                s = 1, -- sprite iterate
                spr = sprs[1],
                watered = false
            }
        )
    end,
    del_i = function(self, ix, iy)
        for i in all(self.items) do
            if (i.x == ix and i.y == iy) del(self.items, i)
        end
    end,
    water_i = function(self, ix, iy)
        for i in all(self.items) do
            if (i.x == ix and i.y == iy) then
                i.spr += 1
                i.watered = true
            end
        end
    end,
    update = function(self)
        for i in all(self.items) do
            if i.s <= #i.spr_cyc and i.watered then
                i.timeLeft -= 1
                if i.timeLeft == 0 then
                    i.s += 1
                    i.watered = false
                    i.timeLeft = i.timer
                    i.spr = i.spr_cyc[i.s]
                end
            end
        end
    end,
    draw = function(self)
        for i in all(self.items) do
            mset(i.x, i.y, i.spr)
        end
    end
})