include "constants.lua"
include "reliableStartMoving.lua"

------------------------------------------------------------
-- PIECES
------------------------------------------------------------
local pelvis = piece "pelvis"
local torso = piece "torso"
local aimy1 = piece "aimy1"
local arm = piece "arm"
local nanogun = piece "nanogun"

-- legs
local leg1_FR = piece "leg1_FR"
local leg2_FR = piece "leg2_FR"
local foot_FR = piece "foot_FR"

local leg1_FL = piece "leg1_FL"
local leg2_FL = piece "leg2_FL"
local foot_FL = piece "foot_FL"

local leg1_BR = piece "leg1_BR"
local leg2_BR = piece "leg2_BR"
local foot_BR = piece "foot_BR"

local leg1_BL = piece "leg1_BL"
local leg2_BL = piece "leg2_BL"
local foot_BL = piece "foot_BL"

local flare = piece "nanogun"

------------------------------------------------------------
-- SIGNALS
------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2
local SIG_RESTORE = 4

------------------------------------------------------------
-- STATE
------------------------------------------------------------
local isOpen = false

------------------------------------------------------------
-- LEG MAP (FIXED)
------------------------------------------------------------
local leg1 = leg1_FR -- front right
local leg2 = leg1_BR -- back right (FIXED BEHAVIOR BELOW)
local leg3 = leg1_BL -- back left
local leg4 = leg1_FL -- front left


--------------------------------------------------------------------------------
-- WALK CONSTANTS (from reference)
--------------------------------------------------------------------------------
local PACE = 3.85

local legRaiseSpeed = math.rad(45)*PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50)*PACE

local legForwardSpeed = math.rad(40)*PACE
local legForwardAngle = math.rad(-35)
local legBackwardSpeed = math.rad(20)*PACE
local legBackwardAngle = math.rad(25)
local legBackwardAngleMinor = math.rad(10)

local REST_Y = math.rad(40)


--------------------------------------------------------------------------------
-- WALK (NEW SYSTEM)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while true do
        -- phase 1
        Turn(leg4, z_axis, legRaiseAngle, legRaiseSpeed)
        Turn(leg4, y_axis, legForwardAngle, legForwardSpeed)

        Turn(leg3, y_axis, legBackwardAngle, legBackwardSpeed)

        Turn(leg1, y_axis, -legBackwardAngleMinor, legBackwardSpeed)

        Turn(leg2, z_axis, -legRaiseAngle, legRaiseSpeed)
        Turn(leg2, y_axis, 0, legForwardSpeed)

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg4, y_axis)

        Turn(leg4, z_axis, 0, legLowerSpeed)
        Turn(leg2, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg4, z_axis)

        -- phase 2
        Turn(leg4, y_axis, legBackwardAngleMinor, legBackwardSpeed)

        Turn(leg3, z_axis, legRaiseAngle, legRaiseSpeed)
        Turn(leg3, y_axis, 0, legForwardSpeed)

        Turn(leg1, z_axis, -legRaiseAngle, legRaiseSpeed)
        Turn(leg1, y_axis, -legForwardAngle, legForwardSpeed)

        Turn(leg2, y_axis, -legBackwardAngle, legBackwardSpeed)

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg1, y_axis)

        Turn(leg3, z_axis, 0, legLowerSpeed)
        Turn(leg1, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg3, z_axis)
    end
end


------------------------------------------------------------
-- STOP WALK
------------------------------------------------------------
local function StopWalk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local r = 5

    -- return to stable X stance
    Turn(leg1, y_axis,  REST_Y, r)
    Turn(leg2, y_axis, -REST_Y, r)
    Turn(leg3, y_axis,  REST_Y, r)
    Turn(leg4, y_axis, -REST_Y, r)

    -- clear swing
    Turn(leg1, z_axis, 0, r)
    Turn(leg2, z_axis, 0, r)
    Turn(leg3, z_axis, 0, r)
    Turn(leg4, z_axis, 0, r)

    Turn(leg1, x_axis, 0, r)
    Turn(leg2, x_axis, 0, r)
    Turn(leg3, x_axis, 0, r)
    Turn(leg4, x_axis, 0, r)
end

------------------------------------------------------------
-- RECOIL
------------------------------------------------------------
local function Recoil()
    Move(nanogun, z_axis, -4, 25)
    Move(pelvis, y_axis, -0.6, 10)

    Sleep(90)

    Move(nanogun, z_axis, 0, 8)
    Move(pelvis, y_axis, 0, 6)
end

------------------------------------------------------------
-- DEPLOY / UNDEPLOY (BOS MATCH)
------------------------------------------------------------
local restoreDelay = 3000

local function Open()
    if isOpen then return end
    isOpen = true

    Turn(nanogun, x_axis, math.rad(-15), math.rad(180))
    Turn(arm, x_axis, math.rad(15), math.rad(180))
end

local function Close()
    if not isOpen then return end
    isOpen = false

    Turn(arm, x_axis, math.rad(-50), math.rad(120))
    Turn(nanogun, x_axis, math.rad(65), math.rad(120))
end

local function RestoreAfterDelay()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(restoreDelay)
    Close()
end

------------------------------------------------------------
-- AIM
------------------------------------------------------------
function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Open()

    Turn(aimy1, y_axis, heading, math.rad(180))
    Turn(nanogun, x_axis, -pitch, math.rad(120)) -- 🔧 better than arm

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(nanogun, x_axis)

    StartThread(RestoreAfterDelay)

    return true
end

function script.AimFromWeapon()
    return nanogun
end

function script.QueryWeapon()
    return flare
end

------------------------------------------------------------
-- FIRE
------------------------------------------------------------
function script.FireWeapon(num)
    Open()
    EmitSfx(flare, 1024)
    StartThread(Recoil)
    StartThread(RestoreAfterDelay)
end

------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------
function script.StartMoving()
    StartThread(Walk)
end

function script.StopMoving()
    StartThread(StopWalk)
end

------------------------------------------------------------
-- CREATE
------------------------------------------------------------
function script.Create()
    -- X stance
    Turn(leg1_FR, y_axis, math.rad(40))
    Turn(leg1_FL, y_axis, math.rad(-40))
    Turn(leg1_BL, y_axis, math.rad(40))
    Turn(leg1_BR, y_axis, math.rad(-40))

    Turn(arm, x_axis, math.rad(-50))
    Turn(nanogun, x_axis, math.rad(65))
end

------------------------------------------------------------
-- KILLED
------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    Explode(pelvis, SFX.SHATTER)
    Explode(torso, SFX.FALL)
    Explode(nanogun, SFX.FIRE)
    return 1
end