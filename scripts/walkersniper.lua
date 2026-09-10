include "constants.lua"
include "reliableStartMoving.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local chassis = piece "chassis"
local innerChassis = piece "innerChassis"
local innerChassisBone = piece "innerChassisBone"

-- legs
local fl_pivot = piece "frontLeftLegPivot"
local fl_upper = piece "frontLeftUpperLeg"
local fl_lower = piece "frontLeftLowerLeg"

local fr_pivot = piece "frontRightLegPivot"
local fr_upper = piece "frontRightUpperLeg"
local fr_lower = piece "frontRightLowerLeg"

local bl_pivot = piece "backLeftLegPivot"
local bl_upper = piece "backLeftUpperLeg"
local bl_lower = piece "backLeftLowerLeg"

local br_pivot = piece "backRightLegPivot"
local br_upper = piece "backRightUpperLeg"
local br_lower = piece "backRightLowerLeg"

-- weapon flares (converted from nano)
local flare1 = piece "nanoFlare1"
local flare2 = piece "nanoFlare2"

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- MAP YOUR LEGS TO SIMPLE SYSTEM
--------------------------------------------------------------------------------
local leg1 = fr_pivot -- front right
local leg2 = br_pivot -- back right
local leg3 = bl_pivot -- back left
local leg4 = fl_pivot -- front left



--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local moving = false


local recoilPower = 6
local recoilReturnSpeed = 2.5
--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function rad(x) return math.rad(x) end



local PACE = 1.6

local legRaiseSpeed = math.rad(45)*PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50)*PACE

local legForwardSpeed = math.rad(35)*PACE
local legForwardAngle = math.rad(-35)
local legBackwardSpeed = math.rad(35)*PACE
local legBackwardAngle = math.rad(35)
local legBackwardAngleMinor = math.rad(35)



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
-- ENGINE CALLS
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
-- AIMING
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
    return innerChassisBone
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(innerChassisBone, y_axis, heading, math.rad(180))
    Turn(innerChassisBone, x_axis, -pitch, math.rad(120))

    WaitForTurn(innerChassisBone, y_axis)
    WaitForTurn(innerChassisBone, x_axis)

    return true
end
--------------------------------------------------------------------------------
-- FIRE (2-point alternating, matches 1 weapon burst timing)
--------------------------------------------------------------------------------
function script.QueryWeapon(num)
    if num == 1 then
        return flare1
    else
        return flare2
    end
end




local recoiling = false

local function Recoil()
    if recoiling then
        return
    end
    recoiling = true

    Move(innerChassisBone, z_axis, -recoilPower, 20)
    Move(chassis, y_axis, -recoilPower * 0.15, 10)

    Sleep(60)

    Move(innerChassisBone, z_axis, 0, recoilReturnSpeed)
    Move(chassis, y_axis, 0, recoilReturnSpeed)

    recoiling = false
end

function script.Shot(num)
    StartThread(Recoil)
  
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    -- X stance
    Turn(fl_pivot, y_axis, rad(-40))
    Turn(fr_pivot, y_axis, rad(40))
    Turn(bl_pivot, y_axis, rad(40))
    Turn(br_pivot, y_axis, rad(-40))

    Hide(flare1)
    Hide(flare2)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.25 then
        ----------------------------------------------------------------
        -- LIGHT: shutdown, intact wreck
        ----------------------------------------------------------------
        Explode(innerChassis, SFX.SMOKE)
        Explode(chassis, SFX.NONE)

        -- legs stay fully intact
        Explode(fl_pivot, SFX.NONE)
        Explode(fr_pivot, SFX.NONE)
        Explode(bl_pivot, SFX.NONE)
        Explode(br_pivot, SFX.NONE)

        return 1

    elseif severity <= 0.5 then
        ----------------------------------------------------------------
        -- MEDIUM: core exposed, partial collapse
        ----------------------------------------------------------------
        Explode(innerChassis, SFX.FALL + SFX.SMOKE)
        Explode(innerChassisBone, SFX.FALL)

        -- outer armor breaks off
        Explode(chassis, SFX.FALL)

        -- front legs start to give out
        Explode(fl_pivot, SFX.FALL)
        Explode(fr_pivot, SFX.FALL)

        return 2

    else
        ----------------------------------------------------------------
        -- HEAVY: full collapse + internal failure
        ----------------------------------------------------------------
        Explode(chassis, SFX.SHATTER)
        Explode(innerChassis, SFX.FIRE + SFX.SMOKE)
        Explode(innerChassisBone, SFX.EXPLODE)

        -- all legs detach cleanly (walker collapse feel)
        Explode(fl_pivot, SFX.FALL)
        Explode(fr_pivot, SFX.FALL)
        Explode(bl_pivot, SFX.FALL)
        Explode(br_pivot, SFX.FALL)

        return 3
    end
end