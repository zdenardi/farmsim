--farmer

farmer = entity:new({
    prevx = 0,
    prevy = 0,
    x = 0,
    y = 0,
    money = 0,
    water = {},
    inv = {
        water = 10, -- water
        seeds = {
            -- seeds
            potato = 10
        },
        crops = {
            -- crops
            potato = 0
        }
    },
    w = 1,
    h = 1,
    sprite = 2,
    dir = 1,
    cursor_coords = { x = 0, y = 0 },
    action_tile = {
        x = 0,
        y = 0,
        num = 0,
        color = nil,
        str = "okay"
    },
    harv_c = function(self, c)
        --crop
        self.inv.crops[c] = (self.inv.crops[c] or 0) + 1
    end,
    sell_c = function(self, c)
        local c_table = {
            potato = 2
        }
        if self.inv.crops[c] != 0 then
            self.inv.crops[c] -= 1
            self.money += c_table[c]
        end
    end,
    update = function(self)
        local side_s = { 2, 3, 4 }
        -- side  spr
        local t_s = { 5, 6, 7 }
        -- up  spr
        local b_s = { 8, 9, 10 }
        -- botm spr
        local p_x = (self.x + 12) / 8
        local p_y = (self.y + 7) / 8
        local n_cell = get_n_cell(self.x, self.y, self.dir)

        self.action_tile = {
            x = n_cell.x,
            y = n_cell.y,
            num = mget(n_cell.x, n_cell.y)
        }

        if btn(1) then
            -- move l
            self.dir = 1
            self.fx = false
            self.x += self.speed
            self.walking(self, side_s)
            if (self.x > 110) then
                self.x = 110
            end
            self.cursor_coords.x = self.x + 8
            self.cursor_coords.y = self.y
        elseif btn(0) then
            -- move r
            self.dir = 0
            self.fx = true
            self.prevx = x
            self.walking(self, side_s)

            self.x -= self.speed
            if (self.x < -10) then
                self.x = -10
            end
            self.cursor_coords.x = self.x - 6
            self.cursor_coords.y = self.y
        elseif btn(2) then
            -- move d
            self.dir = 2
            self.walking(self, b_s)
            self.prevy = y
            self.y -= self.speed
            self.cursor_coords.x = self.x
            self.cursor_coords.y = self.y - 6
        elseif btn(3) then
            -- move u
            self.dir = 3
            self.prevy = y
            self.walking(self, t_s)
            self.y += self.speed
            self.cursor_coords.x = self.x
            self.cursor_coords.y = self.y + 6
            -- movement end
        end

        -- trying to figure out best way to set action_tile to encompass all functionality s

        -- set action str
        for e in all(obj_tbl) do
            if (self.action_tile.num == e.num) then
                self.action_tile.str = e.str
            end
            if obj_tbl[self.action_tile.num] then
                self.action_tile.str = obj_tbl[self.action_tile.num]
            end
        end

        -- on Btn press
        if btnp(5) then
            for e in all(obj_tbl) do
                if (self.action_tile.num == e.num) then
                    e.action()
                end
            end
        end
    end,

    draw_action = function(self)
        rectfill(100, 0, 127, 10, 13)
        -- action btn
        rect(100, 0, 127, 10, 1)
        if self.action_tile.str then
            print(f.action_tile.str, 105, 3, 7)
        end
    end,
    draw_inv = function(self)
        rect(0, 110, 127, 127, 13)
        rectfill(1, 111, 126, 126, 2)
        spr(23, 4, 114)
        print(self.money, 14, 116, 7)
        spr(19, 26, 114)
        print(self.inv.seeds['potato'], 36, 116)
        spr(24, 46, 114)
        print(self.inv.crops['potato'], 56, 116)
    end,
    draw_water = function(self)
        for w in all(self.water) do
            if w.die != 0 then
                circfill(w.x, w.y, w.r, w.c)
                w.y += rnd({ -1, 1 })
                w.r -= .1
                c = rnd({ 12, 6, 1 })

                w.die -= 1
            else
                del(self.water, w)
            end
        end
    end
})