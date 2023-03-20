--[[
    void pMarch31osBarrage(_side, _thickness, _neighbors, _sizeMult)
    void pMarch31osBarrage(_side, _thickness) --, 0, 1
    void pMarch31osRandomBarrages(_side, _thickness, _iter, _delMult, _sizeMult)
    void pMarch31osRandomBarrages(_side, _thickness, _iter) --, 1, 1
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    void pMarch31osAlternatingBarrage(_side, _thickness, _iter), 1, 1, getRandomDir()
    void pMarch31osVortexBarrageRev(_side, _thickness, _iter, _subIter, _vortaBarType, _free, _delMult, _sizeMult, _direction)
    void pMarch31osVortexBarrageRev(_side, _thickness, _iter) --, 0, 0, 0, 1, 1, getRandomDir()
    void pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    void pMarch31osBarrageSpiral(_side, _thickness, _iter) --, 1, 1, false, 1, 1, getRandomDir()
    void pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _sizeMult, _direction)
    void pMarch31osBarrageReversals(_side, _thickness, _iter) --, 1, false, 1, 1, u_rndInt(0, 1)
    void pMarch31osWallStrip(_side, _thickness, _repetitions, _mirrorStep, _extraWidth, _delMult, _sizeMult, _isThickness)
    void pMarch31osWallStrip(_side, _thickness, _repetitions) --, u_rndInt(2, 3), 0, 1, 1, u_rndInt(0, 1)

    void pMarch31osWhirlwind(_side, _iter, _extraWidth, _mirrorStep, _delMult, _sizeMult, _direction)
    void pMarch31osWhirlwind(_side, _iter) --, 0, math.floor(getProtocolSides() / 3), 1, 1, getRandomDir()
    void pMarch31osWhirlwindRev(_side, _iter, _revFreq, _extraWidth, _mirrorStep, _delMult, _sizeMult, _direction)
    void pMarch31osWhirlwindRev(_side, _iter) --, 1, 0, math.floor(getProtocolSides() / 3), 1, 1, getRandomDir()

    void pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter, _delMult, _sizeMult, _direction)
    void pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter) --, 1, 1, getRandomDir()
]]

--[ Commons ]--

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

-- pMarch31osBarrage(): spawns a patternized cBarrageN with a delay
-- _neighbors: neighbors of the barrage
function pMarch31osBarrage(_side, _thickness, _neighbors, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _sizeMult = anythingButNil(_sizeMult, 1); _neighbors = anythingButNil(_neighbors, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;

    cBarrageN(_curSide, _neighbors, p_getPatternThickness() * _sizeMult);

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 8 or 11)));
end

