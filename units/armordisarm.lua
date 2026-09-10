return { armordisarm = {
  name                   = [[Demeter]],
  description            = [[Disarming Plasma Truck]],
  acceleration           = 0.48,
  brakeRate              = 0.92,
  builder                = false,
  buildPic               = [[armordisarm.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND TOOFAST]],
  collisionVolumeOffsets = [[0 -5 0]],
  collisionVolumeScales  = [[35 35 35]],
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
  health                 = 280,
  iconType               = [[armorscout]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 70,
  movementClass          = [[TANK3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB DRONE]],
  objectName             = [[legafcv.s3o]],
  script                 = [[armordisarm.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:RAIDDUST]],
    },

  },
  sightDistance          = 620,
  speed                  = 130,
  trackOffset            = 6,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 1000,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[PLASMA]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    PLASMA = {
      name                    = [[Light Plasma Cannon]],
      areaOfEffect            = 32,
      cegTag                  = [[light_plasma_trail]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams        = {
	    
        disarmDamageMult = 3.5,
        disarmDamageOnly = 0,
        disarmTimer      = 3, -- seconds
        
        light_color = [[1 1 1]],
        burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 70.1,
        planes  = 70.1,
      },

      explosionGenerator      = [[custom:mixed_white_lightning_bomb_small]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 200,
      reloadtime              = 1.2,
      soundHit                = [[weapon/missile/small_lightning_missile]],
      soundStart              = [[weapon/cannon/medplasma_fire]],
	  soundStartVolume        = 0.8,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 400,
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
      object           = [[legafcv_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
