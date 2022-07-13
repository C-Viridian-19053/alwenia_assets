--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_rndInt = u_rndInt or math.random

--[[
    void spMarch31osAlternatingBarrage(_side, _thickness, _iter, _hasContainedEnd, _gapLength, _hasRepeat, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osAlternatingBarrage(_side, _thickness, _iter) --, false, 0, false, 1, getRandomDir(), false
    void spMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _modeType, _free, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osVortaBarrage(_side, _thickness, _iter) --, 0, 1, {math.floor(_iter / 2)}, 0, 0, 1, getRandomDir(), false
    void spMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _isInvertAccurate, _beatDistance, _mainLoopDir, _isRebootingSide)
    void spMarch31osBarrageSpiral(_side, _thickness, _iter) --, 1, 0, 0, 1, false, 1, getRandomDir(), false
    void spMarch31osBarrageSpiralRev(_side, _thickness, _iter, _gap, _holes, _revFreq, _distance, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osBarrageSpiralRev(_side, _thickness, _iter) --, 1, 1, 1, 1, 1, getRandomDir(), false

    void spMarch31osWhirlwind(_side, _iter, _extra, _step, _pos_spacing, _wallLength, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide)
    void spMarch31osWhirlwind(_side, _iter) --, 0, math.floor(getProtocolSides() / 3), 1, 1, getRandomDir(), 0, 0, false, false
    void spMarch31osWhirlwindRev(_side, _iter, _times_beforeChangeDir, _extra, _step, _pos_spacing, _wallLength, _loopDir, _cleanAmountStart, _cleanAmountCycle, _cleanAmountEnd, _is_full, _isRebootingSide)
    void spMarch31osWhirlwindRev(_side, _iter) --, 1, 0, math.floor(getProtocolSides() / 3), 1, 1, getRandomDir(), 0, 0, 0, false, false
    void spMarch31osFullWhirlwind(_side, _iter, _loopDir, _isRebootingSide)
    void spMarch31osFullWhirlwind(_side, _iter) --, getRandomDir(), false
    void spMarch31osFullWhirlwindPrototype(_side, _loopDir, _isRebootingSide)
    void spMarch31osFullWhirlwindPrototype(_side) --, getRandomDir(), false

    void spMarch31osTunnel(_side, _thickness, _iter, _designType, _dirType, _distance, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osTunnel(_side, _thickness, _iter) --, 2, 0, u_rndInt(2, getProtocolSides() - 1), 0, (to be indexed if is nil), 1, 1, false, false, false, 1 1, nil, 0, nil, 1, u_rndInt(0, 1), false
    void spMarch31osBackAndForthTunnelAxis(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osBackAndForthTunnelAxis(_side, _corridorThick, _iter) --, 0, 2, 0, 0, 0, 0, (to be indexed if is nil), 1, 1, false, false, false, 1, 1, u_rndInt(0, 1), false
    void spMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThick, _iter) --, 0, 2, 0, 0, 0, 0, (to be indexed if is nil), 1, 1, false, false, false, 1, 1, u_rndInt(0, 1), false
    void spMarch31osBackAndForthTunnelCentral(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    void spMarch31osBackAndForthTunnelCentral(_side, _corridorThick, _iter) --, 0, 2, 0, 0, 0, 0, (to be indexed if is nil), 1, 1, false, false, false, 1, 1, u_rndInt(0, 1), false

    void spMarch31osTrapAround(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignCycle, _modeDesignEnd, _designDelayAdd, _wallLength, _isRebootingSide)
    void spMarch31osTrapAround(_side, _iter) --, 1, nil, 0, nil, 1, 1, 0, 0, 1, false
    void spMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _wallLength, _isRebootingSide)
    void spMarch31osAccurateBat(_side) --, 0, nil, 0, nil, 0, 1, false
]]

--[ Commons ]--

local _constructDesignCWallExPart = function(_side, _designType, _extra, _thickness)
    if _designType <= 1 and _extra > 1 then
        for i = 0, 1, 1 do cWall(_side + (i * _extra), _thickness); end
    else cWallEx(_side, _extra, _thickness);
    end
end

local _constructBAFTunnelLargeWallPart = function(_side, _freqAmount, _largeWallThick, _corridorThick, _isLargeWallThickSpdMode, _designType)
    for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_side + (i * 3), customizeTempoPatternThickness(_largeWallThick, _isLargeWallThickSpdMode) + ((_corridorThick / 2))); end
    if (getProtocolSides() % 3 > 0) then
        if (_designType <= 1) then
            for i = 0, 1, 1 do cWall(_side - (i * (getProtocolSides() % 3)), customizeTempoPatternThickness(_largeWallThick, _isLargeWallThickSpdMode) + ((_corridorThick / 2))); end
            if (_designType == 0 and getProtocolSides() % 3 == 2) and _freqAmount == 0 then cWall(_side - 1, _corridorThick); end
            if (_designType == 1 and getProtocolSides() % 3 == 2) then cWall(_side - 1, _corridorThick); end
        else
            for i = 0, getProtocolSides() % 3, 1 do cWall(_side - i, customizeTempoPatternThickness(_largeWallThick, _isLargeWallThickSpdMode) + ((_corridorThick / 2))); end
        end
    end
end

--[ Barrages ]--

function spMarch31osAlternatingBarrage(_side, _thickness, _iter, _hasContainedEnd, _gapLength, _hasRepeat, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _beatDistance = anythingButNil(_beatDistance, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, 0);
    if _gapLength == nil or _gapLength < 0 or _gapLength > math.floor(getProtocolSides() / 2) - 1 then _gapLength = 0; end
    if type(_loopDir) ~= "number" or _loopDir == 0 then _loopDir = getRandomDir(); end

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _barrageOffset = 0;
    local _barrageLoopDir = _loopDir;
    local _hasRepeatState = (getBooleanNumber(_hasRepeat) and 1) or 0;

    _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        local _containeDelayFix = (_hasContainedEnd and 1) or 0

        for repeatAmount = 0, _hasRepeatState, 1 do
            cWallExM(_curSide + _barrageOffset, (math.floor(getProtocolSides() / 2) - _gapLength) + (_barrageLoopDir * 0.5 - 0.5), 2, p_getTunnelPatternCorridorThickness());
            if _barrageLoopDir > 0 and _gapLength > 0 then
                for i = getProtocolSides() - (_gapLength * 2) - (getProtocolSides() % 2), getProtocolSides(), 1 do cWall(_curSide + i + (_loopDir * 0.5 - 0.5), p_getTunnelPatternCorridorThickness()); end
            end
            if repeatAmount < _hasRepeatState then t_applyPatDel(customizeTempoPatternDelay(0.15 * _beatDistance)); end
        end

        _barrageOffset = _barrageOffset + _barrageLoopDir; _barrageLoopDir = _barrageLoopDir * -1;
        if a < _iter + _containeDelayFix then t_applyPatDel(customizeTempoPatternDelay((_hasRepeat and 0.35 or 0.5) * _beatDistance)); end
    end
    if (_hasContainedEnd) then
        for repeatAmount = 0, _hasRepeatState, 1 do
            if getProtocolSides() < 5 then cBarrage(_curSide + _barrageOffset + 1, p_getTunnelPatternCorridorThickness());
            elseif getProtocolSides() == 5 then for i = 0, getProtocolSides() - 3 do cWall(_curSide + i + _barrageOffset + closeValue(_barrageLoopDir, 0, 1)); end
            elseif getProtocolSides() > 5 then cBarrageDoubleHoled(_curSide + _barrageOffset + (math.floor(_gapLength / 2) * 2), 0, 0, p_getTunnelPatternCorridorThickness());
            end
            if repeatAmount < _hasRepeatState then t_applyPatDel(customizeTempoPatternDelay(0.15 * _beatDistance)); end
        end
    end

    p_patternEffectEnd();
end

function spMarch31osVortaBarrage(_side, _thickness, _iter, _dirType, _revFreq, _dirPoints, _modeType, _free, _beatDistance, _loopDir, _isRebootingSide)
    -- optional args
    _iter = anythingButNil(_iter, 4); _beatDistance = anythingButNil(_beatDistance, 1);
    _dirType = anythingButNil(_dirType, 0); _revFreq = anythingButNil(_revFreq, 1); _dirPoints = anythingButNil(_dirPoints, (_dirType == 2 and {u_rndInt(2, 5), u_rndInt(2, 5)}) or {math.floor(_iter / 2)});
    _modeType = anythingButNil(_modeType, 0); _free = anythingButNil(_free, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    _loopDir = (type(_loopDir) == "number" and math.ceil(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _revFreqAdd = 0;

    local _vortaBarPart = function(_side, _free, _thickness, _modeType)
        --spawn piece
        if _modeType == 1 then
            cWallEx(_side, closeValue(getProtocolSides() % 3, 0, 1) + 1, _thickness);
            cWallEx(_side + (closeValue(getProtocolSides() % 3, 0, 1) + 3), closeValue((getProtocolSides() % 3) - 1, 0, 1) + 1, _thickness);
            if getProtocolSides() >= 9 then
                for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWallEx(_side + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), 1, _thickness); end
            end
        else cBarrageVorta(_side, _free, _thickness);
        end
    end

    for r = 0, _revFreq, 1 do
        if r == _revFreq and _dirType == 0 then _revFreqAdd = 1; end
        local _endDelayFix = (r == _revFreq and 0) or 1

        --spawn loop
        if _dirType == 0 then
            for a = 0, _iter + _revFreqAdd, 1 do
                p_patternEffectCycle();
                _vortaBarPart(_curSide, _free, p_getTunnelPatternCorridorThickness(), _modeType);
                --apply delay
                if a < _iter + _revFreqAdd + _endDelayFix then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance)); end

                if _dirType == 1 then
                    --check of need to change dir
                    local _switchI = 1
                    if _switchI <= #_dirPoints then
                        if (_dirPoints[_switchI] == a) then
                            _loopDir = -_loopDir
                            table.remove(_dirPoints, _switchI)
                        else _switchI = _switchI + 1;
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
                    local _endDelayFix = (_switchII == #_dirPoints and 0) or 1
                    p_patternEffectCycle();
                    _vortaBarPart(_curSide, _free, p_getTunnelPatternCorridorThickness(), _modeType);
                    _curSide = _curSide + _loopDir;
                    --apply delay
                    if a < _dirPoints[_switchII] + _endDelayFix then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance)); end
                end
                _loopDir = -_loopDir;
            end
        end
    end

    p_patternEffectEnd();
end

function spMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _holes, _offsetType, _offsetDistance, _isInvertAccurate, _beatDistance, _mainLoopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _distance = anythingButNil(_distance, 1); _beatDistance = anythingButNil(_beatDistance, 1);
    if type(_gap) ~= "number" or _gap < 1 then _gap = 1; end
    if type(_holes) ~= "number" or _holes < 1 then _holes = 1; end
    if type(_offsetDistance) ~= "number" or _offsetDistance < 1 then _offsetDistance = 1; end
    if type(_offsetType) ~= "number" then _offsetType = 0; end
    if type(_mainLoopDir) == "number" and _mainLoopDir <= 0 then _mainLoopDir = -1; end

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
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
        if a < _iter then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance)); end
    end

    p_patternEffectEnd();
