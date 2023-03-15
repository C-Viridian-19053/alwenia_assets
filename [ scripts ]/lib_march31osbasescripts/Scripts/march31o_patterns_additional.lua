--[[
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _revFreq, _gap, _holes, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter) --, _revFreq, 1, 1, 1, 1, 1, getRandomDir()
    void pMarch31osBarrageLeftRights(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    void pMarch31osBarrageLeftRights(_side, _thickness, _iter) --, 1, 1, false, 1, 1, u_rndInt(0, 1)
    void pMarch31osWallDisplacer(_side, _thickness, _iter, _delMult, _sizeMult)
    void pMarch31osWallDisplacer(_side, _thickness, _iter) --, 1, 1
    void pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter, _delMult, _sizeMult)
    void pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter) --, 1, 1
    void pMarch31osAbstractBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    void pMarch31osAbstractBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir()
    void pMarch31osWallExFillerSpiral(_side, _delMult, _sizeMult, _direction)
    void pMarch31osWallExFillerSpiral(_side) --, 1, 1, getRandomDir()
    void pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult, _direction)
    void pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir()
    void pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult, _direction)
    void pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir()
    void pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter, _extraHole, _isSpiral, _delMult, _sizeMult, _direction)
    void pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir()
    void pMarch31osCtoCIBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    void pMarch31osCtoCIBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir()
    void pMarch31osJumbleBarrage(_side, _thickness, _iter, _chance, _delMult, _sizeMult)
    void pMarch31osJumbleBarrage(_side, _thickness, _iter) --, getProtocolSides() - 2, 1, 1, false, 0, 1, 1, 2
    void pMarch31osSprayBarrage(_side, _thickness, _iter, _delay, _extra, _delMult, _sizeMult)
    void pMarch31osSprayBarrage(_side, _thickness, _iter) --, 4, 2, 1, 1, false, 0, 1, 1, 2
    void pMarch31osOddAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir)
    void pMarch31osOddAltBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir()
    void pMarch31osEvenAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir)
    void pMarch31osEvenAltBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir()
    void pMarch31osAltHalfBarrage(_side, _thickness, _iter, _extraWalls, _delMult, _sizeMult, _barrageDir)
    void pMarch31osAltHalfBarrage(_side, _thickness, _iter) --, 0, 1, 1, 0, getRandomDir()
    void pMarch31osAltTrapBarrage(_side, _thickness, _iter, _gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir)
    void pMarch31osAltTrapBarrage(_side, _thickness, _iter) --, 1, 1, 1, getRandomDir(), 0, getRandomDir(), 1
    void pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter, _mainDirNeigh, _capDirGap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir)
    void pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir(), 0, getRandomDir(), 1

    void pMarch31osRandomWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountEnd, _is_full)
    void pMarch31osRandomWhirlwind(_side, _iter) --0, math.floor(getProtocolSides() / 3), 1, 1, 1, getRandomDir(), 0
    void pMarch31osFullWhirlwind(_side, _iter, _delMult, _sizeMult, _direction)
    void pMarch31osFullWhirlwind(_side, _iter) --, 1, 1, getRandomDir()
    void pMarch31osFullWhirlwindPrototype(_side, _sizeMult, _direction)
    void pMarch31osFullWhirlwindPrototype(_side) --, 1, getRandomDir()
    void pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _width, _delMult, _sizeMult, _direction)
    void pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, 1, u_rndInt(0, 1)

    void pMarch31osXer(_side)
    void pMarch31osXer(_side)
    void pMarch31osGrowingBarrage(_side)
    void pMarch31osGrowingBarrage(_side)
]]

--[[
[ NOTE FOR THE PARAMETERS ]

>>      _side: which side the pattern spawns on
>> _thickness: the thickness of the pattern
>>      _iter: amount of times
>>   _delMult: the delay pattern multiplier of the pattern
>>  _sizeMult: the size pattern multiplier of the pattern
>> _direction: which direction
]]

