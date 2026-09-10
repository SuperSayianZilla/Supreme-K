include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local hip = piece "hip"
local torso = piece "torso"
local torsoPivot = piece "torsoPivot"
local gunSleeve = piece "gunSleeve"

local legThighR = piece "legThighR"
local legShinR  = piece "legShinR"
local legTibiaR = piece "legTibiaR"
local footR     = piece "footR"

local legThighL = piece "legThighL"
local legShinL  = piece "legShinL"
local legTibiaL = piece "legTibiaL"
local footL     = piece "footL"

local topBarrel = piece "topBarrel"
local bottomBarrel = piece "bottomBarrel"
local topFlare = piece "topFlare"
local bottomFlare = piece "bottomFlare"

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 0.6
local whichBarrel = 0

--------------------------------------------------------------------------------
-- HELPER
--------------------------------------------------------------------------------
local function t(p, axis, deg)
    Turn(p, axis, math.rad(deg), math.rad(1000))
end

--------------------------------------------------------------------------------
-- WALK 
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    while isMoving do

        -- FRAME 1
        t(footL,x_axis,-5.89)
        t(footR,x_axis,9.35)
        t(hip,y_axis,5.00)
        t(legShinL,x_axis,2.68)
        t(legShinR,x_axis,6.60)
        t(legThighL,x_axis,16.33)
        t(legThighR,x_axis,-10.41)
        t(legTibiaL,x_axis,11.99)
        t(legTibiaR,x_axis,-10.17)
        t(torso,x_axis,5.42)
        t(torso,y_axis,-7.52)
        Sleep(33*animSpeed)

        -- FRAME 3
        t(footL,x_axis,-4.92)
        t(footR,x_axis,6.06)
        t(hip,y_axis,3.86)
        t(legShinL,x_axis,4.99)
        t(legShinR,x_axis,3.87)
        t(legThighL,x_axis,18.80)
        t(legThighR,x_axis,-7.04)
        t(legTibiaL,x_axis,12.70)
        t(legTibiaR,x_axis,-6.72)
        t(torso,x_axis,3.22)
        t(torso,y_axis,-5.80)
        Sleep(33*animSpeed)

        -- FRAME 6
        t(footL,x_axis,-23.89)
        t(footR,x_axis,2.59)
        t(gunSleeve,x_axis,1.14)
        t(hip,y_axis,0.80)
        t(legShinL,x_axis,-10.13)
        t(legShinR,x_axis,1.47)
        t(legThighL,x_axis,24.12)
        t(legThighR,x_axis,-3.14)
        t(legTibiaL,x_axis,22.22)
        t(legTibiaR,x_axis,-2.94)
        t(torso,x_axis,0.16)
        t(torso,y_axis,-1.21)
        Sleep(33*animSpeed)

        -- FRAME 9
        t(footL,x_axis,-28.23)
        t(footR,x_axis,-0.34)
        t(gunSleeve,x_axis,-1.10)
        t(hip,y_axis,-2.53)
        t(legShinL,x_axis,-25.33)
        t(legShinR,x_axis,-0.13)
        t(legThighL,x_axis,12.63)
        t(legThighR,x_axis,0.50)
        t(legTibiaL,x_axis,12.53)
        t(legTibiaR,x_axis,0.44)
        t(torso,x_axis,1.26)
        t(torso,y_axis,3.80)
        Sleep(33*animSpeed)

        -- FRAME 12
        t(footL,x_axis,-5.37)
        t(footR,x_axis,-3.21)
        t(gunSleeve,x_axis,0.24)
        t(hip,y_axis,-4.99)
        t(legShinL,x_axis,-13.67)
        t(legShinR,x_axis,-1.15)
        t(legThighL,x_axis,-11.63)
        t(legThighR,x_axis,4.65)
        t(legTibiaL,x_axis,-4.02)
        t(legTibiaR,x_axis,4.12)
        t(torso,x_axis,5.11)
        t(torso,y_axis,7.49)
        Sleep(33*animSpeed)

        -- FRAME 15
        t(footL,x_axis,18.22)
        t(footR,x_axis,-5.69)
        t(gunSleeve,x_axis,3.47)
        t(hip,y_axis,-5.70)
        t(legShinL,x_axis,15.00)
        t(legShinR,x_axis,-0.99)
        t(legThighL,x_axis,-19.09)
        t(legThighR,x_axis,9.66)
        t(legTibiaL,x_axis,-19.48)
        t(legTibiaR,x_axis,8.17)
        t(torso,x_axis,6.82)
        t(torso,y_axis,8.57)
        Sleep(33*animSpeed)

        -- FRAME 18
        t(footL,x_axis,11.44)
        t(footR,x_axis,-6.31)
        t(gunSleeve,x_axis,4.46)
        t(hip,y_axis,-4.42)
        t(legShinL,x_axis,8.38)
        t(legShinR,x_axis,1.62)
        t(legThighL,x_axis,-12.54)
        t(legThighR,x_axis,15.27)
        t(legTibiaL,x_axis,-12.36)
        t(legTibiaR,x_axis,11.64)
        t(torso,x_axis,4.51)
        t(torso,y_axis,6.64)
        Sleep(33*animSpeed)

        -- FRAME 21
        t(footL,x_axis,4.25)
        t(footR,x_axis,-20.69)
        t(gunSleeve,x_axis,1.95)
        t(hip,y_axis,-1.60)
        t(legShinL,x_axis,2.57)
        t(legShinR,x_axis,-7.86)
        t(legThighL,x_axis,-5.06)
        t(legThighR,x_axis,23.24)
        t(legTibiaL,x_axis,-4.78)
        t(legTibiaR,x_axis,21.01)
        t(torso,x_axis,0.71)
        t(torso,y_axis,2.40)
        Sleep(33*animSpeed)

        -- FRAME 24
        t(footL,x_axis,-1.59)
        t(footR,x_axis,-32.77)
        t(gunSleeve,x_axis,-0.85)
        t(hip,y_axis,1.78)
        t(legShinL,x_axis,-0.66)
        t(legShinR,x_axis,-25.55)
        t(legThighL,x_axis,2.21)
        t(legThighR,x_axis,18.16)
        t(legTibiaL,x_axis,1.98)
        t(legTibiaR,x_axis,16.80)
        t(torso,x_axis,0.60)
        t(torso,y_axis,-2.67)
        Sleep(33*animSpeed)

        -- FRAME 27
        t(footL,x_axis,-5.40)
        t(footR,x_axis,-16.44)
        t(gunSleeve,x_axis,-0.38)
        t(hip,y_axis,4.54)
        t(legShinL,x_axis,-1.12)
        t(legShinR,x_axis,-21.62)
        t(legThighL,x_axis,8.85)
        t(legThighR,x_axis,-1.15)
        t(legTibiaL,x_axis,7.58)
        t(legTibiaR,x_axis,3.49)
        t(torso,x_axis,4.21)
        t(torso,y_axis,-6.82)
        Sleep(33*animSpeed)

        -- FRAME 30
        t(footL,x_axis,-6.47)
        t(footR,x_axis,8.01)
        t(gunSleeve,x_axis,2.76)
        t(hip,y_axis,5.71)
        t(legShinL,x_axis,0.83)
        t(legShinR,x_axis,4.00)
        t(legThighL,x_axis,14.07)
        t(legThighR,x_axis,-12.13)
        t(legTibiaL,x_axis,11.11)
        t(legTibiaR,x_axis,-10.19)
        t(torso,x_axis,6.79)
        t(torso,y_axis,-8.59)
        Sleep(33*animSpeed)

    end
