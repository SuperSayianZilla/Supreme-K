include "constants.lua"

--------------------------------------------------------------------------------
-- PIECES
--------------------------------------------------------------------------------
local barrel = piece("barrel")
local turretOpener = piece("turretOpener")
local turretPitchPivot = piece("turretPitchPivot")
local chassis = piece("chassis")
local chassisHeadingPivot = piece("chassisHeadingPivot")
local hip = piece("hip")

local rightUpperLeg = piece("rightUpperLeg")
local rightLowerLeg = piece("rightLowerLeg")
local rightFootPivot = piece("rightFootPivot")

local leftUpperLeg = piece("leftUpperLeg")
local leftLowerLeg = piece("leftLowerLeg")
local leftFootPivot = piece("leftFootPivot")

local barrelSpinPivot = piece("barrelSpinPivot")

local barrelFlare1 = piece("barrelFlare1")
local barrelFlare2 = piece("barrelFlare2")
local barrelFlare3 = piece("barrelFlare3")

--------------------------------------------------------------------------------
-- SIGNALS
--------------------------------------------------------------------------------
local SIG_MOVE = 1
local SIG_AIM = 2

--------------------------------------------------------------------------------
-- STATE
--------------------------------------------------------------------------------
local isMoving = false
local animSpeed = 3
local restoreDelay = 3000
local whichBarrel = 0
local isOpen = false
local stunned = false

--------------------------------------------------------------------------------
-- HELPERS
--------------------------------------------------------------------------------
local function RestorePose()
    Turn(chassis, y_axis, 0, math.rad(90))
    Turn(turretPitchPivot, x_axis, 0, math.rad(90))
    Turn(turretOpener, x_axis, 0, math.rad(40))
    isOpen = false
end

