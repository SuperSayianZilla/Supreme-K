include "constants.lua"
include "plates.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base = piece("base")

local nanoFlareR1, nanoFlareR2 = piece("nanoFlareR1", "nanoFlareR2")
local nanoFlareL1, nanoFlareL2 = piece("nanoFlareL1", "nanoFlareL2")

local fan1, fan2, fan3, fan4 = piece("fan1", "fan2", "fan3", "fan4")
local backFan1, backFan2, backFan3, backFan4 =
    piece("backFan1", "backFan2", "backFan3", "backFan4")

local buildLight1, buildLight2, buildLight3, buildLight4 =
    piece("buildLight1", "buildLight2", "buildLight3", "buildLight4")

local smokeFlare = piece("smokeFlare")
local pad = piece("pad")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_BUILD = 1

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local spray = 0

--------------------------------------------------------------------------------
-- FAN LOOP (ALWAYS ON)
--------------------------------------------------------------------------------
local function FanLoop()
    while true do
        EmitSfx(fan1, 259); Sleep(50)
        EmitSfx(fan2, 259); Sleep(50)
        EmitSfx(fan3, 259); Sleep(50)
        EmitSfx(fan4, 259); Sleep(50)

        EmitSfx(backFan1, 259); Sleep(50)
        EmitSfx(backFan2, 259); Sleep(50)
        EmitSfx(backFan3, 259); Sleep(50)
        EmitSfx(backFan4, 259); Sleep(50)
    end
end

--------------------------------------------------------------------------------
-- SMOKE LOOP (BUILD ONLY)
--------------------------------------------------------------------------------
local function SmokeLoop()
    Signal(SIG_BUILD)
    SetSignalMask(SIG_BUILD)

    while true do
        EmitSfx(smokeFlare, 259)
        Sleep(45)
        EmitSfx(smokeFlare, 259)
        Sleep(500)
    end
end

--------------------------------------------------------------------------------
-- BUILD CONTROL
--------------------------------------------------------------------------------
function script.StartBuilding()
    Show(nanoFlareR1); Show(nanoFlareR2)
    Show(nanoFlareL1); Show(nanoFlareL2)

    Spin(buildLight1, y_axis, math.rad(100))
    Spin(buildLight2, y_axis, math.rad(100))
    Spin(buildLight3, y_axis, math.rad(100))
    Spin(buildLight4, y_axis, math.rad(100))

    StartThread(SmokeLoop)
end

function script.StopBuilding()
    Signal(SIG_BUILD)

    Hide(nanoFlareR1); Hide(nanoFlareR2)
    Hide(nanoFlareL1); Hide(nanoFlareL2)

    StopSpin(buildLight1, y_axis, math.rad(5))
    StopSpin(buildLight2, y_axis, math.rad(5))
    StopSpin(buildLight3, y_axis, math.rad(5))
    StopSpin(buildLight4, y_axis, math.rad(5))
end

--------------------------------------------------------------------------------
-- NANO PIECE CYCLING
--------------------------------------------------------------------------------
local nanoFlareR = {nanoFlareR1, nanoFlareR2}
local nanoFlareL = {nanoFlareL1, nanoFlareL2}

function script.QueryNanoPiece()
    spray = (spray + 1) % 4

    if spray < 2 then
        return nanoFlareR[spray + 1]
    else
        return nanoFlareL[spray - 1]
    end
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(nanoFlareR1); Hide(nanoFlareR2)
    Hide(nanoFlareL1); Hide(nanoFlareL2)

    -- idle fans always on
    Spin(fan1, x_axis, math.rad(50))
    Spin(fan2, x_axis, math.rad(50))
    Spin(fan3, x_axis, math.rad(50))
    Spin(fan4, x_axis, math.rad(50))

    Spin(backFan1, x_axis, math.rad(50))
    Spin(backFan2, x_axis, math.rad(50))
    Spin(backFan3, x_axis, math.rad(50))
    Spin(backFan4, x_axis, math.rad(50))

    StartThread(FanLoop)
end

--------------------------------------------------------------------------------
-- ACTIVATE / DEACTIVATE (NO ANIMATION)
--------------------------------------------------------------------------------
function script.Activate()
    SetInBuildDistance(true)
end

function script.Deactivate()
    SetInBuildDistance(false)
end

--------------------------------------------------------------------------------
-- BUILD INFO
--------------------------------------------------------------------------------
function script.QueryBuildInfo()
    return pad
end

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity < 0.5 then
        Explode(base, SFX.SMOKE)
        return 1
    else
        Explode(base, SFX.SHATTER)
        return 2
    end
end