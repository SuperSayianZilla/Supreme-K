return { armorgrav = {
  name                = [[Cosmos]],
  description         = [[Heavy Riot Gravity Tank]],
  acceleration        = 0.18,
  brakeRate           = 0.624,
  builder             = false,
  buildPic            = [[armorgrav.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[90 90 90]],
  selectionVolumeType    = [[ellipsoid]],
  corpse              = [[DEAD]],

  customParams        = {
    aim_lookahead      = 140,
    bait_level_default = 0,
    decloak_footprint     = 5,

    outline_x = 110,
    outline_y = 110,
    outline_yoff = 13.5,
  },

  explodeAs           = [[BIG_UNIT]],
  footprintX          = 4,
  footprintZ          = 4,
  health              = 8600,
  iconType            = [[armorgrav]],
  leaveTracks         = true,
  maxSlope            = 18,
  maxWaterDepth       = 22,
  metalCost           = 1950,
  movementClass       = [[TANK4]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB]],
  objectName          = [[legamcluster.s3o]],
  script              = [[armorgrav.lua]],
  selfDestructAs      = [[BIG_UNIT]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:LARGE_MUZZLE_FLASH_FX]],
    },

  },
  sightDistance       = 520,
  speed               = 61,
  trackOffset         = 8,
  trackStrength       = 10,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 50,
  turninplace         = 0,
  turnRate            = 470,
  workerTime          = 0,

  weapons             = {

			{
				def                = "VACUUM",
				badTargetCategory  = "FIXEDWING",
				onlyTargetCategory = "FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER",
			},
  },

  weaponDefs          = {

    			VACUUM = {
				name                    = "Vacuum Gun",
				areaOfEffect            = 250,
				avoidFeature            = false,
				avoidFriendly           = true,
				burnblow                = false,
				commandFire             = false,
				craterBoost             = 0,
				craterMult              = 0,
				craterAreaOfEffect      = 60,
				cegtag                  = "sonictrail",
				customParams            = {

					area_damage_drag_factor = 8,

				},

				damage                  = {
					default = 800, --make it not suck vs shields
				},

				explosionGenerator      = [[custom:black_hole_singu2]],
				explosionSpeed          = 50,
				impulseBoost            = 150,
				impulseFactor           = -3.5,
				intensity               = 0.9,
				interceptedByShieldType = 1,
				myGravity               = 0.1,
				projectiles             = 1,
				range                   = 460,
				reloadtime              = 6,
				rgbColor                = "0.05 0.05 0.05",
				size                    = 6,
				soundHit                = "weapon/impacts/impulsewave1",
				soundStart              = "weapon/cannon/commblackhole_fire",
				soundStartVolume        = 100,
				soundHitVolume          = 100,
				stages                  = 1,
                texture1                = [[sonic_glow2]],
                texture2                = [[null]],
                texture3                = [[null]],
				rgbColor                = {0.2, 0.1, 1.0},
				turret                  = true,
				weaponType              = "Cannon",
				weaponVelocity          = 700,
				waterweapon             = true,
			},
   
  },


  featureDefs         = {

    DEAD       = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[legamcluster_dead.s3o]],
    },

    
    HEAP       = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris4x4c.s3o]],
    },

  },

} }
