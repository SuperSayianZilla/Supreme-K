return { armorriot = {
  name                   = [[Hera]],
  description            = [[Dual-Minigun Riot Vehicle]],
  acceleration           = 0.37,
  brakeRate              = 0.8,
  builder                = false,
  buildPic               = [[armorriot.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND TOOFAST]],
  collisionVolumeOffsets = [[0 -5 0]],
  collisionVolumeScales  = [[42 42 42]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 0,
    aimposoffset   = [[0 8 0]],
    midposoffset   = [[0 3 0]],
    modelradius    = [[21]],

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 12.5,
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1650,
  iconType               = [[truckriot]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 480,
  movementClass          = [[TANK3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB DRONE]],
  objectName             = [[legvflak.s3o]],
  script                 = [[armorriot.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:RAIDDUST]],
    },

  },
  sightDistance          = 400,
  speed                  = 70,
  trackOffset            = 6,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 580,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[WARRIOR_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    WARRIOR_WEAPON = {
      name                    = [[Heavy Pulse MG]],
      accuracy                = 420,
      alphaDecay              = 0.7,
      areaOfEffect            = 70,
      burnblow                = true,
      cegTag                  = [[hmg_trail_light]],
      craterBoost             = 0.15,
      craterMult              = 0.3,

      customParams        = {
        reaim_time = 1, -- noticeable twitching otherwise due to huge turnrates
        light_camera_height = 1600,
        light_color = [[0.8 0.76 0.38]],
        light_radius = 150,
        force_ignore_ground = [[1]],
      },

      damage                  = {
        default = 20,
        planes  = 20,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:EMG_HIT_HE]],
      firestarter             = 70,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 320,
      reloadtime              = 0.066,
      rgbColor                = [[1 0.55 0.4]],
      separation              = 1.6,
      soundHit                = [[weapon/cannon/emg_hit]],
      soundStart              = [[weapon/heavy_emg]],
      stages                  = 10,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 580,
    },

  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      collisionVolumeOffsets = [[0 -5 0]],
      collisionVolumeScales  = [[42 42 42]],
      collisionVolumeType    = [[ellipsoid]],
      object           = [[legvflak_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
