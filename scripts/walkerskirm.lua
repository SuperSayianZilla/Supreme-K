include "constants.lua"
include "reliableStartMoving.lua"

------------------------------------------------------------
-- PIECES
------------------------------------------------------------
local base, turret, arm, sleeve, barrel =
    piece("base", "arm", "arm", "sleeve", "barrel")

local armorl, armorr, armorf = piece("armorl", "armorr", "armorf")

local thighbl, legbl, footbl = piece("thighbl", "legbl", "footbl")
local thighbr, legbr, footbr = piece("thighbr", "legbr", "footbr")
local thighfl, legfl, footfl = piece("thighfl", "legfl", "footfl")
local thighfr, legfr, footfr = piece("thighfr", "legfr", "footfr")

local flare = {}
for i = 1, 6 do
    flare[i] = piece("flare"..i)
end

------------------------------------------------------------
-- SIGNALS
------------------------------------------------------------
local SIG_MOVE   = 1
local SIG_AIM    = 2
local SIG_OPEN   = 8
local SIG_RESTORE= 16

------------------------------------------------------------
-- STATE
------------------------------------------------------------
local isMoving = false
local isOpen = false
local pod = 0

------------------------------------------------------------
-- CREATE
------------------------------------------------------------
function script.Create()
    Turn(thighfl, y_axis, math.rad(-25), 3)
    Turn(thighfr, y_axis, math.rad(25), 3)
    Turn(thighbl, y_axis, math.rad(25), 3)
    Turn(thighbr, y_axis, math.rad(-25), 3)
end

--------------------------------------------------------------------------------
-- MAP YOUR LEGS TO SIMPLE SYSTEM
--------------------------------------------------------------------------------
local leg1 = thighfr -- front right
local leg2 = thighbr -- back right
local leg3 = thighbl -- back left
local leg4 = thighfl -- front left


--------------------------------------------------------------------------------
-- WALK CONSTANTS (from reference)
--------------------------------------------------------------------------------
local PACE = 2.85

local legRaiseSpeed = math.rad(45)*PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50)*PACE

local legForwardSpeed = math.rad(40)*PACE
local legForwardAngle = math.rad(-20)
local legBackwardSpeed = math.rad(35)*PACE
local legBackwardAngle = math.rad(45)
local legBackwardAngleMinor = math.rad(10)

local REST_Y = math.rad(25)


--------------------------------------------------------------------------------
-- WALK (NEW SYSTEM)
--------------------------------------------------------------------------------
local function Walk()
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
-- OPEN / CLOSE
------------------------------------------------------------
local function OpenThread()
    Signal(SIG_OPEN)
    SetSignalMask(SIG_OPEN)

    if isOpen then
        return
    end

    isOpen = true

    Turn(armorl, z_axis, math.rad(-45), 3)
    Turn(armorr, z_axis, math.rad(45), 3)

    Turn(arm, x_axis, math.rad(35), 2)
    Turn(sleeve, x_axis, math.rad(-90), 2)

    WaitForTurn(armorl, z_axis)
    WaitForTurn(armorr, z_axis)
    WaitForTurn(arm, x_axis)
    WaitForTurn(sleeve, x_axis)
end

local function CloseThread()
    Signal(SIG_OPEN)
    SetSignalMask(SIG_OPEN)

    if not isOpen then
        return
    end

    isOpen = false

    Turn(armorl, z_axis, 0, 2)
    Turn(armorr, z_axis, 0, 2)

    Turn(arm, x_axis, 0, 3)
    Turn(sleeve, x_axis, 0, 3)
end
------------------------------------------------------------
-- RESTORE
------------------------------------------------------------
local function RestoreThread()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(2500)

    StartThread(CloseThread)
end

------------------------------------------------------------
-- AIM
------------------------------------------------------------
function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)

    StartThread(OpenThread)
    StartThread(RestoreThread)

    return true
end

------------------------------------------------------------
-- FIRE
------------------------------------------------------------
function script.FireWeapon(num)
    Sleep(120)

    local f = flare[pod + 1]
    EmitSfx(f, 1024)

    pod = (pod + 1) % 6

    Move(barrel, z_axis, -2, 20)
    Move(barrel, z_axis, 0, 10)

    return 1
end

------------------------------------------------------------
-- MOVEMENT
------------------------------------------------------------
function script.StartMoving()
    Signal(SIG_MOVE)
    StartThread(Walk)
end

function script.StopMoving()
    Signal(SIG_MOVE)
    StartThread(StopWalk)
end

------------------------------------------------------------
-- HELPERS
------------------------------------------------------------
function script.AimFromWeapon()
    return turret
end

function script.QueryWeapon()
    return flare[1]
end

------------------------------------------------------------
-- KILLED
------------------------------------------------------------
--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.5 then
        -- LIGHT DEATH: collapse but mostly intact
        Explode(base,    SFX.NONE)
        Explode(turret,  SFX.NONE)
        Explode(arm,     SFX.NONE)
        Explode(sleeve,  SFX.NONE)
        Explode(barrel,  SFX.NONE)

        Explode(armorl, SFX.NONE)
        Explode(armorr, SFX.NONE)
        Explode(armorf, SFX.NONE)

        Explode(thighfl, SFX.NONE)
        Explode(thighfr, SFX.NONE)
        Explode(thighbl, SFX.NONE)
        Explode(thighbr, SFX.NONE)

        Explode(legfl, SFX.NONE)
        Explode(legfr, SFX.NONE)
        Explode(legbl, SFX.NONE)
        Explode(legbr, SFX.NONE)

        Explode(footfl, SFX.NONE)
        Explode(footfr, SFX.NONE)
        Explode(footbl, SFX.NONE)
        Explode(footbr, SFX.NONE)

        return 1
    else
        -- HEAVY DEATH: full disintegration
        Explode(base,   SFX.SHATTER + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(turret, SFX.FALL    + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(arm,    SFX.FALL    + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(sleeve, SFX.FALL    + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(barrel, SFX.FALL    + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        Explode(armorl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(armorr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(armorf, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        -- legs (core spider collapse feel)
        Explode(thighfl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(thighfr, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(thighbl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(thighbr, SFX.FALL + SFX.SMOKE + SFX.FIRE)

        Explode(legfl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(legfr, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(legbl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(legbr, SFX.FALL + SFX.SMOKE + SFX.FIRE)

        Explode(footfl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(footfr, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(footbl, SFX.FALL + SFX.SMOKE + SFX.FIRE)
        Explode(footbr, SFX.FALL + SFX.SMOKE + SFX.FIRE)

        return 2
    end
end