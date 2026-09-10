include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis, torso = piece("pelvis", "torso")

local aimx, aimy = piece("aimx", "aimy")

local lshoulder, rshoulder = piece("lshoulder", "rshoulder")
local larm, rarm = piece("larm", "rarm")
local lhand, rhand = piece("lhand", "rhand")

local lsleeve, rsleeve = piece("lsleeve", "rsleeve")
local lbarrel, rbarrel = piece("lbarrel", "rbarrel")
local flarel, flarer = piece("flarel", "flarer")

local aaturret, aasleeve, aabarrel, aaflare =
    piece("aaturret","aasleeve","aabarrel","aaflare")

local lthigh, rthigh = piece("lthigh", "rthigh")
local lknee, rknee = piece("lknee", "rknee")
local lfoot, rfoot = piece("lfoot", "rfoot")
local lkeel, rkeel = piece("lkeel", "rkeel")
local ltoes, rtoes = piece("ltoes", "rtoes")

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local SIGNAL_MOVE = 1
local SIGNAL_AIM1 = 2
local SIGNAL_AIM2 = 4
local SIGNAL_AIM3 = 8

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 14
local gunIndex = 0
local restoreDelay = 3000
-- local isOpen = false
--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function rad(x)
    return math.rad(x)
end

local function StopAABarrel()
    Sleep(200)
    StopSpin(aabarrel, z_axis, 10)
end


--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Show(lsleeve)
    Show(rsleeve)
    Show(lbarrel)
    Show(rbarrel)
    Show(flarel)
    Show(flarer)

    -- hide AA turret (disabled for now)
    Hide(aaturret)
    Hide(aasleeve)
    Hide(aabarrel)
    Hide(aaflare)
end



local function StopBarrelsAfterDelay()
    Sleep(300) -- delay after last shot
    StopSpin(lbarrel, z_axis, 5)
    StopSpin(rbarrel, z_axis, 5)
end


--------------------------------------------------------------------------------
-- WALK CYCLE (CONDENSED BUT SMOOTH)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- WALK (SMOOTHED + CLEANED)
--------------------------------------------------------------------------------
local function Walk()
 
 SetSignalMask(SIGNAL_MOVE)


local function spd(x)
    return math.min(300, math.max(25, x / (animSpeed * 3)))