-- pMarch31osRandomBarrage(): spawns barrages with random side, and waits humanly-possible times depending on the sides distance
function pMarch31osRandomBarrage(_side, _thickness, _delMult, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(2, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _oldCurSideTarget = _curSide;
    local _barrageDistanceDelay = 0;
    local _curRandDist = 0;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cBarrage(_curSide, p_getPatternThickness() * _sizeMult);
        _oldCurSideTarget = _curSide;
        _curRandDist = u_rndInt(-getHalfSides("floor"), getHalfSides("floor"));
        _curSide = _curSide + _curRandDist;
        _barrageDistanceDelay = _curSide - _oldCurSideTarget;
        if _barrageDistanceDelay < 0 then _barrageDistanceDelay = _barrageDistanceDelay * -1; end
        t_applyPatDel(customizePatternDelay((2 + (_barrageDistanceDelay * 2) * (6 / getProtocolSides())) * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
    end

    cBarrage(_curSide, p_getPatternThickness() * _sizeMult);

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 8 or 11)));
end

-- pMarch31osAlternatingBarrage(): spawns a series of cWallExM
function pMarch31osAlternatingBarrage(_side, _thickness, _iter, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(3, 5)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, 0);
    _isSpiral = getBooleanNumber(anythingButNil(_isSpiral, 0));
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageOffset, _barrageLoopDir = 0, _direction;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cWallExM(_curSide + _barrageOffset, (math.floor(getProtocolSides() / 2)) + (_barrageLoopDir * 0.5 - 0.5), 2, p_getPatternThickness() * _sizeMult);
        _barrageOffset = _barrageOffset + _barrageLoopDir;
        _barrageLoopDir = _barrageLoopDir * -1;
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osVortexBarrageRev(): spawns left-left right-right spiral patters
--      _subIter: how many times the direction will halt, idk smth
-- _vortaBarType: vortex barrage type
--         _free: free amount of vortex barrage
function pMarch31osVortexBarrageRev(_side, _thickness, _iter, _subIter, _vortaBarType, _free, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, 1); _subIter = anythingButNil(_subIter, 0); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _vortaBarType = anythingButNil(_vortaBarType, 0); _free = anythingButNil(_free, 0);
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and getRandomDir()) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternHalfSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _revFreqAdd = 0;

    local _vortaBarPart = function(_side, _free, _thickness, _vortaBarType)
        --spawn piece; apply delay
        if _vortaBarType == 1 then
            cWallEx(_side, closeValue(getProtocolSides() % 3, 0, 1) + 1, _thickness);
            cWallEx(_side + (closeValue(getProtocolSides() % 3, 0, 1) + 3), closeValue((getProtocolSides() % 3) - 1, 0, 1) + 1, _thickness);
            if getProtocolSides() >= 9 then
                for i = 0, math.floor(getProtocolSides() / 3) - 3, 1 do cWallEx(_side + (i * 3) + (closeValue(getProtocolSides() % 3, 0, 1) + closeValue((getProtocolSides() % 3) - 1, 0, 1) + 6), 1, _thickness); end
            end
        else cVortaBarrage(_side, _free, _thickness);
        end
        t_applyPatDel(customizePatternDelay(3.6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    for j = 0, _subIter, 1 do
        for a = 0, _iter, 1 do
            p_patternEffectCycle();
            _vortaBarPart(_curSide, _free, p_getPatternThickness() * _sizeMult, _vortaBarType);
            _curSide = _curSide + _direction
        end

        _direction = -_direction;

        for a = 0, _iter + 1, 1 do
            p_patternEffectCycle();
            _vortaBarPart(_curSide, _free, p_getPatternThickness() * _sizeMult, _vortaBarType);
            _curSide = _curSide + _direction
        end
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osBarrageSpiral(): spawns a spiral of cBarrage where you need to change direction
--             _gap: the gap of this barrage
--        _distance: the distance of this barrage
-- _isDelayDistance: is distance has an accurate delay in it?
function pMarch31osBarrageSpiral(_side, _thickness, _iter, _gap, _distance, _isDelayDistance, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _revFreq = anythingButNil(_revFreq, u_rndInt(1, 2)); _distance = anythingButNil(_distance, 1);
    _gap = closeValue((type(_gap) == "number" and _gap or 0), 0, 999, "min");

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and -1) or getRandomDir();
    local _barrageOffset = 0;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cBarrageGap(_curSide + (_barrageOffset * _distance), _gap, p_getPatternThickness());
        _barrageOffset = _barrageOffset + _barrageLoopDir;
        t_applyPatDel(customizePatternDelay(4 * (getBooleanNumber(_isDelayDistance) and (_distance * 0.333 + 0.667) or 1) * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osBarrageReversals(): spawns a barrage who force you to turn 180 degrees
--              _gap: the gap of this barrage
-- _isInvertAccurate: boolean of inverse barrage accuration
function pMarch31osBarrageReversals(_side, _thickness, _iter, _gap, _isInvertAccurate, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(2, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _gap = closeValue((type(_gap) == "number" and _gap or 0), 0, 999, "min");

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _barrageLoopDir = closeValue((type(_barrageLoopDir) == "number" and _barrageLoopDir or getRandomDir()), 0, 1);
    local _barrageOffset = 0;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        if (a + _barrageLoopDir) % 2 == 1 and getBooleanNumber(_isInvertAccurate) then cWallEx(_curSide + 1 + getHalfSides(), getProtocolSides() - (2 + _gap), p_getPatternThickness());
        else cBarrageGap(_curSide + (((a + _barrageLoopDir) % 2) * getHalfSides()), _gap, p_getPatternThickness());
        end
        t_applyPatDel(customizePatternDelay(6 * _delMult * _sizeMult * _curDelaySpeed, p_getDelayPatternBool()));
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osWallStrip(): spawns cMirrorWallExs close to one another on the same side
-- _repetitions: same as <_iter> parameter, how many repeat in this wall
--  _mirrorStep: amount of mirror step
--  _extraWidth: amount of extras in this wall
-- _isThickness: boolean of thickness mode
function pMarch31osWallStrip(_side, _thickness, _repetitions, _mirrorStep, _extraWidth, _delMult, _sizeMult, _isThickness)
    _repetitions = anythingButNil(_repetitions, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _mirrorStep = anythingButNil(_mirrorStep, u_rndInt(2, 3)); _extraWidth = anythingButNil(_extraWidth, 0);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;

    if getBooleanNumber(_isThickness) then
        p_patternEffectCycle();
        cMirrorWallEx(_curSide, _mirrorStep, _extraWidth, customizePatternThickness((2.75 * _repetitions) * _delMult * _sizeMult * _curDelaySpeed, false) + (p_getPatternThickness() * _sizeMult));
        t_applyPatDel(customizePatternDelay((2.75 * (_repetitions + 1)) * _delMult * _sizeMult * _curDelaySpeed, false));
    else
        for a = 0, _repetitions, 1 do
            p_patternEffectCycle();
            cMirrorWallEx(_curSide, _mirrorStep, _extraWidth, p_getPatternThickness() * _sizeMult);
            t_applyPatDel(customizePatternDelay(2.75 * _delMult * _sizeMult * _curDelaySpeed, false));
        end
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

--[ Spirals ]--

-- pMarch31osWhirlwind(): spawns a spiral of cMirrorWallEx
-- _extraWidth: amount of extras in this cMirrorWallEx
-- _mirrorStep: amount of mirror step
function pMarch31osWhirlwind(_side, _iter, _extraWidth, _mirrorStep, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _extraWidth = anythingButNil(_extraWidth, 0); _mirrorStep = anythingButNil(_mirrorStep, math.floor(getProtocolSides() / 3));
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and -1) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternSettings()

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _spiralPosistionOffset = 0;

    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirrorStep, _extraWidth, customizePatternThickness(2.2 * _sizeMult, p_getDelayPatternBool()));
        _spiralPosistionOffset = _spiralPosistionOffset + _direction;
        t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osWhirlwindRev(): spawns a spiral of cMirrorWallEx where you need to change direction
--    _revFreq: amount of times of direction changes
-- _extraWidth: amount of extras in this cMirrorWallEx
-- _mirrorStep: amount of mirror step
function pMarch31osWhirlwindRev(_side, _iter, _revFreq, _extraWidth, _mirrorStep, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(3, 6)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _revFreq = closeValue((type(_revFreq) == "number" and _revFreq or 0), 0, 999, "min");
    _extraWidth = anythingButNil(_extraWidth, 0); _mirrorStep = anythingButNil(_mirrorStep, math.floor(getProtocolSides() / 3));
    _direction = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and -1) or getRandomDir();

    p_resetPatternDelaySettings();
    p_adjustPatternSettings()

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomDir() end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _spiralPosistionOffset = 0;

    for aInv = 0, _revFreq, 1 do
        local _halt = aInv > 0 and rev == _revFreq and 1 or 0

        for a = 0, _iter + _halt, 1 do
            p_patternEffectCycle();
            cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirrorStep, _extraWidth, customizePatternThickness(2.2 * _sizeMult, p_getDelayPatternBool()));
            _spiralPosistionOffset = _spiralPosistionOffset + _direction;
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        end

        if aInv < _revFreq then
            cMirrorWallEx(_curSide + _spiralPosistionOffset, _mirrorStep, _extraWidth, customizePatternThickness(2.2 * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentDelayOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        end
    end
    t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

--[ Tunnels ]--

-- pMarch31osTunnel(): spawns a tunnel what forces you to circle around a very thick wall
-- _corridorThickOfSpeedLessThan: amount of thickness of speed less than, same as <_thickness>
--   _corridorThickOfSpeedGEThan: amount of thickness pf speed greater than equal, same as <_thickness>
function pMarch31osTunnel(_side, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan, _iter, _delMult, _sizeMult, _direction)
    _iter = anythingButNil(_iter, u_rndInt(1, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternSettings(nil, nil, nil, nil, nil, nil, nil, _corridorThickOfSpeedLessThan, _corridorThickOfSpeedGEThan)

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _tunnelLoopDir = (type(_direction) == "number" and getNeg(_direction)) or (_direction == 0 and -1) or getRandomDir();

    for a = 0, _iter do
        p_patternEffectCycle();
        if a < _iter then cWall(_curSide, customizePatternThickness(9 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()) + (p_getPatternThickness() / 2)) end
        for i = 1, getBarrageSide() do
            cWall(i + _curSide + _tunnelLoopDir, p_getPatternThickness())
        end
        _tunnelLoopDir = _tunnelLoopDir * -1
        t_wait(customizePatternDelay(9 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end
