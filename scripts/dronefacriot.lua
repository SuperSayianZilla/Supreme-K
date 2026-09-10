include "constants.lua"

local base              = piece("base")

local thruster1         = piece("thruster1")
local thruster1XPivot   = piece("thruster1XPivot")
local thruster2         = piece("thruster2")
local thruster2XPivot   = piece("thruster2XPivot")

local wing1             = piece("wing1")
local wing2             = piece("wing2")

local centralThruster   = piece("centralThruster")

local riotSleeve1       = piece("riotSleeve1")
local riotBarrel1       = piece("riotBarrel1")
local riotSleeve2       = piece("riotSleeve2")
local riotBarrel2       = piece("riotBarrel2")

local riotFlare1        = piece("riotFlare1")
local riotFlare2        = piece("riotFlare2")

local smallThrust1      = piece("smallThrust1")
local smallThrust2      = piece("smallThrust2")

local mainThrust        = piece("mainThrust")


local whichBarrel = 0

local smokePiece = {base}

local SIG_AIM = 1
local SIG_RESTORE = 2



------------------------------------------------------------
-- CREATE
------------------------------------------------------------

function script.Create()

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Hide(smallThrust1)
	Hide(smallThrust2)
	Hide(mainThrust)

	Turn(smallThrust1, x_axis, math.rad(-90))
	Turn(smallThrust2, x_axis, math.rad(-90))

	Turn(thruster1XPivot, z_axis, math.rad(-20))
	Turn(thruster2XPivot, z_axis, math.rad(20))

	Turn(wing1, z_axis, math.rad(-25))
	Turn(wing2, z_axis, math.rad(25))

	whichBarrel = 0

end



------------------------------------------------------------
-- ACTIVATE
------------------------------------------------------------

function script.Activate()

	Show(smallThrust1)
	Show(smallThrust2)

	Turn(wing1, z_axis, 0, math.rad(30))
	Turn(wing2, z_axis, 0, math.rad(30))

	WaitForTurn(wing2, z_axis)

	Show(mainThrust)

end



------------------------------------------------------------
-- DEACTIVATE
------------------------------------------------------------

function script.Deactivate()

	Hide(mainThrust)

	Turn(wing1, z_axis, math.rad(-25), math.rad(30))
	Turn(wing2, z_axis, math.rad(25), math.rad(30))

	WaitForTurn(wing2, z_axis)

	Hide(smallThrust1)
	Hide(smallThrust2)

end



------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------

function script.MoveRate0()

	Turn(thruster1XPivot, x_axis, 0, math.rad(150))
	Turn(thruster2XPivot, x_axis, 0, math.rad(150))

end


function script.MoveRate1()

	Turn(thruster1XPivot, x_axis, math.rad(50), math.rad(90))
	Turn(thruster2XPivot, x_axis, math.rad(50), math.rad(90))

end


function script.MoveRate2()

	Turn(thruster1XPivot, x_axis, math.rad(90), math.rad(60))
	Turn(thruster2XPivot, x_axis, math.rad(90), math.rad(60))

end


function script.MoveRate3()

	Turn(thruster1XPivot, x_axis, math.rad(90), math.rad(45))
	Turn(thruster2XPivot, x_axis, math.rad(90), math.rad(45))

end




------------------------------------------------------------
-- WEAPON
------------------------------------------------------------

function script.AimFromWeapon(num)

	return base

end


function script.AimWeapon(num, heading, pitch)

	return true

end



function script.QueryWeapon(num)

	if whichBarrel == 0 then

		whichBarrel = 1
		return riotFlare1

	else

		whichBarrel = 0
		return riotFlare2

	end

end



local function BarrelRecoil(barrel)

	Move(barrel, z_axis, -3, 0)
	WaitForMove(barrel, z_axis)

	Sleep(10)

	Move(barrel, z_axis, 0, 3)
	WaitForMove(barrel, z_axis)

end



function script.FireWeapon(num)

	if whichBarrel == 1 then

		EmitSfx(riotFlare1, 1024)
		StartThread(BarrelRecoil, riotBarrel1)

	else

		EmitSfx(riotFlare2, 1024)
		StartThread(BarrelRecoil, riotBarrel2)

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

		Explode(base, SFX.FALL)

		return 2

	end

end