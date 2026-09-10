return { dronefacskirm = {
  name                   = [[Dragonfly]],
  description            = [[Skirming VTOL]],
  acceleration           = 0.16,
  brakeRate              = 0.26,
  builder                = false,
  buildPic               = [[dronefacskirm.png]],
  canFly                 = true,
  canMove                = true,
  canSubmerge            = false,
  category               = [[GUNSHIP]],
  collide                = true,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[42 16 42]],
  collisionVolumeType    = [[cylY]],
  corpse                 = [[DEAD]],
  cruiseAltitude         = 120,

  customParams           = {
    bait_level_default = 0,
    airstrafecontrol = [[1]],
    modelradius    = [[16]],
	aim_lookahead     = 100,
	
  },

  explodeAs              = [[GUNSHIPEX]],
  floater                = true,
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 630,
  hoverAttack            = true,
  iconType               = [[dronefacskirm]],
  metalCost              = 250,
  noChaseCategory        = [[TERRAFORM SUB]],
  objectName             = [[legmos.s3o]],
  script                 = [[dronefacskirm.lua]],
  selfDestructAs         = [[GUNSHIPEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:rapiermuzzle]],
    },

  },

  sightDistance          = 630,
  speed                  = 100,
  turnRate               = 1100,

  weapons                = {

    {
      def                = [[Grenade]],
	  mainDir            = [[0 0 1]],
      maxAngleDif        = 180,
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs             = {

    			Grenade = {
				name                    = "Dual Grenade Launcher",
				areaOfEffect            = 90,
				accuracy                = 560,
				bouncerebound           = 0.5,
				bounceslip              = 0.4,
				craterBoost             = 0,
				craterMult              = 1,
				burnblow                = false,
				cegTag                  = "hydromissile",
				collideFriendly         = false,


				damage                  = {
					default = 200.01,
				},

				edgeEffectiveness       = 0.7,
				explosionGenerator      = "custom:MEDMISSILE_EXPLOSION",
				flightTime              = 2,
				groundbounce            = 1,
				impactOnly              = false,
				impulseBoost            = 0,
				impulseFactor           = 1.45,
				interceptedByShieldType = 1,
				leadlimit               = 100,
				myGravity               = 0.3,
				model                   = "diskball.s3o",
				numBounce               = 3,
				range                   = 625,
				reloadtime              = 4,
				soundHit                = "weapon/clusters/light_cluster_grenade_hit",
				soundHitVolume          = 8.6,
				soundStart              = "weapon/cannon/light_launcher",
				sprayAngle				= 620,
				turret                  = true,
				waterWeapon             = true,
				weaponType              = "Cannon",
				weaponVelocity          = 390,
			}

  },

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legmos_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
