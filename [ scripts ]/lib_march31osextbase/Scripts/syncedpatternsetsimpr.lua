u_execDependencyScript("library_march31osbasescripts", "march31os_scr_base", "march31onne", "march31o_patterns_synced_impr.lua")

--[[
    * COMMONS
]]

march31oPat_thickness = 40

function orderSubPat(_iter, _barType)
    _barType = _barType or u_rndTablePick({
        'barspi', 'barrev', 'barlr', 'blr2p', 'barinv',
        '2bspi', '2blr', '2binv',
        'vorspi', 'vorrev', 'vorlr',
        'alt', 'half', '2gspi', 'atrp', 'oalt'
    })

    if _barType == 'barspi' then -- barrage spiral
        _freq = _iter
        _barType = 'bar'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'barspitight' then -- barrage spiral tight
        local div = GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE > 150 * (6 / getProtocolSides()) and 1 or 2
        _freq = _iter * div
        _barType = 'bar'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1 / div
    elseif _barType == 'barrev' then -- barrage spiral reverser
        _freq = _iter
        _barType = 'bar'
        _dirType = 'rev'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'barlr' then -- barrage left right
        _freq = _iter
        _barType = 'bar'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'bspi2p' then -- barrage spiral pos + 2
        local bpmStat = GLOBAL_TEMPO > 90 and 2 or 1
        _freq = _iter / bpmStat
        _barType = 'bar'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = 2
        _beatDistance = bpmStat
    elseif _barType == 'blr2p' then -- barrage left right pos + 2
        local bpmStat = GLOBAL_TEMPO > 90 and 2 or 1
        _freq = _iter / bpmStat
        _barType = 'bar'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 2
        _beatDistance = bpmStat
    elseif _barType == 'barrng' then -- barrage spiral randomizer
        _freq = _iter
        _barType = 'bar'
        _dirType = 'rndsp'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'barinv' then -- barrage reversals
        _freq = _iter / 2
        _barType = 'ibar'
        _dirType = 'inva'
        _dir = getRandomDir()
        _mult = getHalfSides('floor')
        _beatDistance = 2
    elseif _barType == '2gspi' then -- barrage spiral 2 gap connected
        local bpmStat = GLOBAL_TEMPO < 140 and 1 or 2
        _freq = _iter / bpmStat
        _barType = '2gap'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = getProtocolSides() < 5 and 1 or 2
        _beatDistance = bpmStat
    elseif _barType == '2glr' then -- barrage left-rights 2 gap connected
        local bpmStat = GLOBAL_TEMPO < 140 and 1 or 2
        _freq = _iter / bpmStat
        _barType = '2gap'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = getProtocolSides() < 5 and 1 or 2
        _beatDistance = bpmStat
    elseif _barType == '2bspi' then -- barrage holes spiral
        _freq = _iter
        _barType = '2bar'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == '2blr' then -- barrage holes left right
        _freq = _iter
        _barType = '2bar'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == '2binv' then -- barrage holes reversals
        _freq = _iter
        _barType = '2bar'
        _dirType = 'inva'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'vorspi' then -- vorta spiral
        _freq = _iter
        _barType = 'vor'
        _dirType = 'spi'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'vorrev' then -- vorta reversals
        _freq = _iter
        _barType = 'vor'
        _dirType = 'rev'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'vorlr' then -- vorta left right
        _freq = _iter
        _barType = 'vor'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'alt' then -- alternating barrage
        _freq = _iter
        _barType = 'auni'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'half' then -- alternating half
        _freq = _iter
        _barType = 'ahlf'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = getHalfSides('ceil')
        _beatDistance = 1
    elseif _barType == 'atrp' then -- alternating trap
        _freq = _iter
        _barType = 'atrp'
        _dirType = 'lr'
        _dir = -1
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'oalt' then -- odd alternating barrage
        _freq = _iter
        _barType = 'oalt'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    elseif _barType == 'ealt' then -- even alternating barrage
        _freq = _iter
        _barType = 'ealt'
        _dirType = 'lr'
        _dir = getRandomDir()
        _mult = 1
        _beatDistance = 1
    end

    return _freq, _barType, _dirType, _dir, _mult, _beatDistance
end

function scSwapCorridor(mSide, mEnding)
    mEnding = mEnding or false
    cBarrageN(mSide, 1, march31oPat_thickness)
    cWallExM(mSide - 1, 1, 2, customizeTempoPatternThickness(1))
    t_applyPatDel(customizeTempoPatternDelay(1))
    if getBooleanNumber(mEnding) then
        cGrowWall(mSide, 1, march31oPat_thickness)
    end
end


local getBarrageKeys, barpat_index = {}, 1
local getFillerKeys = {}

function whichPattern(mKey)
    -- barrages
        if mKey == 0  then return "barspi"
    elseif mKey == 1  then return "barlr"
    elseif mKey == 2  then return "barinv"
    elseif mKey == 3  then return "bspi2p"
    elseif mKey == 4  then return "blr2p"
    elseif mKey == 5  then return "barrng"
    elseif mKey == 6  then return "2gspi"
    elseif mKey == 7  then return "barspitight"
    elseif mKey == 8  then return "2glr"
    elseif mKey == 9  then return "barrev"

    -- 2-holed barrages
    elseif mKey == 10 then return "2bspi"
    elseif mKey == 11 then return "2blr"
    elseif mKey == 12 then return "2binv"

    -- vorta barrages
    elseif mKey == 20 then return "vorspi"
    elseif mKey == 21 then return "vorrev"
    elseif mKey == 22 then return "vorlr"

    -- alt barrages
    elseif mKey == 30 then return "alt"
    elseif mKey == 31 then return "half"
    elseif mKey == 32 then return "atrp"
    elseif mKey == 33 then return "oalt"
    elseif mKey == 34 then return "ealt"
    end
end

function shuffleBarragePatterns()
    barpat_index = barpat_index + 1

    if barpat_index == #getBarrageKeys then
        barpat_index = 1
        shuffle(getBarrageKeys)
    end
end

function gatherKeys(mTable, mBarrageTable)
    getKeys, getBarrageKeys = mTable, mBarrageTable
    shuffle(getKeys) shuffle(getBarrageKeys)
    pat_index, barpat_index = 1, 1
end

--[[
    * "ALL ORDERED" PATTERN SETS
]]

