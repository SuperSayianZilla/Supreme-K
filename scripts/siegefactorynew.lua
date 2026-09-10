include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base = piece "base"
local pad = piece "pad"

local arml = piece "arml"
local armr = piece "armr"
local nanol = piece "nanol"
local nanor = piece "nanor"

local exhaust = piece "exhaust"

local ventsmoke1 = piece "ventsmoke1"
local ventsmoke2 = piece "ventsmoke2"

local cagelight1 = piece "cagelight1"
local cagelight2 = piece "cagelight2"
local cagelight1_emit = piece "cagelight1_emit"
local cagelight2_emit = piece "cagelight2_emit"

local flares = {}
for i = 1, 8 do
    flares[i] = piece("flare" .. i)
end

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_BUILD  = 2
local SIG_ANIM   = 1

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local spray = 1
local open = false

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function GetDisabled()
    return Spring.GetUnitIsStunned(unitID)
        or (Spring.GetUnitRulesParam(unitID,"disarmed") == 1)
end

--------------------------------------------------------------------------------
-- NANO PIECE CYCLING
--------------------------------------------------------------------------------
function script.QueryNanoPiece()
    spray = spray + 1
    if spray > 8 then spray = 1 end
    return flares[spray]
end

--------------------------------------------------------------------------------
-- CRANE ANIMATION
--------------------------------------------------------------------------------
local function MoveCranes()
    Signal(SIG_BUILD)
    SetSignalMask(SIG_BUILD)

    while true do
        -- LEFT SIDE
        Turn(nanol, y_axis, math.rad(math.random(-45,45)), math.rad(90))
        Turn(arml,  z_axis, math.rad(math.random(-50,30)), math.rad(90))

        Sleep(400)
        EmitSfx(ventsmoke1, 257)

        Sleep(400)
        EmitSfx(ventsmoke2, 257)

        -- RIGHT SIDE
        Turn(nanor, y_axis, math.rad(math.random(-45,45)), math.rad(90))
        Turn(armr,  z_axis, math.rad(math.random(-30,50)), math.rad(90))

        Sleep(400)
        EmitSfx(ventsmoke1, 257)

        Sleep(400)
        EmitSfx(ventsmoke2, 257)
    end
end

--------------------------------------------------------------------------------
-- OPEN
--------------------------------------------------------------------------------
local function Open()
    if open then return end

    Signal(SIG_ANIM)
    SetSignalMask(SIG_ANIM)
    open = true

    while GetDisabled() do Sleep(300) end

    -- raise arms + exhaust
    Move(arml, y_axis, 10, 10)
    Move(armr, y_axis, 10, 10)
    Move(exhaust, y_axis, 6, 8)

    WaitForMove(arml, y_axis)

    SetUnitValue(COB.INBUILDSTANCE, 1)
    SetUnitValue(COB.YARD_OPEN, 1)

    GG.Script.UnstickFactory(unitID)
end

--------------------------------------------------------------------------------
-- CLOSE
--------------------------------------------------------------------------------
local function Close()
    if not open then return end

    Signal(SIG_ANIM)
    SetSignalMask(SIG_ANIM)
    open = false

    SetUnitValue(COB.INBUILDSTANCE, 0)
    SetUnitValue(COB.YARD_OPEN, 0)

    Sleep(5000)

    while GetDisabled() do Sleep(300) end

    Turn(arml, z_axis, 0, math.rad(30))
    Turn(armr, z_axis, 0, math.rad(30))
    Turn(nanol, y_axis, 0, math.rad(30))
    Turn(nanor, y_axis, 0, math.rad(30))

    WaitForTurn(nanol, y_axis)

    Move(arml, y_axis, 0, 10)
    Move(armr, y_axis, 0, 10)
    Move(exhaust, y_axis, 0, 8)

    WaitForMove(arml, y_axis)
end

--------------------------------------------------------------------------------
-- BUILD START
--------------------------------------------------------------------------------
function script.StartBuilding()
    -- show flares
    for i = 1, 8 do
        Show(flares[i])
    end

    Show(cagelight1_emit)
    Show(cagelight2_emit)

    Move(cagelight1, y_axis, 2, 8)
    Move(cagelight2, y_axis, 2, 8)

    Spin(cagelight1_emit, y_axis, math.rad(200), math.rad(100))
    Spin(cagelight2_emit, y_axis, math.rad(200), math.rad(100))

    StartThread(MoveCranes)
end

--------------------------------------------------------------------------------
-- BUILD STOP
--------------------------------------------------------------------------------
function script.StopBuilding()
    Signal(SIG_BUILD)

    for i = 1, 8 do
        Hide(flares[i])
    end

    Hide(cagelight1_emit)
    Hide(cagelight2_emit)

    Move(cagelight1, y_axis, 0, 8)
    Move(cagelight2, y_axis, 0, 8)

    StopSpin(cagelight1_emit, y_axis, math.rad(100))
    StopSpin(cagelight2_emit, y_axis, math.rad(100))
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(pad)
    Hide(ventsmoke1)
    Hide(ventsmoke2)

    for i = 1, 8 do
        Hide(flares[i])
    end

    Hide(cagelight1_emit)
    Hide(cagelight2_emit)

    Spring.SetUnitNanoPieces(unitID, flares)

    StartThread(GG.Script.SmokeUnit, unitID, {exhaust, ventsmoke1, ventsmoke2})
end

--------------------------------------------------------------------------------
-- ACTIVATION
--------------------------------------------------------------------------------
function script.Activate()
    StartThread(Open)
end

local firstDeactivate = true
function script.Deactivate()
    if firstDeactivate then
        firstDeactivate = false
        return
    end
    StartThread(Close)
end

--------------------------------------------------------------------------------
-- BUILD INFO
--------------------------------------------------------------------------------
function script.QueryBuildInfo()
    return pad
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    Explode(base, SFX.SHATTER)

    if severity < 0.5 then
        Explode(exhaust, SFX.FALL)
        Explode(armr, SFX.FALL)
        Explode(nanol, SFX.FALL)
        Explode(nanor, SFX.FALL)
        return 1
    else
        Explode(exhaust, SFX.FIRE + SFX.SMOKE + SFX.FALL)
        Explode(armr, SFX.FIRE + SFX.FALL)
        Explode(nanol, SFX.FIRE + SFX.FALL)
        Explode(nanor, SFX.FIRE + SFX.FALL)
        return 2
    end
end