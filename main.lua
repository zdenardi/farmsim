function _init()
    palt(0, false)
    palt(14, true)
    f = farmer:new({
        x = 64,
        y = 64,
        speed = 1.25
    })
    n = nature:new({})
    init_objects(f, n)
end

function _update()
    f.update(f)
    n.update(n)
end

function _draw()
    cls(11)
    camera(f.x - 63, f.y - 63)
    map()
    f.draw(f)
    f.draw_water(f)

    -- camera()
    n.draw(n)
    -- IF YOU DRAW AFTER THIS, WEIRD SHIT HAPPENS
    camera()
    f.draw_action(f)
    f.draw_inv(f)
end