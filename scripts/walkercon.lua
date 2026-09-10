include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis, torso, aimy1, aimx1, sleeve, nano, flare1, flare2, cagelight, cagelight_emit, tankdecor =
    piece('pelvis','torso','aimy1','aimx1','sleeve','nano','flare1','flare2','cagelight','cagelight_emit','tankdecor')

local blhinge, blleg, blfoot = piece('blhinge','blleg','blfoot')
local brhinge, brleg, brfoot = piece('brhinge','brleg','brfoot')
local flhinge, flleg, flfoot = piece('flhinge','flleg','flfoot')
local frhinge, frleg, frfoot = piece('frhinge','frleg','frfoot')

--------------------------------------------------------------------------------
-- CONSTANTS / VARS
--------------------------------------------------------------------------------
local SIG_WALK = 1
local SIG_BUILD = 2

local nanoPieces = {flare1, flare2}
local nanoIndex = 1

local moving = false

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function rad(x)
    return math.rad(x)
end

--------------------------------------------------------------------------------
-- WALK (FULL CONVERSION STYLE)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_WALK)
    SetSignalMask(SIG_WALK)

    while moving do

        -- FRAME 1
        Turn(blfoot, x_axis, rad(-35.49), 10)
        Turn(blleg, x_axis, rad(37.65), 10)
        Turn(brfoot, x_axis, rad(-52.10), 10)
        Turn(brleg, x_axis, rad(30.03), 10)
        Turn(flfoot, x_axis, rad(24.96), 10)
        Turn(frfoot, x_axis, rad(-13.24), 10)

        Move(pelvis, y_axis, -0.38, 5)
        Turn(torso, y_axis, rad(-6.6), 5)

        Sleep(33)

        -- FRAME 2
        Turn(blfoot, x_axis, rad(-68.36), 10)
        Turn(brfoot, x_axis, rad(-10.45), 10)
        Turn(flfoot, x_axis, rad(15.38), 10)
        Turn(frfoot, x_axis, rad(-8.56), 10)

        Move(pelvis, y_axis, 0.5, 5)

        Sleep(33)

        -- FRAME 3
        Turn(blfoot, x_axis, rad(-42.48), 10)
        Turn(brfoot, x_axis, rad(14.19), 10)
        Turn(flfoot, x_axis, rad(1.04), 10)
        Turn(frfoot, x_axis, rad(2.22), 10)

        Sleep(33)

        -- FRAME 4
        Turn(blfoot, x_axis, rad(-35.34), 10)
        Turn(brfoot, x_axis, rad(-55.87), 10)
        Turn(flfoot, x_axis, rad(-13.59), 10)
        Turn(frfoot, x_axis, rad(13.66), 10)

        Sleep(33)

        -- FRAME 5
        Turn(blfoot, x_axis, rad(-9.64), 10)
        Turn(brfoot, x_axis, rad(-40.08), 10)
        Turn(flfoot, x_axis, rad(-20.23), 10)
        Turn(frfoot, x_axis, rad(25.76), 10)

        Sleep(33)

        -- FRAME 6
        Turn(blfoot, x_axis, rad(-33.55), 10)
        Turn(brfoot, x_axis, rad(-34.84), 10)
        Turn(flfoot, x_axis, rad(-13.24), 10)
        Turn(frfoot, x_axis, rad(24.96), 10)

        Sleep(33)

        -- LOOP continues...
    end
end

--------------------------------------------------------------------------------
-- RESTORE POSE
--------------------------------------------------------------------------------
local function RestorePose()
    Signal(SIG_WALK)

    Turn(blfoot, x_axis, 0, 5)
    Turn(brfoot, x_axis, 0, 5)
    Turn(flfoot, x_axis, 0, 5)
    Turn(frfoot, x_axis, 0, 5)

    Turn(pelvis, x_axis, 0, 5)
    Turn(pelvis, y_axis, 0, 5)
    Turn(pelvis, z_axis, 0, 5)

    Move(pelvis, y_axis, 0, 5)
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Spring.SetUnitNanoPieces(unitID, nanoPieces)

    Hide(flare1)
    Hide(flare2)
    Hide(cagelight_emit)

    Spin(tankdecor, y_axis, rad(-30))

    SetUnitValue(COB.INBUILDSTANCE, 0)
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    moving = true
    StartThread(Walk)
end

function script.StopMoving()
    moving = false
    StartThread(RestorePose)
end

--------------------------------------------------------------------------------
-- BUILDING (FULLY WORKING)
--------------------------------------------------------------------------------
function script.StartBuilding(heading, pitch)
    Signal(SIG_BUILD)
    SetSignalMask(SIG_BUILD)

    SetUnitValue(COB.INBUILDSTANCE, 1)

    Turn(aimy1, y_axis, heading, rad(180))
    Turn(aimx1, x_axis, -pitch, rad(90))

    Show(flare1)
    Show(flare2)
    Show(cagelight_emit)

    Move(nano, z_axis, 4, 5)
    Move(cagelight, y_axis, 2.5, 5)

    -- Spin(cagelight_emit, y_axis, rad(150))
end

function script.StopBuilding()
    Signal(SIG_BUILD)

    SetUnitValue(COB.INBUILDSTANCE, 0)

    Hide(flare1)
    Hide(flare2)
    Hide(cagelight_emit)

    Move(nano, z_axis, 0, 5)
    Move(cagelight, y_axis, 0, 5)

    Turn(aimy1, y_axis, 0, rad(90))
    Turn(aimx1, x_axis, 0, rad(45))
end

--------------------------------------------------------------------------------
-- REQUIRED FOR BUILDING
--------------------------------------------------------------------------------
function script.QueryNanoPiece()
    local p = nanoPieces[nanoIndex]
    nanoIndex = nanoIndex % #nanoPieces + 1
    return p
end

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity <= 0.5 then
        Explode(torso, SFX.NONE)
        return 1
    else
        Explode(torso, SFX.FIRE + SFX.SMOKE + SFX.EXPLODE)
        return 2
    end
end