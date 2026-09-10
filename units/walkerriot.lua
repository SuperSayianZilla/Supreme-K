return { walkerriot = {
  name                   = [[Kratos]],
  description            = [[Energy Spider - Heavy Raider]],
  acceleration           = 0.75,
  brakeRate              = 3.26,
  buildPic               = [[walkerriot.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 5 0]],
  collisionVolumeScales  = [[48 52 48]],
  collisionVolumeType    = [[ellipsoid]],
  selectionVolumeOffsets = [[0 0 4]],
  selectionVolumeScales  = [[60 60 76]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    aimposoffset       = [[0 10 0]],
    aim_lookahead      = 80,
    selection_scale = 1.2,
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 780,
  iconType               = [[walkerriot1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 170,
  movementClass          = [[TKBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SUB]],
  objectName             = [[legaceb.s3o]],
  script                 = [[walkerriot.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 560,
  speed                  = 93,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 58,
  turnRate               = 888,


weapons = {

    {
      def                = [[DEW]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[DEW]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

},



  weaponDefs          = {

   DEW = {
      name                    = [[Direct Energy Weapon]],
      areaOfEffect            = 48,
      coreThickness           = 0.3,
      craterBoost             = 0,
      craterMult              = 0,

      customParams              = {
        light_camera_height = 1600,
        light_color = [[1 0.5 0]],
        light_radius = 160,
        burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 45.1,
      },

      duration                = 0.2,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 50,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 232,
      reloadtime              = 0.6,
      rgbColor                = [[1 0 0]],
      soundHit                = [[weapon/laser/small_laser_fire2]],
      soundStart              = [[weapon/laser/small_laser_fire3]],
      soundTrigger            = true,
      texture1                = [[energywave]],
      texture2                = [[null]],
      texture3                = [[null]],
      thickness               = 5,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 870,
    },
	

  },
    


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legaceb_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