--------------------------------------------------------------------------------
-- WALK
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- FULL FIDELITY WALK (1:1 BOS)
--------------------------------------------------------------------------------
local function Walk()
    Signal(SIG_MOVE)
    SetSignalMask(SIG_MOVE)

    if isMoving then
        -- Frame 1
        Turn(chassisHeadingPivot, x_axis, math.rad(1.671347), math.rad(16.999333) / animSpeed)
        Turn(leftFootPivot, x_axis, math.rad(-35.927557), math.rad(53.528944) / animSpeed)
        Turn(leftLowerLeg, x_axis, math.rad(3.467934), math.rad(118.552033) / animSpeed)
        Turn(leftUpperLeg, x_axis, math.rad(32.446394), math.rad(64.929383) / animSpeed)
        Turn(rightFootPivot, x_axis, math.rad(13.813381), math.rad(39.850337) / animSpeed)
        Turn(rightLowerLeg, x_axis, math.rad(-0.093231), math.rad(11.266133) / animSpeed)
        Turn(rightUpperLeg, x_axis, math.rad(-13.635576), math.rad(50.796322) / animSpeed)

        Sleep((33 * animSpeed) - 1)
    end

    while isMoving do

        -- Frame 6
        Turn(chassisHeadingPivot, x_axis, math.rad(4.504570), math.rad(84.996670) / animSpeed)
        Move(hip, y_axis, -0.332689, 3.048992 / animSpeed)
        Turn(hip, y_axis, math.rad(-5.603034), math.rad(9.918241) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-27.006057), math.rad(267.644975) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(5.947424), math.rad(13.251954) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(0.916926), math.rad(14.766617) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(-16.290737), math.rad(592.760140) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-1.413935), math.rad(10.763045) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.343312), math.rad(8.183392) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(43.267961), math.rad(324.647019) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.698704), math.rad(5.136071) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.698698), math.rad(5.136247) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(7.171658), math.rad(199.251687) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(5.589916), math.rad(11.712319) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(-0.049612), math.rad(7.516212) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(-1.970920), math.rad(56.330663) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.323386), math.rad(9.635345) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.342096), math.rad(14.792550) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(-5.169524), math.rad(253.981570) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.338476), math.rad(14.140290) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.338469), math.rad(14.140565) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 12
        Turn(chassisHeadingPivot, x_axis, math.rad(5.587182), math.rad(32.478369) / animSpeed)
        Move(hip, y_axis, 0.258781, 17.744122 / animSpeed)
        Turn(hip, y_axis, math.rad(-3.810930), math.rad(53.763138) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-7.170556), math.rad(595.065034) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(3.970949), math.rad(59.294247) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(-0.246281), math.rad(34.896217) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(-31.283158), math.rad(449.772618) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.721831), math.rad(20.763129) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.087514), math.rad(7.673954) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(38.423571), math.rad(145.331706) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.262360), math.rad(13.090330) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.262380), math.rad(13.089537) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-5.790243), math.rad(388.857030) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(3.812945), math.rad(53.309131) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(0.159797), math.rad(6.282291) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(3.215753), math.rad(155.600189) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(-0.109126), math.rad(12.975366) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(0.110359), math.rad(13.573641) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(2.572510), math.rad(232.261012) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(0.110371), math.rad(13.465407) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(0.110365), math.rad(13.465012) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 18
        Turn(chassisHeadingPivot, x_axis, math.rad(2.827506), math.rad(82.790281) / animSpeed)
        Move(hip, y_axis, 0.485043, 6.787834 / animSpeed)
        Turn(hip, y_axis, math.rad(-0.526374), math.rad(98.536659) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(15.173405), math.rad(670.318846) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(0.540038), math.rad(102.927321) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(-0.127548), math.rad(3.561985) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(-32.066058), math.rad(23.487006) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(0.012995), math.rad(22.044788) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(16.892137), math.rad(645.943011) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(-0.006447), math.rad(8.064202) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(-0.006444), math.rad(8.064705) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-19.258996), math.rad(404.062568) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(0.526492), math.rad(98.593583) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(9.335252), math.rad(183.584958) / animSpeed)
        Turn(rightUpperLeg, x_axis, math.rad(9.923586), math.rad(220.532288) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 24
        Turn(chassisHeadingPivot, x_axis, math.rad(0.116353), math.rad(81.334586) / animSpeed)
        Move(hip, y_axis, 0.026783, 13.747787 / animSpeed)
        Turn(hip, y_axis, math.rad(2.964753), math.rad(104.733830) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(23.450367), math.rad(248.308846) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(-2.957642), math.rad(104.930418) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(0.496700), math.rad(18.727445) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(-19.141844), math.rad(387.726412) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.475216), math.rad(14.646358) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.353700), math.rad(10.731091) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(-4.299707), math.rad(635.755306) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.392665), math.rad(11.973377) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.392673), math.rad(11.973506) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-31.785713), math.rad(375.801516) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(-2.996403), math.rad(105.686848) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(-0.674409), math.rad(22.218065) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(13.496275), math.rad(124.830714) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.416563), math.rad(13.987891) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.395329), math.rad(13.349620) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(18.284567), math.rad(250.829417) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.460572), math.rad(15.401821) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.460582), math.rad(15.401789) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 30
        Turn(chassisHeadingPivot, x_axis, math.rad(1.283332), math.rad(35.009364) / animSpeed)
        Move(hip, y_axis, -0.469275, 14.881754 / animSpeed)
        Turn(hip, y_axis, math.rad(5.293834), math.rad(69.872413) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(15.588121), math.rad(235.867384) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(-5.201550), math.rad(67.317226) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(-0.276474), math.rad(23.195209) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(0.431734), math.rad(587.207335) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.741124), math.rad(7.977229) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.989432), math.rad(19.071970) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(-15.916783), math.rad(348.512281) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.958013), math.rad(16.960417) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.958021), math.rad(16.960417) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-38.180542), math.rad(191.844885) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(-5.506506), math.rad(75.303105) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(-1.567803), math.rad(26.801822) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(8.684432), math.rad(144.355305) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.977638), math.rad(16.832243) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.696004), math.rad(9.020257) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(29.486545), math.rad(336.059343) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.929215), math.rad(14.059288) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.929218), math.rad(14.059073) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 36
        Turn(chassisHeadingPivot, x_axis, math.rad(4.679587), math.rad(101.887663) / animSpeed)
        Move(hip, y_axis, -0.303064, 4.986334 / animSpeed)
        Turn(hip, y_axis, math.rad(5.553842), math.rad(7.800234) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(7.418384), math.rad(245.092109) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(-5.538553), math.rad(10.110110) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(0.023643), math.rad(9.003504) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(-1.604489), math.rad(61.086689) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.341572), math.rad(11.986562) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.367576), math.rad(18.655700) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(-5.779341), math.rad(304.123244) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.362180), math.rad(17.874985) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.362193), math.rad(17.874841) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-27.699361), math.rad(314.435442) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(-5.883381), math.rad(11.306234) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(-0.949506), math.rad(18.548923) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(-14.967045), math.rad(709.544298) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(1.385769), math.rad(12.243934) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.364675), math.rad(9.939887) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(42.639037), math.rad(394.574769) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.712099), math.rad(6.513489) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.712096), math.rad(6.513660) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 42
        Turn(chassisHeadingPivot, x_axis, math.rad(5.511916), math.rad(24.969870) / animSpeed)
        Move(hip, y_axis, 0.290848, 17.817364 / animSpeed)
        Turn(hip, y_axis, math.rad(3.644060), math.rad(57.293445) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-5.548727), math.rad(389.013335) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(-3.646863), math.rad(56.750701) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(-0.162561), math.rad(5.586128) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(3.469186), math.rad(152.210268) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(0.091669), math.rad(12.997240) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(-0.093895), math.rad(13.844105) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(2.078793), math.rad(235.744024) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(-0.093430), math.rad(13.668289) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(-0.093434), math.rad(13.668796) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(-8.123357), math.rad(587.280130) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(-3.797384), math.rad(62.579896) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(0.202287), math.rad(34.553774) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(-30.510028), math.rad(466.289501) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.709697), math.rad(20.282170) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.090997), math.rad(8.210345) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(38.606200), math.rad(120.985122) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.262525), math.rad(13.487217) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.262528), math.rad(13.487050) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 48
        Turn(chassisHeadingPivot, x_axis, math.rad(2.607913), math.rad(87.120098) / animSpeed)
        Move(hip, y_axis, 0.474300, 5.503578 / animSpeed)
        Turn(hip, y_axis, math.rad(0.306917), math.rad(100.114302) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-18.821976), math.rad(398.197463) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(-0.307098), math.rad(100.192956) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(-0.037978), math.rad(3.737485) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(9.045703), math.rad(167.295495) / animSpeed)
        Turn(leftUpperLeg, x_axis, math.rad(9.776223), math.rad(230.922901) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(14.716505), math.rad(685.195843) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(-0.315350), math.rad(104.461019) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(0.075010), math.rad(3.818300) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(-32.562486), math.rad(61.573746) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(-0.004862), math.rad(21.436777) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(17.845797), math.rad(622.812080) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(0.002356), math.rad(7.946438) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(0.002352), math.rad(7.946377) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 54
        Turn(chassisHeadingPivot, x_axis, math.rad(0.062441), math.rad(76.364170) / animSpeed)
        Move(hip, y_axis, -0.011610, 14.577312 / animSpeed)
        Turn(hip, y_axis, math.rad(-3.150680), math.rad(103.727894) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-31.202753), math.rad(371.423296) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(3.182969), math.rad(104.702006) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(0.698952), math.rad(22.107927) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(12.784128), math.rad(112.152765) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.442430), math.rad(14.123523) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.413048), math.rad(13.238806) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(18.413014), math.rad(259.103713) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.481812), math.rad(15.353689) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.481814), math.rad(15.354012) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(24.015597), math.rad(278.972776) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(3.152234), math.rad(104.027515) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(-0.580962), math.rad(19.679168) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(-20.472230), math.rad(362.707685) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.505766), math.rad(15.318839) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-0.360238), math.rad(10.849715) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(-3.535434), math.rad(641.436943) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-0.405044), math.rad(12.222024) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-0.405056), math.rad(12.222229) / animSpeed)

        Sleep((33 * animSpeed) - 1)

        -- Frame 60
        Turn(chassisHeadingPivot, x_axis, math.rad(1.471281), math.rad(42.265215) / animSpeed)
        Move(hip, y_axis, -0.481134, 14.085732 / animSpeed)
        Turn(hip, y_axis, math.rad(-5.373559), math.rad(66.686366) / animSpeed)

        Turn(leftFootPivot, x_axis, math.rad(-38.659946), math.rad(223.715811) / animSpeed)
        Turn(leftFootPivot, y_axis, math.rad(5.587888), math.rad(72.147589) / animSpeed)
        Turn(leftFootPivot, z_axis, math.rad(1.627799), math.rad(27.865393) / animSpeed)

        Turn(leftLowerLeg, x_axis, math.rad(9.984612), math.rad(83.985483) / animSpeed)
        Turn(leftLowerLeg, y_axis, math.rad(-0.969108), math.rad(15.800348) / animSpeed)
        Turn(leftLowerLeg, z_axis, math.rad(0.720731), math.rad(9.230482) / animSpeed)

        Turn(leftUpperLeg, x_axis, math.rad(28.666420), math.rad(307.602197) / animSpeed)
        Turn(leftUpperLeg, y_axis, math.rad(0.953408), math.rad(14.147896) / animSpeed)
        Turn(leftUpperLeg, z_axis, math.rad(0.953404), math.rad(14.147714) / animSpeed)

        Turn(rightFootPivot, x_axis, math.rad(16.286837), math.rad(231.862810) / animSpeed)
        Turn(rightFootPivot, y_axis, math.rad(5.272380), math.rad(63.604380) / animSpeed)
        Turn(rightFootPivot, z_axis, math.rad(0.279085), math.rad(25.801425) / animSpeed)

        Turn(rightLowerLeg, x_axis, math.rad(0.180690), math.rad(619.587592) / animSpeed)
        Turn(rightLowerLeg, y_axis, math.rad(0.778901), math.rad(8.194059) / animSpeed)
        Turn(rightLowerLeg, z_axis, math.rad(-1.043663), math.rad(20.502730) / animSpeed)

        Turn(rightUpperLeg, x_axis, math.rad(-16.357579), math.rad(384.664340) / animSpeed)
        Turn(rightUpperLeg, y_axis, math.rad(-1.012906), math.rad(18.235845) / animSpeed)
        Turn(rightUpperLeg, z_axis, math.rad(-1.012912), math.rad(18.235673) / animSpeed)

        Sleep((33 * animSpeed) - 1) 
		end
