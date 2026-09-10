include "constants.lua"
include "reliableStartMoving.lua"

--------------------------------------------------------------------------------
-- PIECES (your original ones mapped into 4-leg system)
--------------------------------------------------------------------------------
local base, torso, lshoulder, rshoulder, lsleeve, rsleeve, lbarrel,
      heatraycoil, torsocoil,
      flthigh, frthigh, blthigh, brthigh,
      flleg, frleg, blleg, brleg,
      flfoot, frfoot, blfoot, brfoot,
      torsopivot, aimx,
      lflare1, lflare2, rflare =
    piece(
        "base","torso","lshoulder","rshoulder","lsleeve","rsleeve","lbarrel",
        "heatraycoil","torsocoil",
        "flthigh","frthigh","blthigh","brthigh",
        "flleg","frleg","blleg","brleg",
        "flfoot","frfoot","blfoot","brfoot",
        "torsopivot","aimx",
        "lflare1","lflare2","rflare"
    )

--------------------------------------------------------------------------------
-- MAP YOUR LEGS TO SIMPLE SYSTEM
--------------------------------------------------------------------------------
local leg1 = frthigh -- front right
local leg2 = brthigh -- back right
local leg3 = blthigh -- back left
local leg4 = flthigh -- front left

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM1 = 2
local SIG_AIM2 = 4

--------------------------------------------------------------------------------
-- WALK CONSTANTS (from reference)
--------------------------------------------------------------------------------
local PACE = 2.6

local legRaiseSpeed = math.rad(45)*PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50)*PACE

local legForwardSpeed = math.rad(35)*PACE
local legForwardAngle = math.rad(-25)
local legBackwardSpeed = math.rad(35)*PACE
local legBackwardAngle = math.rad(35)
local legBackwardAngleMinor = math.rad(30)


--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local moving = false
local gun_1 = false
local torsoHeading = 0


--------------------------------------------------------------------------------
-- WALK (RESET-ALIGNED TETRAPOD)
--------------------------------------------------------------------------------

local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while true do

        ------------------------------------------------------------
        -- PHASE A: FL (leg4) + BR (leg2)
        ------------------------------------------------------------

        -- lift
        Turn(leg4, z_axis,  legRaiseAngle, legRaiseSpeed)
        Turn(leg2, z_axis, -legRaiseAngle, legRaiseSpeed)

        -- swing forward (these two were already correct)
       Turn(leg4, y_axis, math.rad(-40) + legForwardAngle, legForwardSpeed)
       Turn(leg2, y_axis, math.rad(-40) - legForwardAngle, legForwardSpeed)

        -- support legs (keep stable, DO NOT fight stance)
        Turn(leg1, y_axis, math.rad(40 - legBackwardAngleMinor), legBackwardSpeed)
        Turn(leg3, y_axis, math.rad(40 - legBackwardAngleMinor), legBackwardSpeed)

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)

        -- plant
        Turn(leg4, z_axis, 0, legLowerSpeed)
        Turn(leg2, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)

        ------------------------------------------------------------
        -- PHASE B: FR (leg1) + BL (leg3)  🔧 FIXED PAIR
        ------------------------------------------------------------

        -- lift (FR needed inversion correction already correct)
        Turn(leg1, z_axis, -legRaiseAngle, legRaiseSpeed)
        Turn(leg3, z_axis,  legRaiseAngle, legRaiseSpeed)

        -- FIX: BL was inverted — swap its swing direction
        Turn(leg1, y_axis, math.rad(40) - legForwardAngle, legForwardSpeed)
        Turn(leg3, y_axis, math.rad(40) + legForwardAngle, legForwardSpeed)
		
        -- support correction (match corrected BL behavior)
        Turn(leg4, y_axis, math.rad(-40 + legBackwardAngleMinor), legBackwardSpeed)
        Turn(leg2, y_axis, math.rad(-40 + legBackwardAngleMinor), legBackwardSpeed)

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

        -- plant
        Turn(leg1, z_axis, 0, legLowerSpeed)
        Turn(leg3, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

    end
end

--------------------------------------------------------------------------------
-- RESET POSE
--------------------------------------------------------------------------------
local function ResetLegs()
    local speed = math.rad(60)

    ------------------------------------------------------------
    -- X / TETRAPOD BASE STANCE (diagonal balance)
    ------------------------------------------------------------

    -- front-right + back-left pair
    Turn(leg1, y_axis, math.rad(40), speed)   -- FR out
    Turn(leg3, y_axis, math.rad(40), speed)   -- BL support side

    -- front-left + back-right pair
    Turn(leg4, y_axis, math.rad(-40), speed)  -- FL out
    Turn(leg2, y_axis, math.rad(-40), speed)  -- BR support side

    ------------------------------------------------------------
    -- slight stabilization tilt (optional but recommended)
    ------------------------------------------------------------
    Turn(leg1, z_axis, math.rad(5), speed)
    Turn(leg2, z_axis, math.rad(-5), speed)
    Turn(leg3, z_axis, math.rad(-5), speed)
    Turn(leg4, z_axis, math.rad(5), speed)
end
--------------------------------------------------------------------------------
-- MOVE CONTROL
--------------------------------------------------------------------------------
function script.StartMoving()
    moving = true
    StartThread(Walk)
end

function script.StopMoving()
    Signal(SIG_MOVE)
    moving = false
    StartThread(ResetLegs)
end

--------------------------------------------------------------------------------
-- AIM PRIMARY
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
    return aimx
end

function script.QueryWeapon1()
    return rflare
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIM1)
    SetSignalMask(SIG_AIM1)

    torsoHeading = heading

    Turn(torso, y_axis, heading, math.rad(200))
    Turn(aimx, x_axis, -pitch, math.rad(200))

    WaitForTurn(torso, y_axis)
    WaitForTurn(aimx, x_axis)

    return true
