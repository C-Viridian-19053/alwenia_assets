--[[
    Some of my garbage extended base script for Open Hexagon 2.1.x+

    This utility functions/constants are borrowed and taken from:
    - Trollbreeder
    - Dav999 (VVVVVV)
    - NDagger
    - The Sun XIX
    - Syyrion
    - Babadrake
    - Lyrit Zian

    Which were made/modified by me (__march31onne, March31onne Evangelisti).

    marchionne's note: iv tried to import other base script on
    my extended base script but didn't work. but how? the game says
    the other base scrpt pack isn't a dependency of my pack

    i tried to correct this dependency filename with matched filename,
    and iv double check it, still wont work af.

    i think the game engine were screwed up, so i copy and paste
    instead, and i'll credit from OH creators. sorry T_T
]]

u_execDependencyScript("ohvrvanilla", "base", "vittorio romeo", "utils.lua")
u_execDependencyScript("library_march31osbasescripts", "march31os_scr_base", "march31onne", "march31o_utils.lua")
u_execDependencyScript("library_march31osbasescripts", "march31os_scr_base", "march31onne", "march31o_utility_classes.lua")

--[[
    * DIMENSION CONSTANTS
]]
FOCUS_RATIO = 0.625
PLAYER_WIDTH_UNFOCUSED = 23
PLAYER_WIDTH_FOCUSED = PLAYER_WIDTH_UNFOCUSED * FOCUS_RATIO
PLAYER_TIP_DISTANCE_OFFSET = 7.3
PLAYER_BASE_DISTANCE_OFFSET = -2.025
PIVOT_RADIUS_TO_PLAYER_DISTANCE_RATIO = 0.75
PIVOT_BORDER_WIDTH = 5

--[[
    * TIME CONSTANTS
]]
FRAMES_PER_SECOND = FPS or 60
SECONDS_PER_FRAME = 1 / FRAMES_PER_SECOND

TICKS_PER_FRAME = 4
FRAMES_PER_TICK = 1 / TICKS_PER_FRAME

TICKS_PER_SECOND = FRAMES_PER_SECOND * TICKS_PER_FRAME
SECONDS_PER_TICK = 1 / TICKS_PER_SECOND

-- These assume a player speed multiplier of 1
FRAMES_PER_PLAYER_ROTATION = 800 / 21
TICKS_PER_PLAYER_ROTATION = FRAMES_PER_PLAYER_ROTATION * TICKS_PER_FRAME
SECONDS_PER_PLAYER_ROTATION = FRAMES_PER_PLAYER_ROTATION * SECONDS_PER_FRAME

--[[
    * OTHER CONSTANTS
]]
THICKNESS = 40			-- Wall thickness. Sometimes more convenient to define in utils

--[[
    * GENERAL UTILITIES
]]

-- for shader only!
function updateVignetteShader(mShaderID, mRed, mGreen, mBlue)
    shdr_setUniformF(mShaderID, "COL_R", mRed or 0)
    shdr_setUniformF(mShaderID, "COL_G", mGreen or mRed)
    shdr_setUniformF(mShaderID, "COL_B", mBlue or mRed)
end
--

function l_setAllPulseSpeed(mValue)
	l_setPulseSpeed(mValue);
	l_setPulseSpeedR(mValue);
end

function clearAll()
	t_clear()
	u_clearWalls()
end

function l_setLevelValues(mStyle, mSpeedMult, mRotSpeed, mDelayMult, mSides, mPulseMin, mPulseMax, mPulseSpeed, mPulseSpeedR, mPulseDelayMax, mBeatPulseMax, mBeatPulseDelayMax, mRadiusMin, isSwapEnabled, isRndSideChanges, isDarkenUnevenBackgroundChunk, mSpawnDistance)
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
	l_setWallSpawnDistance(mSpawnDistance or 1600)
end

LevSyncDebug = {
	Timer = 0,
	Times = 0
}