end

function spMarch31osBarrageSpiralRev(_side, _thickness, _iter, _gap, _holes, _revFreq, _distance, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _beatDistance = anythingButNil(_beatDistance, 1);
    if not _holes or _holes < 1 then _holes = 1; end
    if not _gap or _gap < 1 then _gap = 1; end
    _revFreq = anythingButNil(_revFreq, 1); _distance = anythingButNil(_distance, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _barrageLoopDir = (type(_loopDir) == "number" and math.ceil(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    local _barrageOffset = 0;
    local _revIterAdd = 0;

    for r = 0, _revFreq, 1 do
        if r == _revFreq then _revIterAdd = 1; end
        local _endDelayFix = (r == _revFreq and 0) or 1

        for a = 0, _iter + _revIterAdd, 1 do
            p_patternEffectCycle();

            if _holes > 1 then cBarrageExHoles(_curSide + (_barrageOffset * _distance), _holes - 1, p_getTunnelPatternCorridorThickness());
            else cBarrageGap(_curSide + (_barrageOffset * _distance), _gap, p_getTunnelPatternCorridorThickness());
            end
            _barrageOffset = _barrageOffset + _barrageLoopDir;
            if a < _iter + _revIterAdd + _endDelayFix then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance)); end
        end

        _barrageLoopDir = _barrageLoopDir * -1;
    end

    p_patternEffectEnd();
end

--[ Spirals ]--

function spMarch31osWhirlwind(_side, _iter, _extra, _step, _pos_spacing, _wallLength, _loopDir, _cleanAmountStart, _cleanAmountEnd, _is_full, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _wallLength = anythingButNil(_wallLength, 1);
    _extra = anythingButNil(_extra, 0); _step = anythingButNil(_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    if not _cleanAmountStart or _cleanAmountStart < 0 then _cleanAmountStart = 0; end
    if not _cleanAmountEnd or _cleanAmountEnd < 0 then _cleanAmountEnd = _cleanAmountStart; end
    _loopDir = (type(_loopDir) == "number" and getNeg(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    _is_full = getBooleanNumber(_is_full);
    if getProtocolSides() == 3 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and _is_full) then
        cBarrage(_curSide + _loopDir, customizeTempoPatternThickness(0.0625 * _wallLength));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(0.5 * _wallLength) + (a == _iter and customizeTempoPatternThickness(0.0625 * _wallLength) / 2 or 0));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizeTempoPatternDelay(0.5 * _wallLength));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _loopDir, customizeTempoPatternThickness(0.0625 * _wallLength));
    elseif getProtocolSides() == 4 and ((_cleanAmountStart > 0 and _cleanAmountEnd > 0) and _is_full) then
        cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(0.25 * _wallLength)); _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
        for i = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + i * _loopDir, customizeTempoPatternThickness(1.25 * _wallLength)); end _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 2;
        t_applyPatDel(customizeTempoPatternDelay(1 * _wallLength));
        for a = 0, _iter + 1, 1 do --1, _iter + 2
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness((a == _iter + 1 and 1.5 or 2.0625) * _wallLength));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizeTempoPatternDelay(1 * _wallLength));
        end
        _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 2;
        for k = 0, 1, 1 do cWall(_curSide + _spiralPosistionOffset + k * _loopDir, customizeTempoPatternThickness(0.5 * _wallLength)); end 
        t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); _spiralPosistionOffset = _spiralPosistionOffset + _loopDir * 3;
        cBarrage(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(0.25 * _wallLength));
    else
        if (_cleanAmountStart > 0) then
            for fa = 0, _cleanAmountStart, 1 do
                for ia = 0, _cleanAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_loopDir * _pos_spacing * (ia - 1)), _step, _extra, customizeTempoPatternThickness(0.3 * _wallLength)); end
                end
                cWallMirrorEx(_curSide + (_loopDir * _pos_spacing * fa) - (_cleanAmountStart * _loopDir * _pos_spacing), _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
                if fa == _cleanAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            end
        end
        for a = 0, _iter * 2 - 2, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
            _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            if a < _iter * 2 - 2 + _cleanAmountEnd then t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); end
            if a == _iter * 2 - 2 then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountEnd > 0) then
            for fb = 0, _cleanAmountEnd, 1 do
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _step, _extra, customizeTempoPatternThickness((fb == _cleanAmountEnd and 0.25 or 0.3) * _wallLength)); end
                if fb < _cleanAmountEnd then t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); end
            end
        end
    end

    p_patternEffectEnd();
