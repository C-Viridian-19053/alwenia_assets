u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_utils.lua")
u_execDependencyScript("march31oluascr", "march31os_scr_base", "march31onne", "march31o_utility_classes.lua")

function mch_wallSwap()
	a_playPackSound("warning.ogg")
	u_setPlayerAngle(u_getPlayerAngle() + math.pi)
	l_setRotation((l_getRotation() + 180) % 360)
end

local os_charges = 5
local os_invulntimer = 0

function mch_invCharge(mFrameTime, mSwap, mInvDuration)
	if mSwap == true and (os_invulntimer <= 0 and os_charges > 0) then
		os_invulntimer = mInvDuration or 40
		a_playPackSound("invuln" .. u_rndIntUpper(3) .. ".ogg")
		os_charges = os_charges - 1
		l_setTutorialMode(true)
		s_setHueInc(12.5 / (u_getDifficultyMult() ^ 0.8))
	end
	if os_invulntimer > 0 then os_invulntimer = os_invulntimer - mFrameTime
	else
		l_setTutorialMode(false)
		s_setHueInc(0)
	end
end
function mch_getInvCharges() return os_charges end
function mch_setInvCharges(mChargeAmount) os_charges = mChargeAmount end

local os_emercharges = 1
local os_emerinvulntimer = 0
local hardmode = false
local readyto = true

function mch_emerInvCharge(mFrameTime, mSwap, mInvDuration)
	if mSwap == true and (os_emerinvulntimer <= 0 and os_emercharges > 0) then
		os_emerinvulntimer = mInvDuration or 40
		s_setHueInc(20)
		s_setPulseInc(0.05)
		l_setRotationSpeed(l_getRotationSpeed() * 10)
		hardmode = true
		l_setTutorialMode(true)
		a_playPackSound("star".. u_rndIntUpper(5) ..".ogg")
		os_emercharges = os_emercharges - 1
	end
	
	if os_emerinvulntimer > 0 then
		os_emerinvulntimer = os_emerinvulntimer - mFrameTime
	else
		l_setTutorialMode(false)
		s_setPulseInc(0)
		if (hardmode == true and readyto == true) then l_setRotationSpeed(l_getRotationSpeed() / 5) readyto = false end
	end
end

local os_dommyIsDown = false
local os_doomytimer = -256
local os_deathTriggeredHeld = false
local os_deathTriggeredOnce = false
local os_deathTriggeredWarn = false

function mch_doDommyStopper(mFrameTime, mSwap, mDeathFunct, bAddWarnMsg)
	if os_deathTriggered == false then
		if (mSwap) then
			if (not os_dommyIsDown) then
				if os_doomytimer > 0 then
					os_doomytimer = -256 --disable doom
					a_playPackSound("flashrefill.ogg")
					os_dommyIsDown = true
				else
					os_deathTriggeredWarn = true
					os_doomytimer = 0 --brought doom upon yourself
					if (getBooleanNumber(bAddWarnMsg) == true) then e_messageAddImportant("don't press space\nunless i tell you to!", 90001) end
				end
			end
		else os_dommyIsDown = false
		end

		if os_doomytimer == 0 then
			os_deathTriggeredHeld = true
			os_deathTriggeredOnce = true
			os_doomytimer = -256
			mDeathFunct()
		elseif os_doomytimer > 0 then
			os_doomytimer = os_doomytimer - 1
			e_messageAddImportant("quick, press space!", mFrameTime)
		elseif os_doomytimer == -256 and u_rndInt(1, 1500) == 83 then
			os_doomytimer = 120
		end
	end
end

function mch_getDeathTriggerWarn() return os_deathTriggeredWarn; end

function mch_getDeathTriggerHeldOfDommyStopper() return os_deathTriggeredHeld; end
function mch_getDeathTriggerOnceOfDommyStopper()
	if (os_deathTriggeredOnce) then os_deathTriggeredOnce = false; return true; end
	return false;
end

-- Constants
THICKNESS = 40			-- Wall thickness. Sometimes more convenient to define in utils
FOCUS_RATIO = 0.625		-- The percentage by which the player shrinks when focused
PLAYER_WIDTH_UNFOCUSED = 23
PLAYER_WIDTH_FOCUSED = PLAYER_WIDTH_UNFOCUSED * FOCUS_RATIO
PLAYER_TIP_DISTANCE_OFFSET = 7.3
PLAYER_BASE_DISTANCE_OFFSET = -2.025
PIVOT_RADIUS_TO_PLAYER_DISTANCE_RATIO = 0.75
PIVOT_BORDER_WIDTH = 5