-- runDebugLevelSync: runs a debug level sync, it's useful to use debug this synced level
function runDebugLevelSync(mBPM, m2ndTS, bDebugMsg)
	m2ndTS = m2ndTS or 4
	mBPM = mBPM or 128

	if getBooleanNumber(bDebugMsg) then
		e_messageAddImportantSilent("BPM: " .. mBPM .. "\nBeat: " .. LevSyncDebug.Times .. " | " .. ((LevSyncDebug.Times - 1) % m2ndTS) + 1 .. "/" .. m2ndTS, .25)
	end

	if l_getLevelTime() > LevSyncDebug.Timer then
		LevSyncDebug.Timer = LevSyncDebug.Timer + (60/mBPM)
		LevSyncDebug.Times = LevSyncDebug.Times + 1
	end
end

function setDebugLevelSyncTimerOffset(mOffsetDuration)
	LevSyncDebug.Timer = mOffsetDuration or 0
end

-- there is from my old common by me (Marchionne)
-- getSpeedWallThickness: returns a regular walls' amount of thickness caculated with speed multiplier.
function getSpeedWallThickness(mAmount) return (mAmount * (u_getSpeedMultDM()) / 2); end

---- these 2 are from lua-users.org by Luc Bloom
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
----

---- these 2 are from Ved's lua script by Dav999
-- probably, i certainly use it maybe.
function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

local sincet = 0

function cons(text)
	if text == nil then
		text = "nil"
	elseif type(text) == "boolean" then
		text = (text and "TRUE" or "FALSE")
	end
	print("[" .. round(l_getLevelTime(), 2) .. "\\" .. round(l_getLevelTime()-sincet, 2) .. "] " .. text)
	sincet = round(l_getLevelTime(), 2)
end
----

---- these 4 are from NDag's levelpack utils script by NDag
function createEvent(type, timing, action, offset)
    local offset = offset or 0
    local timeline = ct_create()

    if type == 1 then
        ct_waitUntilS(timeline, offset + timing)
    else
        ct_waitS(timeline, offset + timing)
    end
    ct_eval(timeline, action)
end

function createEvents(type, timings, action, offset)
    local offset = offset or 0
    local timeline = ct_create()

    for _, timing in ipairs(timings) do
        if type == 1 then
            ct_waitUntilS(timeline, offset + timing)
        else
            ct_waitS(timeline, offset + timing)
        end
        ct_eval(timeline, action)
    end
end

function clone(obj)
    if type(obj) ~= 'table' then return obj end
    local copy = {}
    for k, v in pairs(obj) do
        copy[k] = clone(v)
    end
    setmetatable(copy, getmetatable(obj))
    return copy
end

function instanceof(obj, class)
    local mt = getmetatable(obj)
    while mt do
        if mt == class then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end
----

---- these 2 are from Abberation's core script by The Sun XIX
function shuffle2D(x)
	for k = 1, #x do
		for i = #x[k], 2, -1 do
			local j = u_rndIntUpper(i)
			x[k][i], x[k][j] = x[k][j], x[k][i]
		end
	end
end

function forceSetPulseDiff(p, d)
    if d >= 0 then
        s_setPulseMin(p)
        s_setPulseMax(p + d)
    else
        s_setPulseMin(p + d)
        s_setPulseMax(p)
    end
end

function forceSetPulse3D(value)
    s_set3dPulseMin(value)
    s_set3dPulseMax(value)
end

function whyCantIJustGoToTheMenu()
	e_kill() -- that sucks less
end

function howPlayerDidJustBrokeTheRules(_msg, _is_err)
	e_messageAddImportant(_msg, 99999)
	if getBooleanNumber(_is_err) and (l_getOfficial()) then
		error(_msg, 0)
	else
		l_setRotationSpeed(math.huge)
		l_setPulseMin(math.huge)
	end
	e_kill()
end
----

---- These some are from lib_extbase by Syyrion, modified by me.
-- No operation function
function __NOP(...) return ... end

-- Similar to __NOP but doesn't return anything
function __NIL(...) end

-- Function that always returns true
function __TRUE(...) return true end

-- Function that always returns false
function __FALSE(...) return false end

-- Common functions for sifting erroneous values
Filter = {}

