-- this pattern was referenced from baba's patterns (from since 1.92 release to future ones).

-- utils
GLOBAL_TEMPO = 128
GLOBAL_TIME_SIGNATURE = 4 / 4
GLOBAL_SPAWN_DISTANCE_MULT = 1
GLOBAL_SPAWN_DISTANCE_ADD = -20
GLOBAL_TEMPO_DM_STATE = 1

palletes = {
    ["basic"] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,  51,52,53,54,55},
    ["bar"] = {1,9,10,11},
    ["tun"] = {2,3,4,5,12,13,14,52,53,55},
    ["spi"] = {7,51},
    ["chn"] = {1,2,3,4,5,7,11},
    ["cmb"] = {12,13,14},
    ["swp"] = {4,10,  54,55},
    ["rng"] = {2,6,9,10,11,  54,55},
}

local del_pat, next_spwn, freq_left, freq_targ, is_prep, is_wall = 0, 0, 0, 0, false, false
local pside, pdir = 0, 1
local pat_num, pat_times, pat_selected = 1, 0, palletes["basic"]
local event_cur, event_max = 256, 5
name_pallete = { "barrage", "tunnel", "whirlwind", "chaining", "combo", "swap", "random" }
local incrementTimer, incrementTimesMax = 0, 2

local targetFreqTable, patternChange, chainAlternative
chanceMultiplier = 2.5

shapes, sides, su, sa, st = l_getSides(), 0, {}, {}, {}
t, d, m = 0, 0, 0

function set_sides(v) shapes = type(v) == "number" and v or l_getSides() end

function all_sides()      return shapes                                         end
function bar_side(v)      return all_sides() - (type(v) == "number" and v or 1) end
function odd_side(offset) return (all_sides() + (offset or 0)) % 2              end
function rng_dir()        return (math.random(0, 1) - 0.5) * 2                  end
function poly_side(sides, odd_even)
    sides = sides or 2
    local stat = odd_even % 2 == 1 and math.ceil or math.floor
    return stat(all_sides()/sides)
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

