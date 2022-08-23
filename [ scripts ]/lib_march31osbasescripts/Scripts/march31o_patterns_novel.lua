--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void pMarch31osRandomWalls(_side, _thickness, _iter, _mirrorOffset, _extra, _maxstep, _delMult, _sizeMult, _skipEndDelay, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osRandomWalls(_side, _thickness, _iter) --, u_rndIntUpper(2), 0, getHalfSides(), 1, 1, false, 0, 1, 1, 2
    void pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorOffset, _isContained, _maxDist, _delMult, _thickMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult)
    void pMarch31osSnakeBarrage(_side, _thickness, _iter) --, 0, (to be indexed if is nil), true, (calculated), 1, 1, 1, false, false, 0, 1
    void pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _totalThicknessMult, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult)
    void pMarch31osMidCutSpiral(_side, _iter) --, 1, 2, 2, 1, 1, false, false, 0, 1
]]

--[ Novels (Inspired from Kodipher's Inflorescence pack) ]--

function pMarch31osRandomWalls(_side, _thickness, _iter, _mirrorOffset, _extra, _maxstep, _delMult, _sizeMult, _skipEndDelay, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    -- optional args
    _maxstep = anythingButNil(_maxstep, getHalfSides());
    _mirrorOffset = anythingButNil(_mirrorOffset, u_rndIntUpper(2));
    _extra = anythingButNil(_extra, 0);

    --fix negative max step
    _maxstep = math.abs(_maxstep)

    --get delay
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1)

    -- spawn in loop
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cWallMirrorEx(_curSide, _mirrorOffset, _extra, p_getPatternThickness() * _sizeMult);

        t_applyPatDel(customizePatternDelay(2 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
        _curSide = _curSide + u_rndInt(0, _maxstep) * getRandomDir()
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or 0) + (getBooleanNumber(_skipEndDelay) and 0 or getDelaySides(getProtocolSides() / 2)));
end

function pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorOffset, _isContained, _maxDist, _delMult, _thickMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(8, 16)); _extra = anythingButNil(_extra, 0);
    _delMult = anythingButNil(_delMult, 1); _thickMult = anythingButNil(_thickMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _mirrorOffset == nil then
        if u_rndInt(0, 1) == 0 then _mirrorOffset = 1; _extra = 1; else _mirrorOffset = 2; _extra = 0; end
    end
    _isContained = anythingButNil(_isContained, 1);
    _delayMultSpdLessThan = anythingButNil(_delayMultSpdLessThan, 1); _spdIsGreaterThanEqual = anythingButNil(_spdIsGreaterThanEqual, 2);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSideStat) and _side or -256;

    if not _maxDist then 
        _maxDist = math.floor(getProtocolSides() / _mirrorOffset) - 2 - _extra
        _maxDist = math.max(_maxDist, 0)
    end

    _isContained = getBooleanNumber(_isContained);
    if _isContained then
        cWallMirrorEx(_side, _mirrorOffset, _maxDist + _extra, (_thickness or THICKNESS) * _sizeMult);
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _sizeMult);
    end

    _maxDist = math.abs(_maxDist)
    _extra = math.abs(_extra)

    local _sideLimits = {_side, _side + _maxDist}

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cWallMirrorEx(_side, _mirrorOffset, _extra, (_thickness or THICKNESS) * _thickMult * _sizeMult);
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult);
        _side = _side + u_rndInt(0, 1) * getRandomDir();
        _side = closeValue(_side, _sideLimits[1], _sideLimits[2])
    end

    if _isContained then
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult);
        cWallMirrorEx(_sideLimits[1], _mirrorOffset, _maxDist + _extra, (_thickness or THICKNESS) * _sizeMult);
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or 0) + (getBooleanNumber(_skipEndDelay) and 0 or getDelaySides(getProtocolSides() / 2 + 1)));
end

function pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _mirrorOffset, _totalThicknessMult, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- optional args
    _step = anythingButNil(_step, 1);
    _extra = anythingButNil(_extra, 2);
    _mirrorOffset = anythingButNil(_mirrorOffset, 1);
    _totalThicknessMult = anythingButNil(_totalThicknessMult, 2);

    p_resetPatternDelaySettings();_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSideStat) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSideStat) and _side or -256;

    --locals
    local _loopDir = getRandomDir()

    -- negative shift to flip dir
    if (_step < 0) then
        _step = -_step
        _loopDir  = -_loopDir
    end

    local _constructMidCutSpiPart = function(_side, _mirrorOffset, _extra)
        cWallMirrorEx(_side, _mirrorOffset, _extra)
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _sizeMult)
        cWallMirrorEx(_side, _mirrorOffset, _extra)
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult)
    end

    -- new thickness
    local oldThickness = THICKNESS
    THICKNESS = (getAccurateThickness() / 3) * _totalThicknessMult * _sizeMult

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        _constructMidCutSpiPart(_side, _mirrorOffset, _extra)
        _side = _side + _step * _loopDir
    end

    --restore thickness
    THICKNESS = oldThickness

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or 0) + (getBooleanNumber(_skipEndDelay) and 0 or getDelaySides(getProtocolSides() / 2 + 1)));
end
