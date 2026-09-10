include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis = piece "pelvis"

local aimy = piece "aimy"
local aimx = piece "aimx"

-- legs
local lthigh = piece "lthigh"
local rthigh = piece "rthigh"
local lleg   = piece "lleg"
local rleg   = piece "rleg"
local lkeel  = piece "lkeel"
local rkeel  = piece "rkeel"
local lfoot  = piece "lfoot"
local rfoot  = piece "rfoot"

-- arms
local lsleeve = piece "lsleeve"
local rsleeve = piece "rsleeve"

-- weapons
local lbarrel = piece "lbarrel"
local rbarrel = piece "rbarrel"

-- flares
local lflare = piece "lflare"
local rflare = piece "rflare"

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_AIM  = 2
local SIG_FIRE = 4
local SIG_MOVE = 1

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local isAiming = false

local animSpeed = 3
local restore_delay = 3000
local miniguncount = 0
local lastHeading = 1000000


local function StopBarrels()
    Signal(SIG_FIRE)
    SetSignalMask(SIG_FIRE)

    Sleep(500) -- how long guns keep spinning after last shot

    StopSpin(lbarrel, z_axis, math.rad(360))
    StopSpin(rbarrel, z_axis, math.rad(360))
end


local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local spd = 8 / animSpeed

    local function PelvisY(v)
        return v * 0.9
    end

    local function Blend()
        return 6 / spd
    end

    while isMoving do

        ----------------------------------------------------------------------
        -- FRAME 1 (R STOMP / L BACK)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(-22), 10/spd)
        Turn(rleg,   x_axis, math.rad(-28), 10/spd)

        Turn(lthigh, x_axis, math.rad(50), 10/spd)
        Turn(lleg,   x_axis, math.rad(38), 10/spd)

        -- RIGHT = CONTACT
        Turn(rfoot, x_axis, math.rad(18), 40/spd)
        Turn(rkeel, x_axis, math.rad(-20), 40/spd)

        -- LEFT = LIFT
        Turn(lfoot, x_axis, math.rad(-20), 20/spd)
        Turn(lkeel, x_axis, math.rad(12), 20/spd)

        Move(pelvis, y_axis, PelvisY(-0.6), 20/spd)
        Move(pelvis, z_axis, 0.35, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 2 (COMPRESSION)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(-26), 10/spd)
        Turn(rleg,   x_axis, math.rad(-36), 10/spd)

        Turn(lthigh, x_axis, math.rad(46), 10/spd)
        Turn(lleg,   x_axis, math.rad(12), 10/spd)

        -- soften
        Turn(rfoot, x_axis, math.rad(5), 20/spd)
        Turn(rkeel, x_axis, math.rad(-5), 20/spd)

        Turn(lfoot, x_axis, math.rad(-10), 20/spd)
        Turn(lkeel, x_axis, math.rad(5), 20/spd)

        Move(pelvis, y_axis, PelvisY(-1.5), Blend())
        Move(pelvis, z_axis, -0.55, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 3 (RIGHT PUSH OFF)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(16), 10/spd)
        Turn(rleg,   x_axis, math.rad(-8), 10/spd)

        Turn(lthigh, x_axis, math.rad(5), 10/spd)
        Turn(lleg,   x_axis, math.rad(-10), 10/spd)

        -- RIGHT = STRONG TOE PUSH
        Turn(rfoot, x_axis, math.rad(-36), 35/spd)
        Turn(rkeel, x_axis, math.rad(26), 35/spd)

        -- LEFT = SWING FORWARD
        Turn(lfoot, x_axis, math.rad(-12), 18/spd)
        Turn(lkeel, x_axis, math.rad(6), 18/spd)

        Move(pelvis, y_axis, PelvisY(-0.6), Blend())
        Move(pelvis, z_axis, -0.7, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 4 (TRANSITION)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(50), 10/spd)
        Turn(rleg,   x_axis, math.rad(5), 10/spd)

        Turn(lthigh, x_axis, math.rad(-36), 10/spd)
        Turn(lleg,   x_axis, math.rad(-28), 10/spd)

        -- ONLY swing leg adjusts (NO full reset)
        Turn(lfoot, x_axis, math.rad(-5), 20/spd)
        Turn(lkeel, x_axis, math.rad(2), 20/spd)

        Move(pelvis, y_axis, PelvisY(1.2), Blend())
        Move(pelvis, z_axis, 0.15, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 5 (L STOMP)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(50), 10/spd)
        Turn(rleg,   x_axis, math.rad(38), 10/spd)

        Turn(lthigh, x_axis, math.rad(-58), 10/spd)
        Turn(lleg,   x_axis, math.rad(-28), 10/spd)

        -- LEFT = CONTACT
