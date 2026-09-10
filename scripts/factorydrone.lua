include "constants.lua"

local base = piece("base")

local nano1, nano2, nano3 = piece("nano1", "nano2", "nano3")

local pad = piece("pad")
local exhaust = piece("exhaust")

local arm1, arm2, arm3 = piece("arm1", "arm2", "arm3")


local nanoFlare1a, nanoFlare1b,
nanoFlare2a, nanoFlare2b,
nanoFlare3a, nanoFlare3b =
piece(
	"nanoFlare1a",
	"nanoFlare1b",
	"nanoFlare2a",
	"nanoFlare2b",
	"nanoFlare3a",
	"nanoFlare3b"
)


local nanoPieces = {
	nanoFlare1a,
	nanoFlare1b,
	nanoFlare2a,
	nanoFlare2b,
	nanoFlare3a,
	nanoFlare3b,
}


local smokePiece = {
	exhaust
}


local SIG_SMOKE = 2

local spray = 0


------------------------------------------------------------
-- Smoke
------------------------------------------------------------

local function SmokeItUp()

	Signal(SIG_SMOKE)
	SetSignalMask(SIG_SMOKE)

	while true do

		EmitSfx(exhaust, 259)

		Sleep(500)

	end

end



------------------------------------------------------------
-- Build stance
------------------------------------------------------------

local function Open()

	SetUnitValue(COB.INBUILDSTANCE, 1)

end



local function Close()

	SetUnitValue(COB.INBUILDSTANCE, 0)

end



------------------------------------------------------------
-- Create
------------------------------------------------------------

function script.Create()

	StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

	Spring.SetUnitNanoPieces(unitID, nanoPieces)


	Turn(arm1, z_axis, 0)
	Turn(arm2, z_axis, 0)
	Turn(arm3, z_axis, 0)

end



------------------------------------------------------------
-- Active state
------------------------------------------------------------

function script.Activate()

	Open()

end



function script.Deactivate()

	Close()

end



------------------------------------------------------------
-- Construction
------------------------------------------------------------

function script.StartBuilding()

	StartThread(SmokeItUp)

end



function script.StopBuilding()

	Signal(SIG_SMOKE)

end



------------------------------------------------------------
-- Nano
------------------------------------------------------------

function script.QueryNanoPiece()

	spray = spray + 1

	if spray > #nanoPieces then
		spray = 1
	end

	return nanoPieces[spray]

end



------------------------------------------------------------
-- Build position
------------------------------------------------------------

function script.QueryBuildInfo()

	return pad

end



------------------------------------------------------------
-- Death
------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

	local severity = recentDamage / maxHealth


	if severity <= 0.25 then

		Explode(base, SFX.SHATTER)

		return 1


	elseif severity <= 0.50 then

		Explode(base, SFX.SHATTER)
		Explode(pad, SFX.FALL)

		return 1


	else

		Explode(base, SFX.SHATTER)

		Explode(
			pad,
			SFX.FALL +
			SFX.SMOKE +
			SFX.FIRE +
			SFX.EXPLODE_ON_HIT
		)

		return 2

	end

end