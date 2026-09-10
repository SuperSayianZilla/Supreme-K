include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local chassis, dishTower =
    piece('chassis', 'dishTower')

local dishAStrut, dishA, dishATop1, dishATop2, dishABot1, dishABot2 =
    piece('dishAStrut', 'dishA', 'dishATop1', 'dishATop2', 'dishABot1', 'dishABot2')

local dishBstrut, dishB, dishBTop1, dishBTop2, dishBBot1, dishBBot2 =
    piece('dishBstrut', 'dishB', 'dishBTop1', 'dishBTop2', 'dishBBot1', 'dishBBot2')

local dishCstrut, dishC, dishCTop1, dishCTop2, dishCBot1, dishCBot2 =
    piece('dishCstrut', 'dishC', 'dishCTop1', 'dishCTop2', 'dishCBot1', 'dishCBot2')

local dishDStrut, dishD, dishDTop1, dishDTop2, dishDBot1, dishDBot2 =
    piece('dishDStrut', 'dishD', 'dishDTop1', 'dishDTop2', 'dishDBot1', 'dishDBot2')

local lTrack, rTrack, trackGuards =
    piece('lTrack', 'rTrack', 'trackGuards')

local radarlight1, radarlight2, radarlight3, radarlight4 =
    piece('radarlight1', 'radarlight2', 'radarlight3', 'radarlight4')

--------------------------------------------------------------------------------
-- VARIABLES
--------------------------------------------------------------------------------
local stunned = false
local dead = false

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {
    chassis,
    dishTower,
}

--------------------------------------------------------------------------------
-- LIGHTS
--------------------------------------------------------------------------------
local function LightsThread()

    while not dead do

        if not stunned then
            -- EmitSfx(dishAStrut, 1024)
        end

        Sleep(2500)
    end
end

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function ShowLights()

    Show(radarlight1)
    Show(radarlight2)
    Show(radarlight3)
    Show(radarlight4)
end

local function HideLights()

    Hide(radarlight1)
    Hide(radarlight2)
    Hide(radarlight3)
    Hide(radarlight4)
end

local function StartRadarSpin()

    Spin(dishTower, y_axis, math.rad(100), math.rad(2))

    Spin(dishA, z_axis, math.rad(-100), math.rad(1))
    Spin(dishB, x_axis, math.rad(-100), math.rad(1))
    Spin(dishC, z_axis, math.rad(-100), math.rad(1))
    Spin(dishD, x_axis, math.rad(-100), math.rad(1))
end

