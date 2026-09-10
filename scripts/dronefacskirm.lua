include "constants.lua"

------------------------------------------------------------
-- PIECES (MATCH BOS EXACTLY)
------------------------------------------------------------

local base = piece 'base'

local flare1 = piece 'flare1'
local flare2 = piece 'flare2'

local shell = piece 'shell'
local sleeve = piece 'sleeve'
local aimx1 = piece 'aimx1'

local launcher = piece 'launcher'

local thruster = piece 'thruster'
local blades = piece 'blades'
local thrust = piece 'thrust'
local blur = piece 'blur'

local wing_bl = piece 'wing_bl'
local wing_br = piece 'wing_br'
local wing_fl = piece 'wing_fl'
local wing_fr = piece 'wing_fr'


------------------------------------------------------------
-- VARIABLES
------------------------------------------------------------

local smokePiece = {base}

local SIG_AIM = 1
local SIG_RESTORE = 2


local gun = 0
local flying = false
local moving = false


local spGetUnitVelocity = Spring.GetUnitVelocity



------------------------------------------------------------
-- IDLE HOVER WING ANIMATION
------------------------------------------------------------

local function IdleHover()

	while true do

		if moving then

			Turn(wing_bl, z_axis, math.rad(-30), math.rad(1350))
			Turn(wing_br, z_axis, math.rad(30), math.rad(1350))
			Turn(wing_fl, z_axis, math.rad(30), math.rad(1350))
			Turn(wing_fr, z_axis, math.rad(-30), math.rad(1350))

			Sleep(55)


			Turn(wing_bl, z_axis, math.rad(60), math.rad(1350))
			Turn(wing_br, z_axis, math.rad(-60), math.rad(1350))
			Turn(wing_fl, z_axis, math.rad(-60), math.rad(1350))
			Turn(wing_fr, z_axis, math.rad(60), math.rad(1350))

			Sleep(60)

		else

			Sleep(200)

		end

	end

end



------------------------------------------------------------
-- OPEN FLIGHT MODE
------------------------------------------------------------

local function OpenWings()

	Turn(wing_br, y_axis, math.rad(-10), math.rad(100))
	Turn(wing_fr, y_axis, math.rad(10), math.rad(100))

	Turn(wing_bl, y_axis, math.rad(10), math.rad(100))
	Turn(wing_fl, y_axis, math.rad(-10), math.rad(100))


	Turn(wing_br, x_axis, 0, math.rad(100))
	Turn(wing_fr, x_axis, 0, math.rad(100))

	Turn(wing_bl, x_axis, 0, math.rad(100))
	Turn(wing_fl, x_axis, 0, math.rad(100))


	WaitForTurn(wing_fr, x_axis)

	Show(blur)

end



------------------------------------------------------------
-- CLOSED / PARKED MODE
------------------------------------------------------------

local function CloseWings()

	Hide(blur)


	Turn(wing_bl, z_axis, math.rad(-5), math.rad(100))
	Turn(wing_br, z_axis, math.rad(-5), math.rad(100))
	Turn(wing_fl, z_axis, 0, math.rad(100))
	Turn(wing_fr, z_axis, 0, math.rad(100))


	WaitForTurn(wing_fr, z_axis)



	Turn(wing_fr, x_axis, math.rad(90), math.rad(100))
	Turn(wing_br, x_axis, math.rad(90), math.rad(100))
	Turn(wing_fl, x_axis, math.rad(90), math.rad(100))
	Turn(wing_bl, x_axis, math.rad(90), math.rad(100))


	Turn(wing_br, y_axis, math.rad(-70), math.rad(100))
	Turn(wing_fr, y_axis, math.rad(-70), math.rad(100))

	Turn(wing_bl, y_axis, math.rad(80), math.rad(100))
	Turn(wing_fl, y_axis, math.rad(70), math.rad(100))


	Turn(launcher, x_axis, 0, math.rad(20))

	Move(sleeve, y_axis, 0, 10)


	Turn(thruster, x_axis, math.rad(-90), math.rad(120))

end



------------------------------------------------------------
-- CREATE
------------------------------------------------------------

function script.Create()

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)


	Hide(aimx1)

	Hide(flare1)
	Hide(flare2)

	Hide(thrust)
	Hide(blur)



	-- Initial folded position

	Turn(wing_bl, z_axis, math.rad(-5))
	Turn(wing_br, z_axis, math.rad(5))


	Turn(wing_fr, x_axis, math.rad(90))
	Turn(wing_br, x_axis, math.rad(90))
	Turn(wing_fl, x_axis, math.rad(90))
	Turn(wing_bl, x_axis, math.rad(90))


	Turn(wing_br, y_axis, math.rad(-70))
	Turn(wing_fr, y_axis, math.rad(-70))

	Turn(wing_bl, y_axis, math.rad(80))
	Turn(wing_fl, y_axis, math.rad(70))


	Turn(thruster, x_axis, math.rad(-90))


	StartThread(IdleHover)

end



------------------------------------------------------------
-- ACTIVATE
------------------------------------------------------------

function script.Activate()

	flying = true

	Show(thrust)

	Spin(blades, z_axis, math.rad(120), math.rad(5))


	StartThread(OpenWings)

end



------------------------------------------------------------
-- DEACTIVATE
------------------------------------------------------------

function script.Deactivate()

	flying = false

	Hide(thrust)

	StopSpin(blades, z_axis, math.rad(5))


	StartThread(CloseWings)

end



------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------

function script.StartMoving()

	moving = true

	Turn(thruster, x_axis, 0, math.rad(85))

end



function script.StopMoving()

	moving = false

	Turn(thruster, x_axis, math.rad(-90), math.rad(150))

end
-- Weapon restore

local function RestoreAfterDelay()

	Signal(SIG_RESTORE)
	SetSignalMask(SIG_RESTORE)

	Sleep(2000)

	Turn(launcher, x_axis, 0, math.rad(20))
	Move(sleeve, y_axis, 0, 10)

end


-- Weapon aiming

function script.AimFromWeapon(num)

	return aimx1

end


function script.AimWeapon(num, heading, pitch)

	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)

	Move(sleeve, y_axis, -6, 50)

	Turn(launcher, x_axis, -pitch, math.rad(100))

	StartThread(RestoreAfterDelay)

	return true

end


-- Fire point selection

function script.QueryWeapon(num)

	if gun_1 == 0 then

		gun_1 = 1
		return flare1

	else

		gun_1 = 0
		return flare2

	end

end


function script.FireWeapon(num)

	if gun_1 == 0 then

		EmitSfx(flare1, 1024)

	else

		EmitSfx(flare2, 1024)

	end


	Sleep(200)

	StartThread(RestoreAfterDelay)

end



-- Death

function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth

	if severity <= 0.25 then
		Explode(base, SFX.FALL)
		Explode(thruster, SFX.EXPLODE)
		Explode(thrust, SFX.EXPLODE)
		return 1

	elseif severity <= 0.50 then
		Explode(base, SFX.FALL)
		Explode(thruster, SFX.FALL)
		Explode(thrust, SFX.FALL)
		return 1

	else
		Explode(sleeve, SFX.SHATTER)
		Explode(sleeve, SFX.FALL)

		return 2
	end
end