--[[
[ NOTE FOR THE OPTIONAL PARAMETERS ]

// p_adjustPatternSettings(_isRebootingSide, _skipEndDelayBool, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)

>> [KODIPHER's PARAMETER]          _skipEndDelay: skips delay after pattern spawned
>> [THE SUN XIX's PARAMETER]    _isRebootingSide: the boolean of rebooting side of the pattern
>> [THE SUN XIX's PARAMETER] _endAdditionalDelay: amount of additional delay after pattern spawned, which 'march31oPatDel_AdditionalDelay' variable is
>> [THE SUN XIX's PARAMETER]            _addMult: the alternative delay multiplier of the pattern, which 'march31oPatDel_AddMult' variable is
>>                       _delayMultOfSpdLessThan: delay multiplier of speed less than...
>>                        _spdIsGreaterThanEqual: speed is greater than equal
]]

--[ Barrages ]--

-- pMarch31osBarrageSpiralRev(): spawns a spiral of cBarrage where you need to change direction
--             _gap: the gap of this barrage
--           _holes: the amount of holes of this barrage
--         _revFreq: how many times the direction will change
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _revFreq, _gap, _holes, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _revFreq = anythingButNil(_revFreq, u_rndInt(1, 2)); _distance = anythingButNil(_distance, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and -1) or getRandomDir();
    local _barrageOffset = 0;
    local _revIterAdd = 0;

    if _holes > 1 then _gap = 1; end

    for r = 0, _revFreq, 1 do
        if r == _revFreq then _revIterAdd = 1; end

        for a = 0, _iter + _revIterAdd, 1 do
            p_patternEffectCycle();

            if _holes > 1 then cBarrageExHoles(_curSide + (_barrageOffset * _distance), _holes - 1, p_getPatternThickness());
            else cBarrageGap(_curSide + (_barrageOffset * _distance), _gap, p_getPatternThickness());
            end
            _barrageOffset = _barrageOffset + _barrageLoopDir;
            t_applyPatDel(customizePatternDelay(4 * (getBooleanNumber(_isDelayDistance) and (_distance * 0.333 + 0.667) or 1) * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
        end

        _barrageLoopDir = _barrageLoopDir * -1;
    end

    p_patternEffectEnd();
    if not p_getSkipEndDelayPatternBool() then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

-- pMarch31osBarrageLeftRights(): spawns a barrage with left-right instead of spiral
--             _gap: the gap of this barrage
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageLeftRights(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 1, anythingButNil(_distance, 1), _direction, false, (getBooleanNumber(_isDelayDistance) and (anythingButNil(_distance, 1) * 0.333 + 0.667) or 1) * _delMult, _sizeMult)
end

-- taken from alphapatterns.lua's Vexatious pack by AlphaPromethium
-- pMarch31osWallDisplacer(): spawns a particular pattern with some walls displaced further than the others
function pMarch31osWallDisplacer(_side, _thickness, _iter, _delMult, _sizeMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _displaceSide = {};
    local _displaceSideDifference = false;

    --this loop generates which walls will spawn at what position.. 0 = close; 1 = far
    for i = 1, getProtocolSides(), 1 do _displaceSide[i] = u_rndInt(0, 1); end

    --this loop and the second if statement below will force a difference if there doesn't exist one
    for order = 1, getProtocolSides(), 1 do
        for index = 1, getProtocolSides(), 1 do
            --this compares the two being determined
            if _displaceSide[order] ~= _displaceSide[index] then _displaceSideDifference = true; end
        end
    end
    if not _displaceSideDifference then
        local s = _side; --chooses a random side to differentiate
        _displaceSide[s] = (_displaceSide[s] + 1) % 2;
    end

    --this loop will generate the walls needed at their defined positions
    --remember, the frequency also detemines how many times they will spawn
    for a = 0, _iter - 1, 1 do
        p_patternEffectCycle();

        --1st part = spawns close walls
        --2nd part = spawns far walls
        for i = 1, getProtocolSides(), 1 do
            if _displaceSide[i] == a % 2 then cWallEx(i, 0, p_getPatternThickness() * _sizeMult); end
        end

        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osDoubleBarrageSpiralAcross(): spawns a barrage with double hole but across
function pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter, _delMult, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageOffset = 0;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do
        p_patternEffectCycle();

        if (a % (math.floor(getProtocolSides() / 2) * 2)) == 0 then cBarrage(_side, p_getPatternThickness() * _sizeMult); _barrageOffset = 0
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) > 0 and (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) then cDoubleHoledBarrage(_side - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset + 2
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) >= math.floor(getProtocolSides() / 2) and (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) * 2 then cDoubleHoledBarrage(_side - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset - 2
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()))
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osAbstractBarrage(): same as pMarch31osDoubleBarrageSpiralAcross() pattern * -1 (opposite)
function pMarch31osAbstractBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do
        p_patternEffectCycle();

        cWall(_curSide + a, p_getPatternThickness() * _sizeMult);
        cWall(_curSide - a, p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osWallExFillerSpiral(): same as Hexadorsip's pSTBBarrageSpiral() pattern, spawns a "small to big" spiral of cWallEx
-- note: this pattern has no amount of times parameter in it because works on all sides
function pMarch31osWallExFillerSpiral(_side, _thickness, _delMult, _sizeMult, _direction)
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, getProtocolSides() - 2, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then cWallEx(_curSide + a, a, p_getPatternThickness() * _sizeMult);
        else cWallEx(_curSide - (a * 2), a, p_getPatternThickness() * _sizeMult);
        end

        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osDoubleHoledBarrageSpiral(): spawns a doubled hole barrage with spiral displacement
--   _extraHole: extra amount of holes
-- _distPosMult: displacement multiplier. default = 1
function pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult, _direction)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), 0, anythingButNil(_distPosMult, 1), _direction, false, _delMult, _sizeMult)
end

-- pMarch31osDoubleHoledBarrageLeftRights(): spawns a doubled hole barrage with left-right displacement
--   _extraHole: extra amount of holes
-- _distPosMult: displacement multiplier. default = 1
function pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _distPosMult, _direction)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), 1, anythingButNil(_distPosMult, 1), _direction, false, _delMult, _sizeMult)
end

