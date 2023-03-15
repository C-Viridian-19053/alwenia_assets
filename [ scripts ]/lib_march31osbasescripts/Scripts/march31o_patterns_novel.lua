--[[
    void pMarch31osRandomWalls(_side, _thickness, _iter, _extra, _mirrorStep, _rndMaxStep, _delMult, _sizeMult)
    void pMarch31osRandomWalls(_side, _thickness, _iter) --, 0, u_rndIntUpper(2), getHalfSides(), 1, 1
    void pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorStep, _isContained, _maxDist, _delMult, _thickMult, _sizeMult)
    void pMarch31osSnakeBarrage(_side, _thickness, _iter) --, 0, (to be indexed if is nil), true, (calculated), 1, 1, 1
    void pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _totalThicknessMult, _delMult, _sizeMult)
    void pMarch31osMidCutSpiral(_side, _iter) --, 1, 2, 2, 1, 1
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

--[ Novels (Inspired from Kodipher's Inflorescence pack) ]--

-- pMarch31osRandomWalls(): a wall with randomized side
--      _extra: amount of exrea walls
-- _mirrorStep: amount of mirror step
-- _rndMaxStep: maximum of random displacement
function pMarch31osRandomWalls(_side, _thickness, _iter, _extra, _mirrorStep, _rndMaxStep, _delMult, _sizeMult)
    _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    p_resetPatternDelaySettings();
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, _thickness or THICKNESS, nil);

    p_patternEffectStart();

    -- optional args
    _rndMaxStep = anythingButNil(_rndMaxStep, getHalfSides());
    _mirrorStep = anythingButNil(_mirrorStep, u_rndIntUpper(2));
    _extra = anythingButNil(_extra, 0);

    --fix negative max step
    _rndMaxStep = math.abs(_rndMaxStep)

    --get delay
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1)

    -- spawn in loop
    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cMirrorWallEx(_curSide, _mirrorStep, _extra, p_getPatternThickness() * _sizeMult);

        t_applyPatDel(customizePatternDelay(2 * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()))
        _curSide = _curSide + u_rndInt(0, _rndMaxStep) * getRandomDir()
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (p_getSkipEndDelayPatternBool() and 0 or getDelaySides(getProtocolSides() / 2)));
end

-- pMarch31osSnakeBarrage(): a snake pattern which player stay on free side
--       _extra: amount of exrea walls
--  _mirrorStep: amount of mirror step
-- _isContained: boolean of has contained
--     _maxDist: maximum distance
--   _thickMult: the thickness multiplier of this wall
function pMarch31osSnakeBarrage(_side, _thickness, _iter, _extra, _mirrorStep, _isContained, _maxDist, _delMult, _thickMult, _sizeMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(8, 16)); _extra = anythingButNil(_extra, 0);
    _delMult = anythingButNil(_delMult, 1); _thickMult = anythingButNil(_thickMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _mirrorStep == nil then
        if u_rndInt(0, 1) == 0 then _mirrorStep = 1; _extra = 1; else _mirrorStep = 2; _extra = 0; end
    end
    _isContained = anythingButNil(_isContained, 1);
    _delayMultSpdLessThan = anythingButNil(_delayMultSpdLessThan, 1); _spdIsGreaterThanEqual = anythingButNil(_spdIsGreaterThanEqual, 2);

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool()and _side or -256;

    if not _maxDist then 
        _maxDist = math.floor(getProtocolSides() / _mirrorStep) - 2 - _extra
        _maxDist = math.max(_maxDist, 0)
    end

    _isContained = getBooleanNumber(_isContained);
    if _isContained then
        cMirrorWallEx(_side, _mirrorStep, _maxDist + _extra, (_thickness or THICKNESS) * _sizeMult);
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _sizeMult);
    end

    _maxDist = math.abs(_maxDist)
    _extra = math.abs(_extra)

    local _sideLimits = {_side, _side + _maxDist}

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        cMirrorWallEx(_side, _mirrorStep, _extra, (_thickness or THICKNESS) * _thickMult * _sizeMult);
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult);
        _side = _side + u_rndInt(0, 1) * getRandomDir();
        _side = closeValue(_side, _sideLimits[1], _sideLimits[2])
    end

    if _isContained then
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult);
        cMirrorWallEx(_sideLimits[1], _mirrorStep, _maxDist + _extra, (_thickness or THICKNESS) * _sizeMult);
    end

    p_patternEffectEnd();
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (p_getSkipEndDelayPatternBool() and 0 or getDelaySides(getProtocolSides() / 2 + 1)));
end

-- pMarch31osMidCutSpiral(): a cut-spiral pattern which player will spin
--         _mirrorStep: amount of mirror step
-- _totalThicknessMult: total multiplier of thickness in this pattern
function pMarch31osMidCutSpiral(_side, _iter, _step, _extra, _mirrorStep, _totalThicknessMult, _delMult, _sizeMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _iter = anythingButNil(_iter, u_rndInt(3, 8)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    -- optional args
    _step = anythingButNil(_step, 1);
    _extra = anythingButNil(_extra, 2);
    _mirrorStep = anythingButNil(_mirrorStep, 1);
    _totalThicknessMult = anythingButNil(_totalThicknessMult, 2);

    p_resetPatternDelaySettings();

    p_patternEffectStart();

    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    if _side == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _side or -256;

    --locals
    local _direction = getRandomDir()

    -- negative shift to flip dir
    if (_step < 0) then
        _step = -_step
        _direction  = -_direction
    end

    local _constructMidCutSpiPart = function(_side, _mirrorStep, _extra)
        cMirrorWallEx(_side, _mirrorStep, _extra)
        t_applyPatDel(getDelayWalls(2) * _curDelaySpeed * _delMult * _sizeMult)
        cMirrorWallEx(_side, _mirrorStep, _extra)
        t_applyPatDel(getDelayWalls(1) * _curDelaySpeed * _delMult * _sizeMult)
    end

    -- new thickness
    local oldThickness = THICKNESS
    THICKNESS = (getAccurateThickness() / 3) * _totalThicknessMult * _sizeMult

    for a = 0, _iter, 1 do
        p_patternEffectCycle();

        _constructMidCutSpiPart(_side, _mirrorStep, _extra)
        _side = _side + _step * _direction
    end

    --restore thickness
    THICKNESS = oldThickness

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (p_getSkipEndDelayPatternBool() and 0 or getDelaySides(getProtocolSides() / 2 + 1)));
end
