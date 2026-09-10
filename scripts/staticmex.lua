local base, bottom, tamper, furnace, door_l, door_r, hinge_l, hinge_r, drill1, drill2, drill3, posts = piece ('base', 'bottom', 'tamper', 'furnace', 'door_l', 'door_r', 'hinge_l', 'hinge_r', 'drill1', 'drill2', 'drill3', 'posts')

include "pieceControl.lua"
include "constants.lua"

local SIG_OPEN = 1

local smokePiece = {tamper}

local metalmult = tonumber(Spring.GetModOptions().metalmult) or 1
local metalmultInv = metalmult > 0 and (1/metalmult) or 1

--------------------------------------------------------------------------------
-- PROGRESSIVE METAL GENERATION
--------------------------------------------------------------------------------

local metalMultiplier = 1.0

-- How much the mex gains each interval.
local METAL_INCREASE = 0.05

-- How often it increases.
-- 30 seconds
local METAL_INCREASE_TIME = 30000

-- Maximum multiplier.
local MAX_METAL_MULTIPLIER = 2.0


local function IncreaseMetal()
    while true do

        Sleep(METAL_INCREASE_TIME)

        metalMultiplier = metalMultiplier + METAL_INCREASE

        if MAX_METAL_MULTIPLIER and metalMultiplier > MAX_METAL_MULTIPLIER then
            metalMultiplier = MAX_METAL_MULTIPLIER
        end

        Spring.SetUnitRulesParam(
            unitID,
            "metalGenerationFactor",
            metalMultiplier
        )
    end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function Open()
	Signal(SIG_OPEN)
	SetSignalMask(SIG_OPEN)
	
	Turn (hinge_r, z_axis, math.rad(-120), math.rad(120))
	Turn (hinge_l, z_axis, math.rad(120), math.rad(120))
	WaitForTurn (hinge_l, z_axis)
	Move (tamper, y_axis, 15, 10)
	WaitForMove (tamper, y_axis)

	local height = 40

	while true do
		local income = Spring.GetUnitRulesParam(unitID, "current_metalIncome") or 0
		income = income * metalmultInv
		if income > 0 then
			Spin (furnace, y_axis, income, math.rad(1))
			Spin (drill1, y_axis, income, math.rad(1))
			Move (tamper, y_axis, height, income*10)
			WaitForMove (tamper, y_axis)
			height = 60 - height
		else
			StopSpin (furnace, y_axis, math.rad(5))
			StopSpin (drill1, y_axis, math.rad(5))
			Sleep (200)
		end
	end
end

function script.Activate()
	StartThread(Open)
end

function script.Create()

	StartThread(
		GG.Script.SmokeUnit,
		unitID,
		smokePiece
	)

	-- Start progressive metal generation.
	StartThread(IncreaseMetal)

	if not Spring.GetUnitIsStunned(unitID) then
		StartThread(Open)
	end
end

local explodables = {door_l, furnace}

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage/maxHealth

	for i = 1, #explodables do
		if (math.random() < severity*1.5) then
			Explode (explodables[i], SFX.FALL + SFX.SMOKE)
		end
	end
	if severity < 0.5 then
		return 1
	else
		Explode (door_r, SFX.FALL + SFX.SMOKE)
		Explode (bottom, SFX.SHATTER)
		return 2
	end
end