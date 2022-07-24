--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random

--[[
    void pMarch31osBarrage(_side, _thickness, _neighbors, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrage(_side, _thickness) --, 0, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osRandomBarrages(_side, _thickness, _iter, _distMin, _distMax, _isRepeat, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osRandomBarrages(_side, _thickness, _iter) --, -getHalfSides("floor"), getHalfSides("floor"), true, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter, _hasContainedEnd, _gapLength, _repeatBarrageAmount, _repeatBarrageDelay, _isRepeatBarrageDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter) --, false, 0, 0, 2, false, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _modeType, _free, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osVortaBarrage(_side, _thickness, _iter) --, 0, 1, {math.floor(_iter / 2)}, 0, 0, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _mainLoopDir, _isInvertAccurate, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageTypeBase(_side, _thickness, _iter) --, 1, 1, 1, 1, getRandomDir(), false, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageSpiral(_side, _thickness, _iter) --, 1, 1, false, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _gap, _holes, _revFreq, _distance, _isDelayDistance, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageSpiralRev(_side, _thickness, _iter) --, 1, 1, u_rndInt(1, 2), 1, 1, 1, getRandomDir(), false, 0, 1, 1, 2, false, false
    void pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osBarrageReversals(_side, _thickness, _iter) --, 1, false, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
    void pMarch31osWallStrip(_side, _thickness, _repetitions, _mirror_step, _extra, _delMult, _scale, _isThickness, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osWallStrip(_side, _thickness, _repetitions) --, u_rndInt(2, 3), 0, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false

    void pMarch31osWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _scale, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osWhirlwind(_side, _iter) --, 0, math.floor(getProtocolSides() / 3), 1, 0, 1, 1, getRandomDir(), 0, 0, false, false, 0, 1, 1, 2, false, false
    void pMarch31osWhirlwindRev(_side, _iter, _times_beforeChangeDir, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _scale, _loopDir, _cleanAmountStart, _cleanAmountCycle, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osWhirlwindRev(_side, _iter) --, 1, 0, math.floor(getProtocolSides() / 3), 1, 0, 1, 1, getRandomDir(), 0, 0, 0, false, false, 0, 1, 1, 2, false, false

    void pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _dirType, _largeWalls, _isDistanceTight, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 2, 1, u_rndInt(1, getProtocolSides() - 2), false, false, (to be indexed if is nil), 1, 1, false, false, 0, 2, false 1, nil, 0, 0, 1, 1, u_rndInt(0, 1), false, 0, 1, 1, 2, false, false
]]

--[ Commons ]--

local _constructDesignCWallExPart = function(_side, _designType, _extra, _thickness)
    if _designType <= 1 and _extra > 1 then
        for i = 0, 1, 1 do cWall(_side + (i * _extra), _thickness); end
    else cWallEx(_side, _extra, _thickness);
    end
end

--[ Barrages ]--

function pMarch31osBarrage(_side, _thickness, _neighbors, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _scale = anythingButNil(_scale, 1); _neighbors = anythingButNil(_neighbors, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;

    cBarrageN(_curSide, _neighbors, p_getTunnelPatternCorridorThickness() * _scale);

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osRandomBarrages(_side, _thickness, _iter, _distMin, _distMax, _isRepeat, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _distMin = anythingButNil(_distMin, -getHalfSides("floor")); _distMax = anythingButNil(_distMax, getHalfSides("floor")); _isRepeat = anythingButNil(_isRepeat, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _oldCurSideTarget = _curSide;
    local _barrageDistanceDelay = 0;
    local _curRandDist = 0;

    for a = 0, _iter, 1 do
        for i = 1, getBarrageSide(), 1 do cWall(i + _curSide, p_getTunnelPatternCorridorThickness() * _scale); end
        _oldCurSideTarget = _curSide;
        _curRandDist = u_rndInt(_distMin, _distMax);
        if (not _isRepeat) then
             repeat _curRandDist = u_rndInt(_distMin, _distMax);
             until _curRandDist ~= 0
        else _curRandDist = u_rndInt(_distMin, _distMax);
        end
        _curSide = _curSide + _curRandDist;
        _barrageDistanceDelay = _curSide - _oldCurSideTarget;
        if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1; end
        t_applyPatDel(customizePatternDelay(((1.5 + (_barrageDistanceDelay * 1.5) * (6 / getProtocolSides())) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed) * _delMult * _scale, p_getDelayPatternBool()))
    end

    for i = 1, getBarrageSide(), 1 do cWall(i + _curSide, p_getTunnelPatternCorridorThickness() * _scale); end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osAlternatingBarrage(_side, _thickness, _iter, _hasContainedEnd, _gapLength, _repeatBarrageAmount, _repeatBarrageDelay, _isRepeatBarrageDelaySpd, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, 0);
    if _gapLength == nil or _gapLength < 0 or _gapLength > math.floor(getProtocolSides() / 2) - 1 then _gapLength = 0; end
    if not _repeatBarrageAmount or _repeatBarrageAmount < 0 then _repeatBarrageAmount = 0; end
    _repeatBarrageDelay = anythingButNil(_repeatBarrageDelay, 2); _isRepeatBarrageDelaySpd = anythingButNil(_isRepeatBarrageDelaySpd, 0);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDir = _loopDir;

    _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        for repeatAmount = 0, _repeatBarrageAmount, 1 do
            cWallExM(_curSide + _barrageOffset, (math.floor(getProtocolSides() / 2) - _gapLength) + (_barrageLoopDir * 0.5 - 0.5), 2, p_getTunnelPatternCorridorThickness() * _scale);
            if _barrageLoopDir > 0 and _gapLength > 0 then
                for i = getProtocolSides() - (_gapLength * 2) - (getProtocolSides() % 2), getProtocolSides(), 1 do cWall(_curSide + i + (_loopDir * 0.5 - 0.5), p_getTunnelPatternCorridorThickness() * _scale); end
            end
            if repeatAmount < _repeatBarrageAmount then t_applyPatDel(customizePatternDelay(_repeatBarrageDelay * _scale, _isRepeatBarrageDelaySpd)); end
        end

        _barrageOffset = _barrageOffset + _barrageLoopDir; _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, p_getDelayPatternBool()));
    end
    if (_hasContainedEnd) then
        for repeatAmount = 0, _repeatBarrageAmount, 1 do
            if getProtocolSides() < 5 then cBarrage(_curSide + _barrageOffset + 1, p_getTunnelPatternCorridorThickness() * _scale);
            elseif getProtocolSides() == 5 then for i = 0, getProtocolSides() - 3 do cWall(_curSide + i + _barrageOffset + closeValue(_barrageLoopDir, 0, 1)); end
            elseif getProtocolSides() > 5 then cBarrageDoubleHoled(_curSide + _barrageOffset + (math.floor(_gapLength / 2) * 2), 0, 0, p_getTunnelPatternCorridorThickness() * _scale);
            end
            if repeatAmount < _repeatBarrageAmount then t_applyPatDel(customizePatternDelay(_repeatBarrageDelay * _scale, _isRepeatBarrageDelaySpd)); end
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    -- end delay (optional arg, default false)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _modeType, _free, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    -- optional args
    _iter = anythingButNil(_iter, 4); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _dirType = anythingButNil(_dirType, 0); _revFreq = anythingButNil(_revFreq, 1); _dirPoints = anythingButNil(_dirPoints, (_dirType == 2 and {u_rndInt(2, 5), u_rndInt(2, 5)}) or {math.floor(_iter / 2)});
    _modeType = anythingButNil(_modeType, 0); _free = anythingButNil(_free, 0);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _loopDir = math.ceil(_loopDir);

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _revFreqAdd = 0;

    local _vortaBarPart = function(_side, _free, _thickness, _modeType)
        --spawn piece; apply delay
        if _modeType == 1 then
            cWallEx(_side, closeValue(getProtocolSides() % 3, 0, 1) + 1, _thickness);
            cWallEx(_side + (closeValue(getProtocolSides() % 3, 0, 1) + 3), closeValue((getProtocolSides() % 3) - 1, 0, 1) + 1, _thickness);
            if getProtocolSides() >= 9 then
                for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWallEx(_side + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), 1, _thickness); end
            end
        else cBarrageVorta(_side, _free, _thickness);
        end
        t_applyPatDel(customizePatternDelay(3.6 * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, p_getDelayPatternBool()));
    end

    for r = 0, _revFreq, 1 do
        if r == _revFreq and _dirType == 0 then _revFreqAdd = 1; end

        if _dirType == 0 then
            --spawn loop
            for a = 0, _iter + _revFreqAdd, 1 do
                p_patternEffectCycle();
                _vortaBarPart(_curSide, _free, p_getTunnelPatternCorridorThickness() * _scale, _modeType);

                if _dirType == 1 then
                    --check of need to change dir
                    local _switchI = 1
                    if _switchI <= #_dirPoints then
                        if (_dirPoints[_switchI] == a) then
                            _loopDir = -_loopDir
                            table.remove(_dirPoints, _switchI)
                        else
                            _switchI = _switchI + 1;
                        end
                    end
                end

                --move side pointer
                _curSide = _curSide + _loopDir
            end
        end

        if _dirType == 0 then _loopDir = -_loopDir
        elseif _dirType == 2 then
            for _switchII = 1, #_dirPoints, 1 do
                for a = 0, _dirPoints[_switchII], 1 do
                    p_patternEffectCycle();
                    _vortaBarPart(_curSide, _free, p_getTunnelPatternCorridorThickness(), _modeType);
                    _curSide = _curSide + _loopDir;
                end
                _loopDir = -_loopDir;
            end
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    -- end delay (optional arg, default false)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _mainLoopDir, _isInvertAccurate, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end
    if type(_offsetDistance) ~= "number" or _offsetDistance < 1 then _offsetDistance = 1; end
    if type(_offsetType) ~= "number" then _offsetType = 0; end
    if type(_mainLoopDir) == "number" and _mainLoopDir <= 0 then _mainLoopDir = -1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _barrageLoopDir = (type(_mainLoopDir) == "number" and getNeg(_mainLoopDir)) or getRandomDir();

    local _typeModeModuloStat = (_offsetType == 0 and getProtocolSides()) or 2; --ye, that's the number to integer converter
    local _typeModeStat = (_offsetType == 2 and getHalfSides()) or 1;
    local _typeModeMultStat = (_offsetType == 2 and 1) or _offsetDistance;

    if _holes > 1 then _gap = 1; end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a % 2 == 1 and (l_getSides() % 2 == 1) and _holes == 1 and _offsetType == 2 and getBooleanNumber(_isInvertAccurate) then cWallEx(_curSide + 1 + getHalfSides(), getProtocolSides() - (2 + _gap), p_getTunnelPatternCorridorThickness());
        else
            if _holes > 1 then cBarrageExHoles(_curSide + ((a % _typeModeModuloStat) * _typeModeMultStat * _typeModeStat * _barrageLoopDir), _holes - 1, p_getTunnelPatternCorridorThickness());
            else cBarrageGap(_curSide + ((a % _typeModeModuloStat) * _typeModeMultStat * _typeModeStat * _barrageLoopDir), _gap, p_getTunnelPatternCorridorThickness());
            end
        end
        t_applyPatDel(customizePatternDelay(4 * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 0, anythingButNil(_distance, 1), _loopDir, false, (getBooleanNumber(_isDelayDistance) and (anythingButNil(_distance, 1) * 0.333 + 0.667) or 1) * _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osBarrageSpiralRev(_side, _thickness, _iter, _gap, _holes, _revFreq, _distance, _isDelayDistance, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _revFreq = anythingButNil(_revFreq, u_rndInt(1, 2)); _distance = anythingButNil(_distance, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _barrageLoopDir = (type(_loopDir) == "number" and math.ceil(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    local _barrageOffset = 0;
    local _revIterAdd = 0;

    if _holes > 1 then _gap = 1; end

    for r = 0, _revFreq, 1 do
        if r == _revFreq then _revIterAdd = 1; end

        for a = 0, _iter + _revIterAdd, 1 do
            p_patternEffectCycle();

            if _holes > 1 then cBarrageExHoles(_curSide + (_barrageOffset * _distance), _holes - 1, p_getTunnelPatternCorridorThickness());
            else cBarrageGap(_curSide + (_barrageOffset * _distance), _gap, p_getTunnelPatternCorridorThickness());
            end
            _barrageOffset = _barrageOffset + _barrageLoopDir;
            t_applyPatDel(customizePatternDelay(4 * (getBooleanNumber(_isDelayDistance) and (_distance * 0.333 + 0.667) or 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, p_getDelayPatternBool()));
        end

        _barrageLoopDir = _barrageLoopDir * -1;
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    pMarch31osBarrageTypeBase(_side, _thickness, _iter, _gap, 1, 2, 1, _loopDir, _isInvertAccurate, _delMult * 2, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
end

function pMarch31osWallStrip(_side, _thickness, _repetitions, _mirror_step, _extra, _delMult, _scale, _isThickness, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _repetitions = anythingButNil(_repetitions, 1); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _mirror_step = anythingButNil(_mirror_step, u_rndInt(2, 3)); _extra = anythingButNil(_extra, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;

    _isThickness = getBooleanNumber(_isThickness);
    if not _isThickness then
        for a = 0, _repetitions, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide, _mirror_step, _extra, p_getTunnelPatternCorridorThickness() * _scale);
            t_applyPatDel(customizePatternDelay(2.75 * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, false));
        end
    else
        p_patternEffectCycle();
        cWallMirrorEx(_curSide, _mirror_step, _extra, customizePatternThickness((2.75 * _repetitions) * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, false) + (p_getTunnelPatternCorridorThickness() * _scale));
        t_applyPatDel(customizePatternDelay((2.75 * (_repetitions + 1)) * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale * _curDelaySpeed, false));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Spirals ]--

function pMarch31osWhirlwind(_side, _iter, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _scale, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _extra = anythingButNil(_extra, 0); _mirror_step = anythingButNil(_mirror_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    _loopDir = (type(_loopDir) == "number" and getNeg(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    if not _cleanAmountStart or _cleanAmountStart < 0 then _cleanAmountStart = 0; end
    if not _cleanAmountEnd or _cleanAmountEnd < 0 then _cleanAmountEnd = _cleanAmountStart; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfDelayAmountForTriangle, currentTimesOfThickAmountForSquare = 4, 8.25;
    local currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = 3 * (_seamless and 1.1 or 1) * ((_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentSizeOverride, currentDelayOverride = 1, 0.9;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    if getProtocolSides() == 3 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and getBooleanNumber(_is_full)) then
        cBarrage(_curSide + _loopDir, customizePatternThickness(1 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        for a = 0, _iter, 1 do
            if a == _iter then currentTimesOfDelayAmountForTriangle = 3; end
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _loopDir, customizePatternThickness(1 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
        for i = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + i * _loopDir, customizePatternThickness(5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 2;
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        for a = 0, _iter + 1, 1 do --1, _iter + 2
            p_patternEffectCycle();
            if a == _iter + 1 then currentTimesOfThickAmountForSquare = 6; end
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickAmountForSquare * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 2;
        for k = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + k * _loopDir, customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end 
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 3;
        cBarrage(_curSide + _spiralPosistionOffset, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
    else
        if (_cleanAmountStart > 0) then
            for fa = 0, _cleanAmountStart, 1 do
                for ia = 0, _cleanAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_loopDir * _pos_spacing * (ia - 1)), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_loopDir * _pos_spacing * fa) - (_cleanAmountStart * _loopDir * _pos_spacing), _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                if fa == _cleanAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            end
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountEnd > 0) then
            for fb = 0, _cleanAmountEnd, 1 do
                if fb == _cleanAmountEnd then currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = _curSpiralThick; end
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness(currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0); t_applyPatDel(customizePatternDelay(2 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pMarch31osWhirlwindRev(_side, _iter, _times_beforeChangeDir, _extra, _mirror_step, _pos_spacing, _seamless, _delMult, _scale, _loopDir, _cleanAmountStart, _cleanAmountCycle, _cleanAmountEnd, _is_full, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(4, 7)); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _extra = anythingButNil(_extra, 0); _mirror_step = anythingButNil(_mirror_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    if _times_beforeChangeDir == nil or _times_beforeChangeDir < 0 then _times_beforeChangeDir = 1; end
    _loopDir = (type(_loopDir) == "number" and getNeg(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    if not _cleanAmountStart or _cleanAmountStart < 0 then _cleanAmountStart = 0; end
    if not _cleanAmountCycle or _cleanAmountCycle < 0 then _cleanAmountCycle = _cleanAmountStart; end
    if not _cleanAmountEnd or _cleanAmountEnd < 0 then _cleanAmountEnd = _cleanAmountStart; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfDelayAmountForTriangle, currentTimesOfThickAmountForTriangle = 4, 4;
    local currentTimesOfDelayAmountForSquare, currentTimesOfThickAmountForSquare, currentTimesOfThickAmountBeforeDirChangeForSquare, currentThickOffsetAmountBeforeDirChangeForSquare_001, currentThickOffsetAmountBeforeDirChangeForSquare_002 = 2, 4, 6, 0, 0;
    local currentTimesOfThickAmountForGreaterThanSquare = 2;
    local timesBeforeChangeDir_thickAmountForGreaterThanSquare = 3 * (_seamless and 1.1 or 1) * ((_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = 3 * (_seamless and 1.1 or 1) * ((_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0))) * _delMult; -- adding the 'timesBeforeChangeDir_thickAmountForGreaterThanSquare' value when loops until direction changes
    local currentSizeOverride, currentDelayOverride = 1, 0.9;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    if getProtocolSides() == 3 and ((_cleanAmountStart > 0 and _cleanAmountCycle > 0 and _cleanAmountEnd > 0) and getBooleanNumber(_is_full)) then
        cBarrage(_curSide + _loopDir, customizePatternThickness(1 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        for a = 0, _iter, 1 do
            if a == _iter then currentTimesOfThickAmountForTriangle = 4 + (_curDelaySpeed * _delMult); end
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(currentTimesOfThickAmountForTriangle * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(4 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        cWall(_curSide + _spiralPosistionOffset - _loopDir, customizePatternThickness(5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        _loopDir = _loopDir * -1;
        for a = 0, _iter + 1, 1 do
            if a == _iter + 1 then currentTimesOfDelayAmountForTriangle = 3; end
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizePatternThickness(4 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForTriangle * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _loopDir, customizePatternThickness(1 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
    elseif getProtocolSides() == 4 and ((_cleanAmountStart > 0 and _cleanAmountCycle > 0 and _cleanAmountEnd > 0) and _is_full) then _loopDir = _loopDir * -1;
        if _iter > 0 then currentTimesOfThickAmountBeforeDirChangeForSquare = 4; end
        if _iter == 1 then currentThickOffsetAmountBeforeDirChangeForSquare_001 = 2;
        elseif _iter > 1 then currentThickOffsetAmountBeforeDirChangeForSquare_002 = 2;
        end
        cBarrage(_curSide - _loopDir, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            if a == 1 then currentThickOffsetAmountBeforeDirChangeForSquare_002 = 0; end
            if a == _iter then currentTimesOfThickAmountForSquare = 11; currentTimesOfDelayAmountForSquare = 5; end
            cWall(_curSide, customizePatternThickness((currentTimesOfThickAmountForSquare + currentThickOffsetAmountBeforeDirChangeForSquare_001 + currentThickOffsetAmountBeforeDirChangeForSquare_002) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            if a < _iter then _curSide = _curSide - _loopDir; end
            t_applyPatDel(customizePatternDelay((currentTimesOfDelayAmountForSquare + currentThickOffsetAmountBeforeDirChangeForSquare_001 + currentThickOffsetAmountBeforeDirChangeForSquare_002) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
        cWall(_curSide - _loopDir, customizePatternThickness((currentTimesOfThickAmountBeforeDirChangeForSquare - currentThickOffsetAmountBeforeDirChangeForSquare_001) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        cBarrage(_curSide + _loopDir, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            currentTimesOfThickAmountForSquare = 4; currentTimesOfDelayAmountForSquare = 2;
            if a == _iter then currentTimesOfThickAmountForSquare = 6; currentTimesOfDelayAmountForSquare = 5; end
            cWall(_curSide + _loopDir, customizePatternThickness(currentTimesOfThickAmountForSquare * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(currentTimesOfDelayAmountForSquare * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _curSide = _curSide + _loopDir;
        end
        cBarrage(_curSide - _loopDir, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
    else
        if (_cleanAmountStart > 0) then
            for fa = 0, _cleanAmountStart, 1 do
                for ia = 0, _cleanAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_loopDir * _pos_spacing * (ia - 1)), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool())); end
                end
                cWallMirrorEx(_curSide + (_loopDir * _pos_spacing * fa) - (_cleanAmountStart * _loopDir * _pos_spacing), _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                if fa == _cleanAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            end
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            if a == _iter and (_cleanAmountCycle > 0) then currentTimesOfThickAmountForGreaterThanSquare = 3 * _curDelaySpeed * _delMult; end
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(2 * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountCycle > 0) then
            for fb = 0, _cleanAmountCycle - 1, 1 do
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
            for hb = 0, _times_beforeChangeDir, 1 do
                if hb < _times_beforeChangeDir then
                    for ib = 0, _cleanAmountCycle, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
                elseif hb == _times_beforeChangeDir then
                    for ib = 0, _cleanAmountCycle - 1, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
                    cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * _cleanAmountCycle), _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
            for vb = 1, _cleanAmountCycle, 1 do
                for eb = 0, _cleanAmountCycle - (vb + 1), 1 do
                    if eb >= 0 then
                        for lb = 0, _cleanAmountCycle - (vb + 1), 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * lb), _mirror_step, _extra, customizePatternThickness((_curSpiralThick + 1) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
                    end
                end
                cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * (_cleanAmountCycle - vb)), _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
        else
            for hb = 0, _times_beforeChangeDir, 1 do
                if hb == _times_beforeChangeDir then timesBeforeChangeDir_thickAmountForGreaterThanSquare = _curSpiralThick; end
                cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * _cleanAmountCycle), _mirror_step, _extra, customizePatternThickness(timesBeforeChangeDir_thickAmountForGreaterThanSquare * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
        end
        _spiralPosistionOffset = _spiralPosistionOffset - (_loopDir * _pos_spacing * 2); _loopDir = _loopDir * -1; -- It's time to reversing the spiral.
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _mirror_step, _extra, customizePatternThickness(_curSpiralThick * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountEnd > 0) then
            for fb = 0, _cleanAmountEnd, 1 do
                if fb == _cleanAmountEnd then currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare = _curSpiralThick; end
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _mirror_step, _extra, customizePatternThickness(currentCleanTimesEndSectionOfThickAmountForGreaterThanSquare * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            end
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0); t_applyPatDel(customizePatternDelay(2 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Tunnels ]--

--here's a tunnel what forces you to circle around a very thick wall...but you can personalize everything
function pMarch31osTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _designType, _dirType, _largeWalls, _isDistanceTight, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _repeatCorridorAmount, _repeatCorridorDelay, _isRepeatCorridorDelaySpd, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _delMult, _scale, _loopDir, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _designType = anythingButNil(_designType, 2); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    _dirType = anythingButNil(_dirType, 0); _largeWalls = closeValue(anythingButNil(_largeWalls, u_rndInt(1, getProtocolSides() - 2)), 1, getProtocolSides() - 2); _isDistanceTight = anythingButNil(_isDistanceTight, 0); _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    _sidedir0gap = anythingButNil(_sidedir0gap, 1); _sidedir1gap = anythingButNil(_sidedir1gap, _sidedir0gap); _sidedir0offset = anythingButNil(_sidedir0offset, 0); _sidedir1offset = anythingButNil(_sidedir1offset, _sidedir0offset);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _repeatCorridorAmount or _repeatCorridorAmount < 0 then _repeatCorridorAmount = 0; end
    _repeatCorridorDelay = anythingButNil(_repeatCorridorDelay, 2); _isRepeatCorridorDelaySpd = anythingButNil(_isRepeatCorridorDelaySpd, 0);
    if not _sidedir0gap or _sidedir0gap < 1 then _sidedir0gap = 1; end
    if not _sidedir1gap or _sidedir1gap < 1 then _sidedir1gap = 1; end
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local _curTunnelCorridorDirGap, _curTunnelCorridorDirOffset = 0, 0; local _curTunnelCorridorDir, _curTunnelSpiralCorridorDir = 1, 1;
    local _amountOfBeforeGearTeethBegin, _timesOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _gearTeethBarrageAmount, _gearTeethBarrageStep, _gearTeethBarrageInc = 1, 0, 0;
    local _gearTeethWallOffsetAmount, _gearTeethWallOffsetStep, _gearTeethWallOffsetInc = 1, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir) * (_largeWalls + 1);
    local _amountOfDesignType0, _tunnelSpiralExpected, _largeWallOnceExpected = 1, _dirType == 1, (getBooleanNumber(_isLargeWallOnce)) and (_dirType == 0 or _dirType == 2);

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    --_isSpiral = getBooleanNumber(_isSpiral); if (_isSpiral) then _sidedir0gap = 1; _sidedir1gap = _sidedir0gap; _sidedir0offset = 0; _sidedir1offset = _sidedir0offset; end
    local _curTunnelDel = getBooleanNumber(_isDistanceTight) and (closeValue(getProtocolSides(), 3, 9) / (_largeWalls * 0.4 + 0.175) + (p_getTunnelPatternCorridorThickness() * (_largeWalls / (getProtocolSides() - 2)))) or 9;
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end
    _isRepeatCorridorDelaySpd = getBooleanNumber(_isRepeatCorridorDelaySpd);

    --for larger wall once 
    if (_largeWallOnceExpected) then
        _constructDesignCWallExPart(_curSide + 1, _designType, _largeWalls - 1,
        customizePatternThickness((_curTunnelDel * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd)) * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount + (_repeatCorridorAmount * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd))) * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
    end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if _designType == 0 and (a > 0 and a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) then _amountOfDesignType0 = _largeWalls;
        else _amountOfDesignType0 = 1;
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _tunnelLoopDir > 0 then _curTunnelCorridorDirGap = _sidedir1gap; _curTunnelCorridorDirOffset = _sidedir1offset; _curTunnelCorridorDir = 1 * _curTunnelSpiralCorridorDir;
        else _curTunnelCorridorDirGap = _sidedir0gap; _curTunnelCorridorDirOffset = _sidedir0offset; _curTunnelCorridorDir = -1 * _curTunnelSpiralCorridorDir;
        end

        for repeatAmount = 0, _repeatCorridorAmount, 1 do
            if repeatAmount < _repeatCorridorAmount and (not _largeWallOnceExpected) then _constructDesignCWallExPart(_curSide + 1, _designType, _largeWalls - 1, customizePatternThickness(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end

            _gearTeethBarrageAmount = 1; _gearTeethBarrageStep = 0; _gearTeethBarrageInc = 0;

            for corridorGap = _curTunnelCorridorDirGap, getBarrageSide(_curTunnelCorridorDirOffset + _amountOfDesignType0), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), (p_getTunnelPatternCorridorThickness() + _gearTeethBarrageInc) * _gearTeethSizeMult)
                    if corridorGap < getBarrageSide(_curTunnelCorridorDirOffset + _gearTeethStepLimit) - _largeWalls then _gearTeethBarrageStep = _gearTeethBarrageStep + 1;
                        if _gearTeethBarrageStep >= _gearTeethStepDel then _gearTeethBarrageStep = 0; _gearTeethBarrageInc = (_gearTeethBarrageAmount * _gearTeethInc); _gearTeethBarrageAmount = _gearTeethBarrageAmount + 1; end
                    end
                else cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale)
                end
            end

            _gearTeethWallOffsetAmount = 1; _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = 0;

            for offsetGap = getProtocolSides() - _curTunnelCorridorDirOffset + _amountOfDesignType0, getProtocolSides(), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((offsetGap * _curTunnelCorridorDir * -1) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - (_curTunnelCorridorDir * (getProtocolSides() + _curTunnelCorridorDirOffset)), (p_getTunnelPatternCorridorThickness() + _gearTeethWallOffsetInc) * _gearTeethSizeMult);
                    if offsetGap < getProtocolSides() - (_gearTeethStepLimit - 1) then _gearTeethWallOffsetStep = _gearTeethWallOffsetStep + 1;
                        if _gearTeethWallOffsetStep >= _gearTeethStepDel then _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = (_gearTeethWallOffsetAmount * _gearTeethInc); _gearTeethWallOffsetAmount = _gearTeethWallOffsetAmount + 1; end
                    end
                else cWall((offsetGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - _curTunnelCorridorDir, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end
            end
            if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
        end

        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and (not _largeWallOnceExpected) then
            --for i = 1, _largeWalls, 1 do cWall(_curSide + i, customizePatternThickness(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
            _constructDesignCWallExPart(_curSide + 1, _designType, _largeWalls - 1,
            customizePatternThickness(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()) + customizePatternThickness(_repeatCorridorDelay * (_repeatCorridorAmount) * _scale * (((_dirType == 1 or _dirType >= 3) and a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 and 1) or 0), _isRepeatCorridorDelaySpd) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale));
        end

        if _dirType == 1 then _tunnelSpiralExpected = true;
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then _curSide = _curSide - ((_largeWalls + 1) + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir; --if a == _iter + _timesOfBeforeGearTeethBegin - 1 then _curSide = _curSide - (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset * _curTunnelCorridorDir; _curTunnelSpiralCorridorDir = _curTunnelSpiralCorridorDir * -1; end
            else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
            end
        elseif _dirType == 2 then if u_rndInt(0, 100) > 50 then _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1); end
        elseif _dirType == 3 then
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then
                if u_rndInt(0, 100) > 50 then _tunnelSpiralExpected = true; _curSide = _curSide - ((_largeWalls + 1) + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir; _oldCurSide = _curSide if a == _iter + _timesOfBeforeGearTeethBegin - 1 then _curSide = _curSide - (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset * _curTunnelCorridorDir; _curTunnelSpiralCorridorDir = _curTunnelSpiralCorridorDir * -1; end
                else _tunnelSpiralExpected = false; _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
                end
            else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
            end
        else _tunnelLoopDir = _tunnelLoopDir * -1 + (_largeWalls + 1);
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end

        t_applyPatDel(customizePatternDelay(_curTunnelDel * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
