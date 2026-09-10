include 'constants.lua'

local AngleAverageShortest  = Spring.Utilities.Vector.AngleAverageShortest
local AngleSubtractShortest = Spring.Utilities.Vector.AngleSubtractShortest

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- pieces
--------------------------------------------------------------------------------

local pelvis, torso, head = piece('pelvis', 'torso', 'head')

-- AA turret is still part of the model, but is decorative only.
local aaturret = piece('AAturret')

local larm, larmcannon, larmbarrel1, larmflare1, larmbarrel2, larmflare2 =
	piece('larm', 'larmcannon', 'larmbarrel1', 'larmflare1',
	'larmbarrel2', 'larmflare2')

local rarm, rarmcannon, rarmbarrel1, rarmflare1, rarmbarrel2, rarmflare2 =
	piece('rarm', 'rarmcannon', 'rarmbarrel1', 'rarmflare1',
	'rarmbarrel2', 'rarmflare2')

local lupleg, lmidleg, lleg, lfoot, lftoe, lbtoe =
	piece('lupleg', 'lmidleg', 'lleg', 'lfoot', 'lftoe', 'lbtoe')

local rupleg, rmidleg, rleg, rfoot, rftoe, rbtoe =
	piece('rupleg', 'rmidleg', 'rleg', 'rfoot', 'rftoe', 'rbtoe')

local leftLeg = {
	thigh = piece'lupleg',
	knee = piece'lmidleg',
	shin = piece'lleg',
	foot = piece'lfoot',
	toef = piece'lftoe',
	toeb = piece'lbtoe'
}

local rightLeg = {
	thigh = piece'rupleg',
	knee = piece'rmidleg',
	shin = piece'rleg',
	foot = piece'rfoot',
	toef = piece'rftoe',
	toeb = piece'rbtoe'
}

local mainLeg, offLeg = leftLeg, rightLeg

local smokePiece = {
	torso,
	head,
}

--------------------------------------------------------------------------------
-- ONLY BARREL 1 AND 2 WEAPONS ARE USED
--------------------------------------------------------------------------------

local gunFlares = {
	{larmflare1, larmflare2},
	{rarmflare1, rarmflare2},
}

-- Only the two arm weapons exist now.
local barrels = {
	{larmbarrel1, larmbarrel2},
	{rarmbarrel1, rarmbarrel2},
}

local aimpoints = {
	larmcannon,
	rarmcannon,
}

local gunIndex = {
	1,
	1,
}

local gunFlareCount = {}

for i = 1, #gunFlares do
	gunFlareCount[i] = #gunFlares[i]
end

