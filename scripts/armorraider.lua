include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, flWheel, frWheel, rrTrack, rlTrack =
	piece('base', 'flWheel', 'frWheel', 'rrTrack', 'rlTrack')

local turret, aimfrom, sleeveTop, sleeveBottom =
	piece('turret', 'aimfrom', 'sleeveTop', 'sleeveBottom')

local flareTop, flareBottom =
	piece('flareTop', 'flareBottom')

local barrelTop, barrelBottom =
	piece('barrelTop', 'barrelBottom')

local flTyre, frTyre =
	piece('flTyre', 'frTyre')

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local SIG_MOVE = 2
local SIG_AIM  = 4
local SIG_FIRE = 8

local RESTORE_DELAY = 2000

local TURRET_SPEED = math.rad(400)
local SLEEVE_SPEED = math.rad(400)

local TYRE_SPIN_SPEED = math.rad(720)
local TYRE_ACCEL      = math.rad(240)
local TYRE_DECEL      = math.rad(360)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local whichGun = 1
local stunned = false
local oldHeading = 0

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {
	base,
	turret,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

	Hide(flareTop)
	Hide(flareBottom)

	oldHeading = Spring.GetUnitHeading(unitID) or 0

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
end

--------------------------------------------------------------------------------
-- STEERING
--------------------------------------------------------------------------------
local function SteeringThread()

	Signal(SIG_MOVE)
	SetSignalMask(SIG_MOVE)

	while true do

		local heading = Spring.GetUnitHeading(unitID) or 0
		local steer = (heading - oldHeading) * 0.0006

		Turn(flWheel, y_axis, steer, math.rad(180))
		Turn(frWheel, y_axis, steer, math.rad(180))

		oldHeading = heading

		Sleep(66)
	end
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()

	StartThread(SteeringThread)

	Spin(flTyre, x_axis, TYRE_SPIN_SPEED, TYRE_ACCEL)
	Spin(frTyre, x_axis, TYRE_SPIN_SPEED, TYRE_ACCEL)
end

function script.StopMoving()

	Signal(SIG_MOVE)

	StopSpin(flTyre, x_axis, TYRE_DECEL)
	StopSpin(frTyre, x_axis, TYRE_DECEL)

	Turn(flWheel, y_axis, 0, math.rad(180))
	Turn(frWheel, y_axis, 0, math.rad(180))
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function ExecuteRestoreAfterDelay()

	if stunned then
		return
	end

	whichGun = 1

	Turn(turret, y_axis, 0, math.rad(90))

	Turn(sleeveTop, x_axis, 0, math.rad(50))
	Turn(sleeveBottom, x_axis, 0, math.rad(50))
end

local function RestoreAfterDelay()

	Sleep(RESTORE_DELAY)

	StartThread(ExecuteRestoreAfterDelay)
end

--------------------------------------------------------------------------------
-- STUNNED
--------------------------------------------------------------------------------
function script.setStunned(state)

	stunned = state

	if not stunned then
		StartThread(ExecuteRestoreAfterDelay)
	end
end

--------------------------------------------------------------------------------
-- WEAPON
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
	return aimfrom
end

local whichGun = 1

function script.QueryWeapon(num)

    if whichGun == 1 then
        whichGun = 2
        return flareTop
    else
        whichGun = 1
        return flareBottom
    end
end

function script.AimWeapon(num, heading, pitch)

	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)

	Turn(turret, y_axis, heading, TURRET_SPEED)

	Turn(sleeveTop, x_axis, -pitch, SLEEVE_SPEED)
	Turn(sleeveBottom, x_axis, -pitch, SLEEVE_SPEED)

	WaitForTurn(turret, y_axis)
	WaitForTurn(sleeveBottom, x_axis)

	StartThread(RestoreAfterDelay)

	return true
end


function script.FireWeapon(num)

    Move(barrelTop, z_axis, -5)
    Move(barrelTop, z_axis, 0, 10)

    Sleep(300)

    Move(barrelBottom, z_axis, -5)
    Move(barrelBottom, z_axis, 0, 10)
end


--------------------------------------------------------------------------------
-- SWEET SPOT
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
	return aimfrom
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

	local severity = (recentDamage / maxHealth) * 100

	if severity <= 25 then

		Explode(base, SFX.NONE)

		Explode(turret, SFX.NONE)

		Explode(frWheel,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(flWheel,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(rrTrack, SFX.NONE)
		Explode(rlTrack, SFX.NONE)

		return 1
	end

	if severity <= 50 then

		Explode(base, SFX.NONE)

		Explode(turret,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(frWheel,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(flWheel,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(rrTrack,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(rlTrack,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		return 2
	end

	if severity <= 99 then

		Explode(base,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(turret,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(frWheel,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(flWheel,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(rrTrack,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(rlTrack,
			SFX.EXPLODE +
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		return 3
	end

	Explode(base,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.SMOKE +
		SFX.FALL
	)

	Explode(turret,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.SMOKE +
		SFX.FALL
	)

	Explode(frWheel,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.SMOKE +
		SFX.FALL
	)

	Explode(flWheel,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.SMOKE +
		SFX.FALL
	)

	Explode(rrTrack,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.FALL
	)

	Explode(rlTrack,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.FALL
	)

	return 3
end