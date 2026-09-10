include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis, aimy1, torso, aimx1, sleeve, barrel, flare, armor, flap,
      lthigh, lleg, lfoot, rthigh, rleg, rfoot =
    piece('pelvis','aimy1','torso','aimx1','sleeve','barrel','flare','armor','flap',
          'lthigh','lleg','lfoot','rthigh','rleg','rfoot')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2
local SIG_RESTORE = 4

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 4
local restore_delay = 2750
local aimingClose = false

--------------------------------------------------------------------------------
-- WALK (BOS KEYFRAME PORT)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local spd = 8 / animSpeed

    local function PelvisY(v)
        return v * 0.35 -- 🔥 kills bobbing
    end

    while isMoving do

        -- FRAME 1
        Turn(lfoot, x_axis, math.rad(31), 12/spd)
        Turn(lleg, x_axis, math.rad(-36), 12/spd)
        Turn(lthigh, x_axis, math.rad(35), 10/spd)

        Turn(rfoot, x_axis, math.rad(5), 10/spd)
        Turn(rleg, x_axis, math.rad(13), 10/spd)
        Turn(rthigh, x_axis, math.rad(-18), 10/spd)

        Move(pelvis, y_axis, PelvisY(0.57), 4/spd)
        Move(pelvis, z_axis, 0.3, 4/spd) -- forward weight
        Turn(pelvis, x_axis, math.rad(1), 4/spd)

        Sleep(40 * animSpeed)

        -- FRAME 2
        Turn(lfoot, x_axis, math.rad(38), 10/spd)
        Turn(lleg, x_axis, math.rad(-36), 10/spd)
        Turn(lthigh, x_axis, math.rad(-28), 12/spd)

        Turn(rfoot, x_axis, math.rad(-43), 12/spd)
        Turn(rleg, x_axis, math.rad(33), 10/spd)
        Turn(rthigh, x_axis, math.rad(6), 10/spd)

        Move(pelvis, y_axis, PelvisY(0.38), 4/spd)
        Move(pelvis, z_axis, 0.1, 4/spd)
        Turn(pelvis, x_axis, math.rad(2), 4/spd)

        Sleep(40 * animSpeed)

        -- FRAME 3
        Turn(lfoot, x_axis, math.rad(26), 10/spd)
        Turn(lleg, x_axis, math.rad(42), 12/spd)
        Turn(lthigh, x_axis, math.rad(-66), 12/spd)

        Turn(rfoot, x_axis, math.rad(-13), 10/spd)
        Turn(rleg, x_axis, math.rad(8), 10/spd)
        Turn(rthigh, x_axis, math.rad(56), 12/spd)

        Move(pelvis, y_axis, PelvisY(-0.6), 4/spd)
        Move(pelvis, z_axis, -0.3, 4/spd) -- backward weight
        Turn(pelvis, x_axis, math.rad(-1), 4/spd)

        Sleep(40 * animSpeed)

        -- FRAME 4 (mirror)
        Turn(rfoot, x_axis, math.rad(31), 12/spd)
        Turn(rleg, x_axis, math.rad(-36), 12/spd)
        Turn(rthigh, x_axis, math.rad(35), 10/spd)

        Turn(lfoot, x_axis, math.rad(5), 10/spd)
        Turn(lleg, x_axis, math.rad(13), 10/spd)
        Turn(lthigh, x_axis, math.rad(-18), 10/spd)

        Move(pelvis, y_axis, PelvisY(0.57), 4/spd)
        Move(pelvis, z_axis, 0.3, 4/spd)
        Turn(pelvis, x_axis, math.rad(1), 4/spd)

        Sleep(40 * animSpeed)

        -- FRAME 5
        Turn(rfoot, x_axis, math.rad(38), 10/spd)
        Turn(rleg, x_axis, math.rad(-36), 10/spd)
        Turn(rthigh, x_axis, math.rad(-28), 12/spd)

        Turn(lfoot, x_axis, math.rad(-43), 12/spd)
        Turn(lleg, x_axis, math.rad(33), 10/spd)
        Turn(lthigh, x_axis, math.rad(6), 10/spd)

        Move(pelvis, y_axis, PelvisY(0.38), 4/spd)
        Move(pelvis, z_axis, 0.1, 4/spd)
        Turn(pelvis, x_axis, math.rad(2), 4/spd)

        Sleep(40 * animSpeed)

        -- FRAME 6
        Turn(rfoot, x_axis, math.rad(26), 10/spd)
        Turn(rleg, x_axis, math.rad(42), 12/spd)
        Turn(rthigh, x_axis, math.rad(-66), 12/spd)

        Turn(lfoot, x_axis, math.rad(-13), 10/spd)
        Turn(lleg, x_axis, math.rad(8), 10/spd)
        Turn(lthigh, x_axis, math.rad(56), 12/spd)

        Move(pelvis, y_axis, PelvisY(-0.6), 4/spd)
        Move(pelvis, z_axis, -0.3, 4/spd)
        Turn(pelvis, x_axis, math.rad(-1), 4/spd)

        Sleep(40 * animSpeed)
    end
end
--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------
local function StopWalk()
    Move(pelvis, y_axis, 0, 10)

    Turn(lthigh, x_axis, 0, 10)
    Turn(rthigh, x_axis, 0, 10)
    Turn(lleg, x_axis, 0, 10)
    Turn(rleg, x_axis, 0, 10)
    Turn(lfoot, x_axis, 0, 10)
    Turn(rfoot, x_axis, 0, 10)
end

--------------------------------------------------------------------------------
-- RESTORE (WITH GUN HIDE FIX)
--------------------------------------------------------------------------------
local function RestoreAfterDelay()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(restore_delay)

    Turn(aimy1, y_axis, 0, math.rad(90))
    Turn(aimx1, x_axis, 0, math.rad(45))
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(flare)
    Hide(aimx1)
    Hide(aimy1)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
    Signal(SIG_MOVE)
    StopWalk()
end

--------------------------------------------------------------------------------
-- WEAPONS
--------------------------------------------------------------------------------
function script.AimFromWeapon()
    return aimx1
end

function script.QueryWeapon()
    return flare
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy1, y_axis, heading, math.rad(160))
    Turn(aimx1, x_axis, -pitch, math.rad(90))

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(aimx1, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

function script.FireWeapon()
    -- recoil BACK
    Move(barrel, z_axis, -3, 120)
    EmitSfx(flare, 1024)

    WaitForMove(barrel, z_axis)

    -- return to neutral
    Move(barrel, z_axis, 0, 60)
end

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.5 then
        Explode(torso, SFX.SHATTER + SFX.EXPLODE)
        return 1
    else
        Explode(torso, SFX.SHATTER + SFX.EXPLODE)
        Explode(pelvis, SFX.EXPLODE)
        return 2
    end
end