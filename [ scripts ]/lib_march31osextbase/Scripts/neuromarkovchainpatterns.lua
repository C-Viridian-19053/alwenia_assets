-- this pattern was referenced from baba's patterns (from since 1.92 release to future ones).

shapes, sides, su, sa, st = l_getSides(), 0, {}, {}, {}
t, d, m = 0, 0, 0

--- taken from virpe's anniversary x[overdose]
function neuroDelay(mMult) -- https://www.desmos.com/calculator/2wguctlrlu
    return mMult * (0.41 ^ (l_getSpeedMult() - 3) + 1.6)
end

-- is equal to getPerfectDelay. use this for vortexes and alt barrages
function neuroDelayPerfect(mMult)
    return 40 * mMult * u_getDelayMultDM() / (5.02 * u_getSpeedMultDM())
end

-- gets a thickness for a wall based on the delay and speed, to keep proportions. (use this for tunnels, spirals, etc)
-- for some reason the best mMult seems to always be 5, but maybe that's a coincidence
-- it seems to occaisonally have slight precision problems, (mDelay + 0.15) is there to compensate
function neuroThickness(mDelay, mMult)
    mMult = mMult or 5
    return (mDelay + 0.15) * u_getSpeedMultDM() * mMult
end
---

-- utils
function all_sides()      return shapes                            end
function odd_side(offset) return (all_sides() + (offset or 0)) % 2 end
function rng_dir()        return (math.random(0, 1) - 0.5) * 2     end
function poly_side(sides, odd_even)
    sides = sides or 2
    local stat = odd_even % 2 == 1 and math.ceil or math.floor
    return stat(all_sides()/sides)
end

function neg(value)  if value >  0 then return 1 elseif value < 0 then return -1 end return 0 end
function negn(value) if value >= 0 then return 1 else                  return -1 end          end
function neg0(value) if value >= 0 then return 1 else                  return 0  end          end

