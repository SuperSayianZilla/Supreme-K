return { armorarty = {
  name                   = [[Vulcan]],
  description            = [[Fire-Rocket Tank]],
  acceleration           = 0.34,
  brakeRate              = 0.902,
  builder                = false,
  buildPic               = [[armorarty.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
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
  health                 = 900,
  iconType               = [[truckarty]],
  leaveTracks            = true,
  maxSlope               = 18,
  maxWaterDepth          = 22,
  metalCost              = 630,
  movementClass          = [[TANK3]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB DRONE]],
  objectName             = [[legbar.s3o]],
  script                 = [[armorarty.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:RAIDDUST]],
    },

  },
  sightDistance          = 550,
  speed                  = 52,
  trackOffset            = 6,
  trackStrength          = 5,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 460,
  workerTime             = 0,

  weapons                = {
  
  
    {
      def                = [[ADV_ROCKET]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[LAND SINK TURRET SHIP SWIM FLOAT HOVER FIXEDWING GUNSHIP]],
    },

  },    
     



  weaponDefs             = {


        ADV_ROCKET = {
      name                    = [[Fire Rocket Artillery]],
      areaOfEffect            = 90,
      burst                   = 3,
      burstrate               = 0.3,
      cegTag                  = [[rocket_trail_bar]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams        = {
	    bait_level_default = 1,
        light_camera_height = 2500,
        light_color = [[0.90 0.65 0.30]],
        light_radius = 250,
		setunitsonfire = "1",
        burnchance     = "1",
        burntime = 480,
        stats_burst_damage  = 240,
      },

      damage                  = {
        default = 185,
        planes  = 185,
      },
      explosionGenerator      = [[custom:blastwing]],
      edgeEffectiveness       = 0.5,
      fireStarter             = 70,
      flightTime              = 6,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      model                   = [[recluse_missile.s3o]],
      noSelfDamage            = true,
      predictBoost            = 0.75,
      range                   = 900,
      reloadtime              = 10,
      smokeTrail              = false,
      soundHit                = [[explosion/burn_explode]], 
      soundStart              = [[weapon/missile/missile_fire4]],
      soundTrigger            = true,
      startVelocity           = 150,
      trajectoryHeight        = 1.5,
      turnRate                = 4000,
      turret                  = true,
      weaponAcceleration      = 220,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 460,
      wobble                  = 7000,
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
      object           = [[legbar_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