end

local function StopWalking()
    Turn(leftUpperLeg, x_axis, 0, math.rad(200))
    Turn(rightUpperLeg, x_axis, 0, math.rad(200))
    Turn(leftLowerLeg, x_axis, 0, math.rad(200))
    Turn(rightLowerLeg, x_axis, 0, math.rad(200))
    Turn(leftFootPivot, x_axis, 0, math.rad(200))
    Turn(rightFootPivot, x_axis, 0, math.rad(200))
    Move(hip, y_axis, 0, 10)
end

--------------------------------------------------------------------------------
-- MOVEMENT HOOKS
--------------------------------------------------------------------------------
function script.StartMoving()
    Signal(SIG_MOVE)   -- kill any old walk thread
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
    StartThread(StopWalking)
end

--------------------------------------------------------------------------------
-- OPEN / CLOSE
--------------------------------------------------------------------------------
local function Open()
    Turn(turretOpener, x_axis, math.rad(40), math.rad(40))
    isOpen = true
end

local function Close()
    Turn(turretOpener, x_axis, 0, math.rad(40))
    isOpen = false
end

--------------------------------------------------------------------------------
-- AIM
--------------------------------------------------------------------------------
function script.AimFromWeapon1()
    return barrelSpinPivot
end

function script.QueryWeapon1()
    if whichBarrel == 0 then
        return barrelFlare1
    elseif whichBarrel == 1 then
        return barrelFlare2
    else
        return barrelFlare3
    end
