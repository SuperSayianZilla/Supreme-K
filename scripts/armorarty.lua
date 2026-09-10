include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, tracks, shell =
    piece('base', 'tracks', 'shell')

local aimy1, turret, aimx1 =
    piece('aimy1', 'turret', 'aimx1')

local sleeve, barrel, cover, flare =
    piece('sleeve', 'barrel', 'cover', 'flare')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local restoreDelay = 6000
local stunned = false

--------------------------------------------------------------------------------
-- SPEEDS
--------------------------------------------------------------------------------
local AIM_Y_SPEED     = math.rad(90)
local AIM_X_SPEED     = math.rad(50)

local COVER_OPEN_SPEED  = math.rad(200)
local COVER_CLOSE_SPEED = math.rad(400)

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {
    base,
    turret,
    shell,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

    Hide(flare)

    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
end

function script.StopMoving()
end

--------------------------------------------------------------------------------
-- RELOAD TIME SUPPORT
--------------------------------------------------------------------------------
function SetMaxReloadTime(time)

    restoreDelay = time * 2

    return 0
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
local function ExecuteRestoreAfterDelay()

    if stunned then
        return
    end

    Turn(aimy1, y_axis, 0, AIM_Y_SPEED)
    Turn(aimx1, x_axis, 0, AIM_X_SPEED)
end

function script.setStunned(state)

    stunned = state

    if not stunned then
        StartThread(ExecuteRestoreAfterDelay)
    end
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function RestoreAfterDelay()

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Sleep(restoreDelay)

    StartThread(ExecuteRestoreAfterDelay)

    Move(turret, y_axis, 0, 5)
    Move(barrel, z_axis, 0, 15)

    Turn(cover, x_axis, 0, COVER_CLOSE_SPEED)
end

--------------------------------------------------------------------------------
-- WEAPON
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
    return aimx1
end

function script.QueryWeapon(num)
    return flare
end

function script.AimWeapon(num, heading, pitch)

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    ----------------------------------------------------------------
    -- DEPLOY
    ----------------------------------------------------------------
    Move(turret, y_axis, 4, 10)
    Move(barrel, z_axis, 5, 7.5)

    Turn(cover, x_axis, math.rad(160), COVER_OPEN_SPEED)

    ----------------------------------------------------------------
    -- AIM
    ----------------------------------------------------------------
    Turn(aimy1, y_axis, heading, AIM_Y_SPEED)
    Turn(aimx1, x_axis, -pitch, AIM_X_SPEED)

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(aimx1, x_axis)

    StartThread(RestoreAfterDelay)

    return true
end

--------------------------------------------------------------------------------
-- SHOT
--------------------------------------------------------------------------------
function script.Shot(num)

    EmitSfx(flare, 1024)

    ----------------------------------------------------------------
    -- RECOIL
    ----------------------------------------------------------------
    Move(barrel, z_axis, 2.5, 500)

    Turn(cover, x_axis, math.rad(100), math.rad(500))

    WaitForMove(barrel, z_axis)

    Move(barrel, z_axis, 5, 3)

    Turn(cover, x_axis, math.rad(160), math.rad(150))
end

--------------------------------------------------------------------------------
-- BLOCKSHOT
--------------------------------------------------------------------------------
function script.BlockShot(num, targetID)

    if Spring.ValidUnitID(targetID) then

        local distance = Spring.GetUnitSeparation(unitID, targetID) or 0
        local hitTime = distance * 0.05

        return GG.OverkillPrevention_CheckBlock(
            unitID,
            targetID,
            250,
            hitTime
        )
    end

    return false
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

    local severity = (recentDamage / maxHealth) * 100

    ----------------------------------------------------------------
    -- LIGHT
    ----------------------------------------------------------------
    if severity <= 25 then

        Explode(base, SFX.NONE)
        Explode(turret, SFX.NONE)

        Explode(barrel,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 1
    end

    ----------------------------------------------------------------
    -- MEDIUM
    ----------------------------------------------------------------
    if severity <= 50 then

        Explode(base, SFX.NONE)

        Explode(turret,
            SFX.FALL
        )

        Explode(shell,
            SFX.FALL
        )

        Explode(barrel,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 2
    end

    ----------------------------------------------------------------
    -- HEAVY
    ----------------------------------------------------------------
    if severity <= 99 then

        Explode(base,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(turret,
            SFX.EXPLODE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(shell,
            SFX.EXPLODE +
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(barrel,
            SFX.EXPLODE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 3
    end

    ----------------------------------------------------------------
    -- TOTAL
    ----------------------------------------------------------------
    Explode(base,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    Explode(turret,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(shell,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(barrel,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    return 3
end