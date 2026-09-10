if not gadgetHandler:IsSyncedCode() then return end

function gadget:GetInfo()
	return {
		name = "Overheat Weapons",
		desc = "Makes weapons overheat, slowing their reloadtime based on Weapon Custom params",
		author = "Stiofan", -- but also pilfered from Stardust
		date = "1 March 2026",
		license  = "GNU GPL, v2 or later",
		layer = -1,
		enabled = true
	}
end

--[[
--TODO
-- Feels insanely inefficent. checking all weapons fired for overheat feels quite wastefull


-- Theres a few possible ways to go about it. I could do it per unit or per weapon.
-- Per weapon allows for overheat to only affect certain weapons of a unit
-- Per unit makes it easier to read and understand from a player perpective
--> per unit, and allow a weapon custom param to exclude a weapon from it?
--> we are more likely to have only 1 weapon per unit anyways :o

--> so for now, lets define via unitdefs, and allow a weapon to possibly exclude itself?

--> It's done! Though I can only detect a weapon firing not necessarily a shot per burst.
]]

local LOS_ACCESS = {inlos = true}

-- {heat , heatdefID}
local unitHeat 		= {}
local unitHeatDef 	= {}


-- Defaults taken from Stardust
local	default_heat_per_shot  = 0.1 -- Heat is always a number between 0 and 1
local	default_heat_decay     = 1/6 -- 0.16 per second?
local 	default_heat_max_slow  = 0.5
local	default_heat_initial   = 1



local overheatUnits = {}
for i = 1,#UnitDefs do
	local ucp = UnitDefs[i].customParams
	if ucp and ucp.heat_per_shot then
		overheatUnits[i] = {
			heatPerShot = 	tonumber(ucp.heat_per_shot) or default_heat_per_shot,
			heatDecay = 	tonumber(ucp.heat_decay)/Game.gameSpeed 	or default_heat_decay/Game.gameSpeed,
			heatMaxSlow = 	tonumber(ucp.heat_max_slow)	or default_heat_max_slow,	
			heatInital = 	tonumber(ucp.heat_initial)	or default_heat_initial,
			heatWaterCoolMult= tonumber(ucp.heat_water_cool_mult) or false, 			
		}
	end
end


local function UpdateReloadTime(unitID, currentHeat, heatMaxSlow)
	local reloadMult = 1 - currentHeat * heatMaxSlow
	Spring.SetUnitRulesParam(unitID, "selfReloadSpeedChange", reloadMult, LOS_ACCESS)
	Spring.SetUnitRulesParam(unitID, "heat_bar", currentHeat, LOS_ACCESS)
	GG.UpdateUnitAttributes(unitID)
end

local function HeatDecayFunction(unitID,currentHeat,overheatDef)
		local heatDecay = overheatDef.heatDecay
		local heatWaterCoolMult = overheatDef.heatWaterCoolMult
		local heatMaxSlow = overheatDef.heatMaxSlow
		
		local stunned_or_inbuild = Spring.GetUnitIsStunned(unitID) -- Hm should cooling be tied to being stunned?
		if not stunned_or_inbuild then
			local decayMult = (GG.att_EconomyChange[unitID] or 1) -- unsure what this does? so leaving decay mult as is too
			if decayMult > 0 then
				local x,y,z = Spring.GetUnitPosition(unitID)
				if heatWaterCoolMult and y < -5  then
					--Spring.Echo("We are getting watercooling!")
					currentHeat = currentHeat - heatWaterCoolMult*heatDecay*decayMult
				else
					currentHeat = currentHeat - heatDecay*decayMult
				end
				if currentHeat <= 0 then
					currentHeat = 0
				end
			end
		end
		UpdateReloadTime(unitID, currentHeat, heatMaxSlow)
		unitHeat[unitID] = currentHeat
end

local function AddHeat (unitID,currentHeat,overheatDef)
	local heatMaxSlow = overheatDef.heatMaxSlow
	local heatPerShot = overheatDef.heatPerShot
	
	currentHeat = currentHeat + heatPerShot
	if currentHeat > 1 then
		currentHeat = 1
	end
	UpdateReloadTime(unitID, currentHeat, heatMaxSlow)
	unitHeat[unitID] = currentHeat
end

-- Set innital heat
function gadget:UnitCreated(unitID, unitDefID)
	
	local thisUnitOverheatDef = overheatUnits[unitDefID]

	if not thisUnitOverheatDef then
		return
	end
	UpdateReloadTime(unitID, thisUnitOverheatDef.heatInital, thisUnitOverheatDef.heatMaxSlow)
	
	
	unitHeat[unitID] = thisUnitOverheatDef.heatInital
	unitHeatDef[unitID] = thisUnitOverheatDef
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam)
	if unitHeat[unitID] then
		unitHeat[unitID] = nil
		unitHeatDef[unitID] = nil
	end
end


function gadget:ScriptFireWeapon(unitID, unitDefID, weaponNum)
	local thisOverheatUnit = unitHeat[unitID]
	if not thisOverheatUnit then
		return
	end
	AddHeat(unitID,unitHeat[unitID],unitHeatDef[unitID])
end

-- process heat decay
function gadget:GameFrame(gameFrame)
		for unitID,currentHeat in pairs(unitHeat) do

			overheatDef = unitHeatDef[unitID]
			if currentHeat > 0 then
				HeatDecayFunction(unitID,currentHeat,overheatDef)
			end
			--[[
			Spring.Echo("unitID")
			Spring.Echo(unitID)
			Spring.Echo("overheatDef")
			Spring.Echo(overheatDef)
			Spring.Echo("currentHeat")
			Spring.Echo(currentHeat)
			]]
		end
end

function gadget:Initialize()
	Spring.Echo("Gadget works!")
end