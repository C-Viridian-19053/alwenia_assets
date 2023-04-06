u_execDependencyScript("library_march31osbasescripts", "march31os_scr_base", "march31onne", "march31o_patterns_synced.lua")

function spawnTempoBasicPattern(mNumbSpawn)
    local _side = getRandomSide();

    if mNumbSpawn == 0 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 2, false, 0, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 1 then spMarch31osBarrageSpiralRev(_side, march31oPat_thickness, 1, 1, 1, 2, 1, 1, getRandomDir()) t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 2 and getProtocolSides() == 6 then
        cBarrage(_side, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side + getHalfSides(), 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cBarrage(_side + getHalfSides(), march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side + getHalfSides(), 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cBarrage(_side, march31oPat_thickness); t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 3 then
        if getProtocolSides() == 3 then spMarch31osWhirlwind(_side, (GLOBAL_TEMPO > 150 and 3) or 5, 0, 1, 1, 1, getRandomDir(), 1, nil, true);
        elseif getProtocolSides() == 4 then spMarch31osWhirlwind(_side, 0, 0, 1, 1, 0.5, getRandomDir(), 1, nil, true);
        else spMarch31osWhirlwind(_side, (GLOBAL_TEMPO > 150 and 1) or 3, 0, math.floor(getProtocolSides() / 3), 1, (GLOBAL_TEMPO > 150 and 2) or 1, getRandomDir(), 1, nil, false);
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, GLOBAL_TEMPO > 90 and u_rndIntUpper(8) or u_rndIntUpper(10)); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 4 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 1, 1, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, u_rndIntUpper(8)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 5 and getProtocolSides() > 5 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, (GLOBAL_TEMPO > 90 and 3) or 6, 1, 1, 1, 2, false, (GLOBAL_TEMPO > 90 and 2) or 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 6 then
        spMarch31osTunnel(_side, march31oPat_thickness * 1.75, (GLOBAL_TEMPO > 120 and 2) or 3, 0, 0, u_rndInt(1, getProtocolSides() - 2), true, 0, 0, 1, 1, false, false, false, 0, 1, 1, 0, 0, (GLOBAL_TEMPO > 120 and 3) or 2, u_rndInt(0, 1), true);
        t_wait(customizeTempoPatternDelay(1));
 elseif mNumbSpawn == 7 then
        local _offset, _dir = 0, getRandomDir()
        for a = 0, 4 do
            for i = 0, getBarrageSide(), 2 do wallSCurve(_side + i + _offset, _dir, 2, march31oPat_thickness) end
            _offset = math_add(_offset, _dir);
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)); end
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, u_rndIntUpper(9)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 8 then
        local _offset, _dir = 0, getRandomDir()
        for a = 0, 4 do
            for i = 1, getBarrageSide(), 1 do wallSCurve(_side + i + _offset, _dir, 2, march31oPat_thickness) end
            _offset = math_add(_offset, _dir);
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)); end
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, u_rndIntUpper(9)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 9 and getProtocolSides() > 5 then spMarch31osVortaBarrage(_side, march31oPat_thickness, 2, 0, 1, {}, 0, 0, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 10 then
        local _del = (GLOBAL_TEMPO > 90 and 1) or 0.65
        spMarch31osTrapAround(_side, (GLOBAL_TEMPO > 90 and 0) or 1, 1, 0, 0, 0, 1, 1, 2, 0, 0.7 * _del);
        t_wait(customizeTempoPatternDelay(8));
    elseif mNumbSpawn == 11 and getProtocolSides() > 4 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, u_rndIntUpper(6)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 12 and getProtocolSides() > 4 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 1, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, u_rndIntUpper(6)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 13 and getProtocolSides() > 4 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 2, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, u_rndIntUpper(6)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 14 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 2, 1, true, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, u_rndIntUpper(6)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 15 then
        local _offset, _dir = 0, getRandomDir()
        for a = 0, 4 do
            for i = 1, getBarrageSide(), 1 do wallSCurve(_side + i + _offset, _dir, 1, march31oPat_thickness) end
            _offset = math_add(_offset, _dir);
            _dir = math_mul(_dir, -1);
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)); end
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, u_rndIntUpper(9)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 16 and getProtocolSides() > 5 then
        local _offset, _dir = 0, u_rndInt(0, 1)
        for a = 0, 6 do
            if a < 2 then cWall(_side + (((_dir + a) % 2) * getHalfSides()), customizeTempoPatternThickness(0.5 * (a > 0 and 4 or 6)) + (march31oPat_thickness / 2)) end
            cDrawWall(_side + (((_dir + a + 1) % 2) * getHalfSides()), 2, getProtocolSides() - 2, march31oPat_thickness)
            if a < 6 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 17 then
        local _offset, _dir = 0, getRandomDir()
        for a = 0, 6 do
            for i = 1, getProtocolSides() do
                if _dir > 0 then
                    if _offset < getHalfSides() then cWall(_side + _offset, march31oPat_thickness) end
                else
                    if _offset >= getHalfSides() then cWall(_side + _offset, march31oPat_thickness) end
                end
                _offset = math_add(_offset, 1);
            end
            _offset = 0; _dir = math_mul(_dir, -1);
            if a < 6 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(2))
    elseif mNumbSpawn == 18 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, (GLOBAL_TEMPO < 140 and 6 or 3), 2, 1, 0, (getProtocolSides() > 4 and 2 or 1), false, (GLOBAL_TEMPO < 140 and 1 or 2), getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 19 then
        local _gapOffset = u_rndInt(1, getProtocolSides() - 2);
        spMarch31osTunnel(_side, march31oPat_thickness, 6, 0, 0, 1, true, 1, 0, 1, 1, false, false, false, 0, _gapOffset, getProtocolSides() - (_gapOffset + 1), 0, 0, 1, u_rndInt(0, 1), true); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 20 then
        local _del = (GLOBAL_TEMPO > 100 and 0.8) or 0.5
        spMarch31osAccurateBat(_side, false, false, 0, 0, 0, _del, true);
        if GLOBAL_TEMPO <= 100 then
            t_wait(customizeTempoPatternDelay(0.5));
            barrageFiller(march31oPat_thickness);
            t_wait(customizeTempoPatternDelay(0.5));
            barrageFiller(march31oPat_thickness);
            t_wait(customizeTempoPatternDelay(0.5));
            barrageFiller(march31oPat_thickness);
        end
        t_wait(customizeTempoPatternDelay(8));
    elseif mNumbSpawn == 21 and getProtocolSides() > 4 then
        local _mode, _dir, _dir_offset = u_rndInt(0, 9), getRandomDir(), u_rndInt(0, 1)
        cWall(_side, customizeTempoPatternThickness(0.5 * 6) + (march31oPat_thickness / 2))
        if _mode == 0 then
            local _rnd_offset = u_rndInt(0, getBarrageSide(3))
            for a = 0, 6 do
                cBarrage(_side + (_dir * _rnd_offset) + (_dir * ((a + _dir_offset) % 2 == 1 and 2 or 1)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
            end
        elseif _mode == 1 then
            local _rnd_offset = u_rndInt(0, getBarrageSide(4))
            for a = 0, 3 do
                cBarrage(_side + (_dir * _rnd_offset) + (_dir * ((a + _dir_offset) % 2 == 1 and 3 or 1)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
            end
        elseif _mode == 2 then
            local _type = u_rndInt(0, 1)
            if _type == 1 then
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 2), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                cBarrage(_side + (_dir * getBarrageSide(1)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * getBarrageSide(2)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * getBarrageSide(1)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
            else
                cBarrage(_side + (_dir * 2), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(2))
                cBarrage(_side + (_dir * getBarrageSide(1)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * getBarrageSide(2)), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
            end
        elseif _mode == 3 and getProtocolSides() == 6 then
            local _type = u_rndInt(0, 1)
            if _type == 1 then
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(2))
                cBarrage(_side + (_dir * 5), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
            else
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 2), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                cBarrage(_side + (_dir * 4), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 2), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
            end
        elseif _mode == 4 and getProtocolSides() == 6 then
            local _type = u_rndInt(0, 1)
            if _type == 1 then
                local _type_dir = getRandomDir()
                if _type_dir > 0 then
                    cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 5), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                else
                    cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 5), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                    cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                end
            else
                cBarrage(_side + (_dir * 1), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 2), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 4), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
                cBarrage(_side + (_dir * 5), march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
                cBarrage(_side + (_dir * 3), march31oPat_thickness) t_wait(customizeTempoPatternDelay(0.5))
            end
        else
            local _howMany = 6
            local _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4), 2, 4));
            local _barrageOldOffset = _barrageOffset
            local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
            --u_log("===========")
            for a = 0, 6 do
            if _howMany > 0 then
                cBarrage(_side + _barrageOffset, march31oPat_thickness)
                _barrageOldOffset = _barrageOffset
                if _howMany > 2 then
                    repeat _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4) - (_howMany - 6), 2, 4));
                    until _barrageOffset ~= _barrageOldOffset
                    _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
                    --u_log(_barrageOldOffset .. " - " .. _barrageOffset .. " = " .. _barrageDistanceDelay)
                else
                    _barrageDistanceDelay = 1
                    if _barrageOffset <= 1 then _barrageOffset = _barrageOffset + 1
                    elseif _barrageOffset >= getBarrageSide() then _barrageOffset = _barrageOffset - 1
                    else _barrageOffset = _barrageOffset + getRandomDir()
                    end
                end
                --u_log("_barrageOffset: " ..  _barrageOffset)
                if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1 end
                if _howMany > 0 then t_wait(customizeTempoPatternDelay(0.5 * _barrageDistanceDelay)) end
                    _howMany = _howMany - _barrageDistanceDelay
                    --u_log("_howMany: " ..  _howMany)
                else cBarrage(_side + _barrageOffset, march31oPat_thickness)
                end
            end
        end
        t_wait(customizeTempoPatternDelay(8))
    elseif mNumbSpawn == 22 and getProtocolSides() > 3 then
        local _side, _dir, _offset = getRandomSide(), u_rndInt(0, 1), 0
        cWallEx(_side, getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1 or 0, customizeTempoPatternThickness(0.5 * 6) + (march31oPat_thickness / 2))
        spMarch31osAlternatingBarrage(_side + 1 + _dir, march31oPat_thickness, 6, false, 0, false, 1, _dir, false);
        cWallEx(_side, getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1 or 0, march31oPat_thickness);
        t_wait(customizeTempoPatternDelay(8))
    elseif mNumbSpawn == 23 then
        local _freq_div = (GLOBAL_TEMPO > 100 and 2 or 1);
        local _timas = 4 / _freq_div;
        cWall(_side, customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
        for a = 0, _timas do
            for c = 1, getProtocolSides() - 3 do cWall(getRandomSide(), march31oPat_thickness) end
            if a < _timas then t_wait(customizeTempoPatternDelay(0.5 * _freq_div)) else cWall(_side, march31oPat_thickness) end
        end
        t_wait(customizeTempoPatternDelay(1)) barrageFiller(march31oPat_thickness, u_rndIntUpper(8)) t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 24 and getProtocolSides() > 4 then
        local _dir = u_rndInt(0, 1)
        cWall(_side, customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
        cWall(_side + math.ceil(getProtocolSides() / 2), customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
        for a = 0, 4 do
            cBarrage(_side + (math_mod(a + _dir, 2) * (math.ceil(getProtocolSides() / 2) - 2)) + 1, march31oPat_thickness)
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(1)) barrageFiller(march31oPat_thickness, u_rndIntUpper(8)) t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 25 then
        local _dir = getRandomDir()
        for a = 0, 4 do
            for i = 1, getBarrageSide(), 1 do wallSCurve(_side + i, _dir, 1 + a, march31oPat_thickness) end
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)); end
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, u_rndIntUpper(9)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 26 then
        local _howMany, _del, _oldSide = 6, 0, 0
        for a = 0, 6 do
            if _howMany >= 0 then
                cBarrage(_side, march31oPat_thickness)
                _oldSide = _side
                _side = _side + (_howMany > 3 and u_rndIntUpper(2) or 1) * getRandomDir();
                _del = _side - _oldSide
                if _del < 0 then
                    _del = -_del
                end
                t_wait(customizeTempoPatternDelay(0.5 * _del));
                _howMany = _howMany - _del
            end
        end
        t_wait(customizeTempoPatternDelay(8))
    elseif mNumbSpawn == 27 then
        for a = 0, 4 do
            for c = 1, getProtocolSides() - 3 do cWall(getRandomSide(), march31oPat_thickness) end
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, u_rndIntUpper(6)); t_wait(customizeTempoPatternDelay(1));
    end
