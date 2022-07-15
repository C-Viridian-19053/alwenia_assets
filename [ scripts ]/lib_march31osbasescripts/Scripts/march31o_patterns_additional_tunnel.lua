--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void pMarch31osAlternatingBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAlternatingBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osRandomBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _delMult, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, true, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osRandomBarrageNdistanceTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomBarrageNdistanceTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, false, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osJumbleTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _chance, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osJumbleTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, false, getProtocolSides() - 3, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWallsDistanceMax, _isDistanceTight, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, u_rndIntUpper(getProtocolSides() - 2), true, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osTrapBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeGrowWalls, _growWallClawAdd, _growWallCapAdd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osTrapBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, 1, 1, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osBarrageSpiralTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _revFreq, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageSpiralTunnel(_side, _corridorThickNonSpd, _corridorThickSpd) --, 0, 2, 1, false, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeGrowWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, false, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osLRTunnelShortSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _designType, _largeWalls, _isLargeWallOnce, _isHardMode, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osLRTunnelShortSpiral(_side, _corridorThickNonSpd, _corridorThickSpd) --, 2, 1, false, false, 0, 1, 1, false, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osBackAndForthTunnelAxis(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBackAndForthTunnelAxis(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osBackAndForthTunnelCentral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBackAndForthTunnelCentral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 0, 2, 0, 0, 0, 0, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
]]

--[ Commons ]--

local _constructDesignCWallExPart = function(_side, _designType, _extra, _thickness)
    if _designType <= 1 and _extra > 1 then
        for i = 0, 1, 1 do cWall(_side + (i * _extra), _thickness); end
    else cWallEx(_side, _extra, _thickness);
    end
end

local _constructDesignLargGrowWallPart = function(_side, _designType, _extra, _thickness)
    if _designType <= 1 and _extra > 0 then cWall(_side + _extra, _thickness); cWall(_side - _extra, _thickness);
    else cWallGrow(_side, _extra, _thickness);
    end
end

local _constructTunnelGearTeethCorridorFixPart = function(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _thickness)
    local _tunnelGearTeethStep = 0;
    local _tunnelGearTeethAmount = 1;
    local _tunnelGearTeethInc = 0;

    for tAmount = 0, _thick_inc, 1 do
        if tAmount < _thick_inc - _thick_mult_step_limit then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
            if _tunnelGearTeethStep >= _thick_mult_step then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _thick_mult) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
        end
    end

    cWallEx(_side, _extra, _thickness + _tunnelGearTeethInc);
end

local _constructTunnelGearTeethCorridorFixDesignPart = function(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _largeThickness, _thickness, _gearTeethSizeMult)
    if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_side, _thick_mult_step, _thick_mult_step_limit, _extra, _thick_inc, _thick_mult, _largeThickness);
    else cWallEx(_side, _extra, _thickness);
    end
end

local _constructBAFTunnelLargeWallPart = function(_side, _freqAmount, _freqCount, _largeWallThick, _corridorThick, _isLargeWallThickSpdMode, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _scale, _designType)
    _repeatCorridorAmount = _repeatCorridorAmount or 0;
    _repeatCorridorDelay = _repeatCorridorDelay or 0;
    if (getProtocolSides() > 5) then
        for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_side + (i * 3), customizePatternThickness(_largeWallThick * _scale, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _scale, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _scale)); end
    end
    if (getProtocolSides() % 3 > 0) then
        if (_designType <= 1) then
            for i = 0, 1, 1 do cWall(_side - (i * (getProtocolSides() % 3)), customizePatternThickness(_largeWallThick * _scale, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _scale, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _scale)); end
            if (_designType == 0 and getProtocolSides() % 3 == 2) and _freqCount == 0 then cWall(_side - 1, _corridorThick * _scale); end
            if (_designType == 1 and getProtocolSides() % 3 == 2) then cWall(_side - 1, _corridorThick * _scale); end
        else
            for i = 1, getProtocolSides() % 3, 1 do cWall(_side - i, customizePatternThickness(_largeWallThick * _scale, _isLargeWallThickSpdMode) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * _freqAmount)) * _scale, _isRepeatCorridorDelaySpd) + ((_corridorThick / 2) * _scale)); end
        end
    end
