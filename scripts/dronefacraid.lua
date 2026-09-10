include "constants.lua"

local base = piece 'base'
local lwing = piece 'lwing'
local rwing = piece 'rwing'
local bwing = piece 'bwing'

local lblades = piece 'lblades'
local rblades = piece 'rblades'
local bblades = piece 'bblades'

local lflare = piece 'lflare'
local rflare = piece 'rflare'

local smokePiece = {base}

local gun = 0

local SIG_AIM = 2


function script.Create()

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Hide(lflare)
	Hide(rflare)

end


function script.Activate()

	Spin(lblades, y_axis, math.rad(-800))
	Spin(rblades, y_axis, math.rad(-800))
	Spin(bblades, y_axis, math.rad(-800))

	Turn(lwing, y_axis, math.rad(-15), math.rad(60))
	Turn(rwing, y_axis, math.rad(15), math.rad(60))

	Turn(lwing, z_axis, math.rad(-15), math.rad(60))
	Turn(rwing, z_axis, math.rad(15), math.rad(60))

	Turn(bwing, x_axis, math.rad(15), math.rad(60))

end


function script.Deactivate()

	StopSpin(lblades, y_axis, math.rad(100))
	StopSpin(rblades, y_axis, math.rad(100))
	StopSpin(bblades, y_axis, math.rad(100))

	Turn(lwing, y_axis, 0, math.rad(10))
	Turn(rwing, y_axis, 0, math.rad(10))

	Turn(lwing, z_axis, math.rad(45), math.rad(30))
	Turn(rwing, z_axis, math.rad(-45), math.rad(30))

	Turn(bwing, x_axis, math.rad(-45), math.rad(30))

end


function script.QueryWeapon(num)

	if gun == 0 then
		gun = 1
		return lflare
	else
		gun = 0
		return rflare
	end

end


function script.AimFromWeapon(num)

	return base

end


function script.AimWeapon(num, heading, pitch)

	return true

end


function script.FireWeapon(num)

	if gun == 0 then
		EmitSfx(rflare, 1024)
	else
		EmitSfx(lflare, 1024)
	end

	Sleep(32)

	return true

end


function script.Killed(recentDamage, maxHealth)
	local severity = recentDamage / maxHealth

	if severity <= 0.25 then
		Explode(base, SFX.NONE)
		Explode(lwing, SFX.NONE)
		Explode(rwing, SFX.NONE)
		Explode(bwing, SFX.NONE)
		return 1

	elseif severity <= 0.5 or ((Spring.GetUnitMoveTypeData(unitID).aircraftState or "") == "crashing") then
		Explode(base, SFX.FALL + SFX.FIRE + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
		Explode(lwing, SFX.FALL)
		Explode(rwing, SFX.FALL + SFX.FIRE + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
		Explode(bwing, SFX.FALL)
		return 1

	elseif severity <= 0.75 then
		Explode(base, SFX.FALL + SFX.FIRE + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
		Explode(lwing, SFX.FALL)
		Explode(rwing, SFX.FALL + SFX.FIRE + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
		Explode(bwing, SFX.FALL)
		return 2

	else
		Explode(base, SFX.SHATTER)
		Explode(lwing, SFX.SHATTER)
		Explode(rwing, SFX.SHATTER)
		Explode(bwing, SFX.SHATTER)
		return 2
	end
end


function script.Docked(customparam, dockpiece, carrierarg1, carrierarg2, carrierarg3)

	if customparam == 1 then

		Turn(base, y_axis, carrierarg1)

		Spin(base, y_axis, 10, 1)

		return 1

	end

end


function script.Undocked(customparam, dockpiece)

	StopSpin(base, y_axis)

	Turn(base, y_axis, 0, math.rad(600))

	return 1

end