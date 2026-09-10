return { dronefacassault = {
  name                = [[Gladius]],
  description         = [[Heavy Assault VTOL]],
  acceleration        = 0.17,
  brakeRate           = 0.14,
  builder             = false,
  buildPic            = [[dronefacassault.png]],
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canSubmerge         = false,
  category            = [[GUNSHIP]],
  collide             = true,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[50 15 50]],
  collisionVolumeType    = [[cylY]],
  corpse              = [[DEAD]],
  cruiseAltitude      = 125,

  customParams        = {
    bait_level_default = 1,
    airstrafecontrol = [[1]],
    modelradius    = [[10]],
	combatrange = 160,
  },

  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  health              = 3200,
  hoverAttack         = true,
  iconType            = [[dronefacassault]],
  metalCost           = 600,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[legheavydrone.s3o]],
  script              = [[dronefacassault.lua]],
  selfDestructAs      = [[GUNSHIPEX]],
  sightDistance       = 580,
  speed               = 141.5,
  turnRate            = 1000,
  
sfxtypes = {

explosiongenerators = {
  [[custom:BEAMWEAPON_MUZZLE_ORANGE_SMALL]],
},

},
  weapons                = {

    {
      def                = [[HEATRAY]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    HEATRAY = {
      name                    = [[Heat Ray]],
      accuracy                = 400,
      areaOfEffect            = 40,
      coreThickness           = 0.5,
      craterBoost             = 0.1,
      craterMult              = 0.1,
	  collideFriendly         = false,

      customParams        = {
        light_camera_height = 1500,
        light_color = [[0.9 0.4 0.12]],
        light_radius = 120,
        light_fade_time = 25,
        light_fade_offset = 10,
        light_beam_mult_frames = 9,
        light_beam_mult = 8,
      },

      damage                  = {
        default = 380,
        planes  =380,
      },

      duration                = 0.3,
      dynDamageExp            = 1,
      dynDamageInverted       = false,
      dynDamageRange          = 420,
      explosionGenerator      = [[custom:FLASH2]],
      fallOffRate             = 1,
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      leadLimit               = 5,
      lodDistance             = 10000,
      noSelfDamage            = true,
      proximityPriority       = 10,
      range                   = 400,
      reloadtime              = 2,
      rgbColor                = [[1 0.1 0]],
      rgbColor2               = [[1 1 0.25]],
      soundStart              = [[weapon/laser/heavy_laser5]],
      soundStartVolume        = 4,
      thickness               = 4,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 581.25,
    },

  },



  featureDefs         = {

    DEAD  = {
      blocking         = true,
      collisionVolumeScales  = [[65 20 65]],
      collisionVolumeType    = [[CylY]],
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legheavydrone_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
