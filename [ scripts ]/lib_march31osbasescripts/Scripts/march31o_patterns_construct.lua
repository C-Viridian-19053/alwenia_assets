--need utils & commons, to avoid stack overflow
--[[ NOTICE: if 'table.unpack' was currently unavailable from lua 5.1, make sure you've to change the lua version to 5.1 on 'march31o_utils.lua'
in order to add 'table.unpack' lua function shortcut, if 'table.unpack' has already, change the lua version to 5.3 or higher ]]

--2.x.x+ & 1.92 conv functs
local u_getSpeedMultDM = u_getSpeedMultDM or getSpeedMult
local u_rndInt = u_rndInt or math.random

--[[
    void p_constructSpiral(_side, _func, _args, _freq, _revFreq, _step, _loopDir, _delayAmount, _isRebootingSide, _endAdditionalDelay, _addMult, _isTight, _skipEndDelay, _perfectThicknessMult)
    void p_constructSpiral(_side, _func, _args, _freq) --, 0, 1, getRandomDir(), 1, false, 0, 1, true, false, nil
    void p_constructRepeat(_side, _func, _args, _freq, _delayAmount, _isRebootingSide, _endAdditionalDelay, _addMult, _isTight, _skipEndDelay)
    void p_constructRepeat(_side, _func, _args, _freq) --, 1, false, 0, 1, false, false
]]

--[ Pattern constructors (Inspired from Kodipher's Inflorescence pack) ]--

function p_constructSpiral(_side, _func, _args, _freq, _revFreq, _step, _loopDir, _delayAmount, _delaySides, _delayWalls, _isRebootingSide, _endAdditionalDelay, _addMult, _skipEndDelay, _perfectThicknessMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _freq = anythingButNil(_freq, 5);
    _isTight = anythingButNil(_isTight, 1); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    --reboot side posistion
    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    if _side == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _side or -256;

    --set perfect thickness
    local _oldThickness = 0
    local _usingPerfectThickness = true
    if not _perfectThicknessMult then _usingPerfectThickness = false end

    if _usingPerfectThickness then
        _oldThickness = THICKNESS;
        THICKNESS = getPerfectThickness(THICKNESS) * _perfectThicknessMult;
    end

    -- optional args
    _delayAmount = anythingButNil(_delayAmount, customizePatternDelay(1));
    _delayWalls = anythingButNil(_delayWalls, 1);
    _step = anythingButNil(_step, 1);
    if _loopDir == nil or _loopDir == 0 then _loopDir = getRandomDir(); end
    if _loopDir < -1 then _loopDir = -1 elseif _loopDir > 1 then _loopDir = 1; end

    -- negative shift to flip dir
    if (_step < 0) then _step = -_step; _loopDir  = -_loopDir; end

    -- optional args: based on other
    if not _delaySides then _delaySides = _step end

    --insert side argument
    table.insert(_args, 1, _side)

    --get delay after each call
    local _delay = getDelaySides(_delaySides) + getDelayWalls(_delayWalls)
    if (_delaySides == 0) and (_delayWalls == 0) then _delay = 0
    else _delay = getDelaySides(_delaySides) + getDelayWalls(_delayWalls)
    end

    --get variable of reversing frequency number value
    local _revFreqAdd = 0;

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    -- call the functions in a loop
    for r = 0, _revFreq, 1 do
        if r == _revFreq then _revFreqAdd = 1; end

        for a = 0, _freq + _revFreqAdd, 1 do
            p_patternEffectCycle();

            --call functions
            _func(table.unpack(_args))
            --shift posistions
            _side = _side + _loopDir * _step
            _args[1] = _side
            --apply delay
            if _usingPerfectThickness then t_applyPatDel(_delay)
            else t_applyPatDel(_delayAmount)
            end
        end
        _loopDir = -_loopDir
    end

    --reset thickness
    if _usingPerfectThickness then THICKNESS = _oldThickness; end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end

function p_constructRepeat(_side, _func, _args, _freq, _delayAmount, _isRebootingSide, _endAdditionalDelay, _addMult, _isTight, _skipEndDelay)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _freq = anythingButNil(_freq, 5);
    _isTight = anythingButNil(_isTight, 1); _skipEndDelay = anythingButNil(_skipEndDelay, 0);

    --reboot side posistion
    _isRebootingSide = anythingButNil(_isRebootingSide, 1);
    if _side == TARGET_PATTERN_SIDE and getBooleanNumber(_is_rebooting_side) then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = getBooleanNumber(_is_rebooting_side) and _side or -256;

    -- optional args
    _delayAmount = anythingButNil(_delayAmount, getDelayWalls(1));

    --insert side argument
    table.insert(_args, 1, _side)

    --get delay speed
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));

    --get number into bool
    _isTight = getBooleanNumber(_isTight); if _isTight then p_setDelayPatternBool(false); end

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    -- call the functions in a loop
    for a = 0, _freq, 1 do
        p_patternEffectCycle();

        --call
        _func(table.unpack(_args))
        --delay
        t_applyPatDel(_delayAmount * _curDelaySpeed)
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(_endAdditionalDelay or 0);
    if not getBooleanNumber(_skipEndDelay) then t_applyPatDel(getPerfectDelay(THICKNESS) * 8) end
end
