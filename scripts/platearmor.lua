include "constants.lua"
include "plates.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local base = piece "base"

local buildlightLBase = piece "buildlightLBase"
local buildlightL = piece "buildlightL"
local buildlightRBase = piece "buildlightRBase"
local buildlightR = piece "buildlightR"

local buildlightLPoint = piece "buildlightLPoint"
local buildlightRPoint = piece "buildlightRPoint"

local cannisterLight  = piece "cannisterLight"
local cannisterLight2 = piece "cannisterLight2"
local cannisterLight3 = piece "cannisterLight3"

local pipeLight1 = piece "pipeLight1"
local pipeLight2 = piece "pipeLight2"

local smokePoint = piece "smokePoint"

local doorA = piece "doorA"
local platformA1 = piece "platformA1"
local paltformA2 = piece "paltformA2"

local doorB = piece "doorB"
local platformB1 = piece "platformB1"
local platformB2 = piece "platformB2"

local doorC = piece "doorC"
local platformC1 = piece "platformC1"
local platformC2 = piece "platformC2"

local doorD = piece "doorD"

local gateL1 = piece "gateL1"
local gateL2 = piece "gateL2"
local gateL3 = piece "gateL3"

local gateR1 = piece "gateR1"
local gateR2 = piece "gateR2"
local gateR3 = piece "gateR3"

local nanoarmL1 = piece "nanoarmL1"
local nanoarmL2 = piece "nanoarmL2"
local nanoarmL3 = piece "nanoarmL3"

local nanoarmR1 = piece "nanoarmR1"
local nanoarmR2 = piece "nanoarmR2"
local nanoarmR3 = piece "nanoarmR3"

local sprayL1A = piece "sprayL1A"
local sprayL1B = piece "sprayL1B"
local sprayL2A = piece "sprayL2A"
local sprayL2B = piece "sprayL2B"
local sprayL3A = piece "sprayL3A"
local sprayL3B = piece "sprayL3B"

local sprayR1A = piece "sprayR1A"
local sprayR1B = piece "sprayR1B"
local sprayR2A = piece "sprayR2A"
local sprayR2B = piece "sprayR2B"
local sprayR3A = piece "sprayR3A"
local sprayR3B = piece "sprayR3B"

local pad = piece "pad"

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_BUILD = 1
local SIG_OPEN  = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------

local spray = 0
local isOpen = false

local sprayPieces = {
    sprayL1A,
    sprayL1B,
    sprayL2A,
    sprayL2B,
    sprayL3A,
    sprayL3B,
    sprayR1A,
    sprayR1B,
    sprayR2A,
    sprayR2B,
    sprayR3A,
    sprayR3B,
}

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------

local function ShowBuildFX()

    Show(buildlightLPoint)
    Show(buildlightRPoint)

    Show(cannisterLight)
    Show(cannisterLight2)
    Show(cannisterLight3)

    Show(pipeLight1)
    Show(pipeLight2)

    Show(sprayL1A)
    Show(sprayL2A)
    Show(sprayL3A)

    Show(sprayR1A)
    Show(sprayR2A)
    Show(sprayR3A)

end

local function HideBuildFX()

    Hide(buildlightLPoint)
    Hide(buildlightRPoint)

    Hide(cannisterLight)
    Hide(cannisterLight2)
    Hide(cannisterLight3)

    Hide(pipeLight1)
    Hide(pipeLight2)

    for i = 1, #sprayPieces do
        Hide(sprayPieces[i])
    end
end

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------

local function SmokeLoop()

    Signal(SIG_BUILD)
    SetSignalMask(SIG_BUILD)

    while true do
        EmitSfx(smokePoint, 258)
        Sleep(45)

        EmitSfx(smokePoint, 258)
        Sleep(500)
    end
end

--------------------------------------------------------------------------------
-- CRANES
--------------------------------------------------------------------------------

