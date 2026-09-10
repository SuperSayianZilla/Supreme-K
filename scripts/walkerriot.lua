include "constants.lua"
include "spider_walking.lua"

--------------------------------------------------------------------------------
-- PIECES (EXACT BOS MATCH)
--------------------------------------------------------------------------------
local pelvis, aimy1, torso, aimx1, nanol, nanor, flare1, flare2, armor,
      hingefl, hingeml, hingebl, hingefr, hingemr, hingebr,
      legfl, legml, legbl, legfr, legmr, legbr,
      footfl, footml, footbl, footfr, footmr, footbr =
piece(
    "pelvis","aimy1","torso","aimx1","nanol","nanor","flare1","flare2","armor",
    "hingefl","hingeml","hingebl","hingefr","hingemr","hingebr",
    "legfl","legml","legbl","legfr","legmr","legbr",
    "footfl","footml","footbl","footfr","footmr","footbr"
)

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_AIM  = 2

local Stunned = false

--------------------------------------------------------------------------------
-- LEG GROUPS (CRITICAL: correct ordering for SpiderWalk)
--------------------------------------------------------------------------------
local fr = legfr
local mr = legmr
local br = legbr

local fl = legfl
local ml = legml
local bl = legbl

--------------------------------------------------------------------------------
-- WALK SETTINGS
--------------------------------------------------------------------------------
local PERIOD = 0.12
local sleepTime = PERIOD * 1000

local legRaiseAngle = math.rad(30)
local legRaiseSpeed = legRaiseAngle / PERIOD

local legForwardAngle = math.rad(20)
local legForwardOffset = math.rad(-20)
local legForwardTheta = math.rad(25)
local legForwardSpeed = legForwardAngle / PERIOD

local legMiddleAngle = math.rad(20)
local legMiddleOffset = 0
local legMiddleTheta = 0
local legMiddleSpeed = legMiddleAngle / PERIOD

local legBackwardAngle = math.rad(20)
local legBackwardOffset = math.rad(20)
local legBackwardTheta = math.rad(-25)
local legBackwardSpeed = legBackwardAngle / PERIOD


--------------------------------------------------------------------------------
-- WALK
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
-- RESTORE
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
end
--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(aimx1)
    Hide(aimy1)

    -- neutral X stance (matches StopWalking end)
    Turn(hingefl, y_axis, math.rad(-60))
    Turn(hingefr, y_axis, math.rad(60))
    Turn(hingeml, y_axis, 0)
    Turn(hingemr, y_axis, 0)
    Turn(hingebl, y_axis, math.rad(60))
    Turn(hingebr, y_axis, math.rad(-60))

    StartThread(GG.Script.SmokeUnit, unitID, {pelvis, torso})
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
-- AIMING
--------------------------------------------------------------------------------
local restore_delay = 3000

local function RestoreAfterDelay()
    Sleep(restore_delay)
    if Stunned then return end

    Turn(aimy1, y_axis, 0, math.rad(60))
    Turn(aimx1, x_axis, 0, math.rad(30))
end

function script.AimFromWeapon(num)
    return torso
end

function script.QueryWeapon(num)
    -- alternate barrels
    if num == 1 then
        return flare1
    else
        return flare2
    end
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy1, y_axis, heading, math.rad(300))
    Turn(aimx1, x_axis, -pitch, math.rad(200))

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(aimx1, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon(num)
    if num == 1 then
        EmitSfx(flare1, 1024)
    else
        EmitSfx(flare2, 1024)
    end
end

--------------------------------------------------------------------------------
-- BUILD (kept from BOS behavior)
--------------------------------------------------------------------------------
local function BuildAnim()
    while true do
        Turn(nanol, x_axis, math.rad(math.random(-30,30)), math.rad(30))
        Sleep(400)
        Turn(nanor, x_axis, math.rad(math.random(-30,30)), math.rad(30))
        Sleep(400)
    end
end

function script.StartBuilding(heading, pitch)
    Turn(aimy1, y_axis, heading, math.rad(250))
    Turn(aimx1, x_axis, -pitch, math.rad(150))

    WaitForTurn(aimy1, y_axis)

    Show(flare1)
    Show(flare2)

    StartThread(BuildAnim)
end

function script.StopBuilding()
    Hide(flare1)
    Hide(flare2)

    Turn(aimy1, y_axis, 0, math.rad(250))
    Turn(aimx1, x_axis, 0, math.rad(50))

    Turn(nanol, x_axis, 0, math.rad(200))
    Turn(nanor, x_axis, 0, math.rad(200))
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

    -- LIGHT DEATH (mostly intact collapse)
    if severity <= 0.50 then
        Explode(pelvis, SFX.NONE)
        Explode(torso, SFX.NONE)
        Explode(aimx1, SFX.NONE)
        Explode(aimy1, SFX.NONE)

        Explode(fr, SFX.NONE)
        Explode(mr, SFX.NONE)
        Explode(br, SFX.NONE)
        Explode(fl, SFX.NONE)
        Explode(ml, SFX.NONE)
        Explode(bl, SFX.NONE)

        return 1
    end

    -- HEAVY DEATH (full collapse + structural break)
    Explode(pelvis, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(torso,  SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(aimx1,  SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(aimy1,  SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

    Explode(fr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(mr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(br, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

    Explode(fl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(ml, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
    Explode(bl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

    return 2
end