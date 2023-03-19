--[[
    void p_configContainedPattern(_hasContainedTable, _neighContainedTable)
    void p_configTrapAroundDesign(_hasContainedTable, _neighContainedTable, _designDelAddContainedTable, _modeDesignTable, _neighDesignTable, _designDelAddTable)

    void pMarch31osTrapAround(_side, _freq, _freqInv, _design, _isOdd, _isInverted, _delMult, _sizeMult)
    void pMarch31osTrapAround(_side, _freq) --, 0, nil, false, false, 1, 1
    void pMarch31osTrapPatternizer(_side, _iter, _delMult, _sizeMult, _hasContainedTable, _neighContainedTable)
    void pMarch31osTrapPatternizer(_side, _iter) --, 1, 1, { false, false }, { 0, 0 }
    void pMarch31osAccurateBat(_side, _design, _isOdd, _isInverted, _delMult, _sizeMult, _hasContainedTable, _neighContainedTable)
    void pMarch31osAccurateBat(_side) --, "all", false, false, 1, 1, { false, false }, { 0, 0 }
    void pMarch31osDiamond(_side, _iter, _endHeadFree, _exDelBit, _sizeMult, _hasContainedTable, _neighContainedTable)
    void pMarch31osDiamond(_side, _iter) --, 0, 0, 1, { false, false }, { 0, 0 }
    void pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult)
    void pMarch31osInterpretInversions(_side, _iter) --, 1, 1
    void pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult)
    void pMarch31osDivergencedGauntlets(_side, _iter) --, 1, 1
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

-- [ Pattern utils ] --

march31opatcommon_hasContainedTable = { false, false }
march31opatcommon_neighContainedTable = { 0, 0 }
march31opatcommon_designDelAddContainedTable = { 0, 0 }
march31opatcommon_modeDesignTable = { 0, 0, 0, 0 }
march31opatcommon_neighDesignTable = { 0, 0, 0, 0 }
march31opatcommon_designDelAddTable = { 0, 0, 0, 0 }

-- [ Pattern commons ] --

