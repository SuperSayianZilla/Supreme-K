include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis, torso, aimy1, aimx1 = piece("pelvis","torso","aimy1","aimx1")
local lgun, rgun, lflare, rflare = piece("lgun","rgun","lflare","rflare")
local lbarrel, rbarrel = piece("lbarrel","rbarrel")

local rocketpod, rocketflare1, rocketflare2 = piece("rocketpod","rocketflare1","rocketflare2")
local lhatch, rhatch = piece("lhatch","rhatch")

local lthigh, rthigh = piece("lthigh","rthigh")
local lleg, rleg = piece("lleg","rleg")
local lankle, rankle = piece("lankle","rankle")
local lfoot, rfoot = piece("lfoot","rfoot")
local ltoe1, rtoe1 = piece("ltoe1","rtoe1")


--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_AIM1 = 2
local SIG_AIM2 = 4
local SIG_RESTORE = 8
local SIG_DOOR = 16

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local gunIndex = 1
local rocketswitch = 0
local doorOpen = false
local animSpeed = 2.6 -- adjusted for proper walk cadence

--------------------------------------------------------------------------------
-- RESTORE POSE
--------------------------------------------------------------------------------
local function RestorePose()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Turn(lthigh, x_axis, 0, math.rad(120))
    Turn(rthigh, x_axis, 0, math.rad(120))
    Turn(lleg, x_axis, 0, math.rad(120))
    Turn(rleg, x_axis, 0, math.rad(120))

    Turn(lankle, x_axis, 0, math.rad(120))
    Turn(rankle, x_axis, 0, math.rad(120))

    Turn(ltoe1, x_axis, 0, math.rad(120))
    Turn(rtoe1, x_axis, 0, math.rad(120))

    Turn(torso, x_axis, 0, math.rad(90))
    Turn(torso, y_axis, 0, math.rad(90))

    Turn(aimy1, y_axis, 0, math.rad(120))
    Turn(aimx1, x_axis, 0, math.rad(120))

    Move(pelvis, y_axis, 0, 10)
end

--------------------------------------------------------------------------------
-- AIM RESTORE
--------------------------------------------------------------------------------
local function RestoreAfterDelay()
    Signal(SIG_RESTORE)
    SetSignalMask(SIG_RESTORE)

    Sleep(4000)

    Turn(torso, y_axis, 0, math.rad(90))
    Turn(aimy1, y_axis, 0, math.rad(90))
    Turn(aimx1, x_axis, 0, math.rad(90))
end

--------------------------------------------------------------------------------
-- WALK (FIXED WALK FEEL)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    while isMoving do
        for i = 0, 29 do
            local phase = (i / 30) * math.pi * 2

            -- legs (unchanged stride, good already)
            local thigh = math.rad(math.sin(phase) * 32)
            local shin  = math.rad(math.sin(phase + 0.6) * 18)
            local ankle = math.rad(math.sin(phase + 1.2) * 12)
            local toe   = math.rad(math.sin(phase + 1.4) * 8)

            local r_phase = phase + math.pi

            local r_thigh = math.rad(math.sin(r_phase) * 32)
            local r_shin  = math.rad(math.sin(r_phase + 0.6) * 18)
            local r_ankle = math.rad(math.sin(r_phase + 1.2) * 12)
            local r_toe   = math.rad(math.sin(r_phase + 1.4) * 8)

            -- smoother, less "run"
            Turn(lthigh, x_axis, thigh, math.rad(300)/animSpeed)
            Turn(lleg,   x_axis, shin,  math.rad(300)/animSpeed)
            Turn(lankle, x_axis, ankle, math.rad(300)/animSpeed)
            Turn(ltoe1,  x_axis, toe,   math.rad(300)/animSpeed)

            Turn(rthigh, x_axis, r_thigh, math.rad(300)/animSpeed)
            Turn(rleg,   x_axis, r_shin,  math.rad(300)/animSpeed)
            Turn(rankle, x_axis, r_ankle, math.rad(300)/animSpeed)
            Turn(rtoe1,  x_axis, r_toe,   math.rad(300)/animSpeed)

            -- subtle torso (less swing = less "run")
            Turn(torso, y_axis, math.rad(math.sin(phase) * -3), math.rad(100)/animSpeed)

            -- reduced bob (key fix)
            Move(pelvis, y_axis, math.sin(phase) * 0.6, 10/animSpeed)

            -- CRITICAL FIX: faster frame progression
            Sleep(22 * animSpeed)
        end
    end
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
    Signal(SIG_WALK)
    StartThread(RestorePose)
end

--------------------------------------------------------------------------------
-- AIMING
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
    return aimy1
end

function script.QueryWeapon(num)
    if num == 1 then
        return (gunIndex == 1) and lflare or rflare
    else
        return (rocketswitch == 0) and rocketflare1 or rocketflare2
    end
end

