include "constants.lua"
include "transports.lua"

local base = piece 'base'
local armor = piece 'armor'

local ljet = piece 'ljet'
local rjet = piece 'rjet'
local bjet = piece 'bjet'

local gears1 = piece 'gears1'
local gears2 = piece 'gears2'

local turret = piece 'turret'
local sleeve = piece 'sleeve'
local barrel = piece 'barrel'

local bthrust1 = piece 'bthrust1'
local bthrust2 = piece 'bthrust2'

local rthrust1 = piece 'rthrust1'
local rthrust2 = piece 'rthrust2'

local lthrust1 = piece 'lthrust1'
local lthrust2 = piece 'lthrust2'

local flare = piece 'flare'
local link = piece 'link'
local aimpoint = piece 'aimpoint'


local SIG_AIM1 = 256

local restoreDelay = 1000
local isAiming = false
local stunned = false


local smokePiece = {
	base,
	ljet,
	rjet,
	bjet,
}


------------------------------------------------------------
-- Create
------------------------------------------------------------

function script.Create()

	Hide(bthrust1)
	Hide(bthrust2)
	Hide(rthrust1)
	Hide(rthrust2)
	Hide(lthrust1)
	Hide(lthrust2)

	Hide(flare)

	Hide(link)
	Hide(aimpoint)


	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Spring.MoveCtrl.SetGunshipMoveTypeData(
		unitID,
		"bankingAllowed",
		false
	)

end



------------------------------------------------------------
-- Activation
------------------------------------------------------------

function script.Activate()

	Show(bthrust1)
	Show(bthrust2)
	Show(rthrust1)
	Show(rthrust2)
	Show(lthrust1)
	Show(lthrust2)


	Move(gears1, z_axis, 12, 12)

	Turn(gears1, x_axis, math.rad(-30), math.rad(30))
	Turn(gears2, x_axis, math.rad(60), math.rad(45))

end



function script.Deactivate()

	Hide(bthrust1)
	Hide(bthrust2)
	Hide(rthrust1)
	Hide(rthrust2)
	Hide(lthrust1)
	Hide(lthrust2)


	Move(gears1, z_axis, 0, 18)

	Turn(gears1, x_axis, 0, math.rad(45))
	Turn(gears2, x_axis, 0, math.rad(90))

end



------------------------------------------------------------
-- Transport
------------------------------------------------------------

function script.QueryTransport()

	return link

end



function script.BeginTransport(passengerID)

	local height = Spring.GetUnitHeight(passengerID)

	Move(
		link,
		y_axis,
		-height,
		nil,
		true
	)

end



function script.EndTransport()

	Move(link, y_axis, 0, nil, true)

end



------------------------------------------------------------
-- Jet movement animation
------------------------------------------------------------

function script.MoveRate(curRate)


	if curRate == 0 then

		Turn(bjet, x_axis, math.rad(-90), math.rad(80))
		Turn(ljet, x_axis, math.rad(-90), math.rad(80))
		Turn(rjet, x_axis, math.rad(-90), math.rad(80))


	elseif curRate == 1 then

		Turn(bjet, x_axis, math.rad(-45), math.rad(60))
		Turn(ljet, x_axis, math.rad(-45), math.rad(60))
		Turn(rjet, x_axis, math.rad(-45), math.rad(60))


	elseif curRate == 2 then

		if isAiming then

			Turn(bjet, x_axis, math.rad(-80), math.rad(40))
			Turn(ljet, x_axis, math.rad(-80), math.rad(40))
			Turn(rjet, x_axis, math.rad(-80), math.rad(40))

		else

			Turn(bjet, x_axis, 0, math.rad(45))
			Turn(ljet, x_axis, 0, math.rad(45))
			Turn(rjet, x_axis, 0, math.rad(45))

		end


	elseif curRate == 3 then

		Turn(bjet, x_axis, math.rad(-90), math.rad(70))
		Turn(ljet, x_axis, math.rad(-90), math.rad(70))
		Turn(rjet, x_axis, math.rad(-90), math.rad(70))

	end

end



------------------------------------------------------------
-- Weapon aiming
------------------------------------------------------------

function script.AimFromWeapon(num)

	return aimpoint

end



function script.AimWeapon(num, heading, pitch)

	if num ~= 1 then
		return false
	end


	Signal(SIG_AIM1)
	SetSignalMask(SIG_AIM1)


	isAiming = true


	Turn(bjet, x_axis, math.rad(-75), math.rad(25))
	Turn(ljet, x_axis, math.rad(-75), math.rad(25))
	Turn(rjet, x_axis, math.rad(-75), math.rad(25))


	Turn(
		turret,
		y_axis,
		heading,
		math.rad(180)
	)


	Turn(
		sleeve,
		x_axis,
		-pitch,
		math.rad(180)
	)


	StartThread(RestoreAfterDelay)


	return true

end



function script.QueryWeapon(num)

	return flare

end



function script.Shot(num)

	EmitSfx(flare, 1024)

	Move(barrel, z_axis, -3)

	Sleep(150)

	Move(barrel, z_axis, 0, 6)

end



------------------------------------------------------------
-- Restore turret
------------------------------------------------------------

function RestoreAfterDelay()

	Sleep(restoreDelay)


	if stunned then
		return
	end


	isAiming = false


	Turn(turret, y_axis, 0, math.rad(60))
	Turn(sleeve, x_axis, 0, math.rad(60))

end



------------------------------------------------------------
-- Stun support
------------------------------------------------------------

function script.SetStunned(state)

	stunned = state

	if not stunned then
		StartThread(RestoreAfterDelay)
	end

end



------------------------------------------------------------
-- Death
------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth

	local aircraftState = ""
	local moveData = Spring.GetUnitMoveTypeData(unitID)

	if moveData then
		aircraftState = moveData.aircraftState or ""
	end


	if severity <= 0.25 then

		Explode(base, SFX.SHATTER)
		Explode(armor, SFX.SHATTER)

		Explode(ljet, SFX.FALL)
		Explode(rjet, SFX.FALL)
		Explode(bjet, SFX.FALL)

		Explode(turret, SFX.SHATTER)
		Explode(sleeve, SFX.SHATTER)

		return 1


	elseif severity <= 0.50 or aircraftState == "crashing" then

		Explode(base, SFX.SHATTER)
		Explode(armor, SFX.SHATTER)

		Explode(ljet, SFX.FALL + SFX.SMOKE)
		Explode(rjet, SFX.FALL + SFX.SMOKE)
		Explode(bjet, SFX.FALL + SFX.SMOKE)

		Explode(turret, SFX.SHATTER)
		Explode(sleeve, SFX.SHATTER)

		return 1


	else

		Explode(base, SFX.SHATTER)

		Explode(
			armor,
			SFX.SHATTER
		)

		Explode(
			ljet,
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE +
			SFX.EXPLODE_ON_HIT
		)

		Explode(
			rjet,
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE +
			SFX.EXPLODE_ON_HIT
		)

		Explode(
			bjet,
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE +
			SFX.EXPLODE_ON_HIT
		)

		Explode(turret, SFX.SHATTER)
		Explode(sleeve, SFX.SHATTER)

		return 2

	end

end