--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void pMarch31osBarrageLeftRights(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageLeftRights(_side, _thickness, _iter) --, 1, 1, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osRandomBarragesNrepeats(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomBarragesNrepeats(_side, _thickness, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osRandomBarragesNdistance(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomBarragesNdistance(_side, _thickness, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osWallDisplacer(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osWallDisplacer(_side, _thickness, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osAbstractBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAbstractBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osWallExFillerSpiral(_side, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osWallExFillerSpiral(_side) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _exMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _exMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter, _extraHole, _isSpiral, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osCtoCIBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osCtoCIBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osJumbleBarrage(_side, _thickness, _iter, _chance, _delMult, _sizeMult, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osJumbleBarrage(_side, _thickness, _iter) --, getProtocolSides() - 2, 1, 1, 0, 1, 1, 2, false, false
    void pMarch31osSprayBarrage(_side, _thickness, _iter, _delay, _extra, _delMult, _sizeMult, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osSprayBarrage(_side, _thickness, _iter) --, 4, 2, 1, 1, 0, 1, 1, 2, false, false
    void pMarch31osOddAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osOddAltBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osEvenAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osEvenAltBarrage(_side, _thickness, _iter) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osAltHalfBarrage(_side, _thickness, _iter, _extraWalls, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAltHalfBarrage(_side, _thickness, _iter) --, 0, 1, 1, 0, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osAltTrapBarrage(_side, _thickness, _iter, _gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAltTrapBarrage(_side, _thickness, _iter) --, 1, 1, 1, getRandomDir(), 0, getRandomDir(), 1, false, 0, 1, 1, 2, false, false
    void pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter, _sidedir1Neighbors, _sidedirmin1Gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter) --, 0, 1, 1, 1, getRandomDir(), 0, getRandomDir(), 1, false, 0, 1, 1, 2, false, false

    void pMarch31osRandomWhirlwind(_side, _iter, _extra, _step, _pos_spacing, _delMult, _sizeMult, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomWhirlwind(_side, _iter) --0, math.floor(getProtocolSides() / 3), 1, 1, 1, getRandomDir(), 0, false, 0, 1, 1, 2, false, false
    void pMarch31osFullWhirlwind(_side, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osFullWhirlwind(_side, _iter) --, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osFullWhirlwindPrototype(_side, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osFullWhirlwindPrototype(_side) --, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _width, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false

    void pMarch31osXer(_side, _isRebootingSide, _endAdditionalDelay, _skipEndDelay)
    void pMarch31osXer(_side) --, false, 0, false
    void pMarch31osGrowingBarrage(_side, _isRebootingSide, _endAdditionalDelay, _skipEndDelay)
    void pMarch31osGrowingBarrage(_side) --, false, 0, false
]]

--[ Barrages ]--

function pMarch31osBarrageLeftRights(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 1, anythingButNil(_distance, 1), _loopDir, false, (getBooleanNumber(_isDelayDistance) and (anythingButNil(_distance, 1) * 0.333 + 0.667) or 1) * _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osRandomBarragesNrepeats(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(vbnmk_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    warnF(true, "PatternDeprecation", "'pMarch31osBarrageLeftRights' is deprecated.\nthis pattern will be removed in this update.\nplease use 'pMarch31osRandomBarrages' instead.", ...)
    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageOffset = u_rndIntUpper(math.floor(getProtocolSides() / 2) + 1);
    local _barrageOldOffset = 0
    local _barrageDistanceDelay = _barrageOffset - _barrageOldOffset

    for a = 0, _iter, 1 do
        for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end
        _barrageOldOffset = _barrageOffset
        repeat _barrageOffset = u_rndIntUpper(math.floor(getProtocolSides() / 2) + 1);
        until _barrageOffset ~= _barrageOldOffset
        _barrageDistanceDelay = _barrageOffset - _barrageOldOffset
        if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1 end
        t_applyPatDel(customizePatternDelay((3 * _barrageDistanceDelay) * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult, _sizeMult, p_getDelayPatternBool()))
    end
    for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _barrageOffset, p_getPatternThickness() * _sizeMult); end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osRandomBarragesNdistance(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cBarrage(_curSide + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), p_getPatternThickness() * _sizeMult);

        t_applyPatDel(customizePatternDelay(6 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult, _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

-- taken from alphapatterns.lua's Vexatious pack by AlphaPromethium
function pMarch31osWallDisplacer(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
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

        t_applyPatDel(customizePatternDelay(3.6 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osDoubleBarrageSpiralAcross(_side, _thickness, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageOffset = 0;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do
        p_patternEffectCycle();

        if (a % (math.floor(getProtocolSides() / 2) * 2)) == 0 then cBarrage(_side, p_getPatternThickness() * _sizeMult); _barrageOffset = 0
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) > 0 and (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) then cBarrageDoubleHoled(_side - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset + 2
        elseif (a % (math.floor(getProtocolSides() / 2) * 2)) >= math.floor(getProtocolSides() / 2) and (a % (math.floor(getProtocolSides() / 2) * 2)) < math.floor(getProtocolSides() / 2) * 2 then cBarrageDoubleHoled(_side - (_barrageOffset / 2), _barrageOffset, 0, p_getPatternThickness() * _sizeMult); _barrageOffset = _barrageOffset - 2
        end
        t_applyPatDel(customizePatternDelay(3.6 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()))
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osAbstractBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageLoopDir = _loopDir;

    for a = 0, (math.floor(getProtocolSides() / 2) * 2) * _iter, 1 do
        p_patternEffectCycle();

        cWall(_curSide + a, p_getPatternThickness() * _sizeMult);
        cWall(_curSide - a, p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osWallExFillerSpiral(_side, _thickness, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageLoopDir = _loopDir;

    for a = 0, getProtocolSides() - 2, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then cWallEx(_curSide + a, a, p_getPatternThickness() * _sizeMult);
        else cWallEx(_curSide - (a * 2), a, p_getPatternThickness() * _sizeMult);
        end

        t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osDoubleHoledBarrageSpiral(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _exMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), 0, anythingButNil(_exMult, 1), _loopDir, false, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osDoubleHoledBarrageLeftRights(_side, _thickness, _iter, _extraHole, _delMult, _sizeMult, _exMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), 1, anythingButNil(_exMult, 1), _loopDir, false, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osDoubleHoledBarrageInversions(_side, _thickness, _iter, _extraHole, _isSpiral, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, anythingButNil(_iter, u_rndInt(4, 5)), 1, 2 + anythingButNil(_extraHole, 0), (getBooleanNumber(_isSpiral) and 0) or 2, (getBooleanNumber(_isSpiral) and math.floor(getProtocolSides() / 2)) or 1, _loopDir, false, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osCtoCIBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageLoopDir = _loopDir;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
        else cBarrageExHoles(_curSide, 1, p_getPatternThickness() * _sizeMult);
        end

        _barrageLoopDir = _barrageLoopDir * -1
        t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osJumbleBarrage(_side, _thickness, _iter, _chance, _delMult, _sizeMult, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _chance = anythingButNil(_chance, getProtocolSides() - 2);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, _chance, 1 do cWall(_side + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), p_getPatternThickness() * _sizeMult); end
        t_applyPatDel(customizePatternDelay(2.75 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osSprayBarrage(_side, _thickness, _iter, _delay, _extra, _delMult, _sizeMult, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = u_rndInt(0, 1); end
    if _loopDir < 0 then _loopDir = 0 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);

    for a = 0, _iter, 1 do
        cWallEx(_side + u_rndInt(0, getProtocolSides() - 1) % getProtocolSides(), u_rndInt(0, _extra or 2), p_getPatternThickness() * _sizeMult);
        t_applyPatDel(customizePatternDelay((_delay or 4) * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osOddAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();
    
    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = -1;
    local _barrageLoopDir = _loopDir;

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
        t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osEvenAltBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDirAlt = 0;
    local _barrageLoopDir = _loopDir;

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
        t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osAltHalfBarrage(_side, _thickness, _iter, _extraWalls, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _extraWalls = anythingButNil(_extraWalls, 0);
    if not _extraWalls or _extraWalls < 0 then _extraWalls = 0; end
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDir = _loopDir;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir > 0 then
            for i = 1, getHalfSides() + _extraWalls, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        else
            for i = getHalfSides() + 1, getProtocolSides() + _extraWalls, 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.7 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osAltTrapBarrage(_side, _thickness, _iter, _gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _gap = anythingButNil(_gap, 1); _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
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
        t_applyPatDel(customizePatternDelay(3.6 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osCustomizedAltTrapBarrage(_side, _thickness, _iter, _sidedir1Neighbors, _sidedirmin1Gap, _delMult, _sizeMult, _barrageDir, _offsetType, _offsetMult, _offsetDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _sidedir1Neighbors = anythingButNil(_sidedir1Neighbors, 0); _sidedirmin1Gap = anythingButNil(_sidedirmin1Gap, 1); _offsetType = anythingButNil(_offsetType, 0);
    if _barrageDir == nil or _barrageDir == 0 or _barrageDir < -1 or _barrageDir > 1 then _barrageDir = -1; end
    if _offsetDir == nil or _offsetDir == 0 or _offsetDir < -1 or _offsetDir > 1 then _offsetDir = getRandomDir(); end
    if _offsetMult == nil or _offsetMult == 0 or _offsetMult < 0 then _offsetMult = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _barrageLoopDir = _barrageDir;
    local _offsetLoopDir = math.ceil(_offsetDir);

    local _typeModeModuloStat = (_offsetType == 1 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 0 and 0) or (_offsetType == 3 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 0 and 0) or (_offsetType == 3 and 0) or _offsetMult;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _barrageLoopDir < 0 then cBarrageN(_curSide + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir), _sidedir1Neighbors, p_getPatternThickness() * _sizeMult);
        elseif _barrageLoopDir > 0 then cWallGrow(_curSide + (((math.floor(a * 0.5)) % _typeModeModuloStat) * _typeModeStat * _typeModeMultStat * _offsetLoopDir), _sidedirmin1Gap, p_getPatternThickness() * _sizeMult);
        end
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Spirals ]--

-- pMarch31osRandomWhirlwind: spawns a spiral of using cWallExThick like the pattern from Hexagonest, Hyper Hexagoner and Hyper Hexagonest but always randomizes the direction. (Spin 2 Failure)
function pMarch31osRandomWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _sizeMult, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(6, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extra = anythingButNil(_extra, 0); _mirror_step = anythingButNil(_mirror_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    _loopDir = (type(_loopDir) == "number" and getNeg(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    if not _cleanAmountStart or _cleanAmountStart < 0 then _cleanAmountStart = 0; end
    if not _cleanAmountEnd or _cleanAmountEnd < 0 then _cleanAmountEnd = _cleanAmountStart; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfDelayAmountForTriangle = 4;
    local currentTimesOfThickStartAmountForSquare, currentTimesEndOfThickAmountForSquare, currentTimesOfThickAmountForGreaterThanSquare = 6, 8.25, 2;
    local currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = 3 * (getBooleanNumber(_seamless) and 1.1 or 1) * ((_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentSizeOverride, currentDelayOverride = 1.25, 0.9;
    local currentTimesOfThickAmount = 2;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _spiralRngLoopDir = getRandomDir();
    local _spiralPosistionOffset = 0;

    _is_full = getBooleanNumber(_is_full);
    if getProtocolSides() == 3 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and _is_full) then
        cBarrage(_curSide + _loopDir, customizePatternThickness(1 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        for i = 0, 2, 1 do
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            _spiralRngLoopDir = getRandomDir();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        for i = 0, 2, 1 do
            if i == 2 then currentTimesOfDelayAmountForTriangle = 3; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _spiralRngLoopDir, customizePatternThickness(1 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
        for i = 0, 1 do cWall(_curSide + _spiralPosistionOffset + i * _loopDir, customizePatternThickness(5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 2;
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        for a1 = 0, 1 do
            if a1 == 1 then currentTimesOfThickStartAmountForSquare = 7.5; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickStartAmountForSquare * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
        if _iter > 0 then currentTimesAmountForSquare = 2;
            for a = 0, _iter + 1, 1 do --1, _iter + 2
                p_patternEffectCycle();
                _spiralRngLoopDir = getRandomDir();
                cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        else _spiralRngLoopDir = _loopDir; currentTimesAmountForSquare = 1;
        end
        for a2 = 0, currentTimesAmountForSquare, 1 do
            currentTimesEndOfThickAmountForSquare = 8.25;
            if a2 == currentTimesAmountForSquare then currentTimesEndOfThickAmountForSquare = 6; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesEndOfThickAmountForSquare * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 2;
        for k = 0, 1 do cWall(_curSide + _spiralPosistionOffset + k * _spiralRngLoopDir, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end 
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * 3;
        cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    else
        if (_cleanAmountStart > 0) then
            for fa = 0, _cleanAmountStart, 1 do
                for ia = 0, _cleanAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_loopDir * _pos_spacing * (ia - 1)), _step, _extra, customizePatternThickness(3 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_loopDir * _pos_spacing * fa) - (_cleanAmountStart * _loopDir * _pos_spacing), _step, _extra, customizePatternThickness(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                if fa == _cleanAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            end
        end
        ---------------------- BEFORE RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizePatternThickness(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        -------------------------- RANDOM START --------------------------
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            _spiralRngLoopDir = getRandomDir();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizePatternThickness(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        ----------------------- AFTER RANDOM STARTS ----------------------
        for i = 0, 2, 1 do
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizePatternThickness(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _spiralRngLoopDir * _pos_spacing;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            if i == 2 then _spiralPosistionOffset = _spiralPosistionOffset + (_spiralRngLoopDir * _pos_spacing); end
        end
        -------------------------- END OF RANDOM -------------------------
        if (_cleanAmountEnd > 0) then
            for fb = 0, _cleanAmountEnd, 1 do
                if fb == _cleanAmountEnd then currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = _curSpiralThick; end
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_spiralRngLoopDir * _pos_spacing)) + (_spiralRngLoopDir * _pos_spacing * ib), _step, _extra, customizePatternThickness(currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0); t_applyPatDel(customizePatternDelay(2 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osFullWhirlwind(_side, _iter, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(7, 11)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _spiralLoopDir = _loopDir;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(thickIncAdj * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
        t_applyPatDel(customizePatternDelay(1.5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    end
    cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osFullWhirlwindPrototype(_side, _sizeMult, _loopDir, _delayMultSpdLessThan, _endAdditionalDelay, _addMult, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    _sizeMult = anythingButNil(_sizeMult, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentSizeOverride = 1.25; local spiralPosistionDirMultOffset = 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _spiralLoopDir = _loopDir;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(thickIncAdj * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizePatternDelay((getProtocolSides() - 2) + 0.5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        if thickDecAdj == getProtocolSides() - 3 then spiralPosistionDirMultOffset = 2; end
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness((getProtocolSides() - thickDecAdj) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir * spiralPosistionDirMultOffset;
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osZigZagSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _width, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, anythingButNil(_iter, u_rndInt(3, 7)), 0, 2, 2, false, 0, nil, 1, 1, false, false, 0, 1, false, getBarrageSide(1 + anythingButNil(_width, 2)), nil, 0, nil, _delMult, _sizeMult, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
end

--[ Additional cage barrages ]--

function pMarch31osXer(_side, _isRebootingSide, _endAdditionalDelay, _skipEndDelay)
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osGrowingBarrage(_side, _isRebootingSide, _endAdditionalDelay, _skipEndDelay)
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