local function StopRadarSpin()

    StopSpin(dishTower, y_axis, math.rad(2))

    StopSpin(dishA, z_axis, math.rad(2))
    StopSpin(dishB, x_axis, math.rad(2))
    StopSpin(dishC, z_axis, math.rad(2))
    StopSpin(dishD, x_axis, math.rad(2))
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

    ----------------------------------------------------------------
    -- START FOLDED
    ----------------------------------------------------------------
    Move(dishATop2, z_axis, 1)
    Move(dishABot2, z_axis, 1)
    Turn(dishATop2, x_axis, math.rad(-30))
    Turn(dishABot2, x_axis, math.rad(30))

    Move(dishATop1, z_axis, 1)
    Move(dishABot1, z_axis, 1)
    Turn(dishATop1, x_axis, math.rad(-10))
    Turn(dishABot1, x_axis, math.rad(10))

    Move(dishBTop2, x_axis, -1)
    Move(dishBBot2, x_axis, -1)
    Turn(dishBTop2, z_axis, math.rad(-30))
    Turn(dishBBot2, z_axis, math.rad(30))

    Move(dishBTop1, x_axis, -1)
    Move(dishBBot1, x_axis, -1)
    Turn(dishBTop1, z_axis, math.rad(-10))
    Turn(dishBBot1, z_axis, math.rad(10))

    Move(dishCTop2, z_axis, -1)
    Move(dishCBot2, z_axis, -1)
    Turn(dishCTop2, x_axis, math.rad(30))
    Turn(dishCBot2, x_axis, math.rad(-30))

    Move(dishCTop1, z_axis, -1)
    Move(dishCBot1, z_axis, -1)
    Turn(dishCTop1, x_axis, math.rad(10))
    Turn(dishCBot1, x_axis, math.rad(-10))

    Move(dishDTop2, x_axis, 1)
    Move(dishDBot2, x_axis, 1)
    Turn(dishDTop2, z_axis, math.rad(30))
    Turn(dishDBot2, z_axis, math.rad(-30))

    Move(dishDTop1, x_axis, 1)
    Move(dishDBot1, x_axis, 1)
    Turn(dishDTop1, z_axis, math.rad(10))
    Turn(dishDBot1, z_axis, math.rad(-10))

    HideLights()

    ----------------------------------------------------------------
    -- OPEN SEQUENCE
    ----------------------------------------------------------------
    Turn(dishATop1, x_axis, 0, math.rad(30))
    Turn(dishABot1, x_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishBTop1, z_axis, 0, math.rad(30))
    Turn(dishBBot1, z_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishCTop1, x_axis, 0, math.rad(30))
    Turn(dishCBot1, x_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishDTop1, z_axis, 0, math.rad(30))
    Turn(dishDBot1, z_axis, 0, math.rad(30))

    WaitForTurn(dishABot1, x_axis)

    Move(dishATop1, z_axis, 0, 3)
    Move(dishABot1, z_axis, 0, 3)
    Sleep(100)

    Move(dishBTop1, x_axis, 0, 3)
    Move(dishBBot1, x_axis, 0, 3)
    Sleep(100)

    Move(dishCTop1, z_axis, 0, 3)
    Move(dishCBot1, z_axis, 0, 3)
    Sleep(100)

    Move(dishDTop1, x_axis, 0, 3)
    Move(dishDBot1, x_axis, 0, 3)

    WaitForMove(dishABot1, z_axis)

    ----------------------------------------------------------------
    -- SECONDARY PANELS
    ----------------------------------------------------------------
    Turn(dishATop2, x_axis, 0, math.rad(30))
    Turn(dishABot2, x_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishBTop2, z_axis, 0, math.rad(30))
    Turn(dishBBot2, z_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishCTop2, x_axis, 0, math.rad(30))
    Turn(dishCBot2, x_axis, 0, math.rad(30))
    Sleep(100)

    Turn(dishDTop2, z_axis, 0, math.rad(30))
    Turn(dishDBot2, z_axis, 0, math.rad(30))

    WaitForTurn(dishABot2, x_axis)

    ----------------------------------------------------------------
    -- FINALIZE
    ----------------------------------------------------------------
    Move(dishATop2, z_axis, 0, 3)
    Move(dishABot2, z_axis, 0, 3)

    Spin(dishA, z_axis, math.rad(-100), math.rad(1))

    Sleep(200)

    Move(dishBTop2, x_axis, 0, 3)
    Move(dishBBot2, x_axis, 0, 3)

    Spin(dishB, x_axis, math.rad(-100), math.rad(1))

    Sleep(200)

    Move(dishCTop2, z_axis, 0, 3)
    Move(dishCBot2, z_axis, 0, 3)

    Spin(dishC, z_axis, math.rad(-100), math.rad(1))

    Sleep(100)

    Move(dishDTop2, x_axis, 0, 3)
    Move(dishDBot2, x_axis, 0, 3)

    Spin(dishD, x_axis, math.rad(-100), math.rad(1))

    WaitForMove(dishABot2, z_axis)

    ----------------------------------------------------------------
    -- RADAR ONLINE
    ----------------------------------------------------------------
    StartRadarSpin()
    ShowLights()

    ----------------------------------------------------------------
    -- THREADS
    ----------------------------------------------------------------
    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)
    StartThread(LightsThread)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
end

function script.StopMoving()
end

--------------------------------------------------------------------------------
-- ACTIVATE / DEACTIVATE
--------------------------------------------------------------------------------
function script.Activate()
    return 0
end

function script.Deactivate()
    return 0
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(state)

    stunned = state

    if stunned then

        StopRadarSpin()
        HideLights()

    else

        StartRadarSpin()
        ShowLights()
    end
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

    dead = true

    StopRadarSpin()
    HideLights()

    local severity = recentDamage / math.max(maxHealth, 1)

    ----------------------------------------------------------------
    -- LIGHT
    ----------------------------------------------------------------
    if severity < 0.5 then

        Explode(dishA, SFX.SMOKE)
        Explode(dishB, SFX.SMOKE)
        Explode(dishC, SFX.SMOKE)
        Explode(dishTower, SFX.SMOKE)

        return 1
    end

    ----------------------------------------------------------------
    -- HEAVY
    ----------------------------------------------------------------
    Explode(chassis, SFX.EXPLODE + SFX.FIRE + SFX.SMOKE + SFX.FALL)

    Explode(dishA, SFX.EXPLODE + SFX.FIRE)
    Explode(dishB, SFX.EXPLODE + SFX.FIRE)
    Explode(dishC, SFX.EXPLODE + SFX.FIRE)
    Explode(dishD, SFX.EXPLODE + SFX.FIRE)

    Explode(dishTower, SFX.EXPLODE + SFX.FIRE + SFX.SMOKE)

    return 2
end