end

function spMarch31osWhirlwindRev(_side, _iter, _times_beforeChangeDir, _extra, _step, _pos_spacing, _wallLength, _loopDir, _cleanAmountStart, _cleanAmountCycle, _cleanAmountEnd, _is_full, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(4, 7)); _wallLength = anythingButNil(_wallLength, 1);
    _extra = anythingButNil(_extra, 0); _step = anythingButNil(_step, math.floor(getProtocolSides() / 3)); _pos_spacing = anythingButNil(_pos_spacing, 1); _is_full = anythingButNil(_is_full, 0);
    if _times_beforeChangeDir == nil or _times_beforeChangeDir < 0 then _times_beforeChangeDir = 1; end
    _loopDir = (type(_loopDir) == "number" and getNeg(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();
    if not _cleanAmountStart or _cleanAmountStart < 0 then _cleanAmountStart = 0; end
    if not _cleanAmountCycle or _cleanAmountCycle < 0 then _cleanAmountCycle = _cleanAmountStart; end
    if not _cleanAmountEnd or _cleanAmountEnd < 0 then _cleanAmountEnd = _cleanAmountStart; end

    local currentTimesOfThickAmountForGreaterThanSquare = 0.25;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    _is_full = getBooleanNumber(_is_full);
    if getProtocolSides() == 3 and ((_cleanAmountStart > 0 and _cleanAmountCycle > 0 and _cleanAmountEnd > 0) and _is_full) then
        cBarrage(_curSide + _loopDir, customizeTempoPatternThickness(0.0625 * _wallLength));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness((a == _iter and 1 or 0.5) * _wallLength));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizeTempoPatternDelay(0.5 * _wallLength));
        end
        cWall(_curSide + _spiralPosistionOffset - _loopDir, customizeTempoPatternThickness(1 * _wallLength));
        _loopDir = _loopDir * -1;
        for a = 0, _iter + 1, 1 do
            p_patternEffectCycle();
            cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(0.5 * _wallLength) + (a == _iter and customizeTempoPatternThickness(0.0625 * _wallLength) / 2 or 0));
            _spiralPosistionOffset = _spiralPosistionOffset + _loopDir;
            t_applyPatDel(customizeTempoPatternDelay(0.5 * _wallLength));
        end
        cBarrage(_curSide + _spiralPosistionOffset + _loopDir, customizeTempoPatternThickness(0.0625 * _wallLength));
    elseif getProtocolSides() == 4 and ((_cleanAmountStart > 0 and _cleanAmountCycle > 0 and _cleanAmountEnd > 0) and _is_full) then _loopDir = _loopDir * -1;
        local currentThickOffsetAmountBeforeDirChangeForSquare_002 = (_iter > 1 and 0.5) or 0
        cBarrage(_curSide - _loopDir, customizeTempoPatternThickness(0.25 * _wallLength));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            if a == 1 then currentThickOffsetAmountBeforeDirChangeForSquare_002 = 0; end
            cWall(_curSide, customizeTempoPatternThickness(((a == _iter and 2.75 or 1) + (_iter == 1 and 0.5 or 0) + currentThickOffsetAmountBeforeDirChangeForSquare_002) * _wallLength));
            if a < _iter then _curSide = _curSide - _loopDir; end
            t_applyPatDel(customizeTempoPatternDelay(((a == _iter and 1.25 or 0.5) + (_iter == 1 and 0.5 or 0) + currentThickOffsetAmountBeforeDirChangeForSquare_002) * _wallLength));
        end
        cWall(_curSide - _loopDir, customizeTempoPatternThickness(((_iter > 0 and 1 or 1.5) - (_iter == 1 and 0.5 or 0)) * _wallLength));
        cBarrage(_curSide + _loopDir, customizeTempoPatternThickness(0.25 * _wallLength));
        t_applyPatDel(customizeTempoPatternDelay(1.25 * _wallLength));
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWall(_curSide + _loopDir, customizeTempoPatternThickness((a == _iter and 1.5 or 1) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay((a == _iter and 1.25 or 0.5) * _wallLength));
            _curSide = _curSide + _loopDir;
        end
        cBarrage(_curSide - _loopDir, customizeTempoPatternThickness(0.25 * _wallLength));
    else
        if (_cleanAmountStart > 0) then
            for fa = 0, _cleanAmountStart, 1 do
                for ia = 0, _cleanAmountStart - fa, 1 do
                    if ia > 0 then cWallMirrorEx(_curSide - (_loopDir * _pos_spacing * (ia - 1)), _step, _extra, customizeTempoPatternThickness(0.5 * _wallLength)); end
                end
                cWallMirrorEx(_curSide + (_loopDir * _pos_spacing * fa) - (_cleanAmountStart * _loopDir * _pos_spacing), _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
                if fa == _cleanAmountStart then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            end
        end
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountCycle > 0) then
            for fb = 0, _cleanAmountCycle - 1, 1 do
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _step, _extra, customizeTempoPatternThickness(0.3 * _wallLength)); end
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
            end
            for hb = 0, _times_beforeChangeDir, 1 do
                if hb < _times_beforeChangeDir then
                    for ib = 0, _cleanAmountCycle, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _step, _extra, customizeTempoPatternThickness(0.3 * _wallLength)); end
                elseif hb == _times_beforeChangeDir then
                    for ib = 0, _cleanAmountCycle - 1, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _step, _extra, customizeTempoPatternThickness(0.3 * _wallLength)); end
                    cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * _cleanAmountCycle), _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
                end
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
            end
            for vb = 1, _cleanAmountCycle, 1 do
                for eb = 0, _cleanAmountCycle - (vb + 1), 1 do
                    if eb >= 0 then
                        for lb = 0, _cleanAmountCycle - (vb + 1), 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * lb), _step, _extra, customizeTempoPatternThickness(0.3 * _wallLength)); end
                    end
                end
                cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * (_cleanAmountCycle - vb)), _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
            end
        else
            for hb = 0, _times_beforeChangeDir, 1 do
                cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * _cleanAmountCycle), _step, _extra, customizeTempoPatternThickness((hb == _cleanAmountCycle and 0.25 or 0.3) * _wallLength));
                t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength));
            end
        end
        _spiralPosistionOffset = _spiralPosistionOffset - (_loopDir * _pos_spacing * 2); _loopDir = _loopDir * -1; -- It's time to reversing the spiral.
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            cWallMirrorEx(_curSide + _spiralPosistionOffset, _step, _extra, customizeTempoPatternThickness(0.25 * _wallLength));
            if a < _iter + _cleanAmountEnd then t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
            if a == _iter then _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing); end
        end
        if (_cleanAmountEnd > 0) then
            for fb = 0, _cleanAmountEnd, 1 do
                for ib = 0, fb, 1 do cWallMirrorEx(_curSide + (_spiralPosistionOffset - (_loopDir * _pos_spacing)) + (_loopDir * _pos_spacing * ib), _step, _extra, customizeTempoPatternThickness((fb == _cleanAmountEnd and 0.25 or 0.3) * _wallLength)); end
                if fb < _cleanAmountEnd then t_applyPatDel(customizeTempoPatternDelay(0.25 * _wallLength)); end
            end
        end
    end

    p_patternEffectEnd();
