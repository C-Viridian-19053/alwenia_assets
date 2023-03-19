-- taken from baum's OH 1.92 compatibility

function __192common_get_timeline_module()
	local Timeline = {}
	Timeline.__index = Timeline

	function Timeline:new()
		return setmetatable({ready = true, finished = false, commands = {}, current_command = nil, current_index = 1}, Timeline)
	end

	function Timeline:update(frametime)
		if self.finished then
			return
		end
		self.ready = true
		repeat
			if self.current_command == nil then
				self.finished = true
				self.ready = false
				break
			end
			self.current_command:update(frametime)
		until not self.ready
	end

	function Timeline:append(command)
		table.insert(self.commands, command)
		if self.current_command == nil then
			self.current_command = command
			self.current_index = #self.commands
		end
	end

	function Timeline:insert(index, command)
		table.insert(self.commands, index, command)
		if self.current_command == nil then
			self.current_command = command
			self.current_index = index
		end
	end

	function Timeline:reset()
		self:start()
		for _, command in pairs(self.commands) do
			command:reset()
		end
		if #self.commands ~= 0 then
			self.current_command = self.commands[1]
		else
			self.current_command = nil
		end
		self.current_index = 1
	end

	function Timeline:clear()
		self.current_command = nil
		self.current_index = 1
		self.commands = {}
		self.finished = true
	end

	function Timeline:start()
		self.finished = false
		self.ready = true
	end

	function Timeline:next()
		if self.current_command == nil then
			return
		end
		self.current_index = self.current_index + 1
		self.current_command = self.commands[self.current_index]
	end

	function Timeline:get_current_index()
		if self.current_command == nil then
			return 1
		else
			if self.current_index > #self.commands then
				return -1
			end
			return self.current_index
		end
	end


	local Wait = {}
	Wait.__index = Wait

	function Wait:new(timeline, frameAmount)
		return setmetatable({timeline = timeline, frame = frameAmount or 0, remaining_frame = frameAmount}, Wait)
	end

	function Wait:update(frametime)
		self.timeline.ready = false
		self.remaining_frame = self.remaining_frame - frametime
		if self.remaining_frame - frametime > frametime then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function Wait:reset()
		self.remaining_frame = self.frame
	end


	local WaitS = {}
	WaitS.__index = WaitS

	function WaitS:new(timeline, durationAmount)
		return setmetatable({timeline = timeline, time = durationAmount or 0, remaining_time = durationAmount}, WaitS)
	end

	function WaitS:update(frametime)
		self.timeline.ready = false
		self.remaining_time = self.remaining_time - (frametime / 60)
		if self.remaining_time - (frametime / 60) > (frametime / 60) then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function WaitS:reset()
		self.remaining_time = self.time
	end


	local WaitUntilS = {}
	WaitUntilS.__index = WaitUntilS

	function WaitUntilS:new(timeline, durationAmount)
		return setmetatable({timeline = timeline, time = durationAmount or 0, remaining_time = durationAmount}, WaitUntilS)
	end

	function WaitUntilS:update(frametime)
		self.timeline.ready = false
		self.remaining_time = self.remaining_time - (frametime / 60)
		if self.remaining_time - (frametime / 60) > (frametime / 60) then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function WaitUntilS:reset()
		self.remaining_time = self.time
	end


	local Do = {}
	Do.__index = Do

	function Do:new(timeline, action)
		return setmetatable({timeline = timeline, action = action}, Do)
	end

	function Do:update()
		self.action()
		self.timeline:next()
	end

	function Do:reset()
	end

	return Timeline, Wait, WaitS, WaitUntilS, Do
end


function __2common_get_event_timeline_module()
	local EventTimeline = {}
	EventTimeline.__index = EventTimeline

	function EventTimeline:new()
		return setmetatable({ready = true, finished = false, commands = {}, current_command = nil, current_index = 1}, EventTimeline)
	end

	function EventTimeline:update()
		if self.finished then
			return
		end
		self.ready = true
		repeat
			if self.current_command == nil then
				self.finished = true
				self.ready = false
				break
			end
			self.current_command:update()
		until not self.ready
	end

	function EventTimeline:append(command)
		table.insert(self.commands, command)
		if self.current_command == nil then
			self.current_command = command
			self.current_index = #self.commands
		end
	end

	function EventTimeline:insert(index, command)
		table.insert(self.commands, index, command)
		if self.current_command == nil then
			self.current_command = command
			self.current_index = index
		end
	end

	function EventTimeline:reset()
		self:start()
		for _, command in pairs(self.commands) do
			command:reset()
		end
		if #self.commands ~= 0 then
			self.current_command = self.commands[1]
		else
			self.current_command = nil
		end
		self.current_index = 1
	end

	function EventTimeline:clear()
		self.current_command = nil
		self.current_index = 1
		self.commands = {}
		self.finished = true
	end

	function EventTimeline:start()
		self.finished = false
		self.ready = true
	end

	function EventTimeline:next()
		if self.current_command == nil then
			return
		end
		self.current_index = self.current_index + 1
		self.current_command = self.commands[self.current_index]
	end

	function EventTimeline:get_current_index()
		if self.current_command == nil then
			return 1
		else
			if self.current_index > #self.commands then
				return -1
			end
			return self.current_index
		end
	end


	local EWait = {}
	EWait.__index = EWait

	function EWait:new(timeline, frameAmount)
		return setmetatable({timeline = timeline, frame = frameAmount or 0, remaining_frame = frameAmount, timeStart = os.clock()}, EWait)
	end

	function EWait:update()
		self.timeline.ready = false
		self.remaining_frame = self.remaining_frame - ((os.clock() - timeStart) * 60)
		if self.remaining_frame > 0 then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function EWait:reset()
		self.remaining_frame = self.frame
	end


	local EWaitS = {}
	EWaitS.__index = EWaitS

	function EWaitS:new(timeline, durationAmount)
		return setmetatable({timeline = timeline, time = durationAmount or 0, remaining_time = durationAmount, timeStart = os.clock()}, EWaitS)
	end

	function EWaitS:update()
		self.timeline.ready = false
		self.remaining_time = self.remaining_time - (os.clock() - timeStart)
		if self.remaining_time > 0 then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function EWaitS:reset()
		self.remaining_time = self.time
	end


	local EWaitUntilS = {}
	EWaitUntilS.__index = EWaitUntilS

	function EWaitUntilS:new(timeline, durationAmount)
		return setmetatable({timeline = timeline, time = durationAmount or 0, remaining_time = durationAmount, timeStart = os.clock()}, EWaitUntilS)
	end

	function EWaitUntilS:update()
		self.timeline.ready = false
		self.remaining_time = self.remaining_time - (os.clock() - timeStart)
		if self.remaining_time > 0 then
			return
		end
		self.timeline:next()
		self:reset()
	end

	function EWaitUntilS:reset()
		self.remaining_time = self.time
	end


	local EventDo = {}
	EventDo.__index = EventDo

	function EventDo:new(timeline, action)
		return setmetatable({timeline = timeline, action = action}, Do)
	end

	function EventDo:update()
		self.action()
		self.timeline:next()
	end

	function EventDo:reset()
	end

	return EventTimeline, EWait, EWaitS, EWaitUntilS, EventDo
end
