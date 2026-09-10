include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local pelvis, aimy1, torso, armor, aimx1, barrel, flare, backblast =
    piece('pelvis','aimy1','torso','armor','aimx1','barrel','flare','backblast')

local lthigh, lknee, lleg, lfoot =
    piece('lthigh','lknee','lleg','lfoot')

local rthigh, rknee, rleg, rfoot =
    piece('rthigh','rknee','rleg','rfoot')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM  = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 6
local gunHeading = 0
local stunned = false

--------------------------------------------------------------------------------
-- SPEED SYSTEM ()
--------------------------------------------------------------------------------
-- local function UnitSpeed()
    -- while true do
        -- local vx,_,vz = Spring.GetUnitVelocity(unitID)
        -- local speed = math.sqrt(vx*vx + vz*vz)

        -- animSpeed = (6 - math.min(5, speed * 10))
        -- if animSpeed < 1 then animSpeed = 1 end

        -- Sleep(100)
    -- end
-- end

--------------------------------------------------------------------------------
-- WALK
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    while isMoving do

        -- FRAME 3
        Turn(barrel, x_axis, math.rad(-6.75), math.rad(103.7)/animSpeed)
        Turn(lfoot,  x_axis, math.rad(27.26), math.rad(269.3)/animSpeed)
        Turn(lknee,  x_axis, math.rad(-27.06), math.rad(1386.4)/animSpeed)
        Turn(lleg,   x_axis, math.rad(13.60), math.rad(1607.5)/animSpeed)
        Turn(lthigh, x_axis, math.rad(-13.81), math.rad(42.1)/animSpeed)

        Move(pelvis, z_axis, 0.960679, 13.12/animSpeed)
        Move(pelvis, y_axis, 0.150892, 46.82/animSpeed)

        Turn(rfoot,  x_axis, math.rad(11.27), math.rad(831.2)/animSpeed)
        Turn(rknee,  x_axis, math.rad(44.00), math.rad(1344.9)/animSpeed)
        Turn(rleg,   x_axis, math.rad(-15.22), math.rad(1221.4)/animSpeed)
        Turn(rthigh, x_axis, math.rad(16.95), math.rad(650.7)/animSpeed)

        Turn(torso, y_axis, math.rad(5.67), math.rad(46.88)/animSpeed)

        Sleep((33*animSpeed)-1)

        -- FRAME 6
        Turn(barrel, x_axis, math.rad(-0.83), math.rad(177.5)/animSpeed)
        Turn(lfoot,  x_axis, math.rad(9.01), math.rad(547.4)/animSpeed)
        Turn(lknee,  x_axis, math.rad(-7.80), math.rad(577.7)/animSpeed)
        Turn(lleg,   x_axis, math.rad(3.14), math.rad(313.6)/animSpeed)
        Turn(lthigh, x_axis, math.rad(-3.53), math.rad(308.3)/animSpeed)

        Move(pelvis, z_axis, 0.161194, 23.98/animSpeed)
        Move(pelvis, y_axis, 0.463159, 9.36/animSpeed)

        Turn(rfoot,  x_axis, math.rad(49.74), math.rad(1154)/animSpeed)
        Turn(rleg,   x_axis, math.rad(-41.54), math.rad(789.5)/animSpeed)
        Turn(rthigh, x_axis, math.rad(-7.68), math.rad(739.4)/animSpeed)

        Turn(torso, y_axis, math.rad(5.05), math.rad(18.4)/animSpeed)

        Sleep((33*animSpeed)-1)

        -- FRAME 9
        Turn(barrel, x_axis, math.rad(6.24), math.rad(212.3)/animSpeed)
        Turn(lfoot,  x_axis, math.rad(-21.87), math.rad(926.6)/animSpeed)
        Turn(lknee,  x_axis, math.rad(-10.59), math.rad(83.6)/animSpeed)
        Turn(lleg,   x_axis, math.rad(18.84), math.rad(470.7)/animSpeed)
        Turn(lthigh, x_axis, math.rad(13.82), math.rad(520.8)/animSpeed)

        Move(pelvis, y_axis, 2.21, 52.5/animSpeed)

        Turn(rfoot,  x_axis, math.rad(83.85), math.rad(1023.4)/animSpeed)
        Turn(rknee,  x_axis, math.rad(-0.30), math.rad(1331.7)/animSpeed)
        Turn(rleg,   x_axis, math.rad(-21.04), math.rad(615.1)/animSpeed)
        Turn(rthigh, x_axis, math.rad(-26.46), math.rad(563.2)/animSpeed)

        Turn(torso, y_axis, math.rad(2.50), math.rad(76.7)/animSpeed)

        Sleep((33*animSpeed)-1)

        -- FRAME 12
        Turn(barrel, x_axis, math.rad(4.652213), math.rad(47.715360) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(-33.092113), math.rad(336.484266) / animSpeed)
        Turn(lknee,  x_axis, math.rad(-17.030107), math.rad(193.087792) / animSpeed)
        Turn(lleg,   x_axis, math.rad(33.728734), math.rad(446.630492) / animSpeed)
        Turn(lthigh, x_axis, math.rad(34.599686), math.rad(623.232342) / animSpeed)

        Move(pelvis, z_axis, 0.877801, 23.040959 / animSpeed)
        Move(pelvis, y_axis, 2.974123, 22.775445 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(66.756070), math.rad(512.995291) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-38.448856), math.rad(1144.360246) / animSpeed)
        Turn(rleg,   x_axis, math.rad(20.771741), math.rad(1254.456056) / animSpeed)
        Turn(rthigh, x_axis, math.rad(-26.618992), math.rad(4.725279) / animSpeed)

        Turn(torso, y_axis, math.rad(-1.016784), math.rad(105.515006) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 15
        Turn(barrel, x_axis, math.rad(-3.397265), math.rad(241.484348) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(-16.189580), math.rad(507.075976) / animSpeed)
        Turn(lknee,  x_axis, math.rad(-0.675451), math.rad(490.639664) / animSpeed)
        Turn(lleg,   x_axis, math.rad(25.396621), math.rad(249.963409) / animSpeed)
        Turn(lthigh, x_axis, math.rad(38.648062), math.rad(121.451282) / animSpeed)

        Move(pelvis, z_axis, 1.398980, 15.635387 / animSpeed)
        Move(pelvis, y_axis, 1.686683, 38.623202 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(18.453110), math.rad(1449.088785) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-73.006465), math.rad(1036.728254) / animSpeed)
        Turn(rleg,   x_axis, math.rad(66.867982), math.rad(1382.887245) / animSpeed)
        Turn(rthigh, x_axis, math.rad(-12.529664), math.rad(422.679836) / animSpeed)

        Turn(torso, y_axis, math.rad(-4.143561), math.rad(93.803302) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 18
        Turn(barrel, x_axis, math.rad(-6.730090), math.rad(99.984736) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(11.385446), math.rad(827.250775) / animSpeed)
        Turn(lknee,  x_axis, math.rad(44.109509), math.rad(1343.548795) / animSpeed)
        Turn(lleg,   x_axis, math.rad(-15.309657), math.rad(1221.188339) / animSpeed)
        Turn(lthigh, x_axis, math.rad(16.932384), math.rad(651.470342) / animSpeed)

        Move(pelvis, z_axis, 0.949719, 13.477836 / animSpeed)
        Move(pelvis, y_axis, 0.140059, 46.398733 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(27.328439), math.rad(266.259864) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-27.052568), math.rad(1378.616908) / animSpeed)
        Turn(rleg,   x_axis, math.rad(13.567658), math.rad(1599.009738) / animSpeed)
        Turn(rthigh, x_axis, math.rad(-13.856424), math.rad(39.802774) / animSpeed)

        Turn(torso, y_axis, math.rad(-5.679441), math.rad(46.076384) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 21
        Turn(barrel, x_axis, math.rad(-0.719080), math.rad(180.330281) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(49.739466), math.rad(1150.620617) / animSpeed)
        Turn(lknee,  x_axis, math.rad(43.897824), math.rad(6.350539) / animSpeed)
        Turn(lleg,   x_axis, math.rad(-41.447896), math.rad(784.147176) / animSpeed)
        Turn(lthigh, x_axis, math.rad(-7.723534), math.rad(739.677547) / animSpeed)

        Move(pelvis, z_axis, 0.153757, 23.878872 / animSpeed)
        Move(pelvis, y_axis, 0.481532, 10.244193 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(9.001361), math.rad(549.812333) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-7.947343), math.rad(573.156724) / animSpeed)
        Turn(rleg,   x_axis, math.rad(3.280028), math.rad(308.628877) / animSpeed)
        Turn(rthigh, x_axis, math.rad(-3.515701), math.rad(310.221666) / animSpeed)

        Turn(torso, y_axis, math.rad(-5.034726), math.rad(19.341444) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 24
        Turn(barrel, x_axis, math.rad(6.290283), math.rad(210.280895) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(83.423992), math.rad(1010.535777) / animSpeed)
        Turn(lknee,  x_axis, math.rad(-0.352558), math.rad(1327.511451) / animSpeed)
        Turn(lleg,   x_axis, math.rad(-20.948667), math.rad(614.976897) / animSpeed)
        Turn(lthigh, x_axis, math.rad(-26.393007), math.rad(560.084178) / animSpeed)

        Move(pelvis, y_axis, 2.237012, 52.664423 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(-21.922749), math.rad(927.723302) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-10.763298), math.rad(84.478640) / animSpeed)
        Turn(rleg,   x_axis, math.rad(19.002418), math.rad(471.671682) / animSpeed)
        Turn(rthigh, x_axis, math.rad(13.880146), math.rad(521.875410) / animSpeed)

        Turn(torso, y_axis, math.rad(-2.456952), math.rad(77.333220) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 27
        Turn(barrel, x_axis, math.rad(4.566438), math.rad(51.715337) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(66.399875), math.rad(510.723502) / animSpeed)
        Turn(lknee,  x_axis, math.rad(-38.363660), math.rad(1140.333056) / animSpeed)
        Turn(lleg,   x_axis, math.rad(20.663376), math.rad(1248.361290) / animSpeed)
        Turn(lthigh, x_axis, math.rad(-26.624817), math.rad(6.954294) / animSpeed)

        Move(pelvis, z_axis, 0.889159, 23.189372 / animSpeed)
        Move(pelvis, y_axis, 2.969250, 21.967142 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(-33.139774), math.rad(336.510750) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-17.036887), math.rad(188.207681) / animSpeed)
        Turn(rleg,   x_axis, math.rad(33.747896), math.rad(442.364356) / animSpeed)
        Turn(rthigh, x_axis, math.rad(34.634964), math.rad(622.644544) / animSpeed)

        Turn(torso, y_axis, math.rad(1.064150), math.rad(105.633066) / animSpeed)

        Sleep((33 * animSpeed) - 1)


        -- FRAME 30
        Turn(barrel, x_axis, math.rad(-3.497289), math.rad(241.911826) / animSpeed)
        Turn(lfoot,  x_axis, math.rad(18.314268), math.rad(1442.568225) / animSpeed)
        Turn(lknee,  x_axis, math.rad(-72.738810), math.rad(1031.254507) / animSpeed)
        Turn(lleg,   x_axis, math.rad(66.554197), math.rad(1376.724604) / animSpeed)
        Turn(lthigh, x_axis, math.rad(-12.649481), math.rad(419.260063) / animSpeed)

        Move(pelvis, z_axis, 1.399516, 15.310730 / animSpeed)
        Move(pelvis, y_axis, 1.661633, 39.228526 / animSpeed)

        Turn(rfoot,  x_axis, math.rad(-16.247610), math.rad(506.764929) / animSpeed)
        Turn(rknee,  x_axis, math.rad(-0.523777), math.rad(495.393317) / animSpeed)
        Turn(rleg,   x_axis, math.rad(25.307562), math.rad(253.210036) / animSpeed)
        Turn(rthigh, x_axis, math.rad(38.643479), math.rad(120.255452) / animSpeed)

        Turn(torso, y_axis, math.rad(4.176682), math.rad(93.375961) / animSpeed)

        Sleep((33 * animSpeed) - 1)

    end