-- Tests whether a table contains a specific value on any existing key
function tableContainsValue(val, table)
    for _, v in pairs(table) do
        if val == v then return true end
    end
    return false
end

-- Takes a coordinate, rotates it by R radians about the origin, and returns the new coordinates
function rotate2DPointAroundOrigin(R, x, y)
    local cos, sin = math.cos(R), math.sin(R)
    return x * cos - y * sin, x * sin + y * cos
end

-- Sets hue to a specific value by setting its min an max to the same value
function forceSetHue(h)
    s_setHueMin(h)
    s_setHueMax(h)
end

-- Sets pulse to a specific value by setting its min an max to the same value
function forceSetPulse(p)
    s_setPulseMin(p)
    s_setPulseMax(p)
end

-- Square wave function with period 1 and amplitude 1 at value <x> with duty cycle <d>
function squareWave(x, d)
	return -getNeg(x % 1 - closeValue(d, 0, 1))
end

-- Asymmetrical triangle wave function with period 1 and amplitude 1 at value <x>
-- Asymmetry can be adjusted with <d>
-- An asymmetry of 1 is equivalent to sawtooth wave
-- An asymmetry of 0 is equivalent to a reversed sawtooth wave
function triangleWave(x, d)
    x = x % 1
    d = closeValue(d, 0, 1)
    local p, x2 = 1 - d, 2 * x
    return (x < 0.5 * d) and (x2 / d) or (0.5 * (1 + p) <= x) and ((x2 - 2) / d) or ((1 - x2) / p)
end

-- Sawtooth wave function with period 1 and amplitude 1 at value x
function sawtoothWave(x)
	return 2 * (x - math.floor(0.5 + x))
end

-- Takes a value <i> between <a> and <b> and proportionally maps it to a value between <c> and <d>
function mapValue(i, a, b, c, d)
    return c + ((d - c) / (b - a)) * (i - a)
end

-- Guarantees an input value to be a valid number of sides. Falls back to the level's current number of sides if an invalid argument is given
function verifyShape(shape)
	return type(shape) == 'number' and math.floor(math.max(shape, 3)) or getProtocolSides()
end

local __fromHSV = fromHSV

-- fromHSV with type checking
function fromHSV(h, s, v)
	return __fromHSV(type(h) == 'number' and h or 0, type(s) == 'number' and clamp(s, 0, 1) or 1, type(v) == 'number' and clamp(v, 0, 1) or 1)
end

-- these 2 are from lua-users.org by Luc Bloom
-- math.sign: returns the sign of the number
function math.sign(v)
    return (v > 0 and 1) or (v == 0 and 0) or -1
end

-- math.round: rounds up fractional v to the nearest bracket
function math.round(v, bracket)
	bracket = bracket or 1
	return math.floor(v/bracket + math.sign(v) * 0.5) * bracket
end

-- table.lookForOne: Looks for atleast one of something in a table. T = table, R = what you're looking for
function table.lookForOne(t, r)
	for _,v in pairs(t) do
		if v == r then return true end
	end
	return false
end

-- Distance from the center to the player position
function getDistanceBetweenCenterAndPlayer()
    return l_getRadiusMin() * l_getPulse() / l_getPulseMin() + l_getBeatPulse()
end

-- Distance from center to tip of player arrow
function getDistanceBetweenCenterAndPlayerTip()
    return getDistanceBetweenCenterAndPlayer() + PLAYER_TIP_DISTANCE_OFFSET
end

-- Distance from center to base of player arrow (depends on focus)
function getDistanceBetweenCenterAndPlayerBase(mFocus)
    return getDistanceBetweenCenterAndPlayer() + PLAYER_BASE_DISTANCE_OFFSET * (mFocus and FOCUS_RATIO or 1)
end

-- Distance from the base to the tip of the player triangle (depends on focus)
function getPlayerHeight(mFocus)
    return PLAYER_TIP_DISTANCE_OFFSET - PLAYER_BASE_DISTANCE_OFFSET * (mFocus and FOCUS_RATIO or 1)
end

-- Base width of the player triangle (depends on focus)
function getPlayerBaseWidth(mFocus)
    return mFocus and PLAYER_WIDTH_FOCUSED or PLAYER_WIDTH_UNFOCUSED
end

-- Half of the base width of the player triangle (depends on focus)
function getPlayerHalfBaseWidth(mFocus)
    return getPlayerBaseWidth(mFocus) * 0.5
