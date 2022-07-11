u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_common.lua")

SPINNINGCONSTANT = 0.9450024
--this constant roughly determines how fast the world must spin to be as fast as the triangular cursor (note: could use improving)
SPINTOCURVEMULTIPLIER = 10.471975
--this constant roughly determines how much l_getRotationSpeed() should be multiplied by to have a curving wall's horizontal movement match up perfectly (note: could use improving)
--default value would technically be 10, but that is TOO SLOW to match
SPINNINGDIVINFOCUS = 2.0436
--SPINTOCURVEMULTIPLIER/SPINNINGDIVINFOCUS roughly determines how fast the world must spin to be as fast as the triangular cursor WHEN IT IS IN FOCUS MODE (note: could use improving)

-- [type_name]TimesDo: returns to simple RNG types
function commonTimesDo() return u_rndInt(3, 5) end
function spiralTimesDo() return u_rndInt(7, 11) end
function tunnelTimesDo() return u_rndInt(1, 3) end

function addPlayerSide(mPolySide)
	local sideLength = (360 / l_getSides())
    u_setPlayerAngle(math.rad((getPlayerSide() * sideLength) + (mPolySide * sideLength)))
end

function getPlayerPos()
	local playerPosition = math.deg(u_getPlayerAngle())
	local pPos = playerPosition
	return math.floor(pPos % 360)
end

function addPlayerPos(mAmount)
	u_setPlayerAngle(math.rad(getPlayerPos() + mAmount))
end

function barrageFiller(mThickness, mNumbType)
	mThickness = mThickness or THICKNESS
	mNumbType = mNumbType or u_rndTablePick({ 1, 2, 7 })
	local side = getRandomSide()
	if mNumbType == 1 then rWall(side, mThickness)
	elseif mNumbType == 2 then cAltBarrage(side, 2, mThickness)
	elseif mNumbType == 3 then for a = 0, 1 do rWall(side, mThickness) t_wait(customizeTempoPatternDelay(a == 0 and 0.25 or 0)) end
	elseif mNumbType == 4 then for a = 0, 1 do cAltBarrage(side, 2, mThickness) t_wait(customizeTempoPatternDelay(a == 0 and 0.25 or 0)) end
	elseif mNumbType == 5 then rWall(side, customizeTempoPatternThickness(0.25) + mThickness)
	elseif mNumbType == 6 then cAltBarrage(side, 2, customizeTempoPatternThickness(0.25) + mThickness)
	elseif mNumbType == 7 then cBarrageHalf(side, mThickness)
	elseif mNumbType == 8 then cBarrageVorta(side, 0, mThickness)
	elseif mNumbType == 9 then cBarrageExHoles(side, 2, mThickness)
	elseif mNumbType == 10 then cBarrage(side, mThickness)
	end
end

function filler(mThickness, bIsRepeat, bIsThick)
	local side = getRandomSide()
	bIsRepeat = getBooleanNumber(bIsRepeat) and 1 or 0
	bIsThick = getBooleanNumber(bIsThick)
	local randomNumber = u_rndIntUpper(3)
	if randomNumber == 1 then
		if (not bIsThick) then
			for a = 0, bIsRepeat do
				cAltBarrage(side, 2, mThickness)
				t_wait(customizeTempoPatternDelay(0.25))
			end
		else cAltBarrage(side, 2, customizeTempoPatternThickness(0.25 * bIsRepeat) + mThickness)
		end
	elseif randomNumber == 2 then
		if (not bIsThick) then
			for a = 0, bIsRepeat do
				rWall(side, mThickness)
				t_wait(customizeTempoPatternDelay(0.25))
			end
		else rWall(side, customizeTempoPatternThickness(0.25 * bIsRepeat) + mThickness)
		end
	elseif randomNumber == 3 then
		if (not bIsThick) then
			for a = 0, bIsRepeat do
				cBarrageHalf(side, mThickness)
				t_wait(customizeTempoPatternDelay(0.25))
			end
		else cBarrageHalf(side, customizeTempoPatternThickness(0.25 * bIsRepeat) + mThickness)
		end
	end
end