include "constants.lua"

local chassis = piece 'chassis'
local mainEngine = piece 'mainEngine'
local mainThrust = piece 'mainThrust'

local smallEngineA = piece 'smallEngineA'
local thrustA = piece 'thrustA'

local smallEngineB = piece 'smallEngineB'
local thrustB = piece 'thrustB'

local nanoStrut = piece 'nanoStrut'
local nano = piece 'nano'
local beam = piece 'beam'


local nanoPieces = {beam}

local SIG_STATE = 1


------------------------------------------------------------
-- Activation
------------------------------------------------------------

local function ActivateEngines()

	Turn(mainEngine, x_axis, 0, math.rad(60))
	Show(mainThrust)

	Turn(smallEngineA, x_axis, 0, math.rad(60))
	Show(thrustA)

	Turn(smallEngineB, x_axis, 0, math.rad(60))
	Show(thrustB)

end


local function DeactivateEngines()

	Turn(mainEngine, x_axis, math.rad(-90), math.rad(60))
	Hide(mainThrust)

	Turn(smallEngineA, x_axis, math.rad(-90), math.rad(60))
	Hide(thrustA)

	Turn(smallEngineB, x_axis, math.rad(-90), math.rad(60))
	Hide(thrustB)

end


------------------------------------------------------------
-- Create
------------------------------------------------------------

function script.Create()

	Hide(mainThrust)
	Hide(thrustA)
	Hide(thrustB)
	Hide(beam)

	Turn(mainEngine, x_axis, math.rad(-90))
	Turn(smallEngineA, x_axis, math.rad(-90))
	Turn(smallEngineB, x_axis, math.rad(-90))


	Spring.SetUnitNanoPieces(unitID, nanoPieces)


	-- Wait for construction completion
	while GetUnitValue(COB.BUILD_PERCENT_LEFT) > 0 do
		Sleep(500)
	end


	DeactivateEngines()

end



------------------------------------------------------------
-- Activation state
------------------------------------------------------------

function script.Activate()

	ActivateEngines()

end


function script.Deactivate()

	DeactivateEngines()

end



------------------------------------------------------------
-- Building animation
------------------------------------------------------------

function script.StartBuilding()

	SetUnitValue(COB.INBUILDSTANCE, 1)


	Show(beam)

	Move(nanoStrut, y_axis, -2.8, 40)

	Turn(nano, x_axis, math.rad(20), math.rad(200))


end



function script.StopBuilding()

	SetUnitValue(COB.INBUILDSTANCE, 0)


	Hide(beam)

	Turn(nano, x_axis, 0, math.rad(200))

	Move(nanoStrut, y_axis, 0, 40)


end



------------------------------------------------------------
-- Nano query
------------------------------------------------------------

function script.QueryNanoPiece()

	return beam

end



------------------------------------------------------------
-- Construction sweet spot
------------------------------------------------------------

function script.QueryBuildInfo()

	return chassis

end



------------------------------------------------------------
-- Death
------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth

	Explode(chassis, SFX.SHATTER)
	Explode(nanoStrut, SFX.FALL)
	Explode(beam, SFX.FALL)
	Explode(nano, SFX.FALL)
	Explode(mainThrust, SFX.FALL)

	if severity > 0.5 then

		Explode(mainEngine, SFX.FIRE + SFX.SMOKE + SFX.FALL + SFX.EXPLODE_ON_HIT)
		Explode(smallEngineA, SFX.FIRE + SFX.SMOKE + SFX.FALL + SFX.EXPLODE_ON_HIT)
		Explode(smallEngineB, SFX.FIRE + SFX.SMOKE + SFX.FALL + SFX.EXPLODE_ON_HIT)

		return 2

	else

		Explode(mainEngine, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(smallEngineA, SFX.FALL)
		Explode(smallEngineB, SFX.FALL)

		return 1

	end

end