-- Types
Filter.NIL = function (val) return type(val) == 'nil' end
Filter.NUMBER = function (val) return type(val) == 'number' end
Filter.STRING = function (val) return type(val) == 'string' end
Filter.BOOLEAN = function (val) return type(val) == 'boolean' end
Filter.TABLE = function (val) return type(val) == 'table' end
Filter.FUNCTION = function (val) return type(val) == 'function' end
Filter.THREAD = function (val) return type(val) == 'thread' end
Filter.USERDATA = function (val) return type(val) == 'userdata' end

-- Numeric filters
Filter.POSITIVE = function (val) return Filter.NUMBER(val) and val > 0 end
Filter.NON_NEGATIVE = function (val) return Filter.NUMBER(val) and val >= 0 end
Filter.NEGATIVE = function (val) return Filter.NUMBER(val) and val < 0 end
Filter.NON_POSITIVE = function (val) return Filter.NUMBER(val) and val <= 0 end
Filter.NON_ZERO = function (val) return Filter.NUMBER(val) and val ~= 0 end

Filter.INTEGER = function (val) return Filter.NUMBER(val) and math.floor(val) == val end
Filter.NON_ZERO_INTEGER = function (val) return Filter.INTEGER(val) and val ~= 0 end
Filter.WHOLE = function (val) return Filter.INTEGER(val) and val >= 0 end
Filter.NATURAL = function (val) return Filter.INTEGER(val) and val > 0 end
Filter.SIDE_COUNT = function (val) return Filter.INTEGER(val) and val >= 3 end

-- Returns a table of strings derived from splitting <str> with <pattern>.
function string.split(str, pattern)
    local t, capture = {}, nil
    while true do
        local prev = str
        capture, str = str:match('(.-)' .. pattern .. '(.*)')
        if not capture or str == prev then
            table.insert(t, prev)
            break
        end
        table.insert(t, capture)
    end
    return unpack(t)
end

-- Returns an iterator function that iterates over all split strings.
function string.gsplit(str, pattern)
    return coroutine.wrap(function ()
        local capture
        pattern = '(.-)' .. pattern .. '(.*)'
        while true do
            local prev = str
            capture, str = str:match(pattern)
            if not capture or str == prev then
                coroutine.yield(prev)
                break
            end
            coroutine.yield(capture)
        end
    end)
end

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

function polarToCartesian(r, a)
    return r * math.cos(a), r * math.sin(a)
end

-- Sets hue to a specific value by setting its min an max to the same value
function forceSetHue(hMin, hMax)
    s_setHueMin(hMin)
    s_setHueMax(hMax or hMin)
end

-- Sets pulse to a specific value by setting its min an max to the same value
function forceSetPulse(pMin, pMax)
    s_setPulseMin(pMin)
    s_setPulseMax(pMax or pMin)
end

-- Takes a value <i> between <a> and <b> and proportionally maps it to a value between <c> and <d>
function mapValue(i, a, b, c, d)
    return c + ((d - c) / (b - a)) * (i - a)
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

--[[
    * WAVES
]]
Wave = {
    -- Square wave function with period 1 and amplitude 1 at value <x> with duty cycle <d>
    square = function (x, d)
        return -getNeg(x % 1 - closeValue(d, 0, 1))
    end,

    -- Asymmetrical triangle wave function with period 1 and amplitude 1 at value <x>
    -- Asymmetry can be adjusted with <d>
    -- An asymmetry of 1 is equivalent to sawtooth wave
    -- An asymmetry of 0 is equivalent to a reversed sawtooth wave
    triangle = function (x, d)
        x = x % 1
        d = closeValue(d, 0, 1)
        local p, x2 = 1 - d, 2 * x
        return (x < 0.5 * d) and (x2 / d) or (0.5 * (1 + p) <= x) and ((x2 - 2) / d) or ((1 - x2) / p)
    end,

    -- Sawtooth wave function with period 1 and amplitude 1 at value x
    sawtooth = function (x)
        return 2 * (x - math.floor(0.5 + x))
    end
}
-- ! Legacy function names
squareWave = Wave.square
triangleWave = Wave.triangle
sawtoothWave = Wave.sawtooth

--[[
    * DIMENSIONS
]]

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

--[[
    * THICKNESS AND DELAYS
]]