function get_result()
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
function wall_base(s, t)
    t_eval([[l_setWallSpawnDistance(]] .. 100 + 1100 * u_getSpeedMultDM() * 1.0 * get_tempo(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * GLOBAL_SPAWN_DISTANCE_MULT * GLOBAL_TIME_SIGNATURE + GLOBAL_SPAWN_DISTANCE_ADD .. [[)]])
    w_wall(s or 0, t or THICKNESS)
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

local pside, pdir = 0, 1
local bdir = { 1, 1, 1, 1, 1 }
local boff = { 1, 1, 1, 1, 1 }
local options = {}
local rng, chance = 0, 0
local freq_left, freq_targ = 0, 0
local pat_freq_left, pat_freq_targ = 0, 0
local segmentParts = 0;

function getSegmentPart() return segmentParts; end
function setSegmentPart(v)
	targetFreqTable = (v == 1 and { math.floor(freq_targ / 4) - 1, math.floor(freq_targ / 4) * 2 - 1, math.floor(freq_targ / 4) * 3 - 1, freq_targ - 1 }) or
	                  (v == 2 and { 999, math.floor(freq_targ / 2) - 1, 999, freq_targ - 1 }) or
	                  (v == 3 and { 999, math.random(freq_targ - 2) - 1, 999, freq_targ - 1 }) or { 999, 999, 999, freq_targ - 1 }
	segmentParts = v
end

function get_del(mult, is_dcr)
	if getLevelTimeAndSyncToDM() > del_pat then
		if is_dcr then
			freq_left = freq_left - 1
		end
		if freq_left > 0 then
			del_pat = del_pat + get_tempo(GLOBAL_TEMPO) * mult
			pat_freq_left = pat_freq_left - 1
		end
		--u_log(freq_left)
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
	freq_left = 0
	pat_times = 0
	del_pat = getLevelTimeAndSyncToDM()
end

function run_markov(events_enable, freq, override_table)
	local incrementTimerStats = incrementTimer - getLevelTimeAndSyncToDM()
	if incrementTimerStats < 0 and events_enable then
		incrementTimesMax = math.random(2)
		incrementTimer = incrementTimer + (get_tempo(GLOBAL_TEMPO) * 16) * incrementTimesMax

		if pat_times > 1 then 
			local pallete_rnd = math.random(6)
			event_cur = 0
			event_max = math.random(4, 8)
			pat_selected = (pallete_rnd == 1  and palletes["bar"]) or
						   (pallete_rnd == 2  and palletes["tun"]) or
						   (pallete_rnd == 3  and palletes["spi"]) or
						   (pallete_rnd == 4  and palletes["chn"]) or
						   (pallete_rnd == 5  and palletes["cmb"]) or
						   (pallete_rnd == 6  and palletes["swp"]) or
						   (pallete_rnd == 7  and palletes["rng"]) or
							palletes["basic"]
			e_messageAddImportant("event: " .. name_pallete[pallete_rnd], 80)
		end
	end

	-- preparations
	if freq_left <= 0 then
        if event_cur == event_max then
            pat_selected = palletes["basic"]
        end
        if pat_times > 0 and pat_num ~= 51 and pat_num ~= 0 then
            get_result()
        end
        --u_log("event times: " .. event_cur .. "/" .. event_max)
        pat_num = rnd_table_select((type(override_table) == "table" and override_table) or pat_selected)
        --u_log("pattern spawned: " .. pat_num)
        pdir = rng_dir()
        is_prep = true
        is_wall = true
        event_cur = event_cur + 1
        pat_times = pat_times + 1
		if freq ~= 8 then
			if pat_num == 14 then pat_num = 0; end
		end
	end

	if pat_num == 1 then
		if prepare_values() then
			freq_left = freq + 1
			freq_targ = freq_left
			pat_freq_left = 0
			patternChange = math.random(0, 1)
			setSegmentPart(math.random(0, 3))
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			
			if timesFix == targetFreqTable[1] or timesFix == targetFreqTable[2] or timesFix == targetFreqTable[3] or timesFix == targetFreqTable[4] then
				patternChange = patternChange + 1
				pat_freq_left = 0
			end

			if patternChange % 2 == 0 then
				wall_ex(true, sides, all_sides() - 1, 1, 40)
				sides = sides + pdir
			else
				wall_ex_2(true, sides, poly_side(2, 0) - 1, 2, 40)
				sides = sides + pdir
			end
		end
	elseif pat_num == 2 then
		if prepare_values() then
			freq_left = freq + 1
			freq_targ = freq_left
			pat_freq_left = math.random(2, 4)
			patternChange = math.random(0, 1)
			setSegmentPart(1)
			pdir = rng_dir()
            theuniqueandquirkytable = { 1, rng_dir() }
			boff = { 0, 0, 0 }
            boff[1] = 0
            boff[2] = boff[1]
            boff[3] = 0
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			--u_log(timesFix .. "-" .. (freq_targ - 1))
			
			if pat_freq_left < 0 then
				patternChange = patternChange + 1
				pat_freq_left = math.random(2, 4)
				pat_freq_targ = pat_freq_left;
				pdir = rng_dir()
				boff[1] = 0
				boff[2] = boff[1]
				boff[3] = 0
				theuniqueandquirkytable = { 1, rng_dir() }
				get_result();
				if patternChange % 2 == 0 then
					sides = sides + pdir
				end
			end

			if patternChange % 2 == 0 then

				if timesFix < freq_targ - 1 then
					if pat_freq_left > 0 then
						wall_base(sides - pdir, get_thick_sync(.5) + (THICKNESS / 2))
					end
				end
				
				if boff[3] < boff[1] then
					boff[3] = boff[3] + 1
				elseif boff[3] > boff[1] then
					boff[3] = boff[3] - 1
				end

				if boff[3] == boff[1] then
					boff[2] = boff[1]
					wall_ex(true, sides + boff[3], bar_side(), 1)
					repeat boff[1] =  (math.random(bar_side(1)) - 1) * pdir
					until  boff[2] ~= boff[1]
				end
				
				--u_log(boff[3] .. " - " .. boff[1])

				if pat_freq_left == 0 then
					wall_ex(true, sides + boff[3], bar_side(), 1)
				end

				if timesFix == freq_targ - 1 then
					wall_ex(true, sides + boff[3], bar_side(), 1)
				end
			else
				if timesFix > 0 then
					sides = sides + pdir
				end
				if timesFix < freq_targ - 1 then
					if theuniqueandquirkytable[(timesFix % 2) + 1] > 0 then
						pdir = rng_dir()
						wall_ex(true, sides, bar_side(), 1)
					end
				else
					wall_ex(true, sides, bar_side(), 1)
				end
			end
		end
	elseif pat_num == 3 then
		if prepare_values() then
			freq_left = (freq) + 1
			freq_targ = freq_left
			pat_freq_left = 0
			chance = 50
            pdir = poly_side(2, 0)
			patternChange = math.random(0, 1)
			setSegmentPart(math.random(0, 2))
			
			boff, bdir = { sides }, { rng_dir() }
            sides = sides + neg0(bdir[1])
		end
		if get_del(.5, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			
			if timesFix == targetFreqTable[1] or timesFix == targetFreqTable[2] or timesFix == targetFreqTable[3] or timesFix == targetFreqTable[4] then
				patternChange = math.random(0, 1)
				--pat_freq_left = 0
				chance = 50
			end
			
			if math.random(0, 3) == 3 and timesFix > 0 then
				pat_freq_left = 0
				sides = sides + rng_dir()
			end
			
			if freq_left > 0 then
				wall_ex_2(true,  sides,                   0, 1, get_thick_sync(.5) + THICKNESS)
				wall_ex_2(false, sides + poly_side(2, 1), 0, 1, get_thick_sync(.5) + THICKNESS)
			end
			
			if pat_freq_left < 0 then
				if math.random() >= .5 and timesFix > 0 then
					vorta_wall(true, sides + (neg0(bdir[1]) * 2), THICKNESS)
				else
					dual_holed_bar(true, sides + (neg0(bdir[1]) * poly_side(2, 1)), THICKNESS)
				end
			end
			
			bdir[1] = -bdir[1]
		end
	elseif pat_num == 4 then
        if prepare_values() then
            pdir = rng_dir()
            beat_mult = (math.ceil(freq / 2) * 2) / freq
            freq_left = math.floor((freq / 2)) + 1
            freq_targ = freq_left
			patternChange = math.random(0, 2)
			chance = 1
        end
        if get_del(beat_mult, true) then
			if freq_left > 0 then
				if patternChange % 3 == 0 and chance == 1 then
					if odd_side() == 1 then
						chance = 0
					end
					wall_ex(true, sides - ((poly_side(2, 0) - 2) * 1) - 2 + poly_side(2, 0), ((poly_side(2, 0) - 2) * 2 * 1) + 3, 1)
					sides = sides + poly_side(2, 0)
					for i = 0, poly_side(2, 0) - 2 do
						wall_ex(true, sides + (i + 1) - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
						wall_ex(true, sides - (i + 1) - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
					end
				else
					wall_base(sides + pdir, get_thick_sync(beat_mult) + THICKNESS)
					wall_ex(true, sides, all_sides() - 1, 1)
					sides = sides + (2 * pdir)
					pdir = -pdir
				end
			else
				wall_ex(true, sides, all_sides() - 1, 1)
			end
			patternChange = patternChange + 1
        end
	elseif pat_num == 5 then
        if prepare_values() then
            freq_left = all_sides() >= 6 and 12 or 9
            beat_mult = freq / 8
            deco_left = 0
            options = { 3 / poly_side(2, 0) }
        end
        
        if all_sides() < 6 then
            if freq_left == 9 then
                if get_del(.75 * beat_mult, true) then
                    wall_ex(true, sides, all_sides() - 1, 1)
                end
            elseif freq_left == 8 then
                if get_del(.5 * beat_mult, true) then
                    wall_ex(true,  sides + poly_side(2, 1) + 1, 1, 1, get_thick_sync(-.275 / 2) * beat_mult)
                    wall_ex(true,  sides + poly_side(2, 1) + 1, 1, 1, get_thick_sync(1.25)      * beat_mult)
                    wall_ex(false, sides + poly_side(2, 1) + 0, 1, 1, get_thick_sync(.275)      * beat_mult)
                    wall_ex(false, sides + poly_side(2, 1) + 2, 1, 1, get_thick_sync(.275)      * beat_mult)
                end
            elseif freq_left == 7 then
                if get_del(.5 * beat_mult, true) then
                    wall_ex(true, sides + 1, 1 + odd_side(), 1, get_thick_sync(.275) * beat_mult)
                end
            elseif freq_left == 6 then
                if get_del(.25 * beat_mult, true) then
                    wall_grow(true, sides + poly_side(2, 1) + 1, 1, 0, get_thick_sync(.275) * beat_mult)
                end
            elseif freq_left == 5 then
                if get_del(0, true) then
					sides = sides - 1
                end
            elseif freq_left == 4 then
				if get_del(1.25 * beat_mult, true) then
					wall_ex(true, sides, 1, 1, get_thick_sync(1) * beat_mult)
					wall_ex(true, sides - 1, 1, 1, get_thick_sync(.55) * beat_mult)
					wall_ex(true, sides + 1, 1, 1, get_thick_sync(.55) * beat_mult)
				end
			elseif freq_left == 3 then
				if get_del(.25 * beat_mult, true) then
					wall_ex(true, sides + 2, 1 + odd_side(), 1, get_thick_sync(.55) * beat_mult)
				end
			elseif freq_left == 2 then
				if get_del(.5 * beat_mult, true) then
					wall_ex(false, sides + 1, 1, 1, get_thick_sync(.55) * beat_mult)
					wall_ex(false, sides + 3 + odd_side(), 1, 1, get_thick_sync(.55) * beat_mult)
				end
			elseif freq_left == 1 then
				if get_del(0, true) then
				end
			end
        else
            if freq_left == 12 then
                if get_del(.75 * beat_mult, true) then
                    wall_ex(true, sides, all_sides() - 1, 1)
                end
            elseif freq_left == 11 then
                if get_del(.5 * beat_mult, true) then
                    wall_grow(true, sides + poly_side(2, 1) + (poly_side(2, 0) - 1), poly_side(4, 0), 0, get_thick_sync(-.25 / 2) * beat_mult)
                    if odd_side() % 2 == 1 then
                        wall_grow(true, sides - 1, poly_side(4, 1), 0, get_thick_sync(.25) * beat_mult)
                    else
                        wall_ex(true, sides + poly_side(2, 1), all_sides() - 1, 1, get_thick_sync(.25) * beat_mult)
                    end
                    wall_ex(true, sides - 1, 1, 1, get_thick_sync(1.25) * beat_mult)
                end
            elseif freq_left == 10 then
                if get_del((.25 / 2) * beat_mult, true) then
                    wall_ex(true, sides - 1 - odd_side() + poly_side(2, 1), odd_side() + 1, 1, get_thick_sync((.25 / 2) + .5) * beat_mult)
                end
            elseif freq_left == 9 then
                if get_del(.5 * beat_mult, true) then
                    wall_grow(true, sides - 1 - odd_side() + poly_side(2, 1), 1, odd_side(), get_thick_sync(.25) * beat_mult)
                end
            elseif freq_left == 8 then
                if get_del(.25 * beat_mult, true) then
                    wall_grow(true, sides + poly_side(2, 1) + (poly_side(2, 0) - 1), poly_side(4, 0), 0, get_thick_sync(.275) * beat_mult)
                end
            elseif freq_left == 7 then
                if get_del(0, true) then
					sides = sides - 1
                end
            elseif freq_left == 6 then
                if get_del((.25 / 2) * (poly_side(2, 0) + 2) * beat_mult * options[1], true) then
                    wall_grow(true, sides, poly_side(2, 0) - 1, 0, get_thick_sync(.25 / 2) * beat_mult * options[1]);
                    for amount001 = 0, poly_side(2, 0) - 2, 1 do
                        wall_grow(true, sides, poly_side(2, 0) - (amount001 + 2), 0, get_thick_sync((.25 / 2) * (4 + (amount001 * 3))) * beat_mult * options[1]);
                    end
                end
            elseif freq_left == 5 then
                if get_del(.25 * beat_mult * options[1], true) then
                    wall_ex(true, sides + poly_side(2, 0), odd_side() + 1, 1, get_thick_sync((.25 / 2) * ((poly_side(2, 0) + poly_side(2, 0) + 1 + poly_side(10, 0) + poly_side(4, 0)))) * beat_mult * options[1]);
                end
            elseif freq_left == 4 then
                if get_del(.5 * beat_mult * options[1], false) then
                    wall_ex(false, sides + poly_side(2, 0) + (odd_side()) + 1 + deco_left, 1, 1, get_thick_sync((.25 / 2) * ( (poly_side(2, 0) + (poly_side(2, 0) + 1) + (poly_side(2, 0) - 3) - (deco_left * 3)))) * beat_mult * options[1]);
                    wall_ex(false, sides + poly_side(2, 0)                - 1 - deco_left, 1, 1, get_thick_sync((.25 / 2) * ( (poly_side(2, 0) + (poly_side(2, 0) + 1) + (poly_side(2, 0) - 3) - (deco_left * 3)))) * beat_mult * options[1]);
                    if deco_left >= poly_side(2, 0) - 3 then
                        freq_left = freq_left - 1
                    else
                        deco_left = deco_left + 1
                    end
                end
            elseif freq_left == 3 then
                if get_del(.5 * beat_mult * options[1], true) then
                    wall_ex(true, sides + 1, all_sides() - 1, 1, get_thick_sync(.55) * beat_mult * options[1])
                end
            elseif freq_left == 2 then
                if get_del(0, true) then
                    for i = 0, poly_side(2, 0) - 3 do
                        wall_grow(false, sides + poly_side(2, 0) - 1, (poly_side(2, 0) - 3) - i, 0, get_thick_sync(.275 / 2) * (i + 1) * beat_mult * options[1])
                        wall_grow(false, sides + poly_side(2, 1) + 1, (poly_side(2, 0) - 3) - i, 0, get_thick_sync(.275 / 2) * (i + 1) * beat_mult * options[1])
                    end
                end
            elseif freq_left == 1 then
                if get_del(0, true) then
                end
            end
        end
	elseif pat_num == 6 then
        if prepare_values() then
            pdir = rng_dir()
            beat_mult = (math.ceil(freq / 2) * 2) / freq
            freq_left = math.floor(freq / 2) * 2 + 1
            freq_targ = freq_left
			options = {
				0, -- current offset
				bar_side(2), -- distance
				0, -- offset
				pdir * .5 + .5, -- QUOS
			}
        end
        if get_del(.5 * beat_mult, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			
			if timesFix % 2 == 0 then
				local min, max = pdir > 0 and 0 or 1, pdir < 0 and 1 or 2
				for i = min, all_sides() - max do
					wall_ex(i == min, i + sides + options[1] + options[4] - 1, 1, 1)
				end

				if math.random(0, 1) then
					pdir = -pdir
				end
				options[2] = math.random(bar_side(2))
				options[4] = pdir * .5 + .5

				for i = 1, bar_side() - options[2] do
					wall_ex(false, i * -pdir + sides + options[1] - 1, 1, 1, get_thick_sync(.5 * beat_mult) * clamp(freq_left, 0, 1) + THICKNESS)
				end
			else
				local dirr = rng_dir()
				if options[3] > 0 then
					for off = 0, options[3] - 1 do
						for i = 1, bar_side() - options[2] do
							wall_ex(i == 1, i * -pdir + sides + options[1] - 1, 1, 1, THICKNESS)
						end
						sides = sides + dirr
					end
				end

				for i = 1, bar_side() - options[2] do
					wall_ex(false, i * -pdir + sides + options[1] - 1, 1, 1, get_thick_sync(.5 * beat_mult) * clamp(freq_left, 0, 1) + THICKNESS)
				end
				options[1] = options[1] + pdir * options[2]
			end
        end
	elseif pat_num == 7 then
		if prepare_values() then
			pdir = rng_dir()
			freq_left = (freq + 1) * 2
			freq_targ = freq_left
			if pdir < 0 then
				sides = sides + 1
			end
			options = { math.random(0, 1) }
			pat_freq_left = math.random(4, 6)
		end
		if freq_left > 2 then
			if get_del(.25, true) then
				if pat_freq_left < 0 and freq_left >= 2 then
					pat_freq_left = math.random(4, 6)
					pat_freq_targ = pat_freq_left
					options[1] = options[1] + 1
					pdir = -pdir
				end
				wall_ex_2(true, sides, options[1] % 2, poly_side(2, 0), get_thick_sync(.275))
				if freq_left == freq_targ - 1 then
					wall_ex_2(false, sides + pdir, options[1] % 2, poly_side(2, 0), get_thick_sync(.275))
				elseif freq_left == 2 then
					wall_ex_2(false, sides - pdir, options[1] % 2, poly_side(2, 0), get_thick_sync(.275))
				end
				if freq_left >= 2 then
					if pat_freq_left ~= 0 then
						sides = sides + pdir
					end
				else
					sides = sides + pdir
				end
				u_log(sides)
			end
		else
			if get_del(0, true) then
				sides = sides - (pdir * 2)
			end
		end
	
	elseif pat_num == 8 then
		if prepare_values() then
			pdir = rng_dir()
			beat_mult = (math.ceil(freq / 2) * 2) / freq
			freq_left = math.floor(freq / 2) + 1
			freq_targ = freq_left
		end
		if get_del(beat_mult, true) then
			patternChange = math.random(0, 1)
			if patternChange == 1 then
				wall_ex(true, sides, all_sides() - 1, 1)
				if freq_left > 0 then
					wall_ex(false, sides + 1 - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
					wall_ex(false, sides - 1 - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
				end
				sides = sides + (2 * rng_dir())
			else
				wall_ex(true, sides - ((poly_side(2, 0) - 2) * 1) - 2 + poly_side(2, 0), ((poly_side(2, 0) - 2) * 2 * 1) + 3, 1)
				sides = sides + poly_side(2, 0)
				if freq_left > 0 then
					for i = 0, poly_side(2, 0) - 2 do
						wall_ex(false, sides + (i + 1) - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
						wall_ex(false, sides - (i + 1) - 1, 1, 1, get_thick_sync(beat_mult) + THICKNESS)
					end
				end
			end
		end
	elseif pat_num == 9 then
		if prepare_values() then
			pdir = rng_dir()
			freq_left = freq + 1
			freq_targ = freq_left
			bdir[1] = 0
			patternChange = math.random(0, 1)
			pat_freq_left = math.random(2, 4)
		end
		if get_del(.5, true) then
			if bdir[1] % 2 == 0 then
				vorta_wall(true, sides)
			else
				wall_ex_2(true, sides - 1, 1, poly_side(2, 1))
			end
			
			if bdir[1] % 2 == 0 and pat_freq_left < 0 then
				patternChange = patternChange + 1
				pat_freq_left = math.random(2, 4)
			end
			
			if patternChange % 2 == 0 then
				sides = sides + rng_dir()
			else
				bdir[1] = bdir[1] + 1
			end
		end
	elseif pat_num == 10 then
		if prepare_values() then
			pdir = rng_dir()
			freq_left = freq + 1
			freq_targ = freq_left
			patternChange = math.random(0, 1)
			pat_freq_left = math.random(3, 4)
		end
		if get_del(.5, true) then
			if pat_freq_left < 0 then
				pat_freq_left = math.random(3, 4)
			end
			wall_ex(true, sides, all_sides() - 1, 1, THICKNESS)
			if pat_freq_left == 0 and freq_left > 0 then
				wall_ex(true, sides, all_sides() - 1, 1, -THICKNESS)
			end
			sides = sides + ((pat_freq_left == 1 and freq_left > 1) and poly_side(2, 1) or rng_dir())
		end
	elseif pat_num == 11 then
		if prepare_values() then
			pdir = rng_dir()
			freq_left = freq + 1
			freq_targ = freq_left
			patternChange = math.random(0, 2)
			pat_freq_left = math.random(3, 4)
			boff = { 0 }
			sides = sides - math.random(0, 1) * 2
		end
		if get_del(.5, true) then
			if pat_freq_left < 0 then
				pat_freq_left = math.random(3, 4)
				patternChange = math.random(0, 2)
			end

			wall_ex_2(true,  sides - boff[1],                   boff[1] * 2,     1, THICKNESS)
			wall_ex_2(false, sides + boff[1] + 2, all_sides() - boff[1] * 2 - 4, 1, THICKNESS)

			if patternChange == 0 then
				sides = sides + pdir
			elseif patternChange == 1 then
				sides = sides + pdir
				pdir = -pdir
			else
				boff[1] = boff[1] * -1 + 1
			end
		end
	elseif pat_num == 12 then
        if prepare_values() then
            pdir = rng_dir()
            beat_div = GLOBAL_TEMPO < 90 and 2 or 1
            beat_mult = ((math.ceil(freq / (2 / beat_div)) * (2 / beat_div)) / freq)
            freq_left = math.floor(freq / 2) + 1
            freq_targ = freq_left
			patternChange = math.random(0, 2)
			chance = 1
        end
        if get_del((1 / beat_div) * beat_mult, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)

			wall_base(sides + pdir, get_thick_sync((1 / beat_div) * beat_mult) * clamp(freq_left, 0, 1) + THICKNESS)
			if timesFix % 2 == 0 then
				wall_ex(true, sides, all_sides() - 1, 1)
			else
				if math.random(0, 1) == 1 and freq_left > 0 then
					sides = sides + (2 * pdir)
					pdir = -pdir
				else
					for i = 0, 2 do
						wall_ex(i == 0, sides + pdir + (i * -pdir) - 1, 1, 1)
					end
				end
			end
        end
	elseif pat_num == 13 then
		if prepare_values() then
			pdir = rng_dir()
			beat_div = GLOBAL_TEMPO < 90 and 4 or 2
            beat_mult = GLOBAL_TEMPO < 90 and ((math.ceil(freq / 2) * 2) / freq) or 1
			freq_left = math.floor((freq / beat_div) * beat_div) + 1
			freq_targ = freq_left
			pat_end_fix, sides5_arm_fix, sides4_arm_fix = 0, all_sides() > 5 and 1 or 0, all_sides() > 4 and 0 or 1

			if pdir > 0 then sides = sides + poly_side(2, sides5_arm_fix) else sides = sides + clamp(poly_side(2, (1 - sides5_arm_fix)) - 2, 0, all_sides()) + sides4_arm_fix end -- fuck - tunnel arm direction 1 bug m(_ _)m
		end

		if get_del((1 / beat_div) * beat_mult, true) then
			local timesFix = math.abs((freq_targ - 1) - freq_left)
			if is_wall_avail() then
				wall_base(sides + 1, get_thick_sync((1 / beat_div) * (freq_targ - 1)) * beat_mult)
			end
			local function generateArm()
				if pdir > 0 then
					wall_ex(true, sides + poly_side(2, (1 - sides5_arm_fix)), poly_side(2, 1) + sides5_arm_fix, 1)
					wall_ex(true, sides + poly_side(2, (1 - sides5_arm_fix)), all_sides() - 1, 1, 0)
				else
					wall_ex(true, sides, poly_side(2, 1) + sides5_arm_fix, 1)
					wall_ex(true, sides - 1, all_sides() - 1, 1, 0)
				end
			end

			if timesFix % 2 == 0 then
				generateArm()
			else
				if math.random(0, 1) == 1 then
					generateArm()
				else
					pdir = -pdir
				end
			end
		end
	elseif pat_num == 14 then
		if prepare_values() then
			pdir = rng_dir()
			freq_left = 8
            beat_mult = freq / 8
			freq_targ = freq_left
			sides = sides + poly_side(2, math.random(0, 1))
		end

		if get_del(.5 * beat_mult, true) then
			if freq_left == 7 then
                wall_grow(true, sides - 1, poly_side(4, 0), 0, get_thick_sync(.7 * beat_mult))
                wall_grow(true, sides - 1, poly_side(4, 1), 0, get_thick_sync(.3 * beat_mult))
			elseif freq_left == 6 then
                wall_ex(true, sides - 1, 1, 1, get_thick_sync(1.5 * beat_mult))
			elseif freq_left == 5 then
                wall_grow(true, sides + poly_side(2, 0) - 1, poly_side(4, 0), odd_side(), get_thick_sync(.3 * beat_mult))
                wall_ex(true, sides + poly_side(2, 0) - 1, 1 + odd_side(), 1, get_thick_sync(2 * beat_mult))
			elseif freq_left == 4 then
			elseif freq_left == 3 then
                wall_grow(true, sides - 1, poly_side(4, 0), 0, get_thick_sync(.3 * beat_mult))
			elseif freq_left == 2 then
			elseif freq_left == 1 then
			elseif freq_left == 0 then
                wall_grow(true, sides + poly_side(2, 0) - 1, poly_side(4, 0), odd_side(), get_thick_sync(-.7 * beat_mult))
                wall_grow(true, sides + poly_side(2, 0) - 1, poly_side(4, 1), odd_side(), get_thick_sync(-.3 * beat_mult))
                wall_grow(true, sides + poly_side(2, 0) - 1, poly_side(4, 1), odd_side(), THICKNESS)
			end
		end

    elseif pat_num == 51 then
        if prepare_values() then
            pdir = rng_dir()
            beat_div = GLOBAL_TEMPO > 150 and 1 or 2
            freq_left = freq * (beat_div * 2) + 1
            freq_targ = freq_left
            sides = sides + 1
        end

        if get_del((.25 / beat_div), true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if (timesFix + neg0(pdir)) % 2 == 1 then
                if freq_left > 0 then
                    wall_ex(true, sides, poly_side(3, 0) * 2, 1, get_thick_sync(.25 / beat_div) + THICKNESS)
                end
                if pdir > 0 and freq_left > 1 then
                    sides = sides + 1
                end
            else
                if freq_left > 0 then
                    wall_ex(true, sides, poly_side(3, 0) * 2 - 1, 1, get_thick_sync(.25 / beat_div) + THICKNESS)
                end
                if pdir < 0 and freq_left > 1 then
                    sides = sides - 1
                end
            end
            
            if pdir > 0 and freq_left == 0 then
                sides = sides - 1
            end
        end
	elseif pat_num == 52 then
		if prepare_values() then
			pdir = rng_dir()
			beat_div = GLOBAL_TEMPO > 90 and 1 or 2
            beat_mult = (math.ceil(freq / (2 / beat_div)) * (2 / beat_div)) / freq
			freq_left = math.floor(freq / (2 / beat_div)) + 1
			freq_targ = freq_left
			if pdir > 0 then
				sides = sides + poly_side(2, 1)
			end
		end
		if get_del((1 / beat_div) * beat_mult, true) then
			if is_wall_avail() then
				wall_ex(true, sides, poly_side(2, 0) - 1, 1, get_thick_sync((1 / beat_div) * beat_mult * freq_left) + THICKNESS)
			end
			for i = 0, all_sides() - 2 do
				local tete = freq_left > 0 and freq_left < freq_targ - 1 and clamp(i, 0, all_sides() - poly_side(2, 0) - 1) or 0
				wall_ex(i == 0, sides + (i * pdir) + 3 + (neg0(-pdir) * (poly_side(2, 1) - 2)) + (poly_side(2, 0) - 3), 1, 1, THICKNESS * (tete + 1))
			end

			pdir = -pdir
        end
	elseif pat_num == 53 then
		if prepare_values() then
			pdir = rng_dir()
			options = {
				math.random(bar_side(2)), -- offsets
			}
			freq_left = math.floor(freq) + 1
			freq_targ = freq_left

			if pdir < 0 then
				sides = sides - 1
			end
		end

		if get_del(.5, true) then
			if is_wall_avail() then
				wall_base(sides - options[1], get_thick_sync(.5 * (freq_targ - 1)) + THICKNESS)
			end

			if pdir > 0 then
				wall_draw(true, sides, 0, bar_side(2) - options[1])
				wall_ex(true, sides, all_sides() - 1, 1, 0)
			else
				wall_draw(true, sides - 1, options[1] * -1, 0)
				wall_ex(true, sides + 1, all_sides() - 1, 1, 0)
			end

			pdir = -pdir
		end
    elseif pat_num == 54 then
        if prepare_values() then
            freq_left = (freq * 2) + 1 --math.random(5, 8)
            deco_left = 0
            chance = 50
            boff = { 0 }
            r_wall_ex = function(s, ex, thick, odd_even, ...)
                for i = 0, ex do
                    wall_base(s + i, thick)
                    wall_base(s + i + poly_side(2, odd_even), thick)
                end
            end
        end

        if get_del(.25, true) then
            if deco_left % 2 == 0 then
                wall_ex(true, sides, all_sides() - 1 - (odd_side() * (boff[1] % 2)), 1)
                chance = chance * (math.random() * 1.5 + 1)
            elseif deco_left % 2 == 1 then
                if freq_left > 0 then
                    if chance > 75 then
                        if all_sides() > 5 then
                            r_wall_ex(sides + ((boff[1] + 1) % 2) + poly_side(2, 0) + odd_side(), clamp(poly_side(2, 0) - 2, 0, all_sides()), THICKNESS, boff[1])
                        else
                            r_wall_ex(sides + ((boff[1] + 1) % 2) + poly_side(2, 0) + odd_side(), 0, THICKNESS, boff[1])
                        end
                        if all_sides() % 2 == 1 then
                            sides = sides + poly_side(2, boff[1] + 1)
                            boff[1] = boff[1] + 1
                        else
                            sides = sides + poly_side(2, 1)
                        end
                        chance = chance / 3
                    else
                        boff[1] = 0
                        sides = sides + rng_dir()
                    end
                end
            end
            deco_left = deco_left + 1
        end
    elseif pat_num == 55 then
        if prepare_values() then
            freq_left = freq + 1
            freq_targ = freq_left
            pdir = poly_side(2, 0)
            chance = 50
            sides = sides + (poly_side(2, 0) + 1) * math.random(0, 1)
            boff = { sides }
        end

        if get_del(.5, true) then
            local timesFix = math.abs((freq_targ - 1) - freq_left)

            if is_wall_avail() then
                wall_ex(true, sides,                   poly_side(4, 0), 1, get_thick_sync(.5 * freq_left) + THICKNESS)
                wall_ex(true, sides + poly_side(2, 0), poly_side(4, 0), 1, get_thick_sync(.5 * freq_left) + THICKNESS)
            end

            wall_ex(true, sides - poly_side(8, 1) + pdir, poly_side(2, 1), 1)

            if odd_side() == 0 and timesFix > 0 then
                chance = chance * (math.random() * 1.5 + 1)

                if chance > 100 then
                    wall_ex(false, sides + math.random(0, 1) * poly_side(2, 0), poly_side(2, 1), 1)

                    chance = chance / 3
                end
            end

            if freq_left == 0 then
                wall_ex(false, boff[1],                   poly_side(4, 0), 1, get_thick_sync(.5 * freq_left) + THICKNESS)
                wall_ex(false, boff[1] + poly_side(2, 0), poly_side(4, 0), 1, get_thick_sync(.5 * freq_left) + THICKNESS)
            end

            pdir = pdir * -1 + poly_side(2, 0)
        end

	elseif pat_num == 666 then
	elseif pat_num == 666 then
	elseif pat_num == 666 then
	end
end