end

    while isMoving do

    --------------------------------------------------------------------------------
    -- FRAME 3
    --------------------------------------------------------------------------------


    Turn(lfoot, x_axis, rad(-18.211357), spd(1825.311536))
    Turn(lkeel, x_axis, rad(-46.316442), spd(1006.473803))
    Turn(lkeel, z_axis, rad(-0.702781), spd(3.442841))
    Turn(lkeel, y_axis, rad(-2.766797), spd(52.114544))
    Turn(lknee, x_axis, rad(36.498417), spd(1601.241750))
    Turn(lthigh, x_axis, rad(15.117618), spd(503.398790))
    Turn(lthigh, z_axis, rad(-1.408778), spd(67.112612))
    Turn(ltoes, x_axis, rad(21.035437), spd(1038.902944))

    Move(pelvis, z_axis, -0.216675, spd(32.396539))
    Move(pelvis, y_axis, -1.460117, spd(69.446297))
    Turn(pelvis, y_axis, rad(2.292226), spd(79.607942))

    Turn(rfoot, x_axis, rad(-12.440133), spd(596.162740))
    Turn(rkeel, x_axis, rad(23.484974), spd(246.110567))
    Turn(rkeel, z_axis, rad(0.764601), spd(20.033370))
    Turn(rkeel, y_axis, rad(-2.445486), spd(83.935550))
    Turn(rknee, x_axis, rad(2.592157), spd(648.014281))
    Turn(rthigh, x_axis, rad(-13.647560), spd(193.901318))
    Turn(rthigh, z_axis, rad(0.061712), spd(40.293254))

    Turn(torso, x_axis, rad(-2.510836), spd(27.107254))
    Turn(torso, y_axis, rad(-1.719170), spd(58.595986))

    -- if not isOpen then
        -- Turn(lhand, x_axis, rad(28.749401), spd(312.511327))
        -- Turn(larm, x_axis, rad(55.166448), spd(414.953048))
        -- Turn(rarm, x_axis, rad(22.129331), spd(414.952843))
        -- Turn(rhand, x_axis, rad(32.087221), spd(312.511481))
        -- Turn(lshoulder, y_axis, rad(-10.314040), spd(156.255740))
        -- Turn(rshoulder, y_axis, rad(1.145119), spd(156.255856))
    -- end

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 6
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(-46.603340), spd(851.759492))
    Turn(lkeel, x_axis, rad(-39.707578), spd(198.265912))
    Turn(lkeel, z_axis, rad(0.137783), spd(25.216922))
    Turn(lkeel, y_axis, rad(1.334571), spd(123.041043))
    Turn(lknee, x_axis, rad(58.813803), spd(669.461572))
    Turn(lthigh, x_axis, rad(1.378858), spd(412.162800))
    Turn(lthigh, z_axis, rad(0.190461), spd(47.977171))
    Turn(ltoes, x_axis, rad(34.381028), spd(400.367709))

    Move(pelvis, z_axis, -0.995735, spd(23.371793))
    Move(pelvis, y_axis, -1.747818, spd(8.631020))
    Turn(pelvis, y_axis, rad(-1.241459), spd(106.010560))

    Turn(rfoot, x_axis, rad(-9.795793), spd(79.330180))
    Turn(rkeel, x_axis, rad(3.718027), spd(593.008396))
    Turn(rkeel, z_axis, rad(-0.202892), spd(29.024808))
    Turn(rkeel, y_axis, rad(1.250730), spd(110.886470))
    Turn(rknee, x_axis, rad(9.048526), spd(193.691079))
    Turn(rthigh, x_axis, rad(-2.974111), spd(320.203460))
    Turn(rthigh, z_axis, rad(-0.090355), spd(4.562013))

    Turn(torso, x_axis, rad(-0.416792), spd(62.821314))
    Turn(torso, y_axis, rad(0.931094), spd(79.507926))

    -- if not isOpen then
        -- Turn(lhand, x_axis, rad(42.884150), spd(424.042459))
        -- Turn(rhand, x_axis, rad(32.952469), spd(424.042562))
        -- Turn(larm, x_axis, rad(46.859592), spd(350.794315))
        -- Turn(rarm, x_axis, rad(10.436174), spd(350.794725))
        -- Turn(lshoulder, y_axis, rad(-3.246665), spd(212.021242))
        -- Turn(rshoulder, y_axis, rad(8.212490), spd(212.021127))
    -- end

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 9
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(-53.358746), spd(202.662163))
    Turn(lkeel, x_axis, rad(2.286889), spd(1259.834023))
    Turn(lkeel, z_axis, rad(-1.477643), spd(48.462792))
    Turn(lkeel, y_axis, rad(4.136339), spd(84.053025))
    Turn(lknee, x_axis, rad(42.367817), spd(493.379568))
    Turn(lthigh, x_axis, rad(-13.412237), spd(443.732841))
    Turn(lthigh, z_axis, rad(-0.618847), spd(24.279242))

    Move(pelvis, z_axis, -0.392350, spd(18.101554))
    Move(pelvis, y_axis, 0.391090, spd(64.167252))
    Turn(pelvis, y_axis, rad(-4.298492), spd(91.711007))

    Turn(rfoot, x_axis, rad(11.755289), spd(646.532473))
    Turn(rkeel, x_axis, rad(-9.971215), spd(410.677256))
    Turn(rkeel, z_axis, rad(0.251575), spd(13.634007))
    Turn(rkeel, y_axis, rad(4.258118), spd(90.221662))
    Turn(rknee, x_axis, rad(-6.138516), spd(455.611265))
    Turn(rthigh, x_axis, rad(12.076526), spd(451.519106))
    Turn(rthigh, z_axis, rad(1.299561), spd(41.697469))

    Turn(rtoes, x_axis, rad(-7.757021), spd(232.710632))

    Turn(torso, x_axis, rad(3.640550), spd(121.720246))
    Turn(torso, y_axis, rad(3.223870), spd(68.783265))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 12
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(-28.598436), spd(742.809300))
    Turn(lkeel, x_axis, rad(33.234068), spd(928.415358))
    Turn(lkeel, z_axis, rad(-3.023672), spd(46.380886))
    Turn(lkeel, y_axis, rad(6.600236), spd(73.916930))
    Turn(lknee, x_axis, rad(10.672346), spd(950.864119))
    Turn(lthigh, x_axis, rad(-23.522294), spd(303.301713))
    Turn(lthigh, z_axis, rad(-2.004321), spd(41.564209))

    Move(pelvis, z_axis, 0.755761, spd(34.443325))
    Move(pelvis, y_axis, 1.987022, spd(47.877960))
    Turn(pelvis, y_axis, rad(-5.705141), spd(42.199466))

    Turn(rfoot, x_axis, rad(21.374312), spd(288.570686))
    Turn(rkeel, x_axis, rad(17.984267), spd(838.664457))
    Turn(rkeel, z_axis, rad(0.378115), spd(3.796200))
    Turn(rkeel, y_axis, rad(4.768688), spd(15.317096))
    Turn(rknee, x_axis, rad(-33.517938), spd(821.382648))
    Turn(rthigh, x_axis, rad(33.469337), spd(641.784348))
    Turn(rthigh, z_axis, rad(2.586744), spd(38.615489))

    Turn(rtoes, x_axis, rad(-39.438380), spd(950.440759))

    Turn(torso, x_axis, rad(2.345505), spd(38.851345))
    Turn(torso, y_axis, rad(4.278857), spd(31.649628))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 15
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(7.093960), spd(1070.771885))
    Turn(lkeel, x_axis, rad(31.898240), spd(40.074837))
    Turn(lkeel, z_axis, rad(-1.433427), spd(47.707362))
    Turn(lkeel, y_axis, rad(5.220856), spd(41.381405))
    Turn(lknee, x_axis, rad(-18.773040), spd(883.361582))
    Turn(lthigh, x_axis, rad(-20.164274), spd(100.740595))
    Turn(lthigh, z_axis, rad(-1.575312), spd(12.870241))
    Turn(ltoes, x_axis, 0, spd(1031.430828))

    Move(pelvis, y_axis, 0.824238, spd(34.883537))
    Turn(pelvis, y_axis, rad(-4.921332), spd(23.514271))

    Turn(rfoot, x_axis, rad(42.632361), spd(637.741456))
    Turn(rkeel, x_axis, rad(-12.767315), spd(922.547461))
    Turn(rkeel, z_axis, rad(0.533610), spd(4.664859))
    Turn(rkeel, y_axis, rad(4.359678), spd(12.270303))
    Turn(rknee, x_axis, rad(-16.876308), spd(499.248887))
    Turn(rthigh, x_axis, rad(31.867839), spd(48.044951))
    Turn(rthigh, z_axis, rad(3.471749), spd(26.550153))

    Turn(rtoes, x_axis, rad(-25.086240), spd(430.564197))

    Turn(torso, x_axis, rad(-1.607260), spd(118.582961))
    Turn(torso, y_axis, rad(3.690999), spd(17.635758))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 18
    --------------------------------------------------------------------------------


    Turn(lfoot, x_axis, rad(-12.440133), spd(586.022790))
    Turn(lkeel, x_axis, rad(23.484974), spd(252.397995))
    Turn(lkeel, z_axis, rad(-0.752540), spd(20.426623))
    Turn(lkeel, y_axis, rad(2.399417), spd(84.643173))
    Turn(lknee, x_axis, rad(2.592157), spd(640.955908))
    Turn(lthigh, x_axis, rad(-13.699964), spd(193.929314))
    Turn(lthigh, z_axis, rad(-0.203165), spd(41.164412))

    Move(pelvis, z_axis, -0.233059, spd(32.629737))
    Move(pelvis, y_axis, -1.482891, spd(69.213867))
    Turn(pelvis, y_axis, rad(-2.248001), spd(80.199953))

    Turn(rfoot, x_axis, rad(-18.211357), spd(1825.311536))
    Turn(rkeel, x_axis, rad(-46.316438), spd(1006.473701))
    Turn(rkeel, y_axis, rad(2.574013), spd(53.569963))
    Turn(rknee, x_axis, rad(36.498417), spd(1601.241750))
    Turn(rthigh, x_axis, rad(15.110904), spd(502.708053))
    Turn(rthigh, z_axis, rad(1.402773), spd(62.069278))

    Turn(rtoes, x_axis, rad(12.910848), spd(1139.912631))

    Turn(torso, x_axis, rad(-2.510836), spd(27.107254))
    Turn(torso, y_axis, rad(1.686000), spd(60.149955))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 21
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(-9.795793), spd(79.330180))
    Turn(lkeel, x_axis, rad(3.718028), spd(593.008370))
    Turn(lkeel, z_axis, rad(0.210668), spd(28.896214))
    Turn(lkeel, y_axis, rad(-1.298078), spd(110.924861))
    Turn(lknee, x_axis, rad(9.048528), spd(193.691117))
    Turn(lthigh, x_axis, rad(-2.976451), spd(321.705368))

    Move(pelvis, z_axis, -0.997146, spd(22.922607))
    Move(pelvis, y_axis, -1.731224, spd(7.449989))
    Turn(pelvis, y_axis, rad(1.288440), spd(106.093224))

    Turn(rfoot, x_axis, rad(-46.603340), spd(851.759492))
    Turn(rkeel, x_axis, rad(-39.707578), spd(198.265809))
    Turn(rkeel, z_axis, rad(-0.142187), spd(21.742548))
    Turn(rkeel, y_axis, rad(-1.385055), spd(118.772035))
    Turn(rknee, x_axis, rad(58.813803), spd(669.461572))
    Turn(rthigh, x_axis, rad(1.368883), spd(412.260633))
    Turn(rthigh, z_axis, rad(-0.197623), spd(48.011874))

    Turn(rtoes, x_axis, rad(34.381028), spd(644.105391))

    Turn(torso, x_axis, rad(-0.416792), spd(62.821307))
    Turn(torso, y_axis, rad(-0.966330), spd(79.569907))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 24
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(11.755289), spd(646.532473))
    Turn(lkeel, x_axis, rad(-9.971216), spd(410.677333))
    Turn(lkeel, z_axis, rad(-0.255415), spd(13.982487))
    Turn(lkeel, y_axis, rad(-4.289143), spd(89.731935))
    Turn(lknee, x_axis, rad(-6.138516), spd(455.611316))
    Turn(lthigh, x_axis, rad(12.119958), spd(452.892282))
    Turn(lthigh, z_axis, rad(-1.495461), spd(41.576451))
    Turn(ltoes, x_axis, rad(-7.757019), spd(232.710581))

    Move(pelvis, z_axis, -0.376829, spd(18.609506))
    Move(pelvis, y_axis, 0.424015, spd(64.657173))
    Turn(pelvis, y_axis, rad(4.330190), spd(91.252495))

    Turn(rfoot, x_axis, rad(-53.358746), spd(202.662163))
    Turn(rkeel, x_axis, rad(2.286889), spd(1259.834023))
    Turn(rkeel, z_axis, rad(1.478224), spd(48.612325))
    Turn(rkeel, y_axis, rad(-4.063928), spd(80.366186))
    Turn(rknee, x_axis, rad(42.367817), spd(493.379568))
    Turn(rthigh, x_axis, rad(-13.386278), spd(442.654816))
    Turn(rthigh, z_axis, rad(0.609503), spd(24.213776))

    Turn(torso, x_axis, rad(3.640550), spd(121.720253))
    Turn(torso, y_axis, rad(-3.247643), spd(68.439382))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 27
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(21.374312), spd(288.570686))
    Turn(lkeel, x_axis, rad(17.984269), spd(838.664559))
    Turn(lkeel, z_axis, rad(-0.376718), spd(3.639066))
    Turn(lkeel, y_axis, rad(-4.770471), spd(14.439844))
    Turn(lknee, x_axis, rad(-33.517938), spd(821.382648))
    Turn(lthigh, x_axis, rad(33.506323), spd(641.590942))
    Turn(lthigh, z_axis, rad(-2.774777), spd(38.379470))
    Turn(ltoes, x_axis, rad(-39.438380), spd(950.440810))

    Move(pelvis, z_axis, 0.766664, spd(34.304783))
    Move(pelvis, y_axis, 1.990566, spd(46.996536))
    Turn(pelvis, y_axis, rad(5.709385), spd(41.375847))

    Turn(rfoot, x_axis, rad(-28.598436), spd(742.809300))
    Turn(rkeel, x_axis, rad(33.234061), spd(928.415153))
    Turn(rkeel, z_axis, rad(2.842474), spd(40.927488))
    Turn(rkeel, y_axis, rad(-6.293228), spd(66.879010))
    Turn(rknee, x_axis, rad(10.672345), spd(950.864171))
    Turn(rthigh, x_axis, rad(-23.501270), spd(303.449783))
    Turn(rthigh, z_axis, rad(1.995777), spd(41.588226))

    Turn(torso, x_axis, rad(2.345505), spd(38.851345))
    Turn(torso, y_axis, rad(-4.282039), spd(31.031889))

    Sleep(5 * animSpeed)

    --------------------------------------------------------------------------------
    -- FRAME 30
    --------------------------------------------------------------------------------
    Turn(lfoot, x_axis, rad(42.632361), spd(637.741456))
    Turn(lkeel, x_axis, rad(-12.767315), spd(922.547513))
    Turn(lkeel, z_axis, rad(-0.589128), spd(6.372326))
    Turn(lkeel, y_axis, rad(-4.465012), spd(9.163766))
    Turn(lknee, x_axis, rad(-16.876308), spd(499.248887))
    Turn(lthigh, x_axis, rad(31.837680), spd(50.059276))
    Turn(lthigh, z_axis, rad(-3.649274), spd(26.234938))
    Turn(ltoes, x_axis, rad(-13.594662), spd(775.311541))

    Move(pelvis, y_axis, 0.793484, spd(35.912476))
    Turn(pelvis, y_axis, rad(4.896492), spd(24.386785))

    Turn(rfoot, x_axis, rad(7.093960), spd(1070.771872))
    Turn(rkeel, x_axis, rad(31.898240), spd(40.074632))
    Turn(rkeel, z_axis, rad(1.434349), spd(42.243725))
    Turn(rkeel, y_axis, rad(-5.198006), spd(32.856663))
    Turn(rknee, x_axis, rad(-18.773041), spd(883.361582))
    Turn(rthigh, x_axis, rad(-20.218251), spd(98.490577))
    Turn(rthigh, z_axis, rad(1.404821), spd(17.728695))

    Turn(rtoes, x_axis, 0, spd(1031.430828))

    Turn(torso, x_axis, rad(-1.607260), spd(118.582961))
    Turn(torso, y_axis, rad(-3.672369), spd(18.290098))

