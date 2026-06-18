-- this pattern logic. IS NOT. PLAGIARISM. :cleanse: so i made my own pattern logic properly.

-- utils
GLOBAL_TEMPO = 128
GLOBAL_TIME_SIGNATURE = 4 / 4
GLOBAL_SPAWN_DISTANCE_MULT = 1
GLOBAL_SPAWN_DISTANCE_ADD = -20
GLOBAL_TEMPO_DM_STATE = 1

GLOBAL_SIDE_SEGMENT = 1

palletes = {
    ["basic"] = {
		-1,-1,-2,-2,-3,-3,
		1,2,3,4,5,6,11,12,13,14,23,35,41,42,
		51,52,53,54,51.5,52.5,
		101,102,104,105,106,107,108,101.5,
		151,151,152,152,153,153,154,155,156,157,158,159,160,
		201,202,203,204,205,206,207
	},
	
	-- for debug only.
    --["basic"] = {5, -2},
    --["basic"] = {206},

    ["bar"] = {1,2,3,4,5,6,11,12,13,14,23,35,41,42},
    ["sol"] = {-1,-1,-2,-2,-3,-3},
    ["tun"] = {101,102,104,105,106,107,108,101.5},
    ["spi"] = {51,52,53,54,51.5,52.5},
    ["cge"] = {201,202,203,204,205,206,207},
    ["swp"] = {151,152,153,154,155,156,157,158,159,160},
    ["rng"] = {6,11,35,41,42,101.5,104,106,152,153,154,205},
}

cur_shapes, min_shapes, max_shapes = l_getSides(), l_getSidesMin(), l_getSidesMax()
raw_shapes = cur_shapes;
last_shape = cur_shapes;

side_pos, su, sa, st = 0, {}, {}, {}
t, d, m = 0, 0, 0
temp_shape = nil
sideSpace = {}

local del_pat, next_spwn, freq_left, freq_targ, is_prep, is_wall, deco_left = 0, 0, 0, 0, false, false, 0
local pside, pdir = 0, 1
local pat_num, pat_num_old, pat_times, pat_selected = 1, 0, 0, palletes["basic"]
local pat_event_cur, pat_event_max = 256, 5
local lgc_event_cur, lgc_event_max = 256, 5
name_pallete = { "barrage", "solo", "tunnel", "whirlwind", "cage", "swap", "random" }
local incrementTimer, incrementTimesMax = 0, 2

local targetFreqTable, patternChange, chainAlternative
chanceMultiplier = 2.5

function set_sides(v)
    cur_shapes = type(v) == "number" and v or l_getSides()
    raw_shapes = cur_shapes;
end

function tmp_n_set_sides(v)
    temp_shape = raw_shapes; cons("temp_shape: " .. temp_shape)
    raw_shapes = v; cons("raw_shapes: " .. raw_shapes)
end

function all_sides()      return raw_shapes                                     end
function bar_side(v)      return all_sides() - (type(v) == "number" and v or 1) end
function odd_side(offset) return (all_sides() + (offset or 0)) % 2              end
function rng_dir()        return (math.random(0, 1) - 0.5) * 2                  end
function poly_side(v, odd_even)
    v = v or 2
    local stat = odd_even % 2 == 1 and math.ceil or math.floor
    return stat(all_sides()/v)
end

function neg(value)  if value >  0 then return 1 elseif value < 0 then return -1 end return 0 end
function negn(value) if value >= 0 then return 1 else                  return -1 end          end
function neg0(value) if value >= 0 then return 1 else                  return 0  end          end

