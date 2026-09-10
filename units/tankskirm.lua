return { tankskirm = {
  name                = [[Oni]],
  description         = [[Medium Skirm Tank]],
  acceleration        = 0.138,
  brakeRate           = 0.516,
  builder             = false,
  buildPic            = [[tankskirm.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[80 80 80]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    bait_level_default = 0,
    cus_noflashlight  = 1,
    selection_scale   = 0.92,
    aim_lookahead     = 160,
    set_target_range_buffer = 40,
    normaltex = [[unittextures/atlas_normal.dds]],

    outline_x = 110,
    outline_y = 110,
    outline_yoff = 13.5,
  },

  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 4,
  footprintZ          = 4,
  health              = 1450,
  iconType            = [[tankskirmnew]],
  leaveTracks         = true,
  maxSlope            = 18,
  maxWaterDepth       = 22,
  metalCost           = 340,
  movementClass       = [[TANK4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[legaskirmtank.s3o]],
  script              = [[tankskirm.lua]],
  selfDestructAs      = [[BIG_UNITEX]],
  sightDistance       = 540,
  speed               = 59,
  trackOffset         = 8,
  trackStrength       = 10,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 48,
  turninplace         = 0,
  turnRate            = 600,
  workerTime          = 0,

  weapons = {
    {
      def                = [[THUD_WEAPON]],
      accurateLeading    = 3,
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },

  weaponDefs             = {

    THUD_WEAPON = {
      name                    = [[Light Plasma Cannon]],
      areaOfEffect            = 40,
      cegTag                  = [[light_plasma_trail]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams        = {
        light_camera_height = 1800,
        light_color = [[0.80 0.54 0.23]],
        light_radius = 200,
        burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 180,
        planes  = 180,
      },

      explosionGenerator      = [[custom:MARY_SUE]],
	  burstrate               = 0.1+1/3,
	  burst                   = 3,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 500,
	  separation              = 1.2,
      reloadtime              = 6,
      soundHit                = [[explosion/ex_med5]],
      soundStart              = [[weapon/cannon/cannon_fire5]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 270,
    },

  },




  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legaskirmtank_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
