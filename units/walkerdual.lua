return { walkerdual = {
  name                   = [[Cronos]],
  description            = [[Duel Weapon Riot Spider]],
  acceleration           = 0.66,
  brakeRate              = 3.96,
  buildPic               = [[walkerdual.png]],
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
  health                 = 2000,
  iconType               = [[walkerdual1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 450,
  movementClass          = [[TKBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SUB]],
  objectName             = [[legkark.s3o]],
  script                 = [[walkerdual.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 366,
  speed                  = 60.5,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 58,
  turnRate               = 738,


weapons = {

    {
      def                = [[LASER]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[FLECHETTE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

},



  weaponDefs          = {

    LASER = {
      name                    = [[Light Laserbeam]],
      areaOfEffect            = 8,
      avoidFeature            = false,
      beamTime                = 4/30,
      collideFriendly         = false,
      coreThickness           = 0.3,
      craterBoost             = 0,
      craterMult              = 0,
      --cylinderTargeting     = 1,

      customparams = {
        stats_hide_damage = 1, -- continuous laser
        stats_hide_reload = 1,
        
        light_color = [[1 0.25 0.25]],
        light_radius = 175,
        flamethrower = [[1]],
        combatrange = 320,
		setunitsonfire = "1",
        burnchance = "0.4", -- Per-impact
        burntime = [[450]],
      },

      damage                  = {
        default = 8.1,
      },

      explosionGenerator      = [[custom:flash1red]],
      --heightMod             = 0.5,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 2,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 320,
      reloadtime              = 4/30,
      rgbColor                = [[1 0.65 0]],
      soundStart              = [[weapon/laser/laser_burn9]],
      sweepfire               = false,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 3,
      tolerance               = 2000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
    },
	
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

      customParams            = {
        light_camera_height = 2000,
        light_color = [[0.3 0.3 0.05]],
        light_radius = 50,
      },

      damage                  = {
        default = 28,
      },

      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:archplosion_aoe]],
      fireStarter             = 50,
      heightMod               = 1,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      projectiles             = 3,
      range                   = 285,
      reloadtime              = 0.966,
      separation              = 1.2,
      size                    = 2,
      sizeDecay               = 0,
      rgbColor                = [[1 1 0]],
      soundHit                = [[impacts/shotgun_impactv5]],
      soundStart              = [[weapon/shotgun_firev4]],
      soundStartVolume        = 0.5,
      soundTrigger            = true,
      sprayangle              = 1900,
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
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legkark_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
