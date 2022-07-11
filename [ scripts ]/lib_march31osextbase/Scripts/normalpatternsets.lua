u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_common.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_additional.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_additional_tunnel.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_cage.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_patterns_construct.lua")

function spawnHxdsPentPattern(mNumbSpawn)
	local _side = getRandomSide();
		if mNumbSpawn == 0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), false, 0, 0, 2, false, 1, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 1 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(3, 4), 1, 1, false, 0.77, 1, -1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(1, 2), 1, 1, false, 0.77, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 3 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, true, 0.7, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 4 then pMarch31osBarrageSpiralRev(_side, march31oPat_thickness, u_rndIntUpper(3), 1, 0, 1, 1, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 5 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 6 then pMarch31osBarrageReversals(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 + 1, 1, false, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 7 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndIntUpper(2) * 2 + 1, 2, 0, 3, true, true, 0, 0, 1, 1, false, false, 0, 3, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 8 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndInt(2, 3), 2, 0, 2, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 9 then pMarch31osRandomBarrages(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 11 then pMarch31osRandomBarrages(_side, march31oPat_thickness, u_rndInt(3, 5), nil, nil, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 12 then pMarch31osBarrageReversals(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 + 1, 1, true, 0.7, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 13 then pMarch31osBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(2, 3) * 2, 1, 1, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	end
end

function spawnHxdsHexPattern(mNumbSpawn)
	local _side = getRandomSide();
		if mNumbSpawn == 0                             then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), false, 0, 0, 2, false, 1, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 1 and getProtocolSides() > 5  then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 3, 0, 1, 1, true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 2                             then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(2, 3), 1, 1, false, 1, 1, -1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 3 and getProtocolSides() > 5  then pMarch31osBackAndForthTunnelCentral(_side, march31oPat_thickness * 2, nil, u_rndInt(3, 4) * 2, 0, 1, 0, 0, 0, false, 0, 0, 1, 1, false, false, 0, 2, false, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 4                             then pMarch31osBarrageSpiralRev(_side, march31oPat_thickness, u_rndIntUpper(3), 1, 0, 1, 1, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 5                             then pMarch31osBarrageReversals(_side, march31oPat_thickness, u_rndIntUpper(2) * 2 + 1, 1, true, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 6 and getProtocolSides() > 3  then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 7 and getProtocolSides() > 3  then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 2, 0, 1, 1, true, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 8 and getProtocolSides() > 4  then pMarch31osRandomBarrages(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 9                             then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndIntUpper(2), 2, 0, 2, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 10 and getProtocolSides() > 4 then pMarch31osTunnel(_side, march31oPat_thickness * 2, nil, u_rndInt(2, 3) * 2, 2, 0, 5, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 11                            then pMarch31osVortaBarrage(_side, march31oPat_thickness, 3, 0, 0, {}, 1, 0, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 12                            then pMarch31osBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(2, 3) * 2, 1, 1, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 13 and getProtocolSides() > 4 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, 3, 0, 1, 1, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	end
end

function getKeyHxdsPent()
getKeys = { 0, 1, 2, 3, 5, 6, 7, 8, 9, 11, 12, 13 }
shuffle(getKeys)
pat_index = 1
end

function getKeyHxdsHex()
getKeys = { 0, 0, 1, 2, 3, 3, 4, 5, 5, 6, 7, 8, 8, 9, 10, 11, 12, 12, 13 }
shuffle(getKeys)
pat_index = 1
end

function spawnBabaOldPattern(mNumbSpawn)
	local _side = getRandomSide();
		if mNumbSpawn ==  0 then pMarch31osAlternatingBarrage(_side, march31oPat_thickness, u_rndInt(3, 5), false, 0, 0, 2, false, 1, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  1 then pMarch31osWhirlwind(_side, u_rndInt(3, 6), 0, math.floor(getProtocolSides() / 3), 1, false, 1, 1, getRandomDir(), 0, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn ==  2 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 3), 1, 1, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn ==  3 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(0, 2), 1, 2, false, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
    elseif mNumbSpawn ==  4 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, 2, 1, 1, false, 0.7, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  5 then pMarch31osBarrageReversals(_side, march31oPat_thickness, 1, 1, false, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  6 then pMarch31osTunnel(_side, march31oPat_thickness * 1.75, nil, u_rndInt(1, 3), 2, 0, 2, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  7 then pMarch31osWallStrip(_side, march31oPat_thickness, 1, u_rndInt(2, 3), 0, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  8 and getProtocolSides() > 5 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndInt(1, 3), 0, 1, {}, 1, 0, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn ==  9 then pMarch31osBarrageSpiral(_side, march31oPat_thickness, u_rndInt(4, 7), 1, 1, false, 0.4, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 10 then pMarch31osRandomBarrages(_side, march31oPat_thickness, u_rndInt(2, 4), nil, nil, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 11 then pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndInt(4, 6), 2, 0, 2, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 2, nil, 0, nil, 0.5, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 12 then pMarch31osRandomWhirlwind(_side, u_rndInt(6, 8), 0, math.floor(getProtocolSides() / 3), 1, 1, 1, getRandomDir(), 0, 0, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 13 then pMarch31osTrapAround(_side, 0, 1, 0, 0, 0, 1, 1, 2, 0, 1, 1, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 14 then pMarch31osAlternatingTunnel(_side, march31oPat_thickness, nil, u_rndInt(2, 5), 2, 1, true, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 15 and getProtocolSides() > 5 then pMarch31osVortaBarrage(_side, march31oPat_thickness, u_rndInt(4, 6), 0, 0, {}, 1, 0, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 16 then pMarch31osGrowingBarrage(_side, march31oPatDel_AdditionalDelay)
	elseif mNumbSpawn == 17 then pMarch31osDoubleHoledBarrageSpiral(_side, march31oPat_thickness, u_rndInt(5, 9), 0, 1, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 18 then pMarch31osDoubleHoledBarrageLeftRights(_side, march31oPat_thickness, u_rndInt(5, 8), 0, 1, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 19 then pMarch31osDoubleHoledBarrageInversions(_side, march31oPat_thickness, u_rndInt(6, 9), 0, true, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 20 then pMarch31osAltHalfBarrage(_side, march31oPat_thickness, u_rndInt(2, 4), 0, 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 21 then pMarch31osWhirlwind(_side, u_rndInt(4, 6), 2, 1, 1, false, 1, 1, getRandomDir(), 0, 0, false, march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 22 then pMarch31osCtoCIBarrage(_side, _thickness, u_rndInt(4, 8), 1, 1, getRandomDir(), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	elseif mNumbSpawn == 23 then
		local _mode = u_rndInt(0, 1)
		pMarch31osTunnel(_side, march31oPat_thickness, nil, u_rndInt(1, 4), 1, 0, _mode == 1 and math.floor(getProtocolSides() / 2) + 2 or getProtocolSides() - 1, true, true, 0, 0, 1, 1, false, false, 0, 2, false, 1, nil, 0, nil, 1, 1, u_rndInt(0, 1), march31oPatDel_AdditionalDelay, march31oPatDel_AddMult)
	end
end

function getKeyBabaOld()
getKeys = { 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8, 9, 10, 10, 10, 11, 12, 14, 15, 15, 16, 16, 16, 16, 17, 18, 19, 20, 20, 21, 22, 22, 23 }
shuffle(getKeys)
pat_index = 1
end