-- friking obselete
local function start_pat(available_side)
    st = type(available_side) == 'table' and available_side or { 1 }

    for i = 1, shapes do
        if st[i] == 0 then
            table.insert(st, i)
        end
        u_log('side ' .. i .. (st[i] == 1 and ' un' or ' ') .. 'expected')
    end

    if #st > 1 then
        sides = sides + (st[math.random(#st)] - 1)
    else
        sides = sides + (st[1] - 1)
    end
end

local function get_result()
    sa = {}

    for av = 1, all_sides() do
        if su[av] == 0 then
            table.insert(sa, av)
        end
    end
  
    if #sa > 1 then
        sides = sa[math.random(#sa)]
    else
        sides = sa[1]
    end
end

-- common
function wall_base(s, t) w_wall(s or 0, t or THICKNESS) end

function wall_ex(r, s, e, m, t)
    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = 0, e-1, m do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    return su
end

function vorta_wall(r, s, t)
    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = 0, math.ceil(all_sides() / 2) - 2 do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    for i = math.ceil(all_sides() / 2), all_sides() - 2 do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    return su
end

function dual_holed_bar(r, s, t)
    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    su[(s + 0) % all_sides()+1] = 1
    wall_base((s + 0) % all_sides()+1, t)

    for i = 2, all_sides() - 2 do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    return su
end

function mirror_wall(r, s, m, e, t)
    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = 0, m - 1 do
        for e = 0, e do
            su[(s + math.floor(i * (all_sides() / m))) % all_sides()+1] = 1
            wall_base((s + math.floor(i * (all_sides() / m))) % all_sides()+1, t)
        end
    end

    return su
end

function wall_grow(r, s, g, e, t)
    e = e or 0

    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = -g, g + e, 1 do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    return su
end

function wall_draw(r, s, min, max, t)
    e = e or 0

    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = -min, max, 1 do
        su[(s + i) % all_sides()+1] = 1
        wall_base((s + i) % all_sides()+1, t)
    end

    return su
end

function barrage_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        wall_ex(true, t + m, all_sides() - 1, 1, THICKNESS)

        if a < iter then
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function barrage_spiral_rnd_dist_dir(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        wall_ex(true, t + m, all_sides() - 1, 1, THICKNESS)

        if a < iter then
            if math.random(10) == 10 then d = rng_dir() end
            if math.random(7) == 7 then
                m = m + d * 2
                t_wait(neuroDelayPerfect((5.25 * del_mult) * 0.5))
            else
                m = m + d
            end
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    sides = t + m
end

function barrage_spiral_rnd_dir(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0
    local theuniqueandquirkytable = { 1, rng_dir(), rng_dir() }

    for a = 0, iter do
        if theuniqueandquirkytable[(a % 3) + 1] > 0 then
            wall_ex(true, sides, all_sides() - 1, 1, THICKNESS)
            d = rng_dir()
        end

        if a < iter then
            sides = sides + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end
end

function barrage_lrs(iter, dist, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir() * dist, 0

    for a = 0, iter do
        wall_ex(true, t + m, all_sides() - 1, 1, THICKNESS)

        if a < iter then
            m = m + d
            d = -d
            t_wait((dist * 0.5 + 0.5) * neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function barrage_tri_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    t = t + math.random(poly_side(3, 1)) - 1

    for a = 0, iter do
        wall_ex(true, t + m, (poly_side(3, 0) * 2), 1, THICKNESS)

        if a < iter then
            m = m + d * 2
            t_wait(neuroDelayPerfect(5.25 * (del_mult * .5 + .5)))
        end
    end

    get_result()
end

function alt_barrage(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        wall_ex(true, t + m, all_sides(), 2, THICKNESS)
  
        if a < iter then
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
   end

    get_result()
end

function vorta_spi(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        vorta_wall(true, t + m)
  
        if a < iter then
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function vorta_rev(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter * 2 do
        vorta_wall(true, t + m)
  
        if a < iter then
            if a == math.ceil(iter/2) then d = -d end
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function vorta_lrs(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        vorta_wall(true, t + m)
  
        if a < iter then
            m = m + d
            d = -d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function dual_barrage_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    t = t - math.random(0, 1) * 2

    for a = 0, iter do
        dual_holed_bar(true, t + m)

        if a < iter then
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function dual_barrage_lrs(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    t = t - math.random(0, 1) * 2

    for a = 0, iter do
        dual_holed_bar(true, t + m)

        if a < iter then
            m = m + d
            d = -d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function dual_barrage_inverts(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    t = t - math.random(0, 1) * 2

    for a = 0, iter do
        dual_holed_bar(true, t + m)

        if a < iter then
            m = m + poly_side(2, 1)
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function even_alt(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, math.random(0, 1), 0

    for a = 0, iter do
        if (a + d) % 2 == 1 then 
            vorta_wall(true, t)
        else
            t = t + rng_dir() * (a == 0 and 1 or 0)
            mirror_wall(true, t + poly_side(2, 0) - 1 + odd_side(), 2, 0)
        end
        
        if a < iter then
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function half_alt(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        if (a + d) % 2 == 1 then 
            wall_ex(true, t + 1, poly_side(2, 0), 1)
        else
            t = t + rng_dir() * (a == 0 and 1 or 0)
            wall_ex(true, t + 1 + poly_side(2, 0), poly_side(2, 0), 1)
        end
        if a < iter then
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function single_bar_alt(iter, del_mult)
    del_mult = del_mult or 1
    local t, m = sides, 0

    for a = 0, iter do
        if a % 2 == 0 then 
            wall_ex(true, t, all_sides() - 1, 1)
        else
            wall_ex(true, t - 1, 1, 1)
        end

        if a < iter then
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end
    
    get_result()
end

function dual_bar_alt(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    t = t - math.random(0, 1) * 2

    for a = 0, iter do
        if a % 2 == 0 then 
            dual_holed_bar(true, t)
        else
            wall_ex(true, t - 1, 3, 2)
        end

        if a < iter then
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function sampah_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0
    
    wall_ex(true, t, all_sides(), poly_side(2, 1))
    t_wait(neuroDelayPerfect(5.25 * del_mult))
    t = t + d

    for a = 0, iter do
        local samp = math.random(2, 18)
        if samp < 9  then wall_ex(true, t,     all_sides(), poly_side(2, 1)) end
        if samp > 12 then wall_ex(true, t - 1, all_sides(), 2)               end

        if samp == 9  or samp == 10 then wall_ex(true, t + poly_side(2, 1), all_sides() - poly_side(3, 0), 1) end
        if samp == 11 or samp == 12 then dual_holed_bar(true, t + poly_side(2, 1))                            end
        
        if a < iter then
            t = t + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end
    
    get_result()
end

function jumbel(iter, mChance, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    wall_ex(true, t + 1, 1, 1)
        
    t_wait(neuroDelayPerfect(5.25 * del_mult))

    for a = 0, iter do
        for i = 1, mChance do
            wall_base(math.random(all_sides()))
        end
        
        t_wait(neuroDelayPerfect(5.25 * del_mult))
    end
end

function jumbel_tehek(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0
    local delay = neuroDelay(5.25 * del_mult)

    for a = 0, iter do
        if a % 2 == 1 then
            local rw = math.random(3)
                if rw == 1 then wall_ex(       true, t + 1 + (math.random(all_sides()) * clamp(a, 0, 1)), all_sides(),     2)
            elseif rw == 2 then wall_ex(       true, t + 1 + (math.random(all_sides()) * clamp(a, 0, 1)), poly_side(2, 1), 1)
            else                dual_holed_bar(true, t + 1 + (math.random(all_sides()) * clamp(a, 0, 1))                    )
            end
        else
            wall_ex(false, t + 1 + poly_side(2, 0), 1, 1)
            t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
            wall_ex(false, t + 1, 1, 1, neuroThickness(delay) + THICKNESS)
        end

        if a % 2 < iter then
            t = t + d
            t_wait(delay)
        end
    end

    get_result()
end

function spiral_thin(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        wall_ex(true, t + m, 6, 3)

        if a < iter then
            m = m + d
            t_wait(neuroDelayPerfect(5.25 * del_mult))
        end
    end

    get_result()
end

function barrage_to_dual(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    for a = 0, iter do
        wall_ex(true, t, all_sides() - 1, 1)
        t_wait(neuroDelayPerfect(5.25 * del_mult))
        dual_holed_bar(true, t - 1)
        t_wait(neuroDelayPerfect(5.25 * del_mult))
    end
    
    wall_ex(true, t, all_sides() - 1, 1)

    get_result()
end

-- swap

function swap_corridor(del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, m = sides, rng_dir(), 0
    
    local function rWallEx(x, ex, thick)
        for i = 0, ex do
            wall_base(x + i, thick)
            wall_base(x + i + poly_side(2, 1), thick)
        end
    end
    
    wall_ex(true, t, all_sides() - 1, 1)
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    rWallEx(t + 1, clamp(poly_side(2, 0) - 2, 0, all_sides()), neuroThickness(delay))
    t_wait(delay)
    wall_ex(true, t + poly_side(2, 1), all_sides() - 1 - odd_side(), 1)

    sides = sides + poly_side(2, math.random(0, odd_side()))
end

function swap_chance(del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d = sides, math.random(0, 1)
    local ed = (d + 1) % 2

    t = t + math.random(0, clamp(poly_side(2, ed) - 2, 0, all_sides()))

    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_ex(true, t, 1, 1, neuroThickness(delay))
    wall_ex(true, t + poly_side(2, d), 1, 1, neuroThickness(delay))
    t_wait(delay)
    wall_ex(true, t + (d * poly_side(2, d)), poly_side(2, ed) + 1, 1)

    get_result()
end

function swap_lr_once(del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, m = sides, rng_dir() * 2, 0
    
    wall_ex(true, t + m, all_sides() - 1, 1)
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_base(t + m + 1, neuroThickness(delay))
    wall_base(t + m - 1, neuroThickness(delay))
    t_wait(delay)
    m = m + d
    wall_ex(true, t + m, all_sides() - 1, 1)

    get_result()
end

function aquarium_swap_lr(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, nd, m = sides, rng_dir() * 2, math.random(0, 1), 0

    t = t - (nd == 0 and d or 0)

    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_base(t + 1, neuroThickness(delay * iter))
    wall_base(t - 1, neuroThickness(delay * iter))

    for a = 0, iter do
        if (a + nd) % 2 == 0 then
            m = m + d
            d = -d
            wall_ex(true, t + m, all_sides() - 1, 1)
        else
            m = m + d
            wall_ex(true, t, all_sides() - 1, 1)
        end

        if a < iter then
            t_wait(delay)
        end
    end

    get_result()
end

function dual_spiral_swap(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, m = sides, rng_dir(), 0

    local function rWallEx(x, ex, thick)
        for i = 0, math.floor(all_sides()/2) - 3 do
            wall_base(x + i, thick)
        end
        for i = 0, math.ceil(all_sides()/2) - 3 do
            wall_base(x + i + poly_side(2, 0), thick)
        end
    end

    wall_ex(true, t + m, all_sides() - 1, 1)
    m = m - d * (d > 0 and poly_side(2, 0) - 2 or 1)
    for a = 0, iter do
        t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
        rWallEx(t + m, 0, neuroThickness(delay))
        if a < iter then
            t_wait(delay)
            m = m + d
        end
    end
    t_wait(delay)
    rWallEx(t + m + d, 0, THICKNESS)
    d = -d
    for a = 0, iter + 1 do
        if a < iter + 1 then
            t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
            rWallEx(t + m, 0, neuroThickness(delay))
            t_wait(delay)
        end
        m = m + d
    end
    if all_sides() > 7 then
        m = m + (d > 0 and poly_side(2, 0) - 3 or 0)
    end
    wall_ex(true, t + m, all_sides() - 1, 1)
    sides = t + m
end

function swap_swap(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, 1, 0
    sillyChance = 50
    anjer = 0
    oldm = 0
    
    local function rWallEx(x, ex, thick, odd_even)
        for i = 0, ex do
            wall_base(x + i, thick)
            wall_base(x + i + poly_side(2, odd_even), thick)
        end
    end
    
    for i = 0, iter do
        wall_ex(true, t + m, all_sides() - 1 - (odd_side() * (anjer % 2)), 1)
        if i < iter then
            t_wait(neuroDelayPerfect(5.25 * del_mult) / 2)
            sillyChance = sillyChance * (math.random() * 1.5 + 1)

            if sillyChance > 75 then
                if all_sides() > 5 then
                    rWallEx(t + m + ((anjer + 1) % 2) + poly_side(2, 0) + odd_side(), clamp(poly_side(2, 0) - 2, 0, all_sides()), THICKNESS, anjer)
                else
                    rWallEx(t + m + ((anjer + 1) % 2) + poly_side(2, 0) + odd_side(), 0, THICKNESS, 0)
                end
                if all_sides() % 2 == 1 then
                    oldm = m
                    m = m + poly_side(2, anjer + 1)
                    anjer = anjer + 1
                else
                    m = m + poly_side(2, 1)
                end
                sillyChance = sillyChance / 3
            else
                anjer = 0
                m = m + rng_dir()
            end

            t_wait(neuroDelayPerfect(5.25 * del_mult) / 2)
        end
    end

    get_result()
end

function lr_swap_lr(del_mult)
    del_mult = del_mult or 1
    local t = sides
    local delay = neuroDelay(5.25 * del_mult)

    wall_ex(true, t + 1, all_sides() - 3, 1, neuroThickness(delay * 2) + THICKNESS)

    for i = 1, 3 do
        if i % 2 == 1 then
            wall_ex(true, t, all_sides() - 1, 1)
        else
            dual_holed_bar(true, t - 1)
        end
        
        if i < 3 then
            t_wait(delay)
        end
    end
        
    wall_ex(true, t, poly_side(2, 0) - 1, 1, neuroThickness(delay * 2))
    wall_ex(true, t - poly_side(2, 0), poly_side(2, 0) - 1, 1, neuroThickness(delay * 2))
    t_wait(delay)
    wall_draw(true, t + 2 - poly_side(2, 0), poly_side(2, 0) - 2, poly_side(2, 0) - 2, THICKNESS)
    t_wait(delay)
    wall_ex(true, t + 1, all_sides() - 3, 1, neuroThickness(delay * 2))
        
    for i = 1, 3 do
        if i % 2 == 1 then
            wall_ex(true, t, all_sides() - 1, 1)
        else
            dual_holed_bar(true, t - 1)
        end
        
        if i < 3 then
            t_wait(delay)
        end
    end
end

function random_tunnel(iter, del_mult)
    del_mult = del_mult or 1
    local t, oldM, m = sides, 0, 0
    delay = 0

    sides = sides - 1
    t = sides
    for a = 0, iter do
        wall_ex(true, t + m + 1, all_sides() - 1, 1)
        oldM = m
        m = math.random(0, all_sides() - 2)

        delay = oldM - m

        if delay < 0 then
            delay = delay * -1
        end

        wall_base(t, neuroThickness(neuroDelay(5.25 * del_mult) * (delay / 2.25) + neuroDelayPerfect(2.25)))
        t_wait(neuroDelay(5.25 * del_mult) * (delay / 2.25) + neuroDelayPerfect(2.25))
    end

    sides = t + m + 1
end

function jumbel_tunnel(iter, mChance, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

    wall_ex(true, t + 1, 1, 1, neuroThickness(neuroDelay(5.25 * (iter + 2) * del_mult)))

    t_wait(neuroDelay(5.25 * del_mult))

    for a = 0, iter do
        for i = 1, mChance do
            wall_base(t + math.random(2, all_sides() + 1))
        end
        
        t_wait(neuroDelay(5.25 * del_mult))
    end
end

function broekn_tunnel(iter, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir(), 0

	sideTable = {}
	for i = 1, all_sides() do
		table.insert(sideTable, i)
	end
	shuffle(sideTable)

    wall_ex(true, sides + math.random(all_sides() - 1), 1, 1, neuroThickness(neuroDelay(5.25)) + THICKNESS)
    t_wait(neuroDelay(5.25 * del_mult))

    for a = 0, iter do
		for i = 1, all_sides() do
			if (sideTable[i] + a) % all_sides() + 1 == 3 and a < iter then
				wall_ex(true, sides + i, 1, 1, neuroThickness(neuroDelay(5.25)) + THICKNESS)
			elseif (sideTable[i] + a) % all_sides() + 1 > 3 then
				wall_ex(false, sides + i, 1, 1, THICKNESS)
			end
		end

        if a < iter then
            sides = sides + d
            t_wait(neuroDelay(5.25 * del_mult))
        end
    end
	
	get_result()
end

function dual_tunnel_swap_rnd(iter, del_mult, is_swap)
    del_mult = del_mult or 1
    local delay = neuroDelay(5 * del_mult)
    local t, d, m = sides, rng_dir(), 0
    anjer = 0
    
    local function rWallEx(x, ex, thick)
        for i = 0, ex do
            wall_base(x + i, thick)
            wall_base(x + i + poly_side(2, 1), thick)
        end
    end

    t = t - math.random(0, 1) * 2
    
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    rWallEx(t + 1, 0, neuroThickness(delay) * iter)

    for i = 0, iter do
        if math.random(0, 2) > 1 and i > 0 and is_swap then
            wall_ex(true, t + ((i % 2) * poly_side(2, 1)), all_sides() - 1, 1)
        else
            dual_holed_bar(true, t + ((i % 2) * poly_side(2, 1)))
        end
        
        if i < iter then
            t_wait(delay)
        end
    end

    get_result()
end

function tunnel(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(15 * del_mult)
    local t, d, m = sides, rng_dir(), 0
    
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_base(t + d, neuroThickness(delay) * iter)

    for a = 0, iter do
        wall_ex(true, t + m, all_sides() - 1, 1)

        if a < iter then
            m = m + 2 * d
            d = -d
            t_wait(delay)
        end
    end

    get_result()
end

function short_tunnel(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(7.5 * del_mult)
    local t, d = sides, rng_dir()
    local pat_end_fix, sides5_arm_fix, sides4_arm_fix = 0, all_sides() > 5 and 1 or 0, all_sides() > 4 and 0 or 1

    if d > 0 then t = t + poly_side(2, sides5_arm_fix) else t = t + clamp(poly_side(2, (1 - sides5_arm_fix)) - 2, 0, all_sides()) + sides4_arm_fix end -- fuck - tunnel arm direction 1 bug m(_ _)m

    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_base(t + 1, neuroThickness(delay) * iter)

    for i = 0, iter do
        if d > 0 then
            wall_ex(true, t + poly_side(2, (1 - sides5_arm_fix)), poly_side(2, 1) + sides5_arm_fix, 1)
        else
            wall_ex(true, t, poly_side(2, 1) + sides5_arm_fix, 1)
        end

        d = -d

        if i < iter then
            t_wait(delay)
        end
    end

    pat_end_fix = (clamp(all_sides() - 2, 1, 2) - sides4_arm_fix + (all_sides() > 3 and 0 or odd_side())) * d
    sides = sides + pat_end_fix * (iter % 2)
end

function alt_tunnel(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, m = sides, rng_dir(), 0
    local prevention_d_change, der = d, rng_dir()
    
    t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
    wall_ex(true, t + 1 - neg0(d * der), all_sides() == 4 and 1 or poly_side(2, 0), 1, neuroThickness(delay) * iter)
    
    for i = 0, iter do
        if i < iter then
            wall_ex(true, t + m - 2, all_sides(), 2)
            m = m + d
            d = -d
            t_wait(delay)
        end
    end

    wall_ex(true, t + 1 - neg0(prevention_d_change * der), all_sides() == 4 and 1 or poly_side(2, 0), 1)
    
    sides = sides - neg0(prevention_d_change * der) -- i hate myself ;_;

    get_result()
end

function strange_tunnel(iter, dist, del_mult)
    del_mult = del_mult or 1
    local t, d, m = sides, rng_dir() * dist, 0
    local delay = neuroDelay(5.25 * del_mult)

    for i = 0, 1 do
        wall_ex(true, t + (i * (all_sides() - (dist + 2))) + clamp(d * dist, 0, dist), 1, 1, neuroThickness(delay) * iter * (dist * 0.5 + 0.5))
    end
    
    for a = 0, iter do
        wall_ex(true, t + m, all_sides() - 1, 1, THICKNESS)

        if a < iter then
            m = m + d
            d = -d
            t_wait((dist * 0.5 + 0.5) * delay)
        end
    end

    get_result()
end

function half_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(4 * del_mult)
    local t, d, m = sides, rng_dir(), 0

    t = t + 1

    for i = 0, iter * 2 do
        if (i + neg0(d)) % 2 == 1 then
            t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
            wall_ex(true, t + m, poly_side(3, 0) * 2, 1, neuroThickness(delay / 2) + THICKNESS)
            if i < iter * 2 and d > 0 then
                t = t + 1
            end
        else
            t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
            wall_ex(true, t + m, poly_side(3, 0) * 2 - 1, 1, neuroThickness(delay / 2) + THICKNESS)
            if i < iter * 2 and d < 0 then
                t = t - 1
            end
        end
        t_wait(delay / 2)
    end

    sides = t;
end

function dual_spiral(iter, del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(4 * del_mult)
    local t, d, m = sides, rng_dir(), 0

    t = t + math.random(0, poly_side(2, 1) - 2)

    for i = 0, iter do
        t_eval("l_setWallAngleLeft(0) l_setWallAngleRight(0) l_setWallSkewLeft(0) l_setWallSkewRight(0)")
        wall_ex(true, t + m, poly_side(2, 0) + 1, poly_side(2, 0), neuroThickness(delay))
        
        if i < iter then
            m = m + d * clamp(math.random(0, 7), 0, 1)
            if math.random(0, 4) == 4 then d = -d end
        end

        t_wait(delay)
    end

    get_result()
end

function diamond(del_mult)
    del_mult = del_mult or 1
    local delay = neuroDelay(5.25 * del_mult)
    local t, d, m = sides, rng_dir(), 0

    if odd_side() % 2 == 1 then
        wall_grow(t - 1 + poly_side(2, 0), poly_side(4, 1), 0, neuroThickness(delay))
    else
        wall_ex(true, t, all_sides() - 1, 1, neuroThickness(delay))
    end
    t_wait(delay)
    wall_grow(true, t - 1 + poly_side(2, 0), poly_side(4, 0), 0, neuroThickness(delay))
    t_wait(delay)
    wall_ex(true, t - 1 + poly_side(2, 0), 1, 1, neuroThickness(delay * 4))
    wall_ex(true, t - 1 - odd_side(), odd_side() + 1, 1, neuroThickness(delay * 3))
    t_wait(delay)
    wall_grow(true, t - 1 - odd_side(), 1, odd_side(), neuroThickness(delay))
    t_wait(delay * 2)
    wall_grow(true, t - 1 + poly_side(2, 0), poly_side(4, 0), 0, neuroThickness(delay))
    t_wait(delay)
    --get_result()
end

pattern = {
    [1]  = function() alt_barrage(math.random(5, 6)) end,
    [2]  = function() barrage_spiral(math.random(2, 3)) end,
    [3]  = function() barrage_lrs(math.random(2, 5), 1) end,
    [4]  = function() barrage_lrs(math.random(2, 5), 2) end,
    [5]  = function() barrage_tri_spiral(math.random(2, 5), u_getSpeedMultDM() >= 2 and 2 or 1) end,
    [6]  = function() if all_sides() > 4 then vorta_spi(math.random(2, 5)) else pattern[1]() end end,
    [7]  = function() if all_sides() > 4 then vorta_rev(math.random(2, 5)) else pattern[1]() end end,
    [8]  = function() if all_sides() > 5 then dual_barrage_spiral(math.random(2, 5)) else pattern[1]() end end,
    [9]  = function() if all_sides() > 5 then dual_barrage_lrs(math.random(2, 5)) else pattern[1]() end end,
    [10] = function() if all_sides() > 5 then dual_barrage_inverts(math.random(2, 5)) else pattern[1]() end end,
    [11] = function() if all_sides() > 4 then even_alt(math.random(2, 6)) else pattern[1]() end end,
    [12] = function() if all_sides() > 5 then spiral_thin(math.random(2, 5)) else pattern[1]() end end,
    [13] = function() single_bar_alt(math.random(2, 6)) end,
    [14] = function() if all_sides() > 5 then dual_bar_alt(math.random(2, 6)) else pattern[1]() end end,
    [15] = function() sampah_spiral(math.random(2, 6)) end,
    [16] = function() jumbel(math.random(2, 6), all_sides()-3) end,
    [17] = function() half_alt(math.random(2, 6)) end,
    [18] = function() barrage_to_dual(math.random(2, 6)) end,
    [19] = function() barrage_spiral_rnd_dir(math.random(2, 6)) end,
    [20] = function() if all_sides() > 4 then vorta_lrs(math.random(2, 6)) else pattern[1]() end end,
    [21] = function() if all_sides() > 3 then jumbel_tehek(math.random(2, 6), l_getDelayMult()) else pattern[1]() end end,
    
    [50] = function() half_spiral(7,l_getDelayMult()) end,
    [51] = function() if all_sides() > 5 then dual_spiral(7,l_getDelayMult()) else pattern[50]() end end,
    [52] = function() if all_sides() > 3 then tunnel(1,l_getDelayMult()) else pattern[59]() end end,
    [53] = function() if all_sides() > 3 then short_tunnel(math.random(2, 5), l_getDelayMult() * (1.1 + (all_sides() == 7 and .5 or 0))) else pattern[59]() end end,
    [54] = function() alt_tunnel(math.random(2, 6),l_getDelayMult()) end,
    [55] = function() if all_sides() > 3 then random_tunnel(math.random(2, 4),l_getDelayMult()) else pattern[59]() end end,
    [56] = function() jumbel_tunnel(math.random(2, 3), clamp(all_sides() - 4, 0, all_sides()), l_getDelayMult()) end,
    [57] = function() diamond(l_getDelayMult()) end,
    [58] = function() if all_sides() > 5 then dual_tunnel_swap_rnd(math.random(4, 6), l_getDelayMult() * (all_sides() > 6 and 1.5 or 1), false) else pattern[59]() end end,
    [59] = function() strange_tunnel(math.random(2, 6), 1, l_getDelayMult()) end,
    [60] = function() broekn_tunnel(math.random(4, 6), 1, l_getDelayMult()) end,

    [100] = function() if all_sides() > 3 then swap_corridor(l_getDelayMult()) else pattern[math.random(2)]() end end,
    [101] = function() if all_sides() > 3 then swap_lr_once(2 * l_getDelayMult()) else pattern[100]() end end,
    [102] = function() if all_sides() > 3 then swap_swap(math.random(2, 6), l_getDelayMult() * 1.25) else pattern[math.random(2)]() end end,
    [103] = function() if all_sides() > 5 then dual_tunnel_swap_rnd(math.random(4, 6), l_getDelayMult() * (all_sides() > 6 and 1.5 or 1), true) else pattern[59]() end end,
    [104] = function() if all_sides() > 3 then lr_swap_lr(l_getDelayMult()) else pattern[math.random(2)]() end end,
    [105] = function() if all_sides() > 5 then dual_spiral_swap(math.random(3),l_getDelayMult()) else pattern[50]() end end,
    [106] = function() if all_sides() > 3 then swap_chance(l_getDelayMult() * 2.5) else pattern[math.random(2)]() end end,
    [107] = function() if all_sides() > 3 then aquarium_swap_lr(2, l_getDelayMult() * (all_sides() > 4 and 2.5 or 1)) else pattern[math.random(2)]() end end,

    -- for recursion event (from ozymandias)
    [200] = function() tunnel(math.random(2), l_getDelayMult() / 2.5) end,
    [201] = function() short_tunnel(math.random(3), l_getDelayMult() / 1.25) end,
}

markov_keys = {
    ["basic"] = {
        19, 19, 5, 5, 8, 8, 15, 15, 14, 14, 11, 11, 20, 20, 9, 9,
        50, 50, 51, 51, 52, 52, 53, 53, 54,
        100, 100, 101, 101, 102, 102, 103 
    },
    ["bar"] = {
        19, 19, 5, 5, 8, 8, 15, 15, 14, 14, 11, 11, 20, 20, 9, 9
    },
    ["jumb"] = { 15 },
    ["tun"] = {
        52, 52, 53, 53, 54,
        100, 101, 102, 103
    },
    ["spi"] = {
        15, 15,
        50, 50, 51, 51
    },
    ["rng"] = {
        15, 15,
        100, 100, 102, 102
    },
    ["incr2"] = {
        200, 201,
        100, 102, 101, 107
    },
    ["1e"] = {
        1, 2, 3, 4, 6, 7, 8, 9, 10, 12, 18,
        50, 51, 51, 52, 52, 53, 53, 54, 59,
        101, 101, 101, 106, 106
    },
    ["2e"] = {
        1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 13, 16, 16, 16, 17, 17, 
        51, 51, 52, 52, 52, 54, 55, 56, 58
    },
    ["3e"] = {
        1, 2, 3, 4, 5, 6, 8, 9, 10, 17, 17,
        51, 51, 52, 52, 57
    },
    ["4e"] = {
        1, 2, 3, 6, 9, 10, 19, 21,
        50, 50, 60,
        101, 101, 102, 102, 103, 104, 107
    },
    ["bnos"] = {
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21
    },
    ["cnos"] = {
        50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60
    },
    ["snos"] = {
        101, 102, 103, 104, 105, 106, 107
    },
}

function get_markov_keys(keys_table)
getKeys = type(keys_table) == "table" and keys_table or markov_keys["basic"]
shuffle(getKeys)
pat_index = 1
end
increvent = {
    cur = 0,
    limit = u_rndInt(10, 15)
}
pat_event = { "barrage hell", "jumble up", "tunnel town", "dizzy...", "?????", "recursion", "first era", "second era", "third era", "final era", "barrage-nostalgia", "cage-nostalgia", "swap-nostalgia" }
pat_event_selected = pat_event[u_rndIntUpper(#pat_event)]

function spawn_markov_patterns(events)
    if events then
        if increvent.cur > increvent.limit then
            increvent.cur = 0
            increvent.limit = u_rndInt(10, 15)
            pat_event_selected = pat_event[u_rndIntUpper(#pat_event)]
            e_messageAddImportant("event: " .. pat_event_selected, 120)
                if pat_event_selected == "barrage hell"      then get_markov_keys(markov_keys["bar"])
            elseif pat_event_selected == "jumble up"         then get_markov_keys(markov_keys["jumb"])
            elseif pat_event_selected == "tunnel town"       then get_markov_keys(markov_keys["tun"])
            elseif pat_event_selected == "dizzy..."          then get_markov_keys(markov_keys["spi"])
            elseif pat_event_selected == "?????"             then get_markov_keys(markov_keys["rng"])
            elseif pat_event_selected == "recursion"         then get_markov_keys(markov_keys["incr2"])
            elseif pat_event_selected == "first era"         then get_markov_keys(markov_keys["1e"])
            elseif pat_event_selected == "second era"        then get_markov_keys(markov_keys["2e"])
            elseif pat_event_selected == "third era"         then get_markov_keys(markov_keys["3e"])
            elseif pat_event_selected == "final era"         then get_markov_keys(markov_keys["4e"])
            elseif pat_event_selected == "barrage-nostalgia" then get_markov_keys(markov_keys["bnos"])
            elseif pat_event_selected == "cage-nostalgia"    then get_markov_keys(markov_keys["cnos"])
            elseif pat_event_selected == "swap-nostalgia"    then get_markov_keys(markov_keys["snos"])
            end
        end
        if increvent.cur > 5 then
            get_markov_keys() -- reset to default
        end
    end
    pattern[getKeys[pat_index]]()
    pat_index = pat_index + 1
    increvent.cur = increvent.cur + 1
end

function shuffle_markov_keys()
    if pat_index > #getKeys then
        shuffle(getKeys)
        pat_index = 1
    end
end