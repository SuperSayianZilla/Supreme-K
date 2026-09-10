return { siegeassault = {
  name                   = [[Apollo]],
  description            = [[Siege Assault Bot]],
  acceleration           = 0.7,
  brakeRate              = 1.2,
  activateWhenBuilt   = true,
  builder             = false,
  buildPic               = [[siegeassault.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  corpse                 = [[DEAD]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[70 65 70]],
  collisionVolumeType    = [[ellipsoid]],

  customParams           = {
    
    selection_rank = 3,
    aim_lookahead  = 80,
    aimposoffset   = [[0 5 0]],
    midposoffset   = [[0 5 0]],
	modelradius    = [[36]],
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 3000,
  iconType               = "siegeassault",
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 300,
  movementClass          = [[KBOT3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName             = [[legshot.s3o]],
  script                 = [[siegeassault.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:HEAVYHOVERS_ON_GROUND]],
      [[custom:plasma_cannon_muzzle_blue]],
    },

  },

  sightDistance          = 480,
  speed                  = 59.5,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 730,
  upright                = true,

  weapons             = {

    {
      def                = [[COR_REAP]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    COR_REAP = {
      name                    = [[Medium Plasma Cannon]],
      areaOfEffect            = 32,
      burst                   = 2,
      burstRate               = 0.2,
      cegTag                  = [[medium_plasma_trail]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams            = {
        burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 240.1,
      },

      explosionGenerator      = [[custom:DEFAULT]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 340,
      reloadtime              = 4,
      soundHit                = [[weapon/cannon/reaper_hit]],
      soundStart              = [[weapon/cannon/cannon_fire5]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 260,
    },

  },

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legshot_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
