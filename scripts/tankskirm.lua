include "constants.lua"
include "reliableStartMoving.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local base, tracks, turretBase, barrelPivot, barrelBack, barrelMid,
      barrelAim, barrelA, barrelB, barrelC, turretTop, flare =
    piece(
        "base",
        "tracks",
        "turretBase",
        "barrelPivot",
        "barrelBack",
        "barrelMid",
        "barrelAim",
        "barrelA",
        "barrelB",
        "barrelC",
        "turretTop",
        "flare"
    )

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_AIM  = 1
local SIG_FIRE = 2
local SIG_MOVE = 4

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------

local restoreDelay = 3000
local timeLeft = 0
local lastPrimaryHeading = -1000000

local smokePiece = {base, turretBase}

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

local TURRET_SPEED = math.rad(120)
local BARREL_SPEED = math.rad(60)
local RESTORE_SPEED = math.rad(40)

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()

    Hide(flare)

    restoreDelay = 3000
    timeLeft = 0
    lastPrimaryHeading = -1000000

end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

function script.StartMoving()

    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

end

function script.StopMoving()

    Signal(SIG_MOVE)

end

--------------------------------------------------------------------------------
-- RELOAD
--------------------------------------------------------------------------------

function SetMaxReloadTime(reloadMS)

    restoreDelay = reloadMS * 2

end

--------------------------------------------------------------------------------
-- RESTORE THREAD
--------------------------------------------------------------------------------

local function RestoreAfterDelay()

    while timeLeft > 1 do

        local waitTime = timeLeft
        timeLeft = 1

        Sleep(waitTime)

    end

    timeLeft = 0
    lastPrimaryHeading = -1000000

    Turn(
        turretBase,
        y_axis,
        0,
        RESTORE_SPEED
    )

    Turn(
        barrelPivot,
        x_axis,
        0,
        RESTORE_SPEED
    )

    WaitForTurn(
        turretBase,
        y_axis
    )

end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)

    return barrelPivot

end

function script.QueryWeapon(num)

    return flare

end

function script.AimWeapon(num, heading, pitch)

    if timeLeft == 0 then
        StartThread(RestoreAfterDelay)
    end

    timeLeft = restoreDelay

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(
        turretBase,
        y_axis,
        heading,
        TURRET_SPEED
    )

    Turn(
        barrelPivot,
        x_axis,
        -pitch,
        BARREL_SPEED
    )

    if math.abs(lastPrimaryHeading - heading) > math.rad(20) then

        WaitForTurn(
            turretBase,
            y_axis
        )

        WaitForTurn(
            barrelPivot,
            x_axis
        )

    end

    lastPrimaryHeading = heading

    return true

end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------

function script.FireWeapon(num)

    Signal(SIG_FIRE)
    SetSignalMask(SIG_FIRE)

    ------------------------------------------------------------------------
    -- Barrel A
    ------------------------------------------------------------------------

    EmitSfx(flare, 1024)

    Move(
        barrelA,
        z_axis,
        -6
    )

    Sleep(150)

    Move(
        barrelA,
        z_axis,
        0,
        18
    )

    ------------------------------------------------------------------------
    -- Barrel B
    ------------------------------------------------------------------------

    EmitSfx(flare, 1024)

    Move(
        barrelB,
        z_axis,
        -6
    )

    Sleep(150)

    Move(
        barrelB,
        z_axis,
        0,
        18
    )

    ------------------------------------------------------------------------
    -- Barrel C
    ------------------------------------------------------------------------

    EmitSfx(flare, 1024)

    Move(
        barrelC,
        z_axis,
        -6
    )

    Sleep(150)

    Move(
        barrelC,
        z_axis,
        0,
        18
    )

end

--------------------------------------------------------------------------------
-- BLOCK SHOT
--------------------------------------------------------------------------------

function script.BlockShot(num, targetID)

    return false

end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

    local severity = recentDamage / maxHealth * 100

    ------------------------------------------------------------------------
    -- LIGHT DAMAGE
    ------------------------------------------------------------------------

    if severity <= 25 then

        Explode(
            base,
            SFX.NONE
        )

        Explode(
            turretBase,
            SFX.NONE
        )

        Explode(
            barrelPivot,
            SFX.NONE
        )

        Explode(
            barrelMid,
            SFX.NONE
        )

        Explode(
            barrelBack,
            SFX.FALL +
            SFX.SMOKE +
            SFX.FIRE
        )

        return 1

    end

    ------------------------------------------------------------------------
    -- MEDIUM DAMAGE
    ------------------------------------------------------------------------

    if severity <= 50 then

        Explode(
            base,
            SFX.NONE
        )

        Explode(
            turretBase,
            SFX.FALL +
            SFX.SMOKE +
            SFX.FIRE
        )

        Explode(
            barrelPivot,
            SFX.FALL
        )

        Explode(
            barrelMid,
            SFX.FALL +
            SFX.SMOKE +
            SFX.FIRE
        )

        Explode(
            barrelBack,
            SFX.FALL
        )

        return 2

    end

    ------------------------------------------------------------------------
    -- HEAVY DAMAGE
    ------------------------------------------------------------------------

    if severity <= 99 then

        Explode(
            base,
            SFX.FALL +
            SFX.SMOKE +
            SFX.FIRE
        )

        Explode(
            turretBase,
            SFX.SHATTER +
            SFX.EXPLODE +
            SFX.FALL +
            SFX.SMOKE +
            SFX.FIRE
        )

        Explode(
            barrelPivot,
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(
            barrelMid,
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(
            barrelBack,
            SFX.SHATTER +
            SFX.EXPLODE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 3

    end

    ------------------------------------------------------------------------
    -- TOTAL DESTRUCTION
    ------------------------------------------------------------------------

    Explode(
        base,
        SFX.SHATTER +
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(
        turretBase,
        SFX.SHATTER +
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(
        barrelPivot,
        SFX.SHATTER +
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(
        barrelMid,
        SFX.SHATTER +
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(
        barrelBack,
        SFX.SHATTER +
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    return 3

end