function script.AimWeapon(num, heading, pitch)
    if num == 1 then
        Signal(SIG_AIM1)
        SetSignalMask(SIG_AIM1)

        Turn(aimy1, y_axis, heading, math.rad(180))
        Turn(aimx1, x_axis, -pitch, math.rad(120))

        WaitForTurn(aimy1, y_axis)
        WaitForTurn(aimx1, x_axis)

        StartThread(RestoreAfterDelay)
        return true
    end

    if num == 2 then
    Signal(SIG_AIM2)
    SetSignalMask(SIG_AIM2)

    if not doorOpen then
        Turn(rhatch, z_axis, math.rad(-115), math.rad(100))
        Turn(lhatch, z_axis, math.rad(115), math.rad(100))
        Turn(rocketpod, x_axis, math.rad(15), math.rad(15))
        WaitForTurn(rhatch, z_axis)
        doorOpen = true
    end

    return true
end

    return false
end
local function CloseRocketDoors()
    Signal(SIG_DOOR)
    SetSignalMask(SIG_DOOR)

    Sleep(3000) -- resets if fired again

    if not doorOpen then return end

    -- retract pod FIRST (prevents clipping)
    Turn(rocketpod, x_axis, 0, math.rad(120))
    WaitForTurn(rocketpod, x_axis)

    -- then close doors
    Turn(rhatch, z_axis, 0, math.rad(100))
    Turn(lhatch, z_axis, 0, math.rad(100))

    doorOpen = false
end

--------------------------------------------------------------------------------
-- FIRE (CORRECT RECOIL)
--------------------------------------------------------------------------------
function script.FireWeapon(num)
    if num == 1 then
        local firingGun = gunIndex

        if firingGun == 1 then
            EmitSfx(lflare, 1024)
            StartThread(function()
                Move(rbarrel, z_axis, -5, 80)
                Sleep(60)
                Move(rbarrel, z_axis, 0, 30)
            end)
        else
            EmitSfx(rflare, 1024)
            StartThread(function()
                Move(lbarrel, z_axis, -5, 80)
                Sleep(60)
                Move(lbarrel, z_axis, 0, 30)
            end)
        end

        gunIndex = 3 - gunIndex
    end

if num == 2 then
    rocketswitch = 1 - rocketswitch

    -- restart close timer WITHOUT killing aim
    StartThread(CloseRocketDoors)
end
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    StartThread(RestorePose)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    -- stop all animation threads cleanly
    Signal(SIG_WALK)
    Signal(SIG_AIM1)
    Signal(SIG_AIM2)
    Signal(SIG_RESTORE)
    Signal(SIG_DOOR)

    ------------------------------------------------------------------------
    -- LIGHT DAMAGE (<50%) → mostly intact wreck
    ------------------------------------------------------------------------
    if severity < 0.5 then
        Explode(lbarrel, SFX.SMOKE)
        Explode(rbarrel, SFX.SMOKE)
        Explode(rocketpod, SFX.SMOKE)

        Explode(torso, SFX.FALL)
        Explode(pelvis, SFX.SHATTER)

        return 1 -- normal wreck
    end

    ------------------------------------------------------------------------
    -- MEDIUM DAMAGE (<100%) → parts break off
    ------------------------------------------------------------------------
    if severity < 1 then
        Explode(lbarrel, SFX.FIRE + SFX.SMOKE)
        Explode(rbarrel, SFX.FIRE + SFX.SMOKE)

        Explode(lgun, SFX.SHATTER)
        Explode(rgun, SFX.SHATTER)

        Explode(rocketpod, SFX.FIRE + SFX.SMOKE)
        Explode(lhatch, SFX.SHATTER)
        Explode(rhatch, SFX.SHATTER)

        -- legs collapse
        Explode(lthigh, SFX.SHATTER)
        Explode(rthigh, SFX.SHATTER)

        Explode(torso, SFX.FIRE)
        Explode(pelvis, SFX.SHATTER)

        return 2 -- heap
    end

    ------------------------------------------------------------------------
    -- OVERKILL (>100%) → full destruction
    ------------------------------------------------------------------------
    -- weapons violently explode
    Explode(lbarrel, SFX.EXPLODE + SFX.FIRE)
    Explode(rbarrel, SFX.EXPLODE + SFX.FIRE)

    Explode(lgun, SFX.EXPLODE)
    Explode(rgun, SFX.EXPLODE)

    -- rocket system blows up
    Explode(rocketpod, SFX.EXPLODE + SFX.FIRE)
    Explode(lhatch, SFX.EXPLODE)
    Explode(rhatch, SFX.EXPLODE)

    -- legs fully destroyed
    Explode(lthigh, SFX.EXPLODE)
    Explode(rthigh, SFX.EXPLODE)
    Explode(lleg, SFX.SHATTER)
    Explode(rleg, SFX.SHATTER)

    Explode(lankle, SFX.SHATTER)
    Explode(rankle, SFX.SHATTER)

    -- core destruction
    Explode(torso, SFX.EXPLODE)
    Explode(pelvis, SFX.EXPLODE)

    return 2 -- heap (no clean wreck)
end