include "constants.lua"
include "spider_walking.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local chassis = piece "chassis"

-- LEFT LEGS
local legPivotL1, legUpperL1, legMidL1, legLowerL1, legFootL1 =
    piece "legPivotL1", piece "legUpperL1", piece "legMidL1", piece "legLowerL1", piece "legFootL1"

local legPivotL2, legUpperL2, legMidL2, legLowerL2, legFootL2 =
    piece "legPivotL2", piece "legUpperL2", piece "legMidL2", piece "legLowerL2", piece "legFootL2"

local legPivotL3, legUpperL3, legMidL3, legLowerL3, legFootL3 =
    piece "legPivotL3", piece "legUpperL3", piece "legMidL3", piece "legLowerL3", piece "legFootL3"

-- RIGHT LEGS
local legPivotR1, legUpperR1, legMidR1, legLowerR1, legFootR1 =
    piece "legPivotR1", piece "legUpperR1", piece "legMidR1", piece "legLowerR1", piece "legFootR1"

local legPivotR2, legUpperR2, legMidR2, legLowerR2, legFootR2 =
    piece "legPivotR2", piece "legUpperR2", piece "legMidR2", piece "legLowerR2", piece "legFootR2"

local legPivotR3, legUpperR3, legMidR3, legLowerR3, legFootR3 =
    piece "legPivotR3", piece "legUpperR3", piece "legMidR3", piece "legLowerR3", piece "legFootR3"
	
	

-- TURRET / WEAPONS
local turretHeadingPivot = piece "turretHeadingPivot"
local turretPitchPivot   = piece "turretPitchPivot"
local turretPitchFake    = piece "turretPitchFake"
local turret             = piece "turret"

local upperBarrel = piece "upperBarrel"
local lowerBarrel = piece "lowerBarrel"
local barrelFlare1 = piece "barrelFlare1"
local barrelFlare2 = piece "barrelFlare2"

local barrelSpinPivot = piece "barrelSpinPivot"

local rocketFlare1 = piece "rocketFlare1"
local rocketFlare2 = piece "rocketFlare2"
local rocketFlare3 = piece "rocketFlare3"

local padR          = piece "padR"
local padL          = piece "padL"

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local whichBarrel = 0
local whichMissile = 0
local Stunned = false

---stance
local STANCE_L1 = math.rad(-60)
local STANCE_R1 = math.rad(60)
local STANCE_L3 = math.rad(60)
local STANCE_R3 = math.rad(-60)

--------------------------------------------------------------------------------
-- LEG SETS (SpiderWalk expects grouped legs)
--------------------------------------------------------------------------------
-- RIGHT LEGS (Back / Mid / Front)
local br = legPivotR3
local mr = legPivotR2
local fr = legPivotR1

-- LEFT LEGS (Back / Mid / Front)
local bl = legPivotL3
local ml = legPivotL2
local fl = legPivotL1

--------------------------------------------------------------------------------
-- WALK SETTINGS (tuned defaults)
--------------------------------------------------------------------------------
local PERIOD = 0.235
local sleepTime = PERIOD * 1000

local legRaiseAngle = math.rad(30)
local legRaiseSpeed  = legRaiseAngle / PERIOD

local legForwardAngle = math.rad(20)
local legForwardTheta = math.rad(25)
local legForwardOffset = math.rad(60)
local legForwardSpeed = legForwardAngle / PERIOD

local legMiddleAngle = math.rad(20)
local legMiddleTheta = 0
local legMiddleOffset = 0
local legMiddleSpeed = legMiddleAngle / PERIOD

local legBackwardAngle = math.rad(20)
local legBackwardTheta = math.rad(-25)
local legBackwardOffset = math.rad(-60)
local legBackwardSpeed = legBackwardAngle / PERIOD

--------------------------------------------------------------------------------
-- WALK (FULL REPLACEMENT: SpiderWalk)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    while true do
        GG.SpiderWalk.walk(
            br, mr, fr,
            bl, ml, fl,

            legRaiseAngle, legRaiseSpeed,
            legRaiseSpeed,

            legForwardAngle, legForwardOffset,
            legForwardSpeed, legForwardTheta,

            legMiddleAngle, legMiddleOffset,
            legMiddleSpeed, legMiddleTheta,

            legBackwardAngle, legBackwardOffset,
            legBackwardSpeed, legBackwardTheta,

            sleepTime
        )
    end
end


--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    -- STATE INIT 
    whichBarrel = 0
    whichMissile = 0
    Stunned = false

    -- PAD OFFSET (BOS exact)
    Move(padR, y_axis, -5)
    Move(padL, y_axis, -5)

    -- neutral X stance (matches BOS StopWalking end)
    Turn(legPivotL1, y_axis, math.rad(-60))
    Turn(legPivotR1, y_axis, math.rad(60))
    Turn(legPivotL2, y_axis, 0)
    Turn(legPivotR2, y_axis, 0)
    Turn(legPivotL3, y_axis, math.rad(60))
    Turn(legPivotR3, y_axis, math.rad(-60))


    -- Optional: ensure everything else is neutral
    -- (prevents weird spawn poses)
    Turn(turretHeadingPivot, y_axis, 0)
    Turn(turretPitchFake, x_axis, 0)

    -- Smoke (correct pieces)
    StartThread(GG.Script.SmokeUnit, unitID, {chassis, turret})
end

