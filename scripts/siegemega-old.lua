include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local hip = piece("hip")
local lLegConnector = piece("lLegConnector")
local lUpperLeg = piece("lUpperLeg")
local lTibia = piece("lTibia")
local lLowerLeg = piece("lLowerLeg")
local lFootJoint = piece("lFootJoint")
local lFoot = piece("lFoot")

local rLegConnector = piece("rLegConnector")
local rUpperLeg = piece("rUpperLeg")
local rTibia = piece("rTibia")
local rLowerLeg = piece("rLowerLeg")
local rLegFrontFoot = piece("rLegFrontFoot")
local rFoot = piece("rFoot")

local torsoConnector = piece("torsoConnector")
local torso = piece("torso")
local throat = piece("throat")
local head = piece("head")

local flakHeadingPivot = piece("flakHeadingPivot")
local flakPitchPivot = piece("flakPitchPivot")
local flakHousing = piece("flakHousing")
local flakBarrel = piece("flakBarrel")

local lToroid = piece("lToroid")
local Plane = piece("Plane")

local lUpperArm = piece("lUpperArm")
local lHeatrayStrut = piece("lHeatrayStrut")
local lHeatrayHeadingPivot = piece("lHeatrayHeadingPivot")
local lHeatrayPitchPivot = piece("lHeatrayPitchPivot")
local lHeatrayHousing = piece("lHeatrayHousing")
local lLowerArm = piece("lLowerArm")
local lArmGun = piece("lArmGun")
local lCannon = piece("lCannon")
local lFiringPin = piece("lFiringPin")

local rArmConnector = piece("rArmConnector")
local rUpperArm = piece("rUpperArm")
local rHeatrayStrut = piece("rHeatrayStrut")
local rHeatrayHeadingPivot = piece("rHeatrayHeadingPivot")
local rHeatrayPitchPivot = piece("rHeatrayPitchPivot")
local rHeatrayHousing = piece("rHeatrayHousing")
local rLowerArm = piece("rLowerArm")
local rArmGun = piece("rArmGun")
local rCannon = piece("rCannon")
local rFiringPin = piece("rFiringPin")

local rToroid = piece("rToroid")
local rRiotFlare = piece("rRiotFlare")
local lRiotFlare = piece("lRiotFlare")
local rHeatrayFlare = piece("rHeatrayFlare")
local lHeatrayFlare = piece("lHeatrayFlare")
local flakFlare1 = piece("flakFlare1")
local flakFlare2 = piece("flakFlare2")
local rFootDust = piece("rFootDust")
local lFootDust = piece("lFootDust")
local lToroidFlare = piece("lToroidFlare")
local rToroidFlare = piece("rToroidFlare")
local torsoCalcFlare = piece("torsoCalcFlare")
local hipCalcFlare = piece("hipCalcFlare")



--------------------------------------------------------------------------------
-- SIGNALS
-------------------------------------------------------------------------------
local SIG_MOVE = 1

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local animSpeed = 0.4
local isMoving = false
local whichAAbarrel = 1
local whichRiotBarrel = 1
local aimSpeed = 1.3   -- higher = slower aiming
--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
   local function SetIdlePose()
    local speed = 2  -- smooth return

    -- torso back to forward
    Turn(torso, y_axis, 0, speed)
    Turn(torso, x_axis, 0, speed)

    -- arms back to relaxed pose
    Turn(lUpperArm, x_axis, math.rad(-12), speed)
    Turn(rUpperArm, x_axis, math.rad(-12), speed)

    Turn(lArmGun, x_axis, 0, speed)
    Turn(rArmGun, x_axis, 0, speed)

    -- optional: remove twist drift
    Turn(lUpperArm, z_axis, 0, speed)
    Turn(rUpperArm, z_axis, 0, speed)
end





-- local function ResetLegs()
    -- Turn(lLegConnector, x_axis, 0, 6)
    -- Turn(lUpperLeg, x_axis, 0, 6)
    -- Turn(lTibia, x_axis, 0, 6)
    -- Turn(lLowerLeg, x_axis, 0, 6)
    -- Turn(lFootJoint, x_axis, 0, 6)

    -- Turn(rLegConnector, x_axis, 0, 6)
    -- Turn(rUpperLeg, x_axis, 0, 6)
    -- Turn(rTibia, x_axis, 0, 6)
    -- Turn(rLowerLeg, x_axis, 0, 6)
    -- Turn(rLegFrontFoot, x_axis, 0, 6)

    -- Turn(hip, y_axis, 0, 6)
    -- Move(hip, y_axis, 5.8, 6)