local function MoveCranes()

    SetSignalMask(SIG_BUILD)

    while true do

        -- swapped signs to match Spring piece orientation
        Turn(nanoarmR1, z_axis, math.rad(-15), math.rad(20))
        Turn(nanoarmL1, z_axis, math.rad(15), math.rad(20))

        Turn(nanoarmR2, z_axis, math.rad(-15), math.rad(20))
        Turn(nanoarmL2, z_axis, math.rad(15), math.rad(20))

        Turn(nanoarmR3, z_axis, math.rad(-15), math.rad(20))
        Turn(nanoarmL3, z_axis, math.rad(15), math.rad(20))

        WaitForTurn(nanoarmR1, z_axis)

        Turn(nanoarmR1, z_axis, math.rad(-60), math.rad(20))
        Turn(nanoarmL1, z_axis, math.rad(60), math.rad(20))

        Turn(nanoarmR2, z_axis, math.rad(-60), math.rad(20))
        Turn(nanoarmL2, z_axis, math.rad(60), math.rad(20))

        Turn(nanoarmR3, z_axis, math.rad(-60), math.rad(20))
        Turn(nanoarmL3, z_axis, math.rad(60), math.rad(20))

        WaitForTurn(nanoarmR1, z_axis)

    end
end

--------------------------------------------------------------------------------
-- OPEN
--------------------------------------------------------------------------------

local function Open()

    Signal(SIG_OPEN)
    SetSignalMask(SIG_OPEN)

    isOpen = true

    Move(gateL1, y_axis, 15, 75)
    Move(gateL2, y_axis, 15, 75)
    Move(gateL3, y_axis, 15, 75)

    Move(gateR1, y_axis, 15, 75)
    Move(gateR2, y_axis, 15, 75)
    Move(gateR3, y_axis, 15, 75)

    WaitForMove(gateR3, y_axis)

    -- swapped signs to match Spring piece orientation
    Turn(gateR1, z_axis, math.rad(70), math.rad(200))
    Turn(gateL1, z_axis, math.rad(-70), math.rad(200))

    Sleep(50)

    Turn(gateR2, z_axis, math.rad(70), math.rad(200))
    Turn(gateL2, z_axis, math.rad(-70), math.rad(200))

    Sleep(50)

    Turn(gateR3, z_axis, math.rad(70), math.rad(200))
    Turn(gateL3, z_axis, math.rad(-70), math.rad(200))

    Sleep(50)

    Move(doorA, y_axis, -31, 130)
    Sleep(50)

    Move(doorB, y_axis, -31, 130)
    Sleep(50)

    Move(doorC, y_axis, -31, 130)
    Sleep(50)

    Move(doorD, y_axis, -31, 130)

    WaitForMove(doorD, y_axis)

    Move(platformA1, z_axis, -6, 65)
    Move(paltformA2, z_axis, -6, 65)
    Sleep(50)

    Move(platformB1, z_axis, -6, 65)
    Move(platformB2, z_axis, -6, 65)
    Sleep(50)

    Move(platformC1, z_axis, -6, 65)
    Move(platformC2, z_axis, -6, 65)

    WaitForTurn(gateL3, z_axis)

    Move(buildlightL, y_axis, 0, 1)
    Move(buildlightR, y_axis, 0, 1)

    -- swapped signs to match Spring piece orientation
    Turn(nanoarmR1, z_axis, math.rad(-60), math.rad(65))
    Turn(nanoarmL1, z_axis, math.rad(60), math.rad(65))
    Sleep(10)

    Turn(nanoarmR2, z_axis, math.rad(-60), math.rad(65))
    Turn(nanoarmL2, z_axis, math.rad(60), math.rad(65))
    Sleep(10)

    Turn(nanoarmR3, z_axis, math.rad(-60), math.rad(65))
    Turn(nanoarmL3, z_axis, math.rad(60), math.rad(65))
    Sleep(50)

    Spin(buildlightL, y_axis, math.rad(200), math.rad(2))
    Spin(buildlightR, y_axis, math.rad(200), math.rad(2))

    ShowBuildFX()