end

--[ Tunnels ]--

-- baba's inspired patterns
function pMarch31osAlternatingBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _designType = anythingButNil(_designType, 2); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 or _loopDir == 0 then _loopDir = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = getRandomDir();
    local _tunnelOffset = _tunnelLoopDir;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide + 1, _designType, _largeWalls - 1, customizePatternThickness(3.9 * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide + 1, _designType, _largeWalls - 1, customizePatternThickness(3.9 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            if (_designType == 1 and _largeWalls > 1) or (_designType < 1 and a == 0) then cWallEx(_curSide + 1, _largeWalls - 1, p_getTunnelPatternCorridorThickness() * _scale); end
        else cWallEx(_curSide + 1, _largeWalls - 1, p_getTunnelPatternCorridorThickness() * _scale);
        end

        for i = 1, getProtocolSides() - _largeWalls, 1 do
            if _tunnelOffset > 0 then cWall(i + _curSide + _largeWalls, p_getTunnelPatternCorridorThickness() * _scale); end
            _tunnelOffset = _tunnelOffset * -1;
        end

        _tunnelLoopDir = _tunnelLoopDir * -1; _tunnelOffset = _tunnelLoopDir;
        t_applyPatDel(customizePatternDelay(3.9 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osAlternatingTunnel = pMarch31osAlternatingBarrageTunnel

function pMarch31osRandomBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isRepeat, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _designType = anythingButNil(_designType, 2); _largeWalls = anythingButNil(_largeWalls, 1); _isRepeat = anythingButNil(_isRepeat, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelOldOffset = 0;
    local _tunnelOffset = 0;
    local _tunnelDistanceDelay = 0;
	

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if _designType == 0 and a > 0 then
            for i = _largeWalls, getProtocolSides(), 1 do
                if i ~= _tunnelOffset + _largeWalls then cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
            end
        else
            for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _tunnelOffset + _largeWalls, p_getTunnelPatternCorridorThickness() * _scale); end
        end
        _tunnelOldOffset = _tunnelOffset; _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
        if (not _isRepeat) then
             repeat _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
             until _tunnelOffset ~= _tunnelOldOffset
        else _tunnelOffset = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
        end
        _tunnelDistanceDelay = _tunnelOldOffset - _tunnelOffset;

        if _tunnelDistanceDelay < 0 then _tunnelDistanceDelay = _tunnelDistanceDelay * -1; end

        _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness((3 * (6 / getProtocolSides()) * p_getDelayPatternThickMultOfNoSpdMultMode()) * _curDelaySpeed * _delMult * _scale * (_tunnelDistanceDelay / 1.25) + 1.25, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
        t_applyPatDel(customizePatternDelay((3 * (6 / getProtocolSides()) * p_getDelayPatternThickMultOfNoSpdMultMode()) * _curDelaySpeed * _delMult * _scale * (_tunnelDistanceDelay / 1.25) + 1.25, p_getDelayPatternBool()));
    end

    for i = 1, getBarrageSide(), 1 do cWall(i + _curSide + _tunnelOffset + _largeWalls, p_getTunnelPatternCorridorThickness()); end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osRandomTunnel = pMarch31osRandomBarrageTunnel;

function pMarch31osRandomBarrageNdistanceTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _designType = anythingButNil(_designType, 2); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _randomizeSidePosFix = 0;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(5 * ((getProtocolSides() / 9) + 0.75) * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
    end

    for a = 0, _iter, 1 do
        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(5 * ((getProtocolSides() / 9) + 0.75) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        end
        if _designType == 0 and (a > 0 and a < _iter) then
            _randomizeSidePosFix = u_rndInt(0, getProtocolSides() - (_largeWalls + 1));
            for i = _largeWalls, getProtocolSides(), 1 do
                if i ~= _largeWalls + _randomizeSidePosFix then cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
            end
        else cBarrage(_curSide + u_rndInt(_largeWalls, getProtocolSides() - 1), p_getTunnelPatternCorridorThickness() * _scale);
        end
        if a < _iter then t_applyPatDel(customizePatternDelay(5 * ((getProtocolSides() / 9) + 0.75) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osRandomNdistanceTunnel = pMarch31osRandomBarrageNdistanceTunnel;

function pMarch31osJumbleTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWalls, _isLargeWallOnce, _chance, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _designType = anythingButNil(_designType, 2); _chance = anythingButNil(_chance, getProtocolSides() - 4); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1.4); _scale = anythingButNil(_scale, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(2.75 * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a < _iter then
            if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(2.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        else cWallEx(_curSide, _largeWalls - 1, p_getTunnelPatternCorridorThickness() * _scale);
        end

        if _designType == 0 and a == 0 then cWallEx(_curSide, _largeWalls - 1, p_getTunnelPatternCorridorThickness() * _scale);
        elseif _designType > 0 and a < _iter then cWallEx(_curSide, _largeWalls - 1, p_getTunnelPatternCorridorThickness() * _scale);
        end

        for c = 1, _chance, 1 do cWall(_curSide + u_rndInt(_largeWalls, getProtocolSides() - 1), p_getTunnelPatternCorridorThickness() * _scale); end

        t_applyPatDel(customizePatternDelay(2.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osRandomizationLargeWallsTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeWallsDistanceMax, _isDistanceTight, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 4)); _designType = anythingButNil(_designType, 2); _largeWallsDistanceMax = anythingButNil(_largeWallsDistanceMax, getProtocolSides() - 2); _isDistanceTight = anythingButNil(_isDistanceTight, 1); _delMult = anythingButNil(_delMult, 1.4); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _largeWallsDistanceMax < 1 or _largeWallsDistanceMax > getProtocolSides() - 2 then _largeWallsDistanceMax = getProtocolSides() - 2; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelOffset = 0;
    local _tunnelLoopDir = _loopDir;
    local _tunnelDistance = u_rndIntUpper(_largeWallsDistanceMax);
    local _QUOS = _tunnelLoopDir * 0.5 + 0.5;
    local _curTunnelDel = 0;
    local _amountCurDistanceActivate = 0;

    _isDistanceTight = getBooleanNumber(_isDistanceTight);
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for i = 1, getProtocolSides() - 2, 1 do cWall(_curSide + i + _tunnelOffset + _QUOS, p_getTunnelPatternCorridorThickness() * _scale); end

        _tunnelLoopDir = _tunnelLoopDir * -1;
        _QUOS = _tunnelLoopDir * 0.5 + 0.5;
        _tunnelDistance = u_rndIntUpper(_largeWallsDistanceMax);

        if _isDistanceTight then _curTunnelDel = 4 * (6 / getProtocolSides()); _amountCurDistanceActivate = _tunnelDistance * 0.5 + 0.5; else _curTunnelDel = 9; _amountCurDistanceActivate = 1; end

        if a < _iter then
            if _designType <= 1 then
                cWall(_curSide + 1 * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                cWall(_curSide + ((getProtocolSides() - 1) - _tunnelDistance) * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
            else
                for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, customizePatternThickness(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale * (_amountCurDistanceActivate), p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            end
            t_applyPatDel(customizePatternDelay(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale * (_amountCurDistanceActivate), p_getDelayPatternBool()));
            for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, p_getTunnelPatternCorridorThickness() * _scale); end
        elseif a == _iter then
            for i = 1, (getProtocolSides() - 1) - _tunnelDistance, 1 do cWall(_curSide + i * -_tunnelLoopDir + _tunnelOffset, p_getTunnelPatternCorridorThickness() * _scale); end
        end

        _tunnelOffset = _tunnelOffset + _tunnelLoopDir * _tunnelDistance;
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osTunnels = pMarch31osRandomizationLargeWallsTunnel;

function pMarch31osTrapBarrageTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeGrowWalls, _growWallClawAdd, _growWallCapAdd, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _designType = anythingButNil(_designType, 2); _largeGrowWalls = anythingButNil(_largeGrowWalls, 1); _delMult = anythingButNil(_delMult, 1.4); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = _loopDir;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _designType, _largeGrowWalls - 1, customizePatternThickness(4.75 * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, myResultBool) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle(_curSide, _designType, _largeGrowWalls - 1, customizePatternThickness(4.75 * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, myResultBool) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));

        if a < _iter then
			if (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignLargGrowWallPart(_curSide, _designType, _largeGrowWalls - 1, customizePatternThickness(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, myResultBool) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        elseif a == _iter then cWallGrow(_curSide, _largeGrowWalls - 1, p_getTunnelPatternCorridorThickness() * _scale);
        end

        if (a + _tunnelLoopDir) % 2 == 1 then
            if _designType == 0 and (a > 0 and a < _iter) then
                for i = ((_largeGrowWalls - 1) * -1) - _growWallClawAdd, (_largeGrowWalls - 1) * -1, 1 do cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
                for i = (_largeGrowWalls - 1), (_largeGrowWalls - 1) + _growWallClawAdd, 1 do cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
            else cWallGrow(_curSide, _growWallClawAdd + (_largeGrowWalls - 1), p_getTunnelPatternCorridorThickness() * _scale);
            end
        else
            if _designType == 1 and (a + _tunnelLoopDir) % 2 == 0 then cWallGrow(_curSide, _largeGrowWallExtra, p_getTunnelPatternCorridorThickness() * _scale); end
            if getProtocolSides() % 2 == 1 then
                for i = -_growWallCapAdd + 1, _growWallCapAdd, 1 do cWall(_curSide + i + math.floor(getProtocolSides() / 2), p_getTunnelPatternCorridorThickness() * _scale); end
            else cWallGrow(_curSide + math.floor(getProtocolSides() / 2), _growWallCapAdd, p_getTunnelPatternCorridorThickness() * _scale);
            end
        end

        t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, myResultBool));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBarrageSpiralTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _revFreq, _designType, _largeWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _revFreq = anythingButNil(_revFreq, 0); _designType = anythingButNil(_designType, 1); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 or _loopDir == 0 then _loopDir = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = _loopDir;
    local _tunnelOffset = (_tunnelLoopDir > 0 and _largeWalls) or getProtocolSides() - 1;

    for r = 0, _revFreq, 1 do
        --for larger wall once 
        local _amountOfRevFreqUntilEnd = (r == _revFreq and 0) or 1;

        if (getBooleanNumber(_isLargeWallOnce)) and r == 0 then
            _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(4.75 * (getProtocolSides() - (_largeWalls + _amountOfRevFreqUntilEnd)) * (_revFreq + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
        end

        for a = 1, getProtocolSides() - (_largeWalls + _amountOfRevFreqUntilEnd), 1 do
            p_patternEffectCycle();

            if a < getProtocolSides() - _largeWalls and (not getBooleanNumber(_isLargeWallOnce)) then
                _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
            end

            if _designType == 0 and (a > _amountOfRevFreqUntilEnd and a < getProtocolSides() - _largeWalls) then
                for i = _largeWalls, getProtocolSides(), 1 do
                    if i ~= _tunnelOffset then cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
                end
            else cBarrage(_curSide + _tunnelOffset, p_getTunnelPatternCorridorThickness() * _scale);
            end
            t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));

            _tunnelOffset = _tunnelOffset + _tunnelLoopDir;
        end

        _tunnelLoopDir = -_tunnelLoopDir
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osSideTunnel = pMarch31osBarrageSpiralTunnel;

function pMarch31osDoubleBarrageSpiralAcrossTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _largeGrowWalls, _isLargeWallOnce, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(1, 4)); _designType = anythingButNil(_designType, 2); _largeGrowWalls = anythingButNil(_largeGrowWalls, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 or _loopDir == 0 then _loopDir = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelOffset = (_tunnelLoopDir > 0 and (2 * (_largeGrowWalls - 1))) or (math.floor(getProtocolSides() / 2) * 2) - 2;
    local _tunnelLoopDir = _loopDir;

    --for larger wall once 
    if (getBooleanNumber(_isLargeWallOnce)) then
        _constructDesignCWallExPart(_curSide, _designType, _largeGrowWalls - 1, customizePatternThickness(3.6 * ((math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter)) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale))
    end

    for a = 0, (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter), 1 do
        p_patternEffectCycle();
        if a < (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter) and (not getBooleanNumber(_isLargeWallOnce)) then _constructDesignLargGrowWallPart(_curSide, _designType, _largeGrowWalls - 1, customizePatternThickness(3.6 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        if _designType == 0 and (a > 0 and a < (math.floor(getProtocolSides() / 2) * _iter) - _iter - ((_largeGrowWalls - 1) * _iter)) then
            for i = _largeGrowWalls, math.floor(getProtocolSides() / 2) + ((getProtocolSides() % 2) - 1), 1 do
                if i ~= math.floor(_tunnelOffset / 2) + 1 then cWall(_curSide + i, p_getTunnelPatternCorridorThickness() * _scale); end
            end
            for j = math.ceil(getProtocolSides() / 2), getProtocolSides() - 1, 1 do
                if j ~= (getProtocolSides() - 1) - math.floor(_tunnelOffset / 2) then cWall(_curSide + j, p_getTunnelPatternCorridorThickness() * _scale); end
            end
        else cBarrageDoubleHoled(_curSide - (_tunnelOffset / 2), _tunnelOffset, 0, p_getTunnelPatternCorridorThickness() * _scale);
        end
        if (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) >= 0 and (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) < math.floor(getProtocolSides() / 2) - _largeGrowWalls then _tunnelOffset = _tunnelOffset + 2
        elseif (a % ((math.floor(getProtocolSides() / 2) * 2) - (_largeGrowWalls * 2))) >= math.floor(getProtocolSides() / 2) - _largeGrowWalls then _tunnelOffset = _tunnelOffset - 2
        end
        t_applyPatDel(customizePatternDelay(3.6 * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _curDelaySpeed, p_getDelayPatternBool()))
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osDoubleSideAcrossTunnel = pMarch31osDoubleBarrageSpiralAcrossTunnel;

function pMarch31osLRTunnelShortSpiral(_side, _corridorThickNonSpd, _corridorThickSpd, _designType, _largeWalls, _isLargeWallOnce, _isHardMode, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _designType = anythingButNil(_designType, 2); _largeWalls = anythingButNil(_largeWalls, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 or _loopDir == 0 then _loopDir = getRandomDir(); end
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelOffset = (_loopDir < 0 and getProtocolSides()) or 0;
    local _tunnelLoopDir = _loopDir;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin = 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    local _constructLRTunShoSpiPart = function(_side, _extra, _gearTeethStepDir)
        if _gearTeethSizeMult > 0 then cWallTkns(_side, _gearTeethStepDel, _gearTeethStepLimit, _extra, _gearTeethStepDir, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
        else cWallEx(_side, _extra, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
        end
    end

    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin);
    _isHardMode = getBooleanNumber(_isHardMode) and 1 or 0

    for a = 2, getProtocolSides() - (_largeWalls + 1), 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end

        --for larger wall once 
        if (getBooleanNumber(_isLargeWallOnce)) then
            if a == 2 then _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness((4.75 * ((getProtocolSides() * 2) - (_largeWalls + 5 + _isHardMode))) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _saveOldGearTeethSizeMult * _scale)); end
        else
            _constructDesignCWallExPart(_curSide, _designType, _largeWalls - 1, customizePatternThickness((a < getProtocolSides() - (_largeWalls) - _isHardMode and 9.5 or 4.75) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _saveOldGearTeethSizeMult * _scale));
        end

        if _tunnelLoopDir > 0 then
            _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), 1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset, -1); end
            if _designType == 1 or (_designType == 0 and a == 2) then
                _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale, p_getTunnelPatternCorridorThickness() * _scale, _gearTeethSizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale, p_getTunnelPatternCorridorThickness() * _scale, _gearTeethSizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset + (_largeWalls + 1) - (_largeWalls - 1), -1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)) + 2, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)) - 2, 1); end
            if _designType == 1 or (_designType == 0 and a == getProtocolSides() - (_largeWalls) - _isHardMode and _isHardMode > 0) then
                _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset + (_largeWalls + 1) - (_largeWalls - 1), _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale, p_getTunnelPatternCorridorThickness() * _scale, _gearTeethSizeMult);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixDesignPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)) - 2, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale, p_getTunnelPatternCorridorThickness() * _scale, _gearTeethSizeMult); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        else
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset - (_largeWalls + 1), -1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) + (_tunnelOffset - (_largeWalls + 1)) + 2, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1) - 2, 1); end
            if _designType == 1 or (_designType == 0 and a == 2) then
                _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset - (_largeWalls + 1), _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1) - 2, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) + (_tunnelOffset - (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)) - (_largeWalls - 1), 1);
            if _isHardMode > 0 then _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1) - 2, _tunnelOffset - (_largeWalls + 1), -1); end
            if _designType == 1 or (_designType == 0 and a == getProtocolSides() - (_largeWalls) - _isHardMode and _isHardMode > 0) then
                _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, getProtocolSides() - (_tunnelOffset - (_largeWalls + 1)), _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                if _isHardMode > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _largeWalls - 1, _tunnelOffset - (_largeWalls + 1), _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale); end
            end
            t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end

        _tunnelOffset = _tunnelOffset + _tunnelLoopDir;
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
    end

    if _isHardMode < 1 then
        for i = 1, _largeWalls, 1 do cWall(_curSide + i - 1, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
        if _tunnelLoopDir > 0 then _constructLRTunShoSpiPart(_curSide + (_tunnelOffset + (_largeWalls + 1)), getProtocolSides() - (_tunnelOffset + (_largeWalls + 1)), 1);
        else _constructLRTunShoSpiPart(_curSide + (_largeWalls - 1), _tunnelOffset - (_largeWalls + 1), -1);
        end
        t_applyPatDel(customizePatternDelay(4.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

-- back and forth (double tunnel) patterns
function pMarch31osBackAndForthTunnelAxis(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelAxisCorridorPart = function()
        local _tunnelGearTeethStep = 0;
        local _tunnelGearTeethAmount = 1;
        local _tunnelGearTeethInc = 0;

        for tAmount = 0, _modeDesign1_adjust + 1, 1 do
            if tAmount < _modeDesign1_adjust then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
                if _tunnelGearTeethStep >= _gearTeethStepDel then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _gearTeethInc) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
            end
        end

        if _gearTeethSizeMult > 0 then
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_offset, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
        else
            cWallEx(_curSide, _modeDesign1_offset, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
        end
    end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                end

                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end
                if (_designType == 0 and a == 0) or (_designType == 1 and a >= 0) then _constructBAFTunnelCentralCorridorPart()
                else _constructBAFTunnelAxisCorridorPart()
                end
            else _constructBAFTunnelAxisCorridorPart()
            end
        elseif _modeDesign == 2 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _scale, _designType);
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then _constructBAFTunnelLargeWallPart(_curSide, _repeatCorridorDelay, p_getTunnelPatternCorridorThickness(), _isRepeatCorridorDelaySpd, _scale, _designType); end
                for i = 0, math.floor((getProtocolSides() / 6) - 0.5), 1 do cWall(_curSide + (i * 6) + ((a + _tunnelLoopDir) % 2) + 1, p_getTunnelPatternCorridorThickness() * _scale); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do
                    local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                    local _dirModuloOffsetFixStat = (i % 2 == 1 and 2) or 1;
                    cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + _dirModuloOffsetFixStat, p_getTunnelPatternCorridorThickness() * _scale);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _scale, _designType);
                end
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getTunnelPatternCorridorThickness() * _scale); end
                for i = 1, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getTunnelPatternCorridorThickness() * _scale); end
            end
        elseif _modeDesign == 3 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getTunnelPatternCorridorThickness() * _scale);
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) - ((a + _tunnelLoopDir) % 2) + 2, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getTunnelPatternCorridorThickness() * _scale);
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do
                        local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                        local _dirModuloOffsetFixStat = (i % 2 == 1 and 1) or 0;
                        cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7 + _dirModuloOffsetFixStat), p_getTunnelPatternCorridorThickness() * _scale);
                    end
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then 
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if getProtocolSides() >= 9 then
                        for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getTunnelPatternCorridorThickness() * _scale); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getTunnelPatternCorridorThickness() * _scale); end
                end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then rWall(_curSide, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and not getBooleanNumber(_isLargeWallOnce) then rWall(_curSide, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                else cBarrageDoubleHoled(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 0, _free, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end
            if (a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and not getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelAxisInterpolatedCorridorWallDirPart = function(_dir)
        if _dir > 0 then
            if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
            else cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
            end
        else
            if _gearTeethSizeMult > 0 then _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
            else cWallEx(_curSide, _modeDesign1_adjust, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale)
            end
        end
    end

    local _constructBAFTunnelAxisInterpolatedLargeWallDirPart = function(_dir, _designType, _thickness)
        if _dir > 0 then _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _thickness);
        else _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, _thickness);
        end
    end

    local _constructBAFTunnelAxisInterpolatedCorridorPart = function(_iter_count, _dir) _constructBAFTunnelAxisInterpolatedCorridorWallDirPart(((_iter_count + _dir) % 2)); end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce)) then
                if a == 0 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir) % 2), _designType, customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2))) * _scale, _isRepeatCorridorDelaySpd)  + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                elseif a == 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _designType, customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2))) * _scale, _isRepeatCorridorDelaySpd)  + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart((_tunnelLoopDir % 2), _designType, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 2 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _designType, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                end

                if _designType ~= 1 then
                    if a < 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir) end
                    if a > (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) - 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir) end
                else _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir)
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and (not getBooleanNumber(_isLargeWallOnce)) then
                if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir) % 2), _designType, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _designType, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce)) then
                if a == 0 then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                elseif a == 1 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(4.5 * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end
            end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 2 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                else cWallDraw(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 2 + _free, getProtocolSides() - (2 + _free), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end
            if (not getBooleanNumber(_isLargeWallOnce)) then
                if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if a > 0 and a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5 - 0.5) * 2) + 1 then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBackAndForthTunnelCentral(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    local _constructBAFTunnelCentralCorridorPart = function()
        local _tunnelGearTeethStep = 0;
        local _tunnelGearTeethAmount = 1;
        local _tunnelGearTeethInc = 0;

        for tAmount = 0, _modeDesign1_adjust + 1, 1 do
            if tAmount < _modeDesign1_adjust then _tunnelGearTeethStep = _tunnelGearTeethStep + 1
                if _tunnelGearTeethStep >= _gearTeethStepDel then _tunnelGearTeethInc = (_tunnelGearTeethAmount * _gearTeethInc) _tunnelGearTeethStep = 0; _tunnelGearTeethAmount = _tunnelGearTeethAmount + 1; end
            end
        end

        if _gearTeethSizeMult > 0 then
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_offset, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
        else
            cWallEx(_curSide, _modeDesign1_offset, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
        end
    end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * _iter * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                else
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _modeDesign1_adjust + 1, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _modeDesign1_adjust + 1, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end

                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
                end
                if (_designType == 0 and a == 0) or (_designType == 1 and a >= 0) then _constructBAFTunnelCentralCorridorPart()
                else _constructBAFTunnelCentralCorridorPart()
                end
            else _constructBAFTunnelCentralCorridorPart()
            end
        elseif _modeDesign == 2 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _scale, _designType);
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, _repeatCorridorDelay, p_getTunnelPatternCorridorThickness(), _isRepeatCorridorDelaySpd, _scale, _designType); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + 1, p_getTunnelPatternCorridorThickness() * _scale); end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then
                    _constructBAFTunnelLargeWallPart(_curSide, (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd), a, 4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _scale, _designType);
                end
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getTunnelPatternCorridorThickness() * _scale); end
                for i = 1, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getTunnelPatternCorridorThickness() * _scale); end
            end
        elseif _modeDesign == 3 then
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
            end

            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and (not getBooleanNumber(_isLargeWallOnce)) then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getTunnelPatternCorridorThickness() * _scale);
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) + ((a + _tunnelLoopDir) % 2) + 1, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getTunnelPatternCorridorThickness() * _scale);
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7), p_getTunnelPatternCorridorThickness() * _scale); end
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (not getBooleanNumber(_isLargeWallOnce)) then 
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if getProtocolSides() >= 9 then
                        for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getTunnelPatternCorridorThickness() * _scale); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getTunnelPatternCorridorThickness() * _scale); end
                end
            end
        else
            if (getBooleanNumber(_isLargeWallOnce) and a == 0) then rWall(_curSide, customizePatternThickness(4.5 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount and not getBooleanNumber(_isLargeWallOnce) then rWall(_curSide, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides(), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                else cBarrageVorta(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _free, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end
            if (a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and not getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
