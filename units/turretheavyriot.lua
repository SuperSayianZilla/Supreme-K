return { turretheavyriot = {
  name                          = [[Apoc]],
  description                   = [[Heavy Riot Turret]],
  activateWhenBuilt             = true,
  builder                       = false,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 6,
  buildingGroundDecalSizeY      = 6,
  buildingGroundDecalType       = [[turretriot_aoplane.dds]],
  buildPic                      = [[turretheavyriot.png]],
  category                      = [[FLOAT TURRET]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[47 47 47]],
  collisionVolumeType           = [[ellipsoid]],
  corpse                        = [[DEAD]],

  customParams                  = {
    bait_level_target = 4,
    aimposoffset   = [[0 12 0]],
    midposoffset   = [[0 4 0]],
    aim_lookahead  = 50,
    heat_per_shot  = 0.035, -- Heat is always a number between 0 and 1
    heat_decay     = 1/6, -- Per second
    heat_max_slow  = 0.5,
    heat_initial   = 0,
    stats_show_death_explosion = 1,
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  floater                       = true,
  footprintX                    = 3,
  footprintZ                    = 3,
  health                        = 4200,
  iconType                      = [[defenseheavyriot]],
  levelGround                   = false,
  maxSlope                      = 18,
  metalCost                     = 720,
  noChaseCategory               = [[FIXEDWING LAND SHIP SWIM GUNSHIP SUB HOVER]],
  objectName                    = [[turretheavyriot.s3o]],
  script                        = "turretheavyriot.lua",
  selfDestructAs                = [[LARGE_BUILDINGEX]],

  sfxtypes                      = {

    explosiongenerators = {
      [[custom:WARMUZZLE]],
      [[custom:DEVA_SHELLS]],
    },

  },

  sightDistance                 = 600, 
  useBuildingGroundDecal        = true,
  yardMap                       = [[ooo ooo ooo]],

  weapons                       = {

    {
      def                = [[turretriot_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs                    = {

    turretriot_WEAPON = {
      name                    = [[Heavy Autocannon]],
      accuracy                = 1600,
      alphaDecay              = 0.7,
      areaOfEffect            = 110,
      avoidFeature            = false,
      burnblow                = true,
      cegTag                  = [[light_plasma_trail]],
      craterBoost             = 0.15,
      craterMult              = 0.3,
	  size                    = 0.8,

      customparams = {
	    setunitsonfire = "1",
        burnchance     = "1",
        burntime       = 90,
		
        light_color = [[1.0 0.76 0.28]],
        light_radius = 180,
        proximity_priority = 5, -- Don't use this unless required as it causes O(N^2) seperation checks per slow update.
      },

      damage                  = {
        default = 62,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:EMG_HIT_HE]],
      firestarter             = 70,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 0.1,
      rgbColor                = [[1 0.8 0.6]],
      separation              = 1.3,
      soundHit                = [[weapon/cannon/emg_hit]],
      soundStart              = [[weapon/sd_emgv7]],
      soundStartVolume        = 0.5,
      stages                  = 10,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 600,
    },

  },

  featureDefs                   = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[turretheavyriot_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris4x4b.s3o]],
    },

  },

} }