function spawnSyncedOrderedPattern(mNumbSpawn, mFreq)
    mFreq = mFreq or 6

    local _side, _dir, _chance = getRandomSide(), getRandomDir(), 0.5

    if mNumbSpawn == 10 and getProtocolSides() % 2 == 1 then mNumbSpawn = 3 end
    if mNumbSpawn == 208 and getProtocolSides() >= 9 and mFreq < 4 then mNumbSpawn = 3 end

    if mNumbSpawn == 0 then
        shuffleBarragePatterns()
        barrageFiller(march31oPat_thickness, 2)
        t_applyPatDel(customizeTempoPatternDelay(1))
        BarrageVariant(_side, march31oPat_thickness, orderSubPat(closeValue(mFreq - 4, 0, mFreq - 4), whichPattern(getBarrageKeys[barpat_index])))
        t_applyPatDel(customizeTempoPatternDelay(1))
        barrageFiller(march31oPat_thickness, 1)
    elseif mNumbSpawn == 1 then
        shuffleBarragePatterns()
        BarrageVariant(_side, march31oPat_thickness, orderSubPat(math.floor(mFreq / 2) - 1, whichPattern(getBarrageKeys[barpat_index])))
        t_applyPatDel(customizeTempoPatternDelay(1))
        if mFreq % 2 == 1 then
            barrageFiller(march31oPat_thickness, 1)
            t_applyPatDel(customizeTempoPatternDelay(1))
        end
        shuffleBarragePatterns()
        BarrageVariant(_side, march31oPat_thickness, orderSubPat(math.floor(mFreq / 2) - 1, whichPattern(getBarrageKeys[barpat_index])))
    elseif mNumbSpawn == 2 then
        shuffleBarragePatterns()
        BarrageVariant(_side, march31oPat_thickness, orderSubPat(closeValue(mFreq - 2, 0, mFreq - 2), whichPattern(getBarrageKeys[barpat_index])))
        t_applyPatDel(customizeTempoPatternDelay(1))
        barrageFiller(march31oPat_thickness, u_rndTablePick(getFillerKeys))
    elseif mNumbSpawn == 3 then
        shuffleBarragePatterns()
        BarrageVariant(_side, march31oPat_thickness, orderSubPat(mFreq, whichPattern(getBarrageKeys[barpat_index])))
    elseif mNumbSpawn == 4 then -- barrage spiral zig-zag
        for a = 0, mFreq do
            cBarrage(_side, march31oPat_thickness)
            if a % 2 == 0 then
                _dir = -_dir
            end
            _side = _side + _dir
            t_applyPatDel(customizeTempoPatternDelay(a < mFreq and 0.5 or 0))
        end
    elseif mNumbSpawn == 5 then
        RandomBarrage(_side, march31oPat_thickness * 1.1, mFreq)
    elseif mNumbSpawn == 6 then
        local function typeDirWall(dir)
            if dir > 0 then return 'ceil' end
            return 'floor'
        end

        for a = 0, mFreq do
            if a % 3 == 0 then
                cWallEx(_side + getHalfSides(typeDirWall(_dir)) - 2, getHalfSides(typeDirWall(-_dir)) + 1, march31oPat_thickness)
            else
                if a % 3 == 2 then
                    _dir = -_dir
                    _side = _side + getHalfSides('floor') * _dir
                end
                cWallEx(_side + getHalfSides(typeDirWall(_dir)) - 1, getHalfSides(typeDirWall(-_dir)) - 1, march31oPat_thickness)
                cWallEx(_side,  getHalfSides(typeDirWall(_dir)) - 3, march31oPat_thickness)
            end

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 7 then
        local function jumblePart(times)
            for a = 0, times do
                for c = 1, closeValue(getProtocolSides() - 3, 1, 999) do
                    cWall(getRandomSide(), march31oPat_thickness)
                end
                if a < times then
                    t_applyPatDel(customizeTempoPatternDelay(0.5))
                end
            end
        end

        local _type = u_rndIntUpper(3)
        local _freq = (_type == 2 and closeValue(mFreq - 2, 0, mFreq - 2)) or (_type == 3 and closeValue(mFreq - 4, 0, mFreq - 4)) or mFreq
        if _type == 3 then
            barrageFiller(march31oPat_thickness, 2);
            t_applyPatDel(customizeTempoPatternDelay(1));
        end
        jumblePart(_freq)
        if _type >= 2 then
            t_applyPatDel(customizeTempoPatternDelay(1));
            barrageFiller(march31oPat_thickness, 1);
        end
    elseif mNumbSpawn == 8 then
        for a = 0, math.floor(mFreq / 2) do
            barrageFiller(march31oPat_thickness, u_rndTablePick({ 1, 2, 7, 8, 9, 10 }))
            t_applyPatDel(customizeTempoPatternDelay(1))
        end
    elseif mNumbSpawn == 9 then
        local side = {};
        local difference = false;

        for i = 1, getProtocolSides(), 1 do
            side[i] = u_rndInt(0, 1);
        end

        for order = 1, getProtocolSides(), 1 do
            for index = 1, getProtocolSides(), 1 do
                if side[order] ~= side[index] then
                    difference = true;
                end
            end
        end

        if not difference then
            local s = u_rndIntUpper(getProtocolSides());
            side[s] = (side[s] + 1) % 2;
        end

        for a = 0, mFreq, 1 do
            for i = 1, getProtocolSides(), 1 do
                if side[i] == a % 2 then
                    cWallEx(i, 0);
                end
            end

            if a < mFreq then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 10 then
        BarrageVariant(_side, customizeTempoPatternThickness(.5) - 2.5, mFreq - 1, 'auni', 'lr', _dir, 1, 1)
    elseif mNumbSpawn == 11 then
        local delayAdd = GLOBAL_TEMPO > 170 and 2 or 1
        _dir = u_rndInt(0, 1)

        for a = 0, math.floor(mFreq / delayAdd) do
            local _half = ((math.ceil(a * .5) + _dir) % 2)
            if a % 2 == 0 then
                cBarrageGap(_side + (_half * getHalfSides()), _half * (getProtocolSides() % 2) + 1, march31oPat_thickness)
            else
                cBarrageGap(_side + 1 + (_half * getHalfSides()), _half * (getProtocolSides() % 2) + 3, march31oPat_thickness)
            end

            if a < math.floor(mFreq / delayAdd) then
                t_applyPatDel(customizeTempoPatternDelay(0.5 * delayAdd))
            end
        end
    elseif mNumbSpawn == 12 then
        _dir = u_rndInt(0, 1)

        for a = 0, mFreq do
            if (a + _dir) % 2 == 1 then
                cDrawWall(_side, 0, getHalfSides() - 1, march31oPat_thickness)
            end

            for i = getHalfSides(), getBarrageSide() do
                if (a + i + _dir) % 2 == 1 then
                    cWall(_side + i, march31oPat_thickness)
                end
            end

            if a < mFreq then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 13 or mNumbSpawn == 13.01 then
        _dir = u_rndInt(0, 1)
        local _repetitions, _amount = mNumbSpawn == 13.01 and 2 or 1, 0

        for a = 0, mFreq - 1 do
            for j = 0, _repetitions - 1 do
                for i = 0, getBarrageSide() do
                    if (_amount + i + _dir) % 2 == 1 then
                        cWall(_side + i, march31oPat_thickness)
                    end
                end

                if _repetitions == 2 then
                    t_applyPatDel(customizeTempoPatternDelay(0.25))
                end
            end

            _amount = _amount + 1
            t_applyPatDel(customizeTempoPatternDelay(0.5 - ((_repetitions - 1) * 0.5)))
        end

        for j = 0, _repetitions - 1 do
            if getProtocolSides() % 2 == 1 then
                for i = 0, getBarrageSide() do
                    if (_amount + i + _dir) % 2 == 1 then
                        cWall(_side + i, march31oPat_thickness)
                    end

                    if i >= getBarrageSide(getPolySides(6, 'ceil')) or i < getPolySides(6, 'ceil') then
                        if (_amount + i + _dir) % 2 == 0 then
                            cWall(_side + i, march31oPat_thickness)
                        end
                    end
                end
            else
                cBarrageExHoles(_side + ((_amount + _dir + 1) % 2), getPolySides(6, 'floor'), march31oPat_thickness)
            end

            if _repetitions == 2 then
                t_applyPatDel(customizeTempoPatternDelay(0.25))
            end
        end
    elseif mNumbSpawn == 14 then
        for a = 0, mFreq do
            if a % 2 == 0 then
                cBarrage(_side, march31oPat_thickness)
            else
                cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            end

            if a < mFreq then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end

    -- swap patterns
    elseif mNumbSpawn == 51 then
        for a = 0, math.floor(mFreq / 2) do
            cBarrage(_side, march31oPat_thickness)
            cWallExM(_side - 1, 1, 2, customizeTempoPatternThickness(1))
            t_applyPatDel(customizeTempoPatternDelay(1))
            cWallEx(_side - 1, 2, march31oPat_thickness)
            t_applyPatDel(customizeTempoPatternDelay(1))
            if a == math.floor(mFreq / 2) and mFreq % 2 == 1 then
                barrageFiller(march31oPat_thickness)
            end
        end
    elseif mNumbSpawn == 52 then
        for a = 0, math.floor(mFreq / 2) - 1 do
            scSwapCorridor(_side, a == math.floor(mFreq / 2) - 1)
            _side = math.random(_side + getHalfSides() - 1, _side + getHalfSides() + 1)
        end
    elseif mNumbSpawn == 53 or mNumbSpawn == 53.01 then
        local _div = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 120 and 2 or 1
        local _iter = math.floor(mFreq / _div)
        local _extraTheckWallShit = u_rndInt(0, 1)
        rWallEx(_side, _extraTheckWallShit * (getProtocolSides() > 5 and (getHalfSides('floor') - 2) or 0) or 0, customizeTempoPatternThickness(0.5 * _div * _iter))
        for a = 0, _iter do
            if _dir > 0 then
                cDrawWall(_side, 0, getHalfSides('ceil') + _extraTheckWallShit, march31oPat_thickness)
            else
                cDrawWall(_side, getHalfSides('ceil'), getProtocolSides() + _extraTheckWallShit, march31oPat_thickness)
            end
            if mNumbSpawn == 53.01 then
                if u_rndReal() * _chance > 0.25 then
                    _dir = -_dir
                    _chance = _chance * .5
                else
                    _chance = 1
                end
            else
                _dir = -_dir
            end
            t_applyPatDel(customizeTempoPatternDelay(a < _iter and (0.5 * _div) or 0))
        end
    elseif mNumbSpawn == 54 then
        cBarrage(_side + _dir, march31oPat_thickness)

        for a = 0, math.ceil(mFreq / 2) - 1 do
            rWall(_side, customizeTempoPatternThickness(a == math.floor(mFreq / 2) - 1 and 1 or 0.5))
            t_applyPatDel(customizeTempoPatternDelay(0.5))
            _side = _side + _dir
        end

        rWall(_side, march31oPat_thickness * -.5)
        rWall(_side, march31oPat_thickness * .5)
        _dir = -_dir
        _side = _side + _dir

        for a = 0, math.floor(mFreq / 2) - 1 do
            rWall(_side, customizeTempoPatternThickness(0.5))
            t_applyPatDel(customizeTempoPatternDelay(0.5))
            _side = _side + _dir
        end

        _side = _side + getHalfSides('floor')
        cBarrage(_side - (2 * _dir), march31oPat_thickness)
    elseif mNumbSpawn == 55 then
        cWallEx(_side + 2, getProtocolSides() - 4, customizeTempoPatternThickness(.5 * (math.floor(mFreq / 2) - 1)) + march31oPat_thickness)

        local adj = (math.floor(mFreq / 2) + 1) % 2

        for i = 1, math.floor(mFreq / 2) do
            if (i + adj) % 2 == 1 then
                cWallExM(_side - 1, 1, 2, march31oPat_thickness)
            else
                cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            end

            if i < math.floor(mFreq / 2) then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end

        cWallEx(_side + 1, math.floor(getProtocolSides() / 2) - 2, customizeTempoPatternThickness(1.0) + march31oPat_thickness)
        cWallEx(_side + 1 - math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 2) - 2, customizeTempoPatternThickness(1.0) + march31oPat_thickness)
        t_applyPatDel(customizeTempoPatternDelay(0.5))
        cDrawWall(_side + 2 - math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 2) - 2, math.floor(getProtocolSides() / 2) - 2, -march31oPat_thickness)
        t_applyPatDel(customizeTempoPatternDelay(0.5))
        cWallEx(_side + 2, getProtocolSides() - 4, customizeTempoPatternThickness(.5 * (math.ceil(mFreq / 2) - 1)) + march31oPat_thickness)

        for i = 1, math.ceil(mFreq / 2) do
            if i % 2 == 1 then
                cWallExM(_side - 1, 1, 2, march31oPat_thickness)
            else
                cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            end

            if i < math.ceil(mFreq / 2) then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 56 then
        for a = 0, math.floor(mFreq / 2) do
            if a % 2 == 0 then
                cDrawWall(_side, 2, getProtocolSides(), -march31oPat_thickness)
            else
                cBarrage(_side + (closeValue(_dir, 0, 1) * (getProtocolSides() - 4)) + 3, -march31oPat_thickness)
                _dir = -_dir
            end

            if a < math.floor(mFreq / 2) then
                cWall(_side,     customizeTempoPatternThickness(1))
                cWall(_side + 2, customizeTempoPatternThickness(1))
                t_applyPatDel(customizeTempoPatternDelay(1))
            end
        end
    elseif mNumbSpawn == 57 then
        --_dir = getRandomDir()
        local spiPatFix = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (getProtocolSides() / 6)) and 2 or 1
        for a = 0, math.floor(mFreq / spiPatFix) - 1 do
            cBarrageGap(_side, 2, customizeTempoPatternThickness(0.25 * spiPatFix))
            _side = _side + _dir
            t_applyPatDel(customizeTempoPatternDelay(0.25 * spiPatFix))
        end

        _side = _side + _dir * getHalfSides('floor')
        rWallEx(_side, getHalfSides('floor') - 2, customizeTempoPatternThickness(0.25 * spiPatFix))
        t_applyPatDel(customizeTempoPatternDelay(0.25 * spiPatFix))

        for a = 0, math.floor(mFreq / spiPatFix) - 1 do
            cBarrageGap(_side, 2, customizeTempoPatternThickness(0.25 * spiPatFix))
            _side = _side + _dir
            t_applyPatDel(customizeTempoPatternDelay(0.25 * spiPatFix))
        end
    elseif mNumbSpawn == 58 then
    elseif mNumbSpawn == 59 then

    elseif mNumbSpawn == 100   or mNumbSpawn == 100.01 or
           mNumbSpawn == 100.1 then
        -- single spiral
        local extra = mNumbSpawn == 100.1 and getHalfSides('floor') - 1 or getHalfSides() - 3
        local spiPatFix = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (getProtocolSides() / 6)) and 2 or 1
        local mult = simplifyFloat(mNumbSpawn, 2) == 100.01 and 2 or 1
        for a = 0, math.floor(mFreq * 2 * mult / spiPatFix) - 1, 1 do
            cWallEx(_side + (a * _dir), closeValue(extra, 0, 999, 'min'), customizeTempoPatternThickness(.25 / spiPatFix))
            t_applyPatDel(customizeTempoPatternDelay(.25 / mult / spiPatFix) * (a < math.floor(mFreq * 2 * mult / spiPatFix) - 1 and 1 or 0))
        end
    elseif mNumbSpawn == 101 or mNumbSpawn == 101.01 or
           mNumbSpawn == 101.1 then
        -- mirror spiral
        local spiType = mNumbSpawn == 101.1 and 'rndsp' or 'spi'
        if mNumbSpawn == 101.01 then -- reverser
            local mult = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 150 and 2 or 1
            BarrageVariant(_side, customizeTempoPatternThickness(.25 * mult), math.floor(mFreq / mult) - 1, 'mirw', 'spi', _dir, 1, .5 * mult)
            t_applyPatDel(customizeTempoPatternDelay(0.25 * mult))
            rWall(_side, customizeTempoPatternThickness(.25 * mult))
            t_applyPatDel(customizeTempoPatternDelay(0.25 * mult))
            BarrageVariant(nil, customizeTempoPatternThickness(.25 * mult), math.floor(mFreq / mult) - 1, 'mirw', 'spi', -_dir, 1, .5 * mult)
        else -- original
            if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 150 then
                BarrageVariant(_side, customizeTempoPatternThickness(.5), (mFreq) - 2, 'mirw', spiType, _dir, 1, 1)
                t_applyPatDel(customizeTempoPatternDelay(1))
                barrageFiller(march31oPat_thickness, 2)
            else
                BarrageVariant(_side, customizeTempoPatternThickness(.25), (mFreq * 2) - 4, 'mirw', spiType, _dir, 1, .5)
                t_applyPatDel(customizeTempoPatternDelay(1))
                barrageFiller(march31oPat_thickness, u_rndTablePick(getFillerKeys))
            end
        end
    elseif mNumbSpawn == 102 or mNumbSpawn == 102.01 then
        -- quartz's triangle spiral(?)
        local mult = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 90 and 2 or 1
        for a = 0, mFreq * (2 / mult) do
            cWallEx(_side, 1, customizeTempoPatternThickness(.5 * mult))
            _side = _side + _dir * 2
            if a == math.ceil(mFreq / mult) and mNumbSpawn == 102.01 then
                _dir = -_dir
            end
            t_applyPatDel(customizeTempoPatternDelay(a < mFreq * (2 / mult) and .5 or 0) * mult)
        end
    elseif mNumbSpawn == 103 then
        -- zig-zag spiral
        local mult = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) < 140 and 1 or 2
        for a = 0, math.floor(mFreq / mult) do
            cWall(_side + (_dir), march31oPat_thickness)
            cWall(_side + (_dir * 2), march31oPat_thickness)

            if a < math.floor(mFreq / mult) then
                cWall(_side, customizeTempoPatternThickness(1 / mult))
                _side = _side + (dir * 2)
                t_applyPatDel(customizeTempoPatternDelay(1 / mult))
            else
                cWall(_side, march31oPat_thickness)
            end
        end

    elseif mNumbSpawn == 200    or mNumbSpawn == 200.01 or mNumbSpawn == 200.02 or
           mNumbSpawn == 200.1  or mNumbSpawn == 200.11 or
           mNumbSpawn == 200.2  or mNumbSpawn == 200.21 or
           mNumbSpawn == 200.3  then
        -- tunnel
        if mNumbSpawn == 200.3 then
            cWall(_side, customizeTempoPatternThickness(math.floor(mFreq / 2) * (.5 * 2)))
            for a = 0, math.floor(mFreq / 2) do
                if _dir > 0 then
                    cDrawWall(_side, 0, getBarrageSide(getProtocolSides() > 7 and 2 or 1), march31oPat_thickness * 1.75)
                else
                    cDrawWall(_side, getProtocolSides() >= 7 and 2 or 3, getProtocolSides(), march31oPat_thickness * 1.75)
                    if getProtocolSides() >= 7 then
                        cWall(_side + 1, march31oPat_thickness * 1.75)
                    end
                end
                _dir = -_dir
                t_applyPatDel(customizeTempoPatternDelay(a < math.floor(mFreq / 2) and 1 or 0))
            end
        elseif mNumbSpawn == 200.02 then
            local _tunnelDelay
            if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 120 and (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) < 200 then
                _tunnelDelay = 3
            elseif (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) >= 200 then
                _tunnelDelay = 4
            else
                _tunnelDelay = 2
            end
            cWall(_side, customizeTempoPatternThickness(math.floor(mFreq / _tunnelDelay) * (.5 * _tunnelDelay)))
            for a = 0, math.floor(mFreq / _tunnelDelay) do
                cTknsBarrage(_side + _dir, 1, 1, 1, -_dir, march31oPat_thickness * (6 / getProtocolSides()), march31oPat_thickness)
                _dir = -_dir
                t_applyPatDel(customizeTempoPatternDelay(a < math.floor(mFreq / _tunnelDelay) and 1 or 0))
            end
        else
            local _tunnelDistance = (mNumbSpawn >= 200.1 and mNumbSpawn < 200.2) and u_rndInt(2, getBarrageSide()) or
                                    (mNumbSpawn >= 200.2 and mNumbSpawn < 200.3) and getBarrageSide((getHalfSides() - 3) + 1) or 2
            local _tunnelThick = (mNumbSpawn == 200.01 or mNumbSpawn == 200.11 or mNumbSpawn == 200.21) and 1 or 1.75
            local _tunnelDelay = (mNumbSpawn == 200.21) and 2 or 3
            if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 120 and (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) < 200 then
                cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / _tunnelDelay) * (.5 * _tunnelDelay)))
                BarrageVariant(_side, march31oPat_thickness * _tunnelThick, math.floor(mFreq / _tunnelDelay), 'bar', 'lr', _dir, _tunnelDistance, _tunnelDelay)
            elseif (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) >= 200 then
                cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / 4) * (.5 * 4)))
                BarrageVariant(_side, march31oPat_thickness * _tunnelThick, math.floor(mFreq / 4), 'bar', 'lr', _dir, _tunnelDistance, 4)
            else
                cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / 2) * (.5 * 2)))
                BarrageVariant(_side, march31oPat_thickness * _tunnelThick, math.floor(mFreq / 2), 'bar', 'lr', _dir, _tunnelDistance, 2)
            end
        end
    elseif mNumbSpawn == 201   or mNumbSpawn == 201.01 or
           mNumbSpawn == 201.1 or mNumbSpawn == 201.11 then
        -- tunnel short
        if getProtocolSides() > 5 then
            cWall(_side, customizeTempoPatternThickness(1 * math.floor(mFreq / 2)) + (march31oPat_thickness / 2))
            for a = 0, math.floor(mFreq / 2) do
                if mNumbSpawn == 201.01 then
                    cTknsWall(_side + (closeValue(_dir, 0, 1) * (getHalfSides('floor'))), 1, 1, getHalfSides('ceil') - 1, -_dir, march31oPat_thickness * (6 / getProtocolSides()), march31oPat_thickness)
                else
                    cWallEx(_side + (closeValue(_dir, 0, 1) * (getHalfSides('floor'))), getHalfSides('ceil') - 1, march31oPat_thickness)
                end
                _dir = -_dir
                t_applyPatDel(customizeTempoPatternDelay(a < math.floor(mFreq / 2) and 1 or 0))
            end
        else
            local _dirOff = u_rndIntUpper(getBarrageSide(2))
            cWall(_side, customizeTempoPatternThickness(.5 * mFreq) + (march31oPat_thickness / 2))
            for a = 0, mFreq do
                if mNumbSpawn == 201.01 or mNumbSpawn == 201.11 then
                    cTknsWall(_side + (closeValue(_dir, 0, 1) * (_dirOff + 1)), 1, 1, _dir > 0 and getProtocolSides() - (_dirOff + 2) or _dirOff - 1, -_dir, march31oPat_thickness * (6 / getProtocolSides()), march31oPat_thickness)
                else
                    cWallEx(_side + (closeValue(_dir, 0, 1) * (_dirOff + 1)), _dir > 0 and getProtocolSides() - (_dirOff + 2) or _dirOff - 1, march31oPat_thickness)
                end
                _dir = -_dir
                t_applyPatDel(customizeTempoPatternDelay(a < mFreq and .5 or 0))
            end
        end
    elseif mNumbSpawn == 202 or mNumbSpawn == 202.01 then
        local _tunnelThick = mNumbSpawn == 202.01 and 1 or 2
        cWallExM(_side, math.ceil(getProtocolSides() / 3) - 1, 3, customizeTempoPatternThickness(.5 * mFreq) + (march31oPat_thickness * _tunnelThick))

        for i = 1, mFreq + 2 do
            cWallExM(_side + (_dir * (i < mFreq + 2 and 1 or 0)), math.ceil(getProtocolSides() / 3) - 1, 3, march31oPat_thickness * _tunnelThick)
            _dir = _dir * -1
            t_applyPatDel(customizeTempoPatternDelay(0.5) * (i < mFreq + 1 and 1 or 0))
        end
    elseif mNumbSpawn == 202.1 then
        local _dir = u_rndInt(0, 1)
        local _sideDiv = getProtocolSides() > 6 and 2 or GLOBAL_TEMPO > 150 * (6 / getProtocolSides()) and 2 or 1
        rWall(_side, customizeTempoPatternThickness((.5 * _sideDiv) * math.floor(mFreq / _sideDiv)) + march31oPat_thickness)

        for a = 0, math.floor(mFreq / _sideDiv) do
            cDoubleHoledBarrage(_side + ((_dir % 2) * getHalfSides()), 0, 0, march31oPat_thickness)
            _dir = _dir + 1
            t_applyPatDel(customizeTempoPatternDelay(0.5 * _sideDiv) * (a < math.floor(mFreq / _sideDiv) and 1 or 0))
        end
    elseif mNumbSpawn == 203 then
        local _protect_side = _side
        cWallEx(_protect_side + _dir * .5 - 1.5, getProtocolSides() > 4 and getHalfSides('floor') - 1 or 0, customizeTempoPatternThickness(.5 * mFreq) + march31oPat_thickness)
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'alt', 'lr', _dir, 1, 1)
        cWallEx(_protect_side + _dir * .5 - 1.5, getProtocolSides() > 4 and getHalfSides('floor') - 1 or 0, march31oPat_thickness)
    elseif mNumbSpawn == 204 then
        local _dir_offset = u_rndInt(0, 1)
        cWall(_side, customizeTempoPatternThickness(0.5 * mFreq) + (march31oPat_thickness / 2))

            local _howMany = mFreq
            local _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4), 2, 4));
            local _barrageOldOffset = _barrageOffset
            local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
            for a = 0, mFreq do
            if _howMany > 0 then
                cBarrage(_side + _barrageOffset, march31oPat_thickness)
                _barrageOldOffset = _barrageOffset
                if _howMany > 2 then
                    repeat _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4) - (_howMany - mFreq), 2, 4));
                    until _barrageOffset ~= _barrageOldOffset
                    _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
                else
                    _barrageDistanceDelay = 1
                    if _barrageOffset <= 1 then _barrageOffset = _barrageOffset + 1
                    elseif _barrageOffset >= getBarrageSide() then _barrageOffset = _barrageOffset - 1
                    else _barrageOffset = _barrageOffset + getRandomDir()
                    end
                end
                if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1 end
                if _howMany > 0 then t_applyPatDel(customizeTempoPatternDelay(0.5 * _barrageDistanceDelay)) end
                    _howMany = _howMany - _barrageDistanceDelay
                else cBarrage(_side + _barrageOffset, march31oPat_thickness)
                end
            end
    elseif mNumbSpawn == 205 then
        local _freq_div = (GLOBAL_TEMPO > 100 and 2 or 1);
        local _timas = math.floor(mFreq / _freq_div);
        cWall(_side, customizeTempoPatternThickness((0.5 * _freq_div) * _timas) + (march31oPat_thickness / 2))
        for a = 0, _timas do
            for c = 1, getProtocolSides() - 3 do cWall(getRandomSide(), march31oPat_thickness) end
            if a < _timas then t_applyPatDel(customizeTempoPatternDelay(0.5 * _freq_div)) else cWall(_side, march31oPat_thickness) end
        end
    elseif mNumbSpawn == 206 then
        local _sideDiv = (getProtocolSides() > 6 and 2 or 1)
        cWall(_side, customizeTempoPatternThickness((0.5 * _sideDiv) * math.floor(mFreq / _sideDiv)) + (march31oPat_thickness / 2))
        for a = 0, math.floor(mFreq / _sideDiv) do
            if _dir > 0 then
                cGrowWall(_side, getHalfSides('ceil') - 2, march31oPat_thickness)
            else
                cGrowWallEx(_side + getHalfSides('floor'), getHalfSides('floor') - 2, getProtocolSides() % 2, march31oPat_thickness)
            end
            _dir = -_dir;
            if a < math.floor(mFreq / _sideDiv) then t_applyPatDel(customizeTempoPatternDelay(0.5 * _sideDiv)) else cWall(_side, march31oPat_thickness) end
        end
    elseif mNumbSpawn == 207 then
        local _type = u_rndIntUpper(2)
        local _tunnelDistance = _type == 2 and getHalfSides('floor') - 1 or getBarrageSide()
        local _tunnelDelay = _type == 2 and (getProtocolSides() > 6 and 4 or 2) or 2
        cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / _tunnelDelay) * (.5 * _tunnelDelay)))
        BarrageVariant(_side, march31oPat_thickness, math.floor(mFreq / _tunnelDelay), 'bar', 'lr', _dir, _tunnelDistance, _tunnelDelay)
    elseif mNumbSpawn == 208 then
        local _offset, _del, _freq_fix = 1, getProtocolSides() % 2 == 1 and .75 or 1, math.floor(mFreq / 2) - 3
        cWall(_side, customizeTempoPatternThickness(0.5 * getBarrageSide(2) * _del) + (march31oPat_thickness / 2))
        for a = 0, getBarrageSide(2) do
            for i = 1, getBarrageSide(), 1 do cWall(_side + i + (_offset * (a + 1) * _dir), march31oPat_thickness) end
            if a < getBarrageSide(2) then t_applyPatDel(customizeTempoPatternDelay(0.5 * _del)); end
        end

        if getProtocolSides() < 8 + (_freq_fix * 2) then
            local fillertimesfix = closeValue(1 - math.floor(getProtocolSides() / 6) + _freq_fix, 0, 999, "min")
            for a = 0, fillertimesfix do
                t_applyPatDel(customizeTempoPatternDelay(1));
                barrageFiller(march31oPat_thickness, a == fillertimesfix and u_rndTablePick(getFillerKeys) or 1);
            end
        end

        t_applyPatDel(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 209 or mNumbSpawn == 209.01 then
        local _gearTeeth = mNumbSpawn == 209.01 and 1 or 0
        cWall(_side, customizeTempoPatternThickness(1 * math.floor(mFreq / 2)) + (march31oPat_thickness / 2))
        for a = 0, math.floor(mFreq / 2) do
            cTknsBarrage(_side + (math.floor((a + 1) * (getProtocolSides() / mFreq)) * closeValue(_dir, 0, 1)), 1, 1, 1 + math.floor(a * (getProtocolSides() / mFreq)), _dir, (march31oPat_thickness * (6 / getProtocolSides())) * _gearTeeth, march31oPat_thickness)
            t_applyPatDel(customizeTempoPatternDelay(a < math.floor(mFreq / 2) and .5 or 0));
            if a < math.floor(mFreq / 2) then
                cTknsWall(_side + ((getBrrageSide(2) - math.floor(a * (getProtocolSides() / mFreq))) * closeValue(-_dir, 0, 1)), 1, 1, math.floor(a * (getProtocolSides() / mFreq)) + 2, -_dir, (march31oPat_thickness * (6 / getProtocolSides())) * _gearTeeth, march31oPat_thickness)
                t_applyPatDel(customizeTempoPatternDelay(.5));
            end
        end

    elseif mNumbSpawn == 300 then
        WrapAround(_side, closeValue(math.floor(mFreq / 6), 1, 999), 1)
    elseif mNumbSpawn == 301 then
        TrapAround(_side, closeValue(math.floor(mFreq / 6), 1, 999), 1)
    elseif mNumbSpawn == 302 then
        local _del = (GLOBAL_TEMPO > 90 and 1.75) or 1
        local deskExtend = getProtocolSides() > 5 and 1 or 0
        if getProtocolSides() >= 4 then
            cWall(_side, customizeTempoPatternThickness(1.5 * _del))
        end
        if getProtocolSides() > 5 then
            cGrowWall(_side, getProtocolSides() > 5 and math.floor(getProtocolSides() / 4) or 0, customizeTempoPatternThickness(.5 * _del))
        end
        cGrowWall(_side, math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness(0.25 * _del))
        t_applyPatDel(customizeTempoPatternDelay(.75 * _del));
        if getProtocolSides() >= 6 then
            cWallEx(_side + math.floor(getProtocolSides() / 2), (getProtocolSides() % 2), customizeTempoPatternThickness(.5 * _del))
        end
        for i = -deskExtend, (getProtocolSides() % 2) + deskExtend do
            cGrowWall(_side + i + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness(.25 * _del))
        end
        t_applyPatDel(customizeTempoPatternDelay(.5 * _del));
        if getProtocolSides() > 5 then
            cGrowWall(_side, getProtocolSides() > 5 and math.floor(getProtocolSides() / 4) or 0, customizeTempoPatternThickness(.5 * _del))
        end
        t_applyPatDel(customizeTempoPatternDelay(.25 * _del));
        cGrowWall(_side, math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness(0.25 * _del))
    elseif mNumbSpawn == 303 then
        local delayThingy = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 100 and .75) or .5;
        local deskExtend = getProtocolSides() > 5 and 1 or 0

        cWall(_side, customizeTempoPatternThickness(3.25 * delayThingy))
        cGrowWall(_side, getProtocolSides() > 5 and getPolySides(4, 'floor') or 0, customizeTempoPatternThickness(.5 * delayThingy))
        t_applyPatDel(customizeTempoPatternDelay(.5 * delayThingy))
        cGrowWall(_side, getHalfSides('floor') - 1, customizeTempoPatternThickness(.5 * delayThingy))
        t_applyPatDel(customizeTempoPatternDelay(1 * delayThingy))
        if getProtocolSides() >= 6 then
            cWallEx(_side + getHalfSides('floor'), math_mod(getProtocolSides(), 2), customizeTempoPatternThickness(2 * delayThingy))
        end
        t_applyPatDel(customizeTempoPatternDelay(0.5 * delayThingy))
        for i = -deskExtend, math_mod(getProtocolSides(), 2) + deskExtend do
            cGrowWall(_side + i + getHalfSides('floor'), getPolySides(4, 'floor') - 1, customizeTempoPatternThickness(0.5 * delayThingy))
        end
        t_applyPatDel(customizeTempoPatternDelay(1 * delayThingy))
        cGrowWall(_side, getPolySides(4, 'floor'), customizeTempoPatternThickness(0.5 * delayThingy))

        t_applyPatDel(customizeTempoPatternDelay(1))

        if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) <= 100 then
            for a = 0, closeValue(math.floor(mFreq / 2) - 1, 0, 999, 'min') do
                barrageFiller(march31oPat_thickness)
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 304 then
        local delayThingy = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 100 and 1) or 0.5;
        local deskExtend = getProtocolSides() > 5 and 1 or 0

        cWall(_side, customizeTempoPatternThickness(3 * delayThingy))
        cGrowWall(_side, getProtocolSides() > 5 and getPolySides(4, 'floor') or 0, customizeTempoPatternThickness(1 * delayThingy))
        cGrowWall(_side, getHalfSides('floor') - 1, customizeTempoPatternThickness(0.5 * delayThingy))
        t_applyPatDel(customizeTempoPatternDelay(1 * delayThingy))
        if getProtocolSides() >= 6 then
            cWallEx(_side + getHalfSides('floor'), math_mod(getProtocolSides(), 2), customizeTempoPatternThickness(1.5 * delayThingy))
        end
        t_applyPatDel(customizeTempoPatternDelay(0.5 * delayThingy))
        for i = -deskExtend, math_mod(getProtocolSides(), 2) + deskExtend do
            cGrowWall(_side + i + getHalfSides('floor'), getPolySides(4, 'floor') - 1, customizeTempoPatternThickness(0.5 * delayThingy))
        end
        t_applyPatDel(customizeTempoPatternDelay(1 * delayThingy))
        cGrowWall(_side, getPolySides(4, 'floor'), customizeTempoPatternThickness(0.5 * delayThingy))

        t_applyPatDel(customizeTempoPatternDelay(1))

        if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) <= 100 and mFreq > 4 then
            for a = 0, closeValue(math.floor(mFreq / 2) - 1, 0, 999, 'min') do
                barrageFiller(march31oPat_thickness)
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 350 then
        Bat(_side, mFreq / 6)
    end