local blockGauss = {
	false,
	false,
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- CANISTER SYSTEM
--
-- Temporarily disabled.
-- The original canister bones and functions are left here commented out
-- so the system can be restored later if needed.
--------------------------------------------------------------------------------

--[[
local loadingCanister = false
local previousLoad = false

local canisters = {
	{loaded = true, body = piece('canister1'), cap = piece('cap1'), gib = piece('canister1_merged'), hor = math.cos(-0.2618), vert = math.sin(-0.2618)},
	{loaded = true, body = piece('canister2'), cap = piece('cap2'), gib = piece('canister2_merged'), hor = 1, vert = 0.01},
	{loaded = true, body = piece('canister3'), cap = piece('cap3'), gib = piece('canister3_merged'), hor = math.cos(0.349), vert = math.sin(0.349)},
}

local EXTRUDE_SPEED = 0.21 * 120 / tonumber(UnitDefs[unitDefID].customParams.jump_reload)

local fullCap = 0.5
local emptyCan = 23
local emptyCap = 4.6

local function MoveCanister(num, proportion, capProp, speed)
	local canister = canisters[num]

	Move(
		canister.body,
		z_axis,
		(1 - proportion) * emptyCan * canister.hor,
		speed and speed * canister.hor
	)

	Move(
		canister.body,
		y_axis,
		(1 - proportion) * emptyCan * canister.vert,
		speed and speed * canister.vert
	)

	capProp = capProp or proportion

	if capProp >= 1 then
		Move(
			canister.cap,
			z_axis,
			fullCap * canister.hor,
			speed and speed * canister.hor
		)

		Move(
			canister.cap,
			y_axis,
			fullCap * canister.vert,
			speed and speed * canister.vert
		)

	elseif capProp >= 0.95 then
		local dist = (fullCap - emptyCap) * (capProp - 0.95) * 15 + emptyCap

		Move(
			canister.cap,
			z_axis,
			dist * canister.hor,
			speed and speed * canister.hor
		)

		Move(
			canister.cap,
			y_axis,
			dist * canister.vert,
			speed and speed * canister.vert
		)

	else
		Move(
			canister.cap,
			z_axis,
			emptyCap * canister.hor,
			speed and speed * canister.hor
		)

		Move(
			canister.cap,
			y_axis,
			emptyCap * canister.vert,
			speed and speed * canister.vert
		)
	end
end
]]

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- signals
--------------------------------------------------------------------------------

local SIG_Restore = 1
local SIG_Walk = 2
local SIG_MOONWALK = 4

local PACE = 1.5

--------------------------------------------------------------------------------
-- leg positions
--------------------------------------------------------------------------------

local LEG_FRONT_ANGLES = {
	thigh = math.rad(-40),
	knee = math.rad(-10),
	shin = math.rad(50),
	foot = 0,
	toef = 0,
	toeb = math.rad(15)
}

local LEG_FRONT_SPEEDS = {
	thigh = math.rad(60) * PACE,
	knee = math.rad(60) * PACE,
	shin = math.rad(110) * PACE,
	foot = math.rad(90) * PACE,
	toef = math.rad(90) * PACE,
	toeb = math.rad(30) * PACE
}

local LEG_STRAIGHT_ANGLES = {
	thigh = math.rad(-10),
	knee = math.rad(-20),
	shin = math.rad(30),
	foot = 0,
	toef = 0,
	toeb = 0
}

local LEG_STRAIGHT_SPEEDS = {
	thigh = math.rad(60) * PACE,
	knee = math.rad(30) * PACE,
	shin = math.rad(40) * PACE,
	foot = math.rad(90) * PACE,
	toef = math.rad(90) * PACE,
	toeb = math.rad(30) * PACE
}

local LEG_BACK_ANGLES = {
	thigh = math.rad(10),
	knee = math.rad(-5),
	shin = math.rad(15),
	foot = 0,
	toef = math.rad(-20),
	toeb = math.rad(-10)
}

local LEG_BACK_SPEEDS = {
	thigh = math.rad(30) * PACE,
	knee = math.rad(60) * PACE,
	shin = math.rad(90) * PACE,
	foot = math.rad(90) * PACE,
	toef = math.rad(40) * PACE,
	toeb = math.rad(60) * PACE
}

local LEG_BENT_ANGLES = {
	thigh = math.rad(-15),
	knee = math.rad(20),
	shin = math.rad(-20),
	foot = 0,
	toef = 0,
	toeb = 0
}

local LEG_BENT_SPEEDS = {
	thigh = math.rad(60) * PACE,
	knee = math.rad(90) * PACE,
	shin = math.rad(90) * PACE,
	foot = math.rad(90) * PACE,
	toef = math.rad(90) * PACE,
	toeb = math.rad(90) * PACE
}

local LEG_STEP_ANGLES = {
	thigh = math.rad(-9),
	knee = math.rad(30),
	shin = math.rad(-22),
	foot = 0,
	toef = math.rad(8),
	toeb = 0
}

local LEG_STEP_SPEEDS = {
	thigh = math.rad(15) * PACE,
	knee = math.rad(50) * PACE,
	shin = math.rad(36.6) * PACE,
	foot = math.rad(50) * PACE,
	toef = math.rad(13.3) * PACE,
	toeb = math.rad(50) * PACE
}

--------------------------------------------------------------------------------
-- torso / pelvis motion
--------------------------------------------------------------------------------

local TORSO_ANGLE_MOTION = math.rad(8)
local TORSO_SPEED_MOTION = math.rad(15) * PACE

local TORSO_TILT_ANGLE = math.rad(15)
local TORSO_TILT_SPEED = math.rad(15) * PACE

--------------------------------------------------------------------------------
-- PELVIS MOVEMENT
--
-- Adjusted directly for the smaller model.
--
-- Original:
--     lift  = 11.5
--     lower = 6.5
--
-- New:
--     lift  = 5.175
--     lower = 2.925
--------------------------------------------------------------------------------

local PELVIS_LIFT_HEIGHT = 5.175
local PELVIS_LIFT_SPEED = 6.3

local PELVIS_LOWER_HEIGHT = 2.925
local PELVIS_LOWER_SPEED = 6.75

--------------------------------------------------------------------------------
-- arm motion
--
-- These are rotations, so they stay unchanged.
--------------------------------------------------------------------------------

local ARM_FRONT_ANGLE = math.rad(-15)
local ARM_FRONT_SPEED = math.rad(35) * PACE

local ARM_BACK_ANGLE = math.rad(5)
local ARM_BACK_SPEED = math.rad(30) * PACE

--------------------------------------------------------------------------------
-- weapon / torso state
--------------------------------------------------------------------------------

local leftTorsoHeading = false
local rightTorsoHeading = false
local lastGunAverageHeading = false

local JUMP_TURN_SPEED = math.pi / 80

local isFiring = false
local resetRestore = false
local jumpActive = false
local jumpWindup = false
local weaponBlocked = false

--------------------------------------------------------------------------------
-- Effects
--------------------------------------------------------------------------------

local dirtfling = 1024
local muzzle_flash = 1025
local shells = 1026
local muzzle_flash_large = 1027
local muzzle_smoke_large = 1028
local jetfeet = 1029
local jetfeet_fire = 1030

--------------------------------------------------------------------------------
-- Weapons
--------------------------------------------------------------------------------

local landing_explosion = 4101
local footcrater = 4102
local takeoff_explosion = 4103

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function DoRestore()

	Turn(torso, y_axis, 0, math.rad(70))

	Turn(larm, x_axis, 0, math.rad(30))
	Turn(larmcannon, y_axis, 0, math.rad(10))

	Turn(rarm, x_axis, 0, math.rad(30))
	Turn(rarmcannon, y_axis, 0, math.rad(10))

	isFiring = false
	lastTorsoHeading = 0
end

local function Step(frontLeg, backLeg, impactFoot, pelvisMult)
	local speed = math.max(0.05, GG.att_MoveChange[unitID] or 1)

	mainLeg, offLeg = offLeg, mainLeg

	--------------------------------------------------------------------------------
	-- CONTACT
	--------------------------------------------------------------------------------

	for i, p in pairs(frontLeg) do
		Turn(
			frontLeg[i],
			x_axis,
			LEG_FRONT_ANGLES[i],
			LEG_FRONT_SPEEDS[i] * speed
		)

		Turn(
			backLeg[i],
			x_axis,
			LEG_BACK_ANGLES[i],
			LEG_BACK_SPEEDS[i] * speed
		)
	end

	--------------------------------------------------------------------------------
	-- SWING ARMS AND BODY
	--------------------------------------------------------------------------------

	if not isFiring then
		if frontLeg == leftLeg then

			Turn(
				torso,
				y_axis,
				TORSO_ANGLE_MOTION,
				TORSO_SPEED_MOTION * speed
			)

			Turn(
				larm,
				x_axis,
				ARM_BACK_ANGLE,
				ARM_BACK_SPEED * speed
			)

			Turn(
				larmcannon,
				x_axis,
				ARM_BACK_ANGLE,
				ARM_BACK_SPEED * speed
			)

			Turn(
				rarm,
				x_axis,
				ARM_FRONT_ANGLE,
				ARM_FRONT_SPEED * speed
			)

		else

			Turn(
				torso,
				y_axis,
				-TORSO_ANGLE_MOTION,
				TORSO_SPEED_MOTION * speed
			)

			Turn(
				larm,
				x_axis,
				ARM_FRONT_ANGLE,
				ARM_FRONT_SPEED * speed
			)

			Turn(
				rarmcannon,
				x_axis,
				ARM_BACK_ANGLE,
				ARM_BACK_SPEED * speed
			)

			Turn(
				rarm,
				x_axis,
				ARM_BACK_ANGLE,
				ARM_BACK_SPEED * speed
			)
		end
	end

	--------------------------------------------------------------------------------
	-- LOWER BODY
	--------------------------------------------------------------------------------

	Move(
		pelvis,
		y_axis,
		PELVIS_LOWER_HEIGHT,
		PELVIS_LOWER_SPEED * pelvisMult * speed
	)

	Turn(
		torso,
		x_axis,
		TORSO_TILT_ANGLE,
		TORSO_TILT_SPEED * speed
	)

	--------------------------------------------------------------------------------
	-- WAIT FOR CONTACT POSITION
	--------------------------------------------------------------------------------

	for i, p in pairs(frontLeg) do
		WaitForTurn(frontLeg[i], x_axis)
		WaitForTurn(backLeg[i], x_axis)
	end

	speed = math.max(0.05, GG.att_MoveChange[unitID] or 1)

	--------------------------------------------------------------------------------
	-- PASSING
	--------------------------------------------------------------------------------

	for i, p in pairs(frontLeg) do
		Turn(
			frontLeg[i],
			x_axis,
			LEG_STRAIGHT_ANGLES[i],
			LEG_STRAIGHT_SPEEDS[i] * speed
		)

		Turn(
			backLeg[i],
			x_axis,
			LEG_BENT_ANGLES[i],
			LEG_BENT_SPEEDS[i] * speed
		)
	end

	--------------------------------------------------------------------------------
	-- RAISE PELVIS
	--------------------------------------------------------------------------------

	Move(
		pelvis,
		y_axis,
		PELVIS_LIFT_HEIGHT,
		PELVIS_LIFT_SPEED * pelvisMult * speed
	)

	Turn(
		torso,
		x_axis,
		0,
		TORSO_TILT_SPEED * speed
	)

	--------------------------------------------------------------------------------
	-- WAIT FOR PASSING POSITION
	--------------------------------------------------------------------------------

	for i, p in pairs(frontLeg) do
		WaitForTurn(frontLeg[i], x_axis)
		WaitForTurn(backLeg[i], x_axis)
	end

	Sleep(0)
end

--------------------------------------------------------------------------------
-- WALK IN PLACE
--
-- Original pelvis movement:
--     2 -> 0.9
--     6 -> 2.7
--------------------------------------------------------------------------------

local function StepInPlace(frontLeg, backLeg)

	Move(
		pelvis,
		y_axis,
		0.9,
		2.7
	)

	for i, p in pairs(frontLeg) do
		Turn(
			frontLeg[i],
			x_axis,
			0.8 * LEG_STEP_ANGLES[i],
			LEG_STEP_SPEEDS[i] * 1.4
		)

		Turn(
			backLeg[i],
			x_axis,
			-0.5 * LEG_STEP_ANGLES[i],
			LEG_STEP_SPEEDS[i]
		)
	end

	Sleep(400)
end

--------------------------------------------------------------------------------
-- WALK LOOP
--------------------------------------------------------------------------------

local function Walk()
	Signal(SIG_Walk)
	SetSignalMask(SIG_Walk)

	local first = true

	while true do

		Step(
			mainLeg,
			offLeg,
			lfoot,
			(first and 2) or 1
		)

		Step(
			mainLeg,
			offLeg,
			rfoot,
			(first and 1.2) or 1
		)

		first = false
	end
end

--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------

local function StopWalk()

	Signal(SIG_Walk)
	SetSignalMask(SIG_Walk)

	Move(
		torso,
		y_axis,
		0,
		1
	)

	for i, p in pairs(leftLeg) do
		Turn(
			leftLeg[i],
			x_axis,
			0,
			LEG_STRAIGHT_SPEEDS[i]
		)

		Turn(
			rightLeg[i],
			x_axis,
			0,
			LEG_STRAIGHT_SPEEDS[i]
		)
	end

	Turn(
		pelvis,
		z_axis,
		0,
		math.rad(30)
	)

	Turn(
		torso,
		x_axis,
		0,
		math.rad(30)
	)

	if not isFiring then
		Turn(
			torso,
			y_axis,
			0,
			math.rad(30)
		)
	end

	--------------------------------------------------------------------------------
	-- Return pelvis to neutral position.
	--------------------------------------------------------------------------------

	Move(
		pelvis,
		y_axis,
		0,
		9
	)

	Turn(
		rarm,
		x_axis,
		0,
		math.rad(30)
	)

	Turn(
		larm,
		x_axis,
		0,
		math.rad(10)
	)
end

--------------------------------------------------------------------------------
-- MOONWALK / MOVEMENT CHECK
--------------------------------------------------------------------------------

local function MoonwalkThread()

	Signal(SIG_MOONWALK)
	SetSignalMask(SIG_MOONWALK)

	while true do

		local _, _, _, speed = Spring.GetUnitVelocity(unitID)

		if speed < 0.4 then
			StartThread(StopWalk)
		else
			StartThread(Walk)
		end

		local x, y, z = Spring.GetUnitPosition(unitID)
		local h = Spring.GetGroundHeight(x, z)

		if math.abs(h - y) < 0.01 then
			return
		end

		Sleep(800)
	end
end

function unmoonwalkFunc()
	StartThread(MoonwalkThread)
end

function script.StartMoving()
	if not jumpActive then
		StartThread(Walk)
	end
end

function script.StopMoving()
	StartThread(StopWalk)
end

--------------------------------------------------------------------------------
-- Jumping
--------------------------------------------------------------------------------

local function PreJumpThread(turn, lineDist, flightDist, duration)

	jumpWindup = true
	script.StopMoving()

	local speed = math.max(0.5, GG.att_MoveChange[unitID] or 1)

	DoRestore()

	if jumpWindup then
		weaponBlocked = true

		local heading = -Spring.GetUnitHeading(unitID) * GG.Script.headingToRad

		Spring.MoveCtrl.SetRotation(
			unitID,
			0,
			heading,
			0
		)
	end

	local rotationRequired = -turn * GG.Script.headingToRad

	local rotationFrames = math.ceil(
		math.abs(rotationRequired / JUMP_TURN_SPEED) / 12 / speed
	) * 12

	-- Canister loading/unloading is temporarily disabled.
	--[[
	local usingCanister = false

	for i = 1, 3 do
		if canisters[i].loaded then
			usingCanister = i
			canisters[i].loaded = false
			break
		end
	end
	]]

	if rotationFrames > 0 then

		Spring.MoveCtrl.SetRotationVelocity(
			unitID,
			0,
			rotationRequired / rotationFrames,
			0
		)

		while true do

			StepInPlace(
				leftLeg,
				rightLeg
			)

			rotationFrames = rotationFrames - 12

			if rotationFrames <= 0 then
				break
			end

			Move(
				pelvis,
				y_axis,
				1.8,
				3.15
			)

			Sleep(400)

			rotationFrames = rotationFrames - 12

			if rotationFrames <= 0 then
				break
			end

			StepInPlace(
				rightLeg,
				leftLeg
			)

			rotationFrames = rotationFrames - 12

			if rotationFrames <= 0 then
				break
			end

			Move(
				pelvis,
				y_axis,
				1.8,
				3.15
			)

			Sleep(400)

			rotationFrames = rotationFrames - 12

			if rotationFrames <= 0 then
				break
			end
		end
	end

	if jumpWindup then

		Spring.MoveCtrl.SetRotationVelocity(
			unitID,
			0,
			0,
			0
		)

		for i, p in pairs(leftLeg) do

			Turn(
				leftLeg[i],
				x_axis,
				0,
				LEG_STEP_SPEEDS[i] * speed
			)

			Turn(
				rightLeg[i],
				x_axis,
				0,
				LEG_STEP_SPEEDS[i] * speed
			)
		end

		Move(
			pelvis,
			y_axis,
			0,
			3.6 * speed
		)
	end

	-- Canister extrusion disabled.
	--[[
	if usingCanister then
		MoveCanister(usingCanister, 1, 0, 3 / speed)
	end
	]]

	if jumpWindup then

		Sleep(600 / speed)

		for i, p in pairs(leftLeg) do

			Turn(
				leftLeg[i],
				x_axis,
				1.66 * LEG_STEP_ANGLES[i],
				LEG_STEP_SPEEDS[i] * speed
			)

			Turn(
				rightLeg[i],
				x_axis,
				1.66 * LEG_STEP_ANGLES[i],
				LEG_STEP_SPEEDS[i] * speed
			)
		end

		Move(
			torso,
			y_axis,
			0,
			1 * speed
		)

		Move(
			pelvis,
			y_axis,
			-9,
			7.2 * speed
		)

		Move(
			pelvis,
			z_axis,
			-4.5,
			3.6 * speed
		)

		Turn(
			torso,
			x_axis,
			math.rad(20),
			math.rad(30) * speed
		)

		Turn(
			pelvis,
			z_axis,
			0,
			math.rad(30) * speed
		)
	end

	-- Canister unloading/explosion disabled.
	--[[
	if usingCanister then
		Sleep(1367)

		Hide(canisters[usingCanister].body)
		Hide(canisters[usingCanister].cap)

		MoveCanister(usingCanister, 0)

		Explode(
			canisters[usingCanister].gib,
			SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE
		)

		Sleep(33)

		Show(canisters[usingCanister].body)
		Show(canisters[usingCanister].cap)
	end
	]]

	jumpWindup = false
end

--------------------------------------------------------------------------------
-- END JUMP
--------------------------------------------------------------------------------

local function EndJumpThread()

	GG.PokeDecloakUnit(
		unitID,
		unitDefID
	)

	local projectiles = (
		GG.att_ProjMult[unitID] or 1
	)

	for i = 1, projectiles do
		EmitSfx(
			lfoot,
			landing_explosion
		)
	end

	EmitSfx(
		lfoot,
		dirtfling
	)

	Turn(
		torso,
		x_axis,
		math.rad(45)
	)

	Turn(
		larm,
		x_axis,
		math.rad(-40)
	)

	Turn(
		rarm,
		x_axis,
		math.rad(-40)
	)

	Sleep(50)

	Turn(
		torso,
		x_axis,
		0,
		math.rad(35)
	)

	Turn(
		larm,
		x_axis,
		0,
		math.rad(35)
	)

	Turn(
		rarm,
		x_axis,
		0,
		math.rad(35)
	)
end

function preJump(turn, lineDist, flightDist, duration)
	StartThread(
		PreJumpThread,
		turn,
		lineDist,
		flightDist,
		duration
	)
end

--------------------------------------------------------------------------------
-- Canister reload disabled
--------------------------------------------------------------------------------

function jumpReloadProgress(reloadAmount)

	-- Canister loading is intentionally disabled.
	--
	-- Original logic preserved below for later restoration:
	--
	--[[
	if not loadingCanister then
		previousLoad = reloadAmount

		for i = 1, 3 do
			if not canisters[i].loaded then
				loadingCanister = i
				break
			end
		end
	end

	while reloadAmount < previousLoad - 0.2 do
		previousLoad = previousLoad - 1
	end

	if not loadingCanister then
		return
	end

	local speed = math.max(0.5, GG.att_ReloadChange[unitID] or 1)

	reloadAmount = reloadAmount - math.floor(previousLoad)

	if reloadAmount >= 1 then
		canisters[loadingCanister].loaded = true
		MoveCanister(loadingCanister, 1, false, 2.5)
		loadingCanister = false
	else
		MoveCanister(
			loadingCanister,
			reloadAmount,
			false,
			speed * EXTRUDE_SPEED
		)
	end
	]]
end

--------------------------------------------------------------------------------

function beginJump()

	jumpActive = true

	for i, p in pairs(leftLeg) do

		Turn(
			leftLeg[i],
			x_axis,
			0,
			LEG_STEP_SPEEDS[i]
		)

		Turn(
			rightLeg[i],
			x_axis,
			0,
			LEG_STEP_SPEEDS[i]
		)
	end

	local x, y, z = Spring.GetUnitPosition(
		unitID,
		true
	)

	GG.PlayFogHiddenSound(
		"DetrimentJump",
		15,
		x,
		y,
		z
	)
end

function jumping(jumpPercent)

	if jumpPercent < 30 then

		GG.PokeDecloakUnit(
			unitID,
			unitDefID
		)

		EmitSfx(
			lfoot,
			jetfeet_fire
		)

		EmitSfx(
			rfoot,
			jetfeet_fire
		)
	end

	if weaponBlocked and jumpPercent >= 25 then

		Move(
			pelvis,
			y_axis,
			0,
			2.25
		)

		Move(
			pelvis,
			z_axis,
			0,
			1.35
		)

		Turn(
			torso,
			x_axis,
			0,
			math.rad(10)
		)

		weaponBlocked = false
	end
end

function endJump()

	jumpActive = false

	StartThread(
		EndJumpThread
	)
end

function cancelJump()

	jumpWindup = false
	jumpActive = false
	weaponBlocked = false

	Turn(
		torso,
		x_axis,
		0,
		math.rad(10)
	)

	Move(
		pelvis,
		y_axis,
		0,
		2.25
	)

	Move(
		pelvis,
		z_axis,
		0,
		1.35
	)
end

--------------------------------------------------------------------------------
-- Restore
--------------------------------------------------------------------------------

local function RestoreAfterDelay()

	local counter = 2

	while true do

		if counter > 0 and not Spring.GetUnitIsStunned(unitID) then
			counter = counter - 1
		end

		if resetRestore then
			resetRestore = false
			counter = 2
		end

		if counter == 0 then
			DoRestore()
		end

		Sleep(1000)
	end
end

--------------------------------------------------------------------------------
-- Create
--------------------------------------------------------------------------------

function script.Create()

	--------------------------------------------------------------------------------
	-- HIDE CANISTERS
	--------------------------------------------------------------------------------

	Hide(piece('canister1'))
	Hide(piece('canister2'))
	Hide(piece('canister3'))

	Hide(piece('cap1'))
	Hide(piece('cap2'))
	Hide(piece('cap3'))

	-- Hide any associated canister geometry.
	Hide(piece('canister1_merged'))
	Hide(piece('canister2_merged'))
	Hide(piece('canister3_merged'))

	Hide(piece('canister1_full'))
	Hide(piece('canister2_full'))
	Hide(piece('canister3_full'))

	Hide(piece('can1_full_cap'))
	Hide(piece('can2_full_cap'))
	Hide(piece('can3_full_cap'))

	Hide(piece('can1_full_base'))
	Hide(piece('can2_full_base'))
	Hide(piece('can3_full_base'))

	--------------------------------------------------------------------------------

	Turn(
		larm,
		z_axis,
		-0.1
	)

	Turn(
		rarm,
		z_axis,
		0.1
	)

	StartThread(
		GG.Script.SmokeUnit,
		unitID,
		smokePiece
	)

	StartThread(
		RestoreAfterDelay
	)

	Spring.SetUnitMaxRange(
		unitID,
		510
	)
end

--------------------------------------------------------------------------------
-- Weapon interface
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)
	return aimpoints[num]