Sleep(5 * animSpeed)

--------------------------------------------------------------------------------
-- FRAME 31 (TRANSITION: FRAME 30 → FRAME 3 SMOOTH BLEND)
--------------------------------------------------------------------------------

-- LEFT LEG
Turn(lfoot, x_axis, rad(12.210502), spd(700))
Turn(lkeel, x_axis, rad(-29.541878), spd(600))
Turn(lkeel, y_axis, rad(-2.232506), spd(80))
Turn(lkeel, z_axis, rad(-0.645955), spd(25))
Turn(lknee, x_axis, rad(9.811054), spd(700))
Turn(lthigh, x_axis, rad(23.477649), spd(450))
Turn(lthigh, z_axis, rad(-2.528999), spd(60))
Turn(ltoes, x_axis, rad(3.720388), spd(400))

-- RIGHT LEG
Turn(rfoot, x_axis, rad(-2.673087), spd(700))
Turn(rkeel, x_axis, rad(27.691607), spd(600))
Turn(rkeel, y_axis, rad(-3.821746), spd(80))
Turn(rkeel, z_axis, rad(1.099475), spd(25))
Turn(rknee, x_axis, rad(-8.090442), spd(700))
Turn(rthigh, x_axis, rad(-16.932906), spd(450))
Turn(rthigh, z_axis, rad(0.733267), spd(60))