end

--[[
    * PATTERN KEY SETS
]]

function getSyncedCommonEzKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 100, 100, 101, 101, 200 },
        { 0, 0, 2, 2, 30, 30 }
    )
end

function getSyncedCommonNmKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 101, 101, 200 },
        { 0, 0, 2, 2, 3, 3, 30, 30 }
    )
end

function getSyncedCommonHrKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 101, 101, 200 },
        { 0, 0, 2, 2, 3, 3, 21, 30, 30 }
    )
end

function getSyncedCommonLtKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 101, 101, 101.01, 200 },
        { 0, 0, 2, 2, 3, 3, 7, 21, 30, 30 }
    )
end

function getSyncedExschKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 101, 101, 200, 201, 202, 300 },
        { 0, 0, 0, 0, 2, 2, 3, 3, 7, 21, 30, 30 }
    )
end

function getSyncedHxdsKey()
    getFillerKeys = { 3, 4 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 101, 101, 200.01, 200.2, 201, 202.01, 300, 350 },
        { 0, 0, 2, 3, 3, 7, 21, 30, 33 }
    )
end

function getSyncedHxdsTknsKey()
    getFillerKeys = { 3, 4 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 101, 101, 200.02, 200.2, 201.01, 202.01, 300, 350 },
        { 0, 0, 2, 3, 3, 7, 21, 30, 33 }
    )