end

--------------------------------------------------------------------------------
-- MOVE CONTROL
--------------------------------------------------------------------------------
function script.StartMoving()
    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
end

--------------------------------------------------------------------------------
-- AIM / FIRE (same as before)
--------------------------------------------------------------------------------
function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(torsoPivot, y_axis, heading, math.rad(200))
    Turn(gunSleeve, x_axis, -pitch, math.rad(360))

    WaitForTurn(torsoPivot, y_axis)
    return true
end

function script.QueryWeapon(num)
    return (whichBarrel == 0) and topFlare or bottomFlare
end

function script.AimFromWeapon(num)
    return torso
end

--------------------------------------------------------------------------------
-- RECOIL SYSTEM (FIXED)
--------------------------------------------------------------------------------
local SIG_RECOIL_TOP = 4
local SIG_RECOIL_BOTTOM = 8

local function RecoilTop()
    Signal(SIG_RECOIL_TOP)
    SetSignalMask(SIG_RECOIL_TOP)

    EmitSfx(topFlare, 1024)

    -- fast kick
    Move(topBarrel, z_axis, -6, 120)

    -- slight torso reaction (optional but nice)
    Turn(torso, x_axis, math.rad(-2), math.rad(200))

    Sleep(90)

    -- smooth return
    Move(topBarrel, z_axis, 0, 25)
    Turn(torso, x_axis, 0, math.rad(60))
end

local function RecoilBottom()
    Signal(SIG_RECOIL_BOTTOM)
    SetSignalMask(SIG_RECOIL_BOTTOM)

    EmitSfx(bottomFlare, 1024)

    Move(bottomBarrel, z_axis, -6, 120)
    Turn(torso, x_axis, math.rad(-2), math.rad(200))

    Sleep(90)

    Move(bottomBarrel, z_axis, 0, 25)
    Turn(torso, x_axis, 0, math.rad(60))
end

function script.Shot(num)
    if whichBarrel == 0 then
        StartThread(RecoilTop)
        whichBarrel = 1
    else
        StartThread(RecoilBottom)
        whichBarrel = 0
    end
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    Explode(torso, SFX.SHATTER)
    Explode(hip, SFX.FALL)

    if severity < 0.5 then
        return 1
    else
        return 2
    end
end