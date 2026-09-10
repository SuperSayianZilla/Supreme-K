return { siegeaa = {
  name                   = [[Boreas]],
  description            = [[Missile AA Siegebot]],
  acceleration           = 0.8,
  activateWhenBuilt      = true,
  brakeRate              = 1.8,
  buildPic               = [[siegeaa.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[50 50 50]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 0,
    selection_scale    = 0.85,
	normaltex = [[unittextures/atlas_normal.dds]],

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 12.5,
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 900,
  iconType               = "siegeaa",
  leaveTracks            = true,
  maxSlope               = 36,
  metalCost              = 280,
  movementClass          = [[KBOT3]],
  noChaseCategory        = [[TERRAFORM LAND SINK TURRET SHIP SWIM FLOAT SUB HOVER]],
  objectName             = [[siegeaabot.s3o]],
  script                 = [[siegeaa.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {
    explosiongenerators = {
        [[custom:bubbles_small]],
        [[custom:disruptor_cannon_muzzle]],
    },
  },

  sightDistance          = 900,
  speed                  = 58.5,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 32,
  turnRate               = 520,
  upright                = true,

	weapons                = {

    {
      def                = [[CORTRUCK_MISSILE]],
      onlyTargetCategory = [[FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs             = {

    CORTRUCK_MISSILE = {
      name                    = [[Homing Missiles]],
      areaOfEffect            = 30,
      avoidFeature            = true,
	    burst                   = 3,
	    burstRate               = 0.29999,
      cegTag                  = [[missiletrailyellow]],
      craterBoost             = 0,
      craterMult              = 0,
      canAttackGround         = false,
      customParams        = {
        light_camera_height = 2000,
        light_radius = 200,
      },

      damage                  = {
        default = 60.1,
      },

      explosionGenerator      = [[custom:FLASH2]],
      fireStarter             = 70,
      flightTime              = 4,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[wep_m_frostshard.s3o]],
	    trajectoryHeight        = 0.9,
      range                   = 1200,
      reloadtime              = 2,
      smokeTrail              = true,
      soundHit                = [[explosion/ex_med17]],
      soundStart              = [[weapon/missile/missile_fire11]],
      startVelocity           = 425,
      texture2                = [[lightsmoketrail]],
      tolerance               = 8000,
      tracks                  = true,
      turnRate                = 33000,
      turret                  = true,
      weaponAcceleration      = 109,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 625,
    },

  }, 


  featureDefs            = {

    DEAD      = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[siegeaabot_dead.s3o]],
    },

    HEAP      = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
