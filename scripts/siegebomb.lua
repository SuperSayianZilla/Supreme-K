include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local base, armor, dishbase, blob, dish1, dish2, dish3, dish4 =
    piece('base','armor','dishbase','blob','dish1','dish2','dish3','dish4')

local thighfl, legfl, footfl = piece('thighfl','legfl','footfl')
local thighbl, legbl, footbl = piece('thighbl','legbl','footbl')
local thighfr, legfr, footfr = piece('thighfr','legfr','footfr')
local thighbr, legbr, footbr = piece('thighbr','legbr','footbr')

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE   = 1
local SIG_TURNON = 2
local SIG_OFF    = 4

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local animSpeed = 4
local isMoving = false

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- WALK
--------------------------------------------------------------------------------


local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    local sp = animSpeed
    local frame = 33

    while isMoving do

        --------------------------------------------------------------------------------
        -- FRAME 3
        --------------------------------------------------------------------------------
        Move(base,x_axis,0.942489,11.335389/sp)
        Move(base,z_axis,0.694308,17.003809/sp)
        Turn(base,x_axis,math.rad(6.092794),98.636450/sp)
        Turn(base,z_axis,math.rad(-0.085934),51.105379/sp)
        Turn(base,y_axis,math.rad(2.078072),22.885134/sp)

        Turn(footbr,z_axis,math.rad(-18.314901),606.981273/sp)
        Turn(footbl,z_axis,math.rad(-21.751827),370.932138/sp)
        Turn(footfr,z_axis,math.rad(31.553712),517.981671/sp)

        Turn(legbl,z_axis,math.rad(1.698923),70.732142/sp)
        Turn(legbr,z_axis,math.rad(5.277456),1178.178189/sp)
        Turn(legfl,z_axis,math.rad(-15.761368),210.088508/sp)
        Turn(legfr,z_axis,math.rad(-14.361700),411.894063/sp)

        Turn(thighbl,y_axis,math.rad(23.621011),790.738780/sp)
        Turn(thighbr,y_axis,math.rad(-68.313790),154.487404/sp)
        Turn(thighfl,y_axis,math.rad(-32.363731),597.544495/sp)
        Turn(thighfr,y_axis,math.rad(63.739940),117.250716/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 6
        --------------------------------------------------------------------------------
        Move(base,z_axis,0.297148,11.914806/sp)
        Move(base,y_axis,0.056670,41.082973/sp)
        Turn(base,x_axis,math.rad(7.073049),29.407653/sp)
        Turn(base,z_axis,math.rad(-1.756453),50.115565/sp)
        Turn(base,y_axis,math.rad(0.517369),46.821112/sp)

        Turn(footbr,z_axis,math.rad(38.352943),1700.035331/sp)
        Turn(footbl,z_axis,math.rad(-12.434908),279.507554/sp)
        Turn(footfl,z_axis,math.rad(38.882826),30.131687/sp)
        Turn(footfr,z_axis,math.rad(15.886308),1423.200592/sp)

        Turn(legbr,z_axis,math.rad(-15.961433),637.166683/sp)
        Turn(legfl,z_axis,math.rad(-20.622390),145.830652/sp)
        Turn(legfr,z_axis,math.rad(9.404558),712.987764/sp)

        Turn(thighbl,y_axis,math.rad(42.777352),574.690238/sp)
        Turn(thighbr,y_axis,math.rad(-56.081553),366.967110/sp)
        Turn(thighfl,y_axis,math.rad(-48.698334),490.038069/sp)
        Turn(thighfr,y_axis,math.rad(58.171847),167.042795/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 9
        --------------------------------------------------------------------------------
        Move(base,x_axis,0.606454,10.560533/sp)
        Move(base,z_axis,-0.512562,24.291311/sp)
        Move(base,y_axis,-0.697258,22.617846/sp)

        Turn(footbr,z_axis,math.rad(72.011313),1009.751090/sp)
        Turn(footbl,z_axis,math.rad(7.069373),585.128454/sp)
        Turn(footfl,z_axis,math.rad(-2.255094),1234.137596/sp)
        Turn(footfr,z_axis,math.rad(32.431033),496.341736/sp)

        Turn(legbl,z_axis,math.rad(-2.030577),114.194916/sp)
        Turn(legbr,z_axis,math.rad(-19.590625),108.875760/sp)
        Turn(legfl,z_axis,math.rad(-7.710637),387.352587/sp)
        Turn(legfr,z_axis,math.rad(13.142669),112.143314/sp)

        Turn(thighbl,y_axis,math.rad(58.423922),469.397101/sp)
        Turn(thighbr,y_axis,math.rad(-33.254139),684.822428/sp)
        Turn(thighfl,y_axis,math.rad(-59.145839),313.425155/sp)
        Turn(thighfr,y_axis,math.rad(47.683972),314.636250/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 12
        --------------------------------------------------------------------------------
        Move(base,x_axis,0.021591,17.545873/sp)
        Move(base,y_axis,0.211046,27.249126/sp)

        Turn(footbr,z_axis,math.rad(71.343170),20.044283/sp)
        Turn(footbl,z_axis,math.rad(38.889960),954.617594/sp)
        Turn(footfl,z_axis,math.rad(-37.412802),1054.731229/sp)
        Turn(footfr,z_axis,math.rad(40.648696),246.529907/sp)

        Turn(legbl,z_axis,math.rad(-19.558962),525.851541/sp)
        Turn(legbr,z_axis,math.rad(-16.337966),97.579771/sp)
        Turn(legfl,z_axis,math.rad(14.111977),654.678422/sp)
        Turn(legfr,z_axis,math.rad(8.366449),143.286594/sp)

        Turn(thighbl,y_axis,math.rad(70.008981),347.551785/sp)
        Turn(thighbr,y_axis,math.rad(-4.380907),866.196954/sp)
        Turn(thighfl,y_axis,math.rad(-65.321689),185.275507/sp)
        Turn(thighfr,y_axis,math.rad(23.911717),713.167645/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 15
        --------------------------------------------------------------------------------
        Move(base,x_axis,-0.571561,17.794573/sp)
        Move(base,z_axis,0.139069,22.491525/sp)
        Move(base,y_axis,1.520524,39.284334/sp)

        Turn(footbr,z_axis,math.rad(33.959861),1121.499269/sp)
        Turn(footbl,z_axis,math.rad(49.531610),319.249496/sp)
        Turn(footfl,z_axis,math.rad(-46.305285),266.774485/sp)
        Turn(footfr,z_axis,math.rad(39.687808),28.826643/sp)

        Turn(legbl,z_axis,math.rad(-45.600638),781.250271/sp)
        Turn(legbr,z_axis,math.rad(-4.012985),369.749448/sp)
        Turn(legfl,z_axis,math.rad(25.576885),343.947238/sp)
        Turn(legfr,z_axis,math.rad(8.757976),11.745808/sp)

        Turn(thighbl,y_axis,math.rad(73.466888),103.737186/sp)
        Turn(thighbr,y_axis,math.rad(2.732490),213.401910/sp)
        Turn(thighfl,y_axis,math.rad(-67.644930),69.697231/sp)
        Turn(thighfr,y_axis,math.rad(12.439549),344.165028/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 18
        --------------------------------------------------------------------------------
        Move(base,x_axis,-0.945266,11.211126/sp)
        Move(base,z_axis,0.695708,16.699165/sp)
        Move(base,y_axis,1.413141,3.221483/sp)

        Turn(footbr,z_axis,math.rad(21.814014),364.375412/sp)
        Turn(footbl,z_axis,math.rad(18.229404),939.066163/sp)
        Turn(footfl,z_axis,math.rad(-31.388534),447.502520/sp)

        Turn(legbl,z_axis,math.rad(-5.225950),1211.240642/sp)
        Turn(legbr,z_axis,math.rad(-1.712459),69.015779/sp)
        Turn(legfl,z_axis,math.rad(14.231941),340.348301/sp)
        Turn(legfr,z_axis,math.rad(15.797932),211.198687/sp)

        Turn(thighbl,y_axis,math.rad(68.279202),155.630573/sp)
        Turn(thighbr,y_axis,math.rad(-23.612483),790.349197/sp)
        Turn(thighfl,y_axis,math.rad(-63.758395),116.596042/sp)
        Turn(thighfr,y_axis,math.rad(32.350638),597.332649/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 21
        --------------------------------------------------------------------------------
        Move(base,z_axis,0.286449,12.277754/sp)
        Move(base,y_axis,0.037985,41.254692/sp)

        Turn(footbr,z_axis,math.rad(12.664363),274.489542/sp)
        Turn(footbl,z_axis,math.rad(-38.520443),1702.495428/sp)
        Turn(footfl,z_axis,math.rad(17.344427),1461.988827/sp)

        Turn(legbl,z_axis,math.rad(16.033517),637.784013/sp)
        Turn(legbr,z_axis,math.rad(-1.865863),4.602124/sp)
        Turn(legfl,z_axis,math.rad(-9.452366),710.529229/sp)
        Turn(legfr,z_axis,math.rad(20.654927),145.709860/sp)

        Turn(thighbl,y_axis,math.rad(56.004324),368.246336/sp)
        Turn(thighbr,y_axis,math.rad(-42.803556),575.732184/sp)
        Turn(thighfl,y_axis,math.rad(-58.204400),166.619869/sp)
        Turn(thighfr,y_axis,math.rad(48.703839),490.596027/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 24
        --------------------------------------------------------------------------------
        Move(base,x_axis,-0.599747,10.688773/sp)
        Move(base,z_axis,-0.520506,24.208656/sp)
        Move(base,y_axis,-0.695725,22.011309/sp)

        Turn(footbr,z_axis,math.rad(-15.624934),848.678889/sp)
        Turn(footbl,z_axis,math.rad(-72.011429),1004.729570/sp)
        Turn(footfl,z_axis,math.rad(42.720952),761.295736/sp)
        Turn(footfr,z_axis,math.rad(-2.294120),1259.457842/sp)

        Turn(legbl,z_axis,math.rad(19.622515),107.669941/sp)
        Turn(legbr,z_axis,math.rad(7.024834),266.720908/sp)
        Turn(legfl,z_axis,math.rad(-13.120860),110.054812/sp)
        Turn(legfr,z_axis,math.rad(7.674630),389.408918/sp)

        Turn(thighbl,y_axis,math.rad(33.166818),685.125177/sp)
        Turn(thighbr,y_axis,math.rad(-58.484403),470.425420/sp)
        Turn(thighfl,y_axis,math.rad(-47.691779),315.378623/sp)
        Turn(thighfr,y_axis,math.rad(59.156207),313.571048/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 27
        --------------------------------------------------------------------------------
        Move(base,x_axis,-0.013185,17.596860/sp)
        Move(base,y_axis,0.230670,27.791862/sp)

        Turn(footbr,z_axis,math.rad(-29.933048),429.243426/sp)
        Turn(footbl,z_axis,math.rad(-71.176971),25.033736/sp)
        Turn(footfl,z_axis,math.rad(39.887215),85.012086/sp)
        Turn(footfr,z_axis,math.rad(-35.454255),994.804054/sp)

        Turn(legbl,z_axis,math.rad(16.328334),98.825444/sp)
        Turn(legbr,z_axis,math.rad(21.470833),433.379960/sp)
        Turn(legfl,z_axis,math.rad(-8.313635),144.216763/sp)
        Turn(legfr,z_axis,math.rad(-12.158048),594.980357/sp)

        Turn(thighbl,y_axis,math.rad(4.414476),862.570264/sp)
        Turn(thighbr,y_axis,math.rad(-70.056868),347.173939/sp)
        Turn(thighfl,y_axis,math.rad(-23.845739),715.381190/sp)
        Turn(thighfr,y_axis,math.rad(65.325773),185.086993/sp)

        Sleep(frame)

        --------------------------------------------------------------------------------
        -- FRAME 30
        --------------------------------------------------------------------------------
        Move(base,x_axis,0.564642,17.334837/sp)
        Move(base,z_axis,0.127514,21.969687/sp)
        Move(base,y_axis,1.509766,38.372869/sp)

        Turn(footbr,z_axis,math.rad(-38.547610),258.436873/sp)
        Turn(footbl,z_axis,math.rad(-34.116231),1111.822189/sp)
        Turn(footfr,z_axis,math.rad(48.819767),400.965367/sp)

        Turn(legbl,z_axis,math.rad(4.056661),368.150184/sp)
        Turn(legbr,z_axis,math.rad(44.550063),692.376891/sp)
        Turn(legfl,z_axis,math.rad(-8.758418),13.343509/sp)
        Turn(legfr,z_axis,math.rad(-28.091503),478.003626/sp)

        Turn(thighbl,y_axis,math.rad(-2.736949),214.542735/sp)
        Turn(thighbr,y_axis,math.rad(-73.463370),102.195066/sp)
        Turn(thighfl,y_axis,math.rad(-12.445581),342.004733/sp)
        Turn(thighfr,y_axis,math.rad(67.648297),69.675716/sp)

        Sleep(frame)

    end
end
--------------------------------------------------------------------------------
-- STOP WALK
--------------------------------------------------------------------------------
local function StopWalking()
    Signal(SIG_MOVE)

    local s = 10

    Move(base,x_axis,0,59.315243/s)
    Move(base,y_axis,0,137.515640/s)
    Move(base,z_axis,0,80.971035/s)

    Turn(base,x_axis,0,math.rad(330.026907)/s)
    Turn(base,y_axis,0,math.rad(175.934494)/s)
    Turn(base,z_axis,0,math.rad(170.764860)/s)

    Turn(footbr,z_axis,0,math.rad(5666.784436)/s)
    Turn(footbl,z_axis,0,math.rad(5674.984762)/s)
    Turn(footfl,z_axis,0,math.rad(4873.296089)/s)
    Turn(footfr,z_axis,0,math.rad(4744.001974)/s)

    Turn(legbl,z_axis,0,math.rad(4037.468807)/s)
    Turn(legbr,z_axis,0,math.rad(3927.260631)/s)
    Turn(legfl,z_axis,0,math.rad(2368.430762)/s)
    Turn(legfr,z_axis,0,math.rad(2376.625879)/s)

    Turn(thighbl,x_axis,0,math.rad(235.554185)/s)
    Turn(thighbl,y_axis,math.rad(45),math.rad(2875.234213)/s)
    Turn(thighbl,z_axis,0,math.rad(2620.473109)/s)

    Turn(thighbr,x_axis,0,math.rad(235.645937)/s)
    Turn(thighbr,y_axis,math.rad(-45),math.rad(2887.323178)/s)
    Turn(thighbr,z_axis,0,math.rad(2632.548713)/s)

    Turn(thighfl,x_axis,0,math.rad(337.799780)/s)
    Turn(thighfl,y_axis,math.rad(-45),math.rad(2384.603967)/s)
    Turn(thighfl,z_axis,0,math.rad(1378.428053)/s)

    Turn(thighfr,x_axis,0,math.rad(333.012693)/s)
    Turn(thighfr,y_axis,math.rad(45),math.rad(2377.225484)/s)
    Turn(thighfr,z_axis,0,math.rad(1389.380945)/s)
end

--------------------------------------------------------------------------------
-- SPIN (ALWAYS ON)
--------------------------------------------------------------------------------

local function StartSpin()
    if spinStarted then return end
    spinStarted = true

    Spin(dishbase, y_axis, math.rad(100))

    Move(dish4, z_axis, 0, 2)
    Move(dish3, x_axis, 0, 2)
    Move(dish2, z_axis, 0, 2)
    Move(dish1, x_axis, 0, 2)
end



--------------------------------------------------------------------------------
-- THREAD CONTROL
--------------------------------------------------------------------------------
local walkThread = nil
local spinStarted = false


--------------------------------------------------------------------------------
-- WALK CONTROL
--------------------------------------------------------------------------------
function script.StartMoving()
    if walkThread then
        Signal(SIG_MOVE)
    end

    isMoving = true
    walkThread = StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
    Signal(SIG_MOVE)

    -- start restore cleanly
    StartThread(StopWalking)
end

--------------------------------------------------------------------------------
-- CREATE (ALWAYS ON)
--------------------------------------------------------------------------------
function script.Create()
    isMoving = false
    animSpeed = 4

    StartThread(StopWalking)

    -- ALWAYS ON
    StartThread(StartSpin)

end
--------------------------------------------------------------------------------
-- ACTIVATE 
--------------------------------------------------------------------------------
function script.Activate()
    Signal(SIG_TURNON)
    SetSignalMask(SIG_TURNON)

    StartThread(StartSpin)


    return true
end


--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(severity)
    Explode(base, SFX.EXPLODE)
    Explode(armor, SFX.FIRE)
    Explode(thighfr, SFX.SMOKE)
    return 3
end