-- p_configContainedPattern(): generates containers from fan-wrap around and bat patterns. (WORKS ONLY ON TABLES, OTHERWISE DON'T WORK)
--          _hasContainedTable: boolean of containter, only works on table contains booleans
--        _neighContainedTable: amount of free-neighbor containter, only works on table contains integers
function p_configContainedPattern(_hasContainedTable, _neighContainedTable)
    march31opatcommon_hasContainedTable = type(_hasContainedTable) ~= "table" and _hasContainedTable or { false, false }
    march31opatcommon_neighContainedTable = type(_neighContainedTable) ~= "table" and _neighContainedTable or { 0, 0 }
end

-- p_configTrapAroundDesign(): generates design from trap around pattern. (WORKS ONLY ON TABLES, OTHERWISE DON'T WORK)
--          _hasContainedTable: boolean of containter, only works on table contains booleans
--        _neighContainedTable: amount of free-neighbor containter, only works on table contains integers
-- _designDelAddContainedTable: a design delay/thickness amount adder of containter, only works on table contains integers
--            _modeDesignTable: 0 or else = none, 1 = body type 1(?), 2 = body type 2(?), 3 = all(?), only works on table contains integers
--           _neighDesignTable: amount of free-neighbor body, only works on table contains integers
--          _designDelAddThick: a design delay/thickness amount adder. 1 for add delay/thickness amount, 0 = don't, only works on table contains integers
--          _designDelAddTable: 1 for add delay/thickness amount, 0 = don't, only works on table contains integers
function p_configTrapAroundDesign(_hasContainedTable, _neighContainedTable, _designDelAddContainedTable, _modeDesignTable, _neighDesignTable, _designDelAddTable)
    march31opatcommon_hasContainedTable = _hasContainedTable
    march31opatcommon_neighContainedTable = _neighContainedTable
    march31opatcommon_designDelAddContainedTable = _designDelAddContainedTable
    march31opatcommon_modeDesignTable = _modeDesignTable
    march31opatcommon_neighDesignTable = _neighDesignTable
    march31opatcommon_designDelAddTable = _designDelAddTable
end

--[ Additional cages ]--

-- pMarch31osTrapAround(): it's the """"weird or 321"""" pattern from super hexagon where you turn 3 then turn 2 then turn 1...
--                    _freqInv: amount of times to displace to half side pos
--       [RECOMMENDED] _design: design mode. "trap", "trapped", "wrap", "bat" or nil, it automatically generates itself
--                      _isOdd: boolean of odd pattern design
--                 _isInverted: boolean of inverting the pattern design, not the side pos (pattern design * -1, inverted)
--          _hasContainedTable: boolean of containter, only works on table contains booleans
--        _neighContainedTable: amount of free-neighbor containter, only works on table contains integers
-- _designDelAddContainedTable: a design delay/thickness amount adder of containter, only works on table contains integers
--            _modeDesignTable: 0 or else = none, 1 = body type 1(?), 2 = body type 2(?), 3 = all(?), only works on table contains integers
--           _neighDesignTable: amount of free-neighbor body, only works on table contains integers
--          _designDelAddThick: a design delay/thickness amount adder. 1 for add delay/thickness amount, 0 = don't, only works on table contains integers
--          _designDelAddTable: 1 for add delay/thickness amount, 0 = don't, only works on table contains integers

-- note for desk of table int no.2 from <_modeDesignTable> argument: 0 or else = none, 1 = desk type 1(?), 2 = desk type 2(?)

function pMarch31osTrapAround(_side, _freq, _freqInv, _design, _isOdd, _isInverted, _delMult, _sizeMult, _hasContainedTable, _neighContainedTable, _designDelAddContainedTable, _modeDesignTable, _neighDesignTable, _designDelAddTable)
    -- optional args
    _freq = anythingButNil(_freq, 0); _freqInv = anythingButNil(_freqInv, 0); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1); _isOdd = anythingButNil(_isOdd, 0); _isInverted = anythingButNil(_isInverted, 0);

    -- prepare var
    local _currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternSettings();
    _delMult = _delMult * (p_getTightDelayPatternBool() and 0.75 or 1);

    p_patternEffectStart()

    -- get delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _checkOddInt = (getBooleanNumber(_isOdd) and getProtocolSides() % 2 == 1) and 1 or 0;
    local _oddValueFix = (_checkOddInt + ((getBooleanNumber(_isInverted) and getProtocolSides() % 2 == 1) and 1 or 0)) % 2;

    if _design == "trap" then
        march31opatcommon_hasContainedTable = { true, false }
        march31opatcommon_neighContainedTable = { 0, 0 }
        march31opatcommon_designDelAddContainedTable = { 0, 0 }
        march31opatcommon_modeDesignTable = { 2, 1, 0, 0 }
        march31opatcommon_neighDesignTable = { 0, 0, 0, getProtocolSides() < 6 and 0 or 1 }
        march31opatcommon_designDelAddTable = { 0, 0, 0, 0 }
    elseif _design == "trapped" then
        march31opatcommon_hasContainedTable = { true, false }
        march31opatcommon_neighContainedTable = { 0, 0 }
        march31opatcommon_designDelAddContainedTable = { 0, 0 }
        march31opatcommon_modeDesignTable = { 2, 1, 0, 2 }
        march31opatcommon_neighDesignTable = { 0, 0, 0, 0 }
        march31opatcommon_designDelAddTable = { 0, 0, 0, 1 }
    elseif _design == "wrap" then
        march31opatcommon_hasContainedTable = { true, false }
        march31opatcommon_neighContainedTable = { 0, 0 }
        march31opatcommon_designDelAddContainedTable = { 1, 1 }
        march31opatcommon_modeDesignTable = { 1, 2, 0, 0 }
        march31opatcommon_neighDesignTable = { 0, 0, 0, getProtocolSides() < 6 and 0 or 1 }
        march31opatcommon_designDelAddTable = { 1, 1, 1, 0 }
    elseif _design == "bat" then
        march31opatcommon_hasContainedTable = { false, false }
        march31opatcommon_neighContainedTable = { 0, 0 }
        march31opatcommon_designDelAddContainedTable = { 0, 0 }
        march31opatcommon_modeDesignTable = { 1, 2, 0, 2 }
        march31opatcommon_neighDesignTable = { 0, 0, 0, 0 }
        march31opatcommon_designDelAddTable = { 1, 1, 1, 1 }
    end

    if type(march31opatcommon_hasContainedTable) ~= "table"          then error("argument #6 is not a table.", 2)  elseif #march31opatcommon_hasContainedTable < 2          then error("insufficient tables at argument #6.", 2)  end
    if type(march31opatcommon_neighContainedTable) ~= "table"        then error("argument #7 is not a table.", 2)  elseif #march31opatcommon_neighContainedTable < 2        then error("insufficient tables at argument #7.", 2)  end
    if type(march31opatcommon_designDelAddContainedTable) ~= "table" then error("argument #8 is not a table.", 2)  elseif #march31opatcommon_designDelAddContainedTable < 2 then error("insufficient tables at argument #8.", 2)  end
    if type(march31opatcommon_modeDesignTable) ~= "table"            then error("argument #9 is not a table.", 2)  elseif #march31opatcommon_modeDesignTable < 4            then error("insufficient tables at argument #9.", 2)  end
    if type(march31opatcommon_neighDesignTable) ~= "table"           then error("argument #10 is not a table.", 2) elseif #march31opatcommon_neighDesignTable < 4           then error("insufficient tables at argument #10.", 2) end
    if type(march31opatcommon_designDelAddTable) ~= "table"          then error("argument #11 is not a table.", 2) elseif #march31opatcommon_designDelAddTable < 4          then error("insufficient tables at argument #11.", 2) end

    -- required commons.
    local _wallPart = function(_side, _isOppositeSideAlt, _thickness)                   for i = 0, _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                                   end
    local _wallDrawPart = function(_side, _isOppositeSideAlt, _min, _max, _thickness)   for i = _min, _max + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                         end
    local _wallGrowPart = function(_side, _isOppositeSideAlt, _grow, _thickness)        for i = -_grow, _grow + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                      end
    local _barrageNPart = function(_side, _isOppositeSideAlt, _neighbors, _thickness)   for i = _neighbors + 1, (getBarrageSide() - _neighbors) - _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end    end
    -- simplified commons.
    local _halfLegAndHeadPart = function(_sub_side, _sub_isOddAlt, _sub_isOppositeSideAlt, _sub_neighbors, _mode, _thickCount)
        _thickCount = _thickCount or 2
        _sub_neighbors = _sub_neighbors or 0
        if _mode == 1 then
            _wallGrowPart(_sub_side + ((getPolySides(2, "floor") * (_sub_isOppositeSideAlt % 2))),
                (getProtocolSides() % 2 == 1 and _sub_isOddAlt or 0) % 2,
                getPolySides(4, "floor") - _sub_neighbors, --getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4) - _sub_neighbors or 1, -- target
            customizePatternThickness(_thickCount * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        else
            if getProtocolSides() % 2 == 1 then
                _wallGrowPart(_sub_side + ((getPolySides(2, "floor") * (_sub_isOppositeSideAlt % 2))),
                    (getProtocolSides() % 2 == 1 and _sub_isOddAlt or 0) % 2, getPolySides(2, "ceil") - (2 + _sub_neighbors),
                customizePatternThickness(_thickCount * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            else
                _barrageNPart(_sub_side + ((getPolySides(2, "floor") * ((_sub_isOppositeSideAlt + 1) % 2))),
                    (getProtocolSides() % 2 == 1 and _sub_isOddAlt or 0) % 2, _sub_neighbors,
                customizePatternThickness(_thickCount * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    local _bodyPart = function(_side, _isOddAlt, _isOppositeSideAlt, _modeDesignAlt, _neighbors, _largeThickCount, _delEndCount, _designDelCountAdd, _isInverted)
        _largeThickCount = _largeThickCount or 0;
        _delEndCount = _delEndCount or 4;
        _designDelThickCountAdd = _designDelThickCountAdd or 0;
        _designDelCountAdd = _designDelCountAdd or 0;
        if (_isInverted) then
            if _modeDesignAlt == 1 or _modeDesignAlt == 3 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, _modeDesignAlt == 3 and 4 + (_designDelCountAdd * 2) or 2.5 + (_designDelCountAdd * 0.5)) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 2 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        else
            if _modeDesignAlt == 2 or _modeDesignAlt == 3 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, _modeDesignAlt == 3 and 4 + (_designDelCountAdd * 2) or 2.5 + (_designDelCountAdd * 0.5)) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 1 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
        if getProtocolSides() > 3 and _largeThickCount > 0 then
            _wallPart(_side + ((getPolySides(2, "floor") * (_isOppositeSideAlt % 2))),
                (getProtocolSides() % 2 == 1 and _isOddAlt or 0) % 2,
            customizePatternThickness(_largeThickCount * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        t_applyPatDel(customizePatternDelay((_delEndCount + (_designDelCountAdd * 1.25)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    local _deskPart = function(_side, _isOddAlt, _isOppositeSideAlt, _modeDesignSubCycleAlt, _neighbors, _thickCount, _delEndCount, _designDelCountAdd, _isInverted)
        _thickCount = _thickCount or 5;
        _delEndCount = _delEndCount or 4;
        _neighbors = _neighbors or 0;
        _designDelCountAdd = _designDelCountAdd or 0;
        if (_isInverted) then
            if _modeDesignSubCycleAlt == 1 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 1.5) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    (getProtocolSides() % 2 == 1 and _isOddAlt or 0) % 2,
                customizePatternThickness(2 * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
            end
            t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd - 0.5) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        else
            if _modeDesignSubCycleAlt == 1 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + (_designDelCountAdd * 1.5)) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + _designDelCountAdd) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            if _modeDesignSubCycleAlt == 2 then
                t_applyPatDel(customizePatternDelay(closeValue(1 - _designDelCountAdd, 0, 1) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                customizePatternThickness(2 * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
            end
            if _modeDesignSubCycleAlt < 2 then
                t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 0.5) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((_delEndCount + (_designDelCountAdd * 1.25) - 0.5) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    --

    --[[ debug variables-a. I know Marchionne tried to testing and fixing this patterns-e. ]]
    -- Mario
    --[[
    local _freq = 0
    local _freqInv = 4
    local _neighbors = 0
    local march31opatcommon_modeDesignTable[1] = 0
    local march31opatcommon_modeDesignTable[2] = 0
    local march31opatcommon_modeDesignTable[3] = 0
    local march31opatcommon_modeDesignTable[4] = 0
    local march31opatcommon_neighDesignTable[1] = 0
    local march31opatcommon_neighDesignTable[2] = 0
    local march31opatcommon_neighDesignTable[3] = 0
    local march31opatcommon_neighDesignTable[4] = 0
    local march31opatcommon_designDelAddTable[1] = 0
    local march31opatcommon_designDelAddTable[2] = 0
    local march31opatcommon_designDelAddTable[3] = 0
    local march31opatcommon_designDelAddTable[4] = 0
    local _isOdd = 0
    local _isInverted = 0
    ]]

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(_isInverted) then
        if (getBooleanNumber(march31opatcommon_hasContainedTable[2])) then
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, march31opatcommon_neighContainedTable[2], customizePatternThickness((1 + march31opatcommon_designDelAddContainedTable[2]) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + (march31opatcommon_designDelAddContainedTable[2] * 2)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 6 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1.5 + march31opatcommon_designDelAddTable[3] or 0) + march31opatcommon_designDelAddTable[4]
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2,
                         aInv == 0 and march31opatcommon_modeDesignTable[4]   or aInv == _freqInv and march31opatcommon_modeDesignTable[1]   or march31opatcommon_modeDesignTable[3],
                        (aInv == 0 and march31opatcommon_neighDesignTable[4]  or aInv == _freqInv and march31opatcommon_neighDesignTable[1]  or march31opatcommon_neighDesignTable[3]) + ((aInv > 0 and aInv < _freqInv) and 1 or 0),
                        (aInv < _freqInv - 1 and thickwall + (aInv == _freqInv - 2 and 1 or 0) or 0), (aInv == _freqInv and getBooleanNumber(march31opatcommon_hasContainedTable[2]) and 0 or 5) + delGapFix,
                         aInv == 0 and march31opatcommon_designDelAddTable[4] or aInv == _freqInv and march31opatcommon_designDelAddTable[1] or march31opatcommon_designDelAddTable[3],
                    true)
                end
            else
                for aInv = 0, _freqInv do
                    for aMain = 0, _freq do
                        p_patternEffectCycle();
                        local thickwall = 10.5 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[2] > 0 and 1 + march31opatcommon_designDelAddTable[2] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1 + (march31opatcommon_designDelAddTable[3] * 1.5) or 0)
                        _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and march31opatcommon_modeDesignTable[4] or march31opatcommon_modeDesignTable[3], aMain == 0 and march31opatcommon_neighDesignTable[4] or march31opatcommon_neighDesignTable[3], thickwall,             5 - (march31opatcommon_modeDesignTable[2] > 0 and (aMain > 0 and march31opatcommon_modeDesignTable[4] == 0 and 4 or 1) or 0), march31opatcommon_designDelAddTable[4], true) --end
                        _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[2],                                       march31opatcommon_neighDesignTable[2],                                        aMain == 0 and 5 or 4, 5 + (march31opatcommon_modeDesignTable[2] > 0 and 1 or 0),                                                   march31opatcommon_designDelAddTable[2], true) --desk
                    end
                    _bodyPart(_curSide, _checkOddInt, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[1], march31opatcommon_neighDesignTable[1], 0, 5, march31opatcommon_designDelAddTable[1], true) --start
                end
            end
        else
            for aInv = 0, _freqInv do
                for aMain = 0, _freq do
                    p_patternEffectCycle();
                    local thickwall = 10.5 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[2] > 0 and 1 + march31opatcommon_designDelAddTable[2] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1 + (march31opatcommon_designDelAddTable[3] * 1.5) or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and march31opatcommon_modeDesignTable[4] or march31opatcommon_modeDesignTable[3], aMain == 0 and march31opatcommon_neighDesignTable[4] or march31opatcommon_neighDesignTable[3], thickwall,             5 - (march31opatcommon_modeDesignTable[2] > 0 and (aMain > 0 and march31opatcommon_modeDesignTable[4] == 0 and 4 or 1) or 0), march31opatcommon_designDelAddTable[4], true) --end
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[2],                                       march31opatcommon_neighDesignTable[2],                                        aMain == 0 and 5 or 4, 5 + (march31opatcommon_modeDesignTable[2] > 0 and 1 or 0),                                                   march31opatcommon_designDelAddTable[2], true) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[1], march31opatcommon_neighDesignTable[1], 0, 5, march31opatcommon_designDelAddTable[1], true) --start
            end
        end
        if (getBooleanNumber(march31opatcommon_hasContainedTable[1])) then
            t_applyPatDel(customizePatternDelay((1 + (march31opatcommon_designDelAddContainedTable[1] * 2)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_checkOddInt % 2) * getHalfSides()), _checkOddInt % 2, march31opatcommon_neighContainedTable[1], customizePatternThickness((1 + march31opatcommon_designDelAddContainedTable[1]) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    else
        if (getBooleanNumber(march31opatcommon_hasContainedTable[1])) then
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, march31opatcommon_neighContainedTable[1], customizePatternThickness((1 + march31opatcommon_designDelAddContainedTable[1]) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + (march31opatcommon_designDelAddContainedTable[1] * 2)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 6 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1.25 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1.5 + march31opatcommon_designDelAddTable[3] or 0) + march31opatcommon_designDelAddTable[4]
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2,
                         aInv == 0 and march31opatcommon_modeDesignTable[1]   or aInv == _freqInv and march31opatcommon_modeDesignTable[4]   or march31opatcommon_modeDesignTable[3],
                        (aInv == 0 and march31opatcommon_neighDesignTable[1]  or aInv == _freqInv and march31opatcommon_neighDesignTable[4]  or march31opatcommon_neighDesignTable[3]) + ((aInv > 0 and aInv < _freqInv) and 1 or 0),
                        (aInv < _freqInv - 1 and thickwall + (aInv == _freqInv - 2 and 1 or 0) or 0), (aInv == _freqInv and getBooleanNumber(march31opatcommon_hasContainedTable[2]) and 0 or 5) + delGapFix,
                         aInv == 0 and march31opatcommon_designDelAddTable[1] or aInv == _freqInv and march31opatcommon_designDelAddTable[4] or march31opatcommon_designDelAddTable[3],
                    true)
                end
            else
                for aInv = 0, _freqInv do
                    for aMain = 0, _freq do
                        p_patternEffectCycle();
                        local thickwall = 10.75 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[2] > 0 and 1 + march31opatcommon_designDelAddTable[2] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1 + (march31opatcommon_designDelAddTable[3] * 1.5) or 0)
                        _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and march31opatcommon_modeDesignTable[1] or march31opatcommon_modeDesignTable[3], aMain == 0 and march31opatcommon_neighDesignTable[1] or march31opatcommon_neighDesignTable[3], thickwall,                 5,                                                                                   march31opatcommon_designDelAddTable[1], false) --start
                        _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[2],                                                        march31opatcommon_neighDesignTable[2],                                                         aMain == _freq and 5 or 4, 5 + (march31opatcommon_modeDesignTable[2] > 0 and (aMain == _freq and 0 or 1) or 0), march31opatcommon_designDelAddTable[2], false) --desk
                    end
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[4], march31opatcommon_neighDesignTable[4], 0, aInv == _freqInv and getBooleanNumber(march31opatcommon_hasContainedTable[2]) and 0 or 5, march31opatcommon_designDelAddTable[4], false) --end
                end
            end
        else
            for aInv = 0, _freqInv do
                for aMain = 0, _freq do
                    p_patternEffectCycle();
                    local thickwall = 10.75 + (march31opatcommon_modeDesignTable[1] > 0 and aMain == 0 and 1 + march31opatcommon_designDelAddTable[1] or 0) + (march31opatcommon_modeDesignTable[2] > 0 and 1 + march31opatcommon_designDelAddTable[2] or 0) + (march31opatcommon_modeDesignTable[3] > 0 and aMain > 0 and 1 + (march31opatcommon_designDelAddTable[3] * 1.5) or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and march31opatcommon_modeDesignTable[1] or march31opatcommon_modeDesignTable[3], aMain == 0 and march31opatcommon_neighDesignTable[1] or march31opatcommon_neighDesignTable[3], thickwall,                 5,                                                                                   march31opatcommon_designDelAddTable[1], false) --start
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[2],                                                        march31opatcommon_neighDesignTable[2],                                                         aMain == _freq and 5 or 4, 5 + (march31opatcommon_modeDesignTable[2] > 0 and (aMain == _freq and 0 or 1) or 0), march31opatcommon_designDelAddTable[2], false) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, march31opatcommon_modeDesignTable[4], march31opatcommon_neighDesignTable[4], 0, aInv == _freqInv and getBooleanNumber(march31opatcommon_hasContainedTable[2]) and 0 or 5, march31opatcommon_designDelAddTable[4], false) --end
            end
        end
        if (getBooleanNumber(march31opatcommon_hasContainedTable[2])) then
            t_applyPatDel(customizePatternDelay((1 + (march31opatcommon_designDelAddContainedTable[2] * 2)) * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, march31opatcommon_neighContainedTable[2], customizePatternThickness((1 + march31opatcommon_designDelAddContainedTable[2]) * _currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * _currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd()

    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 8 or 11)));
