return { dronefactorp = {
  name                = [[Harpoon]],
  description         = [[Sea Combat VTOL]],
  acceleration        = 0.22,
  brakeRate           = 0.16,
  builder             = false,
  buildPic            = [[dronefactorp.png]],
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
  cruiseAltitude      = 100,

  customParams        = {
    bait_level_default = 0,
    airstrafecontrol = [[0]],
    modelradius      = [[10]],
    aim_lookahead    = 200,
    sonar_can_be_disabled = 1,

    outline_x = 110,
    outline_y = 110,
    outline_yoff = 10,
  },

  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 3,
  footprintZ          = 3,
  health              = 1250,
  hoverAttack         = true,
  iconType            = [[dronefactorp]],
  maneuverleashlength = [[1280]],
  metalCost           = 270,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE]],
  objectName          = [[legsptorpgunship.s3o]],
  script              = [[dronefactorp.lua]],
  selfDestructAs      = [[GUNSHIPEX]],

  sfxtypes            = {

    explosiongenerators = {
 
    },

  },
  sightDistance       = 560,
  sonarDistance       = 450,
  speed               = 118,
  turnRate            = 760,
  workerTime          = 0,

      weapons                = {
    {
      def                = [[TORPEDO]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP HOVER]],
    },
	


  },

  weaponDefs             = {


    TORPEDO = {
      name                    = [[Torpedo]],
      areaOfEffect            = 32,
      avoidFriendly           = false,
      bouncerebound           = 0.5,
      bounceslip              = 0.8,
      canAttackGround         = false,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cegTag                  = [[torpedo_trail]],
	  collideFriendly         = false,

      customparams = {
        radar_homing_distance = 350,
        stays_underwater = 1,
		burst = Shared.BURST_RELIABLE,
      },

      damage                  = {
        default = 300.01,
      },

      edgeEffectiveness       = 0.99,
      explosionGenerator      = [[custom:TORPEDO_HIT]],
      flightTime              = 3,
      groundbounce            = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      leadlimit               = 0,
      model                   = [[wep_m_ajax.s3o]],
      numbounce               = 4,
      noSelfDamage            = true,
      projectiles             = 1,
      range                   = 350,
      reloadtime              = 3,
      soundHit                = [[explosion/wet/ex_underwater]],
      --soundStart              = [[weapon/torpedo]],
      soundStartVolume        = 0.7,
      soundHitVolume          = 0.7,
      startVelocity           = 140,
      tolerance               = 1000,
      tracks                  = true,
      turnRate                = 25000,
      turret                  = true,
      waterWeapon             = true,
      weaponAcceleration      = 80,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 250,
    },
  },


  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legsptorpgunship_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
