return { dronefactrans = {
  name                   = [[Pegasus]],
  description            = [[Medium Combat Transport]],
  acceleration           = 0.2,
  airStrafe              = 0,
  brakeRate              = 0.248,
  builder                = false,
  buildPic               = [[dronefactrans.png]],
  canFly                 = true,
  canGuard               = true,
  canload                = [[1]],
  canMove                = true,
  canPatrol              = true,
  canSubmerge            = false,
  category               = [[GUNSHIP]],
  collide                = false,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[60 25 100]],
  collisionVolumeType    = [[Box]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[83 38 135]],
  selectionVolumeType    = [[Box]],
  corpse                 = [[DEAD]],
  cruiseAltitude         = 180,

  customParams           = {
    airstrafecontrol  = [[1]],
    midposoffset      = [[0 0 0]],
    modelradius       = [[15]],
    transport_speed_light   = [[0.95]],
    transport_speed_medium  = [[0.85]],
    islighttransport  = 1,
    outline_x = 145,
    outline_y = 145,
    outline_yoff = 17.5,
  },

  explodeAs              = [[GUNSHIPEX]],
  floater                = true,
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 1000,
  hoverAttack            = true,
  iconType               = [[dronefactrans]],
  maneuverleashlength    = [[1280]],
  metalCost              = 340,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE SUB]],
  objectName             = [[legstronghold.s3o]],
  script                 = [[dronefactrans.lua]],
  releaseHeld            = true,
  selfDestructAs         = [[GUNSHIPEX]],

  sfxtypes               = {

    explosiongenerators = {

    },

  },
  sightDistance          = 620,
  speed                  = 160,
  transportCapacity      = 1,
  transportSize          = 25,
  turninplace            = 0,
  turnRate               = 420,
  upright                = true,
  verticalSpeed          = 30,
  workerTime             = 0,

   weapons                = {

    {
      def                = [[FLECHETTE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs             = {


    FLECHETTE = {
      name                    = [[Heavy Shotgun]],
      alphaDecay              = 0.3,
      areaOfEffect            = 64,
      burnBlow                = true,
      burst                   = 3,
      burstRate               = 0.033,
      coreThickness           = 0.5,
      craterBoost             = 0,
      craterMult              = 0,
	  collideFriendly         = false,

      customParams            = {
        light_camera_height = 2000,
        light_color = [[0.3 0.3 0.05]],
        light_radius = 50,
      },

      damage                  = {
        default = 15,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:archplosion_aoe]],
      fireStarter             = 50,
      heightMod               = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      projectiles             = 3,
      range                   = 250,
      reloadtime              = 1.966,
      separation              = 1.1,
      size                    = 2,
      sizeDecay               = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[impacts/shotgun_impactv5]],
      soundStart              = [[weapon/shotgun_firev4]],
      soundStartVolume        = 0.5,
      soundTrigger            = true,
      sprayangle              = 1200,
      stages                  = 20,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 880,
    }
  },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      collisionVolumeScales  = [[40 40 80]],
      collisionVolumeType    = [[CylZ]],
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legstronghold_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris3x3c.s3o]],
    },

  },

} }