-- end


--------------------------------------------------------------------------------
-- WALK CYCLE
--------------------------------------------------------------------------------
local function Walk()
    SetSignalMask(SIG_MOVE)

    while true do
        -- Frame 1
        Move(hip, y_axis, 4.688925, 8.459054 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-37.797406), 32.715547 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(26.925861), 25.337611 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-25.099957), 8.810585 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(-9.707522), 32.396356 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(16.930374), 53.469726 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-24.981229), 18.760395 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-1.325078), 4.890551 / animSpeed)
        Turn(torso, x_axis, math.rad(4.248822), 3.285009 / animSpeed)

        Turn(rLegConnector, y_axis, 0, 806.536634 / animSpeed)
        Turn(lLegConnector, y_axis, 0, 806.536634 / animSpeed)
       Sleep(math.floor(33 / animSpeed))
	  
        

        -- Frame 6
        Move(hip, y_axis, 5.279083, 42.295264 / animSpeed)
        Turn(hip, y_axis, math.rad(3.080873), 7.646664 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-43.249994), 163.577635 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(-4.118610), 7.726673 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(31.148798), 126.688107 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-23.631527), 44.052876 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-1.945096), 6.112208 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-1.107308), 3.451133 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(-4.308129), 161.981778 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(8.018756), 267.348554 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(18.677617), 13.149924 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-21.854497), 93.801976 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-0.509986), 24.452753 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(0.292369), 13.915864 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.129309), 6.008976 / animSpeed)
        Turn(torso, x_axis, math.rad(3.701322), 16.425021 / animSpeed)

        Sleep(math.floor(33 / animSpeed))
		
        

        -- Frame 12
        Move(hip, y_axis, 6.800201, 62.378540 / animSpeed)
        Turn(hip, y_axis, math.rad(1.592232), 44.659240 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-30.306383), 388.308344 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(-0.295633), 3.670922 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(-1.927137), 65.744165 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(16.674531), 434.228013 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(1.979125), 1068.973166 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-0.054675), 41.165468 / animSpeed)
        Turn(lLowerLeg, y_axis, math.rad(0.029726), 30.713346 / animSpeed)
        Turn(lTibia, x_axis, math.rad(12.592696), 1086.726699 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-0.946217), 29.966386 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-0.541272), 16.981097 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.237741), 7.224628 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(1.890573), 185.961057 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-3.764703), 353.503745 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(-1.280367), 37.832212 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(23.515499), 145.136483 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(0.757756), 5.441967 / animSpeed)
        Turn(rLowerLeg, y_axis, math.rad(-0.504577), 4.072660 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-22.104657), 7.504824 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(0.468330), 29.349506 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(-0.269852), 16.866631 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(0.121204), 7.515398 / animSpeed)
        Turn(torso, x_axis, math.rad(2.362247), 40.172231 / animSpeed)

       
        Sleep(math.floor(33 / animSpeed))
		
        

        -- Frame 18
        Move(hip, y_axis, 6.380150, 12.601547 / animSpeed)
        Turn(hip, y_axis, math.rad(-0.508313), 63.016344 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-7.883646), 672.682100 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(0.439500), 70.999117 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(3.966229), 381.249049 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(-25.553008), 825.963987 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(0.659225), 21.416999 / animSpeed)
        Turn(lLowerLeg, y_axis, math.rad(-0.228324), 7.741499 / animSpeed)
        Turn(lTibia, x_axis, math.rad(30.260682), 530.039576 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-0.793751), 4.573983 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(8.466917), 197.290317 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-14.843519), 332.364497 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(-0.244806), 4.633551 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(0.816165), 62.895949 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(26.568756), 91.597703 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(0.882529), 3.743207 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-20.679023), 42.769039 / animSpeed)
        Turn(torso, x_axis, math.rad(1.028757), 40.004708 / animSpeed)

        Sleep(math.floor(33 / animSpeed))
       

        -- Frame 24
        Move(hip, y_axis, 5.956055, 70.086136 / animSpeed)
        Turn(hip, y_axis, math.rad(-2.413444), 57.153941 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(26.103105), 1019.602520 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(-0.461161), 6.497678 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(2.286470), 55.409109 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(-12.164504), 483.921981 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(-25.019335), 16.010202 / animSpeed)
        Turn(lTibia, x_axis, math.rad(13.361185), 506.984895 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-2.285488), 44.752105 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-1.299028), 25.338757 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.558281), 10.746267 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(16.384898), 237.539440 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-25.857421), 330.417061 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(0.089743), 10.036491 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(3.009925), 65.812807 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(29.026774), 73.740532 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(0.989858), 3.219853 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-19.030502), 49.455624 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-0.552429), 30.923294 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(0.316632), 17.768205 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.139947), 7.913420 / animSpeed)
        Turn(torso, x_axis, 0, 30.862713 / animSpeed)

        Sleep(math.floor(33 / animSpeed))
		
        

        -- Frame 30
        Move(hip, y_axis, 4.964905, 30.265503 / animSpeed)
        Turn(hip, y_axis, math.rad(-3.391529), 29.342544 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(18.705636), 221.924065 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(0.276697), 22.135728 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(2.483926), 5.923676 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(-10.782554), 41.458488 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(19.217475), 1327.104287 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-0.595724), 37.234297 / animSpeed)
        Turn(lLowerLeg, y_axis, math.rad(0.382961), 18.282705 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-25.615916), 1169.313035 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-1.490287), 23.856025 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-0.850239), 13.463683 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.370193), 5.642650 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(26.084050), 290.974562 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-36.705180), 325.432781 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(0.411076), 9.639974 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(4.433713), 42.713632 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(37.665707), 259.167976 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(1.429988), 13.203901 / animSpeed)
        Turn(rLowerLeg, y_axis, math.rad(-1.056205), 11.056489 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-25.405879), 191.261314 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-1.703772), 34.540281 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(0.971044), 19.632344 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.421341), 8.441841 / animSpeed)
        Turn(torso, x_axis, math.rad(4.358323), 130.749684 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
		
        

        -- Frame 36
        Move(hip, y_axis, 5.245750, 51.574631 / animSpeed)
        Turn(hip, y_axis, math.rad(-3.067964), 9.706952 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(8.002936), 321.080994 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(-4.304863), 194.330737 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(18.757368), 13.803215 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-21.927436), 110.654392 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-0.504400), 29.576593 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-0.289174), 16.831953 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.127914), 7.268364 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(31.148091), 151.921217 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-43.242979), 196.133971 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(4.102731), 9.929460 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-23.713807), 50.762154 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-1.931313), 6.826234 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(1.099539), 3.854865 / animSpeed)
        Turn(torso, x_axis, math.rad(3.701322), 19.710031 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
		
        

        -- Frame 42
        Move(hip, y_axis, 6.814598, 61.810455 / animSpeed)
        Turn(hip, y_axis, math.rad(-1.566566), 45.041943 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-3.762319), 352.957658 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(1.254132), 38.218744 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(1.888466), 185.799873 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(23.548165), 143.723914 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-0.759045), 5.395152 / animSpeed)
        Turn(lLowerLeg, y_axis, math.rad(0.505567), 4.040126 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-22.138907), 6.344136 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(0.469436), 29.215077 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(0.270493), 16.790007 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(-0.121498), 7.482362 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(16.665848), 434.467292 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-30.302069), 388.227304 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(0.289826), 3.711621 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(1.895572), 66.214750 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(2.005681), 1070.051360 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(0.055416), 41.251669 / animSpeed)
        Turn(rLowerLeg, y_axis, math.rad(-0.030138), 30.794517 / animSpeed)
        Turn(rTibia, x_axis, math.rad(12.552903), 1086.726699 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-0.928432), 30.086422 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(0.531150), 17.051669 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.233361), 7.258639 / animSpeed)
        Turn(torso, x_axis, math.rad(2.362247), 40.172238 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
	
        

        -- Frame 48
        Move(hip, y_axis, 6.355614, 13.769531 / animSpeed)
        Turn(hip, y_axis, math.rad(0.536879), 63.103336 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-14.829702), 332.021472 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(0.240585), 4.707151 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(-0.845928), 63818 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(8.459725), 197.137752 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(26.509743), 88.847357 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-0.880032), 3.629606 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-20.619035), 45.596174 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(3.983481), 380.471009 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(-7.923383), 671.360587 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(-0.467647), 70.896595 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(-25.597951), 828.108959 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(-0.660390), 21.474175 / animSpeed)
        Turn(rLowerLeg, y_axis, math.rad(0.228475), 7.758390 / animSpeed)
        Turn(rTibia, x_axis, math.rad(30.328854), 533.278520 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-0.794633), 4.013987 / animSpeed)
        Turn(torso, x_axis, math.rad(1.028757), 40.004705 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
		
    

        -- Frame 54
        Move(hip, y_axis, 5.985451, 70.231934 / animSpeed)
        Turn(hip, y_axis, math.rad(2.433928), 56.911474 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-25.854117), 330.732462 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(-0.093879), 10.033924 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(-3.032773), 65.605353 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(16.381013), 237.638665 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(28.963947), 73.626092 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-0.987029), 3.209939 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-18.955486), 49.906468 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-0.564230), 31.045837 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-0.323379), 17.836615 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.142909), 7.941384 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(-12.147817), 483.938924 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(26.093303), 1020.500596 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(0.462229), 6.629397 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(-2.303641), 55.079811 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(-25.081466), 15.494557 / animSpeed)
        Turn(rTibia, x_axis, math.rad(13.432030), 506.904726 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-2.301038), 45.192164 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(1.307769), 25.585951 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.561892), 10.847865 / animSpeed)
        Turn(torso, x_axis, 0, 30.862710 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
		
       

        -- Frame 60
        Move(hip, y_axis, 4.958351, 29.187012 / animSpeed)
        Turn(hip, y_axis, math.rad(3.396077), 28.864480 / animSpeed)
        Turn(lFootJoint, x_axis, math.rad(-36.703429), 325.479346 / animSpeed)
        Turn(lFootJoint, z_axis, math.rad(-0.412233), 9.550624 / animSpeed)
        Turn(lFootJoint, y_axis, math.rad(-4.439448), 42.200228 / animSpeed)
        Turn(lLegConnector, x_axis, math.rad(26.086859), 291.175370 / animSpeed)
        Turn(lLowerLeg, x_axis, math.rad(37.677540), 261.407800 / animSpeed)
        Turn(lLowerLeg, z_axis, math.rad(-1.430673), 13.309315 / animSpeed)
        Turn(lLowerLeg, y_axis, math.rad(1.056796), 11.142759 / animSpeed)
        Turn(lTibia, x_axis, math.rad(-25.419437), 193.918530 / animSpeed)
        Turn(lUpperLeg, x_axis, math.rad(-1.706727), 34.274894 / animSpeed)
        Turn(lUpperLeg, z_axis, math.rad(-0.972713), 19.480021 / animSpeed)
        Turn(lUpperLeg, y_axis, math.rad(0.422030), 8.373608 / animSpeed)
        Turn(rLegConnector, x_axis, math.rad(-10.777740), 41.102311 / animSpeed)
        Turn(rLegFrontFoot, x_axis, math.rad(18.698213), 221.852706 / animSpeed)
        Turn(rLegFrontFoot, z_axis, math.rad(-0.277173), 22.182053 / animSpeed)
        Turn(rLegFrontFoot, y_axis, math.rad(-2.487492), 5.515536 / animSpeed)
        Turn(rLowerLeg, x_axis, math.rad(19.232696), 1329.424844 / animSpeed)
        Turn(rLowerLeg, z_axis, math.rad(0.596274), 37.298919 / animSpeed)
        Turn(rLowerLeg, y_axis, math.rad(-0.383365), 18.301524 / animSpeed)
        Turn(rTibia, x_axis, math.rad(-25.626458), 1171.754640 / animSpeed)
        Turn(rUpperLeg, x_axis, math.rad(-1.492268), 24.263095 / animSpeed)
        Turn(rUpperLeg, z_axis, math.rad(0.851365), 13.692122 / animSpeed)
        Turn(rUpperLeg, y_axis, math.rad(-0.370673), 5.736570 / animSpeed)
        Turn(torso, x_axis, math.rad(4.358323), 130.749697 / animSpeed)
        Sleep(math.floor(33 / animSpeed))
		
		

    end

end


--------------------------------------------------------------------------------
-- MOVEMENT
--------------------------------------------------------------------------------
function script.StartMoving()
    Signal(SIG_MOVE)   -- 🔥 kill ANY existing walk thread FIRST

    isMoving = true
    StartThread(Walk)
end

function script.StopMoving()
    isMoving = false
    Signal(SIG_MOVE)
    StopWalk()
end


local function StopWalk()
    local speed = 6

    -- small delay ensures Walk thread is dead
    Sleep(50)

    -- LEGS
    Turn(lLegConnector, x_axis, 0, speed)
    Turn(lUpperLeg,     x_axis, 0, speed)
    Turn(lTibia,        x_axis, 0, speed)

    Turn(rLegConnector, x_axis, 0, speed)
    Turn(rUpperLeg,     x_axis, 0, speed)
    Turn(rTibia,        x_axis, 0, speed)

    -- FEET
    Turn(lFootJoint, x_axis, 0, speed)
    Turn(rLegFrontFoot, x_axis, 0, speed)

    -- HIP
    Move(hip, y_axis, 0, speed)
    Turn(hip, y_axis, 0, speed)
    Turn(hip, x_axis, 0, speed)

    -- TORSO
    Turn(torso, x_axis, 0, speed)
    Turn(torso, y_axis, 0, speed)

    -- OPTIONAL: wait so it actually settles
    WaitForTurn(lLegConnector, x_axis)
    WaitForTurn(rLegConnector, x_axis)
end

-- function script.StopMoving()
    -- Signal(SIG_MOVE)
    -- isMoving = false
    -- ResetLegs()
    -- SetIdlePose()
-- end

--------------------------------------------------------------------------------
-- CREATE (HIDE HEATRAY HERE)
--------------------------------------------------------------------------------
function script.Create()
    -- Hide all heatray visuals
    Hide(lHeatrayHeadingPivot)
    Hide(lHeatrayPitchPivot)
    Hide(lHeatrayHousing)
    Hide(lHeatrayFlare)

    Hide(rHeatrayHeadingPivot)
    Hide(rHeatrayPitchPivot)
    Hide(rHeatrayHousing)
    Hide(rHeatrayFlare)
	
	--hide flak turret, not using
	
	Hide(flakHeadingPivot)
    Hide(flakPitchPivot)
    Hide(flakHousing)
    Hide(flakBarrel)


    SetIdlePose()
end

--------------------------------------------------------------------------------
-- AIMING
--------------------------------------------------------------------------------
function script.AimFromWeapon(num)
    if num == 1 then return torso end
    if num == 2 then return torso end -- disabled
    if num == 3 then return torso end -- disabled
    if num == 4 then return flakPitchPivot end
    return torso
end

function script.QueryWeapon(num)
    if num == 1 then
        return (whichRiotBarrel == 1) and lRiotFlare or rRiotFlare
    elseif num == 2 then
        return lHeatrayFlare
    elseif num == 3 then
        return rHeatrayFlare
    elseif num == 4 then
        return (whichAAbarrel == 1) and flakFlare1 or flakFlare2
    end
end


--------------------------------------------------------------------------------
-- AIMING (WAITFORTURN FIXED)
--------------------------------------------------------------------------------
function script.AimWeapon(num, heading, pitch)

    -- RIOT (torso weapon)
 if num == 1 then
Turn(torso, y_axis, heading, 6 / aimSpeed)

Turn(lUpperArm, x_axis, -pitch, 8 / aimSpeed)
Turn(rUpperArm, x_axis, -pitch, 8 / aimSpeed)

Turn(lArmGun, x_axis, -pitch * 0.5, 10 / aimSpeed)
Turn(rArmGun, x_axis, -pitch * 0.5, 10 / aimSpeed)

    WaitForTurn(torso, y_axis)
    WaitForTurn(lUpperArm, x_axis)
    WaitForTurn(rUpperArm, x_axis)

    return true
end

    -- HEATRAY LEFT (disabled)
    if num == 2 then
        return true
    end

    -- HEATRAY RIGHT (disabled)
    if num == 3 then
        return true
    end

  -- Flak (disabled)
    if num == 4 then
        return true
    end

    return false
end

--------------------------------------------------------------------------------
-- RIOT RECOIL
--------------------------------------------------------------------------------
local RIOT_RECOIL_DEPTH = 300    -- how far pin goes in
local RIOT_RECOIL_SPEED = 25     -- how fast it snaps in
local RIOT_RETURN_SPEED = 8       -- how fast it returns

local function RiotRecoil(pin)
    -- push back
    Move(pin, z_axis, RIOT_RECOIL_DEPTH, RIOT_RECOIL_SPEED)

    Sleep(200)

    -- return forward
    Move(pin, z_axis, 0, RIOT_RETURN_SPEED)
end


--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon(num)
    if num == 1 then

        if whichRiotBarrel == 1 then
            EmitSfx(rRiotFlare, 1024)
            StartThread(RiotRecoil, rFiringPin)
        else
            EmitSfx(lRiotFlare, 1024)
            StartThread(RiotRecoil, lFiringPin)
        end

        whichRiotBarrel = 3 - whichRiotBarrel
    end

    return true
end

--------------------------------------------------------------------------------
-- KILLED (UNCHANGED LOGIC)
--------------------------------------------------------------------------------
function script.Killed(recentDamage, maxHealth)
    local severity = recentDamage / maxHealth
    Explode(hip, SFX.FIRE + SFX.SMOKE + SFX.FALL)
    Explode(torso, SFX.FIRE + SFX.SMOKE + SFX.FALL)
    Explode(head, SFX.FIRE + SFX.SMOKE + SFX.FALL)
    return 3
end