SetInBuildDistance(true)

end

--------------------------------------------------------------------------------
-- CLOSE
--------------------------------------------------------------------------------

local function Close()

    Signal(SIG_OPEN)
    SetSignalMask(SIG_OPEN)

    isOpen = false

SetInBuildDistance(false)

    Sleep(5000)

    Turn(nanoarmR3, z_axis, 0, math.rad(45))
    Sleep(25)

    Turn(nanoarmL3, z_axis, 0, math.rad(45))
    Sleep(25)

    Turn(nanoarmR2, z_axis, 0, math.rad(45))
    Sleep(25)

    Turn(nanoarmL2, z_axis, 0, math.rad(45))
    Sleep(25)

    Turn(nanoarmR1, z_axis, 0, math.rad(45))
    Sleep(25)

    Turn(nanoarmL1, z_axis, 0, math.rad(45))
    Sleep(25)

    WaitForTurn(nanoarmL1, z_axis)

    Move(platformC1, z_axis, 0, 25)
    Sleep(25)

    Move(platformC2, z_axis, 0, 25)
    Sleep(25)

    Move(platformB1, z_axis, 0, 25)
    Sleep(25)

    Move(platformB2, z_axis, 0, 25)
    Sleep(25)

    Move(platformA1, z_axis, 0, 25)
    Sleep(25)

    Move(paltformA2, z_axis, 0, 25)
    Sleep(25)

    WaitForMove(paltformA2, z_axis)

    Move(doorD, y_axis, 0, 40)
    Sleep(50)

    Move(doorC, y_axis, 0, 40)
    Sleep(50)

    Move(doorB, y_axis, 0, 40)
    Sleep(50)

    Move(doorA, y_axis, 0, 40)

    -- swapped signs to match Spring piece orientation
    Turn(gateR1, z_axis, 0, math.rad(90))
    Turn(gateL1, z_axis, 0, math.rad(90))
    Sleep(25)

    Turn(gateR2, z_axis, 0, math.rad(90))
    Turn(gateL2, z_axis, 0, math.rad(90))
    Sleep(25)

    Turn(gateR3, z_axis, 0, math.rad(90))
    Turn(gateL3, z_axis, 0, math.rad(90))

    WaitForTurn(gateL3, z_axis)

    Move(buildlightL, y_axis, -2, 2)
    Move(buildlightR, y_axis, -2, 2)

    Move(gateL1, y_axis, 0, 15)
    Move(gateR1, y_axis, 0, 15)
    Sleep(25)

    Move(gateL2, y_axis, 0, 15)
    Move(gateR2, y_axis, 0, 15)
    Sleep(25)

    Move(gateL3, y_axis, 0, 15)
    Move(gateR3, y_axis, 0, 15)

    HideBuildFX()

end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------

function script.Create()

    HideBuildFX()

    Move(buildlightL, y_axis, -2)
    Move(buildlightR, y_axis, -2)

end

--------------------------------------------------------------------------------
-- FACTORY CONTROL
--------------------------------------------------------------------------------

function script.Activate()
    StartThread(Open)
end

function script.Deactivate()
    StartThread(Close)
end

--------------------------------------------------------------------------------
-- BUILDING
--------------------------------------------------------------------------------

function script.StartBuilding()

    Signal(SIG_BUILD)

    StartThread(MoveCranes)
    StartThread(SmokeLoop)

end

function script.StopBuilding()

    Signal(SIG_BUILD)

    StopSpin(buildlightL, y_axis, math.rad(2))
    StopSpin(buildlightR, y_axis, math.rad(2))

end

--------------------------------------------------------------------------------
-- NANO QUERY
--------------------------------------------------------------------------------

function script.QueryNanoPiece()

    spray = (spray % #sprayPieces) + 1

    return sprayPieces[spray]

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

    if severity <= 0.5 then
        return 1
    elseif severity <= 0.99 then

        Explode(pad, SFX.SMOKE + SFX.FALL)

        return 2
    end

    return 3
end