-- Returns the speed of walls in units per frame (5 times the speed mult)
function getWallSpeedInUnitsPerFrame()
    return u_getSpeedMultDM() * 5
end

-- Returns the amount of frames/ticks/seconds it takes for a certain thickness of wall to travel one full length of itself
function thicknessToFrames(th)
    return th / getWallSpeedInUnitsPerFrame()
end

function thicknessToTicks(th)
    return thicknessToFrames(th) * TICKS_PER_FRAME
end

function thicknessToSeconds(th)
    return thicknessToFrames(th) * SECONDS_PER_FRAME
end

-- Inverse of the above functions
function framesToThickness(frames)
    return getWallSpeedInUnitsPerFrame() * frames
end

function ticksToThickness(ticks)
    return framesToThickness(ticks * FRAMES_PER_TICK)
end

function secondsToThickness(seconds)
    return framesToThickness(seconds * FRAMES_PER_SECOND)
end

-- Returns the amount of time in frames/ticks/seconds for the player make one full revolution adjusted for the player speed multiplier.
function getTicksPerPlayerRotation()
    return TICKS_PER_PLAYER_ROTATION / l_getPlayerSpeedMult()
end

function getFramesPerPlayerRotation()
    return FRAMES_PER_PLAYER_ROTATION / l_getPlayerSpeedMult()
end

function getSecondsPerPlayerRotation()
    return SECONDS_PER_PLAYER_ROTATION / l_getPlayerSpeedMult()
end

-- Returns the amount of time in frames/ticks/seconds for the player travel across one side.
function getIdealDelayInTicks(sides)
    return getTicksPerPlayerRotation() / (sides or getProtocolSides())
end

function getIdealDelayInFrames(sides)
    return getFramesPerPlayerRotation() / (sides or getProtocolSides())
end

function getIdealDelayInSeconds(sides)
    return getSecondsPerPlayerRotation() / (sides or getProtocolSides())
end

function getIdealThickness(sides)
    return ticksToThickness(getIdealDelayInTicks(sides))
end

function createSolidPolygonConstructor(sides, fn)
    sides, fn = Filter.SIDE_COUNT(sides) and sides or errorf(2, 'CreatePolygonConstructor', 'Invalid side count.'), type(fn) == "function" and fn or cw_createNoCollision
    local arc, limit, t = math.tau / sides, math.floor(sides / 2), {}
    local a, b = 0, sides - 1
    local aa, ba = 0, b * arc
    repeat
        local key = fn()
        t[key] = {[0] = ba, [1] = aa}
        a, b = a + 1, b - 1
        aa, ba = a * arc, b * arc
        t[key][2] = aa
        t[key][3] = ba
    until b == limit
    return t
end

--[[
    * CLASSES
]]

local CascadeChain = {sieve = __FALSE}
CascadeChain.__index = CascadeChain

function CascadeChain:new(init, def)
    local newInst = setmetatable({}, self)
    newInst.__index = newInst
    newInst:set(init)
    newInst:define(def)
    return newInst
end
-- Sets a value. If verification fails, the value is removed.
function CascadeChain:set(val)
    if self.sieve(val) then
        self.val = val
        return val
    end
    self.val = nil
end
-- Gets a value.
function CascadeChain:get() return self.val end
-- Modifies the behavior of the get function.
function CascadeChain:define(fn) self.get = type(fn) == 'function' and fn or nil end
-- Gets a value without searching for a default value.
function CascadeChain:rawget() return rawget(self, 'val') end
-- Sets a value to its default.
function CascadeChain:freeze()
    self.val = nil
    self.val = self:get()
end

Cascade = {}

-- Creates the root of a new cascade chain.
function Cascade.new(filter, init, def)
    local newInst = setmetatable({
        sieve = type(filter) == 'function' and filter or errorf(2, "NewCascade", "A valid filter must be specified.")
    }, CascadeChain)
    newInst.__index = newInst
    newInst:set(init)
    newInst:define(def)
    return newInst
end



Channel = {}
Channel.__index = Channel

