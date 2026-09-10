include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local body = piece('body')

local frFan = piece('frFan')
local rear_engine_casing = piece('rear_engine_casing')
local rear_engine = piece('rear_engine')

local turret = piece('turret')
local turret_body = piece('turret_body')

local vertical_ring = piece('vertical_ring')

local flFan = piece('flFan')
local brFan = piece('brFan')
local blFan = piece('blFan')

local frFanPivot = piece('frFanPivot')
local brFanPivot = piece('brFanPivot')
local flFanPivot = piece('flFanPivot')
local blFanPivot = piece('blFanPivot')

local rocketFlareR = piece('rocketFlareR')
local rocketFlareL = piece('rocketFlareL')

local heatFlare = piece('heatFlare')

local tlTurretHeadingPivot = piece('tlTurretHeadingPivot')
local tlTurretPitchPivot = piece('tlTurretPitchPivot')
local tlTurret = piece('tlTurret')
local tlFlare = piece('tlFlare')

local wake = piece('wake')
local airjetFlare = piece('airjetFlare')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_AIM1 = 1
local SIG_AIM2 = 2
local SIG_RESTORE = 4
local SIG_HEAT = 8

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

local RESTORE_DELAY = 3000

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------

local firingHeat = false
local oldHeading = 0

--------------------------------------------------------------------------------
-- HOVER WOBBLE
--------------------------------------------------------------------------------

local function WobbleUnit()
	while true do
		Move(body, y_axis, 0.8, 1.2)
		Sleep(750)

		Move(body, y_axis, -0.8, 1.2)
		Sleep(750)
	end
end

--------------------------------------------------------------------------------
-- WAKE FX
--------------------------------------------------------------------------------

local sfxNum = 0

function script.setSFXoccupy(num)
	sfxNum = num
end

local function MoveScript()

	while Spring.GetUnitIsStunned(unitID) do
		Sleep(2000)
	end

	while true do

		if not Spring.GetUnitIsCloaked(unitID) then

			if (sfxNum == 1 or sfxNum == 2)
				and select(2, Spring.GetUnitPosition(unitID)) == 0
			then
				EmitSfx(wake, 3)
			else
				EmitSfx(wake, 1024)
			end
		end

		Sleep(150)
	end
end

--------------------------------------------------------------------------------
-- STEERING
--------------------------------------------------------------------------------

local function SteeringThread()

	local oldSteerHeading = Spring.GetUnitHeading(unitID)

	while true do

		local heading = Spring.GetUnitHeading(unitID)

		local steer = (heading - oldSteerHeading) * 4

		Turn(rear_engine, y_axis, math.rad(-steer * 3), math.rad(120))

		local x, _, z = Spring.GetUnitPosition(unitID)
		local waterDepth = Spring.GetGroundHeight(x, z)

		if waterDepth <= 0 then
			Move(tlTurretHeadingPivot, y_axis, -8, 8)
		else
			Move(tlTurretHeadingPivot, y_axis, 0, 8)
		end

		oldSteerHeading = heading

		Sleep(33)
	end
end

--------------------------------------------------------------------------------
-- HEAT EFFECT
--------------------------------------------------------------------------------

local function HeatEffectThread()

	Signal(SIG_HEAT)
	SetSignalMask(SIG_HEAT)

	while firingHeat do
		EmitSfx(heatFlare, GG.Script.UNIT_SFX2)
		Sleep(20)
	end
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------

local function RestoreMainTurret()

	Signal(SIG_RESTORE)
	SetSignalMask(SIG_RESTORE)

	Sleep(RESTORE_DELAY)

	Turn(turret, y_axis, 0, math.rad(80))
	Turn(turret_body, x_axis, 0, math.rad(50))
end

