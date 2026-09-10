return { siegeriot1 = {
  name                  = [[Morpheus]],
  description           = [[Sonic Riot Bot]],
  acceleration          = 1.3,
  brakeRate             = 5.2,
  builder               = false,
  buildPic              = [[siegeriot.png]],
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  category              = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[45 45 45]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                = [[DEAD]],

  customParams          = {
    aim_lookahead      = 80,
	bait_level_default = 0,
    set_target_range_buffer = 30,
    set_target_speed_buffer = 8,
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs             = [[BIG_UNITEX]],
  footprintX            = 3,
  footprintZ            = 3,
  health                = 880,
  iconType              = "siegeriot",
  leaveTracks           = true,
  maxSlope              = 36,
  maxWaterDepth         = 22,
  metalCost             = 240,
  movementClass         = [[KBOT3]],
  noAutoFire            = false,
  noChaseCategory       = [[FIXEDWING GUNSHIP SUB]],
  objectName            = [[siegeriot.s3o]],
  script                = [[siegeriot.lua]],
  selfDestructAs        = [[BIG_UNITEX]],
  selfDestructCountdown = 5,

  sfxtypes              = {

    explosiongenerators = {
      [[custom:sonicfire_80]],
      [[custom:emg_shells_l]],
    },

  },

  sightDistance         = 560,
  speed                 = 62.5,
  trackOffset           = 0,
  trackStrength         = 8,
  trackStretch          = 1,
  trackType             = [[ComTrack]],
  trackWidth            = 22,
  turnRate              = 1300,
  upright               = true,
  workerTime            = 0,

  weapons               = {

    {
      def                = [[SONIC]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
      mainDir            = [[0 -1 0]],
      maxAngleDif        = 250,
    },

  },

  weaponDefs            = {

     SONIC         = {
        name                    = [[Sonic Blaster]],
        areaOfEffect            = 170,
        avoidFeature            = true,
        avoidFriendly           = true,
        burnblow                = true,
        craterBoost             = 0,
        craterMult              = 0,

        customParams            = {
            force_ignore_ground = [[1]],
            slot = [[5]],
            muzzleEffectFire = [[custom:HEAVY_CANNON_MUZZLE]],
            miscEffectFire   = [[custom:RIOT_SHELL_L]],
            lups_explodelife = 1.5,
            lups_explodespeed = 0.8,
            light_radius = 240,
        },

        damage                  = {
            default = 300.01,
        },
        
        cegTag                  = [[sonictrail]],
        cylinderTargeting       = 5.0,
        explosionGenerator      = [[custom:sonic_80]],
        edgeEffectiveness       = 0.5,
        fireStarter             = 150,
        impulseBoost            = 300,
        impulseFactor           = 0.5,
        interceptedByShieldType = 1,
        myGravity               = 0.01,
        noSelfDamage            = true,
        range                   = 300,
        reloadtime              = 2,
        size                    = 55,
        sizeDecay               = 0.2,
        soundStart              = [[SonicLow]],
        soundHit                = [[SonicHitLow]],
        soundStartVolume        = 5,
        soundHitVolume          = 9,
        stages                  = 1,
        texture1                = [[sonic_glow2]],
        texture2                = [[null]],
        texture3                = [[null]],
        rgbColor                = {0.2, 0.6, 0.8},
        turret                  = true,
        weaponType              = [[Cannon]],
        weaponVelocity          = 700,
        waterweapon             = true,
        duration                = 0.15,
    },

  },

  featureDefs           = {

    DEAD  = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[siegeriot_dead.s3o]],
    },

    
    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
