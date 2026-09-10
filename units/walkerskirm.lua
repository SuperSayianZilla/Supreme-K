return { walkerskirm = {
  name                   = [[Phaoroh]],
  description            = [[Homing Missile Walker]],
  acceleration           = 0.68,
  brakeRate              = 4.68,
  buildPic               = [[walkerskirm.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  corpse                 = [[DEAD]],

  customParams           = {
    midposoffset   = [[0 -5 0]],
    aim_lookahead  = 160,
    bait_level_default = 0,
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 580,
  iconType               = [[walkerskirm1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 260,
  movementClass          = [[TKBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName             = [[walkerskirm.s3o]],
  script                 = [[walkerskirm.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 590,
  speed                  = 49.5,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 52,
  turnRate               = 1000,

  weapons                = {

    {
      def                = [[ADV_ROCKET]],
      onlyTargetCategory = [[LAND SINK TURRET SHIP SWIM FLOAT HOVER FIXEDWING GUNSHIP]],
    },

  },

  weaponDefs             = {

    ADV_ROCKET = {
      name                    = [[Rocket Volley]],
      areaOfEffect            = 60,
      burst                   = 3,
      burstrate               = 0.3,
      avoidFeature            = true,
      cegTag                  = [[missiletrailyellow]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams        = {
        light_camera_height = 2500,
        light_color = [[0.90 0.65 0.30]],
        light_radius = 250,
		burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 140,
      },
      explosionGenerator      = [[custom:FLASH2]],
      edgeEffectiveness       = 0.5,
      fireStarter             = 70,
      flightTime              = 4,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_frostshard.s3o]],
      noSelfDamage            = true,
      predictBoost            = 0.81,
      range                   = 510,
      reloadtime              = 7,
      tracks                  = true,
      smokeTrail              = false,
      soundHit                = [[explosion/ex_med17]],
      soundStart              = [[weapon/missile/missile_fire11]],
      soundTrigger            = true,
      startVelocity           = 150,
      trajectoryHeight        = 1.9,
      turnRate                = 4000,
      turret                  = true,
      weaponAcceleration      = 150,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 500,

    },

  },

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      collisionVolumeOffsets = [[0 0 0]],
      collisionVolumeScales  = [[50 30 50]],
      collisionVolumeType    = [[ellipsoid]],
      object           = [[walkerskirm_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
