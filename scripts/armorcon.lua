include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, mlwheel, mrwheel, blwheel, brwheel, flwheel, frwheel =
	piece('base', 'mlwheel', 'mrwheel', 'blwheel', 'brwheel', 'flwheel', 'frwheel')

local arml, armr, lpanel, rpanel, solar =
	piece('arml', 'armr', 'lpanel', 'rpanel', 'solar')

local cylinderdeco, loturret, upturret, nano, beam =
	piece('cylinderdeco', 'loturret', 'upturret', 'nano', 'beam')

local cagelight, cagelight_emit =
	piece('cagelight', 'cagelight_emit')

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local SIG_MOVE  = 1
local SIG_BUILD = 2

local wheels = {
	flwheel, frwheel,
	mlwheel, mrwheel,
	blwheel, brwheel,
}

local WHEEL_TURN_SPEED = math.rad(720)
local WHEEL_ACCEL      = math.rad(180)
local WHEEL_DECEL      = math.rad(300)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local readyToBuild = false
local oldHeading = 0

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {
	base,
	upturret,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

	Hide(cagelight_emit)

	oldHeading = Spring.GetUnitHeading(unitID) or 0

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Spring.SetUnitNanoPieces(unitID, {beam})

	Spin(cylinderdeco, x_axis, math.rad(30))

	SetUnitValue(COB.INBUILDSTANCE, 0)
end

--------------------------------------------------------------------------------
-- STEERING / WHEELS
--------------------------------------------------------------------------------
local function SteeringThread()

	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)

	while true do

		local heading = Spring.GetUnitHeading(unitID) or 0
		local steer = (heading - oldHeading) * 0.0008

		Turn(flwheel, y_axis,  steer, math.rad(120))
		Turn(frwheel, y_axis,  steer, math.rad(120))

		Turn(blwheel, y_axis, -steer, math.rad(120))
		Turn(brwheel, y_axis, -steer, math.rad(120))

		oldHeading = heading

		Sleep(66)
	end
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()

	StartThread(SteeringThread)

	for i = 1, #wheels do
		Spin(wheels[i], x_axis, WHEEL_TURN_SPEED, WHEEL_ACCEL)
	end
end

function script.StopMoving()

	Signal(SIG_MOVE)

	for i = 1, #wheels do
		StopSpin(wheels[i], x_axis, WHEEL_DECEL)
	end

	Turn(flwheel, y_axis, 0, math.rad(120))
	Turn(frwheel, y_axis, 0, math.rad(120))
	Turn(blwheel, y_axis, 0, math.rad(120))
	Turn(brwheel, y_axis, 0, math.rad(120))
end

--------------------------------------------------------------------------------
-- BUILDING
--------------------------------------------------------------------------------
function script.StartBuilding(heading, pitch)

	Signal(SIG_BUILD)
	SetSignalMask(SIG_BUILD)

	if not readyToBuild then

		Turn(arml, z_axis,  math.rad(30),  math.rad(180))
		Turn(armr, z_axis, -math.rad(30),  math.rad(180))

        Turn(lpanel, z_axis,  math.rad(20), math.rad(120))
        Turn(rpanel, z_axis, -math.rad(20), math.rad(120))

		Turn(solar, x_axis, -math.rad(25), math.rad(50))

		Sleep(100)

		Move(loturret, y_axis, 4, 12)
		Move(upturret, y_axis, 4, 12)

		WaitForMove(loturret, y_axis)

		Move(nano, z_axis, 3, 12)
		Move(cagelight, y_axis, 2, 12)

		Move(loturret, y_axis, 4, 12)
		Move(upturret, y_axis, 5, 12)

		readyToBuild = true
	end

	Turn(upturret, y_axis, heading, math.rad(160))
	WaitForTurn(upturret, y_axis)

	SetUnitValue(COB.INBUILDSTANCE, 1)

	Show(cagelight_emit)

	Spin(cagelight_emit, y_axis, math.rad(250))
	Spin(cylinderdeco, x_axis, math.rad(240), math.rad(10))

	readyToBuild = true
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function RestoreAfterDelay()

	Signal(SIG_BUILD)
	SetSignalMask(SIG_BUILD)

	Hide(cagelight_emit)

	Turn(cagelight, y_axis, 0, math.rad(1000))

	Spin(cylinderdeco, x_axis, math.rad(30), math.rad(10))

	Sleep(6000)

	SetUnitValue(COB.INBUILDSTANCE, 0)

	Hide(cagelight_emit)

	Turn(cagelight_emit, y_axis, 0, math.rad(1000))

	Turn(upturret, y_axis, 0, math.rad(160))
	WaitForTurn(upturret, y_axis)

	Move(loturret, y_axis, 0, 12)
	Move(upturret, y_axis, 0, 12)

	Move(nano, z_axis, 0, 12)
	Move(cagelight, y_axis, 0, 12)

	Sleep(200)

	Turn(arml, z_axis, 0, math.rad(180))
	Turn(armr, z_axis, 0, math.rad(180))

	Turn(lpanel, z_axis, 0, math.rad(120))
	Turn(rpanel, z_axis, 0, math.rad(120))

	Turn(solar, x_axis, 0, math.rad(50))

	readyToBuild = false
end

function script.StopBuilding()

	StartThread(RestoreAfterDelay)
end

--------------------------------------------------------------------------------
-- NANO PIECE
--------------------------------------------------------------------------------
function script.QueryNanoPiece()
	return beam
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

	local severity = (recentDamage / maxHealth) * 100

	if severity <= 25 then

		Explode(base, SFX.NONE)
		Explode(solar, SFX.FALL + SFX.SMOKE + SFX.FIRE)
		Explode(lpanel, SFX.NONE)
		Explode(rpanel, SFX.NONE)
		Explode(flwheel, SFX.NONE)

		return 1
	end

	if severity <= 50 then

		Explode(base, SFX.NONE)
		Explode(solar, SFX.FALL + SFX.SMOKE + SFX.FIRE)

		Explode(lpanel, SFX.FALL)
		Explode(rpanel, SFX.FALL)

		Explode(flwheel, SFX.FALL + SFX.SMOKE + SFX.FIRE)

		return 2
	end

	if severity <= 99 then

		Explode(base, SFX.NONE)

		Explode(solar,
			SFX.EXPLODE +
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE
		)

		Explode(lpanel,
			SFX.EXPLODE +
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE
		)

		Explode(rpanel,
			SFX.EXPLODE +
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE
		)

		Explode(flwheel,
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE
		)

		return 3
	end

	Explode(base, SFX.NONE)

	Explode(solar,
		SFX.EXPLODE +
		SFX.FALL +
		SFX.SMOKE +
		SFX.FIRE
	)

	Explode(flwheel,
		SFX.EXPLODE +
		SFX.FALL +
		SFX.SMOKE +
		SFX.FIRE
	)

	Explode(lpanel,
		SFX.EXPLODE +
		SFX.FALL +
		SFX.FIRE
	)

	Explode(rpanel,
		SFX.EXPLODE +
		SFX.FALL +
		SFX.FIRE
	)

	return 3
end