return { dronefacriot = {
  name                = [[Broadsword]],
  description         = [[Riot-Cannon VTOL]],
  acceleration        = 0.23,
  brakeRate           = 0.16,
  builder             = false,
  buildPic            = [[dronefacriot.png]],
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canSubmerge         = false,
  category            = [[GUNSHIP]],
  collide             = true,
  collisionVolumeOffsets = [[0 0 -5]],
  collisionVolumeScales  = [[40 20 60]],
  collisionVolumeType    = [[box]],
  corpse              = [[DEAD]],
  cruiseAltitude      = 110,

  customParams        = {
    bait_level_default = 0,
    airstrafecontrol = [[0]],
    modelradius      = [[10]],
    aim_lookahead    = 200,
	collideFriendly         = false,

    outline_x = 110,
    outline_y = 110,
    outline_yoff = 10,
  },

  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  health              = 1550,
  hoverAttack         = true,
  iconType            = [[dronefacriot]],
  maneuverleashlength = [[1280]],
  metalCost           = 380,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE SUB]],
  objectName          = [[legspsurfacegunship.s3o]],
  script              = [[dronefacriot.lua]],
  selfDestructAs      = [[GUNSHIPEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:brawlermuzzle]],
    },

  },
  sightDistance       = 560,
  speed               = 112,
  turnRate            = 620,
  workerTime          = 0,

      weapons             = {

    {
      def                = [[vehriot_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
	  mainDir            = [[0 0 1]],
      maxAngleDif        = 180,
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
	    {
      def                = [[vehriot_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
	  mainDir            = [[0 0 1]],
      maxAngleDif        = 180,
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    vehriot_WEAPON = {
      name                    = [[Impulse Cannon]],
      areaOfEffect            = 144,
      avoidFeature            = true,
      avoidFriendly           = true,
      burnblow                = true,
      cegTag                  = [[riot_cannon_trail]],
      craterBoost             = 1,
      craterMult              = 0.5,


      customParams            = {
        gatherradius = [[90]],
        smoothradius = [[60]],
        smoothmult   = [[0.08]],
        force_ignore_ground = [[1]],

        light_camera_height = 1300,
      },
      
      damage                  = {
        default = 200.2,
        planes  = 200.2,
      },

      edgeEffectiveness       = 0.75,
      explosionGenerator      = [[custom:FLASH64]],
      impulseBoost            = 30,
      impulseFactor           = 0.6,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 2.6 + 2/30, -- don't forget to tweak the high-alpha threshold at the bottom of `LuaRules/Configs/target_priority_defs.lua`
      soundHit                = [[weapon/cannon/generic_cannon]],
      soundStart              = [[weapon/cannon/outlaw_gun]],
      soundStartVolume        = 2.8,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1250,
	  sprayAngle              = 500,
  },

  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legspsurfacegunship_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
