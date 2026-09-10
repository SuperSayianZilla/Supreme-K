include "constants.lua"

local base              = piece("base")

local turretSleeves     = piece("turretSleeves")
local torpedoBarrel1    = piece("torpedoBarrel1")
local torpedoBarrel2    = piece("torpedoBarrel2")

local wingTop           = piece("wingTop")
local wingBottom        = piece("wingBottom")

local thruster2         = piece("thruster2")
local thruster2XPivot   = piece("thruster2XPivot")
local thruster1         = piece("thruster1")
local thruster1XPivot   = piece("thruster1XPivot")

local mainThrust        = piece("mainThrust")
local smallThurst1      = piece("smallThurst1")
local smallThurst2      = piece("smallThurst2")

local torpFlare1        = piece("torpFlare1")
local torpFlare2        = piece("torpFlare2")


local missileBarrel = false
local torpedoBarrel = false


local smokePiece = {base}

local spGetUnitVelocity = Spring.GetUnitVelocity



------------------------------------------------------------
-- CREATE
------------------------------------------------------------

function script.Create()

	Hide(smallThurst1)
	Hide(smallThurst2)
	Hide(mainThrust)

	Turn(smallThurst1, x_axis, math.rad(-90))
	Turn(smallThurst2, x_axis, math.rad(-90))

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
	StartThread(IdleHover)

end



------------------------------------------------------------
-- IDLE HOVER
------------------------------------------------------------

function IdleHover()

	while true do

		local vx, _, vz = spGetUnitVelocity(unitID)
		local speed = vx * vx + vz * vz

		if speed > 0.5 then

			Sleep(200)

		else

			Turn(base, x_axis, math.rad(1), math.rad(20))
			Sleep(500)

			Turn(base, x_axis, math.rad(-1), math.rad(20))
			Sleep(500)

		end

	end

end



------------------------------------------------------------
-- ACTIVATE
------------------------------------------------------------

function script.Activate()

	Show(smallThurst1)
	Show(smallThurst2)
	Show(mainThrust)

end



------------------------------------------------------------
-- DEACTIVATE
------------------------------------------------------------

function script.Deactivate()

	Hide(mainThrust)
	Hide(smallThurst1)
	Hide(smallThurst2)

end



------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------

function script.StartMoving()
end


function script.StopMoving()
end



function script.MoveRate0()

	Turn(thruster1XPivot, x_axis, 0, math.rad(150))
	Turn(thruster2XPivot, x_axis, 0, math.rad(150))

end


function script.MoveRate1()

	Turn(thruster1XPivot, x_axis, math.rad(50), math.rad(90))
	Turn(thruster2XPivot, x_axis, math.rad(50), math.rad(90))

end


function script.MoveRate2()

	Turn(thruster1XPivot, x_axis, math.rad(70), math.rad(60))
	Turn(thruster2XPivot, x_axis, math.rad(70), math.rad(60))

end


function script.MoveRate3()

	Turn(thruster1XPivot, x_axis, math.rad(90), math.rad(45))
	Turn(thruster2XPivot, x_axis, math.rad(90), math.rad(45))

end



------------------------------------------------------------
-- WEAPONS
------------------------------------------------------------

function script.AimFromWeapon(num)

	return base

end



function script.AimWeapon(num, heading, pitch)

	return true

end



function script.QueryWeapon(num)

	if num == 1 then

		if missileBarrel then
			return torpFlare1
		else
			return torpFlare2
		end


	elseif num == 2 then

		if torpedoBarrel then
			return torpFlare1
		else
			return torpFlare2
		end

	end

end



function script.FireWeapon(num)

	local useBarrel


	if num == 1 then

		useBarrel = missileBarrel


	elseif num == 2 then

		useBarrel = torpedoBarrel

	end



	if useBarrel then

		EmitSfx(torpFlare1, 1024)

		Move(torpedoBarrel1, z_axis, -3, 0)
		Sleep(10)
		Move(torpedoBarrel1, z_axis, 0, 3)


	else

		EmitSfx(torpFlare2, 1024)

		Move(torpedoBarrel2, z_axis, -3, 0)
		Sleep(10)
		Move(torpedoBarrel2, z_axis, 0, 3)

	end

end



function script.EndBurst(num)

	if num == 1 then

		missileBarrel = not missileBarrel


	elseif num == 2 then

		torpedoBarrel = not torpedoBarrel

	end

end



------------------------------------------------------------
-- DEATH
------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth


	if severity <= 0.25 then

		Explode(base, SFX.FALL)

		return 1


	elseif severity <= 0.50 then

		Explode(base, SFX.FALL)

		return 1


	else

		Explode(base, SFX.SHATTER)

		return 2

	end

end