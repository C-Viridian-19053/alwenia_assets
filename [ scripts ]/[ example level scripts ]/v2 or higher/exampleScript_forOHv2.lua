-- include useful files, which one
--[[
>>> for OH v2 or non-Steam users, use:
u_execScript("utils.lua") -- don't forget to use this default utils
u_execScript("march31o_utils.lua")
u_execScript("march31o_common.lua")
u_execScript("march31o_patterns_common.lua")
u_execScript("march31o_patterns_additional.lua")
u_execScript("march31o_patterns_additional_tunnel.lua")
u_execScript("march31o_patterns_swap.lua")
u_execScript("march31o_patterns_cage.lua")
u_execScript("march31o_patterns_novel.lua")
u_execScript("march31o_patterns_construct.lua")
(i) - important for OH v2 or non-Steam users: copy the file in <<.../[ scripts ]/marchionne's base scripts/Scripts/>> directory and then paste on <../Open Hexagon/Packs/[pack_name]/Scripts/>

>>> for OH Steam v2.0.4+ users, use:
u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", utils.lua") -- don't forget to use this default utils from vee's script base
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_utils.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_common.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_common.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_additional.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_additional_tunnel.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_cage.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_swap.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_novel.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_construct.lua")
(i) - important for OH Steam v2.0.4+ users: make sure your pack has a dependency on it (with good JSON syntax), see example: <.../Open Hexagon/Packs/cube/pack.json>
]]

-- default for OH v2 or non-Steam users
u_execScript("utils.lua") -- don't forget to use this default utils
u_execScript("march31o_utils.lua")
u_execScript("march31o_common.lua")
u_execScript("march31o_patterns_common.lua")
u_execScript("march31o_patterns_additional.lua")
u_execScript("march31o_patterns_additional_tunnel.lua")
u_execScript("march31o_patterns_cage.lua")
u_execScript("march31o_patterns_swap.lua")
u_execScript("march31o_patterns_novel.lua")
u_execScript("march31o_patterns_construct.lua")

-- inspired taken from modern year pack, shoutouts to The Sun XIX

-- Pattern constants (recommended)
local march31oFirstPatternSpawn = false;
local march31oCurrentSpawning = true;
local march31oPatternSpawnAmount = 0;

-- configs can be changed (IMPORTANT FOR OH 2.0.2+ USERS: Delete the current replay file before changing the config)
march31oPat_timesDo = 999; --cycle do (unused, maybe)
march31oPat_thickness = 40; --thickness tho
march31oPatDel_AdditionalDelay = 0; --delay increment after patterns loaded (FOR PATTERNS ONLY) (required)
march31oPatDel_AddMult = 1; --additional delay mult, alternation of delay multiplier...i think (FOR PATTERNS ONLY) (required)
-- delay config (recommended)
    march31oPatDel_SDMult = 0; --delay-speed multiplier (FOR PATTERNS ONLY)

-- Pattern effect (required)
function p_patternEffectStart() --begin
end
function p_patternEffectCycle() --cycle
end
function p_patternEffectEnd() --end
end

-- Set level data
function onInit()
    l_setSpeedMult(1.7)
    l_setSpeedInc(0.15)
    l_setSpeedMax(2.9)

    l_setRotationSpeed(0.1)
    l_setRotationSpeedMax(0.415)
    l_setRotationSpeedInc(0.035)

    l_setDelayMult(1)
    l_setDelayInc(0.0)

    l_setFastSpin(0.0)

    l_setSides(6)
    l_setSidesMin(6)
    l_setSidesMax(6)

    l_setIncTime(15)

    l_setPulseMin(70)
    l_setPulseMax(70)
    l_setPulseSpeed(0)
    l_setPulseSpeedR(0)
    l_setPulseDelayMax(0)
end

-- Spawn logic
function spawnPattern(mNumbSpawn)
    local _side = getRandomSide(); --for randomizing side positions

    -- insert patterns here, for example from cube pack by vee:
    if mNumbSpawn == 1 and getProtocolSides() % 2 == 1 then --it is recommended to use getProtocolSides(), which the overriding shape function has been released (FOR PATTERNS ONLY)
        -- mirror spiral looks bad with odd sides, obiously
        mNumbSpawn = 5
    end

        if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 6), false, 0, 0, 2, false, 1, 1, getRandomDir(), true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn == 1 then pMarch31osWhirlwind(_side, u_rndInt(3, 6), 0, math.floor(getProtocolSides() / 3), 1, false, 1, 1, getRandomDir(), 0, 0, false, true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 3), 1, 1, 1, getRandomDir(), true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn == 3 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, false, 1, 1, u_rndInt(0, 1), true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn == 4 then pMarch31osTunnel(_side, march31oPat_thickness * 1.75, nil, u_rndInt(1, 3), 2, 0, 2, true, true, 0, 0, 1, 1, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn == 5 then pMarch31osWhirlwind(_side, getProtocolSides() * u_rndInt(1, 2), 0, 1, 1, false, 1, 1, getRandomDir(), 0, 0, false, true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult);
    end

    -- debug, remove if you don't want to use this
    print("[mbs::MarchionneBaseScripts::keySpawned] Pattern key spawned: " .. mNumbSpawn)
end

-- shuffle the keys, and then call them to add all the patterns
-- shuffling is better than randomizing - it guarantees all the patterns will be called
getKeys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 5, 5 }
shuffle(getKeys)
pat_index = 0

-- onStartOrRestart
function onLoad()
    -- level & pattern configs
    PAT_START_SPEED = l_getSpeedMult();
end

-- patternSpawning
function onStep()
    if (march31oCurrentSpawning) then
        if (not march31oFirstPatternSpawn) then march31oFirstPatternSpawn = true;
        end
        spawnPattern(getKeys[pat_index])
        pat_index = pat_index + 1
        march31oPatternSpawnAmount = march31oPatternSpawnAmount + 1

        if pat_index - 1 == #getKeys then
            pat_index = 1
            shuffle(getKeys)
        end
    end
end

-- onLevelUpApply
function onIncrement()
end

-- onLevelCloseOrRestart
function onUnload()
end

-- call every delta frame
function onUpdate(mFrameTime)
end