end

function spMarch31osFullWhirlwind(_side, _iter, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(7, 11));
    _loopDir = (type(_loopDir) == "number" and math.ceil(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralLoopDir = _loopDir;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(thickIncAdj * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizeTempoPatternDelay((getProtocolSides() - 2) * 0.25));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(2 * 0.25));
        _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
        t_applyPatDel(customizeTempoPatternDelay(1.5 * 0.25));
    end
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness((getProtocolSides() - thickDecAdj) * 0.25));
        t_applyPatDel(customizeTempoPatternDelay(1 * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    end
    cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(2 * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;
    cBarrage(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(2 * 0.25));
    t_applyPatDel(customizeTempoPatternDelay(2 * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir;

    p_patternEffectEnd();
end

function spMarch31osFullWhirlwindPrototype(_side, _loopDir, _isRebootingSide)
    _loopDir = (type(_loopDir) == "number" and math.ceil(_loopDir)) or (_loopDir == 0 and getRandomDir()) or getRandomDir();

    local spiralPosistionDirMultOffset = 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _spiralLoopDir = _loopDir;
    local _spiralPosistionOffset = 0;

    for thickIncAdj = 1, getProtocolSides() - 1, 1 do cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(thickIncAdj * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir; end
    t_applyPatDel(customizeTempoPatternDelay((getProtocolSides() - 2) + 0.5 * 0.25));
    for thickDecAdj = 0, getProtocolSides() - 3, 1 do
        if thickDecAdj == getProtocolSides() - 3 then spiralPosistionDirMultOffset = 2; end
        cWall(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness((getProtocolSides() - thickDecAdj) * 0.25)); _spiralPosistionOffset = _spiralPosistionOffset + _spiralLoopDir * spiralPosistionDirMultOffset;
        t_applyPatDel(customizeTempoPatternDelay(1 * 0.25));
    end
    cBarrage(_curSide + _spiralPosistionOffset, customizeTempoPatternThickness(2 * 0.25));

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    _skipEndDelay = getBooleanNumber(_skipEndDelay); if not _skipEndDelay then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

--[ Tunnels ]--

--here's a tunnel what forces you to circle around a very thick wall...but you can personalize everything
function spMarch31osTunnel(_side, _thickness, _iter, _designType, _dirType, _distance, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _sidedir0gap, _sidedir1gap, _sidedir0offset, _sidedir1offset, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _designType = anythingButNil(_designType, 2); _beatDistance = anythingButNil(_beatDistance, 1); _repeatDelayMult = anythingButNil(_repeatDelayMult, 1);
    _distance = anythingButNil(_distance, u_rndInt(2, getProtocolSides() - 1)); _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0); _isAfterGearTeethEnd = anythingButNil(_isAfterGearTeethEnd, 0);
    _sidedir0gap = anythingButNil(_sidedir0gap, 1); _sidedir1gap = anythingButNil(_sidedir1gap, _sidedir0gap); _sidedir0offset = anythingButNil(_sidedir0offset, 0); _sidedir1offset = anythingButNil(_sidedir1offset, _sidedir0offset);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    if not _sidedir0gap or _sidedir0gap < 1 then _sidedir0gap = 1; end
    if not _sidedir1gap or _sidedir1gap < 1 then _sidedir1gap = 1; end
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end

    local _curTunnelCorridorDirGap, _curTunnelCorridorDirOffset = 0, 0; local _curTunnelCorridorDir, _curTunnelSpiralCorridorDir = 1, 1;
    local _amountOfBeforeGearTeethBegin, _timesOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _gearTeethBarrageAmount, _gearTeethBarrageStep, _gearTeethBarrageInc = 1, 0, 0;
    local _gearTeethWallOffsetAmount, _gearTeethWallOffsetStep, _gearTeethWallOffsetInc = 1, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir) * _distance;
    local _amountOfDesignType0, _tunnelSpiralExpected = 1, false;
    local _hasRepeatState = (getBooleanNumber(_hasRepeat) and 1) or 0;

    _gearTeethInc = anythingButNil(_gearTeethInc, p_getTunnelPatternCorridorThickness() * (6 / getProtocolSides()));

    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end
    _isRepeatCorridorDelaySpd = getBooleanNumber(_isRepeatCorridorDelaySpd);

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if _designType == 0 and (a > 0 and a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) and (not _tunnelSpiralExpected) then _amountOfDesignType0 = _distance - 1;
        else _amountOfDesignType0 = 1;
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _tunnelLoopDir > 0 then _curTunnelCorridorDirGap = _sidedir1gap; _curTunnelCorridorDirOffset = _sidedir1offset; _curTunnelCorridorDir = 1 * _curTunnelSpiralCorridorDir;
        else _curTunnelCorridorDirGap = _sidedir0gap; _curTunnelCorridorDirOffset = _sidedir0offset; _curTunnelCorridorDir = -1 * _curTunnelSpiralCorridorDir;
        end

        for repeatAmount = 0, _hasRepeatState, 1 do
            if repeatAmount < _hasRepeatState then _constructDesignCWallExPart(_curSide + 1, _designType, _distance - 2, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2))); end

            _gearTeethBarrageAmount = 1; _gearTeethBarrageStep = 0; _gearTeethBarrageInc = 0;

            for corridorGap = _curTunnelCorridorDirGap, getBarrageSide(_curTunnelCorridorDirOffset + _amountOfDesignType0), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), (p_getTunnelPatternCorridorThickness() + _gearTeethBarrageInc) * _gearTeethSizeMult)
                    if corridorGap < getBarrageSide(_curTunnelCorridorDirOffset + _gearTeethStepLimit) - (_distance - 1) then _gearTeethBarrageStep = _gearTeethBarrageStep + 1;
                        if _gearTeethBarrageStep >= _gearTeethStepDel then _gearTeethBarrageStep = 0; _gearTeethBarrageInc = (_gearTeethBarrageAmount * _gearTeethInc); _gearTeethBarrageAmount = _gearTeethBarrageAmount + 1; end
                    end
                else cWall((corridorGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult)
                end
            end

            _gearTeethWallOffsetAmount = 1; _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = 0;

            for offsetGap = getProtocolSides() - _curTunnelCorridorDirOffset + _amountOfDesignType0, getProtocolSides(), 1 do
                if _gearTeethSizeMult > 0 then
                    cWall((offsetGap * _curTunnelCorridorDir * -1) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - (_curTunnelCorridorDir * (getProtocolSides() + _curTunnelCorridorDirOffset)), (p_getTunnelPatternCorridorThickness() + _gearTeethWallOffsetInc) * _gearTeethSizeMult);
                    if offsetGap < getProtocolSides() - (_gearTeethStepLimit - 1) then _gearTeethWallOffsetStep = _gearTeethWallOffsetStep + 1;
                        if _gearTeethWallOffsetStep >= _gearTeethStepDel then _gearTeethWallOffsetStep = 0; _gearTeethWallOffsetInc = (_gearTeethWallOffsetAmount * _gearTeethInc); _gearTeethWallOffsetAmount = _gearTeethWallOffsetAmount + 1; end
                    end
                else cWall((offsetGap * _curTunnelCorridorDir) + _curSide + _tunnelLoopDir + (_curTunnelCorridorDirOffset * _curTunnelCorridorDir) - _curTunnelCorridorDir, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
                end
            end
            if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
        end

        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
            --for i = 1, _distance - 1, 1 do cWall(_curSide + i, customizeTempoPatternThickness(_curTunnelDel * _wallLength * _curDelaySpeed) + ((p_getTunnelPatternCorridorThickness() / 2))); end
            _constructDesignCWallExPart(_curSide + 1, _designType, _distance - 2, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + ((p_getTunnelPatternCorridorThickness() / 2)));
        end

        if _dirType == 1 then _tunnelSpiralExpected = true;
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then _curSide = _curSide - (_distance + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir; --if a == _iter + _timesOfBeforeGearTeethBegin - 1 then _curSide = _curSide - (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset * _curTunnelCorridorDir; _curTunnelSpiralCorridorDir = _curTunnelSpiralCorridorDir * -1; end
            else _tunnelLoopDir = _tunnelLoopDir * -1 + _distance;
            end
        elseif _dirType == 2 then if u_rndInt(0, 100) > 50 then _tunnelLoopDir = _tunnelLoopDir * -1 + _distance; end
        elseif _dirType == 3 then
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd - 1 then
                if u_rndInt(0, 100) > 50 then _tunnelSpiralExpected = true; _curSide = _curSide - (_distance + (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset) * _curTunnelCorridorDir; _oldCurSide = _curSide if a == _iter + _timesOfBeforeGearTeethBegin - 1 then _curSide = _curSide - (_curTunnelCorridorDirGap - 1) + _curTunnelCorridorDirOffset * _curTunnelCorridorDir; _curTunnelSpiralCorridorDir = _curTunnelSpiralCorridorDir * -1; end
                else _tunnelSpiralExpected = false; _tunnelLoopDir = _tunnelLoopDir * -1 + _distance;
                end
            else _tunnelLoopDir = _tunnelLoopDir * -1 + _distance;
            end
        else _tunnelLoopDir = _tunnelLoopDir * -1 + _distance;
        end

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end

        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance) - (customizePatternDelay(_repeatDelayMult, false) * _hasRepeatState)); end
    end

    p_patternEffectEnd();
end

-- back and forth (double tunnel) patterns
function spMarch31osBackAndForthTunnelAxis(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _beatDistance = anythingButNil(_beatDistance, 1); _repeatDelayMult = anythingButNil(_repeatDelayMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThick or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;
    local _hasRepeatState = (getBooleanNumber(_hasRepeat) and 1) or 0;

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
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
        else
            cWallEx(_curSide, _modeDesign1_adjust, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
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
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2)));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2)));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult); end
                end

                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (_designType == 0 and a == 0) or (_designType == 1 and a >= 0) then _constructBAFTunnelAxisCorridorPart() end
                _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2));
            else _constructBAFTunnelAxisCorridorPart()
            end
        elseif _modeDesign == 2 then
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then _constructBAFTunnelLargeWallPart(_curSide, _repeatCorridorDelay, p_getTunnelPatternCorridorThickness(), _isRepeatCorridorDelaySpd, _designType); end
                for i = 0, math.floor((getProtocolSides() / 6) - 0.5), 1 do cWall(_curSide + (i * 6) + ((a + _tunnelLoopDir) % 2) + 1, p_getTunnelPatternCorridorThickness()); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do
                    local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                    local _dirModuloOffsetFixStat = (i % 2 == 1 and 2) or 1;
                    cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + _dirModuloOffsetFixStat, p_getTunnelPatternCorridorThickness());
                end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then _constructBAFTunnelLargeWallPart(_curSide, a, 4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _designType);
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getTunnelPatternCorridorThickness()); end
                for i = 0, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getTunnelPatternCorridorThickness()); end
            end
        elseif _modeDesign == 3 then
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2))); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getTunnelPatternCorridorThickness());
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) - ((a + _tunnelLoopDir) % 2) + 2, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getTunnelPatternCorridorThickness());
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do
                        local _dirModuloStat = (i % 2 == 1 and -1) or 1;
                        local _dirModuloOffsetFixStat = (i % 2 == 1 and 1) or 0;
                        cWall(_curSide + (i * 3) + (((a + _tunnelLoopDir) % 2) * _dirModuloStat) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7 + _dirModuloOffsetFixStat), p_getTunnelPatternCorridorThickness());
                    end
                end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getTunnelPatternCorridorThickness()); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getTunnelPatternCorridorThickness()); end
                end
            end
        else
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then rWall(_curSide, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2))); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                else cBarrageDoubleHoled(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 0, _free, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
                end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then rWall(_curSide, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance) - (customizePatternDelay(_repeatDelayMult, false) * _hasRepeatState)); end
    end

    p_patternEffectEnd();