end

function getSyncedYyacKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 11, 11, 101, 101, 200, 201, 206 },
        { 0, 0, 2, 2, 3, 3, 21, 30, 30 }
    )
end

function getSyncedRnbwKey()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 101, 101, 200, 201, 203, 208, 303 },
        { 0, 0, 2, 2, 3, 3, 30, 30 }
    )
end

function getSyncedQuartzKey()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 3, 3, 4, 4, 4, 12, 13.01, 101, 101, 200.3, 201, 206, 302 },
        { 9, 9 }
    )
end

function getSyncedBabaV1Key()
    getFillerKeys = { 3, 14 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 14, 14, 100.1, 101, 101, 101.1, 200, 201 },
        { 0, 0, 2, 2, 3, 3, 10, 11, 12, 20, 20, 21, 30, 30, 31, 31 }
    )
end

function getSyncedBabaV1_5Key()
    getFillerKeys = { 3 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 7, 7, 100, 101, 101, 101.01, 102, 103, 200 },
        { 0, 0, 2, 2, 3, 3, 7, 8, 8, 21, 30, 30 }
    )
end

function getSyncedBabaV2Key()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 7, 7, 7, 8, 8, 8, 8, 101.01, 101.01, 200, 202.1, 203, 204, 205 },
        { 0, 0, 1, 1, 4, 4, 10, 10, 11, 11, 12, 12, 30, 30, 31, 31, 32, 32, 33, 33 }
    )
