return { siegeraid = {
  name                   = [[Cougar]],
  description            = [[Heavy Raider/Riot Bot (Gattling Cannons)]],
  acceleration           = 0.78,
  brakeRate              = 1.2,
  buildPic               = [[siegeraid.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  corpse                 = [[DEAD]],

  customParams           = {
    aim_lookahead  = 80,
    aimposoffset   = [[0 5 0]],
    midposoffset   = [[0 5 0]],
    modelradius    = [[22]],
	heat_per_shot  = 0.035, -- Heat is always a number between 0 and 1
    heat_decay     = 1/6, -- Per second
    heat_max_slow  = 0.5,
    heat_initial   = 0,
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 900,
  iconType               = "siegeraid",
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 260,
  movementClass          = [[KBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING GUNSHIP SUB]],
  objectName             = [[legstr.s3o]],
  script                 = [[cougar.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:emg_shells_l]],
      [[custom:flashmuzzle1]],
    },

  },

  sightDistance          = 530,
  speed                  = 88,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 1230,
  upright                = true,

  weapons                = {

    {
      def                = [[PLASMA]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
  },


  weaponDefs             = {

    PLASMA = {
      name                    = "Rapid-Fire Gatling Plasma",
      accuracy                = 450,
      areaOfEffect            = 85,
      avoidFeature            = false,
      avoidGround             = false,
      cegTag                  = [[light_plasma_trail]],
      craterAreaOfEffect      = 0,
      craterBoost             = 0,
      craterMult              = 0,
	  size                    = 0.8,
      
      customParams            = {
				light_camera_height = 2000,
				light_color           = [[0.85 0.33 1]],
				light_radius = 150,
      },

      damage                  = {
        default = 23,
        planes  = 23, 
      },
      edgeEffectiveness       = 0.5,
      explosionGenerator      = "custom:EMG_HIT_HE",
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      myGravity               = 0.2,
      noSelfDamage            = true,
      nofriendlyfire          = true,
      range                   = 255,
      reloadtime              = 0.1,
      soundStart              = [[weapon/sd_emgv7]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 990,
    },

  }, 



  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legstr_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
