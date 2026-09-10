
include "constants.lua"
include "reliableStartMoving.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------

local chassis = piece("chassis")

-- Head laser
local headflare = piece("headflare")
local headlaserpivot = piece("headlaserpivot")

-- Legs
local leftFrontLegPivot  = piece("leftFrontLegPivot")
local leftRearLegPivot   = piece("leftRearLegPivot")
local rightFrontLegPivot = piece("rightFrontLegPivot")
local rightRearLegPivot  = piece("rightRearLegPivot")

-- Turret
local turretHeadingPivot = piece("turretHeadingPivot")
local turretPitchPivot   = piece("turretPitchPivot")
local turretMain         = piece("turretMain")

-- ONLY REMAINING BARREL
local rightTopChamber = piece("rightTopChamber")
local rightTopBarrel  = piece("rightTopBarrel")
local rightTopFlare   = piece("rightTopFlare")


--------------------------------------------------------------------------------
-- LEG MAPPING
--------------------------------------------------------------------------------

local leg1 = rightFrontLegPivot
local leg2 = rightRearLegPivot
local leg3 = leftRearLegPivot
local leg4 = leftFrontLegPivot


--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------

local SIG_MOVE     = 1
local SIG_AIM      = 2
local SIG_HEAD_AIM = 4
local SIG_TURN     = 8
local SIG_RESET    = 16


--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------

local moving = false
local isOpen = false

local burstDelay = 300
local firing = false

-- Rotation detection
local unitTurning = false
local lastHeading = nil

local turningDirection = 0


--------------------------------------------------------------------------------
-- WALK SETTINGS
--------------------------------------------------------------------------------

local PACE = 2.5

local legRaiseSpeed = math.rad(45) * PACE
local legRaiseAngle = math.rad(20)
local legLowerSpeed = math.rad(50) * PACE

local legForwardSpeed = math.rad(35) * PACE
local legForwardAngle = math.rad(-25)

local legBackwardSpeed = math.rad(35) * PACE
local legBackwardAngle = math.rad(35)

local legBackwardAngleMinor = math.rad(30)


--------------------------------------------------------------------------------
-- WALK
--------------------------------------------------------------------------------