end

function getSyncedBabaV2RandomlessKey()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 2, 2, 2, 3, 3, 3, 101.01, 101.01, 200, 202.1, 203 },
        { 0, 0, 1, 1, 4, 4, 10, 10, 11, 11, 12, 12, 30, 30, 31, 31, 32, 32, 33, 33 }
    )
end

function getSyncedBabaV2BasicKey()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 5, 5, 5, 100, 100, 200, 203, 204 },
        { 0, 0, 1, 1, 4, 4, 30, 30, 31, 31, 32, 32 }
    )
end

function getSyncedBabaV2BasicRandomlessKey()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 2, 2, 2, 3, 3, 3, 100, 100, 200, 203 },
        { 0, 0, 1, 1, 4, 4, 30, 30, 31, 31, 32, 32 }
    )
end

function getSyncedBabaV2KeyForInterferEyes()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 3, 3, 3, 3, 3, 3, 3, 3, 101.01, 101.01, 200, 202.1, 203 },
        { 0, 0, 1, 1, 4, 4, 10, 10, 11, 11, 12, 12, 30, 30, 31, 31, 32, 32, 33, 33 }
    )
end

function getSyncedBabaV3Key()
    getFillerKeys = { 1, 2, 7 }
    gatherKeys(
        { 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 6, 6, 101, 101, 200.01, 304 },
        { 0, 0, 1, 1, 2, 2, 4, 4, 6, 6, 10, 10, 11, 11, 12, 12, 21, 21, 30, 30, 31, 31 }
    )
end

-- ! Legacy function keys
getSyncedBabaKey = getSyncedBabaV2Key
getSyncedBabaRandomlessKey = getSyncedBabaV2RandomlessKey
getSyncedBabaBasicKey = getSyncedBabaV2BasicKey
getSyncedBabaBasicRandomlessKey = getSyncedBabaV2BasicRandomlessKey

