include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local chassis, buildlight1Base, buildlight1, conLight1, cannisterLightL, cannisterLightR,
      lBackSuspension, lBackTyre, lFrontSuspension, lFrontTyre,
      rBackSuspension, rBackTyre, rFrontSuspension, rFrontTyre,
      nanoStrut, nanoHeadingPivot, nanoTurret, nanoTube,
      plateLStrut, plateRStrut, plateL, plateR, nanoFlare =
      piece(
        "chassis", "buildlight1Base", "buildlight1", "conLight1",
        "cannisterLightL", "cannisterLightR",
        "lBackSuspension", "lBackTyre",
        "lFrontSuspension", "lFrontTyre",
        "rBackSuspension", "rBackTyre",
        "rFrontSuspension", "rFrontTyre",
        "nanoStrut", "nanoHeadingPivot", "nanoTurret", "nanoTube",
        "plateLStrut", "plateRStrut",
        "plateL", "plateR",
        "nanoFlare"
      )

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

local SIG_MOVE = 1
local SIG_AIM  = 2
local SIG_RESTORE = 4

local RESTORE_DELAY = 6000

local deployed = false
local oldHeading = 0

local smokePiece = {
    chassis,
    nanoTurret,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()

    Hide(nanoFlare)
    Hide(conLight1)

    oldHeading = Spring.GetUnitHeading(unitID) or 0

    Turn(buildlight1Base, x_axis, math.rad(28))

    Move(buildlight1, y_axis, -0.5)

    Turn(plateLStrut, y_axis, math.rad(20))
    Turn(plateRStrut, y_axis, math.rad(-20))

    Move(nanoTube, z_axis, -3)

    Turn(nanoStrut, x_axis, math.rad(-12))

    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

local function SteeringThread()

    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while true do

        local heading = Spring.GetUnitHeading(unitID) or 0
        local steer = (heading - oldHeading) * 0.0006

        Turn(lFrontSuspension, y_axis, steer, math.rad(120))
        Turn(rFrontSuspension, y_axis, steer, math.rad(120))

        Turn(lBackSuspension, y_axis, -steer, math.rad(120))
        Turn(rBackSuspension, y_axis, -steer, math.rad(120))

        oldHeading = heading

        Sleep(66)
    end
end

function script.StartMoving()

    StartThread(SteeringThread)

    Spin(lFrontTyre, x_axis, math.rad(720))
    Spin(rFrontTyre, x_axis, math.rad(720))
    Spin(lBackTyre, x_axis, math.rad(720))
    Spin(rBackTyre, x_axis, math.rad(720))
end

function script.StopMoving()

    Signal(SIG_MOVE)

    StopSpin(lFrontTyre, x_axis)
    StopSpin(rFrontTyre, x_axis)
    StopSpin(lBackTyre, x_axis)
    StopSpin(rBackTyre, x_axis)

    Turn(lFrontSuspension, y_axis, 0, math.rad(180))
    Turn(rFrontSuspension, y_axis, 0, math.rad(180))
    Turn(lBackSuspension, y_axis, 0, math.rad(180))
    Turn(rBackSuspension, y_axis, 0, math.rad(180))
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------

local function RestoreThread()

    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(8000)

    deployed = false

    Hide(conLight1)
    Hide(nanoFlare)

    StopSpin(buildlight1, y_axis)

    Move(buildlight1, y_axis, -0.5, 1)

    Turn(nanoHeadingPivot, y_axis, 0, math.rad(720))
    Turn(nanoTurret, x_axis, 0, math.rad(540))

    Move(nanoTube, z_axis, -3, 40)

    Turn(nanoStrut, x_axis, math.rad(-12), math.rad(120))

    Turn(plateLStrut, y_axis, math.rad(20), math.rad(200))
    Turn(plateRStrut, y_axis, math.rad(-20), math.rad(200))
end

--------------------------------------------------------------------------------
-- WEAPON
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)
    return nanoTurret
end

function script.QueryWeapon(num)
    return nanoFlare
end

function script.AimWeapon(num, heading, pitch)

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    -- HARD LOCK: cannot fire until fully deployed
if not deployed then

    Turn(plateRStrut, y_axis, 0, math.rad(600))
    Turn(plateLStrut, y_axis, 0, math.rad(600))

    Turn(nanoStrut, x_axis, 0, math.rad(360))
    Move(nanoTube, z_axis, 0, 120)

    WaitForTurn(plateRStrut, y_axis)
    WaitForTurn(plateLStrut, y_axis)
    WaitForTurn(nanoStrut, x_axis)
    WaitForMove(nanoTube, z_axis)

    deployed = true
end

    -- if still somehow not deployed, block firing
    if not deployed then
        return false
    end

    Turn(nanoHeadingPivot, y_axis, heading, math.rad(720))
    Turn(nanoTurret, x_axis, -pitch, math.rad(540))

    WaitForTurn(nanoHeadingPivot, y_axis)
    WaitForTurn(nanoTurret, x_axis)

    Show(conLight1)
    Show(nanoFlare)

    Move(buildlight1, y_axis, 0, 1)
    Spin(buildlight1, y_axis, math.rad(240), math.rad(60))

    return true
end

function script.FireWeapon(num)

Signal(SIG_RESTORE)
StartThread(RestoreThread)

    Move(nanoTube, z_axis, 1.5, 40)
    Sleep(80)
    Move(nanoTube, z_axis, 0, 20)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

    local severity = (recentDamage / maxHealth) * 100

    if severity <= 25 then

        Explode(chassis, SFX.NONE)

        Explode(plateR,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(plateL, SFX.NONE)

        Explode(rBackSuspension, SFX.NONE)
        Explode(lBackSuspension, SFX.NONE)

        return 1
    end

    if severity <= 50 then

        Explode(chassis, SFX.NONE)

        Explode(plateR,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(plateL, SFX.FALL)

        Explode(rBackSuspension, SFX.FALL)

        Explode(lBackSuspension,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 2
    end

    if severity <= 99 then

        Explode(chassis, SFX.NONE)

        Explode(plateR,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(plateL,
            SFX.EXPLODE +
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(rBackSuspension,
            SFX.EXPLODE +
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(lBackSuspension,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 3
    end

    Explode(chassis,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    Explode(plateR,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    Explode(plateL,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(rBackSuspension,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(lBackSuspension,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(rFrontSuspension,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    return 3
end