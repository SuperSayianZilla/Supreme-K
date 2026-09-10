return { dronefacraid = {
  name                   = [[Hornet]],
  description            = [[Raider VTOL]],
  acceleration           = 0.2,
  brakeRate              = 0.17,
  builder                = false,
  buildPic               = [[dronefacraid.png]],
  canFly                 = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canSubmerge            = false,
  category               = [[GUNSHIP]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[63 63 63]],
  selectionVolumeType    = [[ellipsoid]],
  collide                = true,
  corpse                 = [[DEAD]],
  cruiseAltitude         = 80,

  customParams           = {
    airstrafecontrol = [[1]],
    modelradius    = [[18]],
	selection_scale = 1.2,

  },

  explodeAs              = [[GUNSHIPEX]],
  floater                = true,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 520,
  hoverAttack            = true,
  iconType               = [[dronefacraid]],
  idleAutoHeal           = 5,
  idleTime               = 150,
  metalCost              = 140,
  noChaseCategory        = [[TERRAFORM SUB]],
  objectName             = [[legdrone.s3o]],
  script                 = [[dronefacraid.lua]],
  selfDestructAs         = [[GUNSHIPEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:VINDIBACK]],
    },

  },

  sightDistance          = 570,
  speed                  = 180,
  turnRate               = 985,

  weapons                = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
	  mainDir            = [[0 0 1]],
      maxAngleDif        = 190,
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs             = {

    LASER = {
      name                    = [[Laser Blaster]],
      areaOfEffect            = 8,
      cegTag                  = [[laser_cannon_trail_thin]],
      coreThickness           = 0.5,
      craterBoost             = 0,
      craterMult              = 0,
	  collideFriendly         = false,

      customParams        = {
        light_camera_height = 1200,
        light_radius = 120,
      },
      
      damage                  = {
        default = 18,
      },

      duration                = 0.02,
      explosionGenerator      = [[custom:BEAMWEAPON_HIT_RED]],
      fireStarter             = 50,
      heightMod               = 1,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      leadLimit               = 0,
      noSelfDamage            = true,
      range                   = 203,
      reloadtime              = 0.2,
      rgbColor                = [[1 0 0]],
      soundHit                = [[weapon/laser/lasercannon_hit]],
      soundStart              = [[weapon/laser/small_laser_fire2]],
      soundTrigger            = true,
      thickness               = 2.45,
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
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legdrone_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2a.s3o]],
    },

  },

} }
