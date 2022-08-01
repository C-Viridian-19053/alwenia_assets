--need utils & commons, to avoid stack overflow

--2.x.x+ & 1.92 conv functs
local l_getSides = l_getSides or getSides
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random
local u_rndIntUpper = u_rndIntUpper or math.random

--[[
    void pMarch31osTrapAround(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignCycle, _modeDesignEnd, _designDelayAdd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osTrapAround(_side, _iter) --, 1, 1, nil, 1, nil, 0, 0, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osTrapPatternizer(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osTrapPatternizer(_side, _iter) --, 0, nil, 0, nil, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osAccurateBat(_side) --, 0, nil, 0, nil, 0, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osDiamond(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _endHeadFree, _exDelBit, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDiamond(_side, _iter) --, 0, nil, 0, nil, 0, 0, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osInterpretInversions(_side, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
    void pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    void pMarch31osDivergencedGauntlets(_side, _iter) --, 1, 1, false, 0, 1, 1, 2, false, false
]]

--[ Additional cages ]--

function pMarch31osTrapAround(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _modeDesignStart, _modeDesignCycle, _modeDesignEnd, _designDelayAdd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _iter = anythingButNil(_iter, 0); _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    _hasContainedStart = anythingButNil(_hasContainedStart, 1); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 1); _neighContainedEnd = anythingButNil(_neighContainedEnd, _hasContainedStart);
    _modeDesignStart = anythingButNil(_modeDesignStart, 1); _modeDesignCycle = anythingButNil(_modeDesignCycle, 1); _modeDesignEnd = anythingButNil(_modeDesignEnd, 0);
    if _designDelayAdd == nil or _designDelayAdd < 0 then _designDelayAdd = 0; elseif _designDelayAdd > 0 then _designDelayAdd = 1; end
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentDelayMult001 = 1; local currentDelayMult002 = 1; local currentBatDesignOffset = 0;
    local currentThickAddAmount_001 = 1;
    local currentTimesOfDelayAmount_001 = 4;
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

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
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if (_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        if _modeDesignStart == 1 and _designDelayAdd > 0 then _designDelayAdd = 0.5; end
        cBarrageN(_curSide, _neighContainedStart, customizePatternThickness((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay((4 + (_designDelayAdd * 2)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    -- large thickness
    if _modeDesignStart == 1 and _designDelayAdd > 0 then _designDelayAdd = 1; currentDelayMult002 = 1.05; end
    --some number to integer had to be number value in that case...
    local _curStatForLargeThickness = (_modeDesignCycle == 3 and 12.5) or (getProtocolSides() <= 4 and 11) or 12;
    local _curStatForLargeThicknessOfDelayMult = (getProtocolSides() >= 6 and _delMult * 0.75 + 0.25) or _delMult;
    local _curStatForLargeThicknessOfDelaySpeed = (getProtocolSides() >= 6 and _curDelaySpeed) or 1;
    if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness((_curStatForLargeThickness * (_curStatForLargeThicknessOfDelaySpeed * 0.6 + 0.4) + (_designDelayAdd * 2.5)) * currentDelayMult002 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _curStatForLargeThicknessOfDelayMult * _sizeMult, p_getDelayPatternBool())); end
    --
    if getProtocolSides() >= 6 then
        if _modeDesignStart == 1 then --trap around style
            --if getProtocolSides() >= 10 then modeDesignStartType001_sideOffset = math.floor(getProtocolSides() / 4); end
            local modeDesignStartType001_sideOffset = (getProtocolSides() >= 10 and math.floor(getProtocolSides() / 4)) or 1;
            cWallGrow(_curSide, modeDesignStartType001_sideOffset, customizePatternThickness((2.5 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        elseif _modeDesignStart == 2 then --wrap around style
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness((3 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
            t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        elseif _modeDesignStart == 3 then --both
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness((4 + (_designDelayAdd * 1.5)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        else --noneness...?
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
            t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
    else
        if getProtocolSides() > 3 then
            cWallGrow(_curSide, 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        else cWall(_curSide, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        end
    end
    for timesAmount = 0, _iter, 1 do -- repeat until reaching into _iter, stops here
        p_patternEffectCycle();
        if timesAmount > 0 then
            if getProtocolSides() >= 6 then
                if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                end
            end
            --if getProtocolSides() < 6 then currentTimesOfDelayAmount_001 = 5; end
            currentTimesOfDelayAmount_001 = (getProtocolSides() < 6 and 5) or 4;
        end
        t_applyPatDel(customizePatternDelay((currentTimesOfDelayAmount_001 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        --if timesAmount == _iter then currentTimesOfThickAmount_001 = 5; end
        local currentTimesOfThickAmount_001 = (timesAmount == _iter and 5) or 4; -- when the steps stops right here
        if getProtocolSides() >= 6 then -- if sides greater than equal 6 section...
            if _modeDesignCycle == 1 then --trap around style
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizePatternThickness(currentTimesOfThickAmount_001 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            elseif _modeDesignCycle == 2 then --wrap around style
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizePatternThickness((currentTimesOfThickAmount_001 - 0.5) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            elseif _modeDesignCycle == 3 then --both
                for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWall(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), customizePatternThickness((4 + (_designDelayAdd * 1.5)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
                t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            else --noneness...?
                t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                for largeWallsOffset002 = -1, (getProtocolSides() % 2) + 1, 1 do cWallGrow(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            end
        else -- if sides lower than 6 section...
            if getProtocolSides() > 3 then for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), math.floor(getProtocolSides() / 4) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            else cBarrage(_curSide, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        end
        local _curModeDesignCycleStatForThickAmount_002 = ((_modeDesignCycle == 3 and 12) or 11) + (getProtocolSides() > 6 and 1 or 0);
        if timesAmount < _iter then -- if timesAmount lower than _iter...
            if getProtocolSides() > 6 then currentTimesOfThickAmount_002 = (_curModeDesignCycleStatForThickAmount_002 + _designDelayAdd);
            elseif getProtocolSides() <= 5 then currentTimesOfThickAmount_002 = (11 + _designDelayAdd);
            end
            t_applyPatDel(customizePatternDelay(((5 + _designDelayAdd) * currentDelayMult001) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            if _modeDesignCycle == 3 and getProtocolSides() >= 6 then
                cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness((4 + (_designDelayAdd * 1.5)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _sizeMult, p_getDelayPatternBool()));
            end
            if getProtocolSides() > 3 then cWall(_curSide, customizePatternThickness(((currentTimesOfThickAmount_002 + (_designDelayAdd * 1.25)) * currentDelayMult001) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * (_curStatForLargeThicknessOfDelaySpeed * 0.25 + 0.75) * _curStatForLargeThicknessOfDelayMult * _sizeMult, p_getDelayPatternBool())); end
            if getProtocolSides() > 3 and getProtocolSides() <= 5 then cWallGrow(_curSide, 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cWall(_curSide, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        end
    end
    if getProtocolSides() >= 5 then
        -- We need a cap. Why? Because the steps were stops here for now.
        if _modeDesignEnd == 1 and getProtocolSides() >= 6 then currentDelayMult002 = 1.15 end
        if getProtocolSides() == 5 then currentDelayMult002 = 1.15 end
        t_applyPatDel(customizePatternDelay(((5 + _designDelayAdd) * currentDelayMult002) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        if _modeDesignEnd == 1 then --octagon wrap around's barrage precision design
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        elseif (_modeDesignEnd == 2 and getProtocolSides() >= 6) then --kensem's hexaxaz/bat design
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        elseif (_modeDesignEnd == 3 and getProtocolSides() >= 6) then --both bullshiet same as mode design cycle was 3
            cWallGrow(_curSide, math.floor(getProtocolSides() / 4), customizePatternThickness((4 + (_designDelayAdd * 1.5)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            if getProtocolSides() % 2 == 1 then cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            else cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            end
        else cWallGrow(_curSide, math.ceil(getProtocolSides() / 2) - 2, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); --include wall grow, normal
        end
    elseif getProtocolSides() == 4 then
        t_applyPatDel(customizePatternDelay(((5 + _designDelayAdd) * currentDelayMult002) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        cBarrage(_curSide + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    else
        t_applyPatDel(customizePatternDelay(((5 + _designDelayAdd) * currentDelayMult002) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        cWall(_curSide, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    if (_hasContainedEnd) then
        t_applyPatDel(customizePatternDelay((6 + (_designDelayAdd * 2)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        -- Set the "C" barrage with neighbors after pattern spawned.
        cBarrageN(_curSide, _neighContainedEnd, customizePatternThickness((1 + _designDelayAdd) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(_endAdditionalDelay or 0) t_applyPatDel(customizePatternDelay(4, p_getDelayPatternBool()))
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) end
end
pMarch31osWrapAround = pMarch31osTrapAround

function pMarch31osTrapPatternizer(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
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
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) end
end

function pMarch31osAccurateBat(_side, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _design, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
    -- When the value is nil, the values will automatically indexed itself!
    _delMult = anythingButNil(_delMult, 1); _sizeMult = anythingButNil(_sizeMult, 1);
    if _delMult > 1.5 then _delMult = 1.5; end
    _hasContainedStart = anythingButNil(_hasContainedStart, 0); _hasContainedEnd = anythingButNil(_hasContainedEnd, _hasContainedStart);
    _neighContainedStart = anythingButNil(_neighContainedStart, 0); _neighContainedEnd = anythingButNil(_neighContainedEnd, _neighContainedStart);
    _design = anythingButNil(_design, 0);
    _isTight = anythingButNil(_isTight, 0); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    -- Prepare the value data.
    local currentLargeWallsOffsetForLessThanPentagon = getProtocolSides() - 4;
    local isdesign1_extraDecrement = 2; local isdesign1_thickIncrement = 4; local isdesign1_middleSideIncrement = 0;
    local currentSizeOverride = 1.25;

    p_resetPatternDelaySettings();
    --[[ if u_getSpeedMultDM greater than equal _spdIsGreaterThanEqual that will calculated with speed difficulty multiplier,
    elseif u_getSpeedMultDM lower than _spdIsGreaterThanEqual that won't calculated with speed difficulty multiplier,
    but you can now change the '_delayMultSpdLessThan' value ]]
    p_adjustPatternDelaySettings(_spdIsGreaterThanEqual or 2, _delayMultSpdLessThan or 1, nil, nil);
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

    --[ -= Starting of pattern code =- ]--
    _hasContainedStart = getBooleanNumber(_hasContainedStart); _hasContainedEnd = getBooleanNumber(_hasContainedEnd);
    if (_hasContainedStart) then
        -- Alright. Set the "C" barrage with neighbors.
        cBarrageN(_curSide, _neighContainedStart, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
    end
    if getProtocolSides() <= 3 then -- if sides less than equal 3 section...
        cWall(_curSide, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(6 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        cBarrage(_curSide, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() > 3 and getProtocolSides() <= 5 then -- if sides greater than 3 and less than equal 5 section...
        cWallGrow(_curSide, 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        cWallGrow(_curSide, 0, customizePatternThickness(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        for largeWallsOffsetLessThanPent = 0, currentLargeWallsOffsetForLessThanPentagon, 1 do cWall(_curSide + largeWallsOffsetLessThanPent + math.floor(getProtocolSides() / 2), customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
        t_applyPatDel(customizePatternDelay(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        cWall(_curSide + math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
        cWall(_curSide + math.floor(getProtocolSides() / 2) + 1 + currentLargeWallsOffsetForLessThanPentagon, customizePatternThickness(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    elseif getProtocolSides() > 5 then -- elseif sides greater than 5 section...
        if _design == 1 then --alright, if _design is equal 1 section...
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            for amount001 = 0, math.floor(getProtocolSides() / 2) - 2, 1 do cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - isdesign1_extraDecrement, customizePatternThickness(isdesign1_thickIncrement * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); isdesign1_thickIncrement = isdesign1_thickIncrement + 3; isdesign1_extraDecrement = isdesign1_extraDecrement + 1; end
            t_applyPatDel(customizePatternDelay(math.floor(getProtocolSides() / 2) + 2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), 0, customizePatternThickness((math.floor(getProtocolSides() / 2) + math.floor(getProtocolSides() / 2) + 1 + math.floor(getProtocolSides() / 10) + math.floor(getProtocolSides() / 4)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            for amount002 = 0, math.floor(getProtocolSides() / 2) - 3, 1 do
                cWall(_curSide + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1 + isdesign1_middleSideIncrement, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (isdesign1_middleSideIncrement * 3)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                cWall(_curSide + math.floor(getProtocolSides() / 2) - 1 - isdesign1_middleSideIncrement, customizePatternThickness((math.floor(getProtocolSides() / 2) + (math.floor(getProtocolSides() / 2) + 1) + (math.floor(getProtocolSides() / 2) - 3) - (isdesign1_middleSideIncrement * 3)) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
                if amount002 < math.floor(getProtocolSides() / 2) - 3 then isdesign1_middleSideIncrement = isdesign1_middleSideIncrement + 1; t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool())); end
            end
        else -- elseif _design is equal 0 section...
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            cWallGrow(_curSide, math.floor(getProtocolSides() / 2) - 2 - math.floor(getProtocolSides() / 10), customizePatternThickness(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            cWallGrow(_curSide, 0, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
            t_applyPatDel(customizePatternDelay(5 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            for largeWallsOffset001 = 0, getProtocolSides() % 2, 1 do cWallGrow(_curSide + largeWallsOffset001 + math.floor(getProtocolSides() / 2), 0, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _delMult * _sizeMult, p_getDelayPatternBool())); end
            t_applyPatDel(customizePatternDelay(2 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
            for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide + largeWallsOffset002 + math.floor(getProtocolSides() / 2) + (getProtocolSides() % 2) + 1, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
            for largeWallsOffset002 = 0, math.floor(getProtocolSides() / 10), 1 do cWall(_curSide - largeWallsOffset002 + math.floor(getProtocolSides() / 2) - 1, customizePatternThickness(7 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool())); end
        end
        t_applyPatDel(customizePatternDelay(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        cBarrage(_curSide, customizePatternThickness(3 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    end
    if (_hasContainedEnd) then
        if _design == 1 then t_applyPatDel(customizePatternDelay((isdesign1_middleSideIncrement + 9) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        else t_applyPatDel(customizePatternDelay(9 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
        -- Set the wall extra's barrier container after pattern spawned.
        cWallEx(_curSide + 1 + getHalfSides() - _neighContainedEnd, getProtocolSides() - (2 + _neighContainedEnd + (getProtocolSides() % 2)), customizePatternThickness(1 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _sizeMult, p_getDelayPatternBool()));
    else
        if _design == 1 then t_applyPatDel(customizePatternDelay((isdesign1_middleSideIncrement + 4) * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        else t_applyPatDel(customizePatternDelay(4 * currentSizeOverride * p_setDelayPatternOfSpeedLessThan() * _curDelaySpeed * _delMult * _sizeMult, p_getDelayPatternBool()));
        end
    end
    --[ -= End of pattern code =- ]--
    p_patternEffectEnd();

    -- And finally, add the pattern of delay 't_applyPatDel' to avoid impossible patterns. Why? Because the pattern code needs to delay after it's ends here!
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) else t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
pMarch31osBat = pMarch31osAccurateBat;

function pMarch31osDiamond(_side, _iter, _hasContainedStart, _hasContainedEnd, _neighContainedStart, _neighContainedEnd, _endHeadFree, _exDelBit, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
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
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) end
end

function pMarch31osInterpretInversions(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
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
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curDelaySpeed', '_curSide', and '_curLoopDir' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;
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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) end
end
pMarch31osHexazazInversions = pMarch31osInterpretInversions;

function pMarch31osDivergencedGauntlets(_side, _iter, _delMult, _sizeMult, _isRebootingSide, _endAdditionalDelay, _addMult, _delayMultSpdLessThan, _spdIsGreaterThanEqual, _isTight, _skipEndDelay)
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
    if getBooleanNumber(_isTight) then p_setDelayPatternBool(false); end

    p_patternEffectStart();

    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    -- First, create the '_curDelaySpeed' and '_curSide' value.
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));
    local _curSide = _side or u_rndInt(0, getProtocolSides() - 1);
    if _curSide == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _curSide = _curSide + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _curSide or -256;

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
    t_applyPatDel(_endAdditionalDelay or 0)
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 11) end
end
pMarch31osRevertingGauntlet = pMarch31osDivergencedGauntlets;