local function RestoreTorpedoTurret()

	Sleep(RESTORE_DELAY)

	Turn(tlTurretHeadingPivot, y_axis, 0, math.rad(20))
	Turn(tlTurretPitchPivot, x_axis, 0, math.rad(20))
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()

	Turn(flFanPivot, x_axis, math.rad(5.5))
	Turn(blFanPivot, x_axis, math.rad(13))
	Turn(frFanPivot, x_axis, math.rad(5.5))
	Turn(brFanPivot, x_axis, math.rad(13))

	Turn(flFanPivot, z_axis, math.rad(13.5))
	Turn(blFanPivot, z_axis, math.rad(10.2))
	Turn(frFanPivot, z_axis, math.rad(-13.5))
	Turn(brFanPivot, z_axis, math.rad(-10.2))

	Turn(blFanPivot, y_axis, math.rad(47))
	Turn(brFanPivot, y_axis, math.rad(-47))

	Turn(rocketFlareL, x_axis, math.rad(-30))
	Turn(rocketFlareR, x_axis, math.rad(-30))

	Turn(rocketFlareL, z_axis, math.rad(12))
	Turn(rocketFlareR, z_axis, math.rad(-12))

	Turn(rear_engine_casing, x_axis, math.rad(-90))

	Hide(airjetFlare)

	Spin(frFan, y_axis, math.rad(300))
	Spin(flFan, y_axis, math.rad(-300))
	Spin(brFan, y_axis, math.rad(300))
	Spin(blFan, y_axis, math.rad(-300))

	Spin(vertical_ring, x_axis, math.rad(100))

	StartThread(GG.Script.SmokeUnit, unitID, {body})
	StartThread(WobbleUnit)
	StartThread(MoveScript)
	StartThread(SteeringThread)
end

--------------------------------------------------------------------------------
-- WEAPON 1 (HEATRAY)
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)
	if num == 1 then
		return turret_body
	elseif num == 2 then
		return tlTurret
	end

	return turret_body
end

function script.QueryWeapon(num)

	if num == 1 then
		return heatFlare
	elseif num == 2 then
		return tlFlare
	elseif num == 3 then
		return rocketFlareR
	elseif num == 4 then
		return rocketFlareL
	end
end

function script.AimWeapon(num, heading, pitch)

	if num == 1 then

		Signal(SIG_AIM1)
		SetSignalMask(SIG_AIM1)

		oldHeading = heading

		Turn(turret, y_axis, heading, math.rad(100))
		Turn(turret_body, x_axis, -pitch, math.rad(100))

		WaitForTurn(turret, y_axis)
		WaitForTurn(turret_body, x_axis)

		StartThread(RestoreMainTurret)

		return true
	end

	if num == 2 then

		Signal(SIG_AIM2)
		SetSignalMask(SIG_AIM2)

		Turn(tlTurretHeadingPivot, y_axis, heading, math.rad(120))
		Turn(tlTurretPitchPivot, x_axis, -pitch, math.rad(120))

		WaitForTurn(tlTurretHeadingPivot, y_axis)

		StartThread(RestoreTorpedoTurret)

		return true
	end

	return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------

function script.FireWeapon(num)

	if num == 1 then
		firingHeat = true
		StartThread(HeatEffectThread)
	end

	if num == 2 then
		EmitSfx(tlFlare, GG.Script.UNIT_SFX3)
	end
end

function script.EndBurst(num)

	if num == 1 then
		firingHeat = false
	end
end

function script.Shot(num)

	if num == 3 then
		EmitSfx(rocketFlareR, GG.Script.UNIT_SFX1)
	end

	if num == 4 then
		EmitSfx(rocketFlareL, GG.Script.UNIT_SFX1)
	end
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

function script.StartMoving()
	Turn(rear_engine_casing, x_axis, 0, math.rad(75))
	Show(airjetFlare)
end

function script.StopMoving()
	Turn(rear_engine_casing, x_axis, math.rad(-90), math.rad(75))
	Hide(airjetFlare)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth

	if severity <= 0.25 then

		Explode(blFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(brFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(flFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(frFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)

		return 1

	elseif severity <= 0.50 then

		Explode(blFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(brFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(flFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(frFan, SFX.FIRE + SFX.SMOKE + SFX.FALL)

		Explode(vertical_ring, SFX.SHATTER)
		Explode(turret_body, SFX.SHATTER)

		return 2

	else

		Explode(body, SFX.FIRE + SFX.SMOKE + SFX.FALL)

		Explode(vertical_ring,
			SFX.SHATTER +
			SFX.FIRE +
			SFX.SMOKE)

		Explode(turret_body,
			SFX.SHATTER +
			SFX.FIRE +
			SFX.SMOKE)

		return 3
	end
end