end

function getTempoBasicKey()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 7, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 17, 17, 18, 18, 19, 20, 21, 22, 23, 24, 25, 25, 26, 27, 27, 27 }
shuffle(getKeys)
pat_index = 0
end

function getTempoCurveyKey()
getKeys = { 0, 1, 2, 3, 4, 5, 6, 7, 7, 8, 8, 9, 10, 11, 12, 13, 14, 15, 15, 25, 25 }
shuffle(getKeys)
pat_index = 0
end

function getTempoCurvelessKey()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 16, 17, 17, 18, 18, 19, 20, 21, 22, 23, 24, 26, 27, 27, 27 }
--getKeys = { 20 }
shuffle(getKeys)
pat_index = 0
end

function getTempoRandomlessKey()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 9, 9, 10, 11, 11, 12, 12, 13, 13, 14, 14, 16, 17, 17, 18, 18, 19, 20, 22, 23, 24, 27, 27, 27 }
shuffle(getKeys)
pat_index = 0
end

function spawnTempoCommonPattern(mNumbSpawn)
    local _side = getRandomSide();

    if mNumbSpawn == 1 and getProtocolSides() % 2 == 1 then
        -- mirror spiral looks bad with odd sides
        mNumbSpawn = 5
    end

    if mNumbSpawn == 0 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 2, false, 0, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 1 then
        if getProtocolSides() < 5 then spMarch31osWhirlwind(_side, 0, 0, 1, 1, 0.5, getRandomDir(), 1, nil, true);
        else spMarch31osWhirlwind(_side, (GLOBAL_TEMPO > 150 and 3) or 5, 0, math.floor(getProtocolSides() / 3), 1, (GLOBAL_TEMPO > 150 and 2) or 1, getRandomDir(), 0, nil, false);
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness, 3); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 2 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, 3); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 3 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 2, 1, false, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness, 3); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 4 then spMarch31osTunnel(_side, march31oPat_thickness, (GLOBAL_TEMPO > 120 and 2) or 3, 2, 0, 1, true, 0, nil, 1, 1, false, false, false, 1, 1, 1, 0, 0, (GLOBAL_TEMPO > 120 and 3) or 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 5 then spMarch31osWhirlwind(_side, (GLOBAL_TEMPO > 150 and 5) or 7, 0, 1, 1, (GLOBAL_TEMPO > 150 and 2) or 1, getRandomDir(), 0, 0, false); t_wait(customizeTempoPatternDelay(1));
    end
end

function getTempoCommonKey()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5 }
shuffle(getKeys)
pat_index = 0
end

