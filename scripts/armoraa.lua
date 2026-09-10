include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local Base = piece("Base")

local flare1, flare2 = piece("flare1", "flare2")

local aimy1 = piece("aimy1")
local turret = piece("turret")
local aimx1 = piece("aimx1")

local sleeve = piece("sleeve")
local nanogun = piece("nanogun")

local larmor = piece("larmor")
local rarmor = piece("rarmor")

local susfl = piece("susfl")
local susfr = piece("susfr")
local susbl = piece("susbl")
local susbr = piece("susbr")

local wheelfl = piece("wheelfl")
local wheelfr = piece("wheelfr")
local wheelbl = piece("wheelbl")
local wheelbr = piece("wheelbr")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_AIM = 1

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------

local gun = 1

--------------------------------------------------------------------------------
-- WHEEL CONTROL
--------------------------------------------------------------------------------

local function WheelControl()

    while true do

        local vx, _, vz = Spring.GetUnitVelocity(unitID)

        if vx then
            local speed = math.sqrt(vx * vx + vz * vz)
            local wheelSpeed = speed * 8

            Spin(wheelfl, x_axis, wheelSpeed)
            Spin(wheelfr, x_axis, wheelSpeed)
            Spin(wheelbl, x_axis, wheelSpeed)
            Spin(wheelbr, x_axis, wheelSpeed)
        end

        Sleep(100)
    end
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()

    Hide(flare1)
    Hide(flare2)

    -- permanently deployed pose

    Turn(rarmor, z_axis, math.rad(30))
    Turn(larmor, z_axis, math.rad(-30))

    Turn(susfl, x_axis, math.rad(15))
    Turn(susfr, x_axis, math.rad(15))

    Turn(susbl, x_axis, math.rad(-45))
    Turn(susbr, x_axis, math.rad(-45))

    Move(Base, y_axis, 4)

    Turn(Base, x_axis, math.rad(10))

    Turn(turret, x_axis, math.rad(90))

    Move(aimy1, z_axis, 7)

    Move(nanogun, y_axis, -4)

    StartThread(WheelControl)
end

--------------------------------------------------------------------------------
-- WEAPON
--------------------------------------------------------------------------------

function script.QueryWeapon(num)

    if gun == 1 then
        gun = 2
        return flare1
    else
        gun = 1
        return flare2
    end
end

function script.AimFromWeapon(num)
    return turret
end

function script.AimWeapon(num, heading, pitch)

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy1, y_axis, heading + math.rad(180), math.rad(360))

    -- positive pitch
    Turn(aimx1, x_axis, pitch, math.rad(180))

    WaitForTurn(aimy1, y_axis)
    WaitForTurn(aimx1, x_axis)

    return true
end

function script.FireWeapon(num)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

function script.StartMoving()
end

function script.StopMoving()
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

    local severity = recentDamage / maxHealth

    if severity < 0.25 then

        Explode(Base, SFX.NONE)
        Explode(turret, SFX.NONE)
        Explode(rarmor, SFX.NONE)

        Explode(sleeve, SFX.SMOKE + SFX.FALL)

        return 1

    elseif severity < 0.50 then

        Explode(Base, SFX.NONE)
        Explode(turret, SFX.NONE)
        Explode(rarmor, SFX.NONE)

        Explode(sleeve, SFX.SMOKE + SFX.FALL)

        return 2

    elseif severity < 0.99 then

        Explode(Base, SFX.FIRE + SFX.SMOKE + SFX.FALL)
        Explode(turret, SFX.FIRE + SFX.SMOKE + SFX.FALL)
        Explode(rarmor, SFX.FIRE + SFX.SMOKE + SFX.FALL)

        Explode(sleeve, SFX.SHATTER + SFX.SMOKE + SFX.FALL)

        return 3

    else

        Explode(Base, SFX.FIRE + SFX.SMOKE + SFX.FALL)

        Explode(turret,
            SFX.SHATTER +
            SFX.FIRE +
            SFX.SMOKE +
            SFX.FALL)

        Explode(rarmor,
            SFX.SHATTER +
            SFX.FIRE +
            SFX.FALL)

        Explode(sleeve,
            SFX.SHATTER +
            SFX.FIRE +
            SFX.FALL)

        return 3
    end
end