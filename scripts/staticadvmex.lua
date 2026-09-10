include "pieceControl.lua"
include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base = piece("base")
local pumpcylinders = piece("pumpcylinders")
local pump1 = piece("pump1")
local pump2 = piece("pump2")
local pump3 = piece("pump3")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_OPEN = 1

--------------------------------------------------------------------------------
-- SMOKE
--------------------------------------------------------------------------------
local smokePiece = {

    pumpcylinders,
}

--------------------------------------------------------------------------------
-- METAL MULT
--------------------------------------------------------------------------------
local metalmult = tonumber(Spring.GetModOptions().metalmult) or 1
local metalmultInv = metalmult > 0 and (1 / metalmult) or 1

--------------------------------------------------------------------------------
-- PROGRESSIVE METAL GENERATION
--------------------------------------------------------------------------------

local metalMultiplier = 1.0

-- How much the mex gains each interval.
local METAL_INCREASE = 0.05

-- How often it increases.
--1000 per second
local METAL_INCREASE_TIME = 30000

-- Optional maximum multiplier.
-- Set to nil if you want it to increase forever.
local MAX_METAL_MULTIPLIER = 2.0


local function IncreaseMetal()
    while true do

        Sleep(METAL_INCREASE_TIME)

        metalMultiplier = metalMultiplier + METAL_INCREASE

        if MAX_METAL_MULTIPLIER and metalMultiplier > MAX_METAL_MULTIPLIER then
            metalMultiplier = MAX_METAL_MULTIPLIER
        end

        Spring.SetUnitRulesParam(
            unitID,
            "metalGenerationFactor",
            metalMultiplier
        )
    end
end

--------------------------------------------------------------------------------
-- OPEN / WORK LOOP
--------------------------------------------------------------------------------
local function Open()

    Signal(SIG_OPEN)
    SetSignalMask(SIG_OPEN)

    --------------------------------------------------------------------
    -- INITIAL ANGLES
    --------------------------------------------------------------------
    Turn(pump2, y_axis, -0.523598776)
    Turn(pump3, y_axis,  0.523598776)

    while true do

        local income =
            (Spring.GetUnitRulesParam(unitID, "current_metalIncome") or 0)

        income = income * metalmultInv 

        if income > 0 then



            ----------------------------------------------------------------
            -- PUMP DOWN
            ----------------------------------------------------------------
            Move(pumpcylinders, z_axis, -11, income * 15)

            Turn(pump1, x_axis, -1.4, income * 2)
            Turn(pump2, z_axis, -1.4, income * 2)
            Turn(pump3, z_axis,  1.4, income * 2)

            WaitForMove(pumpcylinders, z_axis)

            ----------------------------------------------------------------
            -- PUMP UP
            ----------------------------------------------------------------
            Move(pumpcylinders, z_axis, 0, income * 15)

            Turn(pump1, x_axis, 0, income * 2)
            Turn(pump2, z_axis, 0, income * 2)
            Turn(pump3, z_axis, 0, income * 2)

            WaitForMove(pumpcylinders, z_axis)

        else

            ----------------------------------------------------------------
            -- IDLE
            ----------------------------------------------------------------


            Sleep(200)
        end
    end
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()


    Turn(pump2, y_axis, -0.523598776)
    Turn(pump3, y_axis,  0.523598776)

    ----------------------------------------------------------------
    -- Start at normal mex production.
    ----------------------------------------------------------------
    Spring.SetUnitRulesParam(
        unitID,
        "metalGenerationFactor",
        metalMultiplier
    )

    ----------------------------------------------------------------
    -- Start progressive income increase.
    ----------------------------------------------------------------
    StartThread(IncreaseMetal)

    ----------------------------------------------------------------
    -- Smoke
    ----------------------------------------------------------------
    StartThread(GG.Script.SmokeUnit, unitID, smokePiece)

    ----------------------------------------------------------------
    -- Animation
    ----------------------------------------------------------------
    if not Spring.GetUnitIsStunned(unitID) then
        StartThread(Open)
    end
end

--------------------------------------------------------------------------------
-- ACTIVATE
--------------------------------------------------------------------------------
function script.Activate()

    StartThread(Open)
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)

    local severity = recentDamage / maxHealth

    if severity < 0.5 then

        Explode(base, SFX.NONE)
        Explode(pumpcylinders, SFX.NONE)

        return 1
    end

    Explode(base,
        SFX.SHATTER
    )

    Explode(pumpcylinders,
        SFX.SHATTER
    )


    return 2
end