include "constants.lua"

local base          = piece("base")
local thruster      = piece("thruster")

local flwing        = piece("flwing")
local frwing        = piece("frwing")
local blwing        = piece("blwing")
local brwing        = piece("brwing")

local flblades      = piece("flblades")
local frblades      = piece("frblades")
local blblades      = piece("blblades")
local brblades      = piece("brblades")

local blades        = piece("blades")

local flare         = piece("flare")

local ringazimuth   = piece("ringazimuth")
local ringelevation = piece("ringelevation")

local armor         = piece("armor")
local thrusttrail   = piece("thrusttrail")

local smokePiece = {base}

local SIG_AIM = 1

local spGetUnitVelocity = Spring.GetUnitVelocity


------------------------------------------------------------
-- IDLE HOVER
------------------------------------------------------------

local function IdleHover()

	while true do

		local vx, _, vz = spGetUnitVelocity(unitID)
		local speed = vx * vx + vz * vz

		if speed < 0.5 then

			Move(base, y_axis, 1, 5)
			Sleep(500)

			Move(base, y_axis, 0, 5)
			Sleep(500)

		else

			Sleep(500)

		end

	end

end



------------------------------------------------------------
-- CREATE
------------------------------------------------------------

function script.Create()

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
	StartThread(IdleHover)

	Hide(flare)
	Hide(thrusttrail)


	-- Folded wings
	Turn(flwing, y_axis, math.rad(-30))
	Turn(frwing, y_axis, math.rad(30))
	Turn(blwing, y_axis, math.rad(30))
	Turn(brwing, y_axis, math.rad(-30))


	-- Weapon reset
	Turn(ringazimuth, y_axis, 0)
	Turn(ringelevation, x_axis, math.rad(-90))


	-- Thruster folded
	Turn(thruster, x_axis, math.rad(-90))

end



------------------------------------------------------------
-- ACTIVATE
------------------------------------------------------------

function script.Activate()


	Spin(flblades, y_axis, math.rad(600))
	Spin(frblades, y_axis, math.rad(-600))
	Spin(blblades, y_axis, math.rad(-600))
	Spin(brblades, y_axis, math.rad(600))

	Spin(blades, z_axis, math.rad(200))


	Turn(flwing, z_axis, math.rad(-15), math.rad(120))
	Turn(frwing, z_axis, math.rad(15), math.rad(120))
	Turn(blwing, z_axis, math.rad(-15), math.rad(120))
	Turn(brwing, z_axis, math.rad(15), math.rad(120))


	Move(base, y_axis, 0, 1)


	Turn(thruster, x_axis, 0, math.rad(90))


	Show(thrusttrail)

end



------------------------------------------------------------
-- DEACTIVATE
------------------------------------------------------------

function script.Deactivate()


	StopSpin(flblades, y_axis, math.rad(3))
	StopSpin(frblades, y_axis, math.rad(3))
	StopSpin(blblades, y_axis, math.rad(3))
	StopSpin(brblades, y_axis, math.rad(3))

	StopSpin(blades, z_axis, math.rad(3))


	Turn(flwing, z_axis, math.rad(45), math.rad(180))
	Turn(frwing, z_axis, math.rad(-45), math.rad(180))
	Turn(blwing, z_axis, math.rad(45), math.rad(180))
	Turn(brwing, z_axis, math.rad(-45), math.rad(180))


	Move(base, y_axis, 2, 20)


	Turn(thruster, x_axis, math.rad(-90), math.rad(90))


	Hide(thrusttrail)


	Turn(ringazimuth, y_axis, 0, math.rad(30))
	Turn(ringelevation, x_axis, math.rad(-90), math.rad(30))

end



------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------

function script.StartMoving()
end


function script.StopMoving()
end


function script.MoveRate0()

	Turn(thruster, x_axis, math.rad(-90), math.rad(180))

end


function script.MoveRate1()

	Turn(thruster, x_axis, math.rad(-45), math.rad(180))

end


function script.MoveRate2()

	Turn(thruster, x_axis, 0, math.rad(180))

end


function script.MoveRate3()

	Turn(thruster, x_axis, 0, math.rad(180))

end



------------------------------------------------------------
-- WEAPON
------------------------------------------------------------

function script.QueryWeapon(num)

	return flare

end


function script.AimFromWeapon(num)

	return base

end


function script.AimWeapon(num, heading, pitch)

	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)


	Turn(thruster, x_axis, 0, math.rad(90))


	Turn(
		ringazimuth,
		y_axis,
		heading,
		math.rad(300)
	)


	Turn(
		ringelevation,
		x_axis,
		-pitch,
		math.rad(300)
	)


	return true

end


function script.FireWeapon(num)

	EmitSfx(flare)

end



------------------------------------------------------------
-- DEATH
------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth


	if severity <= 0.25 then

		Explode(base, SFX.FALL)
		Explode(thruster, SFX.NONE)

		return 1


	elseif severity <= 0.50 then

		Explode(base, SFX.FALL)
		Explode(armor, SFX.FALL)

		Explode(flwing, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(frwing, SFX.FIRE + SFX.SMOKE + SFX.FALL)
		Explode(thruster, SFX.FIRE + SFX.SMOKE + SFX.FALL)

		return 1


	else

		Explode(base, SFX.FALL)
		Explode(armor, SFX.FALL)

		Explode(flwing, SFX.SMOKE + SFX.FALL)
		Explode(frwing, SFX.SMOKE + SFX.FALL)

		Explode(thruster, SFX.SMOKE + SFX.FALL)


		return 2

	end

end