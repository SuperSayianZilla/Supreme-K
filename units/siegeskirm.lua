return { siegeskirm = {
  name                   = [[Catapult]],
  description            = [[Shelling Artillery Bot]],
  acceleration           = 0.75,
  activateWhenBuilt      = true,
  brakeRate              = 1.2,
  buildPic               = [[siegeskirm.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  corpse                 = [[DEAD]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[48 38 48]],
  collisionVolumeType    = [[ellipsoid]],

  customParams           = {
    bait_level_default = 1,
    aim_lookahead  = 80,
    aimposoffset   = [[0 5 0]],
    midposoffset   = [[0 5 0]],
    -- disable_radar_preview = 1,
	modelradius    = [[28]],
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1250,
  iconType               = "siegeskirm",
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 550,
  movementClass          = [[KBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING GUNSHIP SUB]],
  objectName             = [[legbart.s3o]],
  -- radarDistance          = 1200,
  -- radarEmitHeight        = 32,
  onoffable              = true,
  script                 = [[siegearty.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:STORMMUZZLE]],
      [[custom:STORMBACK]],
    },

  },

  sightDistance          = 660,
  speed                  = 53.5,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 930,
  upright                = true,

  weapons                = {

    {
            def                = [[CORE_ARTILLERY]],
      mainDir            = [[0 0 1]],
--      maxAngleDif        = 180,
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },
	 {
      def                = [[CORE_ARTILLERY]],
      mainDir            = [[0 0 1]],
--      maxAngleDif        = 180,
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },
  },

  weaponDefs          = {

    CORE_ARTILLERY = {
      name                    = [[Plasma Artillery]],
      accuracy                = 480,
      areaOfEffect            = 85,
      avoidFeature            = false,
      avoidGround             = true,
      cegTag                  = [[medium_arty_trail]],
      craterBoost             = 1,
      craterMult              = 2,

      customParams            = {
        burst = Shared.BURST_RELIABLE,

        light_color = [[1.4 0.8 0.3]],
      },

      damage                  = {
        default = 260.5,
        planes  = 260.5,
      },
      burst                   = 2,
	  burstrate               = 0.3,
      edgeEffectiveness       = 0.5,
      explosionGenerator      = [[custom:DOT_Pillager_Explo]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      myGravity               = 0.17,
      noSelfDamage            = true,
      range                   = 780,
      reloadtime              = 9,
      soundHit                = [[weapon/cannon/arty_hit]],
      soundStart              = [[weapon/cannon/pillager_fire]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 360,
      highTrajectory          = 1,
    },
},
  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legbart_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
