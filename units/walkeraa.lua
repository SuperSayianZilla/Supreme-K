return { walkeraa = {
  name                   = [[Skier]],
  description            = [[Anti-Air Walker]],
  acceleration           = 0.36,
  brakeRate              = 3.96,
  buildPic               = [[walkeraa.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[40 30 40]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    aim_lookahead      = 150,
    bait_level_default = 0,
    cus_noflashlight = 1,
    okp_damage = 220.1,
    normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 900,
  iconType               = [[walkeraa]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 240,
  movementClass          = [[TKBOT3]],
  moveState              = 0,
  noChaseCategory        = [[TERRAFORM LAND SINK TURRET SHIP SATELLITE SWIM FLOAT SUB HOVER]],
  objectName             = [[walkeraa.s3o]],
  script                 = [[walkeraa.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 700,
  speed                  = 72,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 50,
  turnRate               = 840,

  weapons                = {

    {
      def                = [[VTOL_ROCKET]],

      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },

  weaponDefs             = {

    VTOL_ROCKET = {
      name                    = [[Disruptor Missiles]],
      areaOfEffect            = 16,
      avoidFeature            = false,
      burnblow                = true,
      cegTag                  = [[missiletrailpurple]],
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      customparams = {
        burst = Shared.BURST_RELIABLE,

        timeslow_damagefactor = 3,
        
        light_camera_height = 2500,
        light_color = [[1.3 0.5 1.6]],
        light_radius = 220,
      },

      damage                  = {
        default = 220.1,
      },

      explosionGenerator      = [[custom:disruptor_missile_hit]],
      fireStarter             = 70,
      flightTime              = 2.2,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      leadlimit               = 0,
      model                   = [[wep_m_maverick.s3o]],
      range                   = 700,
      reloadtime              = 4,
      smokeTrail              = true,
      soundHit                = [[explosion/ex_med11]],
      soundStart              = [[weapon/missile/rocket_fire]],
      soundTrigger            = true,
      startVelocity           = 300,
      texture2                = [[purpletrail]],
      tolerance               = 32767,
      tracks                  = true,
      turnRate                = 60000,
      turret                  = true,
      weaponAcceleration      = 350,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 1200,
	  canAttackGround         = false,
    },
	 },

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      collisionVolumeOffsets = [[0 -5 0]],
      collisionVolumeScales  = [[40 30 40]],
      collisionVolumeType    = [[ellipsoid]],
      object           = [[walkeraa_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