end

-- Radius of a circle circumscribed around the center polygon cap
function getCapRadius()
    return getDistanceBetweenCenterAndPlayer() * PIVOT_RADIUS_TO_PLAYER_DISTANCE_RATIO
end

-- Radius of a circle circumscribed around the center polygon
function getPivotRadius()
    return getCapRadius() + PIVOT_BORDER_WIDTH
end

-- Returns the speed of walls in units per frame (5 times the speed mult)
function getWallSpeedInUnitsPerFrame()
    return u_getSpeedMultDM() * 5
end

function l_setAllPulseSpeed(mValue)
	l_setPulseSpeed(mValue);
	l_setPulseSpeedR(mValue);
end

-- Max size of polygon, delay between pulses
function configBeatPulse(max, del)
	l_setBeatPulseMax(max)
	l_setBeatPulseDelayMax(del)
end

-- Minimum val, maximum val, speed, reversed speed, delay between pulses
function configWallPulse(min, max, sp, spr, del)
	l_setPulseMin(min)
	l_setPulseMax(max)
	l_setPulseSpeed(sp)
	l_setPulseSpeedR(spr)
	l_setPulseDelayMax(del)
end

function stopWallPulse(freezeAt)
	l_setPulseMin(freezeAt)
	l_setPulseMax(freezeAt)
	l_setPulseSpeed(0)
	l_setPulseSpeedR(0)
	l_setPulseDelayMax(0)
end

function clearAll()
	t_clear()
	u_clearWalls()
end

function l_setLevelValues(mStyle, mSpeedMult, mRotSpeed, mDelayMult, mSides, mPulseMin, mPulseMax, mPulseSpeed, mPulseSpeedR, mPulseDelayMax, mBeatPulseMax, mBeatPulseDelayMax, mRadiusMin, isSwapEnabled, isRndSideChanges, isDarkenUnevenBackgroundChunk)
	if (mSpeedMult ~= nil) then l_setSpeedMult(mSpeedMult) end
	if (mRotSpeed ~= nil) then l_setRotationSpeed(mRotSpeed) end
	if (mDelayMult ~= nil) then l_setDelayMult(mDelayMult) end
	if (mSides ~= nil) then l_setSides(mSides) end
	if (mPulseMin ~= nil) then l_setPulseMin(mPulseMin) end
	if (mPulseMax ~= nil) then l_setPulseMax(mPulseMax) end
	if (mPulseSpeed ~= nil) then l_setPulseSpeed(mPulseSpeed) end
	if (mPulseSpeedR ~= nil) then l_setPulseSpeedR(mPulseSpeedR) end
	if (mPulseDelayMax ~= nil) then l_setPulseDelayMax(mPulseDelayMax) end
	if (mBeatPulseMax ~= nil) then l_setBeatPulseMax(mBeatPulseMax) end
	if (mBeatPulseDelayMax ~= nil) then l_setBeatPulseDelayMax(mBeatPulseDelayMax) end
	if (mRadiusMin ~= nil) then l_setRadiusMin(mRadiusMin) end
	if (mStyle ~= nil) then s_setStyle(mStyle) end
	if (isSwapEnabled ~= nil) then l_setSwapEnabled(isSwapEnabled) end
	if (isRndSideChanges ~= nil) then l_enableRndSideChanges(isRndSideChanges) end
	if (isDarkenUnevenBackgroundChunk ~= nil) then l_setDarkenUnevenBackgroundChunk(isDarkenUnevenBackgroundChunk) end
end

--SHOUTOUTS TO SYYRION
function l_changeLevel(mLevelPath, mStyleID, mBacksoundName, mTimeSegment, bResetTime)
	u_execScript(mLevelPath);
	if (bResetTime) then l_resetTime() end
	if type(mStyleID) == "string" then s_setStyle(mStyleID) end
	if type(mBacksoundName) == "string" then
		if type(mTimeSegment) == "number" then a_setMusicSeconds(mBacksoundName, mTimeSegment);
		else a_setMusic(mBacksoundName);
		end
	end
	u_clearWalls(); t_clear();
	onInit(); onLoad();
end

function whyCantIJustGoToTheMenu()
	a_setMusic("emptyness")
	e_kill() -- that sucks
end

function whyCanIPlayerFailsThisChallenge(_msg, _is_err)
	if getBooleanNumber(_is_err) and (l_getOfficial()) then error(_msg)
	else                                                    e_messageAddImportant(_msg, 99999) e_kill() -- that sucks
	end
end
