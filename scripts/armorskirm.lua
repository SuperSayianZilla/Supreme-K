include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, btrack, fltrack, frtrack =
    piece('base', 'btrack', 'fltrack', 'frtrack')

local aimpoint, armor, turret, sleeve =
    piece('aimpoint', 'armor', 'turret', 'sleeve')

local lrail, rrail, flare =
    piece('lrail', 'rrail', 'flare')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE   = 1
local SIG_AIM    = 2
local SIG_IDLE   = 8
local SIG_SHOOT  = 16

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local restoreDelay = 3000

local wpn1LastHead = 1000000
local shotCount = 0

local fired1 = false
local fired2 = false
local aiming = false

local stunned = false
local oldHeading = 0


--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {
    base,
    turret,
    sleeve,
}

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

    oldHeading = Spring.GetUnitHeading(unitID) or 0

    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
    StartThread(SteeringThread)
end

--------------------------------------------------------------------------------
-- STEERING
--------------------------------------------------------------------------------
function SteeringThread()

    while true do

        local heading = Spring.GetUnitHeading(unitID) or 0
        local steer = (heading - oldHeading) * 0.0004

        Turn(fltrack, y_axis, steer, math.rad(120))
        Turn(frtrack, y_axis, steer, math.rad(120))

        oldHeading = heading

        Sleep(66)
    end
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
end

function script.StopMoving()
end

--------------------------------------------------------------------------------
-- RESET FIRE
--------------------------------------------------------------------------------
local function ResetFire()

    Signal(SIG_SHOOT)
    SetSignalMask(SIG_SHOOT)

    fired1 = true
    fired2 = true

    Sleep(3000)

    fired2 = false

    Sleep(3000)

    fired1 = false
end

--------------------------------------------------------------------------------
-- RESET AIMING
--------------------------------------------------------------------------------
local function ResetAiming()

    Signal(SIG_IDLE)
    SetSignalMask(SIG_IDLE)

    aiming = true

    Sleep(500)

    aiming = false
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function ExecuteRestoreAfterDelay()

    if stunned then
        return
    end

    fired1 = false
    fired2 = false

    Turn(turret, y_axis, 0, math.rad(50))
    Turn(sleeve, x_axis, 0, math.rad(50))

    wpn1LastHead = 1000000
end

local function RestoreAfterDelay()

    SetSignalMask(SIG_AIM)

    Sleep(restoreDelay)

    StartThread(ExecuteRestoreAfterDelay)
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.setStunned(state)

    stunned = state

    if not stunned then
        StartThread(ExecuteRestoreAfterDelay)
    end
end

--------------------------------------------------------------------------------
-- WEAPON 1
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
    return aimpoint
end

function script.QueryWeapon(num)
    return flare
end

function script.AimWeapon(num, heading, pitch)

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    StartThread(ResetAiming)

    Turn(turret, y_axis, heading, math.rad(120))
    Turn(sleeve, x_axis, -pitch, math.rad(120))

    if math.abs(wpn1LastHead - heading) > math.rad(2) then

        wpn1LastHead = 1000000

        WaitForTurn(turret, y_axis)
        WaitForTurn(sleeve, x_axis)
    end

    wpn1LastHead = heading

    StartThread(RestoreAfterDelay)

    if num == 1 and fired1 then
        return false
    end

    if num == 2 and fired2 then
        return false
    end

    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon(num)

    StartThread(ResetFire)

    shotCount = shotCount + 1

    EmitSfx(flare, 1024)

    if GG and GG.Script and GG.Script.UnitScriptLight then
        GG.Script.UnitScriptLight(unitID, 1, shotCount)
    end

    local recoil = (num == 1) and -4 or -6

    Move(lrail, z_axis, recoil)
    Move(rrail, z_axis, recoil)

    Move(lrail, x_axis, 1)
    Move(rrail, x_axis, -1)

    Sleep(300)

    Move(lrail, z_axis, 0, 6.5)
    Move(rrail, z_axis, 0, 6.5)

    Move(lrail, x_axis, 0, 6.5)
    Move(rrail, x_axis, 0, 6.5)
end

--------------------------------------------------------------------------------
-- SWEET SPOT
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
    return aimpoint
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

    local severity = (recentDamage / maxHealth) * 100

    if severity <= 25 then

        Explode(base, SFX.NONE)
        Explode(turret, SFX.NONE)
        Explode(sleeve, SFX.NONE)

        Explode(rrail,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 1
    end

    if severity <= 50 then

        Explode(base, SFX.NONE)

        Explode(turret,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        Explode(sleeve,
            SFX.FALL
        )

        Explode(rrail,
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL
        )

        return 2
    end

    Explode(base,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    Explode(turret,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    Explode(sleeve,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.FALL
    )

    Explode(rrail,
        SFX.EXPLODE +
        SFX.FIRE +
        SFX.SMOKE +
        SFX.FALL
    )

    return 3
end