--[[
    * AQUARIUM/LAST STAND PATTERN SETS
]]

function spawnSyncedSwapRndPattern(mNumbSpawn, mFreq, bIsRnd)
mFreq = mFreq or 6

    if mNumbSpawn == 18 and not bIsRnd then mNumbSpawn = 16 end
    if (mNumbSpawn == 15 or
        mNumbSpawn == 100) and not bIsRnd then mNumbSpawn = 0 end

    if mNumbSpawn == 3  and getProtocolSides() < 6 then mNumbSpawn = 0  end
    if mNumbSpawn == 4  and getProtocolSides() < 5 then mNumbSpawn = 1  end
    if mNumbSpawn == 5  and getProtocolSides() < 5 then mNumbSpawn = 7  end
    if mNumbSpawn == 8  and getProtocolSides() < 5 then mNumbSpawn = 2  end
    if mNumbSpawn == 9  and getProtocolSides() < 4 then mNumbSpawn = 0  end
    if mNumbSpawn == 50 and getProtocolSides() < 4 then mNumbSpawn = 0  end
    if mNumbSpawn == 53 and getProtocolSides() < 6 then mNumbSpawn = 2  end
    if mNumbSpawn == 54 and getProtocolSides() < 4 then mNumbSpawn = 2  end
    if mNumbSpawn == 55 and getProtocolSides() < 6 then mNumbSpawn = 51 end
    if mNumbSpawn == 56 and getProtocolSides() < 6 then mNumbSpawn = 0  end
    if mNumbSpawn == 57 and getProtocolSides() < 6 then mNumbSpawn = 52 end

    if mNumbSpawn == 101 and getProtocolSides() < 6 then mNumbSpawn = 0 end

    if mNumbSpawn == 151 and getProtocolSides() < 5 then mNumbSpawn = 0   end
    if mNumbSpawn == 152 and getProtocolSides() < 6 then mNumbSpawn = 150 end

    if mNumbSpawn >= 10 and mNumbSpawn < 15 and getProtocolSides() < 5 then mNumbSpawn = 0 end
    if mNumbSpawn >= 18 and mNumbSpawn < 21 and getProtocolSides() < 4 then mNumbSpawn = 0 end

    if mNumbSpawn == 20 and mFreq < 3 then mNumbSpawn = 0 end

    local _side, _dir, _chance = getRandomSide(), getRandomDir(), .5

    if mNumbSpawn == 0 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'bar', 'rev', _dir, 1, 1)
    elseif mNumbSpawn == 1 then
        local spiPatFix = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (getProtocolSides() / 6)) and 2 or 1
        BarrageVariant(_side, customizeTempoPatternThickness(.25 * spiPatFix), (mFreq * (2 / spiPatFix)) - 1, 'half', 'spi', _dir, 1, .5 * spiPatFix)
    elseif mNumbSpawn == 2 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'bar', 'lr', _dir, 1, 1)
    elseif mNumbSpawn == 3 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'vor', 'spi', _dir, 1, 1)
    elseif mNumbSpawn == 4 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, '2bar', 'spi', _dir, 1, 1)
    elseif mNumbSpawn == 5 then
        if getProtocolSides() % 2 == 0 then
            _dir = getHalfSides()
        else
            _dir = 3 * getRandomDir()
        end

        for a = 0, mFreq do
            if getProtocolSides() > 5 and getProtocolSides() % 2 == 1 then
                if a < mFreq then
                    cWall(_side, customizeTempoPatternThickness(0.5))
                end
                if a > 0 then
                    cWall(_side, customizeTempoPatternThickness(-0.5))
                end
            end

            cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            _side = _side + _dir

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 6 then
        for a = 0, mFreq do
            if a % 2 == 0 then
                barrageFiller(march31oPat_thickness / .66, getProtocolSides() > 3 and u_rndTablePick({ 1, 2, 7 }) or u_rndIntUpper(2))
            else
                cWall(_side, customizeTempoPatternThickness(0.5) + march31oPat_thickness)
                cWall(_side + getHalfSides('floor'), march31oPat_thickness)
            end

            _side = _side + _dir
            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 7 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'auni', bIsRnd and 'rndlr' or 'lr', _dir, 1, 1)
    elseif mNumbSpawn == 8 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, '2bar', bIsRnd and 'rndsp' or 'lr', _dir, 1, 1)
    elseif mNumbSpawn == 9 then
        cWallEx(_side + 2, getProtocolSides() - 4, customizeTempoPatternThickness(.5 * (math.floor(mFreq / 2) - 1)) + march31oPat_thickness)

        local adj = (math.floor(mFreq / 2) + 1) % 2

        for i = 1, math.floor(mFreq / 2) do
            if (i + adj) % 2 == 1 then
                cWallExM(_side - 1, 1, 2, march31oPat_thickness)
            else
                cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            end

            if i < math.floor(mFreq / 2) then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end

        cWallEx(_side + 1, math.floor(getProtocolSides() / 2) - 2, customizeTempoPatternThickness(1.0) + march31oPat_thickness)
        cWallEx(_side + 1 - math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 2) - 2, customizeTempoPatternThickness(1.0) + march31oPat_thickness)
        t_applyPatDel(customizeTempoPatternDelay(0.5))
        cDrawWall(_side + 2 - math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 2) - 2, math.floor(getProtocolSides() / 2) - 2, -march31oPat_thickness)
        t_applyPatDel(customizeTempoPatternDelay(0.5))
        cWallEx(_side + 2, getProtocolSides() - 4, customizeTempoPatternThickness(.5 * (math.ceil(mFreq / 2) - 1)) + march31oPat_thickness)

        for i = 1, math.ceil(mFreq / 2) do
            if i % 2 == 1 then
                cWallExM(_side - 1, 1, 2, march31oPat_thickness)
            else
                cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            end

            if i < math.ceil(mFreq / 2) then
                t_applyPatDel(customizeTempoPatternDelay(0.5))
            end
        end
    elseif mNumbSpawn == 10 then
        for a = 0, math.floor(mFreq / 2) do
            if a % 2 == 0 then
                cDrawWall(_side, 2, getProtocolSides(), -march31oPat_thickness)
            else
                cBarrage(_side + (closeValue(_dir, 0, 1) * (getProtocolSides() - 4)) + 3, -march31oPat_thickness)
                _dir = -_dir
            end

            if a < math.floor(mFreq / 2) then
                cWall(_side,     customizeTempoPatternThickness(1))
                cWall(_side + 2, customizeTempoPatternThickness(1))
                t_applyPatDel(customizeTempoPatternDelay(1))
            end
        end
    elseif mNumbSpawn == 11 then
        if getProtocolSides() < 7 then
            if getProtocolSides() == 6 and mFreq % 3 == 0 then
                cWall(_side + _dir * 2, march31oPat_thickness)
            end
            for i = 1, mFreq + 1 do
                if mFreq % 3 == 0 then
                    if i % 3 == 1 and i < mFreq + 1 then
                        rWall(_side, customizeTempoPatternThickness(1) + 10)
                    else
                        rWall(_side, march31oPat_thickness)
                    end

                    if i % 3 == 0 then
                        rWall(_side + _dir, customizeTempoPatternThickness(0.5) + march31oPat_thickness)
                    else
                        rWall(_side + _dir, march31oPat_thickness)
                    end

                    _dir = _dir * -1
                    if i % 3 == 0 then
                        _side = _side + _dir
                    end

                    if i == mFreq + 1 then
                        if getProtocolSides() == 6 then
                            cWall(_side + _dir, march31oPat_thickness)
                        end
                    end
                else
                    if i == 1 or i == mFreq - 1 then
                        rWall(_side, customizeTempoPatternThickness(1) + 10)
                        if i == 1 then
                            cBarrage(_side - (_dir * 2), march31oPat_thickness)
                        end
                    else
                        if i < mFreq - 1 then
                            rWall(_side - (_dir * 3), customizeTempoPatternThickness(.5))
                            _side = _side - _dir
                        end
                    end

                    if i == 2 then
                        rWall(_side - _dir, march31oPat_thickness)
                    elseif i == mFreq then
                        rWall(_side - _dir, march31oPat_thickness)
                    elseif i == mFreq + 1 then
                        cBarrage(_side + (_dir * 2), march31oPat_thickness)
                    end
                end
                t_applyPatDel(customizeTempoPatternDelay(0.5) * (i < mFreq + 1 and 1 or 0))
            end
        else
            cWallExM(_side, math.ceil(getProtocolSides() / 3) - 1, 3, customizeTempoPatternThickness(.5 * mFreq) + march31oPat_thickness)

            for i = 1, mFreq + 1 do
                cWallExM(_side + _dir, math.ceil(getProtocolSides() / 3) - 1, 3, march31oPat_thickness)
                _dir = _dir * -1
                t_applyPatDel(customizeTempoPatternDelay(0.5) * (i < mFreq + 1 and 1 or 0))
            end
        end
    elseif mNumbSpawn == 12 then
        for i = 0, math.floor(mFreq / 2) do
            if i < math.floor(mFreq / 2) then
                cWallExM(_side + _dir, 1, 2, customizeTempoPatternThickness(1))
            end
            cBarrage(_side + _dir + 1, march31oPat_thickness)
            _dir = _dir * -1
            t_applyPatDel(customizeTempoPatternDelay(1) * (i < math.floor(mFreq / 2) and 1 or 0))
        end
    elseif mNumbSpawn == 13 then
        local _sideDiv = getProtocolSides() > 6 and 2 or GLOBAL_TEMPO > 90 and 2 or 1
        rWall(_side, customizeTempoPatternThickness(math.floor(mFreq / _sideDiv) * (.5 * _sideDiv)))
        for a = 0, math.floor(mFreq / _sideDiv) do
            cBarrage(_side + _dir, -march31oPat_thickness)
            _dir = _dir * -1
            t_applyPatDel(customizeTempoPatternDelay(.5 * _sideDiv) * (a < math.floor(mFreq / _sideDiv) and 1 or 0))
        end
    elseif mNumbSpawn == 14 then
        local _theck = u_rndIntUpper(2) == 2 and getProtocolSides() > 5
        local _sideDiv = getProtocolSides() > 6 and 2 or GLOBAL_TEMPO > 90 and 2 or 1
        for a = 0, math.floor(mFreq / _sideDiv) do
            cBarrage(_side - a * 2 * _dir, -march31oPat_thickness)
            if a < math.floor(mFreq / _sideDiv) then
                cWall(_side - a * 2 * _dir - 1 * _dir, customizeTempoPatternThickness(.5 * _sideDiv))
                cWall(_side - a * 2 * _dir + 2 * _dir, customizeTempoPatternThickness(.5 * _sideDiv))
                if _theck then
                    cWall(_side - a * 2 * _dir + 3 * _dir, customizeTempoPatternThickness(.5 * _sideDiv))
                end
                t_applyPatDel(customizeTempoPatternDelay(.5 * _sideDiv) * (a < math.floor(mFreq / _sideDiv) and 1 or 0))
            end
        end
    elseif mNumbSpawn == 15 then
        RandomBarrage(_side, march31oPat_thickness * 1.1, mFreq)
    elseif mNumbSpawn == 16 then
        local _tunnelDistance = u_rndInt(2, getBarrageSide())
        local _tunnelThick = march31oPat_thickness * 1.75
        local _rndDistance = 2
        if (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 120 and (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) < 200 then
            _rndDistance = u_rndInt(2, 3)
            cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / _rndDistance) * (.5 * _rndDistance)) - _tunnelThick)
            BarrageVariant(_side, -_tunnelThick, math.floor(mFreq / _rndDistance), 'bar', 'lr', _dir, _tunnelDistance, _rndDistance)
        elseif (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) >= 200 then
            _rndDistance = u_rndInt(3, 4)
            cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / _rndDistance) * (.5 * _rndDistance)) - _tunnelThick)
            BarrageVariant(_side, -_tunnelThick, math.floor(mFreq / _rndDistance), 'bar', 'lr', _dir, _tunnelDistance, _rndDistance)
        else
            _rndDistance = u_rndIntUpper(3)
            cWallEx(_side + closeValue(_dir * _tunnelDistance, 1 - _tunnelDistance, 1), _tunnelDistance - 2, customizeTempoPatternThickness(math.floor(mFreq / _rndDistance) * (.5 * _rndDistance)) - _tunnelThick)
            BarrageVariant(_side, -_tunnelThick, math.floor(mFreq / _rndDistance), 'bar', 'lr', _dir, _tunnelDistance, _rndDistance)
        end
    elseif mNumbSpawn == 17 then
        local _dirOff = u_rndIntUpper(getBarrageSide(2))
        cWall(_side, customizeTempoPatternThickness(.5 * mFreq) + (march31oPat_thickness / 2))
        for a = 0, mFreq do
            if _dir < 0 then
                cDrawWall(_side, 0, _dirOff, march31oPat_thickness)
            else
                cDrawWall(_side, _dirOff + 1, getProtocolSides(), march31oPat_thickness)
            end
            _dir = -_dir
            t_applyPatDel(customizeTempoPatternDelay(.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 18 then
        cWall(_side, customizeTempoPatternThickness(0.5 * mFreq) + (march31oPat_thickness / 2))

            local _howMany = mFreq
            local _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4), 2, 4));
            local _barrageOldOffset = _barrageOffset
            local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
            for a = 0, mFreq do
            if _howMany > 0 then
                cBarrage(_side + _barrageOffset, march31oPat_thickness)
                _barrageOldOffset = _barrageOffset
                if _howMany > 2 then
                    repeat _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4) - (_howMany - mFreq), 2, 4));
                    until _barrageOffset ~= _barrageOldOffset
                    _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
                else
                    _barrageDistanceDelay = 1
                    if _barrageOffset <= 1 then _barrageOffset = _barrageOffset + 1
                    elseif _barrageOffset >= getBarrageSide() then _barrageOffset = _barrageOffset - 1
                    else _barrageOffset = _barrageOffset + getRandomDir()
                    end
                end
                if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1 end
                if _howMany > 0 then t_applyPatDel(customizeTempoPatternDelay(0.5 * _barrageDistanceDelay)) end
                    _howMany = _howMany - _barrageDistanceDelay
                else cBarrage(_side + _barrageOffset, march31oPat_thickness)
                end
            end
    elseif mNumbSpawn == 19 then
        local spiPatFix, blockDir = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 150 and 2 or 1, u_rndInt(0, 1)
        for a = 0, mFreq * (2 / spiPatFix) - 1 do
            rWall(_side, customizeTempoPatternThickness(.25 * spiPatFix))
            _side = _side + (a < mFreq * (2 / spiPatFix) - 1 and _dir or 0)
            t_applyPatDel(customizeTempoPatternDelay(.25 * spiPatFix))
        end
        cDrawWall(_side + (blockDir * getHalfSides('ceil')), 0, getHalfSides(blockDir == 0 and 'ceil' or 'floor'), -march31oPat_thickness)
    elseif mNumbSpawn == 20 then
        local _2ndLargeWallOffset, blockDir = u_rndInt(3, getProtocolSides() - 3), u_rndInt(0, 1)
        local _dirOffOne, _dirOffTwo = u_rndIntUpper(_2ndLargeWallOffset - 2), u_rndIntUpper(getBarrageSide(2) - _2ndLargeWallOffset)
        local _dirOne, _dirTwo = getRandomDir(), getRandomDir()
        cWallExM(_side, 1, _2ndLargeWallOffset, customizeTempoPatternThickness((.5 * closeValue(mFreq - 2, 0, mFreq - 2)) + 1))
        for a = 0, closeValue(mFreq - 2, 0, mFreq - 2) do
            if _dirOne > 0 then
                cDrawWall(_side, 0, _dirOffOne, march31oPat_thickness)
            else
                cDrawWall(_side, _dirOffOne + 1, _2ndLargeWallOffset, march31oPat_thickness)
            end
            if _dirTwo > 0 then
                cDrawWall(_side, _2ndLargeWallOffset, _2ndLargeWallOffset + _dirOffTwo, march31oPat_thickness)
            else
                cDrawWall(_side, _2ndLargeWallOffset + _dirOffTwo + 1, getProtocolSides(), march31oPat_thickness)
            end
            _dirOne = -_dirOne
            _dirTwo = -_dirTwo
            t_applyPatDel(customizeTempoPatternDelay(.5))
        end
        t_applyPatDel(customizeTempoPatternDelay(.5))
        cDrawWall(_side + (blockDir * _2ndLargeWallOffset), 0, blockDir == 0 and _2ndLargeWallOffset or getProtocolSides() - _2ndLargeWallOffset, -march31oPat_thickness)
    elseif mNumbSpawn == 21 then
        local _div = (GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 120 and 2 or 1
        local _iter = math.floor(mFreq / _div)
        local _extraTheckWallShit = u_rndInt(0, 1)
        rWallEx(_side, _extraTheckWallShit * (getProtocolSides() > 5 and (getHalfSides('floor') - 2) or 0) or 0, customizeTempoPatternThickness(0.5 * _div * _iter))
        for a = 0, _iter do
            if _dir > 0 then
                cDrawWall(_side, 0, getHalfSides('ceil') + _extraTheckWallShit, march31oPat_thickness)
            else
                cDrawWall(_side, getHalfSides('ceil'), getProtocolSides() + _extraTheckWallShit, march31oPat_thickness)
            end
            if u_rndReal() * _chance > 0.25 then
                _dir = -_dir
                _chance = _chance * .5
            else
                _chance = 1
            end
            t_applyPatDel(customizeTempoPatternDelay(a < _iter and (0.5 * _div) or 0))
        end
    elseif mNumbSpawn == 22 then
        BarrageVariant(_side, customizeTempoPatternThickness(.5) - 2.5, mFreq - 1, 'auni', bIsRnd and 'rndlr' or 'lr', _dir, 1, 1)
    ----------------------------------------------------------------------------------------------------------- END OF 4/4 TIME SIGNATURE PATTERNS

    elseif mNumbSpawn == 50 then
        local _largeWalls = u_rndIntUpper(getHalfSides('floor')) - 1
        cWallEx(_side + _dir * .5 - 1.5, getProtocolSides() > 4 and _largeWalls or 0, customizeTempoPatternThickness(.5 * mFreq) + march31oPat_thickness)
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'auni', 'rndlr', _dir, 1, 1)
    elseif mNumbSpawn == 51 then
        BarrageVariant(_side, march31oPat_thickness, mFreq, 'oalt', 'rndlr', _dir, 0, 1)
    elseif mNumbSpawn == 52 then
        for a = 0, mFreq do
            cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            _side = _side + getRandomDir()

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 53 then
        local _free = getHexaSides() - 1
        cWallExM(_side, 1, getProtocolSides() - (2 + _free), customizeTempoPatternThickness(math.floor(mFreq / 2)) + march31oPat_thickness)

        for a = 0, math.floor(mFreq / 2) do
            if (a + _dir) % 2 == 0 then
                cWallEx(_side, getProtocolSides() - (2 + _free), march31oPat_thickness)
            else
                cWallEx(_side - (1 + _free), _free, march31oPat_thickness)
                cWallEx(_side + 2, getProtocolSides() - (6 + _free), march31oPat_thickness)
            end

            t_applyPatDel(customizeTempoPatternDelay(a < math.floor(mFreq / 2) and 1 or 0))
        end
    elseif mNumbSpawn == 54 then
        for a = 0, mFreq do
            if a % 2 == 0 then
                cBarrage(_side, march31oPat_thickness)
                _side = _side + _dir
            else
                cWallEx(_side + math.floor(_dir * 0.5) + 2, getProtocolSides() - 3, march31oPat_thickness)
                _side = _side + _dir * 2
            end
            
            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 55 then
        cWallExM(_side, math.ceil(getProtocolSides() / 3) - 1, 3, customizeTempoPatternThickness(.5 * mFreq) + march31oPat_thickness)

        for a = 0, mFreq do
            cWallExM(_side + _dir, math.ceil(getProtocolSides() / 3) - 1, 3, march31oPat_thickness)
            _dir = _dir * -1
            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 56 then
        for a = 0, mFreq do
            if a % 2 == 0 then
                if _dir > 0 then
                    cWallEx(_side + 1, getHalfSides('floor') - 2, march31oPat_thickness)
                else
                    cWallEx(_side + getHalfSides('floor') + 1, getHalfSides('ceil') - 2, march31oPat_thickness)
                end
                _dir = -_dir
            else
                cWallExM(_side, 1, getHalfSides('floor'), march31oPat_thickness)
            end

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 57 then
        _dir = 0

        for a = 0, math.floor(mFreq / 2) - ((mFreq + 1) % 2) do
            if a % 2 == 0 then
                _side = _side + u_rndIntUpper(closeValue(getHalfSides('floor') - 1, 1, getProtocolSides()))
            end
            cWallEx(_side + (((a + _dir) % 2)), getProtocolSides() - 2 * (((a + _dir) % 2) + 1), march31oPat_thickness / 2)
            cWall(_side + (((a + _dir) % 2)), customizeTempoPatternThickness(0.5))
            cWall(_side + (((a + _dir) % 2)) - (2 + (((a + _dir) % 2) * 2)), customizeTempoPatternThickness(0.5))
            t_applyPatDel(customizeTempoPatternDelay(0.5))
            cWallEx(_side + ((a + _dir) % 2) - 2 - ((((a + _dir) % 2) * 2)), 2 + ((((a + _dir) % 2) * 2)), march31oPat_thickness)
            t_applyPatDel(customizeTempoPatternDelay(0.5))
        end
        if mFreq % 2 == 0 then
            rWall(getRandomSide(), march31oPat_thickness)
        end
    elseif mNumbSpawn == 58 then
        local spiPatFix = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 132 * (6 / getProtocolSides()) and 2) or 1
        BarrageVariant(_side, customizeTempoPatternThickness(.25 * spiPatFix), (mFreq * (2 / spiPatFix)) - 1, 'mirw', 'spi', _dir, 1, .5 * spiPatFix)
    ----------------------------------------------------------------------------------------------------------- END OF 3/4 TIME SIGNATURE PATTERNS

    elseif mNumbSpawn == 100 then
        for a = 0, mFreq do
            cBarrage(_side, march31oPat_thickness)
            _side = _side + getRandomDir()

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 101 then
        _chance = .75
        cWallExM(_side, math.ceil(getProtocolSides() / 3) - 1, 3, customizeTempoPatternThickness(.5 * mFreq) + march31oPat_thickness)

        for a = 0, mFreq do
            cWallExM(_side + _dir, math.ceil(getProtocolSides() / 3) - 1, 3, march31oPat_thickness)
            if u_rndReal() * _chance > 0.25 then
                _dir = _dir * -1
                _chance = _chance * .5
            else
                _chance = _chance * 2
            end

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 102 then
        for a = 0, mFreq do
            cVortaBarrage(_side, 0, march31oPat_thickness)
            if a % 3 == 0 then
                _dir = -_dir
            end
            _side = _side + _dir

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 103 then
        for a = 0, mFreq do
            cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness)
            _side = _side + (a % 2 == 0 and _dir or getHalfSides('floor'))

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 104 then
        local spiPatFix = ((GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) > 140 * (getProtocolSides() / 6) or 2) or 1

        for a = 0, mFreq * (2 / spiPatFix) - 1 do
            rWall(_side, 0, customizeTempoPatternThickness(0.25 * spiPatFix))
            if a % 4 == 0 then
                _dir = -_dir
            end
            _side = _side + _dir

            t_applyPatDel(customizeTempoPatternDelay(0.25 * spiPatFix) * (a < mFreq and 1 or 0))
        end
    ----------------------------------------------------------------------------------------------------------- END OF 5/4 TIME SIGNATURE PATTERNS

    elseif mNumbSpawn == 150 then
        local r = u_rndIntUpper(4) - 2

        BarrageVariant(_side, march31oPat_thickness, math.floor(math.ceil(mFreq / 2) + r), 'bar', 'spi', _dir, 1, 1)
        _dir = -_dir
        r = -r + 1.0
        t_applyPatDel(customizeTempoPatternDelay(0.5))
        BarrageVariant(_side, march31oPat_thickness, math.floor((mFreq / 2) + r), 'alt', 'spi', _dir, 1, 1)
    elseif mNumbSpawn == 151 then
        _chance = 1

        for a = 0, mFreq do
            if getProtocolSides() % 2 == 0 then
                if u_rndReal() * _chance < 1 then
                    cBarrage(_side, march31oPat_thickness)
                    _side = _side + getRandomDir()
                    _chance = _chance * 2
                else
                    if a < mFreq then
                        cVortaBarrage(_side + 1, 0, customizeTempoPatternThickness(0.5) + march31oPat_thickness)
                    end

                    cBarrage(_side, march31oPat_thickness / (a < mFreq and 2 or 1))
                    _side = _side + getHalfSides('floor')
                    _chance = 0.5
                end
            else
                cBarrage(_side, march31oPat_thickness)
                _side = _side + _dir

                if u_rndReal() * _chance > 0.8 then
                    _side = _side + _dir
                    _dir = -_dir
                    _chance = 0.5
                else
                    _chance = _chance * 2
                end
            end

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 152 then
        local function typeDirWall(dir)
            if dir > 0 then return 'ceil' end
            return 'floor'
        end

        for a = 0, mFreq do
            if a % 3 == 0 then
                cWallEx(_side + getHalfSides(typeDirWall(_dir)) - 2, getHalfSides(typeDirWall(-_dir)) + 1, march31oPat_thickness)
            else
                if a % 3 == 2 then
                    _dir = -_dir
                    _side = _side + getHalfSides('floor') * _dir
                end
                cWallEx(_side + getHalfSides(typeDirWall(_dir)) - 1, getHalfSides(typeDirWall(-_dir)) - 1, march31oPat_thickness)
                cWallEx(_side,  getHalfSides(typeDirWall(_dir)) - 3, march31oPat_thickness)
            end
            
            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    elseif mNumbSpawn == 153 then
        for a = 0, mFreq do
            if a < mFreq then
                cWall(_side, customizeTempoPatternThickness(0.5) + 3)
            end

            cWall(_side + _dir,     march31oPat_thickness)
            cWall(_side + _dir * 2, march31oPat_thickness)

            _side = _side + _dir * 2

            t_applyPatDel(customizeTempoPatternDelay(0.5) * (a < mFreq and 1 or 0))
        end
    end
    ----------------------------------------------------------------------------------------------------------- END OF 5/4 TIME SIGNATURE PATTERNS
