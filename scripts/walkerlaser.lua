include "constants.lua"
include "spider_walking.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local flare1, pelvis, aimy1, turret, aimx1, turretarm, sleeve, wedge, barrel,
      sleelvedeco1, sleevedeco2, armor,
      hingefl, hingefr, hingeml, hingemr, hingebl, hingebr,
      thighfl, thighfr, thighml, thighmr, thighbl, thighbr,
      legfl, legfr, legml, legmr, legbl, legbr,
      footfl, footfr, footml, footmr, footbl, footbr =
piece('flare1','pelvis','aimy1','turret','aimx1','turretarm','sleeve','wedge','barrel',
      'sleelvedeco1','sleevedeco2','armor',
      'hingefl','hingefr','hingeml','hingemr','hingebl','hingebr',
      'thighfl','thighfr','thighml','thighmr','thighbl','thighbr',
      'legfl','legfr','legml','legmr','legbl','legbr',
      'footfl','footfr','footml','footmr','footbl','footbr')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_AIM  = 2

local isAiming = false
local Stunned = false

--------------------------------------------------------------------------------
-- LEG SETS (SpiderWalk expects grouped legs)
--------------------------------------------------------------------------------
local br, mr, fr = thighbr, thighmr, thighfr
local bl, ml, fl = thighbl, thighml, thighfl

--------------------------------------------------------------------------------
-- WALK SETTINGS (tuned defaults)
--------------------------------------------------------------------------------
local PERIOD = 0.335
local sleepTime = PERIOD * 1000

local legRaiseAngle = math.rad(30)
local legRaiseSpeed  = legRaiseAngle / PERIOD

local legForwardAngle = math.rad(20)
local legForwardTheta = math.rad(25)
local legForwardOffset = math.rad(-20)
local legForwardSpeed = legForwardAngle / PERIOD

local legMiddleAngle = math.rad(20)
local legMiddleTheta = 0
local legMiddleOffset = 0
local legMiddleSpeed = legMiddleAngle / PERIOD

local legBackwardAngle = math.rad(20)
local legBackwardTheta = math.rad(-25)
local legBackwardOffset = math.rad(20)
local legBackwardSpeed = legBackwardAngle / PERIOD

--------------------------------------------------------------------------------
-- WALK (FULL REPLACEMENT: SpiderWalk)
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
-- RESTORE LEGS
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
    Hide(aimy1)
    Hide(aimx1)

    Spin(sleelvedeco1, z_axis, math.rad(360))
    Spin(sleevedeco2, z_axis, math.rad(-360))

    Turn(hingebl, y_axis, math.rad(-30))
    Turn(hingebr, y_axis, math.rad(30))
    Turn(hingefl, y_axis, math.rad(30))
    Turn(hingefr, y_axis, math.rad(-30))

    Hide(wedge)
    if math.random(100) > 98 then
        Move(wedge, y_axis, 5)
        Show(wedge)
    end

    StartThread(GG.Script.SmokeUnit, unitID, {pelvis, turret})
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
    Turn(sleeve, x_axis, 0, math.rad(30))

    isAiming = false
end

function script.AimFromWeapon(num)
    return sleeve
end

function script.QueryWeapon(num)
    return flare1
end

function script.AimWeapon(num, heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    isAiming = true

    Turn(aimy1, y_axis, heading, math.rad(260))
    Turn(aimx1, x_axis, -pitch, math.rad(260))

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(aimx1, x_axis)

    StartThread(RestoreAfterDelay)
    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
local function Fire()
    EmitSfx(flare1, 1024)

    StopSpin(sleelvedeco1, z_axis, math.rad(30))
    StopSpin(sleevedeco2, z_axis, math.rad(30))

    Turn(turretarm, x_axis, math.rad(-5), math.rad(260))
    Move(barrel, z_axis, -10, 50)

    WaitForTurn(turretarm, x_axis)

    Sleep(100)

    Turn(turretarm, x_axis, 0, math.rad(15))

    Sleep(300)

    Move(barrel, z_axis, 0, 8)

    Spin(sleelvedeco1, z_axis, math.rad(360))
    Spin(sleevedeco2, z_axis, math.rad(-360))
end

function script.FireWeapon(num)
    Fire()
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
--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.5 then
        -- LIGHT DEATH: mostly intact collapse
        Explode(pelvis,      SFX.NONE)
        Explode(turret,      SFX.NONE)
        Explode(sleeve,      SFX.NONE)
        Explode(barrel,      SFX.NONE)

        Explode(legfl, SFX.NONE)
        Explode(legfr, SFX.NONE)
        Explode(legml, SFX.NONE)
        Explode(legmr, SFX.NONE)
        Explode(legbl, SFX.NONE)
        Explode(legbr, SFX.NONE)

        Explode(thighfl, SFX.NONE)
        Explode(thighfr, SFX.NONE)
        Explode(thighml, SFX.NONE)
        Explode(thighmr, SFX.NONE)
        Explode(thighbl, SFX.NONE)
        Explode(thighbr, SFX.NONE)

        return 1
    else
        -- HEAVY DEATH: full disintegration
        Explode(pelvis, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(turret, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(aimy1,  SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(aimx1,  SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        Explode(sleeve, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(barrel, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(turretarm, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        Explode(legfl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(legfr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(legml, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(legmr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(legbl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(legbr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        Explode(thighfl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(thighfr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(thighml, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(thighmr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(thighbl, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)
        Explode(thighbr, SFX.FALL + SFX.SMOKE + SFX.FIRE + SFX.EXPLODE_ON_HIT)

        return 2
    end
end