--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void fMarch31osSwapBarrage(_side, _corridorThickNonSpd, _corridorThickSpd, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osSwapBarrage(_side, _corridorThickNonSpd, _corridorThickSpd) --, 1, 1, false, false, 0, 1, 1, 2
    void fMarch31osSwapCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osSwapCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 1, 1, false, false, 0, 1, 1, 2
    void fMarch31osChance(_side, _corridorThickNonSpd, _corridorThickSpd, _delMult, _sizeMult, _blockDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osChance(_side, _corridorThickNonSpd, _corridorThickSpd) --, 1, 1, getRandomDir(), false, false, 0, 1, 1, 2
    void fMarch31osBarrageNoDelay(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _delMult, _sizeMult, _loopDir, _isRandDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osBarrageNoDelay(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, 1, 1, getRandomDir(), false, false, false, 0, 1, 1, 2
    void fMarch31osFlip(_side, _thickness, _sizeMult, _loopDir, _endAdditionalDelay, _skipEndDelay)
    void fMarch31osFlip(_side) --, THICKNESS, 1, getRandomDir(), 0, false
    void fMarch31osMirrorWhirlwind(_side, _thickness, _iter, _extra, _pos_spacing, _seamless, _delMult, _sizeMult, _loopDir, _blockDir, _is_clean, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osMirrorWhirlwind(_side, _thickness, _iter) --, 0, 1, false, 1, 1, getRandomDir(), getRandomDir(), false, false, false, 0, 1, 1, 2
    void fMarch31osSwapTunnelCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _isLargeWallOnce, _delMult, _sizeMult, _loopDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osSwapTunnelCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, false, 1, 1, u_rndInt(0, 1), false, false, 0, 1, 1, 2
    void fMarch31osBackAndForthTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _variantDesign, _free, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _delMult, _sizeMult, _loopDir, _blockDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    void fMarch31osBackAndForthTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter) --, _u_rndInt(0, 1), 0, false, THICKNESS, getSpeedWallThickness(THICKNESS), 0, 1, 1, 1, false, false, 1, 1, u_rndInt(0, 1), getRandomDir(), false, false, 0, 1, 1, 2
]]

--[ Swap patterns ]--

function fMarch31osSwapBarrage(_side, _corridorThickNonSpd, _corridorThickSpd, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    cSwapBarrage(_curSide, _delMult * _curDelaySpeed * _sizeMult, p_getDelayPatternBool(), p_getPatternThickness() * _sizeMult);

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

function fMarch31osSwapCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _delMult, _sizeMult, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if (a == _iter) then cSwapCorridor(_curSide, true, _delMult * _curDelaySpeed * _sizeMult, p_getDelayPatternBool(), p_getPatternThickness() * _sizeMult);
        else cSwapCorridor(_curSide, false, _delMult * _curDelaySpeed * _sizeMult, p_getDelayPatternBool(), p_getPatternThickness() * _sizeMult);
        end
        _curSide = u_rndInt(_curSide + getHalfSides() - 1, _curSide + getHalfSides() + 1)
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

--[ Swap corridors ]--

function fMarch31osChance(_side, _corridorThickNonSpd, _corridorThickSpd, _delMult, _sizeMult, _blockDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _blockDir = anythingButNil(_blockDir, getRandomDir());
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _corridorBlockDir = _blockDir;

    rWall(_curSide, customizePatternThickness(16 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
    t_applyPatDel(customizePatternDelay(16 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    if _corridorBlockDir > 0 then
        for i = 0, getHalfSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
    else
        for i = getHalfSides(), getProtocolSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

function fMarch31osBarrageNoDelay(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _delMult, _sizeMult, _loopDir, _isRandDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 then _loopDir = getRandomDir(); end
    _isRandDir = anythingButNil(_isRandDir, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _corridorLoopDir = _loopDir;

    _isRandDir = getBooleanNumber(_isRandDir);

    if getProtocolSides() >= 6 then
        for a = 0, _iter, 1 do
            p_patternEffectCycle();

            if a < _iter then
                cWall(_curSide + 1, customizePatternThickness(8 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
                cWall(_curSide - 1, customizePatternThickness(8 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
            end
            cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
            if (_isRandDir) then _curSide = _curSide + getRandomDir() + math.floor(getProtocolSides() / 2);
            else _curSide = _curSide + _corridorLoopDir + math.floor(getProtocolSides() / 2);
            end
            t_applyPatDel(customizePatternDelay(8 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

function fMarch31osFlip(_side, _thickness, _sizeMult, _loopDir, _endAdditionalDelay, _skipEndDelay)
    _sizeMult = anythingButNil(_sizeMult, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < -1 then _loopDir = getRandomDir(); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    for a = 0, math.floor(getProtocolSides() / 2), 1 do
        p_patternEffectCycle();

        cWall(_curSide + a, (_thickness or THICKNESS) * _sizeMult);
        if (getProtocolSides() % 2) == 0 and a > 0 and a < math.floor(getProtocolSides() / 2) then cWall(_curSide - a, (_thickness or THICKNESS) * _sizeMult);
        elseif (getProtocolSides() % 2) == 1 and a > 0 and (_loopDir > 0) then cWall(_curSide - a, (_thickness or THICKNESS) * _sizeMult);
        elseif (getProtocolSides() % 2) == 1 and a < math.floor(getProtocolSides() / 2) and (_loopDir <= 0) then cWall(_curSide - a - 1, (_thickness or THICKNESS) * _sizeMult);
        end
        if a < math.floor(getProtocolSides() / 2) then t_applyPatDel(getPerfectDelay((_thickness or THICKNESS) * _sizeMult)) end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end

--[ Swap spirals ]--

-- baba's inspired patterns
function fMarch31osMirrorWhirlwind(_side, _thickness, _iter, _extra, _pos_spacing, _seamless, _delMult, _sizeMult, _loopDir, _blockDir, _isCleanStart, _isCleanEnd, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(4, 7)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extra = anythingButNil(_extra, 0); _pos_spacing = anythingButNil(_pos_spacing, 1); _isCleanStart = anythingButNil(_isCleanStart, 0); _isCleanEnd = anythingButNil(_isCleanEnd, 0);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end
    _blockDir = anythingButNil(_blockDir, getRandomDir());
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    local currentTimesOfThickAmountForGreaterThanSquare = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    _loopDir = math.floor(_loopDir);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    local _curSpiralThick = 2 * (getBooleanNumber(_seamless) and 1.1 or 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _spiralPosistionOffset = 0;

    if getBooleanNumber(_isCleanStart) then rWallEx(_curSide + _spiralPosistionOffset + (_loopDir * _pos_spacing), _extra, customizePatternThickness(3 * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool())); end
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        if a == _iter and getBooleanNumber(_isCleanEnd) then currentTimesOfThickAmountForGreaterThanSquare = (_curSpiralThick + 1); end
        rWallEx(_curSide + _spiralPosistionOffset, _extra, customizePatternThickness(currentTimesOfThickAmountForGreaterThanSquare * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + (_loopDir * _pos_spacing);
        t_applyPatDel(customizePatternDelay(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    rWallEx(_curSide + _spiralPosistionOffset, _extra, customizePatternThickness(2 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    if getBooleanNumber(_isCleanEnd) then rWallEx(_curSide + _spiralPosistionOffset - (_loopDir * _pos_spacing), _extra, customizePatternThickness(2 * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
    t_applyPatDel(customizePatternDelay(_curSpiralThick * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    if _blockDir > 0 then
        for i = 0, getHalfSides(), 1 do cWall(_curSide + _spiralPosistionOffset + i, -p_getPatternThickness() * _sizeMult); end
    else
        for i = getHalfSides(), getProtocolSides(), 1 do cWall(_curSide + _spiralPosistionOffset + i, -p_getPatternThickness() * _sizeMult); end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

--[ Swap tunnels ]--

function fMarch31osSwapTunnelCorridor(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _isLargeWallOnce, _delMult, _sizeMult, _loopDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelBlockDir = math.floor(_loopDir);

    if (getBooleanNumber(_isLargeWallOnce)) then
        rWall(_curSide, customizePatternThickness(8 * _iter * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
    end

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if a < _iter and (not getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(8 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        if (_tunnelBlockDir + a) % 2 == 0 then
            for i = 0, getHalfSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        else
            for i = getHalfSides(), getProtocolSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
        end
        t_applyPatDel(customizePatternDelay(8 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

-- baba's inspired patterns
function fMarch31osBackAndForthTunnel(_side, _corridorThickNonSpd, _corridorThickSpd, _iter, _variantDesign, _free, _isLargeWallOnce, _gearTeethSizeMult, _gearTeethInc, _gearTeethStepDel, _gearTeethStepLimit, _isBeforeGearTeethBegin, _isAfterGearTeethEnd, _delMult, _sizeMult, _loopDir, _blockDir, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _free = anythingButNil(_free, 0); _variantDesign = anythingButNil(_variantDesign, 0); _modeDesign1_offset = anythingButNil(_modeDesign1_offset, 0); _modeDesign1_adjust = anythingButNil(_modeDesign1_adjust, 0);
    if not _loopDir or _loopDir > 1 or _loopDir < 0 then _loopDir = u_rndInt(0, 1); end _blockDir = anythingButNil(_blockDir, getRandomDir());
    _gearTeethInc = anythingButNil(_gearTeethInc, THICKNESS * (6 / getProtocolSides()));
    _gearTeethSizeMult = anythingButNil(_gearTeethSizeMult, 0); _isBeforeGearTeethBegin = anythingButNil(_isBeforeGearTeethBegin, 0);
    if not _gearTeethStepDel or _gearTeethStepDel < 1 then _gearTeethStepDel = 1; end
    if not _gearTeethStepLimit or _gearTeethStepLimit < 1 then _gearTeethStepLimit = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _corridorThickNonSpd or THICKNESS, _corridorThickSpd);_addMult or march31oPatDel_AddMult or 1

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(_variantDesign == 1 and getRebootPatternSide() or getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _tunnelLoopDir = math.floor(_loopDir);
    local _tunnelLoopDirGearTeeth = 0;
    local _timesOfBeforeGearTeethBegin, _timesOfAfterGearTeethEnd = 0, 0;
    local _amountOfBeforeGearTeethBegin = 0;
    local _oldGearTeethSizeMult = 0;
    local _saveOldGearTeethSizeMult = 1;

    if _tunnelLoopDir > 0 then _tunnelLoopDirGearTeeth = 1; else _tunnelLoopDirGearTeeth = -1; end
    _isBeforeGearTeethBegin = getBooleanNumber(_isBeforeGearTeethBegin); if (_isBeforeGearTeethBegin) then _timesOfBeforeGearTeethBegin = 1; end
    _isAfterGearTeethEnd = getBooleanNumber(_isAfterGearTeethEnd); if (_isAfterGearTeethEnd) then _timesOfAfterGearTeethEnd = 1; end

    if (getBooleanNumber(_isLargeWallOnce)) then
        rWall(_curSide, customizePatternThickness(((3 * (_iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd)) + 3) * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult));
    end

    for a = 0, _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd, 1 do
        p_patternEffectCycle();

        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult > 0 then _oldGearTeethSizeMult = _gearTeethSizeMult; _gearTeethSizeMult = 0; _saveOldGearTeethSizeMult = _oldGearTeethSizeMult; end
        if (_isAfterGearTeethEnd) and a >= _iter + _timesOfBeforeGearTeethBegin + _timesOfAfterGearTeethEnd and _gearTeethSizeMult > 0 then _gearTeethSizeMult = 0; end

        if (getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(3 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
        if _variantDesign == 1 then
            if _gearTeethSizeMult > 0 then
                cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, THICKNESS * (6 / getProtocolSides()) * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                cWallTkns(_curSide - (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides() + (2 + _free), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, -_tunnelLoopDirGearTeeth, THICKNESS * (6 / getProtocolSides()) * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
            else cBarrageDoubleHoled(_curSide + (((a + _tunnelLoopDir + 1) % 2) * getHalfSides()), 0, _free, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
            end
        else
            if _gearTeethSizeMult > 0 then
                cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (_free + 2), _tunnelLoopDirGearTeeth, THICKNESS * (6 / getProtocolSides()) * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
                cWallTkns(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)) + getHalfSides(), _gearTeethStepDel, _gearTeethStepLimit, math.ceil(getProtocolSides() / 2) - (2 + (getProtocolSides() % 2)) - _free, _tunnelLoopDirGearTeeth, THICKNESS * (6 / getProtocolSides()) * _gearTeethSizeMult, p_getPatternThickness() * _gearTeethSizeMult * _sizeMult)
            else cBarrageVorta(_curSide + (((a + _tunnelLoopDir) % 2) * (2 + _free)), _free, p_getPatternThickness() * _saveOldGearTeethSizeMult * _sizeMult);
            end
        end

        _tunnelLoopDirGearTeeth = _tunnelLoopDirGearTeeth * -1
        if (_isBeforeGearTeethBegin) and _amountOfBeforeGearTeethBegin == 0 and _gearTeethSizeMult == 0 then _amountOfBeforeGearTeethBegin = _amountOfBeforeGearTeethBegin + 1; _gearTeethSizeMult = _oldGearTeethSizeMult; end
        t_applyPatDel(customizePatternDelay(3 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    if (getBooleanNumber(_isLargeWallOnce)) then rWall(_curSide, customizePatternThickness(3 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + ((p_getPatternThickness() / 2) * _sizeMult)); end
    t_applyPatDel(customizePatternDelay(3 * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));

    if _blockDir > 0 then
        for i = 0, getHalfSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
    else
        for i = getHalfSides(), getProtocolSides(), 1 do cWall(_curSide + i, p_getPatternThickness() * _sizeMult); end
    end

    p_patternEffectEnd();
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end