function Channel:new(r, g, b, a, def)
    local newInst = setmetatable({}, self)
    newInst.__index = newInst
    newInst:set(r, g, b, a)
    newInst:define(def)
    return newInst
end

function Channel:setcolor(r, g, b)
    self.r = Filter.NUMBER(r) and r or nil
    self.g = Filter.NUMBER(g) and g or nil
    self.b = Filter.NUMBER(b) and b or nil
end

function Channel:sethsv(h, s, v)
    self.r, self.g, self.b = fromHSV(h, s, v)
end

function Channel:setalpha(a)
    self.a = Filter.NUMBER(a) and a or nil
end

function Channel:set(r, g, b, a)
    self:setcolor(r, g, b)
    self:setalpha(a)
end

function Channel:get()
    local r, g, b, a = s_getMainColor()
    return self.r or r, self.g or g, self.b or b, self.a or a
end

function Channel:define(fn) self.get = type(fn) == 'function' and fn or nil end

function Channel:rawget() return rawget(self, 'r'), rawget(self, 'g'), rawget(self, 'b'), rawget(self, 'a') end

function Channel:freeze()
    self.r, self.g, self.b, self.a = nil, nil, nil, nil
    self.r, self.g, self.b, self.a = self:get()
end



Incrementer = {value = 0}
Incrementer.__index = Incrementer

function Incrementer:new(start, target, steps)
    local newInst = setmetatable({
        new = __NIL,
        start = Filter.NUMBER(start) and start or errorf(1, 'Incrementer', 'Argument #1 is not a number'),
        target = Filter.NUMBER(target) and target or errorf(1, 'Incrementer', 'Argument #2 is not a number'),
        progress = 0,
        limit = Filter.WHOLE(steps) and steps or errorf(1, 'Incrementer', 'Argument #3 is not a whole number')
    }, self)
    newInst.value = newInst.start
    return newInst
end

function Incrementer:restart()
    self.progress = 0
    self.value = self.start
    return self.value
end

function Incrementer:increment()
    if self.progress == self.limit then return self.value end
    self.progress = self.progress + 1
    self.value = mapValue(self.progress, 0, self.limit, self.start, self.target)
    return self.value
end

function Incrementer:get()
    return self.value
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
----

--[[
    * CUSTOM MECHANICS
]]

-- baba's mechanics
local isDownSwap, isDownInv = false, false
local statSideSwap, statSideFocus, mechanicType = false, false, 0
local invinc_swap, invinc_charge, invCooldown = 0, 0, 0
local isInvReady, isInvDeployed, invSyncFix = false, false, 0
local invProgress, invProgrDebounceOne, invProgrDebounceTwo = 0, 0, 0
local isSwapped, isCharged = false, false

globalInvicibilityType = 0

function mch_resetInvSync(_beat_duration_amount)
	invinc_charge = convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE, 1, 4 * GLOBAL_TIME_SIGNATURE - 1.5)
end