end

function spMarch31osBackAndForthTunnelAxisInterpolated(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _beatDistance = anythingButNil(_beatDistance, 1); _repeatDelayMult = anythingButNil(_repeatDelayMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThick or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;
    local _hasRepeatState = (getBooleanNumber(_hasRepeat) and 1) or 0;

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

    local _constructBAFTunnelAxisInterpolatedCorridorPart = function(_iter_count, _dir)
        _constructBAFTunnelAxisInterpolatedCorridorWallDirPart(((_iter_count + _dir) % 2));
    end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart((_tunnelLoopDir % 2), _designType, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if a > 0 and a < getValOfOddOrEven(_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1) + 1 then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _designType, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (1 + _free + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1 - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
                else
                    for j = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (j + 1) + _modeDesign1_offset + (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                    for k = 0, _modeDesign1_adjust - _free, 1 do cWall(_curSide + (k - 1 - _modeDesign1_adjust + _free) - (((a + _tunnelLoopDir) % 2) * (_free + 1)), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale); end
                end

                if _designType ~= 1 then
                    if a < 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir, _isRebootingSide) end
                    if a > (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) - 2 then _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir, _isRebootingSide) end
                else
                    _constructBAFTunnelAxisInterpolatedCorridorPart(a, _loopDir, _isRebootingSide)
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(customizePatternDelay(_repeatDelayMult, false))); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir) % 2), _designType, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
                if a > 0 and a < getValOfOddOrEven(_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1) then _constructBAFTunnelAxisInterpolatedLargeWallDirPart(((_tunnelLoopDir + 1) % 2), _designType, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
            end
        else
            for repeatAmount = 0, _repeatCorridorAmount, 1 do
                if repeatAmount < _repeatCorridorAmount then
                    if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) + 1 + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                    if a > 0 and a < getValOfOddOrEven(_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1) + 1 + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2) * _scale)); end
                end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                    cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
                else cWallDraw(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 2 + _free, getProtocolSides() - (2 + _free), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult * _scale);
                end
                if repeatAmount < _repeatCorridorAmount then t_applyPatDel(customizePatternDelay(_repeatCorridorDelay * _scale, _isRepeatCorridorDelaySpd)); end
            end
            if a < (math.floor((_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd) * 0.5) * 2) then cWall(_curSide + (((_tunnelLoopDir) % 2) * getHalfSides()), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
            if a > 0 and a < getValOfOddOrEven(_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1) then cWall(_curSide + (((_tunnelLoopDir + 1) % 2) * getHalfSides()), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance) - (customizePatternDelay(_repeatDelayMult, false) * _hasRepeatState)); end
    end

    p_patternEffectEnd();
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function spMarch31osBackAndForthTunnelCentral(_side, _corridorThick, _iter, _free, _designType, _modeDesign, _modeDesign1_offset, _modeDesign1_adjust, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _hasRepeat, _repeatDelayMult, _beatDistance, _loopDir, _isRebootingSide)
    _iter = anythingButNil(_iter, u_rndInt(4, 6)); _designType = anythingButNil(_designType, 2); _beatDistance = anythingButNil(_beatDistance, 1); _repeatDelayMult = anythingButNil(_repeatDelayMult, 1);
    _free = anythingButNil(_free, 0); _modeDesign = anythingButNil(_modeDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, _corridorThick or THICKNESS, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = _tunnelLoopDir > 0 and 1 or -1;
    local _timesOfBeforeGearTeethBegin, _amountOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0, 0;
    local _oldGearTeethSizeMult, _saveOldGearTeethSizeMult = 0, 1;
    local _hasRepeatState = (getBooleanNumber(_hasRepeat) and 1) or 0;

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
            _constructTunnelGearTeethCorridorFixPart(_curSide, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust, _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale)
            _constructTunnelGearTeethCorridorFixPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _gearTeethStepDel, _gearTeethStepLimit, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), _modeDesign1_adjust + 1 - _free, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult * _scale);
        else
            cWallEx(_curSide, _modeDesign1_adjust, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult)
            cWallEx(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
        end
    end

    if getProtocolSides() <= 5 then _modeDesign = 2; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if _modeDesign == 1 then
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then
                    _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2)));
                    _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2)));
                end

                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult);
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _gearTeethStepDel, _gearTeethStepLimit, _modeDesign1_adjust + 1, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult);
                else
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + _modeDesign1_offset, _modeDesign1_adjust + 1, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
                    cWallEx(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) - (3 + _modeDesign1_adjust), _modeDesign1_adjust + 1, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
                end

                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                if (_designType == 0 and a == 0) or (_designType == 1 and a >= 0) then _constructBAFTunnelCentralCorridorPart() end
                _constructDesignCWallExPart(_curSide, _designType, _modeDesign1_offset, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2));
                _constructDesignCWallExPart(_curSide + 3 + _modeDesign1_offset + _modeDesign1_adjust, _designType, getProtocolSides() - 3 - _modeDesign1_adjust - (3 + _modeDesign1_offset + _modeDesign1_adjust), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2));
            else _constructBAFTunnelCentralCorridorPart()
            end
        elseif _modeDesign == 2 then
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then _constructBAFTunnelLargeWallPart(_curSide, a, _repeatCorridorDelay, p_getTunnelPatternCorridorThickness(), _isRepeatCorridorDelaySpd, _designType); end
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + 1, p_getTunnelPatternCorridorThickness()); end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then _constructBAFTunnelLargeWallPart(_curSide, a, 4.5 * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult, p_getTunnelPatternCorridorThickness(), p_getDelayPatternBool(), _designType);
            else
                for i = 0, math.floor(getProtocolSides() / 3) - 1, 1 do cWall(_curSide + (i * 3), p_getTunnelPatternCorridorThickness()); end
                for i = 0, getProtocolSides() % 3, 1 do cWall(_curSide - i, p_getTunnelPatternCorridorThickness()); end
            end
        elseif _modeDesign == 3 then
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then
                    for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2))); end
                end
                cWallEx(_curSide + 0 + ((a + _tunnelLoopDir) % 2) + 1, closeValue(getProtocolSides() % 3, 0, 1), p_getTunnelPatternCorridorThickness());
                cWallEx(_curSide + (closeValue(getProtocolSides() % 3, 0, 1) + 3) + ((a + _tunnelLoopDir) % 2) + 1, closeValue((getProtocolSides() % 3) - 1, 0, 1), p_getTunnelPatternCorridorThickness());
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + ((a + _tunnelLoopDir) % 2) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 7), p_getTunnelPatternCorridorThickness()); end
                end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end

            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
                end
            else
                for i = 0, 1, 1 do cWall(_curSide + (i * (closeValue(getProtocolSides() % 3, 0, 1) + 3)), p_getTunnelPatternCorridorThickness()); end
                if getProtocolSides() >= 9 then
                    for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWall(_curSide + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), p_getTunnelPatternCorridorThickness()); end
                end
            end
        else
            for repeatAmount = 0, _hasRepeatState, 1 do
                if repeatAmount < _hasRepeatState then rWall(_curSide, customizePatternThickness(_repeatDelayMult, false) + ((p_getTunnelPatternCorridorThickness() / 2))); end
                if _gearTeethSizeMult > 0 then
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                    cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides(), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, _tunnelLoopDirGearTeeth, _gearTeethInc * _gearTeethSizeMult, p_getTunnelPatternCorridorThickness() * _gearTeethSizeMult)
                else cBarrageVorta(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _free, p_getTunnelPatternCorridorThickness() * _saveOldGearTeethSizeMult);
                end
                if repeatAmount < _hasRepeatState then t_applyPatDel(customizePatternDelay(_repeatDelayMult, false)); end
            end
            if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then rWall(_curSide, customizeTempoPatternThickness(0.5 * _beatDistance) - (customizePatternThickness(_repeatDelayMult, false) * _hasRepeatState) + (p_getTunnelPatternCorridorThickness() / 2)); end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        if a < _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd then t_applyPatDel(customizeTempoPatternDelay(0.5 * _beatDistance) - (customizePatternDelay(_repeatDelayMult, false) * _hasRepeatState)); end
    end

    p_patternEffectEnd();
