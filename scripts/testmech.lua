include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES (YOUR EXACT SETUP)
--------------------------------------------------------------------------------
local base = piece("base")
local torso = piece("torso")
local waist = piece("waist")

-- LEFT LEG
local l_thigh = piece("left_thigh")
local l_knee  = piece("leftleg_knee")
local l_leg   = piece("left_leg")
local l_ankle = piece("left_ankle")
local l_toe_f = piece("leftfoot_fronttoe")
local l_toe_b = piece("leftfoot_backtoe")

-- RIGHT LEG
local r_thigh = piece("right_thigh")
local r_knee  = piece("right_knee")
local r_leg   = piece("right_leg")
local r_ankle = piece("right_ankle")
local r_toe_f = piece("rightfoot_fronttoe")
local r_toe_b = piece("rightfoot_backtoe")

-- GUNS
local gun_l = piece("gun_left")
local gun_r = piece("gun_right")
local barrel_l = piece("barrel_left")
local barrel_r = piece("barrel_right")

-- FLARES (you added)
local flare = piece("flare")
local flare2 = piece("flare2")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local moving = false
local gun = 0
local restoreDelay = 1500

--------------------------------------------------------------------------------
-- WALK (CHAIN-CORRECT)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while moving do
        local speed = math.rad(120)

        ----------------------------------------------------------------------
        -- STEP A (RIGHT FORWARD, LEFT BACK)
        ----------------------------------------------------------------------
        Turn(r_thigh, x_axis, math.rad(-40), speed)
        Turn(r_knee,  x_axis, math.rad(60), speed*1.5)
        Turn(r_leg,   x_axis, math.rad(10), speed)
        Turn(r_ankle, x_axis, math.rad(-10), speed)
        Turn(r_toe_f, x_axis, math.rad(20), speed)
        Turn(r_toe_b, x_axis, math.rad(-10), speed)

        Turn(l_thigh, x_axis, math.rad(20), speed)
        Turn(l_knee,  x_axis, math.rad(10), speed)
        Turn(l_leg,   x_axis, math.rad(-10), speed)
        Turn(l_ankle, x_axis, math.rad(5), speed)
        Turn(l_toe_f, x_axis, math.rad(-10), speed)
        Turn(l_toe_b, x_axis, math.rad(5), speed)

        Turn(waist, z_axis, math.rad(3), speed*0.3)
        Turn(torso, x_axis, math.rad(2), speed*0.5)

        Sleep(150)

        ----------------------------------------------------------------------
        -- STEP B (SWAP)
        ----------------------------------------------------------------------
        Turn(r_thigh, x_axis, math.rad(20), speed)
        Turn(r_knee,  x_axis, math.rad(10), speed)
        Turn(r_leg,   x_axis, math.rad(-10), speed)
        Turn(r_ankle, x_axis, math.rad(5), speed)
        Turn(r_toe_f, x_axis, math.rad(-10), speed)
        Turn(r_toe_b, x_axis, math.rad(5), speed)

        Turn(l_thigh, x_axis, math.rad(-40), speed)
        Turn(l_knee,  x_axis, math.rad(60), speed*1.5)
        Turn(l_leg,   x_axis, math.rad(10), speed)
        Turn(l_ankle, x_axis, math.rad(-10), speed)
        Turn(l_toe_f, x_axis, math.rad(20), speed)
        Turn(l_toe_b, x_axis, math.rad(-10), speed)

        Turn(waist, z_axis, math.rad(-3), speed*0.3)
        Turn(torso, x_axis, math.rad(-2), speed*0.5)

        Sleep(150)
    end
end

--------------------------------------------------------------------------------
-- STOP
--------------------------------------------------------------------------------
local function StopWalk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local s = math.rad(120)

    -- reset ALL joints cleanly
    for _, p in ipairs({
        l_thigh,l_knee,l_leg,l_ankle,l_toe_f,l_toe_b,
        r_thigh,r_knee,r_leg,r_ankle,r_toe_f,r_toe_b
    }) do
        Turn(p, x_axis, 0, s)
        Turn(p, y_axis, 0, s)
        Turn(p, z_axis, 0, s)
    end

    Turn(waist, z_axis, 0, s)
    Turn(torso, x_axis, 0, s)
end

--------------------------------------------------------------------------------
-- MOVEMENT HOOKS
--------------------------------------------------------------------------------
function script.StartMoving()
    moving = true
    StartThread(Walk)
end

function script.StopMoving()
    moving = false
    StartThread(StopWalk)
end

--------------------------------------------------------------------------------
-- AIM (FIXED TORSO ROTATION)
--------------------------------------------------------------------------------
local function Restore()
    Sleep(restoreDelay)
    Turn(torso, y_axis, 0, math.rad(90))
    Turn(torso, x_axis, 0, math.rad(60))
end

function script.AimFromWeapon1()
    return torso
end

function script.QueryWeapon1()
    if gun == 0 then return flare else return flare2 end
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    -- IMPORTANT: torso rotates, not random aim piece
    Turn(torso, y_axis, heading, math.rad(200))
    Turn(torso, x_axis, -pitch, math.rad(120))

    WaitForTurn(torso, y_axis)

    StartThread(Restore)
    return true
end

--------------------------------------------------------------------------------
-- FIRE (DUAL BARREL)
--------------------------------------------------------------------------------
function script.FireWeapon1()
    if gun == 0 then
        EmitSfx(flare, 1024)
        Move(barrel_r, z_axis, -5)
        Sleep(120)
        Move(barrel_r, z_axis, 0, 10)
    else
        EmitSfx(flare2, 1024)
        Move(barrel_l, z_axis, -5)
        Sleep(120)
        Move(barrel_l, z_axis, 0, 10)
    end

    gun = 1 - gun
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    StartThread(StopWalk)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(severity)
    Explode(torso, SFX.FALL + SFX.SMOKE)
    return 2
end