end

function script.QueryWeapon(num)
	return gunFlares[num][gunIndex[num]]
end

function script.AimWeapon(num, heading, pitch)

	local SIG_AIM = 2 ^ (num + 1)
	local speed = math.max(
		0.5,
		GG.att_MoveChange[unitID] or 1
	)

	isFiring = true

	Signal(SIG_AIM)
	SetSignalMask(SIG_AIM)

	-- Only weapons 1 and 2 exist.
	if weaponBlocked then
		return false
	end

	resetRestore = true

	--------------------------------------------------------------------------------
	-- LEFT GUN
	--------------------------------------------------------------------------------

	if num == 1 then

		leftTorsoHeading = heading

		if rightTorsoHeading then

			heading = AngleAverageShortest(
				rightTorsoHeading,
				leftTorsoHeading
			)

			rightTorsoHeading = false
		end

		lastGunAverageHeading = heading

		local armAngle = leftTorsoHeading - heading

		if armAngle > 3 then
			armAngle = armAngle - 2 * math.pi
		end

		armAngle = math.min(
			0.2,
			math.max(-0.2, armAngle)
		)

		Turn(
			torso,
			y_axis,
			heading,
			math.rad(140) * speed
		)

		Turn(
			larmcannon,
			y_axis,
			armAngle,
			math.rad(20) * speed
		)

		Turn(
			larm,
			x_axis,
			-pitch,
			math.rad(40) * speed
		)

		WaitForTurn(
			torso,
			y_axis
		)

		WaitForTurn(
			larm,
			x_axis
		)

	--------------------------------------------------------------------------------
	-- RIGHT GUN
	--------------------------------------------------------------------------------

	elseif num == 2 then

		rightTorsoHeading = heading

		if leftTorsoHeading then

			heading = AngleAverageShortest(
				rightTorsoHeading,
				leftTorsoHeading
			)

			leftTorsoHeading = false
		end

		lastGunAverageHeading = heading

		local armAngle = rightTorsoHeading - heading

		if armAngle > 3 then
			armAngle = armAngle - 2 * math.pi
		end

		-- Avoid excessive arm conflict.
		if math.abs(armAngle) > 0.7 then

			lastGunAverageHeading = false
			rightTorsoHeading = false

			return false
		end

		armAngle = math.min(
			0.2,
			math.max(-0.2, armAngle)
		)

		Turn(
			torso,
			y_axis,
			heading,
			math.rad(160) * speed
		)

		Turn(
			rarmcannon,
			y_axis,
			armAngle,
			math.rad(40) * speed
		)

		Turn(
			rarm,
			x_axis,
			-pitch,
			math.rad(60) * speed
		)

		WaitForTurn(
			torso,
			y_axis
		)

		WaitForTurn(
			rarm,
			x_axis
		)

	else

		-- All other weapons have been removed.
		return false
	end

	lastTorsoHeading = heading

	return true
