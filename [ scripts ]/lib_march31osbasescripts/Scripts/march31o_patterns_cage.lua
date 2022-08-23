--[[
    void pMarch31osTrapAround(_side, _freq, _freqInv, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignDesk, _modeDesignCycle, _modeDesignEnd, _neighDesignStart, _neighDesignDesk, _neighDesignCycle, _neighDesignEnd, _designDelAddThick, _designDelAddStart, _designDelAddDesk, _designDelAddCycle, _designDelAddEnd, _isOdd, _isInverted, _delMult, _scale, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osTrapAround(_side, _freq) --, 0, true, false, 0, 0, 2, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, false, false, 1, 1, false, false, false, 0, 1, 1, 2
    void pMarch31osTrapPatternizer(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    void pMarch31osTrapPatternizer(_side, _iter) --, 0, nil, 0, nil, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _isOdd, _isInverted, _delMult, _scale, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
    void pMarch31osAccurateBat(_side) --, false, false, 0, 0, 0, false, false, 1, 1, false, false, 0, 1, 1, 2
    void pMarch31osDiamond(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _endHeadFree, _exDelBit, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    void pMarch31osDiamond(_side, _iter) --, 0, nil, 0, nil, 0, 0, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    void pMarch31osInterpretInversions(_side, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    void pMarch31osDivergencedGauntlets(_side, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
]]

--[ Additional cages ]--

function pMarch31osTrapAround(_side, _freq, _freqInv, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignDesk, _modeDesignCycle, _modeDesignEnd, _neighDesignStart, _neighDesignDesk, _neighDesignCycle, _neighDesignEnd, _designDelAddThick, _designDelAddStart, _designDelAddDesk, _designDelAddCycle, _designDelAddEnd, _isOdd, _isInverted, _delMult, _scale, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
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
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultOfSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, nil, nil);

    p_patternEffectStart()

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- get delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
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
            customizePatternThickness(_thickCount * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        else
            if getProtocolSides() % 2 == 1 then
                _wallGrowPart(_sub_side + ((getPolySides(2, "floor") * (_sub_isOppositeSideAlt % 2))),
                    (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _sub_isOddAlt or 0) % 2, getPolySides(2, "ceil") - (2 + _sub_neighbors),
                customizePatternThickness(_thickCount * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            else
                _barrageNPart(_sub_side + ((getPolySides(2, "floor") * ((_sub_isOppositeSideAlt + 1) % 2))),
                    (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _sub_isOddAlt or 0) % 2, _sub_neighbors,
                customizePatternThickness(_thickCount * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
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
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 2 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
        else
            if _modeDesignAlt == 2 or _modeDesignAlt == 3 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, _modeDesignAlt == 3 and 4 + (_designDelCountAdd * 2) or 2.5 + (_designDelCountAdd * 0.5)) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
            _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 0, 2)
            if _modeDesignAlt == 1 then
                if getProtocolSides() > 5 then _halfLegAndHeadPart(_side, _isOddAlt, _isOppositeSideAlt, _neighbors, 1, 3 + _designDelCountAdd) end
                t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
        end
        if getProtocolSides() > 3 and _largeThickCount > 0 then
            _wallPart(_side + ((getPolySides(2, "floor") * (_isOppositeSideAlt % 2))),
                (getProtocolSides() % 2 == 1 and getProtocolSides() > 5 and _isOddAlt or 0) % 2,
            customizePatternThickness(_largeThickCount * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
        end
        t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
    end
    local _deskPart = function(_side, _isOddAlt, _isOppositeSideAlt, _modeDesignSubCycleAlt, _neighbors, _thickCount, _delEndCount, _designDelCountAdd, _isInverted)
        _thickCount = _thickCount or 5;
        _delEndCount = _delEndCount or 4;
        _neighbors = _neighbors or 0;
        _designDelCountAdd = _designDelCountAdd or 0;
        if (_isInverted) then
            if _modeDesignSubCycleAlt == 1 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                --t_applyPatDel(customizePatternDelay((1 + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 1.5) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + closeValue(_thickCount - 4, 0, 999) + (_designDelCountAdd * 0.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    (getProtocolSides() % 2 == 1 and _isOddAlt or 0) % 2,
                customizePatternThickness(2 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
            end
            t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
        else
            if _modeDesignSubCycleAlt == 1 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + (_designDelCountAdd * 1.5)) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((1 + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if _modeDesignSubCycleAlt == 2 then
                t_applyPatDel(customizePatternDelay(1 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 5 then
                _wallGrowPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    getPolySides(4, "floor") - _neighbors,
                customizePatternThickness(2 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
            else
                _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                    ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                customizePatternThickness(2 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
            end
            if _modeDesignSubCycleAlt < 2 then
                t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            elseif _modeDesignSubCycleAlt == 2 then
                if getProtocolSides() > 5 then
                    _wallPart(_side + (_isOppositeSideAlt % 2 == 0 and getPolySides(2, "floor") or 0),
                        ((_isOddAlt + 1) % 2) * (getProtocolSides() % 2),
                    customizePatternThickness((_thickCount + _designDelCountAdd - 0.5) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()))
                end
                t_applyPatDel(customizePatternDelay((_delEndCount + _designDelCountAdd) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
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
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedStart, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 8 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignCycle > 0 and _freq > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
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
                        local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
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
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignEnd or _modeDesignCycle, aMain == 0 and _neighDesignEnd or _neighDesignCycle, thickwall,             5 - (_modeDesignDesk > 0 and 1 or 0), _designDelAddEnd,  true) --end
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                   _neighDesignDesk,                                    aMain == 0 and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk, true) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignStart, _neighDesignStart, 0, 5, _designDelAddStart, true) --start
            end
        end
        if (getBooleanNumber(_hasContainedStart)) then
            t_applyPatDel(customizePatternDelay(1 * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_checkOddInt % 2) * getHalfSides()), _checkOddInt % 2, _neighContainedEnd, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
    else
        if (getBooleanNumber(_hasContainedStart)) then
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedStart, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((4 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() >= 8 then
            if _freq == 0 and _freqInv > 0 then
                for aInv = 0, _freqInv do
                    local delGapFix = (aInv > 0 and aInv < _freqInv - 1 and 0) or 1
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignCycle > 0 and _freq > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
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
                        local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
                        _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignStart or _modeDesignCycle, aMain == 0 and _neighDesignStart or _neighDesignCycle, thickwall,                 5,                                    _designDelAddStart, false) --start
                        _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                     _neighDesignDesk,                                      aMain == _freq and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk,  false) --desk
                    end
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignEnd, _neighDesignEnd, 0, 5, _designDelAddEnd, false) --end
                end
            end
        else
            for aInv = 0, _freqInv do
                for aMain = 0, _freq do
                    p_patternEffectCycle();
                    local thickwall = 11 + (_modeDesignStart > 0 and aMain == 0 and 1 + _designDelAddStart or 0) + (_modeDesignDesk > 0 and 1.5 + _designDelAddDesk or 0) + (_modeDesignCycle > 0 and aMain > 0 and 1 + _designDelAddCycle or 0) + _designDelAddEnd
                    _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, aMain == 0 and _modeDesignStart or _modeDesignCycle, aMain == 0 and _neighDesignStart or _neighDesignCycle, thickwall,                 5,                                    _designDelAddStart, false) --start
                    _deskPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignDesk,                                     _neighDesignDesk,                                      aMain == _freq and 5 or 4, 5 + (_modeDesignDesk > 0 and 1 or 0), _designDelAddDesk,  false) --desk
                end
                _bodyPart(_curSide, (_checkOddInt + aInv) % 2, (_checkOddInt + aInv) % 2, _modeDesignEnd, _neighDesignEnd, 0, 5, _designDelAddEnd, false) --end
            end
        end
        if (getBooleanNumber(_hasContainedEnd)) then
            t_applyPatDel(customizePatternDelay((1 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + ((_oddValueFix % 2) * getHalfSides()), _oddValueFix % 2, _neighContainedEnd, customizePatternThickness((1 + _designDelAddThick) * _currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd()

    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end
pMarch31osWrapAround = pMarch31osTrapAround

function pMarch31osTrapPatternizer(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, u_rndInt(0, 2)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _hasContainedStart = anythingButNil(_hasContainedStart, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 1); _neighContainedEnd = anythingButNil(_neighContainedEnd, _hasContainedStart);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local _largeWallThickStat, _designMiddleThickStat, _designMiddleDelayStat = 11, 10, 4;
    local currentSizeOverride = 1;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = (_altMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _curLoopDir = 1;

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if (_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, _neighContainedStart, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    if getProtocolSides() >= 6 then
        local modeDesignStartType001_sideOffset = (getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4)) or 1;
        cWallGrow(_curSide, modeDesignStartType001_sideOffset, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()))
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
    else cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
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
        if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness(_largeWallThickStat * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * (_curDelaySpeed * (_curStatForLargeThicknessOfDelaySpeed * 0.6 + 0.4)) * _curStatForLargeThicknessOfDelayMult * _sizeMult, p_getDelayPatternBool())) end
        t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizePatternThickness(_designMiddleThickStat * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
        if getProtocolSides() >= 6 then
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
        end
        t_applyPatDel(customizePatternDelay(_designMiddleDelayStat * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        if a < _iter then
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()))
    if (_hasContainedEnd) then
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        -- Set the "C" barrage with neighbors after pattern spawned.
        cBarrageN(_curSide, _neighContainedEnd, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

function pMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _isOdd, _isInverted, _delMult, _scale, _skipEndDelay, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultOfSpdLessThan, _spdIsGreaterThanEqual)
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
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultOfSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultOfSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- get delay speed, start pos, odd int checker, and rnd side rebooter
    local _curDelaySpeed = (_addMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
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
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide + math.ceil(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == 1 then --alright, if _design is equal 1 section...
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    local _addSide = math.floor(getProtocolSides() / 2) - 2;
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (1 + amount001) + (getProtocolSides() % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - (1 + amount001) + (_checkOddInt % 2), customizePatternThickness(6 + (_addSide * 3) - (amount001 * 3) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                    if amount001 == 0 then cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), (getProtocolSides() % 2 == 1 and _checkOddInt % 2 == 0) and 1 or 0, customizePatternThickness(7 + (_addSide * 2.5) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
                end
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
                    _wallGrowPart(_curSide, _checkOddInt % 2, amount001, customizePatternThickness(3.5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                    t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                end
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            else
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(8 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(6.5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(3.5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            end
        end
        if (_hasContainedStart) then
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
    else
        if (_hasContainedStart) then
            -- set c barrage neighbors
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
            _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _wallPart(_curSide + ((_checkOddInt + 1) % 2), (_checkOddInt + 1) % 2, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
            _wallGrowPart(_curSide, _checkOddInt % 2, 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            _wallGrowPart(_curSide, _checkOddInt % 2, 0, customizePatternThickness(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            cWall(_curSide + math.ceil(getProtocolSides() / 2) + (((_checkOddInt + 1) % 2)) + (_checkOddInt % 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
            if _design == 1 then --alright, if _design is equal 1 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - (amount001 + 2), customizePatternThickness((4 + (amount001 * 3)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay((math.floor(getProtocolSides() / 2) + 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + (_checkOddInt % 2), _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness((math.floor(getProtocolSides() / 2) + math.floor(getProtocolSides() / 2) + 1 + math.floor(getProtocolSides() / 10) + math.floor(getProtocolSides() / 4)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for amount002 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                    cWall(_curSide + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1 + amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                    cWall(_curSide + math.floor(getProtocolSides() / 2) - ((_checkOddInt + 1) % 2) - amount002, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (amount002 * 3)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                    if amount002 < math.floor(getProtocolSides() / 2) - 3 then t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool())); end
                end
            else -- elseif _design is equal 0 section...
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                _wallGrowPart(_curSide, _checkOddInt % 2, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                _wallPart(_curSide, _checkOddInt % 2, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                cWallEx(_curSide + math.floor(getProtocolSides() / 2) + _checkOddInt, _checkOddInt % 2 == 0 and getProtocolSides() % 2 or 0, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _scale, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
                for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1 + (_checkOddInt % 2), customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool())); end
            end
            t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            _barrageNPart(_curSide + (_checkOddInt % 2), _checkOddInt % 2, 0, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(((getProtocolSides() / 2) + 3) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
        end
        if (_hasContainedEnd) then
            t_applyPatDel(customizePatternDelay(((getProtocolSides() / 2) + 3) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _scale, p_getDelayPatternBool()));
            -- set c barrage neighbors after pattern spawned
            _barrageNPart(_curSide + math.floor(getProtocolSides() / 2) + 1, (_checkOddInt + 1) % 2, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _scale, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- end delay (optional arg, default false)
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 8 or 11)));
end
pMarch31osBat = pMarch31osAccurateBat;

function pMarch31osDiamond(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _endHeadFree, _exDelBit, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 0); _exDelBit = anythingButNil(_exDelBit, 0); _sizeMult = anythingButNil(_sizeMult, 1);
    _hasContainedStart = anythingButNil(_hasContainedStart, 0); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _endHeadFree = anythingButNil(_endHeadFree, 0);
    if _endHeadFree > math.floor(getProtocolSides() / 2) - 2 then _endHeadFree = 0; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_altMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if (_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    end
    --spawn large walls
    local _currentReduceThickAmountStat = (getProtocolSides() >= 6 and 0.25) or -0.1
    if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) + (_exDelBit * 2) - _currentReduceThickAmountStat) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool())); end
    for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
        cWallGrow(_curSide, adj + 1, customizePatternThickness(((math.floor(getProtocolSides() / 2) - (1 + adj)) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
            cWallEx(_curSide + adj + math.floor(getProtocolSides() / 2), getProtocolSides() % 2, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            cWallEx(_curSide - adj + math.floor(getProtocolSides() / 2), getProtocolSides() % 2, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(((1 + math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)) + (_exDelBit * math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)))) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        end
        if a < _iter then
            if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness(((((getProtocolSides() - (getProtocolSides() % 2)) + (_exDelBit * 2) - _currentReduceThickAmountStat) * 2) + 1.5) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool())); end
            for adj = 0, math.floor(getProtocolSides() / 2) - 2, 1 do
                cWallGrow(_curSide, adj + 1, customizePatternThickness((((getProtocolSides() - (getProtocolSides() % 2)) - (adj * 2 + 3)) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay(((1 + math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)) + (_exDelBit * math.floor((adj + 1) / (math.floor(getProtocolSides() / 2) - 1)))) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    for adj = 0, math.floor(getProtocolSides() / 2) - (_endHeadFree + 2), 1 do
        local _currentEndHeadThickAmountStat = adj >= math.floor(getProtocolSides() / 2) - (_endHeadFree + 2) and 2 or 3;
        cWallGrow(_curSide, adj + 1, customizePatternThickness(_currentEndHeadThickAmountStat * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
    end
    if (_hasContainedEnd) then
        -- Set the "C" barrage with neighbors after pattern spawned.
        t_applyPatDel(customizePatternDelay(((_exDelBit + 2) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
        cBarrageN(_curSide, _neighContainedEnd, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end

function pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, u_rndInt(0, 3)); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentTimesOfThickAmount_001 = 3;
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = (_altMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;
    local _curLoopDir = 1;

    --[ -= Starting of pattern code =- ]--
    if getProtocolSides() >= 6 then
        for sideOffset001 = 0, getProtocolSides() % 2, 1 do
            cWallGrow(_curSide - (getProtocolSides() % 2) + sideOffset001, math.floor(getProtocolSides() / 4), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
    elseif getProtocolSides() < 6 then
        for sideOffset001a = 0, getProtocolSides() % 2, 1 do
            cWall(_curSide - (getProtocolSides() % 2) + sideOffset001a, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
    end
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for sideAmount = 0, math.floor(getProtocolSides() / 2) - 1, 1 do
            local _thickSideAmountStat = (sideAmount == math.floor(getProtocolSides() / 2) - 1 and 2) or 3;
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool()));
            for sideOffset = 0, ((a % 2) * (getProtocolSides() % 2)), 1 do
                cWallGrow(_curSide + sideOffset + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)) - ((a % 2) * (getProtocolSides() % 2)), sideAmount, customizePatternThickness(_thickSideAmountStat * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                cWall(_curSide + sideOffset + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)) - ((a % 2) * (getProtocolSides() % 2)), customizePatternThickness((sideAmount * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        end
        t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
pMarch31osHexazazInversions = pMarch31osInterpretInversions;

function pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 1); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);

    p_patternEffectStart();

    local _isRebootingSideStat = getBooleanNumber(_isRebootingSide or march31oPatDel_isRebootingSide);
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_altMult or march31oPatDel_AddMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and (_isRebootingSideStat) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = (_isRebootingSideStat) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    for i = 0, math.floor(getProtocolSides() / 2), 1 do cWall(_curSide + i, customizePatternThickness(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
    t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool()));
    for a = 0, _iter, 1 do
        p_patternEffectCycle();
        for d = 0, 1 do
            for i = 1 - d, math.floor(getProtocolSides() / 2) + (((a + 1) % 2) * (getProtocolSides() % 2)) + (d - 1), 1 do cWall(_curSide + i + (((a + 1) % 2) * math.floor(getProtocolSides() / 2)), customizePatternThickness((3 - d) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            t_applyPatDel(customizePatternDelay(((d + 1) * 2) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel((_endAdditionalDelay or march31oPatDel_AdditionalDelay or 0) + (getPerfectDelay(THICKNESS) * (getBooleanNumber(_skipEndDelay) and 0 or 8)));
end
pMarch31osRevertingGauntlet = pMarch31osDivergencedGauntlets;