end

--[[
    * AQUARIUM/LAST STAND PATTERN KEY SETS
]]

function getSyncedSwapRndKey()
    getKeys = { 0, 0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 10, 11, 12 }
    shuffle(getKeys)
    pat_index = 1
end

function getSyncedSwapRndAddKey()
    getKeys = { 0, 0, 1, 1, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 10, 11, 12, 13, 13, 14, 15, 15, 16, 17, 17, 18, 19, 20, 21, 21, 22, 22 }
    shuffle(getKeys)
    pat_index = 1
end

function getSyncedSwapRndTripletKey()
    getKeys = { 0, 0, 50, 50, 51, 51, 52, 52, 53, 54, 54, 55, 56, 56, 57, 57, 58, 6, 6, 15, 15, 16, 17, 17, 18 }
    shuffle(getKeys)
    pat_index = 1
end

function getSyncedSwapRndQuintKey()
    getKeys = { 100, 100, 101, 1, 102, 102, 10, 11, 103, 103, 104, 56, 56, 6, 6, 7, 7, 15, 15, 16, 17, 17, 18 }
    shuffle(getKeys)
    pat_index = 1
end

function getSyncedSwapRndSeptKey()
    getKeys = { 150, 150, 151, 151, 55, 103, 103, 152, 152, 58, 2, 2, 1, 1, 153, 6, 6, 52, 52, 7, 7, 15, 15, 16, 17, 17, 18 }
    shuffle(getKeys)
    pat_index = 1
end