-- spaghetti code or smth
function mch_enableMechanics(mFrameTime, mFocus, mSwap, bIsSwapEnabled, bIsInvEnabled, mInvDuration, mInvCoolDuration)
	if getProtocolSides() > 7 and bIsInvEnabled then
		statSideSwap = mSwap
	else
		statSideSwap = (bIsSwapEnabled) and true or mSwap
	end

	-- emergency invicibility
	if bIsInvEnabled then
		if bIsSwapEnabled then
			statSideFocus = mFocus
		else
			statSideFocus = true
		end

		if statSideFocus == true then
			if mechanicType == 0 then
				if invProgrDebounceOne == 0 then
					invProgrDebounceOne = 1
					invProgress = invProgress + 1
				end
				if statSideSwap == true and invCooldown <= 0 then
					if invProgrDebounceTwo == 0 then
						invProgrDebounceTwo = 1
						invProgress = invProgress + 1
					end
					if invProgress >= 2 then
						if isDownInv == false then
							isInvDeployed = true
							isInvReady = false
							isCharged = true
							a_playPackSound("star" .. u_rndIntUpper(5) .. ".ogg")
							invCooldown = mInvCoolDuration or 15
							if globalInvicibilityType == 0 then
								invinc_charge = mInvDuration or 1
							end
						end
						invProgress = 0
					end
					mechanicType = 1
					isDownInv = true
				end
			end
		else
			invProgrDebounceOne = 0
			invProgrDebounceTwo = 0
			invProgress = 0
			mechanicType = 0
			isDownInv = false
		end
	end
	--

	-- swap
	if bIsSwapEnabled then
		if mSwap == true then
			if isDownSwap == false then
				if mechanicType == 0 then
					u_swapPlayer(true)
					isSwapped = true
					if invinc_swap < 0.35 then
						invinc_swap = 1
					end
				end
			end
			mechanicType = -1
			isDownSwap = true
		else
			isDownSwap = false
			mechanicType = 0
		end
	end
	--

	if invCooldown < 0 and isInvReady == false then
		isInvReady = true
		a_playSound("swapBlip.ogg")
	end

	invinc_swap = convValue(mFrameTime, invinc_swap, 0, 1)
	invinc_charge = invinc_charge - (mFrameTime / 60)
	invCooldown = invCooldown - (mFrameTime / 60)

	if globalInvicibilityType == 1 then
		local syncFunctShortened = convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE)
		invSyncFix = loopValue(invinc_charge + (syncFunctShortened * 1.1), syncFunctShortened * -.5, syncFunctShortened * 4 * GLOBAL_TIME_SIGNATURE - (syncFunctShortened * .5))
		if invSyncFix <= 0 then
			isInvDeployed = false
		end
	else
		if invinc_charge <= 0 then
			isInvDeployed = false
		end
	end

	l_setTutorialMode((invinc_swap >= 0.85) or isInvDeployed)
end

function mch_isSwappedOnce()
	if isSwapped then
		isSwapped = false
		return true
	end
	return false
end

function mch_isChargedOnce()
	if isCharged then
		isCharged = false
		return true
	end
	return false
end

-- omegasphere mechanics
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

function mch_doDoomyHalter(mFrameTime, mSwap, mDeathFunct, bAddWarnMsg)
	if os_deathTriggered == false then
		if (mSwap) then
			if (not os_dommyIsDown) then
				if math.floor(os_doomytimer) > 0 then
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

		if math.floor(os_doomytimer) == 0 then
			os_deathTriggeredHeld = true
			os_deathTriggeredOnce = true
			os_doomytimer = -256
			if (mDeathFunct) then
				mDeathFunct()
			else
				l_setRotationSpeed(math.huge)
				l_setPulseMin(math.huge)
			end
		elseif math.floor(os_doomytimer) > 0 then
			os_doomytimer = os_doomytimer - mFrameTime
			e_messageAddImportant("quick, press space!", mFrameTime)
		elseif math.floor(os_doomytimer) == -256 and u_rndInt(1, 1500) == 83 then
			os_doomytimer = 120
		end
	end
end

function mch_getDeathTriggerWarn() return os_deathTriggeredWarn; end

function mch_getDeathTriggerHeldOfDoomyHalter() return os_deathTriggeredHeld; end
function mch_getDeathTriggerOnceOfDoomyHalter()
	if (os_deathTriggeredOnce) then os_deathTriggeredOnce = false; return true; end
	return false;
end

-- hexagons! mechanics
local h_isLoaded = false
h_score, h_scoreInc = 0, 0

function u_updateScore(mFrameTime, mDistStart)
    if (not h_isLoaded) then
        h_isLoaded = true
        h_scoreInc = -(mDistStart or 1600)
        l_overrideScore("h_score")
    end

    h_scoreInc = h_scoreInc + u_getSpeedMultDM() * 5 * mFrameTime
    h_score = ("%08d // "):format(closeValue(h_scoreInc, 0, 99999999, 'min')) .. simplifyFloat(l_getLevelTime(), 3)
end

function getSyncedDist()
    return 70 + 1100 * u_getSpeedMultDM() * 1.075 * convertBPMtoSeconds(GLOBAL_TEMPO * GLOBAL_TEMPO_DM_STATE) * GLOBAL_SPAWN_DISTANCE_MULT * GLOBAL_TIME_SIGNATURE + GLOBAL_SPAWN_DISTANCE_ADD
end