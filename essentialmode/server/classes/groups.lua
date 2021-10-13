--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --

-- Table with all groups
groups = {}

-- Constructor
Group = {}
Group.__index = Group

-- Allowing better inheritance
local _user = 'user'
local _headadmin = 'headadmin'
local _administrator = 'administrator'
local _moderator = 'moderator'
local _guide = 'guide'
local _supporter = 'supporter'
local _manager = 'manager'
local _projektleitung = 'projektleitung'
local _dev = 'dev'
local _TinyLara = 'TinyLara'

-- Meta table for groups
setmetatable(Group, {
	__eq = function(self)
		return self.group
	end,
	__tostring = function(self)
		return self.group
	end,
	__call = function(self, group, inh, ace)
		local gr = {}

		gr.group = group
		gr.inherits = inh
		gr.aceGroup = ace

		groups[group] = gr

		for k, v in pairs(Group) do
			if type(v) == 'function' then
				gr[k] = v
			end
		end

		return gr
	end
})

-- To check if a certain group can target another
function Group:canTarget(gr)
	if(gr == "")then
		return true
	elseif(self.group == "dev")then
		return true
	elseif(gr == "dev")then
		return false
	elseif(self.group == "TinyLara")then
		return true
	elseif(gr == "TinyLara")then
		return false
	elseif(self.group == "headadmin")then
		return true
	elseif(gr == "headadmin")then
		return false
	elseif(self.group == "moderator")then
		return true
	elseif(gr == "moderator")then
		return false
	elseif(self.group == "administrator")then
		return true
	elseif(gr == "administrator")then
		return false
	elseif(self.group == "supporter")then
		return true
	elseif(gr == "supporter")then
		return false
	elseif(self.group == "guide")then
		return true
	elseif(gr == "guide")then
		return false
	elseif(self.group == "manager")then
		return true
	elseif(gr == "manager")then
		return false
	elseif(self.group == "projektleitung")then
		return true
	elseif(gr == "projektleitung")then
		return false
	elseif(self.group == 'user')then
		if(gr == 'user')then
			return true
		else
			return false
		end
	else
		if(self.group == gr)then
			return true
		elseif(self.inherits == gr)then
			return true
		elseif(self.inherits == 'TinyLara')then
			return true
		elseif(self.inherits == 'headadmin')then
			return true
		elseif(self.inherits == 'moderator')then
			return true
		elseif(self.inherits == 'administrator')then
			return true
		elseif(self.inherits == 'supporter')then
			return true
		elseif(self.inherits == 'manager')then
			return true
		elseif(self.inherits == 'projektleitung')then
			return true
		elseif(self.inherits == 'guide')then
			return true
		elseif(self.inherits == 'dev')then
			return true
		else
			if(self.inherits == 'user')then
				return false
			else
				return groups[self.inherits]:canTarget(gr)
			end
		end
	end
end

-- Default groups
user = Group("user", "")
guide = Group("guide", "user")
supporter = Group("supporter", "guide")
moderator = Group("moderator", "supporter")
dev = Group("dev", "moderator")
administrator = Group("administrator", "dev")
headadmin = Group("headadmin", "administrator")
manager = Group("manager", "headadmin")
TinyLara = Group("TinyLara", "manager")
projektleitung = Group("projektleitung", "TinyLara")

-- ACL
ExecuteCommand('add_principal group.guide group.user')
ExecuteCommand('add_principal group.supporter group.guide')
ExecuteCommand('add_principal group.moderator group.supporter')
ExecuteCommand('add_principal group.dev group.moderator')
ExecuteCommand('add_principal group.administrator group.dev')
ExecuteCommand('add_principal group.headadmin group.administrator')
ExecuteCommand('add_principal group.manager group.headadmin')
ExecuteCommand('add_principal group.TinyLara group.manager')
ExecuteCommand('add_principal group.projektleitung group.TinyLara')

-- Developer, unused by default only for developer
dev = Group("dev", "projektleitung")

-- Custom groups
AddEventHandler("es:addGroup", function(group, inherit, aceGroup)
	if(type(aceGroup) ~= "string") then aceGroup = "user" end

	if(type(group) ~= "string")then
		log('ES_ERROR: There seems to be an issue while creating a new group, please make sure that you entered a correct "group" as "string"')
		print('ES_ERROR: There seems to be an issue while creating a new group, please make sure that you entered a correct "group" as "string"')
	end

	if(type(inherit) ~= "string")then
		log('ES_ERROR: There seems to be an issue while creating a new group, please make sure that you entered a correct "inherit" as "string"')
		print('ES_ERROR: There seems to be an issue while creating a new group, please make sure that you entered a correct "inherit" as "string"')
	end

	ExecuteCommand('add_principal group.' .. group .. ' group.' .. inherit)

	if(inherit == _user)then
		_user = group
		groups['guide'].inherits = group
		ExecuteCommand('add_principal group.guide group.' .. group)
	elseif(inherit == _guide)then
		_guide = group
		groups['supporter'].inherits = group
		ExecuteCommand('add_principal group.supporter group.' .. group)
	elseif(inherit == _supporter)then
		_supporter = group
		groups['moderator'].inherits = group
		ExecuteCommand('add_principal group.moderator group.' .. group)
	elseif(inherit == _moderator)then
		_moderator = group
		groups['dev'].inherits = group
		ExecuteCommand('add_principal group.dev group.' .. group)
	elseif(inherit == _dev)then
		_dev = group
		groups['administrator'].inherits = group
		ExecuteCommand('add_principal group.administrator group.' .. group)
	elseif(inherit == _administrator)then
		_administrator = group
		groups['headadmin'].inherits = group
		ExecuteCommand('add_principal group.headadmin group.' .. group)
	elseif(inherit == _headadmin)then
		_headadmin = group
		groups['manager'].inherits = group
		ExecuteCommand('add_principal group.manager group.' .. group)
	elseif(inherit == _manager)then
		_manager = group
		groups['TinyLara'].inherits = group
		ExecuteCommand('add_principal group.TinyLara group.' .. group)
	elseif(inherit == _TinyLara)then
		_TinyLara = group
		groups['projektleitung'].inherits = group
		ExecuteCommand('add_principal group.projektleitung group.' .. group)
	end

	Group(group, inherit, aceGroup)
end)

-- Can target function, mainly for exports
function canGroupTarget(group, targetGroup, cb)
	if groups[group] and groups[targetGroup] then
		if cb then
			cb(groups[group]:canTarget(targetGroup))
		else
			return groups[group]:canTarget(targetGroup)
		end
	else
		if cb then
			cb(false)
		else
			return false
		end
	end
end

-- Can target event handler
AddEventHandler("es:canGroupTarget", function(group, targetGroup, cb)
	canGroupTarget(group, targetGroup, cb)
end)

-- Get all groups
AddEventHandler("es:getAllGroups", function(cb)
	cb(groups)
end)