local function Walk()

    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while true do

        ------------------------------------------------------------------------
        -- PHASE A
        -- Front-left + back-right
        ------------------------------------------------------------------------

        Turn(leg4, z_axis, legRaiseAngle, legRaiseSpeed)
        Turn(leg2, z_axis, -legRaiseAngle, legRaiseSpeed)

        Turn(
            leg4,
            y_axis,
            math.rad(-20) + legForwardAngle,
            legForwardSpeed
        )

        Turn(
            leg2,
            y_axis,
            math.rad(-20) - legForwardAngle,
            legForwardSpeed
        )

        Turn(
            leg1,
            y_axis,
            math.rad(20 - legBackwardAngleMinor),
            legBackwardSpeed
        )

        Turn(
            leg3,
            y_axis,
            math.rad(20 - legBackwardAngleMinor),
            legBackwardSpeed
        )

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)

        Turn(leg4, z_axis, 0, legLowerSpeed)
        Turn(leg2, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)


        ------------------------------------------------------------------------
        -- PHASE B
        -- Front-right + back-left
        ------------------------------------------------------------------------

        Turn(leg1, z_axis, -legRaiseAngle, legRaiseSpeed)
        Turn(leg3, z_axis, legRaiseAngle, legRaiseSpeed)

        Turn(
            leg1,
            y_axis,
            math.rad(20) - legForwardAngle,
            legForwardSpeed
        )

        Turn(
            leg3,
            y_axis,
            math.rad(20) + legForwardAngle,
            legForwardSpeed
        )

        Turn(
            leg4,
            y_axis,
            math.rad(-20 + legBackwardAngleMinor),
            legBackwardSpeed
        )

        Turn(
            leg2,
            y_axis,
            math.rad(-20 + legBackwardAngleMinor),
            legBackwardSpeed
        )

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

        Turn(leg1, z_axis, 0, legLowerSpeed)
        Turn(leg3, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

    end
end


--------------------------------------------------------------------------------
-- RESET LEGS
--------------------------------------------------------------------------------

local function ResetLegs()

    local speed = math.rad(60)

    Turn(leg1, y_axis, math.rad(20), speed)
    Turn(leg3, y_axis, math.rad(20), speed)

    Turn(leg4, y_axis, math.rad(-20), speed)
    Turn(leg2, y_axis, math.rad(-20), speed)

    Turn(leg1, z_axis, math.rad(-5), speed)
    Turn(leg2, z_axis, math.rad(-5), speed)
    Turn(leg3, z_axis, math.rad(-5), speed)
    Turn(leg4, z_axis, math.rad(-5), speed)

end


--------------------------------------------------------------------------------
-- ROTATION DETECTION
--------------------------------------------------------------------------------

local TURN_THRESHOLD = 20

local function GetHeadingDifference(current, previous)

    local difference = current - previous

    if difference > 32768 then
        difference = difference - 65536
    elseif difference < -32768 then
        difference = difference + 65536
    end

    return difference
end


local function RotationWatcher()

    lastHeading = Spring.GetUnitHeading(unitID)

    while true do

        local currentHeading = Spring.GetUnitHeading(unitID)

        if lastHeading ~= nil then

            local difference =
                GetHeadingDifference(currentHeading, lastHeading)

            if not moving and math.abs(difference) > TURN_THRESHOLD then

                unitTurning = true

                if difference > 0 then
                    turningDirection = 1
                else
                    turningDirection = -1
                end

            else

                unitTurning = false
                turningDirection = 0

            end
        end

        lastHeading = currentHeading

        Sleep(50)

    end
end


--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------

function script.StartMoving()

    moving = true

    Signal(SIG_TURN)

    StartThread(Walk)

end


function script.StopMoving()

    moving = false

    Signal(SIG_MOVE)
    Signal(SIG_TURN)

    StartThread(ResetLegs)

end


--------------------------------------------------------------------------------
-- TURN IN PLACE
--------------------------------------------------------------------------------

local function TurnInPlace(direction)

    Signal(SIG_TURN)
    SetSignalMask(SIG_TURN)

    if direction == 0 then
        direction = 1
    end

    while not moving and unitTurning do

        ------------------------------------------------------------------------
        -- PAIR A
        ------------------------------------------------------------------------

        Turn(leg4, z_axis, legRaiseAngle, legRaiseSpeed)
        Turn(leg2, z_axis, -legRaiseAngle, legRaiseSpeed)

        Turn(
            leg4,
            y_axis,
            math.rad(-20) + math.rad(30) * direction,
            legForwardSpeed
        )

        Turn(
            leg2,
            y_axis,
            math.rad(-20) - math.rad(30) * direction,
            legForwardSpeed
        )

        Turn(
            leg1,
            y_axis,
            math.rad(20) - math.rad(20) * direction,
            legBackwardSpeed
        )

        Turn(
            leg3,
            y_axis,
            math.rad(20) + math.rad(20) * direction,
            legBackwardSpeed
        )

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)

        if moving or not unitTurning then
            break
        end

        Turn(leg4, z_axis, 0, legLowerSpeed)
        Turn(leg2, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg4, z_axis)
        WaitForTurn(leg2, z_axis)

        if moving or not unitTurning then
            break
        end


        ------------------------------------------------------------------------
        -- PAIR B
        ------------------------------------------------------------------------

        Turn(leg1, z_axis, -legRaiseAngle, legRaiseSpeed)
        Turn(leg3, z_axis, legRaiseAngle, legRaiseSpeed)

        Turn(
            leg1,
            y_axis,
            math.rad(20) - math.rad(30) * direction,
            legForwardSpeed
        )

        Turn(
            leg3,
            y_axis,
            math.rad(20) + math.rad(30) * direction,
            legForwardSpeed
        )

        Turn(
            leg4,
            y_axis,
            math.rad(-20) + math.rad(20) * direction,
            legBackwardSpeed
        )

        Turn(
            leg2,
            y_axis,
            math.rad(-20) - math.rad(20) * direction,
            legBackwardSpeed
        )

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

        if moving or not unitTurning then
            break
        end

        Turn(leg1, z_axis, 0, legLowerSpeed)
        Turn(leg3, z_axis, 0, legLowerSpeed)

        WaitForTurn(leg1, z_axis)
        WaitForTurn(leg3, z_axis)

    end
end