--------------------------------------------------------------------------------
-- RESTORE LEGS
--------------------------------------------------------------------------------
local function RestoreLegs()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    GG.SpiderWalk.restoreLegs(
        br, mr, fr,
        bl, ml, fl,
        legRaiseSpeed,
        legForwardSpeed,
        legMiddleSpeed,
        legBackwardSpeed
    )

    -- FORCE BASE SPREAD AFTER RESTORE
    Turn(legPivotL1, y_axis, STANCE_L1, math.rad(90))
    Turn(legPivotR1, y_axis, STANCE_R1, math.rad(90))
    Turn(legPivotL3, y_axis, STANCE_L3, math.rad(90))
    Turn(legPivotR3, y_axis, STANCE_R3, math.rad(90))
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    StartThread(Walk)
end

function script.StopMoving()
    StartThread(RestoreLegs)
end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------
local function RestoreAfterDelay()
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Sleep(5000)
    if Stunned then return end

    Turn(turretHeadingPivot, y_axis, 0, math.rad(36))
    Turn(turretPitchFake, x_axis, 0, math.rad(30))
end

function script.AimFromWeapon(num)
    return turretPitchPivot
end

function script.QueryWeapon(num)
    if num == 1 or num == 2 then
        return (whichBarrel == 0) and barrelFlare1 or barrelFlare2
    elseif num == 4 then
        if whichMissile == 0 then return rocketFlare1 end
        if whichMissile == 1 then return rocketFlare2 end
        return rocketFlare3
    end
    return turret
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(turretHeadingPivot, y_axis, heading, math.rad(160))
    Turn(turretPitchFake, x_axis, -pitch, math.rad(135))

    WaitForTurn(turretHeadingPivot, y_axis)
    WaitForTurn(turretPitchFake, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

---Recoil
local function DoRecoil()
    if whichBarrel == 0 then
        EmitSfx(barrelFlare1, 1024)
        Move(upperBarrel, z_axis, -10, 120)
    else
        EmitSfx(barrelFlare2, 1024)
        Move(lowerBarrel, z_axis, -10, 120)
    end

    whichBarrel = 1 - whichBarrel

    -- restore after short delay (non-blocking)
    StartThread(function()
        Sleep(150)
        Move(upperBarrel, z_axis, 0, 20)
        Move(lowerBarrel, z_axis, 0, 20)
    end)
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
local function FireCommon()
    if whichBarrel == 0 then
        EmitSfx(barrelFlare1, 1024)
        Move(upperBarrel, z_axis, -10, 120)
        whichBarrel = 1
    else
        EmitSfx(barrelFlare2, 1024)
        Move(lowerBarrel, z_axis, -10, 120)
        whichBarrel = 0
    end

    Sleep(700)

    Move(upperBarrel, z_axis, 0, 6)
    Move(lowerBarrel, z_axis, 0, 6)
end



function script.Shot(num)
    if num == 1 or num == 2 then
        DoRecoil()
    end
end


function script.FireWeapon(num)
    if num == 4 then
        Spin(barrelSpinPivot, y_axis, math.rad(900))

        if whichMissile == 0 then
            EmitSfx(rocketFlare1, 1025)
        elseif whichMissile == 1 then
            EmitSfx(rocketFlare2, 1025)
        else
            EmitSfx(rocketFlare3, 1025)
        end

        whichMissile = (whichMissile + 1) % 3

        StopSpin(barrelSpinPivot, y_axis, math.rad(45))
    end
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(stun)
    Stunned = stun
    if not stun then
        StartThread(RestoreAfterDelay)
    end
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    ----------------------------------------------------------------
    -- LIGHT DEATH (mostly intact collapse)
    ----------------------------------------------------------------
    if severity <= 0.50 then
        Explode(chassis, SFX.NONE)
        Explode(turret, SFX.NONE)

        Explode(turretHeadingPivot, SFX.NONE)
        Explode(turretPitchFake, SFX.NONE)

        Explode(legPivotL1, SFX.NONE)
        Explode(legPivotL2, SFX.NONE)
        Explode(legPivotL3, SFX.NONE)

        Explode(legPivotR1, SFX.NONE)
        Explode(legPivotR2, SFX.NONE)
        Explode(legPivotR3, SFX.NONE)

        Explode(upperBarrel, SFX.NONE)
        Explode(lowerBarrel, SFX.NONE)

        return 1
    end

    ----------------------------------------------------------------
    -- HEAVY DEATH (full structural failure)
    ----------------------------------------------------------------
    Explode(chassis, SFX.SHATTER + SFX.SMOKE)

    Explode(turret, SFX.FALL + SFX.SMOKE + SFX.FIRE)
    Explode(turretHeadingPivot, SFX.FALL)
    Explode(turretPitchFake, SFX.FALL)

    Explode(legPivotL1, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
    Explode(legPivotL2, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
    Explode(legPivotL3, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)

    Explode(legPivotR1, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
    Explode(legPivotR2, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)
    Explode(legPivotR3, SFX.FALL + SFX.SMOKE + SFX.EXPLODE_ON_HIT)

    Explode(upperBarrel, SFX.FALL + SFX.SMOKE)
    Explode(lowerBarrel, SFX.FALL + SFX.SMOKE)

    Explode(barrelSpinPivot, SFX.FIRE + SFX.SMOKE)

    Explode(rocketFlare1, SFX.EXPLODE)
    Explode(rocketFlare2, SFX.EXPLODE)
    Explode(rocketFlare3, SFX.EXPLODE)

    return 2
end