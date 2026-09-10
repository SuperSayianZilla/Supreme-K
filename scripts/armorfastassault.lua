include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, armor, aimy1, turret, aimx1, sleeve, barrel, flare =
	piece('base', 'armor', 'aimy1', 'turret', 'aimx1', 'sleeve', 'barrel', 'flare')

local wheelfl, wheelfr, wheelml, wheelmr, wheelbl, wheelbr =
	piece('wheelfl', 'wheelfr', 'wheelml', 'wheelmr', 'wheelbl', 'wheelbr')

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2

local TURRET_TURN_SPEED = math.rad(250)
local GUN_TURN_SPEED    = math.rad(240)

local WHEEL_SPIN_SPEED  = math.rad(900)
local WHEEL_ACCEL       = math.rad(240)
local WHEEL_DECEL       = math.rad(360)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local restoreDelay = 3000
local oldHeading = 0
local lastPrimaryHeading = -1000000
local stunned = false

--------------------------------------------------------------------------------
-- TABLES
--------------------------------------------------------------------------------
local wheels = {
	wheelfl, wheelfr,
	wheelml, wheelmr,
	wheelbl, wheelbr,
}

local smokePiece = {
	base,
	turret,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

	Hide(flare)

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
		local steer = (heading - oldHeading) * 0.0004

		Turn(wheelfl, y_axis,  steer, math.rad(120))
		Turn(wheelfr, y_axis,  steer, math.rad(120))

		Turn(wheelbl, y_axis, -steer, math.rad(120))
		Turn(wheelbr, y_axis, -steer, math.rad(120))

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
		Spin(wheels[i], x_axis, WHEEL_SPIN_SPEED, WHEEL_ACCEL)
	end
end

function script.StopMoving()

	Signal(SIG_MOVE)

	for i = 1, #wheels do
		StopSpin(wheels[i], x_axis, WHEEL_DECEL)
	end

	Turn(wheelfl, y_axis, 0, math.rad(120))
	Turn(wheelfr, y_axis, 0, math.rad(120))
	Turn(wheelbl, y_axis, 0, math.rad(120))
	Turn(wheelbr, y_axis, 0, math.rad(120))
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function ExecuteRestoreAfterDelay()

	if stunned then
		return
	end

	lastPrimaryHeading = -1000000

	Turn(aimy1, y_axis, 0, math.rad(90))
	Turn(aimx1, x_axis, 0, math.rad(50))
end

local function RestoreAfterDelay()

	Sleep(restoreDelay)

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
	return aimx1
end

function script.QueryWeapon(num)
	return flare
end

function script.BlockShot(num, targetID)
	return false
end

function script.AimWeapon(num, heading, pitch)

	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)

	Turn(aimy1, y_axis, heading, TURRET_TURN_SPEED)
	Turn(aimx1, x_axis, -pitch, GUN_TURN_SPEED)

	if math.abs(lastPrimaryHeading - heading) > math.rad(20) then
		WaitForTurn(aimy1, y_axis)
		WaitForTurn(aimx1, x_axis)
	end

	lastPrimaryHeading = heading

	StartThread(RestoreAfterDelay)

	return true
end

function script.Shot(num)

	EmitSfx(flare, 1024)

	Move(barrel, z_axis, -1.5)
	Move(barrel, z_axis, 0, 3)
end

--------------------------------------------------------------------------------
-- SWEET SPOT
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
	return aimx1
end

function script.QueryWeapon1()
	return flare
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

	local severity = (recentDamage / maxHealth) * 100

	if severity <= 25 then

		Explode(base, SFX.NONE)
		Explode(turret, SFX.NONE)
		Explode(armor, SFX.NONE)

		return 1
	end

	if severity <= 50 then

		Explode(base, SFX.NONE)

		Explode(turret,
			SFX.FIRE +
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(armor,
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
			SFX.SMOKE +
			SFX.FALL
		)

		Explode(armor,
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

	Explode(armor,
		SFX.EXPLODE +
		SFX.FIRE +
		SFX.FALL
	)

	return 3
end