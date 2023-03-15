--Lua 5.3+ & 5.1 conv functs
local unpack = unpack or table.unpack

--[[
    void p_constructPatternizer(_side, _array, _sizeMult, _isSpdMode)
    void p_constructPatternizer(_side, _array) --, 1, true
    void p_constructSpiral(_side, _func, _args, _freq, _revFreq, _step, _direction, _delayAmount, _delaySides, _delayWalls, _perfectThicknessMult)
    void p_constructSpiral(_side, _func, _args, _freq) --, 0, 1, getRandomDir(), 1, false, 1, nil
    void p_constructRepeat(_side, _func, _args, _freq, _delayAmount)
    void p_constructRepeat(_side, _func, _args, _freq) --, 1
]]

--[ Pattern constructors ]--

-- p_constructPatternizer: constructs patternizer with array
function p_constructPatternizer(_side, _array, _sizeMult, _isSpdMode)
    _side = _side or getRandomSide();
    _sizeMult = _sizeMult or 1;
    _isSpdMode = _isSpdMode or true;
    local eArray = cycleSide(getProtocolSides(), _side)
    local j = math.floor((#_array) / getProtocolSides())

    for i = 1, j, 1 do
        for k = 1, getProtocolSides(), 1 do
            if _array[(i - 1) * getProtocolSides() + k] == 1 then
                cWall(eArray[k], customizePatternThickness(2 * _sizeMult, _isSpdMode))
            end
        end
        t_wait(customizePatternDelay(1.8 * _sizeMult, _isSpdMode))
    end
end

-- Inspired from Kodipher's Inflorescence pack
function p_constructSpiral(_side, _func, _args, _freq, _revFreq, _step, _direction, _delayAmount, _delaySides, _delayWalls, _perfectThicknessMult)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _freq = anythingButNil(_freq, 5);

    --reboot side posistion
    if _side == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _side or -256;

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
    if _direction == nil or _direction == 0 then _direction = getRandomDir(); end
    if _direction < -1 then _direction = -1 elseif _direction > 1 then _direction = 1; end

    -- negative shift to flip dir
    if (_step < 0) then _step = -_step; _direction  = -_direction; end

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
            _func(unpack(_args))
            --shift posistions
            _side = _side + _direction * _step
            _args[1] = _side
            --apply delay
            if _usingPerfectThickness then t_applyPatDel(_delay)
            else t_applyPatDel(_delayAmount)
            end
        end
        _direction = -_direction
    end

    --reset thickness
    if _usingPerfectThickness then THICKNESS = _oldThickness; end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end

function p_constructRepeat(_side, _func, _args, _freq, _delayAmount)
    _side = anythingButNil(_side, u_rndInt(0, getProtocolSides() - 1)); _freq = anythingButNil(_freq, 5);

    --reboot side posistion
    if _side == TARGET_PATTERN_SIDE and p_getRebootingSideBool() then _side = _side + getRandomNegVal(getRebootPatternSide()) end
    TARGET_PATTERN_SIDE = p_getRebootingSideBool() and _side or -256;

    -- optional args
    _delayAmount = anythingButNil(_delayAmount, getDelayWalls(1));

    --insert side argument
    table.insert(_args, 1, _side)

    --get delay speed
    local _curDelaySpeed = (_addMult or 1) - (getSpeedDelay(PAT_START_SPEED or u_getSpeedMultDM()) * (march31oPatDel_SDMult or 0));

    p_resetPatternDelaySettings();
    p_patternEffectStart();

    -- call the functions in a loop
    for a = 0, _freq, 1 do
        p_patternEffectCycle();

        --call
        _func(unpack(_args))
        --delay
        t_applyPatDel(_delayAmount * _curDelaySpeed)
    end

    p_patternEffectEnd();
    -- end delay (optional arg, default false)
    t_applyPatDel(p_getEndAdditionalDelayPattern() + (getPerfectDelay(THICKNESS) * (p_getSkipEndDelayPatternBool() and 0 or 8)));
end
