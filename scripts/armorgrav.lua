include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local base, tracks, turret, sleeve, cannon, flare =
    piece("base", "tracks", "turret", "sleeve", "cannon", "flare")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_AIM = 1
local SIG_RESTORE = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------

local restoreDelay = 3000
local stunned = false

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

local RESTORE_SPEED = math.rad(70.005495)
local AIM_SPEED = math.rad(70.005495)

local RECOIL_DISTANCE = -3
local RECOIL_SPEED = 1250
local RECOIL_RETURN_SPEED = 7.5

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()


    restoreDelay = 3000
    stunned = false

end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

function script.StartMoving()
end

function script.StopMoving()
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------

local function ExecuteRestore()

    if stunned then
        return
    end

    Turn(
        turret,
        y_axis,
        0,
        RESTORE_SPEED
    )

    Turn(
        sleeve,
        x_axis,
        0,
        RESTORE_SPEED
    )

end


local function RestoreAfterDelay()

    SetSignalMask(SIG_RESTORE)

    Sleep(restoreDelay)

    if not stunned then
        StartThread(ExecuteRestore)
    end

end

--------------------------------------------------------------------------------
-- RELOAD TIME
--------------------------------------------------------------------------------

function script.SetMaxReloadTime(reloadMS)

    restoreDelay = reloadMS * 2

end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------

function script.setStunned(state)

    stunned = state

    if not stunned then
        StartThread(ExecuteRestore)
    end

end

--------------------------------------------------------------------------------
-- AIM FROM
--------------------------------------------------------------------------------

function script.AimFromWeapon(num)

    return turret

end

--------------------------------------------------------------------------------
-- QUERY
--------------------------------------------------------------------------------

function script.QueryWeapon(num)

    return flare

end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------

function script.AimWeapon(num, heading, pitch)

    if stunned then
        return false
    end

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    --------------------------------------------------------------------------
    -- TURRET
    -- No firing arc restriction.
    -- The turret can rotate to any heading requested by the weapon.
    --------------------------------------------------------------------------

    Turn(
        turret,
        y_axis,
        heading,
        AIM_SPEED
    )

    --------------------------------------------------------------------------
    -- CANNON ELEVATION
    --------------------------------------------------------------------------

    Turn(
        sleeve,
        x_axis,
        -pitch,
        AIM_SPEED
    )

    --------------------------------------------------------------------------
    -- WAIT UNTIL AIMED
    --------------------------------------------------------------------------

    WaitForTurn(turret, y_axis)
    WaitForTurn(sleeve, x_axis)

    --------------------------------------------------------------------------
    -- START RESTORE TIMER
    --------------------------------------------------------------------------

    Signal(SIG_RESTORE)
    StartThread(RestoreAfterDelay)

    return true

end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------

function script.FireWeapon(num)

    --------------------------------------------------------------------------
    -- MUZZLE FLASH
    --------------------------------------------------------------------------

    EmitSfx(flare, 1024)

    --------------------------------------------------------------------------
    -- RECOIL
    --------------------------------------------------------------------------

    Move(
        cannon,
        z_axis,
        RECOIL_DISTANCE,
        RECOIL_SPEED
    )

    WaitForMove(cannon, z_axis)

    --------------------------------------------------------------------------
    -- RETURN
    --------------------------------------------------------------------------

    Move(
        cannon,
        z_axis,
        0,
        RECOIL_RETURN_SPEED
    )

end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

    local severity = recentDamage / maxHealth

    if severity <= 0.5 then

        ------------------------------------------------------------------------
        -- LIGHT DAMAGE DEATH
        ------------------------------------------------------------------------

        Explode(
            base,
            SFX.NONE
        )

        Explode(
            turret,
            SFX.NONE
        )

        Explode(
            sleeve,
            SFX.NONE
        )

        Explode(
            cannon,
            SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE
        )

        return 1

    else

        ------------------------------------------------------------------------
        -- HEAVY DAMAGE DEATH
        ------------------------------------------------------------------------

        Explode(
            base,
            SFX.SHATTER
        )

        Explode(
            turret,
            SFX.SHATTER
        )

        Explode(
            sleeve,
            SFX.SHATTER
        )

        Explode(
            cannon,
            SFX.SHATTER
        )

        return 2

    end

end