end

--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------

local function StopWalking()
    Signal(SIG_MOVE)

    local s = 10

    -- pelvis reset
    Move(pelvis, y_axis, 0, 175/s)
    Move(pelvis, z_axis, 0, 80/s)

    -- barrel reset 
    Turn(barrel, x_axis, 0, math.rad(800)/s)

    -- legs reset
    for _, p in ipairs({
        lthigh, lknee, lleg, lfoot,
        rthigh, rknee, rleg, rfoot
    }) do
        Turn(p, x_axis, 0, math.rad(600))
    end

    -- torso reset
    Turn(torso, y_axis, 0, math.rad(350)/s)

    -- stance offsets 
    Turn(lthigh, y_axis, math.rad(15), math.rad(60))
    Turn(rthigh, y_axis, math.rad(-15), math.rad(60))


    WaitForMove(pelvis, y_axis)
    WaitForMove(pelvis, z_axis)

    WaitForTurn(torso, y_axis)
    WaitForTurn(barrel, x_axis)
end
--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
    StartThread(StopWalking)
end

--------------------------------------------------------------------------------
-- CREATE
--------------------------------------------------------------------------------
function script.Create()
    Hide(flare)
    Hide(aimx1)
    Hide(aimy1)

    -- StartThread(UnitSpeed)
end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
    return aimx1
end

function script.QueryWeapon1()
    return flare
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    Turn(aimy1, y_axis, heading, math.rad(270))
    Turn(aimx1, x_axis, -pitch, math.rad(135))

    if math.abs(heading - gunHeading) > math.rad(7) then
        WaitForTurn(aimy1, y_axis)
        WaitForTurn(aimx1, x_axis)
    end

    gunHeading = heading

    StartThread(function()
        Sleep(5000)
        if not stunned then
            Turn(aimy1, y_axis, 0, math.rad(270))
            Turn(aimx1, x_axis, 0, math.rad(135))
        end
    end)

    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon1()
    EmitSfx(backblast, 1024)

    Turn(torso, y_axis, math.rad(8), math.rad(1000))
    Turn(barrel, x_axis, math.rad(-5), math.rad(1000))

    Sleep(32)

    Turn(barrel, x_axis, 0, math.rad(5))
    Turn(torso, y_axis, 0, math.rad(16))
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(s)
    stunned = s
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(severity)
    Explode(pelvis, SFX.EXPLODE)
    Explode(torso, SFX.FIRE)
    Explode(lleg, SFX.SMOKE)
    return 3
end