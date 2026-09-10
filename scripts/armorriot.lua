include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, armor, turret, sleeve =
	piece('base', 'armor', 'turret', 'sleeve')

local lbarrel, rbarrel =
	piece('lbarrel', 'rbarrel')

local lflare, rflare =
	piece('lflare', 'rflare')

local wheelfl, wheelfr, wheelml, wheelmr, wheelbl, wheelbr =
	piece('wheelfl', 'wheelfr', 'wheelml', 'wheelmr', 'wheelbl', 'wheelbr')

local radar =
	piece('radar')

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM1 = 2

local TURRET_SPEED = math.rad(240)
local SLEEVE_SPEED = math.rad(120)

local WHEEL_SPEED = math.rad(900)
local WHEEL_ACCEL = math.rad(240)
local WHEEL_DECEL = math.rad(360)

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local restoreDelay = 6000
local oldHeading = 0
local gunSwitch = 0
local stunned = false

local barrelSpinSpeed = 0

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
	armor,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

	Hide(lflare)
	Hide(rflare)

	oldHeading = Spring.GetUnitHeading(unitID) or 0

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Turn(radar, x_axis, -math.rad(45), math.rad(25))
	Spin(radar, z_axis, math.rad(60))

	StartThread(BarrelSpinThread)
	StartThread(ExecuteRestoreAfterDelay)
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
		Spin(wheels[i], x_axis, WHEEL_SPEED, WHEEL_ACCEL)
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
-- IDLE / RESTORE
--------------------------------------------------------------------------------
function ExecuteRestoreAfterDelay()

	if stunned then
		return
	end

	Turn(sleeve, x_axis, -math.rad(30), math.rad(25))

	Spin(turret, y_axis, math.rad(25))

	Sleep(restoreDelay)

	StopSpin(turret, y_axis)

	Turn(turret, y_axis, 0, math.rad(45))
end

local function RestoreAfterDelay()

	Sleep(restoreDelay)

	StartThread(ExecuteRestoreAfterDelay)
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.setStunned(state)

	stunned = state

	if not stunned then
		StartThread(ExecuteRestoreAfterDelay)
	end
end

--------------------------------------------------------------------------------
-- BARREL SPIN
--------------------------------------------------------------------------------
function BarrelSpinThread()

	while true do

		if barrelSpinSpeed > 0 then

			Spin(lbarrel, z_axis, -barrelSpinSpeed)
			Spin(rbarrel, z_axis,  barrelSpinSpeed)

			barrelSpinSpeed = barrelSpinSpeed * 0.94

			if barrelSpinSpeed < math.rad(50) then

				barrelSpinSpeed = 0

				StopSpin(lbarrel, z_axis, math.rad(25))
				StopSpin(rbarrel, z_axis, math.rad(25))
			end
		end

		Sleep(33)
	end
end

--------------------------------------------------------------------------------
-- WEAPON
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)
	return turret
end

function script.QueryWeapon(num)

	if gunSwitch == 0 then
		return lflare
	end

	return rflare
end

function script.AimWeapon(num, heading, pitch)

	Signal(SIG_AIM1)
	SetSignalMask(SIG_AIM1)

	StopSpin(turret, y_axis)

	Turn(turret, y_axis, heading, TURRET_SPEED)
	Turn(sleeve, x_axis, -pitch, SLEEVE_SPEED)

	WaitForTurn(turret, y_axis)
	WaitForTurn(sleeve, x_axis)

	return true
end

--------------------------------------------------------------------------------
-- SHOT
--------------------------------------------------------------------------------
function script.Shot(num)

	barrelSpinSpeed = math.rad(2000)

	if gunSwitch == 0 then

		EmitSfx(lflare, 1024)

		gunSwitch = 1

	else

		EmitSfx(rflare, 1024)

		gunSwitch = 0
	end

	StartThread(RestoreAfterDelay)
end
--------------------------------------------------------------------------------
-- SHOT
--------------------------------------------------------------------------------
function script.Shot(num)

	barrelSpinSpeed = math.rad(2000)

	if gunSwitch == 0 then

		EmitSfx(lflare, 1024)

		gunSwitch = 1

	else

		EmitSfx(rflare, 1024)

		gunSwitch = 0
	end

	StartThread(RestoreAfterDelay)
end

--------------------------------------------------------------------------------
-- SWEET SPOT
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
	return turret
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