-- LEFT = STRONGER CONTACT
Turn(lfoot, x_axis, math.rad(20), 45/spd)
Turn(lkeel, x_axis, math.rad(-22), 45/spd)

        -- RIGHT = LIFT
        Turn(rfoot, x_axis, math.rad(-20), 20/spd)
        Turn(rkeel, x_axis, math.rad(12), 20/spd)

        Move(pelvis, y_axis, PelvisY(1.2), 20/spd)
        Move(pelvis, z_axis, 0.75, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 6
        ----------------------------------------------------------------------
-- FRAME 6 (LEFT SWING FORWARD - FIXED)
Turn(rthigh, x_axis, math.rad(60), 10/spd)
Turn(rleg,   x_axis, math.rad(25), 10/spd)

Turn(lthigh, x_axis, math.rad(26), 10/spd)
Turn(lleg,   x_axis, math.rad(-36), 10/spd)

-- LEFT = ACTIVE SWING (was too weak before)
Turn(lfoot, x_axis, math.rad(-18), 20/spd)
Turn(lkeel, x_axis, math.rad(10), 20/spd)

-- RIGHT = RECOVER
Turn(rfoot, x_axis, math.rad(-12), 18/spd)
Turn(rkeel, x_axis, math.rad(6), 18/spd)

Move(pelvis, y_axis, PelvisY(-0.3), Blend())
Move(pelvis, z_axis, 0.3, Blend())

Sleep(33 * animSpeed)
        ----------------------------------------------------------------------
        -- FRAME 7 (LEFT PUSH OFF)
        ----------------------------------------------------------------------
-- FRAME 7 (LEFT PRE-CONTACT + PUSH FIX)
Turn(rthigh, x_axis, math.rad(46), 10/spd)
Turn(rleg,   x_axis, math.rad(12), 10/spd)

Turn(lthigh, x_axis, math.rad(-16), 10/spd)
Turn(lleg,   x_axis, math.rad(-10), 10/spd)

-- LEFT = PRE-CONTACT (THIS WAS MISSING FEEL)
Turn(lfoot, x_axis, math.rad(10), 25/spd)
Turn(lkeel, x_axis, math.rad(-12), 25/spd)

-- RIGHT = MID AIR
Turn(rfoot, x_axis, math.rad(-10), 18/spd)
Turn(rkeel, x_axis, math.rad(4), 18/spd)

Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 8 (TRANSITION)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(5), 10/spd)
        Turn(rleg,   x_axis, math.rad(-10), 10/spd)

        Turn(lthigh, x_axis, math.rad(16), 10/spd)
        Turn(lleg,   x_axis, math.rad(-10), 10/spd)

        -- prep alignment
        Turn(rfoot, x_axis, math.rad(-2), 20/spd)
        Turn(lfoot, x_axis, math.rad(8), 20/spd)

        Turn(rkeel, x_axis, 0, 20/spd)
        Turn(lkeel, x_axis, math.rad(-4), 20/spd)

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 9 (PRE-STOMP BLEND)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(-36), 10/spd)
        Turn(rleg,   x_axis, math.rad(-28), 10/spd)

        Turn(lthigh, x_axis, math.rad(50), 10/spd)
        Turn(lleg,   x_axis, math.rad(5), 10/spd)

        -- prepare next stomp
        Turn(rfoot, x_axis, math.rad(5), 20/spd)
        Turn(rkeel, x_axis, math.rad(-5), 20/spd)

        Turn(lfoot, x_axis, math.rad(-10), 20/spd)
        Turn(lkeel, x_axis, math.rad(5), 20/spd)

        Move(pelvis, y_axis, PelvisY(1.3), Blend())
        Move(pelvis, z_axis, 0.1, Blend())

        Sleep(33 * animSpeed)

        ----------------------------------------------------------------------
        -- FRAME 10 (R STOMP AGAIN)
        ----------------------------------------------------------------------
        Turn(rthigh, x_axis, math.rad(-58), 10/spd)
        Turn(rleg,   x_axis, math.rad(-28), 10/spd)

        Turn(lthigh, x_axis, math.rad(50), 10/spd)
        Turn(lleg,   x_axis, math.rad(38), 10/spd)

        -- RIGHT CONTACT
        Turn(rfoot, x_axis, math.rad(18), 40/spd)
        Turn(rkeel, x_axis, math.rad(-20), 40/spd)

        -- LEFT LIFT
        Turn(lfoot, x_axis, math.rad(-20), 20/spd)
        Turn(lkeel, x_axis, math.rad(12), 20/spd)

        Move(pelvis, y_axis, PelvisY(1.3), 20/spd)
        Move(pelvis, z_axis, 0.75, Blend())

        Sleep(33 * animSpeed)
    end
end
--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------
local function StopWalk()
    Move(pelvis, y_axis, 0, 8)
    Move(pelvis, z_axis, 0, 8)

    Turn(lthigh, x_axis, 0, 6)
    Turn(rthigh, x_axis, 0, 6)

    Turn(lleg, x_axis, 0, 6)
    Turn(rleg, x_axis, 0, 6)

    Turn(lkeel, x_axis, 0, 6)
    Turn(rkeel, x_axis, 0, 6)

    Turn(lfoot, x_axis, 0, 6)
    Turn(rfoot, x_axis, 0, 6)
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(lflare)
    Hide(rflare)
    Hide(aimx)
    Hide(aimy)

    Turn(rsleeve, y_axis, math.rad(5))
    Turn(lsleeve, y_axis, math.rad(-5))
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
    StopWalk()
end

--------------------------------------------------------------------------------
-- AIMING
--------------------------------------------------------------------------------
function script.AimFromWeapon()
    return aimx
end

function script.QueryWeapon()
    if miniguncount == 0 then
        return rflare
    else
        return lflare
    end
end

function script.AimWeapon(_, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy, y_axis, heading, math.rad(500))
    Turn(aimx, x_axis, -pitch, math.rad(500))

    WaitForTurn(aimy, y_axis)
    WaitForTurn(aimx, x_axis)

    lastHeading = heading
    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon()
    -- keep spinning while firing
    Spin(lbarrel, z_axis, math.rad(-1080), math.rad(720))
    Spin(rbarrel, z_axis, math.rad(1080), math.rad(720))

    -- restart stop timer every shot
    StartThread(StopBarrels)

    if miniguncount == 0 then
        EmitSfx(rflare, 1024)
    else
        EmitSfx(lflare, 1024)
    end

    miniguncount = (miniguncount + 1) % 2
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    Explode(pelvis, SFX.SHATTER)
    return (recentDamage / maxHealth) > 0.5 and 2 or 1
end