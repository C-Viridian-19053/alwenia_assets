--[[ Alright then, Marchionne made-a this pattern from march31o_patterns_cage.lua script, but it's garbage when I
tried-a to testing a {Trap/Accurate Wrap} Around-a pattern, Luigi said.

So I made my own of 2 cage paterns (Include Trap Arond & Accurate Bat pattern) with our brothers. ]]
-- Mario

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random

--[[
    void pMariosTrapAroundNew(_side, _freq, _freqInv, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignDesk, _modeDesignCycle, _modeDesignEnd, _neighDesignStart, _neighDesignDesk, _neighDesignCycle, _neighDesignEnd, _designDelAddThick, _designDelAddStart, _designDelAddDesk, _designDelAddCycle, _designDelAddEnd, _isOdd, _isInverted, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pMariosTrapAroundNew(_side, _freq) --, 0, true, false, 0, 0, 2, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, false, false, 1, 1, false, false, 0, 1, 1, 2, false, false
    void pLuigisAccurateBatNew(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _isOdd, _isInverted, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    void pLuigisAccurateBatNew(_side) --, false, false, 0, 0, 0, false, false, 1, 1, false, 0, 1, 1, 2, false, false
]]

function pMariosTrapAroundNew(_side, _freq, _freqInv, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignDesk, _modeDesignCycle, _modeDesignEnd, _neighDesignStart, _neighDesignDesk, _neighDesignCycle, _neighDesignEnd, _designDelAddThick, _designDelAddStart, _designDelAddDesk, _designDelAddCycle, _designDelAddEnd, _isOdd, _isInverted, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    -- optional args
    _freq = anythingButNil(_freq, 0); _freqInv = anythingButNil(_freqInv, 0); _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1); _isOdd = anythingButNil(_isOdd, 0); _isInverted = anythingButNil(_isInverted, 0);
    _hasContainedStart = anythingButNil(_hasContainedStart, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _modeDesignStart = anythingButNil(_modeDesignStart, 2); _modeDesignDesk = anythingButNil(_modeDesignDesk, 1); _modeDesignCycle = anythingButNil(_modeDesignCycle, 1); _modeDesignEnd = anythingButNil(_modeDesignEnd, 0);
    _neighDesignStart = anythingButNil(_neighDesignStart, 0); _neighDesignDesk = anythingButNil(_neighDesignDesk, 0); _neighDesignCycle = anythingButNil(_neighDesignCycle, 0); _neighDesignEnd = anythingButNil(_neighDesignEnd, 1);
    if _designDelAddThick == nil or _designDelAddThick < 0 then _designDelAddThick = 0; elseif _designDelAddThick > 0 then _designDelAddThick = 1; end
    _designDelAddStart = anythingButNil(_designDelAddStart, _designDelAddThick); _designDelAddDesk = anythingButNil(_designDelAddDesk, _designDelAddThick); _designDelAddCycle = anythingButNil(_designDelAddCycle, _designDelAddThick); _designDelAddEnd = anythingButNil(_designDelAddEnd, _designDelAddThick);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- prepare var
    local _currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart()

    -- get start pos delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_isRebootingSide) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_isRebootingSide) and _curSide or -256;
    local _designDelThickCountAddVar = ((_designDelAddStart + _designDelAddDesk + _designDelAddCycle) / 3);
    local _checkOddInt = (getBooleanNumber(_isOdd) and getProtocolSides() % 2 == 1) and 1 or 0;
    local _oddValueFix = (_checkOddInt + ((getBooleanNumber(_isInverted) and getProtocolSides() % 2 == 1) and 1 or 0)) % 2;

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
                (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _sub_isOddAlt or 0) % 2,
                getPolySides(4, "floor") - _sub_neighbors, --getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4) - _sub_neighbors or 1, -- target
            customizePatternThickness(_thickCount * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        else
            if getProtocolSides() % 2 == 1 then
                _wallGrowPart(_sub_side + ((getPolySides(2, "floor") * (_sub_isOppositeSideAlt % 2))),
                    (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _sub_isOddAlt or 0) % 2, getPolySides(2, "ceil") - (2 + _sub_neighbors),
                customizePatternThickness(_thickCount * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            else
                _barrageNPart(_sub_side + ((getPolySides(2, "floor") * ((_sub_isOppositeSideAlt + 1) % 2))),
                    (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _sub_isOddAlt or 0) % 2, _sub_neighbors,
                customizePatternThickness(_thickCount * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
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
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 2 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
        else
            if _modeDesignAlt == 2 or _modeDesignAlt == 3 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, _modeDesignAlt == 3 and 4 + (_designDelCountAdd * 2) or 2.5 + (_designDelCountAdd * 0.5)) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 1 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
        end
        if getProtocolSides() > 3 and _largeThickCount > 0 then
            _wallPart(_side + ((getPolySides(2, "floor") * (_isOppositeSideAlt % 2))),
                (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _isOddAlt or 0) % 2,
            customizePatternThickness(_largeThickCount * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
        end
        t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
    end
    local _deskPart = function(_side, _isOddAlt, _isOppositeSideAlt, _modeDesignSubCycleAlt, _neighbors, _thickCount, _delEndCount, _designDelCountAdd, _isInverted)
        _thickCount = _thickCount or 5;
        _delEndCount = _delEndCount or 4;
        _neighbors = _neighbors or 0;
        _designDelCountAdd = _designDelCountAdd or 0;
        if (_isInverted) then
            if _modeDesignSubCycleAlt == 1 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 1.5) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    (getProtocolSides() % 2 == 1 and _isOddAlt or 0) % 2,
                customizePatternThickness(2 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
            end
            t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
        else
            if _modeDesignSubCycleAlt == 1 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + (_designDelCountAdd * 1.5)) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if _modeDesignSubCycleAlt == 2 then
                t_applyPatDel(customizePatternDelay(1 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                customizePatternThickness(2 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
            end
            if _modeDesignSubCycleAlt < 2 then
                t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 0.5) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
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
    local _modeDesignStart = 0
    local _modeDesignDesk = 0
    local _modeDesignCycle = 0
    local _modeDesignEnd = 0
    local _neighDesignStart = 0
    local _neighDesignDesk = 0
    local _neighDesignCycle = 0
    local _neighDesignEnd = 0
    local _designDelAddStart = 0
    local _designDelAddDesk = 0
    local _designDelAddCycle = 0
    local _designDelAddEnd = 0
    local _isOdd = 0
    local _isInverted = 0
    ]]

    --[ -= Starting of pattern code =- ]--
    if getBooleanNumber(_isInverted) then
        if (getBooleanNumber(_hasContainedEnd)) then
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedStart, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 8 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignCycle > 0 and _freq > 0 and 1 + _designDelAddCycle or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2,
                         aInv == 0 and _modeDesignEnd   or aInv == _freqInv and _modeDesignStart   or _modeDesignCycle,
                        (aInv == 0 and _neighDesignEnd  or aInv == _freqInv and _neighDesignStart  or _neighDesignCycle) + ((aInv > 0 and aInv < _freqInv) and 1 or 0),
                        (aInv < _freqInv - 1 and thickwall + (aInv == _freqInv - 2 and 1 or 0) or 0), (aInv == _freqInv and getBooleanNumber(_hasContainedEnd) and 0 or 5) + delGapFix,
                         aInv == 0 and _designDelAddEnd or aInv == _freqInv and _designDelAddStart or _designDelAddCycle,
                    true)
                end
            else
                for aInv = 0, _freqInv do
                    for aMain = 0, _freq do
                        p_patternEffectCycle();
                        local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0)
                        _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignEnd or _modeDesignCycle, aMain == 0 and _neighDesignEnd or _neighDesignCycle, thickwall,             5 - (_modeDesignDesk > 0 and 1 or 0), _designDelAddEnd,  true) --end
                        _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                   _neighDesignDesk,                                    aMain == 0 and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk, true) --desk
                    end
                    _bodyPart(_curSide, _checkOddInt, (_checkOddInt + aInv) % 2, _modeDesignStart, _neighDesignStart, 0, 5, _designDelAddStart, true) --start
                end
            end
        else
            for aInv = 0, _freqInv do
                for aMain = 0, _freq do
                    p_patternEffectCycle();
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignEnd or _modeDesignCycle, aMain == 0 and _neighDesignEnd or _neighDesignCycle, thickwall,             5 - (_modeDesignDesk > 0 and 1 or 0), _designDelAddEnd,  true) --end
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                   _neighDesignDesk,                                    aMain == 0 and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk, true) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignStart, _neighDesignStart, 0, 5, _designDelAddStart, true) --start
            end
        end
        if (getBooleanNumber(_hasContainedStart)) then
            t_applyPatDel(customizePatternDelay(1 * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_checkOddInt % 2) * getHalfSides()), _checkOddInt % 2, _neighContainedEnd, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
    else
        if (getBooleanNumber(_hasContainedStart)) then
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedStart, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 8 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignCycle > 0 and _freq > 0 and 1 + _designDelAddCycle or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2,
                         aInv == 0 and _modeDesignStart   or aInv == _freqInv and _modeDesignEnd   or _modeDesignCycle,
                        (aInv == 0 and _neighDesignStart  or aInv == _freqInv and _neighDesignEnd  or _neighDesignCycle) + ((aInv > 0 and aInv < _freqInv) and 1 or 0),
                        (aInv < _freqInv - 1 and thickwall + (aInv == _freqInv - 2 and 1 or 0) or 0), (aInv == _freqInv and getBooleanNumber(_hasContainedEnd) and 0 or 5) + delGapFix,
                         aInv == 0 and _designDelAddStart or aInv == _freqInv and _designDelAddEnd or _designDelAddCycle,
                    true)
                end
            else
                for aInv = 0, _freqInv do
                    for aMain = 0, _freq do
                        p_patternEffectCycle();
                        local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0)
                        _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignStart or _modeDesignCycle, aMain == 0 and _neighDesignStart or _neighDesignCycle, thickwall,                 5,                                    _designDelAddStart, false) --start
                        _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                     _neighDesignDesk,                                      aMain == _freq and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk,  false) --desk
                    end
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignEnd, _neighDesignEnd, 0, aInv == _freqInv and getBooleanNumber(_hasContainedEnd) and 0 or 5, _designDelAddEnd, false) --end
                end
            end
        else
            for aInv = 0, _freqInv do
                for aMain = 0, _freq do
                    p_patternEffectCycle();
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0)
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignStart or _modeDesignCycle, aMain == 0 and _neighDesignStart or _neighDesignCycle, thickwall,                 5,                                    _designDelAddStart, false) --start
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                     _neighDesignDesk,                                      aMain == _freq and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk,  false) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignEnd, _neighDesignEnd, 0, aInv == _freqInv and getBooleanNumber(_hasContainedEnd) and 0 or 5, _designDelAddEnd, false) --end
            end
        end
        if (getBooleanNumber(_hasContainedEnd)) then
            t_applyPatDel(customizePatternDelay((1 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedEnd, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd()

    -- end delay (optional arg, default false)
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function pLuigisAccurateBatNew(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _isOdd, _isInverted, _delMult, _scale, _isRebootingSide, _endAdditionalDelay, _addMult, _thickMult_nonSpd, _spdIs_greaterThanEqual, _isTight, _skipEndDelay)
    -- optional args
    _delMult = anythingButNil(_delMult, 1); _scale = anythingButNil(_scale, 1);
    if _delMult > 1.5 then _delMult = 1.5; end
    _hasContainedStart = anythingButNil(_hasContainedStart, 0); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _design = anythingButNil(_design, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- prepare var
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIs_greaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIs_greaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_thickMult_nonSpd' value ]]
    p_adjustPatternDelaySettings(_spdIs_greaterThanEqual or 2, _thickMult_nonSpd or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- get start pos delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
    local _checkOddInt = (getBooleanNumber(_isOdd) and getProtocolSides() % 2 == 1) and 1 or 0;

    -- required commons.
    local _wallPart = function(_side, _isOppositeSideAlt, _thickness)                   for i = 0, _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                                   end
    local _wallDrawPart = function(_side, _isOppositeSideAlt, _min, _max, _thickness)   for i = _min, _max + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                         end
    local _wallGrowPart = function(_side, _isOppositeSideAlt, _grow, _thickness)        for i = -_grow, _grow + _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end                                      end
    local _barrageNPart = function(_side, _isOppositeSideAlt, _neighbors, _thickness)   for i = _neighbors + 1, (getBarrageSide() - _neighbors) - _isOppositeSideAlt, 1 do cWall(_side + i, _thickness); end    end
    --

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if getBooleanNumber(_isInverted) then
        if (_hasContainedEnd) then
            -- set c barrage neighbors
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide + math.ceil(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == 1 then --alright, if _design is equal 1 section...
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    local _addSide = math.floor(getProtocolSides() / 2) - 2;
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (1 + amount001) + (getProtocolSides() % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - (1 + amount001) + (_checkOddInt % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                    if amount001 == 0 then cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), (getProtocolSides() % 2 == 1 and _checkOddInt % 2 == 0) and 1 or 0, customizePatternThickness(7 + (_addSide * 2.5) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                end
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
                    _wallGrowPart(_curSide, _checkOddInt % 2, amount001, customizePatternThickness(3.5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                end
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            else
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(8 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(6.5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(3.5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            end
        end
        if (_hasContainedStart) then
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
    else
        if (_hasContainedStart) then
            -- set c barrage neighbors
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == 1 then --alright, if _design is equal 1 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - (amount001 + 2), customizePatternThickness((4 + (amount001 * 3)) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay((math.floor(getProtocolSides() / 2) + 2) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness((math.floor(getProtocolSides() / 2) + math.floor(getProtocolSides() / 2) + 1 + math.floor(getProtocolSides() / 10) + math.floor(getProtocolSides() / 4)) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for amount002 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1 + amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2) - amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                    if amount002 < math.floor(getProtocolSides() / 2) - 3 then t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
                end
            else -- elseif _design is equal 0 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool())); end
            end
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if (_hasContainedEnd) then
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_getDelayPatternThickMultOfNoSpdMultMode() * _scale, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- end delay (optional arg, default false)
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