end

--------------------------------------------------------------------------------
-- Barrel alternation / recoil
--------------------------------------------------------------------------------

local function BumpGunNum(num)

	gunIndex[num] = gunIndex[num] + 1

	if gunIndex[num] > gunFlareCount[num] then
		gunIndex[num] = 1
	end
end

local function FireGun(num)

	local flare = gunFlares[num][gunIndex[num]]

	-- Muzzle flash only.
	EmitSfx(
		flare,
		muzzle_flash_large
	)

	-- Advance to the next barrel.
	BumpGunNum(num)
end

function script.Shot(num)

	if num == 1 or num == 2 then
		FireGun(num)
	end
end

--------------------------------------------------------------------------------
-- Weapon blocking
--------------------------------------------------------------------------------

function script.BlockShot(num, targetID)

	-- Only weapons 1 and 2 are valid.
	if num ~= 1 and num ~= 2 then
		return true
	end

	if weaponBlocked then
		return true
	end

	local frame = Spring.GetGameFrame()

	if (blockGauss[num] or 0) > frame then
		return true
	end

	blockGauss[3 - num] = frame + 6

	return false
end

--------------------------------------------------------------------------------
-- EndBurst
--------------------------------------------------------------------------------

function script.EndBurst(num)

	-- No special handling is needed for removed weapons.
	-- Barrel selection is handled by FireGun().
end

--------------------------------------------------------------------------------
-- Death
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth

	if severity <= 0.5 then

		Explode(
			torso,
			SFX.NONE
		)

		Explode(
			head,
			SFX.NONE
		)

		Explode(
			pelvis,
			SFX.NONE
		)

		Explode(
			rarmcannon,
			SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE
		)

		Explode(
			larmcannon,
			SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE
		)

		Explode(
			larm,
			SFX.SHATTER
		)

		return 1

	else

		Explode(
			torso,
			SFX.SHATTER
		)

		Explode(
			head,
			SFX.SMOKE + SFX.FIRE
		)

		Explode(
			pelvis,
			SFX.SHATTER
		)

		return 2
	end
end