end

function script.FireWeapon1()
    -- add recoil/light if needed
end

--------------------------------------------------------------------------------
-- AIM SECONDARY
--------------------------------------------------------------------------------
function script.AimFromWeapon2()
    return lsleeve
end

function script.QueryWeapon2()
    return gun_1 and lflare1 or lflare2
end

function script.AimWeapon2(heading, pitch)
    Signal(SIG_AIM2)
    SetSignalMask(SIG_AIM2)

    local diff = heading - torsoHeading

    if diff < math.rad(120) and diff > math.rad(-60) then
        Turn(lshoulder, y_axis, diff/2, math.rad(90))
        Turn(lsleeve, y_axis, diff/2, math.rad(90))
        return true
    end

    Turn(lshoulder, y_axis, 0, math.rad(90))
    Turn(lsleeve, y_axis, 0, math.rad(90))
    return false
end

function script.FireWeapon2()
    Move(lbarrel, z_axis, -6)
    Move(lbarrel, z_axis, 0, 3)

    gun_1 = not gun_1
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(lflare1)
    Hide(lflare2)
    Hide(aimx)
    Hide(torsopivot)

    -- default stance (wide X like you wanted)
    Turn(flthigh, y_axis, math.rad(-50))
    Turn(frthigh, y_axis, math.rad(50))
    Turn(blthigh, y_axis, math.rad(50))
    Turn(brthigh, y_axis, math.rad(-50))

    Turn(lshoulder, z_axis, math.rad(20))
    Turn(rshoulder, z_axis, math.rad(-20))
end

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.25 then
        -- LIGHT: unit just dies, mostly intact
        Explode(torso, SFX.SMOKE)
        Explode(base, SFX.NONE)
        return 1

    elseif severity <= 0.5 then
        -- MEDIUM: upper body breaks, legs remain
        Explode(torso, SFX.FALL + SFX.SMOKE)
        Explode(lshoulder, SFX.FALL)
        Explode(rshoulder, SFX.FALL)
        Explode(lbarrel, SFX.FALL)
        return 2

    else
        -- HEAVY: full destruction, proper mech breakup
        Explode(torso, SFX.SHATTER)
        Explode(base, SFX.EXPLODE)

        -- legs detach instead of all shattering
        Explode(frthigh, SFX.FALL)
        Explode(flthigh, SFX.FALL)
        Explode(brthigh, SFX.FALL)
        Explode(blthigh, SFX.FALL)

        -- energy bits pop
        Explode(torsocoil, SFX.FIRE + SFX.SMOKE)
        Explode(heatraycoil, SFX.FIRE + SFX.SMOKE)

        return 3
    end
end