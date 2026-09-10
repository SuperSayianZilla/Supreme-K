include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local turretBase, hip, chassis, turret, topPlate, turretSlide =
    piece('turretBase','hip','chassis','turret','topPlate','turretSlide')

local rUpperLeg, rTibio, rLowerLeg, rFoot, rLegJoint =
    piece('rUpperLeg','rTibio','rLowerLeg','rFoot','rLegJoint')

local lUpperLeg, lTibio, lLowerLeg, lFoot, lLegJoint =
    piece('lUpperLeg','lTibio','lLowerLeg','lFoot','lLegJoint')

local leftFlare, rightFlare, cannisterFlare =
    piece('leftFlare','rightFlare','cannisterFlare')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE    = 1
local SIG_AIM     = 2
local SIG_RESTORE = 4
local SIG_TRANS   = 8

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 5
local whichBarrel = 0
local deployed = false
local opening = false
local stunned = false

local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local spd = 2.5 / animSpeed

    local function Blend()
        return 22 / spd   -- smoother blending
    end

    while isMoving do

        ------------------------------------------------------------------
        -- FRAME 1 (RIGHT FOOT PLANTED)
        ------------------------------------------------------------------

        -- RIGHT LEG (PLANTED - LOCKED & SAFE)
        Turn(rUpperLeg, x_axis, math.rad(-32), 2.5/spd)
        Turn(rLowerLeg, x_axis, math.rad(22), 2.5/spd)
        Turn(rFoot, x_axis, math.rad(5), 1.5/spd) -- slight heel up (NO CLIP)

        -- LEFT LEG (SWING BACK WITH LIFT)
        Turn(lUpperLeg, x_axis, math.rad(60), 3/spd)
        Turn(lLowerLeg, x_axis, math.rad(-28), 3/spd)
        Turn(lFoot, x_axis, math.rad(-25), 3/spd)

        -- ADD LIFT TO SWING LEG
        Move(lLegJoint, y_axis, 1.2, Blend())

        -- HIP (NEVER GO NEGATIVE)
        Move(hip, y_axis, 0.3, Blend())   -- ALWAYS ABOVE 0
        Move(hip, z_axis, -0.1, Blend())

        Turn(hip, z_axis, math.rad(-1), 2/spd)
        Turn(hip, y_axis, math.rad(1), 2/spd)

        Sleep(50 * animSpeed)

        ------------------------------------------------------------------
        -- FRAME 2 (TRANSITION)
        ------------------------------------------------------------------

        -- REMOVE LIFT SMOOTHLY
        Move(lLegJoint, y_axis, 0, Blend())

        Turn(rUpperLeg, x_axis, math.rad(-10), 2/spd)
        Turn(lUpperLeg, x_axis, math.rad(15), 2/spd)

        Turn(rLowerLeg, x_axis, math.rad(5), 2/spd)
        Turn(lLowerLeg, x_axis, math.rad(-10), 2/spd)

        Turn(rFoot, x_axis, math.rad(4), 2/spd)
        Turn(lFoot, x_axis, math.rad(-5), 2/spd)

        Move(hip, y_axis, 0.35, Blend())
        Move(hip, z_axis, 0, Blend())

        Sleep(50 * animSpeed)

        ------------------------------------------------------------------
        -- FRAME 3 (LEFT FOOT PLANTED)
        ------------------------------------------------------------------

        -- LEFT LEG (PLANTED)
        Turn(lUpperLeg, x_axis, math.rad(-32), 2.5/spd)
        Turn(lLowerLeg, x_axis, math.rad(22), 2.5/spd)
        Turn(lFoot, x_axis, math.rad(5), 1.5/spd)

        -- RIGHT LEG (SWING BACK WITH LIFT)
        Turn(rUpperLeg, x_axis, math.rad(60), 3/spd)
        Turn(rLowerLeg, x_axis, math.rad(-28), 3/spd)
        Turn(rFoot, x_axis, math.rad(-25), 3/spd)

        -- LIFT
        Move(rLegJoint, y_axis, 1.2, Blend())

        Move(hip, y_axis, 0.3, Blend())
        Move(hip, z_axis, 0.1, Blend())

        Turn(hip, z_axis, math.rad(1), 2/spd)
        Turn(hip, y_axis, math.rad(-1), 2/spd)

        Sleep(50 * animSpeed)

        ------------------------------------------------------------------
        -- FRAME 4 (TRANSITION)
        ------------------------------------------------------------------

        Move(rLegJoint, y_axis, 0, Blend())

        Turn(lUpperLeg, x_axis, math.rad(-10), 2/spd)
        Turn(rUpperLeg, x_axis, math.rad(15), 2/spd)

        Turn(lLowerLeg, x_axis, math.rad(5), 2/spd)
        Turn(rLowerLeg, x_axis, math.rad(-10), 2/spd)

        Turn(lFoot, x_axis, math.rad(4), 2/spd)
        Turn(rFoot, x_axis, math.rad(-5), 2/spd)

        Move(hip, y_axis, 0.35, Blend())
        Move(hip, z_axis, 0, Blend())

        Sleep(50 * animSpeed)
    end