-- pMarch31osDoubleHoledBarrageInversions(): spawns a doubled hole barrage with invert displacement
-- _extraHole: extra amount of holes
--  _isSpiral: boolean of spiral 180 dregees displacement
function pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter, _extraHole, _isSpiral, _delMult, _sizeMult, _direction)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), (getBooleanNumber(_isSpiral) and 0) or 2, (getBooleanNumber(_isSpiral) and math.floor(getProtocolSides() / 2)) or 1, _direction, false, _delMult, _sizeMult)
end

-- pMarch31osCtoCIBarrage(): spawns one-holed barrage and double-holed barrage
function pMarch31osCtoCIBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(4, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = _direction;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
        else cBarrageExHoles(_curSide, 1, p_getPatternThickness() * _sizeMult);
        end

        _barrageLoopDir = _barrageLoopDir * -1
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osJumbleBarrage(): spawns a jumbled barrage (taken from babadrake's pattern)
-- _chance: amount of randomized wall displacement
function pMarch31osJumbleBarrage(_side, _thickness, _iter, _chance, _delMult, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _chance = anythingButNil(_chance, getProtocolSides() - 2);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, _chance, 1 do cWall(_curSide + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), p_getPatternThickness() * _sizeMult); end
        t_applyPatDel(customizePatternDelay(2.75 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osSprayBarrage(): spawns a spray barrage (taken from Syyrion's pattern)
-- _delay: amount of delay
-- _extra: amount of extra walls
function pMarch31osSprayBarrage(_side, _thickness, _iter, _delay, _extra, _delMult, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = u_rndInt(0, 1); end
    if _direction < 0 then _direction = 0 elseif _direction > 1 then _direction = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do
        cWallEx(_curSide + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), u_rndInt(0, _extra or 2), p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay((_delay or 4) * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osOddAltBarrage(): spawns a odd alt barrage
-- _barrageDir: barrage direction
function pMarch31osOddAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();
    
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = -1;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir > 0 then
                if _barrageLoopDirAlt == -1 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            else
                if _barrageLoopDirAlt >= 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            end
            _barrageOffset = _barrageOffset + 1; _barrageLoopDirAlt = _barrageLoopDirAlt + 1;
            if _barrageLoopDirAlt > 1 then _barrageLoopDirAlt = -1; end
        end
        _barrageOffset = 0; _barrageLoopDirAlt = -1; _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osEvenAltBarrage(): spawns a even alt barrage instead of odd ones
-- _barrageDir: barrage direction
function pMarch31osEvenAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _barrageDir)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = 0;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir > 0 then
                if _barrageLoopDirAlt == 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            else
                if _barrageLoopDirAlt > 0 then cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); cWall(_curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end
            end
            _barrageOffset = _barrageOffset + 1; _barrageLoopDirAlt = _barrageLoopDirAlt + 1;
            if _barrageLoopDirAlt > getHalfSides() - 1 then _barrageLoopDirAlt = 0; end
        end
        _barrageOffset = 0; _barrageLoopDirAlt = 0; _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(4 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osAltHalfBarrage(): spawns a alternating half-barrage
-- _offset: offset of this wall
function pMarch31osAltHalfBarrage(_side, _thickness, _iter, _offset, _delMult, _sizeMult, _barrageDir)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _offset = anythingButNil(_offset, 0);
    if not _offset or _offset < 0 then _offset = 0; end
    if _barrageDir == nil or _barrageDir == 0 then _barrageDir = getRandomDir(); end
    if _barrageDir < -1 then _barrageDir = -1 elseif _barrageDir > 1 then _barrageDir = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDir = _barrageDir;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then
            for i = 1, getHalfSides() + _offset, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        else
            for i = getHalfSides() + 1, getProtocolSides() + _offset, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.7 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osAltTrapBarrage(): spawns a alternating trap barrage
--        _gap: gap amount. default = 1
-- _barrageDir: barrage direction
-- _offsetType: offset type. 0 = none, 1 = spiral, 2 = left-right, 3 = inversions
-- _offsetMult: offset multiplier
--  _offsetDir: offset direction
function pMarch31osAltTrapBarrage(_side, _thickness, _iter, _gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _gap = anythingButNil(_gap, 1); _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = _barrageDir;
    local _offsetLoopDir = math.ceil(_offsetDir);

    local _typeModeModuloStat = (_offsetType == 1 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 0 and 0) or (_offsetType == 3 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 0 and 0) or (_offsetType == 3 and 0) or _offsetMult;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, getProtocolSides(), 1 do
            if _barrageLoopDir < 0 then
                if i > _gap then cWall(_curSide + i + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _offsetLoopDir), p_getPatternThickness() * _sizeMult); end
            elseif _barrageLoopDir > 0 then
                if i <= _gap then cWall(_curSide + i + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _offsetLoopDir), p_getPatternThickness() * _sizeMult); end
            end
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osCustomizedAltTrapBarrage(): same as pMarch31osAltTrapBarrage(), but you can personalize everything
-- _mainDirNeigh: barrage direction 1 neighbors. default = 0
--    _capDirGap: barrage direction -1 gap, but extend. default = 1
--   _barrageDir: barrage direction
--   _offsetType: offset type. 0 = none, 1 = spiral, 2 = left-right, 3 = inversions
--   _offsetMult: offset multiplier
--    _offsetDir: offset direction
function pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter, _mainDirNeigh, _capDirGap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _mainDirNeigh = anythingButNil(_mainDirNeigh, 0); _capDirGap = anythingButNil(_capDirGap, 1); _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = _barrageDir;
    local _offsetLoopDir = math.ceil(_offsetDir);

    local _typeModeModuloStat = (_offsetType == 1 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 0 and 0) or (_offsetType == 3 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 0 and 0) or (_offsetType == 3 and 0) or _offsetMult;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir < 0 then cBarrageN(_curSide + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir), _mainDirNeigh, p_getPatternThickness() * _sizeMult);
        elseif _barrageLoopDir > 0 then cGrowWall(_curSide + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir), _capDirGap, p_getPatternThickness() * _sizeMult);
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Spirals ]--

-- pMarch31osRandomWhirlwind(): spawns a spiral of using cWallExThick like the pattern from Hexagonest, Hyper Hexagoner and Hyper Hexagonest but always randomizes the direction. (Spin 2 Failure)
--                            _extra: amount of extras in this cMirrorWallEx
--                      _mirror_step: amount of mirror step
--                      _pos_spacing: position spacing amount where to displace
--                         _seamless: boolean of spiral pattern uses seamless
--                 _slopeAmountStart: amount of slope before spiral pattern spawns
--                   _slopeAmountEnd: amount of slope after spiral pattern spawns
-- [WORKS ONLY ON SIDE < 5] _is_full: boolean of full spiral
function pMarch31osRandomWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _sizeMult, _direction, _slopeAmountStart, _slopeAmountEnd, _is_full)
    _iter = anythingButNil(_iter, u_rndInt(6, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extra = anythingButNil(_extra, 0); _mirror_step = anythingButNil(_mirror_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();
    if not _slopeAmountStart or _slopeAmountStart < 0 then _slopeAmountStart = 0; end
    if not _slopeAmountEnd or _slopeAmountEnd < 0 then _slopeAmountEnd = _slopeAmountStart; end

    local currentTimesOfThickStartAmountForSquare, currentTimesEndOfThickAmountForSquare, currentTimesOfThickAmountForGreaterThanSquare = 6, 8.25, 2;
    local currentSizeOverride, currentDelayOverride = 1.25, 0.9;
    local currentTimesOfThickAmount = 2;

    p_resetPatternDelaySettings();
    p_adjustPatternSettings();

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _spiralRngLoopDir = getRandomDir();
    local _spiralPosistionOffset = 0;

    _is_full = getBooleanNumber(_is_full);
    if getProtocolSides() == 3 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and _is_full) then
        cBarrage(_curSide + _direction, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
        for i = 0, 2, 1 do
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(4 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            _spiralRngLoopDir = getRandomDir();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for i = 0, 2, 1 do
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay((i == 2 and 3 or 4) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _spiralRngLoopDir, customizePatternThickness(1 * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_slopeAmountStart > 0 and _slopeAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _direction;
        for i = 0, 1 do cWall(_curSide + _spiralPosistionOffset + i * _direction, customizePatternThickness(5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end _spiralPosistionOffset = _spiralPosistionOffset + _direction * 2;
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        for a1 = 0, 1 do
            if a1 == 1 then currentTimesOfThickStartAmountForSquare = 7.5; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickStartAmountForSquare * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
        if _iter > 0 then currentTimesAmountForSquare = 2;
            for a = 0, _iter + 1, 1 do --1, _iter + 2
                p_patternEffectCycle();
                _spiralRngLoopDir = getRandomDir();
                cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(6 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        else _spiralRngLoopDir = _direction; currentTimesAmountForSquare = 1;
        end
        for a2 = 0, currentTimesAmountForSquare, 1 do
            currentTimesEndOfThickAmountForSquare = 8.25;
            if a2 == currentTimesAmountForSquare then currentTimesEndOfThickAmountForSquare = 6; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesEndOfThickAmountForSquare * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 2;
        for k = 0, 1 do cWall(_curSide + _spiralPosistionOffset + k * _spiralRngLoopDir, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end 
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 3;
        cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    else
        if (_slopeAmountStart > 0) then
            for fa = 0, _slopeAmountStart, 1 do
                for ia = 0, _slopeAmountStart - fa, 1 do
                    if ia > 0 then cMirrorWallEx(_curSide - (_direction * _pos_spacing * (ia - 1)), _mirror_step, _extra, customizePatternThickness(3 * _delMult * _sizeMult, p_getDelayPatternBool())); end
                end
                cMirrorWallEx(_curSide + (_direction * _pos_spacing * fa) - (_slopeAmountStart * _direction * _pos_spacing), _mirror_step, _extra, customizePatternThickness(_curSpiralThick * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                if fa == _slopeAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _pos_spacing); end
            end
        end
        ---------------------- BEFORE RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + (_direction * _pos_spacing);
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        -------------------------- RANDOM START --------------------------
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            _spiralRngLoopDir = getRandomDir();
            cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        ----------------------- AFTER RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(_curSpiralThick * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            if i == 2 then _spiralPosistionOffset = _spiralPosistionOffset + (_spiralRngLoopDir * _pos_spacing); end
        end
        -------------------------- END OF RANDOM -------------------------
        if (_slopeAmountEnd > 0) then
            for fb = 0, _slopeAmountEnd, 1 do
                for ib = 0, fb, 1 do cMirrorWallEx(_curSide + (_spiralPosistionOffset - (_spiralRngLoopDir * _pos_spacing)) + (_spiralRngLoopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + (fb < _slopeAmountEnd and 1 or 0)) * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osFullWhirlwind(): similiar pattern from Terry's Super Hexagon. same as spiral pattern.
function pMarch31osFullWhirlwind(_side, _iter, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(7, 11)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    p_adjustPatternSettings();

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _spiralLoopDir = _direction;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(thickIncAdj * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
        t_applyPatDel(customizePatternDelay(1.5 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    end
    cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osFullWhirlwindPrototype(): similiar pattern from Terry's Prototype of Super Hexagon. same as spiral pattern.
function pMarch31osFullWhirlwindPrototype(_side, _sizeMult, _direction, _delayMultSpdLessThan, _endAdditionalDelay, _addMult, _spdIsGreaterThanEqual, _skipEndDelay)
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    local currentSizeOverride = 1.25; local spiralPosistionDirMultOffset = 1;

    p_resetPatternDelaySettings();
    p_adjustPatternSettings();

    p_patternEffectStart();

    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _spiralLoopDir = _direction;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(thickIncAdj * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) + 0.5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        if thickDecAdj == getProtocolSides() - 3 then spiralPosistionDirMultOffset = 2; end
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir * spiralPosistionDirMultOffset;
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

-- pMarch31osZigZagSpiral(): taken from baba's line pack, same as spiral pattern
function pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _width, _delMult, _sizeMult, _direction)
    pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, anythingButNil(_iter, u_rndInt(3, 7)), 0, 2, 2, false, false, 0, 0, 1, 1, false, false, 0, 1, false, getBarrageSide(1 + anythingButNil(_width, 2)), nil, 0, nil, _delMult, _sizeMult, _direction)
end

--[ Additional cage barrages ]--

-- pMarch31osXer(): taken from kayden's takarazed pack, made by me
function pMarch31osXer(_side)
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _currentOffset = 1;

    cWall(_curSide, 110);
    t_applyPatDel(getPerfectDelay(THICKNESS) * 2.5);
    for a = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
        cWall(_curSide - _currentOffset);
        cWall(_curSide + _currentOffset);
        _currentOffset = _currentOffset + 1;
        t_applyPatDel(getPerfectDelay(THICKNESS) / 1.2);
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osGrowingBarrage(): taken from baba's old pattern, made by me
function pMarch31osGrowingBarrage(_side)
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _currentOffset = 0;
    local _amountOfGrow = 1;

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    for a = 0, getHalfSides() - 2, 1 do
        p_patternEffectCycle();

        for i = -_amountOfGrow, _amountOfGrow - 1, 1 do cWall(_curSide + i); end
        _amountOfGrow = _amountOfGrow + 1;
        t_applyPatDel(getPerfectDelay(THICKNESS) / 1.2);
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end