end

function script.AimWeapon1(heading, pitch)
    Signal(SIG_AIM)
    SetSignalMask(SIG_AIM)

    if not isOpen then
        Open()
    end

    Turn(chassis, y_axis, heading, math.rad(225))
    Turn(turretPitchPivot, x_axis, -pitch + math.rad(40), math.rad(225))

    WaitForTurn(chassis, y_axis)

    StartThread(function()
        Sleep(restoreDelay)
        if not stunned then
            RestorePose()
        end
    end)

    return true
end

--------------------------------------------------------------------------------
-- FIRE
--------------------------------------------------------------------------------
function script.FireWeapon1()
    Spin(barrelSpinPivot, y_axis, math.rad(900))
    Sleep(100)
    StopSpin(barrelSpinPivot, y_axis, math.rad(45))

    whichBarrel = (whichBarrel + 1) % 3
end

--------------------------------------------------------------------------------
-- STUN
--------------------------------------------------------------------------------
function script.SetStunned(state)
    stunned = state
    if not stunned then
        StartThread(RestorePose)
    end
end

--------------------------------------------------------------------------------
-- KILLED
--------------------------------------------------------------------------------
function script.Killed(severity)
    if severity <= 25 then
        Explode(barrel, SFX.FALL)
        return 1
    elseif severity <= 50 then
        Explode(barrel, SFX.SMOKE + SFX.FALL)
        return 2
    else
        Explode(barrel, SFX.FIRE + SFX.SMOKE + SFX.EXPLODE)
        return 3
    end
end