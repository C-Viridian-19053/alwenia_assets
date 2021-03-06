--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void pMarch31osRandomWalls(_side, _thickness, _iter, _mirrorOffset, _extra, _maxstep, _delMult, _scale, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _skipEndDelay)
    void pMarch31osRandomWalls(_side, _thickness, _iter) --, u_rndIntUpper(2), 0, getHalfSides(), 1, 1, 0, 1, 1, 2, false, false
    void pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorOffset, _isContained, _maxDist, _delMult, _thickMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _skipEndDelay)
    void pMarch31osSnakeBarrage(_side, _thickness, _iter) --, 0, (to be indexed if is nil), true, (calculated), 1, 1, 1, false, 0, 1, false
    void pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _totalThicknessMult, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _skipEndDelay)
    void pMarch31osMidCutSpiral(_side, _iter) --, 1, 2, 2, 1, 1, false, 0, 1, false
]]

--[ Novels (Inspired from Kodipher's Inflorescence pack) ]--

function pMarch31osRandomWalls(_side, _thickness, _iter, _mirrorOffset, _extra, _maxstep, _delMult, _scale, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

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

        cWallMirrorEx(_curSide, _mirrorOffset, _extra, p_getTunnelPatternCorridorThickness() * _scale);

        t_applyPatDel(customizePatternDelay(2 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()))
        _curSide = _curSide + u_rndInt(0, _maxstep) * getRandomDir()
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    -- end delay (optional arg, default false)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getDelaySides(getProtocolSides() / 2)) end
end

function pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorOffset, _isContained, _maxDist, _delMult, _thickMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _skipEndDelay)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(8, 16)); _extra = anythingButNil(_extra, 0);
    _delMult = anythingButNil(_delMult, 1); _thickMult = anythingButNil(_thickMult, 1); _scale = anythingButNil(_scale, 1);
    if _mirrorOffset == nil then
        if u_rndInt(0, 1) == 0 then _mirrorOffset = 1; _extra = 1; else _mirrorOffset = 2; _extra = 0; end
    end
    _isContained = anythingButNil(_isContained, 1);
    _thickMult_nonSpd = anythingButNil(_thickMult_nonSpd, 1); _spdIs_greaterThanEqual = anythingButNil(_spdIs_greaterThanEqual, 2);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _side or -256;

    if not _maxDist then 
        _maxDist = math.floor(getProtocolSides() / _mirrorOffset) - 2 - _extra
        _maxDist = math.max(_maxDist, 0)
    end

    _isContained = getBooleanNumber(_isContained);
    if _isContained then
        cWallMirrorEx(_side, _mirrorOffset, _maxDist + _extra, (_thickness or THICKNESS) * _scale);
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _scale);
    end

    _maxDist = math.abs(_maxDist)
    _extra = math.abs(_extra)

    local _sideLimits = {_side, _side + _maxDist}

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cWallMirrorEx(_side, _mirrorOffset, _extra, (_thickness or THICKNESS) * _thickMult * _scale);
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _scale);
        _side = _side + u_rndInt(0, 1) * getRandomDir();
        _side = closeValue(_side, _sideLimits[1], _sideLimits[2])
    end

    if _isContained then
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _scale);
        cWallMirrorEx(_sideLimits[1], _mirrorOffset, _maxDist + _extra, (_thickness or THICKNESS) * _scale);
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getDelaySides(getProtocolSides() / 2 + 1)) end
end

function pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _mirrorOffset, _totalThicknessMult, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _skipEndDelay)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- optional args
    _step = anythingButNil(_step, 1);
    _extra = anythingButNil(_extra, 2);
    _mirrorOffset = anythingButNil(_mirrorOffset, 1);
    _totalThicknessMult = anythingButNil(_totalThicknessMult, 2);

    p_resetPatternDelaySettings();
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _side or -256;

    --locals
    local _loopDir = getRandomDir()

    -- negative shift to flip dir
    if (_step < 0) then
        _step = -_step
        _loopDir  = -_loopDir
    end

    local _constructMidCutSpiPart = function(_side, _mirrorOffset, _extra)
        cWallMirrorEx(_side, _mirrorOffset, _extra)
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _scale)
        cWallMirrorEx(_side, _mirrorOffset, _extra)
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _scale)
    end

    -- new thickness
    local oldThickness = THICKNESS
    THICKNESS = (getAccurateThickness() / 3) * _totalThicknessMult * _scale

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        _constructMidCutSpiPart(_side, _mirrorOffset, _extra)
        _side = _side + _step * _loopDir
    end

    --restore thickness
    THICKNESS = oldThickness

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    -- end delay (optional arg, default false)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getDelaySides(getProtocolSides() / 2 + 1)) end
end