end

function spMarch31osTrapAround(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignCycle, _modeDesignEnd, _designDelayAdd, _wallLength, _isRebootingSide)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 0); _wallLength = anythingButNil(_wallLength, 1);
    _hasContainedStart = anythingButNil(_hasContainedStart, 0); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _modeDesignStart = anythingButNil(_modeDesignStart, 1); _modeDesignCycle = anythingButNil(_modeDesignCycle, 1); _modeDesignEnd = anythingButNil(_modeDesignEnd, 0);
    if _designDelayAdd == nil or _designDelayAdd < 0 then _designDelayAdd = 0; elseif _designDelayAdd > 0 then _designDelayAdd = 1; end

    -- Prepare the value data.
    local currentDelayMult001, currentDelayMult002, currentBatDesignOffset = 1, 1, 0;
    local currentThickAddAmount_001 = 1;
    local currentTimesOfDelayAmount_001 = 4;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    --i create hard when coding the pattern, well i'm just confused lah...
    local currentTimesOfThickAmount_002 = (getProtocolSides() == 4 and 10) or (getProtocolSides() == 5 and 11) or 12;
    if getProtocolSides() % 2 == 1 and getProtocolSides() >= 6 then currentDelayMult001 = 1; currentDelayMult002 = 1.05; elseif getProtocolSides() % 2 == 0 and getProtocolSides() >= 6 then currentDelayMult001 = 1; currentDelayMult002 = 1; end

    -- when '_modeDesignEnd' is set to value, the index will prepared to code... and yea
    if (_modeDesignEnd == 1 and getProtocolSides() >= 6) then currentDelayMult001 = 1; currentDelayMult002 = 1.05;
    elseif (_modeDesignEnd == 2 and getProtocolSides() >= 6) then currentDelayMult001 = 1; currentDelayMult002 = 1; if getProtocolSides() >= 7 then currentBatDesignOffset = 1; end
    end

    --add some math.floor to prevent to adding the floating points
    _designDelayAdd = math.floor(_designDelayAdd);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curSide' value.
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        if _modeDesignStart == 1 and _designDelayAdd > 0 then _designDelayAdd = 0.5; end
        cBarrageN(_curSide, _neighContainedStart, customizeTempoPatternThickness(((1 + _designDelayAdd) * 0.25) * _wallLength));
        t_applyPatDel(customizeTempoPatternDelay(((4 + (_designDelayAdd * 2)) * 0.25) * _wallLength));
    end
    -- large thickness
    if _modeDesignStart == 1 and _designDelayAdd > 0 then _designDelayAdd = 1; currentDelayMult002 = 1.05; end
    --some number to integer had to be number value in that case...
    local _curStatForLargeThickness = (_modeDesignCycle == 3 and 12.5) or (getProtocolSides() <= 4 and 11) or 12;
    if getProtocolSides() > 3 then cWall(_curSide, customizeTempoPatternThickness(((_curStatForLargeThickness + (_designDelayAdd * 2.5)) * currentDelayMult002 * 0.25) * _wallLength)); end
    --
    if getProtocolSides() >= 6 then
        if _modeDesignStart == 1 then --trap around style
            --if getProtocolSides() >= 10 then modeDesignStartType001_sideOffset = math.floor(getProtocolSides() / 4); end
            local modeDesignStartType001_sideOffset = (getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4)) or 1;
            cWallGrow(_curSide, modeDesignStartType001_sideOffset, customizeTempoPatternThickness(((2.5 + _designDelayAdd) * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        elseif _modeDesignStart == 2 then --wrap around style
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizeTempoPatternThickness(((3 + _designDelayAdd) * 0.25) * _wallLength));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
            t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
        elseif _modeDesignStart == 3 then --both
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizeTempoPatternThickness(((4 + (_designDelayAdd * 1.5)) * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        else --noneness...?
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
            t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
        end
    else
        if getProtocolSides() > 3 then
            cWallGrow(_curSide, 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay((1 * 0.25) * _wallLength));
        else cWall(_curSide, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
        end
    end
    for timesAmount = 0, _iter, 1 do -- repeat until reaching into _iter, stops here
        p_patternEffectCycle();
        if timesAmount > 0 then
            if getProtocolSides() >= 6 then
                if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
                else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
                end
            end
            --if getProtocolSides() < 6 then currentTimesOfDelayAmount_001 = 5; end
            currentTimesOfDelayAmount_001 = (getProtocolSides() < 6 and 5) or 4;
        end
        t_applyPatDel(customizeTempoPatternDelay(((currentTimesOfDelayAmount_001 + _designDelayAdd) * 0.25) * _wallLength));
        --if timesAmount == _iter then currentTimesOfThickAmount_001 = 5; end
        local currentTimesOfThickAmount_001 = (timesAmount == _iter and 5) or 4; -- when the steps stops right here
        if getProtocolSides() >= 6 then -- if sides greater than equal 6 section...
            if _modeDesignCycle == 1 then --trap around style
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((currentTimesOfThickAmount_001 * 0.25) * _wallLength)); end
                t_applyPatDel(customizeTempoPatternDelay((1 * 0.25) * _wallLength));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
            elseif _modeDesignCycle == 2 then --wrap around style
                t_applyPatDel(customizeTempoPatternDelay((1 * 0.25) * _wallLength));
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness(((currentTimesOfThickAmount_001 - 0.5) * 0.25) * _wallLength)); end
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
            elseif _modeDesignCycle == 3 then --both
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness(((4 + (_designDelayAdd * 1.5)) * 0.25) * _wallLength)); end
                t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
            else --noneness...?
                t_applyPatDel(customizeTempoPatternDelay((1 * 0.25) * _wallLength));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
            end
        else -- if sides lower than 6 section...
            if getProtocolSides() > 3 then for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
            else cBarrage(_curSide, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        end
        local _curModeDesignCycleStatForThickAmount_002 = (_modeDesignCycle == 3 and 12) or 11;
        if timesAmount < _iter then -- if timesAmount lower than _iter...
            if getProtocolSides() > 6 then currentTimesOfThickAmount_002 = (_curModeDesignCycleStatForThickAmount_002 + _designDelayAdd);
            elseif getProtocolSides() <= 5 then currentTimesOfThickAmount_002 = (11 + _designDelayAdd);
            end
            t_applyPatDel(customizeTempoPatternDelay((((5 + _designDelayAdd) * currentDelayMult001) * 0.25) * _wallLength));
            if _modeDesignCycle == 3 and getProtocolSides() >= 6 then
                cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizeTempoPatternThickness(((4 + (_designDelayAdd * 1.5)) * 0.25) * _wallLength));
                t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
            end
            if getProtocolSides() > 3 then cWall(_curSide, customizeTempoPatternThickness((((currentTimesOfThickAmount_002 + (_designDelayAdd * 1.25)) * currentDelayMult001) * 0.25) * _wallLength)); end
            if getProtocolSides() > 3 and getProtocolSides() <= 5 then cWallGrow(_curSide, 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cWall(_curSide, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        end
    end
    if getProtocolSides() >= 5 then
        -- We need a cap. Why? Because the steps were stops here for now.
        if _modeDesignEnd == 1 and getProtocolSides() >= 6 then currentDelayMult002 = 1.15 end
        if getProtocolSides() == 5 then currentDelayMult002 = 1.15 end
        t_applyPatDel(customizeTempoPatternDelay((((5 + _designDelayAdd) * currentDelayMult002) * 0.25) * _wallLength));
        if _modeDesignEnd == 1 then --octagon wrap around's barrage precision design
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        elseif (_modeDesignEnd == 2 and getProtocolSides() >= 6) then --kensem's hexaxaz/bat design
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizeTempoPatternThickness((3 * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay((2 * 0.25) * _wallLength));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        elseif (_modeDesignEnd == 3 and getProtocolSides() >= 6) then --both bullshiet same as mode design cycle was 3
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizeTempoPatternThickness(((4 + (_designDelayAdd * 1.5)) * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay(((1 + _designDelayAdd) * 0.25) * _wallLength));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
            end
        else cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizeTempoPatternThickness((2 * 0.25) * _wallLength)); --include wall grow, normal
        end
    elseif getProtocolSides() == 4 then
        t_applyPatDel(customizeTempoPatternDelay((((5 + _designDelayAdd) * currentDelayMult002) * 0.25) * _wallLength));
        cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength));
    else
        t_applyPatDel(customizeTempoPatternDelay((((5 + _designDelayAdd) * currentDelayMult002) * 0.25) * _wallLength));
        cWall(_curSide, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
    end
    if getBooleanNumber(_hasContainedEnd) then
        t_applyPatDel(customizeTempoPatternDelay(((6 + (_designDelayAdd * 2)) * 0.25) * _wallLength));
        -- Set the "C" barrage with neighbors after pattern spawned.
        cBarrageN(_curSide, _neighContainedEnd, customizeTempoPatternThickness(((1 + _designDelayAdd) * 0.25) * _wallLength));
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();
end

function spMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _wallLength, _isRebootingSide)
    -- When the value is nil, the values will automatically indexed itself!
    _wallLength = anythingButNil(_wallLength, 1);
    _hasContainedStart = anythingButNil(_hasContainedStart, 0); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _design = anythingButNil(_design, 0);

    -- Prepare the value data.
    local currentLargeWallsOffsetForLessThanPentagon = getProtocolSides() - 4;
    local isdesign1_extraDecrement, isdesign1_thickIncrement, isdesign1_middleSideIncrement = 2, 4, 0;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curSide' value.
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if (_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, _neighContainedStart, customizeTempoPatternThickness((1 * 0.25) * _wallLength));
        t_applyPatDel(customizeTempoPatternDelay((6 * 0.25) * _wallLength));
    end
    if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
        cWall(_curSide, customizeTempoPatternThickness((3 * 0.25) * _wallLength));
        t_applyPatDel(customizeTempoPatternDelay((6 * 0.25) * _wallLength));
        cBarrage(_curSide, customizeTempoPatternThickness((1 * 0.25) * _wallLength));
    elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
        cWallGrow(_curSide, 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
        cWallGrow(_curSide, 0, customizeTempoPatternThickness((4 * 0.25) * _wallLength));
        t_applyPatDel(customizeTempoPatternDelay((5 * 0.25) * _wallLength));
        for largeWallsOffsetLessThanPent = 0, currentLargeWallsOffsetForLessThanPentagon, 1 do cWall(_curSide + largeWallsOffsetLessThanPent + math.floor(getProtocolSides() / 2), customizeTempoPatternThickness((2 * 0.25) * _wallLength)); end
        t_applyPatDel(customizeTempoPatternDelay((1 * 0.25) * _wallLength));
        cWall(_curSide + math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
        cWall(_curSide + math.floor(getProtocolSides() / 2) + 1 + currentLargeWallsOffsetForLessThanPentagon, customizeTempoPatternThickness((2 * 0.25) * _wallLength));
    elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
        if _design == 1 then --alright, if _design is equal 1 section...
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness((1 * 0.25) * _wallLength));
            for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - isdesign1_extraDecrement, customizeTempoPatternThickness((isdesign1_thickIncrement * 0.25) * _wallLength)); isdesign1_thickIncrement = isdesign1_thickIncrement + 3; isdesign1_extraDecrement = isdesign1_extraDecrement + 1; end
            t_applyPatDel(customizeTempoPatternDelay(((math.floor(getProtocolSides() / 2) + 2) * 0.25) * _wallLength));
            for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), 0, customizeTempoPatternThickness(((math.floor(getProtocolSides() / 2) + math.floor(getProtocolSides() / 2) + 1 + math.floor(getProtocolSides() / 10) + math.floor(getProtocolSides() / 4)) * 0.25) * _wallLength)); end
            t_applyPatDel(customizeTempoPatternDelay((2 * 0.25) * _wallLength));
            for amount002 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                cWall(_curSide + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1 + isdesign1_middleSideIncrement, customizeTempoPatternThickness(((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (isdesign1_middleSideIncrement * 3)) * 0.25) * _wallLength));
                cWall(_curSide + math.floor(getProtocolSides() / 2) - 1 - isdesign1_middleSideIncrement, customizeTempoPatternThickness(((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (isdesign1_middleSideIncrement * 3)) * 0.25) * _wallLength));
                if amount002 < math.floor(getProtocolSides() / 2) - 3 then isdesign1_middleSideIncrement = isdesign1_middleSideIncrement + 1; t_applyPatDel(customizeTempoPatternDelay((2 * 0.25) * _wallLength)); end
            end
        else -- elseif _design is equal 0 section...
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness((1 * 0.25) * _wallLength));
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizeTempoPatternThickness((4 * 0.25) * _wallLength));
            cWallGrow(_curSide, 0, customizeTempoPatternThickness((7 * 0.25) * _wallLength));
            t_applyPatDel(customizeTempoPatternDelay((5 * 0.25) * _wallLength));
            for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), 0, customizeTempoPatternThickness((7 * 0.25) * _wallLength)); end
            t_applyPatDel(customizeTempoPatternDelay((2 * 0.25) * _wallLength));
            for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizeTempoPatternThickness((7 * 0.25) * _wallLength)); end
            for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1, customizeTempoPatternThickness((7 * 0.25) * _wallLength)); end
        end
        t_applyPatDel(customizeTempoPatternDelay((3 * 0.25) * _wallLength));
        cBarrage(_curSide, customizeTempoPatternThickness((3 * 0.25) * _wallLength));
    end
    if (_hasContainedEnd) then
        if _design == 1 then t_applyPatDel(customizeTempoPatternDelay(((isdesign1_middleSideIncrement + 9) * 0.25) * _wallLength));
        else t_applyPatDel(customizeTempoPatternDelay((9 * 0.25) * _wallLength));
        end
        -- Set the wall extra's barrier container after pattern spawned.
        cWallEx(_curSide + 1 + getHalfSides() - _neighContainedEnd, getProtocolSides() - (2 + _neighContainedEnd + (getProtocolSides() % 2)), customizeTempoPatternThickness((1 * 0.25) * _wallLength));
    else
        if _design == 1 then t_applyPatDel(customizeTempoPatternDelay(((isdesign1_middleSideIncrement + 3) * 0.25) * _wallLength));
        else t_applyPatDel(customizeTempoPatternDelay((3 * 0.25) * _wallLength));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();
end