-- PELVIS (ROOT STABILIZATION)
Move(pelvis, y_axis, -0.333316, spd(40))
Move(pelvis, z_axis, -0.108338, spd(40))
Turn(pelvis, y_axis, rad(3.594359), spd(90))

-- TORSO (MOTION CONTINUITY)
Turn(torso, x_axis, rad(-2.059048), spd(60))
Turn(torso, y_axis, rad(-2.695770), spd(60))

-- SHORT BLEND HOLD
Sleep(5 * animSpeed)
    end
end

--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------
local function StopWalk()
    local speed = 5

    -- legs
    Turn(lthigh, x_axis, 0, speed)
    Turn(rthigh, x_axis, 0, speed)
    Turn(lthigh, z_axis, 0, speed)
    Turn(rthigh, z_axis, 0, speed)

    Turn(lknee, x_axis, 0, speed)
    Turn(rknee, x_axis, 0, speed)

    Turn(lfoot, x_axis, 0, speed)
    Turn(rfoot, x_axis, 0, speed)

    Turn(ltoes, x_axis, 0, speed)
    Turn(rtoes, x_axis, 0, speed)

    -- keels )
    Turn(lkeel, x_axis, 0, speed)
    Turn(rkeel, x_axis, 0, speed)
    Turn(lkeel, y_axis, 0, speed)
    Turn(rkeel, y_axis, 0, speed)
    Turn(lkeel, z_axis, 0, speed)
    Turn(rkeel, z_axis, 0, speed)

    -- pelvis (
    Move(pelvis, y_axis, 0, speed)
    Move(pelvis, z_axis, 0, speed)
    Turn(pelvis, y_axis, 0, speed)

    -- torso 
    Turn(torso, x_axis, 0, speed)
    Turn(torso, y_axis, 0, speed)
end
-------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    Signal(SIGNAL_MOVE) -- kill old thread first
    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
    Signal(SIGNAL_MOVE)
    StopWalk()
end

--------------------------------------------------------------------------------
-- AIM (MAIN WEAPON)
--------------------------------------------------------------------------------
function script.QueryWeapon1()
    if gunIndex == 0 then
        return flarel
    else
        return flarer
    end
end

function script.AimWeapon1(heading, pitch)
    Signal(SIGNAL_AIM1)
    SetSignalMask(SIGNAL_AIM1)

    Turn(aimy, y_axis, heading, 5)
    Turn(aimx, x_axis, -pitch, 5)

    WaitForTurn(aimy, y_axis)
    WaitForTurn(aimx, x_axis)

    return true
end

function script.FireWeapon1()
    if gunIndex == 0 then
        EmitSfx(flarel, 1024)
        gunIndex = 1
    else
        EmitSfx(flarer, 1024)
        gunIndex = 0
    end

    Spin(lbarrel, z_axis, -120)
    Spin(rbarrel, z_axis, 120)

    Signal(1024)
    StartThread(function()
        SetSignalMask(1024)
        StopBarrelsAfterDelay()
    end)
end




--------------------------------------------------------------------------------
-- AA WEAPON
--------------------------------------------------------------------------------
function script.AimWeapon2(heading, pitch)
    Signal(SIGNAL_AIM3)
    SetSignalMask(SIGNAL_AIM3)

    Turn(aaturret, y_axis, heading, 10)
    Turn(aasleeve, x_axis, -pitch, 10)

    WaitForTurn(aaturret, y_axis)
    WaitForTurn(aasleeve, x_axis)

    StartThread(function()
        Sleep(restoreDelay)
        Turn(aaturret, y_axis, 0, 3)
        Turn(aasleeve, x_axis, 0, 3)
    end)

    return true
end

function script.QueryWeapon2()
    return aaflare
end



function script.FireWeapon2()
    Spin(aabarrel, z_axis, -40)
    EmitSfx(aaflare, 1024)

    StartThread(StopAABarrel)
end
--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- KILLED (IMPROVED)
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity < 0.5 then
        -- light death (mostly intact wreck)
        Explode(lbarrel, SFX.SMOKE)
        Explode(rbarrel, SFX.SMOKE)
        Explode(aabarrel, SFX.SMOKE)

        Explode(torso, SFX.FALL)
        Explode(pelvis, SFX.SHATTER)

        return 1 -- normal wreck

    elseif severity < 1 then
        -- medium death (some parts fly off)
        Explode(lbarrel, SFX.FIRE + SFX.SMOKE)
        Explode(rbarrel, SFX.FIRE + SFX.SMOKE)
        Explode(aabarrel, SFX.FIRE + SFX.SMOKE)

        Explode(larm, SFX.SHATTER)
        Explode(rarm, SFX.SHATTER)

        Explode(torso, SFX.FIRE)
        Explode(pelvis, SFX.SHATTER)

        return 2 -- heap

    else
        -- overkill (big explosion, everything goes boom)
        Explode(lbarrel, SFX.EXPLODE + SFX.FIRE)
        Explode(rbarrel, SFX.EXPLODE + SFX.FIRE)
        Explode(aabarrel, SFX.EXPLODE + SFX.FIRE)

        Explode(larm, SFX.EXPLODE)
        Explode(rarm, SFX.EXPLODE)

        Explode(lthigh, SFX.SHATTER)
        Explode(rthigh, SFX.SHATTER)

        Explode(torso, SFX.EXPLODE)
        Explode(pelvis, SFX.EXPLODE)

        return 2 -- heap (no clean wreck)
    end
end