function spawnTempoQuartzPattern(mNumbSpawn)
    local _side = getRandomSide();

    if mNumbSpawn == 0 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 2, false, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 1 then
        spMarch31osWhirlwindRev(_side, 0, 0, 1, 1, 2, 1.5, getRandomDir(), 1, 1, 1, false); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 2 then spMarch31osBarrageSpiralRev(_side, march31oPat_thickness, 1, 1, 1, 2, 1, 1, getRandomDir()) t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 3 then
        local _del = (GLOBAL_TEMPO > 90 and 1) or 0.65
        spMarch31osTrapAround(_side, (GLOBAL_TEMPO > 90 and 0) or 1, 1, 0, 0, 0, 1, 1, 2, 0, 0.7 * _del); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 4 then spMarch31osTunnel(_side, march31oPat_thickness * 1.75, 3, 2, 0, 1, true, 0, nil, 1, 1, false, false, false, 1, 1, 1, 0, 1, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 5 then
        spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 3, true, 0, true, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1 - 0.15));
        barrageFiller(march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
    end
end

function getTempoQuartzKey()
getKeys = { 0, 0, 1, 2, 2, 3, 4, 5, 5 }
shuffle(getKeys)
pat_index = 0
end

function spawnTempoInsanityPattern(mNumbSpawn)
    local _side = getRandomSide()
    if mNumbSpawn == 0 and getProtocolSides() >= 4 then
        local _2nd_side = getRandomSide()
        for a = 0, 2 do
            cBarrage(_side, march31oPat_thickness)
            if a < 2 then t_wait(customizeTempoPatternDelay(0.5)) end
        end    
        t_wait(customizeTempoPatternDelay(1))
        for a = 0, 2 do
            cAltBarrage(_2nd_side, 2, march31oPat_thickness)
            if a < 2 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 1 and getProtocolSides() >= 4 then
        for a = 0, 3 do
            cBarrageExHoles(getRandomSide(), 1, march31oPat_thickness);
            if a < 3 then t_wait(customizeTempoPatternDelay(1)) end
        end
        t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 2 then
        if getProtocolSides() < 5 then spMarch31osWhirlwind(_side, 0, 0, 1, 1, 0.5, getRandomDir(), 1, nil, true);
        else spMarch31osWhirlwind(_side, (GLOBAL_TEMPO > 150 and 1) or 3, 0, math.floor(getProtocolSides() / 3), 1, (GLOBAL_TEMPO > 150 and 2) or 1, getRandomDir(), 1, nil, false);
        end
        t_wait(customizeTempoPatternDelay(1)); barrageFiller(march31oPat_thickness); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 3 and getProtocolSides() > 4 then spMarch31osTunnel(_side, march31oPat_thickness, (GLOBAL_TEMPO > 160 and 1) or 2, 2, 0, 2, true, 1, nil, 1, 1, true, false, false, 1, 1, 1, 0, 0, (GLOBAL_TEMPO > 160 and 3) or 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 4 then
        local _del = (GLOBAL_TEMPO > 90 and 1) or 0.65
        spMarch31osTrapAround(_side, (GLOBAL_TEMPO > 90 and 0) or 1, 1, 0, 0, 0, 1, 1, 2, 0, 0.7 * _del);
        t_wait(customizeTempoPatternDelay(8));
    elseif mNumbSpawn == 5 then spMarch31osBarrageSpiralRev(_side, march31oPat_thickness, 1, 1, 1, 2, 1, 1, getRandomDir()) t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 6 then spMarch31osTunnel(_side, march31oPat_thickness * 1.75, 3, 2, 0, 1, true, 0, nil, 1, 1, false, false, false, 1, 1, 1, 1, 0, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 7 and getProtocolSides() > 5 then
        local _offset, _dir = 0, u_rndInt(0, 1)
        for a = 0, 6 do
            if a < 2 then cWall(_side + ((_dir + a % 2) * getHalfSides()), customizeTempoPatternThickness(0.5 * (a > 0 and 4 or 6)) + march31oPat_thickness) end
            cDrawWall(_side + ((_dir + a + 1 % 2) * getHalfSides()), 2, getProtocolSides() - 2, march31oPat_thickness * 2)
            if a < 6 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 8 and getProtocolSides() > 3 then
        local _dir, _offset = getRandomDir(), u_rndInt(0, 1)
        cWallEx(_side, (getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1) or 0, customizeTempoPatternThickness(0.5 * 6) + (march31oPat_thickness / 2))
        for a = 0, 6 do
            cWallExM(_side + _offset, math.floor(getProtocolSides() / 2) + (_dir * 0.5 - 0.5) + 1, 2, march31oPat_thickness)
            _offset = _offset + _dir
            _dir = _dir * -1
            if a < 6 then t_wait(customizeTempoPatternDelay(0.5)) else cWallEx(_side, (getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1) or 0, march31oPat_thickness) end
        end
        t_wait(customizeTempoPatternDelay(8))
    elseif mNumbSpawn == 9 then
        local _dir = getRandomDir()
        cWall(_side, customizeTempoPatternThickness(2) + (march31oPat_thickness / 2));
        cBarrage(_side + _dir, march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        cBarrage(_side + (4 * _dir), march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        cBarrage(_side + _dir, march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 10 then
        local _dir = getRandomDir()
        cWall(_side, customizeTempoPatternThickness(2) + (march31oPat_thickness / 2));
        cBarrage(_side + _dir, march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        cBarrage(_side - (getQuadSides() * _dir), march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        cBarrage(_side + getHalfSides(), march31oPat_thickness); t_wait(customizeTempoPatternDelay(1));
        barrageFiller(march31oPat_thickness); t_wait(customizeTempoPatternDelay(2));
    end
end

function getTempoInsanityKey()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 }
shuffle(getKeys)
pat_index = 0
end

function spawnTempoBasicPatternTrip(mNumbSpawn)
    local _side = getRandomSide();

        if mNumbSpawn == 0                            then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 1                            then spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 4, false, 0, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 2                            then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 1, 1, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 3                            then spMarch31osTunnel(_side, march31oPat_thickness, (GLOBAL_TEMPO > 100 and 2) or 3, 2, 0, 1, true, 0, nil, 1, 1, false, false, false, 1, (getProtocolSides() > 6 and 3) or 1, nil, 0, nil, 2 * (GLOBAL_TEMPO > 100 and 1 or 0.666), u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 4                            then spMarch31osWhirlwind(_side, 3, 0, math.floor(getProtocolSides() / 3), 1, 1, getRandomDir(), 1, nil, false); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 5 and getProtocolSides() > 5 then spMarch31osVortaBarrage(_side, march31oPat_thickness, 1, 0, 1, {}, 0, 0, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 6 and getProtocolSides() > 5 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 7 and getProtocolSides() > 5 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 1, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 8 and getProtocolSides() > 5 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 2, 1, true, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 9 and getProtocolSides() > 5 then spMarch31osBackAndForthTunnelCentral(_side, march31oPat_thickness, 4, 0, 2, 0, 0, 0, 0, nil, 1, 1, false, false, false, 1, 1, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 10 then spMarch31osTrapAround(_side, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0.7); t_wait(customizeTempoPatternDelay(8));
    elseif mNumbSpawn == 11 then
        local _offset, _dir = 0, getRandomDir()
        for a = 0, 4 do
            for i = 1, getProtocolSides() do
                if _dir > 0 then
                    if _offset < getHalfSides() then cWall(_side + _offset, march31oPat_thickness) end
                else
                    if _offset >= getHalfSides() then cWall(_side + _offset, march31oPat_thickness) end
                end
                _offset = math_add(_offset, 1);
            end
            _offset = 0; _dir = math_mul(_dir, -1);
            if a < 6 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(2))
    elseif mNumbSpawn == 12 then spMarch31osBarrageSpiral(_side, march31oPat_thickness, 3, 2, 1, 0, (getProtocolSides() > 4 and 2 or 1), false, 2, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 13 then spMarch31osTunnel(_side, march31oPat_thickness, 1, 2, 0, (getProtocolSides() > 6 and 4) or 3, true, 1, nil, 1, 1, true, false, false, 1, 1, 1, 0, 0, 2, u_rndInt(0, 1)); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 14 then
        cWall(_side, customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
            local _howMany = 4
            local _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4), 2, 4));
            local _barrageOldOffset = _barrageOffset
            local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
            for a = 0, 4 do
            if _howMany > 0 then
                cBarrage(_side + _barrageOffset, march31oPat_thickness)
                _barrageOldOffset = _barrageOffset
                if _howMany > 2 then
                    repeat _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4) - (_howMany - 4), 2, 4));
                    until _barrageOffset ~= _barrageOldOffset
                    _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
                    --u_log(_barrageOldOffset .. " - " .. _barrageOffset .. " = " .. _barrageDistanceDelay)
                else
                    _barrageDistanceDelay = 1
                    if _barrageOffset <= 1 then _barrageOffset = _barrageOffset + 1
                    elseif _barrageOffset >= getBarrageSide() then _barrageOffset = _barrageOffset - 1
                    else _barrageOffset = _barrageOffset + getRandomDir()
                    end
                end
                --u_log("_barrageOffset: " ..  _barrageOffset)
                if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1 end
                if _howMany > 0 then t_wait(customizeTempoPatternDelay(0.5 * _barrageDistanceDelay)) end
                    _howMany = _howMany - _barrageDistanceDelay
                    --u_log("_howMany: " ..  _howMany)
                else cBarrage(_side + _barrageOffset, march31oPat_thickness)
                end
            end
            t_wait(customizeTempoPatternDelay(2));
    elseif mNumbSpawn == 15 then
        local _dir, _offset = getRandomDir(), u_rndInt(0, 1)
        cWallEx(_side, math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness(0.5 * 4) + (THICKNESS / 2))
        for a = 0, 4 do
            cWallExM(_side + _offset, math.floor(getProtocolSides() / 2) + (_dir * 0.5 - 0.5) + 1, 2, THICKNESS)
            _offset = _offset + _dir
            _dir = _dir * -1
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)) else cWallEx(_side, math.floor(getProtocolSides() / 2) - 1, THICKNESS) end
        end
        t_wait(customizeTempoPatternDelay(8))
    elseif mNumbSpawn == 16 and getProtocolSides() > 4 then
        local _dir = u_rndInt(0, 1)
        cWall(_side, customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
        cWall(_side + math.ceil(getProtocolSides() / 2), customizeTempoPatternThickness(0.5 * 4) + (march31oPat_thickness / 2))
        for a = 0, 4 do
            cBarrage(_side + (math_mod(a + _dir, 2) * (math.ceil(getProtocolSides() / 2) - 2)) + 1, march31oPat_thickness)
            if a < 4 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(2))
    end
end

function getTempoKeyTrip()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10, 11, 11, 12, 12, 13, 14, 15, 16 }
shuffle(getKeys)
pat_index = 0
end

function getTempoCurvelessKeyTrip()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 10, 11, 11, 12, 12, 13, 14, 15, 16 }
shuffle(getKeys)
pat_index = 0
end

function spawnTempoBasicPatternQuint(mNumbSpawn)
    local _side = getRandomSide();

    if mNumbSpawn == 0 then
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 3, 1, 1, 0, 1, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
        spMarch31osAlternatingBarrage(getRandomSide(), march31oPat_thickness, 3, false, 0, false, 1, getRandomDir()); t_wait(customizeTempoPatternDelay(1));
    elseif mNumbSpawn == 1 then
        local _dir = getRandomDir()
        spMarch31osWhirlwind(_side, 3, 0, math.floor(getProtocolSides() / 3), 1, 1, _dir, 1, 0, false, false);
        _side = _side + (_dir * 5)
        spMarch31osWhirlwind(_side, 5, 0, math.floor(getProtocolSides() / 3), 1, 1, -_dir, 0, 1, false, false);
        t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 2 then
        local _dir = getRandomDir()
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 3, 1, 1, 0, 1, false, 1, _dir, false); t_wait(customizeTempoPatternDelay(0.5));
        _side = _side + (_dir * 2)
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 0, 1, 1, 0, 1, false, 1, -_dir, false); t_wait(customizeTempoPatternDelay(0.5));
        _side = _side + (_dir * 1)
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 3, 1, 1, 0, 1, false, 1, -_dir, false); t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 3 then
        cBarrage(_side, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side + getHalfSides(), 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cBarrage(_side + getHalfSides(), march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cMirrorWall(_side, 2, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cBarrage(_side, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side, 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cDoubleHoledBarrage(_side + getHalfSides(), 0, 0, march31oPat_thickness); t_wait(customizeTempoPatternDelay(0.5))
        cBarrage(_side + getHalfSides(), march31oPat_thickness); t_wait(customizeTempoPatternDelay(5))
    elseif mNumbSpawn == 4 then
        local _dir = getRandomDir()
        for a = 0, 8 do
            if _dir > 0 then cMirrorWall(_side - 1, 2, march31oPat_thickness);
            else cVortaBarrage(_side, 0, march31oPat_thickness);
            end
            _dir = -_dir;
            if a < 8 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(5))
    elseif mNumbSpawn == 5 then
        local _dir = getRandomDir()
        cWall(_side, customizeTempoPatternThickness(4) + (march31oPat_thickness / 2))
        for a = 1, 4 do
            cBarrage(_side + _dir, march31oPat_thickness * 1.75);
            _dir = -_dir;
            t_wait(customizeTempoPatternDelay(a ~= 2 and 1.5 or 1));
        end
        t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 6 then
        local _dir = getRandomDir()
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 1, 1, 1, 0, 1, false, 1, _dir, false); t_wait(customizeTempoPatternDelay(0.5));
        _side = _side + (_dir * 2)
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 1, 1, 1, 0, 1, false, 1, -_dir, false); t_wait(customizeTempoPatternDelay(0.5));
        _side = _side - (_dir * 2)
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 1, 1, 1, 0, 1, false, 1, _dir, false); t_wait(customizeTempoPatternDelay(0.5));
        spMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, 0, 1, false, 1, _dir, false); t_wait(customizeTempoPatternDelay(5));
    elseif mKey == 7 then
        local _dir = getRandomDir()
        DoubleBarrageSpiral(_side, march31oPat_thickness, 4, 1, 2, 0, 1, false, 1, _dir, false)
        _side = _side + (getHalfSides("floor") - 1) * _dir
        t_wait(customizeTempoPatternDelay(0.5))
        DoubleBarrageSpiral(_side, march31oPat_thickness, 3, 1, 2, 0, 1, false, 1, _dir, false)
        t_wait(customizeTempoPatternDelay(5))
    elseif mKey == 8 then
        local _dir = getRandomDir()
        for i = 1, 9 do
            if i % 3 == 1 then
                rWall(_side, customizeTempoPatternThickness(1) + march31oPat_thickness)
            end

            if i % 3 == 0 and i < 9 then
                rWall(_side + _dir, customizeTempoPatternThickness(0.5))
            else
                rWall(_side + _dir, march31oPat_thickness)
            end

            _dir = _dir * -1
            if i % 3 == 0 then
                _side = _side + _dir
            end
            t_wait(customizeTempoPatternDelay(0.5))
        end
        t_wait(customizeTempoPatternDelay(5))
        
    elseif mKey == 9 then
        local _dir = getRandomDir()
        for i = 1, 9 do
            cVortaBarrage(_side, march31oPat_thickness)
            _side = _side + _dir
            
            if i % 2 == 1 then
                _dir = _dir * -1
            end

            t_wait(customizeTempoPatternDelay(0.5))
        end
        t_wait(customizeTempoPatternDelay(5))
    elseif mKey == 10 then
        local _dir = getRandomDir()
        for i = 1, 9 do
            if i % 2 == 1 then
                cVortaBarrage(_side, march31oPat_thickness)
            else
                cAltBarrage(_side, 2, march31oPat_thickness)
                _side = _side + _dir * 2
            end
            
            t_wait(customizeTempoPatternDelay(0.5))
        end
        t_wait(customizeTempoPatternDelay(5))
    elseif mKey == 11 then
        local _dir = getRandomDir()
        cBarrage(_side, march31oPat_thickness)
        _side = _side + getHalfSides()
        t_wait(customizeTempoPatternDelay(1.5))
        cBarrage(_side, march31oPat_thickness)
        _side = _side + getHalfSides()
        t_wait(customizeTempoPatternDelay(1))
        cBarrage(_side, march31oPat_thickness)
        _side = _side + getHalfSides()
        t_wait(customizeTempoPatternDelay(1.5))
        cBarrage(_side, march31oPat_thickness)
        _side = _side + getHalfSides()
        t_wait(customizeTempoPatternDelay(5))
    elseif mNumbSpawn == 12 then
        local _dir, _offset = getRandomDir(), u_rndInt(0, 1)
        cWallEx(_side, (getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1) or 0, customizeTempoPatternThickness(0.5 * 8) + (march31oPat_thickness / 2))
        for a = 0, 8 do
            cWallExM(_side + _offset, math.floor(getProtocolSides() / 2) + (_dir * 0.5 - 0.5) + 1, 2, march31oPat_thickness)
            _offset = _offset + _dir
            _dir = _dir * -1
            if a < 8 then t_wait(customizeTempoPatternDelay(0.5)) else cWallEx(_side, (getProtocolSides() > 4 and math.floor(getProtocolSides() / 2) - 1) or 0, march31oPat_thickness) end
        end
        t_wait(customizeTempoPatternDelay(5))
    elseif mNumbSpawn == 13 then
        cWall(_side, customizeTempoPatternThickness(0.5 * 8) + (march31oPat_thickness / 2))
        for a = 0, 8 do
            for c = 0, getProtocolSides() - 4 do cWall(getRandomSide(), march31oPat_thickness) end
            if a < 8 then t_wait(customizeTempoPatternDelay(0.5)) else cWall(_side, march31oPat_thickness) end
        end
        t_wait(customizeTempoPatternDelay(1)) barrageFiller(march31oPat_thickness) t_wait(customizeTempoPatternDelay(1))
    elseif mNumbSpawn == 14 and getProtocolSides() > 5 then
        local _offset, _dir = 0, u_rndInt(0, 1)
        for a = 0, 8 do
            if a < 2 then cWall(_side + ((_dir + a % 2) * getHalfSides()), customizeTempoPatternThickness(0.5 * (a > 0 and 6 or 8)) + (march31oPat_thickness / 2)) end
            cDrawWall(_side + ((_dir + a + 1 % 2) * getHalfSides()), 2, getProtocolSides() - 2, march31oPat_thickness)
             if a < 8 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 15 then
        spMarch31osTrapAround(_side, 1, 1, 0, 0, 0, 1, 1, 2, 0, 0.6);
        t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 16 then
        local _howMany = 8
        local _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4), 2, 4));
        local _barrageOldOffset = _barrageOffset
        local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
        cWall(_side, customizeTempoPatternThickness(0.5 * 8) + (march31oPat_thickness / 2))
        for a = 0, 8 do
            if _howMany > 0 then
                cBarrage(_side + _barrageOffset, march31oPat_thickness)
                _barrageOldOffset = _barrageOffset
                if _howMany > 2 then
                    repeat _barrageOffset = u_rndIntUpper(closeValue(getBarrageSide(4) - (_howMany - 6), 2, 4));
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
                if _howMany > 0 then t_wait(customizeTempoPatternDelay(0.5 * _barrageDistanceDelay)) end
                _howMany = _howMany - _barrageDistanceDelay
            else cBarrage(_side + _barrageOffset, march31oPat_thickness)
            end
        end
        t_wait(customizeTempoPatternDelay(5));
    elseif mNumbSpawn == 17 and getProtocolSides() > 4 then
        local _dir = u_rndInt(0, 1)
        cWall(_side, customizeTempoPatternThickness(0.5 * 8) + (march31oPat_thickness / 2))
        cWall(_side + math.ceil(getProtocolSides() / 2), customizeTempoPatternThickness(0.5 * 8) + (march31oPat_thickness / 2))
        for a = 0, 8 do
            cBarrage(_side + (math_mod(a + _dir, 2) * (math.ceil(getProtocolSides() / 2) - 2)) + 1, march31oPat_thickness)
            if a < 8 then t_wait(customizeTempoPatternDelay(0.5)) end
        end
        t_wait(customizeTempoPatternDelay(5))
    end
end

function getTempoBasicKeyQuint()
getKeys = { 0, 0, 1, 2, 2, 3, 3, 4, 4, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 13, 14, 15, 16, 17 }
shuffle(getKeys)
pat_index = 0
end