end
local function StopWalking()
    Turn(chassis, x_axis, 0, 5)
    Move(hip, y_axis, 0, 8)

    for _, p in ipairs({
        lFoot, rFoot,
        lLowerLeg, rLowerLeg,
        lUpperLeg, rUpperLeg,
        lTibio, rTibio,
        lLegJoint, rLegJoint
    }) do
        Turn(p, x_axis, 0, 6)
        Turn(p, y_axis, 0, 6)
        Turn(p, z_axis, 0, 6)
    end
end

--------------------------------------------------------------------------------
-- DEPLOY / UNDEPLOY
--------------------------------------------------------------------------------
local function Open()
    if opening then return end

    Signal(SIG_TRANS)
    SetSignalMask(SIG_TRANS)

    opening = true

    Turn(topPlate, x_axis, 0, math.rad(90))
    WaitForTurn(topPlate, x_axis)

    Move(turret, z_axis, 0, 8)
    WaitForMove(turret, z_axis)

    deployed = true
end

local function Close()
    Signal(SIG_TRANS)
    SetSignalMask(SIG_TRANS)

    deployed = false
    opening = false

    Move(turret, z_axis, -4, 6)
    WaitForMove(turret, z_axis)

    Turn(topPlate, x_axis, math.rad(55), math.rad(45))
end

--------------------------------------------------------------------------------
-- RESTORE
--------------------------------------------------------------------------------
local function RestoreAfterDelay()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(3000)
    if stunned then return end

    StartThread(Close)

    Turn(turretBase, x_axis, math.rad(-25), math.rad(45))
    Turn(chassis, y_axis, 0, math.rad(45))
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Move(chassis, y_axis, 0.5)

    Turn(topPlate, x_axis, math.rad(55))
    Turn(turretBase, x_axis, math.rad(-25))
    Move(turret, z_axis, -4)

    whichBarrel = 0
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    if not isMoving then
        isMoving = true
        StartThread(Walk)
    end
end

function script.StopMoving()
    isMoving = false
    Signal(SIG_MOVE)
    StopWalking()
end

--------------------------------------------------------------------------------
-- AIMING
--------------------------------------------------------------------------------
function script.AimFromWeapon()
    return turretBase
end

function script.QueryWeapon()
    if whichBarrel == 0 then
        return leftFlare
    else
        return rightFlare
    end
end

function script.AimWeapon(_, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Signal(SIG_RESTORE)
    StartThread(RestoreAfterDelay)
    StartThread(Open)

    Turn(chassis, y_axis, heading, math.rad(180))

    local clampedPitch = math.max(math.rad(-45), math.min(0, -pitch))
    Turn(turretBase, x_axis, clampedPitch, math.rad(165))

    WaitForTurn(chassis, y_axis)
    WaitForTurn(turretBase, x_axis)

    return deployed
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon()
    Move(turret, z_axis, -5, 20)
    WaitForMove(turret, z_axis)
    Move(turret, z_axis, 0, 5)

    if whichBarrel == 0 then
        EmitSfx(leftFlare, 1024)
        whichBarrel = 1
    else
        EmitSfx(rightFlare, 1024)
        whichBarrel = 0
    end
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(state)
    stunned = state
    if not stunned then
        StartThread(RestoreAfterDelay)
    end
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.25 then
        Explode(chassis, SFX.NONE)
        Explode(turretBase, SFX.NONE)
        return 1
    elseif severity <= 0.5 then
        Explode(chassis, SFX.FALL + SFX.SMOKE)
        Explode(turret, SFX.FALL)
        return 2
    else
        Explode(chassis, SFX.SHATTER)
        Explode(turret, SFX.FIRE + SFX.SMOKE)
        return 3
    end
end