end
pMarch31osWrapAround = pMarch31osTrapAround

-- pMarch31osTrapPatternizer(): same pattern of 321 pattern, taken from patternizer.lua
--             _freqInv: amount of times to displace to half side pos
--          _isInverted: boolean of inverting the pattern design, not the side pos (pattern design * -1, inverted)
--   _hasContainedTable: boolean of containter, only works on table contains booleans
-- _neighContainedTable: amount of free-neighbor containter, only works on table contains integers
function pMarch31osTrapPatternizer(_side, _iter, _delMult, _sizeMult)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, u_rndInt(0, 2)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    -- Prepare the value data.
    local _largeWallThickStat, _designMiddleThickStat, _designMiddleDelayStat = 11, 10, 4;
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternSettings();

    p_patternEffectStart();

    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _curLoopDir = 1;

    if type(march31opatcommon_hasContainedTable) ~= "table"   or #march31opatcommon_hasContainedTable < 2   then march31opatcommon_hasContainedTable = { false, false } end
    if type(march31opatcommon_neighContainedTable) ~= "table" or #march31opatcommon_neighContainedTable < 2 then march31opatcommon_neighContainedTable = { 0, 0 }       end

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(march31opatcommon_hasContainedTable[1]) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, march31opatcommon_neighContainedTable[1], customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    if getProtocolSides() >= 6 then
        local modeDesignStartType001_sideOffset = (getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4)) or 1;
        cGrowWall(_curSide, modeDesignStartType001_sideOffset, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        if getProtocolSides() % 2 == 1 then cGrowWall(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    else cGrowWall(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    for a = 0, _iter do
        if getProtocolSides() >= 6 and getProtocolSides() < 8 then _largeWallThickStat = (a == _iter and 11) or 13;
        elseif getProtocolSides() >= 8 then _largeWallThickStat = 13;
        else _largeWallThickStat = 9;
        end
        local _curStatForLargeThicknessOfDelayMult = (getProtocolSides() >= 6 and _delMult * 0.75 + 0.25) or _delMult;
        local _curStatForLargeThicknessOfDelaySpeed = (getProtocolSides() >= 6 and _curDelaySpeed) or 1;
        if getProtocolSides() >= 6 and getProtocolSides() < 8 then _designMiddleThickStat = (a == _iter and 8) or 6;
        elseif getProtocolSides() >= 8 then _designMiddleThickStat = (a == _iter and 10) or 6;
        else _designMiddleThickStat = 2;
        end
        if getProtocolSides() >= 6 and getProtocolSides() < 8 then _designMiddleDelayStat = (a == _iter and 4) or 6;
        elseif getProtocolSides() >= 8 then _designMiddleDelayStat = 6;
        else _designMiddleDelayStat = 4;
        end
        if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness(_largeWallThickStat * currentSizeOverride * (_curDelaySpeed * (_curStatForLargeThicknessOfDelaySpeed * 0.6 + 0.4)) * _curStatForLargeThicknessOfDelayMult * _sizeMult, p_getDelayPatternBool())) end
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizePatternThickness(_designMiddleThickStat * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
        if getProtocolSides() >= 6 then
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cGrowWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
        end
        t_applyPatDel(customizePatternDelay(_designMiddleDelayStat * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        if a < _iter then
            if getProtocolSides() % 2 == 1 then cGrowWall(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    cGrowWall(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()))
    if getBooleanNumber(march31opatcommon_hasContainedTable[2]) then
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        -- Set the "C" barrage with neighbors after pattern spawned.
        cBarrageN(_curSide, march31opatcommon_neighContainedTable[2], customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osAccurateBat(): the """"accurate"""" bat pattern from Super Hexagon where you have to turn left-left or right-right (guided 180 turn)
--              _design: design mode, "hex" = hexagon affected, "all" all sides affected
--               _isOdd: boolean of odd pattern design
--          _isInverted: boolean of inverting the pattern design, not the side pos (pattern design * -1, inverted)
--   march31opatcommon_hasContainedTable: boolean of containter, only works on table contains booleans
-- march31opatcommon_neighContainedTable: amount of free-neighbor containter, only works on table contains integers
function pMarch31osAccurateBat(_side, _design, _isOdd, _isInverted, _delMult, _sizeMult, march31opatcommon_hasContainedTable, march31opatcommon_neighContainedTable)
    -- optional args
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _delMult > 1.5 then _delMult = 1.5; end
    _design = anythingButNil(_design, "hex");

    -- prepare var
    local currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternSettings();
    _delMult = closeValue(_delMult * (p_getTightDelayPatternBool() and 0.75 or 1), 0, 1.5);

    p_patternEffectStart();

    -- get delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _checkOddInt = (getBooleanNumber(_isOdd) and getProtocolSides() % 2 == 1) and 1 or 0;

    if type(march31opatcommon_hasContainedTable) ~= "table"   or #march31opatcommon_hasContainedTable < 2   then march31opatcommon_hasContainedTable = { false, false } end
    if type(march31opatcommon_neighContainedTable) ~= "table" or #march31opatcommon_neighContainedTable < 2 then march31opatcommon_neighContainedTable = { 0, 0 }       end

    -- required commons.
    local _wallPart = function(_side, _isOppositeSideAlt, _thickness)                   for i = 0, _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                                   end
    local _wallDrawPart = function(_side, _isOppositeSideAlt, _min, _max, _thickness)   for i = _min, _max + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                         end
    local _wallGrowPart = function(_side, _isOppositeSideAlt, _grow, _thickness)        for i = -_grow, _grow + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                      end
    local _barrageNPart = function(_side, _isOppositeSideAlt, _neighbors, _thickness)   for i = _neighbors + 1, (getBarrageSide() - _neighbors) - _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end    end
    --

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(_isInverted) then
        if getBooleanNumber(march31opatcommon_hasContainedTable[2]) then
            -- set c barrage neighbors
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, march31opatcommon_neighContainedTable[2], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _wallPart(_curSide + math.ceil(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == "all" then --alright, if _design is equal 1 section...
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    local _addSide = math.floor(getProtocolSides() / 2) - 2;
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (1 + amount001) + (getProtocolSides() % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - (1 + amount001) + (_checkOddInt % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                    if amount001 == 0 then cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), (getProtocolSides() % 2 == 1 and _checkOddInt % 2 == 0) and 1 or 0, customizePatternThickness(7 + (_addSide * 2.5) * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
                end
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
                    _wallGrowPart(_curSide, _checkOddInt % 2, amount001, customizePatternThickness(3.5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                end
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            else
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(8 * currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(6.5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(3.5 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        end
        if getBooleanNumber(march31opatcommon_hasContainedTable[1]) then
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, march31opatcommon_neighContainedTable[1], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    else
        if getBooleanNumber(march31opatcommon_hasContainedTable[1]) then
            -- set c barrage neighbors
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, march31opatcommon_neighContainedTable[1], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == "all" then --alright, if _design is equal 1 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - (amount001 + 2), customizePatternThickness((4 + (amount001 * 3)) * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay((math.floor(getProtocolSides() / 2) + 2) * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness((math.floor(getProtocolSides() / 2) + math.floor(getProtocolSides() / 2) + 1 + math.floor(getProtocolSides() / 10) + math.floor(getProtocolSides() / 4)) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                for amount002 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1 + amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2) - amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                    if amount002 < math.floor(getProtocolSides() / 2) - 3 then t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
                end
            else -- elseif _design is equal 0 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(7 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(7 * currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
            end
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(((getProtocolSides() / 2) + 3) * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        if (march31opatcommon_hasContainedTable[2]) then
            t_applyPatDel(customizePatternDelay(((getProtocolSides() / 2) + 3) * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, march31opatcommon_neighContainedTable[2], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 8 or 11)));
end
pMarch31osBat = pMarch31osAccurateBat;

-- pMarch31osDiamond(): similiar of 321 pattern, but where you turn 2 and turn 1 instead of 321 ones
--         _endHeadFree: neighbors amount of head free.
--            _exDelBit: amount extra delay bit.
--   march31opatcommon_hasContainedTable: boolean of containter, only works on table contains booleans
-- march31opatcommon_neighContainedTable: amount of free-neighbor containter, only works on table contains integers
function pMarch31osDiamond(_side, _iter, _endHeadFree, _exDelBit, _sizeMult, march31opatcommon_hasContainedTable, march31opatcommon_neighContainedTable)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 0); _exDelBit = anythingButNil(_exDelBit, 0); _sizeMult = anythingButNil(_sizeMult, 1);
    _endHeadFree = anythingButNil(_endHeadFree, 1);
    if _endHeadFree > math.floor(getProtocolSides() / 2) - 2 then _endHeadFree = 0; end
    _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternSettings();
    _delMult = _delMult * (p_getTightDelayPatternBool() and 0.75 or 1);

    p_patternEffectStart();

    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;

    if type(march31opatcommon_hasContainedTable) ~= "table"   or #march31opatcommon_hasContainedTable < 2   then march31opatcommon_hasContainedTable = { false, false } end
    if type(march31opatcommon_neighContainedTable) ~= "table" or #march31opatcommon_neighContainedTable < 2 then march31opatcommon_neighContainedTable = { 0, 0 }       end

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(march31opatcommon_hasContainedTable[1]) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, march31opatcommon_neighContainedTable[1], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    end
    --spawn large walls
    local _currentReduceThickAmountStat = (getProtocolSides() >= 6 and 0.25) or -0.1
    if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) + (_exDelBit * 2) - _currentReduceThickAmountStat) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool())); end
    for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
        cGrowWall(_curSide, adj + 1, customizePatternThickness(((math.floor(getProtocolSides() / 2) - (1 + adj)) * 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
            cWallEx(_curSide + adj + math.floor(getProtocolSides() / 2), getProtocolSides() % 2, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            cWallEx(_curSide - adj + math.floor(getProtocolSides() / 2), getProtocolSides() % 2, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(((1 + math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)) + (_exDelBit * math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)))) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        end
        if a < _iter then
            if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness(((((getProtocolSides() - (getProtocolSides() % 2)) + (_exDelBit * 2) - _currentReduceThickAmountStat) * 2) + 1.5) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool())); end
            for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
                cGrowWall(_curSide, adj + 1, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(((1 + math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)) + (_exDelBit * math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)))) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    for adj = 0, math.floor(getProtocolSides() / 2) - (_endHeadFree + 2), 1 do
        local _currentEndHeadThickAmountStat = adj >= math.floor(getProtocolSides() / 2) - (_endHeadFree + 2) and 2 or 3;
        cGrowWall(_curSide, adj + 1, customizePatternThickness(_currentEndHeadThickAmountStat * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    end
    if getBooleanNumber(march31opatcommon_hasContainedTable[2]) then
        -- Set the "C" barrage with neighbors after pattern spawned.
        t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        cBarrageN(_curSide, march31opatcommon_neighContainedTable[2], customizePatternThickness(1 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

-- pMarch31osInterpretInversions(): a pattern from Super Circles' Super Hexagon clone of circle version where you have to turn left-left or right-right or elsewhat. (3-spin)
function pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, u_rndInt(0, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);

    -- Prepare the value data.
    local currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternSettings();
    _delMult = _delMult * (p_getTightDelayPatternBool() and 0.75 or 1);

    p_patternEffectStart();

    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;
    local _curLoopDir = 1;

    --[ -= Starting of pattern code =- ]--
    if getProtocolSides() >= 6 then
        for sideOffset001 = 0, getProtocolSides() % 2, 1 do
            cGrowWall(_curSide - (getProtocolSides() % 2) + sideOffset001, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    elseif getProtocolSides() < 6 then
        for sideOffset001a = 0, getProtocolSides() % 2, 1 do
            cWall(_curSide - (getProtocolSides() % 2) + sideOffset001a, customizePatternThickness(2 * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
        end
    end
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for sideAmount = 0, math.floor(getProtocolSides() / 2) - 1, 1 do
            local _thickSideAmountStat = (sideAmount == math.floor(getProtocolSides() / 2) - 1 and 2) or 3;
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
            for sideOffset = 0, ((a % 2) * (getProtocolSides() % 2)), 1 do
                cGrowWall(_curSide + sideOffset + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)) - ((a % 2) * (getProtocolSides() % 2)), sideAmount, customizePatternThickness(_thickSideAmountStat * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
                cWall(_curSide + sideOffset + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)) - ((a % 2) * (getProtocolSides() % 2)), customizePatternThickness((sideAmount * 2) * currentSizeOverride * _sizeMult, p_getDelayPatternBool()));
            end
        end
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end
pMarch31osHexazazInversions = pMarch31osInterpretInversions;

-- pMarch31osDivergencedGauntlets(): a pattern from Serponge's Super Hexagon clone (Ultra Hexagon) from Geometry Dash where you have to turn left-right or right-left. (2-spin)
function pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _delMult = _delMult * (p_getTightDelayPatternBool() and 0.75 or 1);

    -- Prepare the value data.
    local currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternSettings();

    p_patternEffectStart();

    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = p_getAddMultPattern() - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    for i = 0, math.floor(getProtocolSides() / 2), 1 do cWall(_curSide + i, customizePatternThickness(4 * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
    t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for d = 0, 1, 1 do
            for i = 1 - d, math.floor(getProtocolSides() / 2) + (((a + 1) % 2) * (getProtocolSides() % 2)) + (d - 1), 1 do cWall(_curSide + i + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)), customizePatternThickness((3 - d) * currentSizeOverride * _sizeMult, p_getDelayPatternBool())); end
            t_applyPatDel(customizePatternDelay(((d + 1) * 2) * currentSizeOverride * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end
pMarch31osRevertingGauntlet = pMarch31osDivergencedGauntlets;