--------------------------------------------------------------------------------
-- TURN ANIMATION CONTROLLER
--------------------------------------------------------------------------------

local function TurnAnimationController()

    local wasTurning = false

    while true do

        if not moving and unitTurning then

            if not wasTurning then

                wasTurning = true

                Signal(SIG_RESET)
                Signal(SIG_TURN)

                StartThread(
                    TurnInPlace,
                    turningDirection
                )

            end

        elseif wasTurning then

            wasTurning = false

            Signal(SIG_TURN)

            StartThread(ResetLegs)

        end

        Sleep(50)

    end
end




--------------------------------------------------------------------------------
-- WEAPON 1: TURRET BARREL
--------------------------------------------------------------------------------

function script.AimFromWeapon1()

    return turretMain

end


function script.QueryWeapon1()

    return rightTopFlare

end


function script.AimWeapon1(heading, pitch)

    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(
        turretHeadingPivot,
        y_axis,
        heading,
        math.rad(90)
    )

    Turn(
        turretPitchPivot,
        x_axis,
        -pitch,
        math.rad(90)
    )

    WaitForTurn(
        turretHeadingPivot,
        y_axis
    )

    return true

end


--------------------------------------------------------------------------------
-- WEAPON 2: HEAD LASER
--------------------------------------------------------------------------------

function script.AimFromWeapon2()

    return headlaserpivot

end


function script.QueryWeapon2()

    return headflare

end


function script.AimWeapon2(heading, pitch)

    Signal(SIG_HEAD_AIM)
    SetSignalMask(SIG_HEAD_AIM)

    Turn(
        headlaserpivot,
        y_axis,
        heading,
        math.rad(90)
    )

    Turn(
        headlaserpivot,
        x_axis,
        -pitch,
        math.rad(90)
    )

    return true

end


function script.FireWeapon2()

end


--------------------------------------------------------------------------------
-- FIRE SYSTEM
--------------------------------------------------------------------------------


local function FireBurst()

    firing = true

    Sleep(burstDelay)

    firing = false

end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()

    Turn(leg1, y_axis, math.rad(45))
    Turn(leg3, y_axis, math.rad(45))
    Turn(leg4, y_axis, math.rad(-45))
    Turn(leg2, y_axis, math.rad(-45))

    lastHeading = Spring.GetUnitHeading(unitID)

    StartThread(RotationWatcher)
    StartThread(TurnAnimationController)

end

--------------------------------------------------------------------------------
-- DEATH
--------------------------------------------------------------------------------

function script.Killed(recentDamage, maxHealth)

    local severity = recentDamage / maxHealth

    ------------------------------------------------------------------------
    -- LIGHT
    ------------------------------------------------------------------------

    if severity <= 0.25 then

        Explode(
            turretMain,
            SFX.SMOKE
        )

        Explode(
            chassis,
            SFX.NONE
        )

        Explode(
            leftFrontLegPivot,
            SFX.NONE
        )

        Explode(
            leftRearLegPivot,
            SFX.NONE
        )

        Explode(
            rightFrontLegPivot,
            SFX.NONE
        )

        Explode(
            rightRearLegPivot,
            SFX.NONE
        )

        return 1


    ------------------------------------------------------------------------
    -- MEDIUM
    ------------------------------------------------------------------------

    elseif severity <= 0.5 then

        Explode(
            turretMain,
            SFX.FALL + SFX.SMOKE
        )

        Explode(
            rightTopBarrel,
            SFX.FALL
        )

        Explode(
            chassis,
            SFX.SMOKE
        )

        return 2


    ------------------------------------------------------------------------
    -- HEAVY
    ------------------------------------------------------------------------

    else

        Explode(
            chassis,
            SFX.SHATTER
        )

        Explode(
            turretMain,
            SFX.FIRE + SFX.SMOKE
        )

        Explode(
            rightTopBarrel,
            SFX.FALL + SFX.FIRE
        )

        Explode(
            rightTopChamber,
            SFX.SMOKE
        )

        Explode(
            leftFrontLegPivot,
            SFX.FALL
        )

        Explode(
            leftRearLegPivot,
            SFX.FALL
        )

        Explode(
            rightFrontLegPivot,
            SFX.FALL
        )

        Explode(
            rightRearLegPivot,
            SFX.FALL
        )

        return 3

    end

end
