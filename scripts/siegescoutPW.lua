include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, armor, aimy, Turret, aimx, sleeve, barrel1, barrel2 =
    piece('base','armor','aimy','Turret','aimx','sleeve','barrel1','barrel2')

local flare1, flare2 = piece('flare1','flare2')

local flthigh, flleg, flfoot = piece('flthigh','flleg','flfoot')
local frthigh, frleg, frfoot = piece('frthigh','frleg','frfoot')
local blthigh, blleg, blfoot = piece('blthigh','blleg','blfoot')
local brthigh, brleg, brfoot = piece('brthigh','brleg','brfoot')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM = 2
local SIG_FIRE = 4
local SIG_RESTORE = 8

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local unitID = unitID
local isMoving = false
local animSpeed = 4
local restoreDelay = 1000
local gun = 0
local lastHeading = 0
local stunned = false

--------------------------------------------------------------------------------
-- SPEED SYSTEM (FIXED)
--------------------------------------------------------------------------------
local function UnitSpeed()
    while true do
        local vx, _, vz = Spring.GetUnitVelocity(unitID)
        local speed = math.sqrt(vx*vx + vz*vz)

        animSpeed = math.max(1, 6 - speed * 8)

        Sleep(100)
    end
end

--------------------------------------------------------------------------------
-- WALK
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while isMoving do
        -- FRAME 3
        Move(base, z_axis, 0.395727, 7.680589 / animSpeed)
        Turn(base, x_axis, math.rad(-0.843888), math.rad(25.316632) / animSpeed)
        Turn(base, z_axis, math.rad(0.015896), math.rad(33.508313) / animSpeed)

        Turn(blfoot, x_axis, math.rad(4.131265), math.rad(654.527778) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-15.473860), math.rad(1252.219818) / animSpeed)
        Turn(blthigh,x_axis, math.rad(27.583767), math.rad(203.451767) / animSpeed)

        Turn(brfoot, x_axis, math.rad(45.886751), math.rad(19.362767) / animSpeed)
        Turn(brleg,  x_axis, math.rad(10.060334), math.rad(1352.342775) / animSpeed)
        Turn(brthigh,x_axis, math.rad(-66.378913), math.rad(1899.377151) / animSpeed)

        Turn(flfoot, x_axis, math.rad(17.218956), math.rad(177.159346) / animSpeed)
        Turn(flleg,  x_axis, math.rad(17.730524), math.rad(586.736150) / animSpeed)
        Turn(flthigh,x_axis, math.rad(-41.092942), math.rad(507.621384) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-7.291807), math.rad(95.046548) / animSpeed)
        Turn(frleg,  x_axis, math.rad(55.948491), math.rad(81.048186) / animSpeed)
        Turn(frthigh,x_axis, math.rad(-48.011777), math.rad(474.661742) / animSpeed)

        Turn(sleeve, x_axis, math.rad(-1.489601), math.rad(51.829060) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 6
        Move(base, z_axis, 0.499809, 3.122460 / animSpeed)
        Move(base, y_axis, 0.616884, 10.357904 / animSpeed)
        Turn(base, x_axis, math.rad(-1.363769), math.rad(15.596429) / animSpeed)
        Turn(base, z_axis, math.rad(1.126737), math.rad(33.325233) / animSpeed)

        Turn(blfoot, x_axis, math.rad(31.335808), math.rad(816.136294) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-27.509891), math.rad(361.080939) / animSpeed)
        Turn(blthigh,x_axis, math.rad(5.535280), math.rad(661.454614) / animSpeed)

        Turn(brfoot, x_axis, math.rad(45.223799), math.rad(19.888555) / animSpeed)
        Turn(brleg,  x_axis, math.rad(31.119657), math.rad(631.779675) / animSpeed)
        Turn(brthigh,x_axis, math.rad(-74.783413), math.rad(252.134999) / animSpeed)

        Turn(flfoot, x_axis, math.rad(-4.770465), math.rad(659.682628) / animSpeed)
        Turn(flleg,  x_axis, math.rad(62.523340), math.rad(1343.784480) / animSpeed)
        Turn(flthigh,x_axis, math.rad(-66.901648), math.rad(774.261194) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-8.198938), math.rad(27.213933) / animSpeed)
        Turn(frleg,  x_axis, math.rad(-6.005000), math.rad(1858.604712) / animSpeed)
        Turn(frthigh,x_axis, math.rad(15.938533), math.rad(1918.509296) / animSpeed)

        Turn(sleeve, x_axis, math.rad(-2.645311), math.rad(34.671298) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 9
        Move(base, y_axis, 0.034771, 17.463398 / animSpeed)
        Turn(base, z_axis, math.rad(1.804973), math.rad(20.347073) / animSpeed)

        Turn(blfoot, x_axis, math.rad(33.326580), math.rad(59.723140) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-24.285180), math.rad(96.741348) / animSpeed)
        Turn(blthigh,x_axis, math.rad(-26.634056), math.rad(965.080078) / animSpeed)

        Turn(brfoot, x_axis, math.rad(43.874198), math.rad(40.488030) / animSpeed)
        Turn(brleg,  x_axis, math.rad(-21.105233), math.rad(1566.746699) / animSpeed)
        Turn(brthigh,x_axis, math.rad(-21.005309), math.rad(1613.343121) / animSpeed)

        Turn(flfoot, x_axis, math.rad(-1.330889), math.rad(103.187264) / animSpeed)
        Turn(flleg,  x_axis, math.rad(53.863862), math.rad(259.784333) / animSpeed)
        Turn(flthigh,x_axis, math.rad(-53.649015), math.rad(397.578994) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-60.270183), math.rad(1562.137372) / animSpeed)
        Turn(frleg,  x_axis, math.rad(14.680173), math.rad(620.555198) / animSpeed)
        Turn(frthigh,x_axis, math.rad(47.164881), math.rad(936.790429) / animSpeed)

        Turn(sleeve, x_axis, math.rad(-2.785368), math.rad(4.201700) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 12
        Move(base, z_axis, 0.165993, 7.379988 / animSpeed)
        Move(base, y_axis, -0.560693, 17.863913 / animSpeed)
        Turn(base, x_axis, math.rad(-0.834127), math.rad(15.777316) / animSpeed)

        Turn(blfoot, x_axis, math.rad(50.583322), math.rad(517.702282) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-19.201432), math.rad(152.512421) / animSpeed)
        Turn(blthigh,x_axis, math.rad(-52.796252), math.rad(784.865883) / animSpeed)

        Turn(brfoot, x_axis, math.rad(30.119703), math.rad(412.634848) / animSpeed)
        Turn(brleg,  x_axis, math.rad(-20.750145), math.rad(10.652636) / animSpeed)
        Turn(brthigh,x_axis, math.rad(-6.534695), math.rad(434.118440) / animSpeed)

        Turn(flfoot, x_axis, math.rad(11.422524), math.rad(382.602393) / animSpeed)
        Turn(flleg,  x_axis, math.rad(5.980617), math.rad(1436.497370) / animSpeed)
        Turn(flthigh,x_axis, math.rad(-16.725287), math.rad(1107.711832) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-16.578216), math.rad(1310.759013) / animSpeed)
        Turn(frleg,  x_axis, math.rad(13.850349), math.rad(24.894733) / animSpeed)
        Turn(frthigh,x_axis, math.rad(65.775999), math.rad(558.333540) / animSpeed)

        Turn(sleeve, x_axis, math.rad(-1.855997), math.rad(27.881118) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 15
        Move(base, z_axis, -0.143739, 9.291945 / animSpeed)
        Move(base, y_axis, -0.940881, 11.405640 / animSpeed)
        Turn(base, x_axis, math.rad(0.012042), math.rad(25.385085) / animSpeed)
        Turn(base, z_axis, math.rad(1.088087), math.rad(21.063353) / animSpeed)

        Turn(blfoot, x_axis, math.rad(58.245934), math.rad(229.878349) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-15.902297), math.rad(98.974051) / animSpeed)
        Turn(blthigh,x_axis, math.rad(-42.715071), math.rad(302.435449) / animSpeed)

        Turn(brfoot, x_axis, math.rad(-17.367761), math.rad(1424.623918) / animSpeed)
        Turn(brleg,  x_axis, math.rad(2.925297), math.rad(710.263261) / animSpeed)
        Turn(brthigh,x_axis, math.rad(15.452675), math.rad(659.621079) / animSpeed)

        Turn(flfoot, x_axis, math.rad(-16.811310), math.rad(847.015029) / animSpeed)
        Turn(flleg,  x_axis, math.rad(-22.349964), math.rad(849.917403) / animSpeed)
        Turn(flthigh,x_axis, math.rad(29.634012), math.rad(1390.778982) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-31.442059), math.rad(445.915269) / animSpeed)
        Turn(frleg,  x_axis, math.rad(16.530934), math.rad(80.417563) / animSpeed)
        Turn(frthigh,x_axis, math.rad(73.262269), math.rad(224.588095) / animSpeed)

        Turn(sleeve, x_axis, math.rad(-0.214025), math.rad(49.259161) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 18
        Move(base, z_axis, -0.398283, 7.636313 / animSpeed)
        Turn(base, x_axis, math.rad(0.853589), math.rad(25.246387) / animSpeed)
        Turn(base, z_axis, 0, math.rad(32.642604) / animSpeed)

        Turn(blfoot, x_axis, math.rad(31.137869), math.rad(813.241938) / animSpeed)
        Turn(blleg,  x_axis, math.rad(-23.881217), math.rad(239.367582) / animSpeed)
        Turn(blthigh,x_axis, math.rad(-6.905451), math.rad(1074.288579) / animSpeed)

        Turn(brfoot, x_axis, math.rad(5.407492), math.rad(683.257589) / animSpeed)
        Turn(brleg,  x_axis, math.rad(35.651084), math.rad(981.773628) / animSpeed)
        Turn(brthigh,x_axis, math.rad(16.971019), math.rad(45.550327) / animSpeed)

        Turn(flfoot, x_axis, math.rad(-86.677122), math.rad(2095.974362) / animSpeed)
        Turn(flleg,  x_axis, math.rad(31.019864), math.rad(1601.094833) / animSpeed)
        Turn(flthigh,x_axis, math.rad(51.829262), math.rad(665.857486) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-33.393679), math.rad(58.548621) / animSpeed)
        Turn(frleg,  x_axis, math.rad(-30.939244), math.rad(1424.105353) / animSpeed)
        Turn(frthigh,x_axis, math.rad(75.561290), math.rad(68.970636) / animSpeed)

        Turn(sleeve, x_axis, math.rad(1.510121), math.rad(51.724371) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 21
        Move(base, z_axis, -0.499908, 3.048751 / animSpeed)
        Move(base, y_axis, -0.610246, 10.487309 / animSpeed)
        Turn(base, x_axis, math.rad(1.367404), math.rad(15.414457) / animSpeed)
        Turn(base, z_axis, math.rad(-1.113932), math.rad(33.417958) / animSpeed)

        Turn(blfoot, x_axis, math.rad(-39.590013), math.rad(2121.836481) / animSpeed)
        Turn(blleg,  x_axis, math.rad(31.181736), math.rad(1651.888593) / animSpeed)
        Turn(blthigh,x_axis, math.rad(7.774533), math.rad(440.399529) / animSpeed)

        Turn(brfoot, x_axis, math.rad(11.051618), math.rad(169.323779) / animSpeed)
        Turn(brleg,  x_axis, math.rad(32.214201), math.rad(103.106487) / animSpeed)
        Turn(brthigh,x_axis, math.rad(27.065502), math.rad(302.834503) / animSpeed)

        Turn(flfoot, x_axis, math.rad(-45.263472), math.rad(1242.409498) / animSpeed)
        Turn(flleg,  x_axis, math.rad(63.965172), math.rad(988.359245) / animSpeed)
        Turn(flthigh,x_axis, math.rad(68.426604), math.rad(497.920278) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-4.784207), math.rad(858.284175) / animSpeed)
        Turn(frleg,  x_axis, math.rad(-36.454079), math.rad(165.445043) / animSpeed)
        Turn(frthigh,x_axis, math.rad(9.402501), math.rad(1984.763677) / animSpeed)

        Turn(sleeve, x_axis, math.rad(2.654463), math.rad(34.330271) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 24
        Move(base, y_axis, -0.026367, 17.516356 / animSpeed)
        Turn(base, z_axis, math.rad(-1.800175), math.rad(20.587289) / animSpeed)

        Turn(blfoot, x_axis, math.rad(0.464943), math.rad(1201.648684) / animSpeed)
        Turn(blleg,  x_axis, math.rad(49.292335), math.rad(543.317950) / animSpeed)
        Turn(blthigh,x_axis, math.rad(14.201553), math.rad(192.810605) / animSpeed)

        Turn(brfoot, x_axis, math.rad(-9.958105), math.rad(630.291701) / animSpeed)
        Turn(brleg,  x_axis, math.rad(18.125394), math.rad(422.664212) / animSpeed)
        Turn(brthigh,x_axis, math.rad(27.977230), math.rad(27.351834) / animSpeed)

        Turn(flfoot, x_axis, math.rad(10.618845), math.rad(1676.469513) / animSpeed)
        Turn(flleg,  x_axis, math.rad(-19.845139), math.rad(2514.309327) / animSpeed)
        Turn(flthigh,x_axis, math.rad(77.857306), math.rad(282.921052) / animSpeed)

        Turn(frfoot, x_axis, math.rad(2.769608), math.rad(226.614452) / animSpeed)
        Turn(frleg,  x_axis, math.rad(-21.745628), math.rad(441.253511) / animSpeed)
        Turn(frthigh,x_axis, math.rad(-24.277361), math.rad(1010.395852) / animSpeed)

        Turn(sleeve, x_axis, math.rad(2.779637), math.rad(3.755217) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 27
        Move(base, z_axis, -0.162022, 7.427222 / animSpeed)
        Move(base, y_axis, 0.567635, 17.820053 / animSpeed)
        Turn(base, x_axis, math.rad(0.824308), math.rad(15.957077) / animSpeed)

        Turn(blfoot, x_axis, math.rad(14.997089), math.rad(435.964387) / animSpeed)
        Turn(blleg,  x_axis, math.rad(54.813518), math.rad(165.635502) / animSpeed)
        Turn(blthigh,x_axis, math.rad(16.713456), math.rad(75.357084) / animSpeed)

        Turn(brfoot, x_axis, math.rad(31.833183), math.rad(1253.738630) / animSpeed)
        Turn(brleg,  x_axis, math.rad(-18.596887), math.rad(1101.668447) / animSpeed)
        Turn(brthigh,x_axis, math.rad(22.049241), math.rad(177.839684) / animSpeed)

        Turn(flfoot, x_axis, math.rad(19.505827), math.rad(266.609459) / animSpeed)
        Turn(flleg,  x_axis, math.rad(-40.937903), math.rad(632.782944) / animSpeed)
        Turn(flthigh,x_axis, math.rad(37.531224), math.rad(1209.782469) / animSpeed)

        Turn(frfoot, x_axis, math.rad(10.672022), math.rad(237.072415) / animSpeed)
        Turn(frleg,  x_axis, math.rad(21.664846), math.rad(1302.314235) / animSpeed)
        Turn(frthigh,x_axis, math.rad(-47.179190), math.rad(687.054876) / animSpeed)

        Turn(sleeve, x_axis, math.rad(1.837585), math.rad(28.261545) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- FRAME 30
        Move(base, z_axis, 0.147760, 9.293448 / animSpeed)
        Move(base, y_axis, 0.943695, 11.281815 / animSpeed)
        Turn(base, x_axis, math.rad(-0.024084), math.rad(25.451758) / animSpeed)
        Turn(base, z_axis, math.rad(-1.101048), math.rad(20.826065) / animSpeed)

        Turn(blfoot, x_axis, math.rad(-26.311835), math.rad(1239.267730) / animSpeed)
        Turn(blleg,  x_axis, math.rad(32.133882), math.rad(680.389089) / animSpeed)
        Turn(blthigh,x_axis, math.rad(18.907702), math.rad(65.827382) / animSpeed)

        Turn(brfoot, x_axis, math.rad(46.532177), math.rad(440.969819) / animSpeed)
        Turn(brleg,  x_axis, math.rad(-35.017758), math.rad(492.626130) / animSpeed)
        Turn(brthigh,x_axis, math.rad(-3.066345), math.rad(753.467571) / animSpeed)

        Turn(flleg,  x_axis, math.rad(-0.815188), math.rad(1203.681449) / animSpeed)
        Turn(flthigh,x_axis, math.rad(-23.173705), math.rad(1821.147853) / animSpeed)

        Turn(frfoot, x_axis, math.rad(-2.568909), math.rad(397.227939) / animSpeed)
        Turn(frleg,  x_axis, math.rad(61.211411), math.rad(1186.396943) / animSpeed)
        Turn(frthigh,x_axis, math.rad(-65.542782), math.rad(550.907759) / animSpeed)

        Turn(sleeve, x_axis, math.rad(0.189998), math.rad(49.427613) / animSpeed)

        Sleep((33 * animSpeed) - 1)
    end
end

--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------
local function StopWalking()
    Move(base, y_axis, 0, 10)
    Move(base, z_axis, 0, 10)

    for _, p in ipairs({
        flthigh, flleg, flfoot,
        frthigh, frleg, frfoot,
        blthigh, blleg, blfoot,
        brthigh, brleg, brfoot
    }) do
        Turn(p, x_axis, 0, math.rad(200))
        Turn(p, y_axis, 0, math.rad(200))
        Turn(p, z_axis, 0, math.rad(200))
    end
end

--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    Signal(SIG_MOVE)
    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    Signal(SIG_MOVE)
    isMoving = false
    StartThread(StopWalking)
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    StartThread(UnitSpeed)
    StartThread(StopWalking)
end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
    return sleeve
end

function script.QueryWeapon1()
    return (gun == 0) and flare1 or flare2
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy, y_axis, heading, math.rad(300))
    Turn(aimx, x_axis, -pitch, math.rad(100))

    WaitForTurn(aimy, y_axis)
    WaitForTurn(aimx, x_axis)

    lastHeading = heading

    Signal(SIG_RESTORE)
    StartThread(function()
        SetSignalMask(SIG_RESTORE)
        Sleep(restoreDelay)
        if not stunned then
            Turn(aimy, y_axis, 0, math.rad(90))
            Turn(aimx, x_axis, 0, math.rad(50))
        end
    end)

    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon1()
    Signal(SIG_FIRE)
    SetSignalMask(SIG_FIRE)

    if gun == 0 then
        EmitSfx(flare1, 1024)
        Move(barrel1, z_axis, -4)
        Sleep(50)
        Move(barrel1, z_axis, 0, 4)
    else
        EmitSfx(flare2, 1024)
        Move(barrel2, z_axis, -4)
        Sleep(50)
        Move(barrel2, z_axis, 0, 4)
    end

    gun = 1 - gun
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(state)
    stunned = state
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- KILLED (FIXED)
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth

    if severity < 0.5 then
        -- light death (mostly intact)
        Explode(armor, SFX.SMOKE)
        Explode(barrel1, SFX.SMOKE)
        Explode(barrel2, SFX.SMOKE)

        return 1 -- wreck

    elseif severity < 1 then
        -- medium death
        Explode(armor, SFX.FIRE + SFX.SMOKE)
        Explode(barrel1, SFX.FIRE)
        Explode(barrel2, SFX.FIRE)

        Explode(flthigh, SFX.SHATTER)
        Explode(frthigh, SFX.SHATTER)

        return 2 -- heap

    else
        -- overkill
        Explode(armor, SFX.EXPLODE + SFX.FIRE)
        Explode(barrel1, SFX.EXPLODE)
        Explode(barrel2, SFX.EXPLODE)

        Explode(flthigh, SFX.EXPLODE)
        Explode(frthigh, SFX.EXPLODE)
        Explode(blthigh, SFX.EXPLODE)
        Explode(brthigh, SFX.EXPLODE)

        Explode(base, SFX.EXPLODE)

        return 2 -- heap (no clean wreck)
    end
end