function get_tempo(v) return 60 / (v or GLOBAL_TEMPO) end
function get_thick_sync(v)
    return (get_tempo(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * v * 3.75 * 80 * u_getSpeedMultDM()) + 1;
end
function getLevelTimeAndSyncToDM()
    return l_getLevelTime() * GLOBAL_TEMPO_DM_STATE
end
function rnd_table_select(t)
    return t[math.random(1, #t)]
end
function clamp(v, min, max)
    return (v >= max and max) or (v <= min and min) or v
end

fshapes = 4

function getNewWallValues()
	sideSpace = {}

	if fshapes == 1 then
		print("fake cur_shapes only 1? pathetic.")
		return
	end
	if raw_shapes <= fshapes then
		print("fck you")
		return
	end

	local minLimit = 1;
	local maxLimit = fshapes - 1;
	local heh = math.random(1, 1);

	print("actualShape: " .. raw_shapes)
	print("heh: " .. heh)

	print("getting new wall side_pos")

	for i = 1, fshapes - 1 do
		sideSpace[i] = math.random(minLimit, raw_shapes-maxLimit-heh);
		print("side picked: " .. sideSpace[i])
		maxLimit = maxLimit + sideSpace[i] - minLimit;
		print("maxLimit " .. maxLimit)
		if heh ~= 0 then heh = heh - 1; end
	end

	sideSpace[#sideSpace + 1] = raw_shapes
	print("\nadding last side\n")

	for i = 1, fshapes - 1 do
		sideSpace[#sideSpace] = sideSpace[#sideSpace] - sideSpace[i];
		print("side " .. i .. ": " .. sideSpace[i])
	end
	print("side " .. fshapes .. ": " .. sideSpace[#sideSpace])
end

function get_result()
    sa = {}

    for av = 1, all_sides() do
        if su[av] == 0 then
            table.insert(sa, av)
        end
    end

    if #sa > 1 then
        side_pos = sa[math.random(#sa)]
    else
        side_pos = sa[1]
    end

    if side_pos == nil then
        cons("CAUTION: side_pos IS nil AND NO AVAILABLE SIDES TO SPAWN WITH SIDES, RETURNING TO PROPER SIDE RANGE...")
        side_pos = 0 --math.random(cur_shapes) - 1
    end
end

-- common
function wall_base(s, t)
    t_eval([[l_setWallSpawnDistance(]] .. 100 + 1100 * u_getSpeedMultDM() * 1.0 * get_tempo(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * GLOBAL_SPAWN_DISTANCE_MULT * GLOBAL_TIME_SIGNATURE + GLOBAL_SPAWN_DISTANCE_ADD .. [[)]])
    for i = 0, GLOBAL_SIDE_SEGMENT - 1 do w_wall((s or 0) * GLOBAL_SIDE_SEGMENT + i, t or THICKNESS) end
end

function wall_ex(r, s, e, m, t)
    e = type(e) == "number" and e or 1
    m = type(m) == "number" and m or 1

    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = math.min(e, 0), math.max(e-1, 0), m do
        su[(s + i) % all_sides()+1] = 1
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
    end

    return su
end

function wall_ex_2(r, s, e, m, t)
    e = type(e) == "number" and e or 0
    m = type(m) == "number" and m or 1

    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    for i = math.min(e, 0), math.max(e, 0), 1 do
        su[(s + i * m) % all_sides()+1] = 1
        if t ~= 0 then
            wall_base((s + i * m) % all_sides()+1, t)
        end
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
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
    end

    for i = math.ceil(all_sides() / 2), all_sides() - 2 do
        su[(s + i) % all_sides()+1] = 1
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
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
    if t ~= 0 then
        wall_base((s + 0) % all_sides()+1, t)
    end

    for i = 2, all_sides() - 2 do
        su[(s + i) % all_sides()+1] = 1
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
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
            if t ~= 0 then
                wall_base((s + math.floor(i * (all_sides() / m))) % all_sides()+1, t)
            end
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
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
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

    for i = min, max, 1 do
        su[(s + i) % all_sides()+1] = 1
        if t ~= 0 then
            wall_base((s + i) % all_sides()+1, t)
        end
    end

    return su
end

local function wall_pie_base(r, s, t) --position = wall.. thick = thickness
    if r then
        for i = 0, all_sides() do
            su[i] = 0
        end
    end

    if s < 0 then s = (-s % -fshapes)*-1;
    elseif s > fshapes then s = (s % fshapes);
    end

    if s == 0 then s = fshapes; end --allows 0 to spawn fshapes.. very helpful!!

    local pos = -1;
    for i = 1, fshapes, 1 do
        if i == s then
            for j = 0, sideSpace[i]-1 do
                su[(pos + j) % all_sides() + 1] = 1
                if t ~= 0 then
                    wall_base((pos + j) % all_sides() + 1, t);
                end
            end
        end
        pos = pos + sideSpace[i];
    end

    return su
end

function wall_pie(r, s, t)
    if fshapes == 1 then
        wall_ex(r, s, 1, 1, t)
        return
    end
    if raw_shapes <= fshapes then
        wall_ex(r, s, 1, 1, t)
        return
    end
    wall_pie_base(r, s, t)
end

-- utils

local pside, pdir = 0, 1
local options = {}
local rng, chance = 0, 0
local freq_left, freq_targ = -999, 0
local pat_freq_left, pat_freq_targ = 0, 0
local type_end_delay, type_end_delay_old = 0, 0
local freq_halts = 0
local is_time_signature = false

function get_del(mult, is_dcr)
	if getLevelTimeAndSyncToDM() > del_pat then
		if is_dcr then
			freq_left = freq_left - 1
			pat_freq_left = pat_freq_left - 1
		end
		if freq_left > (type_end_delay == 5 and 0 or -1) then
			del_pat = del_pat + get_tempo(GLOBAL_TEMPO) * mult
		end
		return true;
	end
	return false;
end

function prepare_values()
	if is_prep then
		is_prep = false;
		return true;
	end
	return false;
end

function is_wall_avail()
	if is_wall then
		is_wall = false;
		return true;
	end
	return false;
end

function reset_pats()
	freq_left = -999
	pat_times = 0
	del_pat = getLevelTimeAndSyncToDM()
end

function is_pattern_guess_end_del()
	if type_end_delay == 5 then return 2; end
	if type_end_delay < 3 then return 0; end
	return 1
end

function is_pattern_guess_end_del_before()
	if type_end_delay_old == 5 then return 2; end
	if type_end_delay_old < 3 then return 0; end
	return 1
end

local tahanDulu = false
local is_pat_halt = false
local is_pat_halt_2 = false
local is_incr = false
local inc_timer = 0
local inc_times = 0

function ensure_halt_pattern_or_not() -- onUpdate
	if getLevelTimeAndSyncToDM() > inc_timer then
		inc_timer = inc_timer + get_tempo(GLOBAL_TEMPO)
		if is_incr then
			is_incr = false;
			tahanDulu = false; -- resume the pattern logic
			pat_times = 0
			del_pat = getLevelTimeAndSyncToDM()
			run_event()
		end
	end

	if u_isFastSpinning() then
		if not is_pat_halt then
			is_pat_halt = true
			tahanDulu = true
		end
	else
		is_pat_halt = false
	end
end

function enable_pattern_after_incr() -- onIncrement
	inc_times = inc_times + 1
	is_incr = true
end

local logic_event_after_incgr = false
local logic_rnd = 0

function end_pattern(tipe)
	typeEndDelayOld = type_end_delay
	cons("current type_end_delay: " .. tostring(type_end_delay))
	if type_end_delay == 5 then
		get_result()
	elseif type_end_delay == 3 or type_end_delay == 4 then
		get_result()
		side_pos = side_pos + rng_dir() * clamp(poly_side(4, 0) * math.random(-3, 2), 0, 2);
	else
		side_pos = math.random(all_sides()) - 1
	end
	-- raw_shapes ~= cur_shapes
	if tipe == 2 then
		type_end_delay = 4
	elseif tipe == 3 then
		type_end_delay = 5
	else
		type_end_delay = 5 --(pat_num < 0) and math.random(0, 4) or math.random(0, 5)
	end
end

function run_event()
	if inc_times % 2 == 1 then
		if math.random(3) == 3 then
			logic_rnd = ((min_shapes ~= max_shapes) and math.random(3)) or math.random(2, 3)
			local logic_events = { "incongruence", "seamless", "endless" }
			e_messageAddImportant("logic event: " .. logic_events[logic_rnd], 80)
			cons("logic event: " .. logic_rnd .. " - ".. logic_events[logic_rnd])
			lgc_event_cur = 0
			lgc_event_max = math.random(4, 8)
		else
			local pallete_rnd = math.random(7)
			pat_selected = (pallete_rnd == 1  and palletes["bar"]) or
						   (pallete_rnd == 2  and palletes["sol"]) or
						   (pallete_rnd == 3  and palletes["tun"]) or
						   (pallete_rnd == 4  and palletes["spi"]) or
						   (pallete_rnd == 5  and palletes["cge"]) or
						   (pallete_rnd == 6  and palletes["swp"]) or
						   (pallete_rnd == 7  and palletes["rng"]) or
							palletes["basic"]
			e_messageAddImportant("pallete event: " .. name_pallete[pallete_rnd], 80)
			cons("pallete event: " .. pallete_rnd .. " - " .. name_pallete[pallete_rnd])
			pat_event_cur = 0
			pat_event_max = math.random(4, 8)
		end
	end
end

function reset_event()
end

function run_pat_logic(freq, events_enable, override_table)
	-- event manager
	local incrementTimerStats = incrementTimer - getLevelTimeAndSyncToDM()
	if incrementTimerStats < 0 and events_enable then
		incrementTimer = incrementTimer + (get_tempo(GLOBAL_TEMPO) * 16) * incrementTimesMax

		if pat_times > 1 then
			incrementTimesMax = math.random(2)
		end
	end

-- start off a barrage pallete
	if pat_num == 1 then
		if prepare_values() then -- barrage spiral, 0.5 mult tempo, no override shape
		end

		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				wall_ex(true, side_pos, all_sides() - 1, 1, THICKNESS)
				side_pos = side_pos + pdir;
			end
		end
	elseif pat_num == 2 then -- random distance barrage, 0.5 mult tempo, no override shape
        if prepare_values() then
            options = { 1, rng_dir() }
        end
        if get_del(.5, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if timesFix % 2 == 0 then
                options = { 1, rng_dir() }
            end

            if freq_left == freq_halts then
                wall_ex(true, side_pos, all_sides() - 1, 1, THICKNESS)
            elseif freq_left > freq_halts then
                if options[(timesFix % 2) + 1] > 0 then
                    wall_ex(true, side_pos, all_sides() - 1, 1, THICKNESS)
                    pdir = rng_dir();
                end
            end

            side_pos = side_pos + pdir
        end
	elseif pat_num == 3 then -- spiral rng barrage, 0.5 mult tempo, no override shape
		if prepare_values() then
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				wall_ex(true, side_pos, all_sides() - 1, 1)
				side_pos = side_pos + rng_dir();
			end
		end
	elseif pat_num == 4 then -- lr barrage, 0.5 mult tempo, no override shape
		if prepare_values() then
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				wall_ex(true, side_pos, all_sides() - 1, 1)
				side_pos = side_pos + pdir;
				pdir = -pdir;
			end
		end
	elseif pat_num == 5 then -- inv barrage, 1 mult tempo, no override shape
		if prepare_values() then
			options = {
				beat_mult = (is_time_signature and (math.ceil(freq / 2) * 2) / freq) or 1,
				bar_type = math.random(2),
			}
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
				options.beat_mult = 1
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
			if options.bar_type > 1 then
				pdir = 1
			end
		end
		if get_del(1 * options.beat_mult, true) then
			if options.bar_type > 1 then
				if pdir > 0 then
					wall_ex(true, side_pos, all_sides() - 1, 1)
				else
					wall_ex(true, side_pos - ((poly_side(2, 0) - 2) * 1) - 2, ((poly_side(2, 0) - 2) * 2 * 1) + 3, 1)
				end
			else
				wall_ex(true, side_pos, all_sides() - 1, 1)
				side_pos = side_pos + (pdir * poly_side(2, 0));
			end
			pdir = -pdir;
		end
-- alternating barrage-based pallete barrage, 1 mult tempo, no override shape
	elseif pat_num == 11 then
		if prepare_values() then -- alternating barrage swap(?), 0.5 mult tempo, no override shape
            if odd_side() == 0 then
                side_pos = side_pos + 1
            end
            pdir = 1
		end

		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				wall_ex(true, side_pos + pdir, math.floor(all_sides() / 2) + (pdir * 0.5 - 0.5) + 4, 2)
				if odd_side() == 0 then
					if math.random(0, 1) == 0 then
						side_pos = side_pos + rng_dir()
					else
						side_pos = side_pos + (pdir * poly_side(2, 0))
						pdir = -pdir
					end
				else
					side_pos = side_pos + (pdir * (all_sides() > 5 and poly_side(2, 0) or 1))
					pdir = -pdir
				end
			end
		end
    elseif pat_num == 12 then -- alt half barrage, 1 mult tempo, no override shape
        if prepare_values() then
            pdir = neg0(rng_dir())
        end
        if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

			if freq_left >= freq_halts then
				if (timesFix + neg0(pdir)) % 2 == 1 then 
					wall_ex(true,  side_pos, poly_side(2, 0), 1)
					wall_ex(false, side_pos + poly_side(2, 0) + 1, poly_side(2, 1) - 2, 1, 0)
				else
					side_pos = side_pos + pdir * (timesFix == 0 and 1 or 0)
					wall_ex(true,  side_pos + poly_side(2, 0), poly_side(2, 1), 1)
					wall_ex(false, side_pos + 1, poly_side(2, 0) - 2, 1, 0)
				end
			end
        end
    elseif pat_num == 13 then -- odd alt barrage, 1 mult tempo, no override shape
        if prepare_values() then
            pdir = 1
			options = { 0 }
        end
        if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				options[1] = 0
				
				if timesFix == 0 then
					side_pos = side_pos - 1
				end

				for odd = 0, all_sides() - 1 do
					if pdir < 0 then
						if odd % 3 == 0 then
							wall_ex(options[1] == 0, odd + side_pos, 1, 1)
							options[1] = options[1] + 1
						end
					else
						if odd % 3 ~= 0 then
							wall_ex(options[1] == 0, odd + side_pos, 1, 1)
							options[1] = options[1] + 1
						end
					end
				end

				pdir = -pdir
			end
        end
    elseif pat_num == 14 or pat_num == 14.1 or pat_num == 14.2 then -- alt trap barrage, 1 mult tempo, no override shape
        if prepare_values() then
            pdir = 1
			options = {
				alg = (pat_num == 14.1 and 2) or (pat_num == 14.2 and 1) or 0, -- 14: original, 14.1: Tau628's based 1, 14.2: Tau628's based 2
				alg_dir = rng_dir(),
			}
        end
        if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if freq_left >= freq_halts then
				if timesFix % 2 == 0 then
					wall_ex_2(true, side_pos, all_sides() - 2, 1)
				else
					wall_ex_2(true,  side_pos - (1 + clamp(options.alg * options.alg_dir, 0, 1)), options.alg, 1)
					wall_ex_2(false, side_pos - (3 + clamp(options.alg * options.alg_dir, 0, 1)), all_sides() - (4 + options.alg), 1, 0)
					if pat_num == 14.2 then
						side_pos = side_pos - options.alg_dir
					end
					if pat_num >= 14.1 then
						options.alg_dir = -options.alg_dir
					end
				end
			end
        end
-- start off a vorta barrage pallete
    elseif pat_num == 21 then  -- vorta spiral, 0.5 mult tempo, no override shape
        if prepare_values() then
        end

        if get_del(.5, true) then
			if freq_left >= freq_halts then
				vorta_wall(true, side_pos)
				side_pos = side_pos + pdir
			end
        end
    elseif pat_num == 22 then -- vorta rev barrage, 1 mult tempo, no override shape
        if prepare_values() then
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				if freq_left == math.floor(freq_targ / 2) + 1 then
					pdir = -pdir
				end
				vorta_wall(true, side_pos)
				side_pos = side_pos + pdir
			end
        end
    elseif pat_num == 23 then -- vorta spi rnd barrage, 1 mult tempo, no override shape
        if prepare_values() then
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				vorta_wall(true, side_pos)
				side_pos = side_pos + rng_dir()
			end
        end
    elseif pat_num == 24 then -- vorta lr barrage, 1 mult tempo, no override shape
        if prepare_values() then
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				vorta_wall(true, side_pos)
				side_pos = side_pos + pdir
				pdir = -pdir
			end
        end
    elseif pat_num == 31 then -- semi-holed bar spi, 1 mult tempo, no override shape
        if prepare_values() then
            side_pos = side_pos - math.random(0, 1) * 2
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				dual_holed_bar(true, side_pos)
				side_pos = side_pos + pdir
			end
        end
    elseif pat_num == 32 then -- semi-holed bar rng spi, 1 mult tempo, no override shape
        if prepare_values() then
            side_pos = side_pos - math.random(0, 1) * 2
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				dual_holed_bar(true, side_pos)
				side_pos = side_pos + rng_dir()
			end
        end
    elseif pat_num == 33 then -- semi-holed bar lr, 1 mult tempo, no override shape
        if prepare_values() then
            side_pos = side_pos - math.random(0, 1) * 2
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				dual_holed_bar(true, side_pos)
				side_pos = side_pos + pdir
				pdir = -pdir
			end
        end
    elseif pat_num == 34 then -- semi-holed bar inv, 1 mult tempo, no override shape
        if prepare_values() then
            side_pos = side_pos - math.random(0, 1) * 2
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				dual_holed_bar(true, side_pos)
				side_pos = side_pos + (pdir * poly_side(2, 0))
			end
        end
    elseif pat_num == 35 then -- semi-holed bar spi, 1 mult tempo, no override shape
        if prepare_values() then
            side_pos = side_pos - math.random(0, 1) * 2
            options = { chance = 50 }
        end
        if get_del(.5, true) then
			if freq_left >= freq_halts then
				dual_holed_bar(true, side_pos)
				options.chance = options.chance * (math.random() * 1.5 + 1)
				
				if options.chance > 100 then
					side_pos = side_pos + poly_side(2, 0)
					options.chance = options.chance / 3
				else
					side_pos = side_pos + rng_dir()
				end
            end
        end
-- misc
    elseif pat_num == 41 then -- jumbled barrage, 1 mult tempo, no override shape
        if prepare_values() then
        end
        if get_del(.5, true) then
            if freq_left >= freq_halts and freq_left < freq_targ - ((is_pattern_guess_end_del_before() == 2 and 1 or 0)) then
                for i = 0, all_sides() - 2 do
                    wall_ex(i == 0, side_pos + math.random(all_sides()) - 1, 1, 1)
                end
            end
        end
    elseif pat_num == 42 then -- spray barrage, 1 mult tempo, no override shape
        if prepare_values() then
        end
        if get_del(.5, true) then
            if freq_left >= freq_halts and freq_left < freq_targ - ((is_pattern_guess_end_del_before() == 2 and 1 or 0)) then
                wall_ex(true, side_pos + math.random(all_sides()), math.random(all_sides() - 3), 1)
            end
        end

-- spiral palletes
	elseif pat_num == 51 then  -- double spiral, 0.25 mult tempo..., no override shape
		if prepare_values() then
			options = {
				beat_mult = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (all_sides() / 6)) and 2 or 1,
				end_del_fix_whyy = is_pattern_guess_end_del() == 2 and 1 or 0,
			}
			freq_left = (freq * (2 / options.beat_mult)) + (clamp((is_pattern_guess_end_del() - 1), 0, 1) * clamp(2 - options.beat_mult, 0, 1)) -- 2 is 1, otherwise 0
			freq_halts = ((is_pattern_guess_end_del() == 2 and 0) or (is_pattern_guess_end_del() == 1 and 2) or 4) / options.beat_mult
		end
		if get_del(.25 * options.beat_mult, true) then
			if freq_left >= freq_halts + options.end_del_fix_whyy then
				wall_ex(true,            side_pos + poly_side(2, 0), 1, 1, get_thick_sync(.275 * options.beat_mult) * clamp(clamp(all_sides() - 5, 0, 1), 0, 1))
				wall_ex(all_sides() < 6, side_pos,                   1, 1, get_thick_sync(.275 * options.beat_mult), 0, 1)
				side_pos = side_pos + pdir;
			end
		end
	elseif pat_num == 61 then  -- single spiral tau based, 0.25 mult tempo..., no override shape
		if prepare_values() then
			options = {
				beat_mult = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (all_sides() / 6)) and 2 or 1,
			}
			freq_left = (freq * (2 / options.beat_mult)) + (clamp((is_pattern_guess_end_del() - 1), 0, 1) * clamp(2 - options.beat_mult, 0, 1)) -- 2 is 1, otherwise 0
			freq_halts = ((is_pattern_guess_end_del() == 2 and 0) or (is_pattern_guess_end_del() == 1 and 2) or 4) / options.beat_mult
		end
		if get_del(.25 * options.beat_mult, true) then
			if freq_left >= freq_halts then
				wall_ex_2(true, side_pos + poly_side(4, 1) - 1, poly_side(2, 0) - 1, 1, THICKNESS)
				wall_ex_2(true, side_pos + poly_side(4, 1) - 2, all_sides() - 2, 1, 0)
				side_pos = side_pos + pdir;
			end
		end

-- tunnel palletes
	elseif pat_num == 101 then -- disgraceful tunnel, 0.5 mult tempo, no override shape
		-- SPHAGETTI CODE!!!!! HORRAYY!!!! konto
		if prepare_values() then
			freq_left = (freq * 2) + clamp((is_pattern_guess_end_del() - 1), 0, 1)
            freq_targ = freq_left
			freq_halts = ((is_pattern_guess_end_del() == 2 and 0) or (is_pattern_guess_end_del() == 1 and 2) or 3)
			options = {
				available_tables = {},
				tables_passed = 1,
				large_walls = math.random(bar_side(2)),
				pat_divs = {
					0,
					(GLOBAL_TEMPO < 120 and 3) or (GLOBAL_TEMPO >= 150 and 1) or 2,
					math.floor(freq_targ / 2) - 8,
				},
				pat_div = 0,
				dirs = { 1, -1 },
			}
			options.pat_divs[1] = math.floor(options.large_walls * .5 - .5)
			cons("pat_div 1: " .. options.pat_divs[1])
			cons("pat_div 2: " .. options.pat_divs[2])
			cons("pat_div 3: " .. options.pat_divs[3])
			options.pat_div = options.pat_divs[1] + options.pat_divs[2] + options.pat_divs[3]

			for i = 0, options.pat_div - 1 do
				table.insert(options.available_tables, math.floor(((freq_targ - freq_halts) / options.pat_div) * i))
				cons("reps: " .. i .. " / added: " .. options.pat_div)
			end
			cons("pat_div: " .. options.pat_div)
			cons("available_tables: " .. #options.available_tables)
		end

		if get_del(.25, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

			if is_wall_avail() then
				for i = 1, options.large_walls do
					wall_base(side_pos + (i * options.dirs[1]), get_thick_sync(.25 * (freq_left - freq_halts)) + THICKNESS)
				end
			end

			if options.tables_passed <= #options.available_tables then
				if timesFix == options.available_tables[options.tables_passed] and freq_left > freq_halts then
					cons("tables_passed: " .. options.tables_passed)
					options.tables_passed = options.tables_passed + 1
					wall_ex_2(true, side_pos - ((bar_side() - options.large_walls) * neg0(options.dirs[2])), all_sides() - 2, 1)
					options.dirs[2] = -options.dirs[2]
				end
			end

			if freq_left == freq_halts then
				wall_ex_2(true, side_pos - ((bar_side() - options.large_walls) * neg0(options.dirs[2])), all_sides() - 2, 1)
			end
		end
	elseif pat_num == 102 then -- short tunnel, 0.5 mult tempo, no override shape
		if prepare_values() then
			freq_halts = (is_pattern_guess_end_del() == 0 and 2) or (is_pattern_guess_end_del() == 1 and 1) or 0
			options = {
				math.random(bar_side(2)), -- offsets
			}

			if pdir < 0 then
				side_pos = side_pos - 1
			end
		end

		if get_del(.5, true) then
			if is_wall_avail() then
				wall_base(side_pos - options[1], get_thick_sync(.5 * (freq_targ - clamp(freq_halts, 1, 2))) + THICKNESS)
			end

			if freq_left >= (freq_halts - 1) then
				if pdir > 0 then
					wall_draw(true, side_pos, 0, bar_side(2) - options[1])
					wall_ex(true, side_pos, all_sides() - 1, 1, 0)
				else
					wall_draw(true, side_pos - 1, options[1] * -1, 0)
					wall_ex(true, side_pos + 1, all_sides() - 1, 1, 0)
				end

				pdir = -pdir
			end
		end
	elseif pat_num == 103 then -- random ahh double tunnel, 0.5 mult tempo
		if prepare_values() then
			options = {
				rng_dir(),
				(is_pattern_guess_end_del() == 2 and 0) or 1,
				clamp(is_pattern_guess_end_del() - 1, -1, 1),
				start_pos = math.random(1, poly_side(2, 1) - 2),
				end_pos = math.random(1, (all_sides() - 2) - poly_side(2, 1)),
				pat_freq_left = 1,
				pattern_change = 0,
			}
            side_pos = side_pos + neg0(all_sides() ~= 5 and options[1] or 0) * poly_side(2, 0)
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

			options.pat_freq_left = options.pat_freq_left - 1
			if options.pat_freq_left < 0 then
				options.pat_freq_left = math.random(0, 2)
				options.pattern_change = math.random(0, 1)
			end
			
			if options.pattern_change == 1 and freq_left > 1 - options[3] - options[2] then
				--pat_freq_left = 0
				side_pos = side_pos + rng_dir()
			end
			
			if freq_left > 1 - options[3] - options[2] then
				wall_ex_2(true,  side_pos,                   0, 1, get_thick_sync(.5) + THICKNESS)
				wall_ex_2(false, side_pos + poly_side(2, 1), 0, 1, get_thick_sync(.5) + THICKNESS)
			end
			
			if freq_left == 1 - options[3] - options[2] then
				options.pattern_change = 0
			end
			
			if freq_left > 0 - options[3] - options[2] and options.pattern_change == 0 then
				if math.random() >= .5 and timesFix > 0 then
					if all_sides() > 6 then
						if options[1] > 0 then
							wall_draw(true,  side_pos, 0, options.start_pos)
							wall_draw(false, side_pos + poly_side(2, 1), 0, options.end_pos)
						else
							wall_draw(true,  side_pos + options.start_pos + 1, 0, options.start_pos)
							wall_draw(false, side_pos + poly_side(2, 1) + options.end_pos + 1, 0, (all_sides() - 2) - (poly_side(2, 1) + 1))
						end
					else
						vorta_wall(true, side_pos + (neg0(options[1]) * 2), THICKNESS)
					end
				else
					if all_sides() > 6 then
						if options[1] > 0 then
							wall_draw(true,  side_pos, 0, options.start_pos)
							wall_draw(false, side_pos + poly_side(2, 1) + options.end_pos + 1, 0, (all_sides() - 2) - (poly_side(2, 1) + 1))
						else
							wall_draw(true,  side_pos + options.start_pos + 1, 0, options.start_pos)
							wall_draw(false, side_pos + poly_side(2, 1), 0, options.end_pos)
						end
					else
						dual_holed_bar(true, side_pos + (neg0(options[1]) * poly_side(2, 1)), THICKNESS)
					end
				end
			end
			
			if (timesFix == 0 or timesFix == freq_targ - (2 - options[3]) + options[2]) and all_sides() == 5 then
				wall_ex(false, side_pos + poly_side(2, 1) + 1, 1, 1)
			end
			
			options[1] = -options[1]
		end
    elseif pat_num == 104 then -- alternating tunnel, 0.5 mult tempo, no override shape
        if prepare_values() then
			options = { pdir, side_pos, math.random(poly_side(2, 0)), is_pattern_guess_end_del() == 2 and 1 or 0 }
        end
        if get_del(.5, true) then
            if is_wall_avail() then
                wall_ex(true, side_pos + 2 - neg0(pdir), options[3], 1, get_thick_sync(.5) * clamp(freq_left - freq_halts, 0, 999) + THICKNESS)
            end

            if freq_left > freq_halts - 1 + options[4] then
                wall_ex(true, side_pos + ((options[1] > 0 and 1 or 3) * odd_side()), all_sides(), 2)
                wall_ex(false, options[2] + 2 - neg0(options[1]), options[3], 1)
                side_pos = side_pos + pdir
                pdir = -pdir
			end
            if freq_left == freq_halts then
                wall_ex(true, options[2] + 2 - neg0(options[1]), options[3], 1)
                side_pos = side_pos - neg0(options[1]) -- i hate myself ;_;
            end
        end
	elseif pat_num == 105 then -- random tunnel, 0.5 mult tempo, no override shape
		if prepare_values() then
            options = { 
				offsets = { 0, 0, 0 },
			}
            options.offsets[1] = 0
            options.offsets[2] = options.offsets[1]
            options.offsets[3] = 0
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

				if timesFix < freq_targ - (1 + freq_halts) then
					--if pat_freq_left > 0 then
						wall_base(side_pos - pdir, get_thick_sync(.5) + (THICKNESS / 2))
					--end
				end
				
				if options.offsets[3] < options.offsets[1] then
					options.offsets[3] = options.offsets[3] + 1
				elseif options.offsets[3] > options.offsets[1] then
					options.offsets[3] = options.offsets[3] - 1
				end

				if options.offsets[3] == options.offsets[1] then
					options.offsets[2] = options.offsets[1]
					if freq_left > freq_halts then
						wall_ex(true, side_pos + options.offsets[3], bar_side(), 1)
					end
					repeat options.offsets[1] =  (math.random(bar_side(1)) - 1) * pdir
					until  options.offsets[2] ~= options.offsets[1]
				end

				if freq_left == freq_halts then
					wall_ex(true, side_pos + options.offsets[3], bar_side(), 1)
				end

				-- why me...
				--if timesFix == freq_targ - 2 then
				--	wall_ex(true, side_pos + options.offsets[3], bar_side(), 1)
				--end
			--end
		end
    elseif pat_num == 106 then -- jumbled tunnel, 0.5 mult tempo, no override shape
        if prepare_values() then
        end

        if get_del(.5, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if is_wall_avail() then
                wall_ex(true, side_pos + 1, 1, 1, get_thick_sync(.5) * clamp(freq_left - freq_halts, 0, 999) + THICKNESS)
            end

            if freq_left == freq_halts then -- whyyyyyy
                wall_ex(true, side_pos + 1, 1, 1, THICKNESS)
            end

            if timesFix > (is_pattern_guess_end_del_before() == 2 and 0 or -1) and timesFix < (freq_targ - freq_halts) - clamp(is_pattern_guess_end_del() - 1, 0, 1) then
                for i = 1, all_sides() - 3 do
                    wall_ex(false, side_pos + math.random(all_sides()), 1, 1)
                end
            end
        end
	elseif pat_num == 131 then -- pipe
		if prepare_values() then
			options = {
				dir1 = math.random(2),
				(is_pattern_guess_end_del() == 2 and 1) or 0,
				(is_pattern_guess_end_del() == 0 and 1) or 0,
				pat_freq_left = 1,
				pattern_change = 0,
			}
			side_pos = side_pos - (1 + options.dir1)
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

			wall_ex_2(true,  side_pos,     0, 1, get_thick_sync(.5) * clamp(freq_left, 0, 1) + THICKNESS)
			wall_ex_2(false, side_pos + 3, 0, 1, get_thick_sync(.5) * clamp(freq_left, 0, 1) + THICKNESS)

			if timesFix % 4 == 2 and options.dir1 == 1 then
				side_pos = side_pos + rng_dir()
			elseif timesFix % 4 ~= 3 then
				wall_ex_2(true, side_pos + options.dir1 + 1, all_sides() - 2, 1)
			end
			options.dir1 = math.random(2)

			if freq_left == freq_halts then
				options.dir1 = 2
				wall_ex_2(false, side_pos + options.dir1 + 1, all_sides() - 3, 1)
			end
		end
	elseif pat_num == 150 then -- disgraceful tunnel, 0.5 mult tempo, no override shape
		-- SPHAGETTI CODE!!!!! HORRAYY!!!! konto
		if prepare_values() then
			options = {
				0, -- current offset
				bar_side(2), -- distance
				0, -- offset
				pdir * .5 + .5, -- QUOS
				0, -- remaining
				is_pattern_guess_end_del() >= 1 and 0 or 1,
				is_pattern_guess_end_del() == 2 and -1 or 0,

				beat_mult = (math.ceil(freq / 2) * 2) / freq,
				halt_fix = freq_left >= freq_halts and 1 or 0,
			}
			if is_time_signature then
				freq_left = math.floor(freq / 2) * 2 + (type_end_delay == 5 and 1 or 0)
				options[6] = 0
				options[7] = 0
			else
				freq_left = (freq * 2) + 1 - options[6]
			end
            freq_targ = freq_left
		end

		if get_del(.5 * options.beat_mult, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			
			if timesFix % 2 == 0 then
				local min, max = pdir > 0 and 0 or 1, pdir < 0 and 1 or 2
				for i = min, all_sides() - max do
					wall_ex(i == min, i + side_pos + options[1] + options[4] - 1, 1, 1)
				end

				if math.random(0, 1) then
					pdir = -pdir
				end
				options[2] = math.random(bar_side(2))
				options[4] = pdir * .5 + .5

				if freq_left >= freq_halts * 2 then
					for i = 1, bar_side() - options[2] do
						wall_ex(false, i * -pdir + side_pos + options[1] - 1, 1, 1, get_thick_sync(.5 * options.beat_mult) * clamp(freq_left - options[6], 0, 1) + THICKNESS)
					end
				end
			else
				if freq_left >= freq_halts * 2 then
					local dirr = rng_dir()
					if options[3] > 0 then
						for off = 0, options[3] - 1 do
							if freq_left > options[6] then
								for i = 1, bar_side() - options[2] do
									wall_ex(i == 1, i * -pdir + side_pos + options[1] - 1, 1, 1, THICKNESS)
								end
							end
							side_pos = side_pos + dirr
						end
					end

					if freq_left > options[7] then
						for i = 1, bar_side() - options[2] do
							wall_ex(false, i * -pdir + side_pos + options[1] - 1, 1, 1, get_thick_sync(.5 * options.beat_mult) * clamp(freq_left - options[6], 0, 1) + THICKNESS)
						end
					end
					options[1] = options[1] + pdir * options[2]
				end
			end
		end

-- starting swap palletes
    elseif pat_num == 151 then -- simple swap, 1 mult tempo, NO TIME SIGNATURE ALLOWED, no override shape
        if prepare_values() then
            freq_left = 2
            pdir = math.random(0, poly_side(2, 0) - 2)
			options = {
				barN = function(s, n, t)
					for i = n, all_sides() - 2 - n do
						wall_ex(i == n, s + i, 1, 1, t)
					end
				end,
			}
            del_mult = 1
        end

        if freq_left == 2 then
            if get_del(del_mult, true) then
                options.barN(side_pos, pdir, THICKNESS)
                wall_base(side_pos + (pdir + 1), get_thick_sync(del_mult) + THICKNESS)
                wall_base(side_pos - (pdir + 1), get_thick_sync(del_mult) + THICKNESS)
            end
        elseif freq_left == 1 then
            if get_del(is_pattern_guess_end_del() == 2 and 0 or is_pattern_guess_end_del() == 1 and .5 or 1, true) then
                wall_grow(true, side_pos - 1, pdir + 1, 0)
            end
        end
    elseif pat_num == 152 then -- simple swap v2, 0.5 mult tempo, NO TIME SIGNATURE ALLOWED, no override shape
        if prepare_values() then
            freq_left = 2
			options = {
				dir2 = neg0(1),
			}
            del_mult = .5
        end

        if freq_left == 2 then
            if get_del(del_mult, true) then
                wall_ex(true, side_pos, all_sides() - 1, 1)
                for i = 0, options.dir2 * (poly_side(2, 0) - 2) do
                    wall_base(side_pos + (i + 1), get_thick_sync(del_mult) + THICKNESS)
                    wall_base(side_pos - (i + 1), get_thick_sync(del_mult) + THICKNESS)
                end
            end
        elseif freq_left == 1 then
            if get_del(is_pattern_guess_end_del() == 2 and 0 or is_pattern_guess_end_del() == 1 and .5 or 1, true) then
                wall_ex(true, side_pos - ((poly_side(2, 0) - 2) * options.dir2) - 2, ((poly_side(2, 0) - 2) * 2 * options.dir2) + 3, 1)
                if is_pattern_guess_end_del() == 2 then side_pos = side_pos + poly_side(2, 0) end
            end
        end
    elseif pat_num == 153 then -- random swap corridor, 0.5 mult tempo, no override shape
        if prepare_values() then
			--freq_halts = is_pattern_guess_end_del() == 0 and 2 or 1
			freq_left = freq + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
			if pdir < 0 then
				side_pos = side_pos + (poly_side(2, 0))
			end
        end

        if get_del(.5, true) then
			if is_wall_avail() then
				for i = 0, (poly_side(2, 0) - 2) do
					wall_base(side_pos + (i + 1), get_thick_sync(.5 * (freq_targ + clamp(is_pattern_guess_end_del() - 2, -2, -1))) + THICKNESS) -- TDE 0, 2...TDE 1, 1
					wall_base(side_pos - (i + 1), get_thick_sync(.5 * (freq_targ + clamp(is_pattern_guess_end_del() - 2, -2, -1))) + THICKNESS) -- TDE 0, 2...TDE 1, 1
				end
			end

			local ugyeruif = (is_pattern_guess_end_del() > 0 and 0) or 1
			if freq_left >= ugyeruif then -- TDE 0, 0...TDE 1, -1
				if pdir > 0 then
					wall_ex(true, side_pos, all_sides() - 1, 1)
				else
					wall_ex(true, side_pos - ((poly_side(2, 0) - 2) * 1) - 2, ((poly_side(2, 0) - 2) * 2 * 1) + 3, 1)
				end

				pdir = rng_dir()
			end
        end
    elseif pat_num == 154 then -- distance's simplism pattern: swap then rnadom barrage, .25 tempo mult, no override shape
        if prepare_values() then
            deco_left = 0
			options = {
				r_wall_ex = function(s, ex, thick, odd_even, ...)
					for i = 0, ex do
						wall_base(s + i, thick)
						wall_base(s + i + poly_side(2, odd_even), thick)
					end
				end,
				boff = { 0 },
				chance = 50,
			}
			freq_left = (freq * 2) + (clamp((is_pattern_guess_end_del() - 1), 0, 1) * clamp(2 - 1, 0, 1)) -- 2 is 1, otherwise 0
			freq_halts = ((is_pattern_guess_end_del() == 2 and 0) or (is_pattern_guess_end_del() == 1 and 2) or 4) - 1
        end

        if get_del(.25, true) then
			if freq_left >= freq_halts then
				if deco_left % 2 == 0 then
					wall_ex(true, side_pos, all_sides() - 1 - (odd_side() * (options.boff[1] % 2)), 1)
					options.chance = options.chance * (math.random() * 1.5 + 1)
				elseif deco_left % 2 == 1 then
					if freq_left > 0 then
						if options.chance > 75 then
							if all_sides() > 5 then
								options.r_wall_ex(side_pos + ((options.boff[1] + 1) % 2) + poly_side(2, 0) + odd_side(), clamp(poly_side(2, 0) - 2, 0, all_sides()), THICKNESS, options.boff[1])
							else
								options.r_wall_ex(side_pos + ((options.boff[1] + 1) % 2) + poly_side(2, 0) + odd_side(), 0, THICKNESS, options.boff[1])
							end
							if all_sides() % 2 == 1 then
								side_pos = side_pos + poly_side(2, options.boff[1] + 1)
								options.boff[1] = options.boff[1] + 1
							else
								side_pos = side_pos + poly_side(2, 1)
							end
							options.chance = options.chance / 3
						else
							options.boff[1] = 0
							side_pos = side_pos + rng_dir()
						end
					end
				end
			end
			deco_left = deco_left + 1
        end
	elseif pat_num == 155 then -- distance's old random barrage no delay pattern, 1 mult tempo, no override shape
        if prepare_values() then
			options = {
				beat_mult = (is_time_signature and (math.ceil(freq / 2) * 2) / freq) or 1,
			}
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
        end
        if get_del(1 * options.beat_mult, true) then
			if freq_left > 0 then
                wall_ex(true, side_pos, all_sides() - 1, 1)
                wall_base(side_pos - 1, get_thick_sync(1 * options.beat_mult) + THICKNESS)
                wall_base(side_pos + 1, get_thick_sync(1 * options.beat_mult) + THICKNESS)
                side_pos = side_pos + (rng_dir() * 2)
			else
                wall_ex(true, side_pos, all_sides() - 1, 1)
			end
        end
	elseif pat_num == 156 then -- theepie's back-and-forth tunnel swap pattern, 1 mult tempo, no override shape
        if prepare_values() then
			options = {
				beat_mult = (math.ceil(freq / 2) * 2) / freq,
			}
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
			if pdir > 0 then
				side_pos = side_pos - (poly_side(2, 1) - 1)
			end
        end
        if get_del(1 * options.beat_mult, true) then
			if is_wall_avail() then
                wall_ex_2(true, side_pos, 1, poly_side(2, 0), get_thick_sync(freq_left * options.beat_mult) + THICKNESS)
			end

            wall_ex(true, side_pos + (neg0(pdir) * 2), all_sides() - 1, 1)
            pdir = -pdir
        end
	elseif pat_num == 157 then -- vipre's spiral swap pattern based on speedruns, 1 mult tempo, no override shape
        if prepare_values() then
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
				options.beat_mult = 1
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
			options = {
				beat_mult = (is_time_signature and (math.ceil(freq / 2) * 2) / freq) or 1,
			}
        end
        if get_del(1 * options.beat_mult, true) then
            wall_ex_2(true, side_pos, all_sides() - 2, 1, THICKNESS)

			if freq_left > 0 then
				wall_base(side_pos - (1 * pdir), get_thick_sync(clamp(freq_left, 0, 1) * options.beat_mult) + THICKNESS)
				wall_base(side_pos + (2 * pdir), get_thick_sync(clamp(freq_left, 0, 1) * options.beat_mult) + THICKNESS)
				if (u_rndIntUpper(2) == 2 and all_sides() > 5) then
					wall_base(side_pos + (3 * pdir), get_thick_sync(clamp(freq_left, 0, 1) * options.beat_mult) + THICKNESS)
				end
			end
			
			side_pos = side_pos - (2 * pdir)
        end
    elseif pat_num == 158 then -- aquarium's lr-swap-lr, freq is 8, type_end_delay < 3, no override shape
        if prepare_values() then
            freq_left = 4
            deco_left = 0
			options = {
				rep_limits = { clamp(math.floor(((freq or 8) - 2) / 2) - 1, 0, 999), 2, clamp(math.ceil(((freq or 8) - 2) / 2) - 1, 0, 999) },
				rngs = math.random(3),
				dir2 = -1,
			}
			options.rep_limits[options.rngs] = options.rep_limits[options.rngs] + is_pattern_guess_end_del()
			if options.rep_limits[1] % 2 == 0 then
				pdir = 1
			else
				pdir = -1
				side_pos = side_pos + rng_dir()
			end
        end

        if freq_left == 4 then
            if get_del(.5, false) then
                if deco_left == 0 then
                    wall_ex(true, side_pos + 1, all_sides() - 3, 1, get_thick_sync(.5 * options.rep_limits[1]) + THICKNESS)
                end

                if pdir > 0 then
                    wall_ex_2(true, side_pos, all_sides() - 2, 1)
                else
                    wall_ex_2(true,  side_pos - 1, 0, 1)
                    wall_ex_2(false, side_pos + 1, all_sides() - 4, 1)
                end

                deco_left = deco_left + 1
                pdir = -pdir

                if deco_left >= options.rep_limits[1] then
                    deco_left = 0
                    pdir = -1
                    freq_left = freq_left - 1
                end
            end
        elseif freq_left == 3 then
            if get_del(.5, false) then
                if deco_left == 0 then
                    for i = 0, poly_side(2, 0) - 2 do
                        wall_base(side_pos + i + 1, get_thick_sync(.5 * options.rep_limits[2]) + THICKNESS)
                        wall_base(side_pos + i + poly_side(2, 1) + 1, get_thick_sync(.5 * options.rep_limits[2]) + THICKNESS)
                    end
                end
                wall_ex_2(true, side_pos + (poly_side(2, 1) * neg0(pdir)), all_sides() - (odd_side() * neg0(pdir) + 2), 1)
                pdir = -pdir
                if deco_left == options.rep_limits[2] then
                    deco_left = 0
                    freq_left = freq_left - 1
                    wall_ex(true, side_pos + 1 + (poly_side(2, 1) * neg0(-pdir)), all_sides() - (odd_side() * neg0(-pdir) + 3), 1, get_thick_sync(.5 * options.rep_limits[3]) + THICKNESS)
                end
                deco_left = deco_left + 1
            end
        elseif freq_left == 2 then
            if get_del(.5, false) then
                if options.dir2 > 0 then
                    wall_ex_2(true, side_pos + (poly_side(2, 1) * neg0(-pdir)), all_sides() - (odd_side() * neg0(-pdir) + 2), 1)
                else
                    wall_ex_2(true, side_pos + (poly_side(2, 0) * neg0(-pdir)) - 1, odd_side() * neg0(-pdir), 1)
                    wall_ex_2(true, side_pos + (poly_side(2, 1) * neg0(-pdir)) + 1, all_sides() - (odd_side() * neg0(-pdir) + 4), 1)
                end

                options.dir2 = -options.dir2
                deco_left = deco_left + 1

                if deco_left >= options.rep_limits[3] then
                    deco_left = 0
                    freq_left = freq_left - 1
                end
            end
        elseif freq_left == 1 then
            if get_del(is_pattern_guess_end_del() == 2 and 0 or is_pattern_guess_end_del() == 1 and .5 or 1, true) then
                if options.dir2 > 0 then
                    wall_ex_2(true, side_pos + (poly_side(2, 1) * neg0(-pdir)), all_sides() - (odd_side() * neg0(-pdir) + 2), 1)
                else
                    wall_ex_2(true, side_pos + (poly_side(2, 0) * neg0(-pdir)) - 1, odd_side() * neg0(-pdir), 1)
                    wall_ex_2(true, side_pos + (poly_side(2, 1) * neg0(-pdir)) + 1, all_sides() - (odd_side() * neg0(-pdir) + 4), 1)
                end
            end
        end
    elseif pat_num == 159 then -- aquarium long lr swapped, 1 mult tempo, no override shape
        if prepare_values() then
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
            options = {
				2,
				math.random(0, 1),
				rng_dir(),
				beat_mult = (is_time_signature and (math.ceil(freq / 2) * 2) / freq) or 1,
			}

            side_pos = side_pos - (options[2] == 0 and options[1] or 0)
        end

        if get_del(1 * options.beat_mult, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if is_wall_avail() then
                wall_base(side_pos + 1, get_thick_sync(freq_left * options.beat_mult) + THICKNESS)
                wall_base(side_pos - 1, get_thick_sync(freq_left * options.beat_mult) + THICKNESS)
            end

            if (timesFix + options[2]) % 2 == 0 then
                wall_ex(true, side_pos + options[1], all_sides() - 1, 1)
                options[1] = (options[1] * options[3])
                options[3] = -options[3]
            else
                wall_ex(true, side_pos, all_sides() - 1, 1)
                options[1] = (options[1] * options[3])
            end
        end
    elseif pat_num == 160 then -- swap spiral corridor, 0.5 mult tempo, no override shape
        if prepare_values() then
            options = {
				r_wall_ex = function(s, ex, thick, ...)
					for i = 0, math.floor(all_sides()/2) - 3 do
						wall_base(s + i, thick)
					end
					for i = 0, math.ceil(all_sides()/2) - 3 do
						wall_base(s + i + poly_side(2, 0), thick)
					end
				end,
				floorceil = math.random(0, 1) == 0 and math.floor or math.ceil
			}
        end

        if get_del(.5, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)
            
            if timesFix == 0 then
                wall_ex(true, side_pos, all_sides() - 1, 1)
                side_pos = side_pos - pdir * (pdir > 0 and poly_side(2, 0) - 2 or 1)
            elseif timesFix == options.floorceil(freq_targ / 2) - 1 then
                options.r_wall_ex(side_pos + pdir, 0, THICKNESS)
                pdir = -pdir
            end

            --if timesFix < math.floor(freq_targ / 2) or timesFix >= math.floor(freq_targ / 2) then
                if timesFix < freq_targ - (1 + freq_halts) then
                    options.r_wall_ex(side_pos, 0, get_thick_sync(.5) + THICKNESS)
                end
                if timesFix < options.floorceil(freq_targ / 2) - 2 or timesFix >= options.floorceil(freq_targ / 2) - 1 then
                    side_pos = side_pos + pdir
                end
                if timesFix == freq_targ - (1 + freq_halts) then
                    if all_sides() > 7 then
                        side_pos = side_pos + (pdir > 0 and poly_side(2, 0) - 3 or 0)
                    end
                    wall_ex(true, side_pos, all_sides() - 1, 1)
                end
            --end
        end
    elseif pat_num == 161 then -- distance's simplism pattern: doubled tunnel swap, .5 tempo mult, no override shape
        if prepare_values() then
            pdir = poly_side(2, 0)
            side_pos = side_pos + (poly_side(2, 1) + 1) * (math.random(0, 1))
            options = {
				side_lock = side_pos,
				chance = 50,
			}
        end

        if get_del(.5, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if is_wall_avail() then
                wall_ex(true, side_pos,                   poly_side(2, 0)          - 2, 1, get_thick_sync(.5 * (freq_left - freq_halts)) + THICKNESS)
                wall_ex(true, side_pos + poly_side(2, 0), poly_side(2, odd_side()) - 2, 1, get_thick_sync(.5 * (freq_left - freq_halts)) + THICKNESS)
            end

			if freq_left >= freq_halts then
				if pdir > 0 then
					wall_ex_2(true, side_pos + poly_side(2, 0) - 1, 1, poly_side(2, 1) - 1)
				else
					wall_ex_2(true, side_pos - 1, 1, poly_side(2, 0) - 1)
				end

				if odd_side() == 0 and timesFix > 0 then
					options.chance = options.chance * (math.random() * 1.5 + 1)

					if options.chance > 100 then
						wall_ex(false, side_pos + math.random(0, 1) * poly_side(2, 0), poly_side(2, 1), 1)

						options.chance = options.chance / 3
					end
				end

				if freq_left == 0 then
				    wall_ex(false, options.side_lock,                   poly_side(2, 0)          - 2, 1, THICKNESS)
				    wall_ex(false, options.side_lock + poly_side(2, 0), poly_side(2, odd_side()) - 2, 1, THICKNESS)
				end

				pdir = pdir * -1 + poly_side(2, 0)
			end
        end
	elseif pat_num == 162 then -- distance's soup sand pack pattern: tunnel swap chain, 1 mult tempo, no override shape
        if prepare_values() then
			options = {
				beat_mult = (is_time_signature and (math.ceil(freq / 2) * 2) / freq) or 1,
				patternChange = math.random(0, 2),
				chance = 1,
			}
			if is_time_signature then
				freq_left = math.floor(freq / 2)
			else
				freq_left = freq
			end
            freq_left = freq_left + (is_pattern_guess_end_del() == 2 and 1 or 0)
            freq_targ = freq_left
        end
        if get_del(options.beat_mult, true) then
			if freq_left > 0 then
				if options.patternChange % 3 == 0 and options.chance == 1 then
					if odd_side() == 1 then
						options.chance = 0
					end
					wall_ex(true, side_pos - ((poly_side(2, 0) - 2) * 1) - 2 + poly_side(2, 0), ((poly_side(2, 0) - 2) * 2 * 1) + 3, 1)
					side_pos = side_pos + poly_side(2, 0)
					for i = 0, poly_side(2, 0) - 2 do
						wall_ex(true, side_pos + (i + 1) - 1, 1, 1, get_thick_sync(options.beat_mult) + THICKNESS)
						wall_ex(true, side_pos - (i + 1) - 1, 1, 1, get_thick_sync(options.beat_mult) + THICKNESS)
					end
				else
					wall_base(side_pos + pdir, get_thick_sync(options.beat_mult) + THICKNESS)
					wall_ex(true, side_pos, all_sides() - 1, 1)
					side_pos = side_pos + (2 * pdir)
					pdir = -pdir
				end
			else
				wall_ex(true, side_pos, all_sides() - 1, 1)
			end
			options.patternChange = options.patternChange + 1
        end

	elseif pat_num == 666 then
	elseif pat_num == 666 then
	elseif pat_num == 666 then
	end

	-- variable preparations
	if freq_left <= 0 then
		-- end pattern manager
		type_end_delay_old = type_end_delay
		cons("type_end_delay: " .. type_end_delay)
		if type_end_delay == 5 then
			get_result()
		elseif type_end_delay == 3 or type_end_delay == 4 then
			get_result()
			side_pos = side_pos + (rng_dir() * clamp(math.random(0, 2), 0, 1));
		else
			side_pos = math.random(all_sides()) - 1
		end

		is_time_signature = true
		-- set freq
		if type(freq) == "nil" then
			freq = math.random(3, 6)
			is_time_signature = false
		elseif type(freq) == "table" then
			freq_tables = freq -- insert 'freq' if it's table
			freq = freq_tables[(pat_times % #freq_tables) + 1]
		end

		-- pattern selector --
		type_end_delay = math.random(0, 5)
		freq_halts = type_end_delay < 3 and 1 or 0
		pat_num_old = pat_num
		pat_num = rnd_table_select(override_table or {1,2,3,4,5,11,12,13,14,22,31,32,33,41,42,  51,61,  101,102,103,104,105,106,131,  153,154,155,156,157,158,159,160,161,162})
		cons("shapes: " .. tostring(math.floor(l_getSides() / GLOBAL_SIDE_SEGMENT)))
		cons("sides used: " .. tostring(side_pos))

		-- pattern end delay bug preventer --
		--[[
		if type_end_delay >= 3 and pat_num_old == 67 then pat_num = 1 end -- for overriding sides

		]]
		-- for time signature or smth
		if is_time_signature and pat_num == 151 then pat_num = 153 end
		if is_time_signature and pat_num == 152 then pat_num = 153 end

		-- sides
		if all_sides() < 6 and pat_num == 103 then pat_num = 101 end
		if all_sides() < 6 and pat_num == 156 then pat_num = 159 end
		if all_sides() < 6 and pat_num == 160 then pat_num = 159 end
		if all_sides() < 6 and pat_num == 161 then pat_num = 153 end

		if all_sides() < 5 and pat_num == 157 then pat_num = 153 end

		cons("pat_num: " .. pat_num)

		-- preparing utiliies --
		pdir = rng_dir()
		freq_left = (freq or math.random(4, 6)) + (type_end_delay == 5 and 1 or 0)
		freq_targ = freq_left
		cons("pattern direction: " .. tostring(pdir))
		is_prep = true
		is_wall = true
		pat_event_cur = pat_event_cur + 1
		lgc_event_cur = lgc_event_cur + 1
		pat_times = pat_times + 1
	end
end
