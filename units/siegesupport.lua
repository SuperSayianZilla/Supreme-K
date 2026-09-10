return { siegesupport = {
  name                   = [[Thor]],
  description            = [[Ranged Lightning Bot]],
  acceleration           = 0.75,
  brakeRate              = 1.2,
  buildPic               = [[siegesupport.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  corpse                 = [[DEAD]],
 -- collisionVolumeOffsets = [[0 0 0]],
  --collisionVolumeScales  = [[60 70 60]],
  --collisionVolumeType    = [[ellipsoid]],


  customParams           = {
    aim_lookahead  = 80,
    aimposoffset   = [[0 5 0]],
    midposoffset   = [[0 5 0]],
	modelradius    = [[45]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1400,
  iconType               = "siegesupport",
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 400,
  movementClass          = [[KBOT3]],
  noChaseCategory        = [[TERRAFORM FIXEDWING GUNSHIP SUB]],
  objectName             = [[siegebomb.s3o]],
  script                 = [[siegebomb.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:YELLOW_LIGHTNING_MUZZLE]],
      [[custom:YELLOW_LIGHTNING_GROUNDFLASH]],
    },

  },

  sightDistance          = 500,
  speed                  = 56.5,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 930,
  upright                = true,

  weapons                = {

    {
      def                = [[LIGHTNING]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT GUNSHIP SHIP HOVER]],
    },
	{
      def                = [[LIGHTNING]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT GUNSHIP SHIP HOVER]],
    },
   -- {
      --def                = [[SLOW_BLAST]],
      --onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    --},

  },

  weaponDefs             = {

       LIGHTNING = {
      name                    = [[Lightning Gun]],
      areaOfEffect            = 8,
      craterBoost             = 0,
      craterMult              = 0,

      customParams            = {
        extra_damage = 300,
        
        light_camera_height = 1600,
        light_color = [[0.85 0.85 1.2]],
        light_radius = 200,
        gui_draw_range = 450,
        reaim_time = 1,
      },

      cylinderTargeting      = 0,

      damage                  = {
        default        = 50,
      },

      duration                = 10,
      explosionGenerator      = [[custom:YELLOW_LIGHTNINGPLOSION]],
      fireStarter             = 50,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 12,
      interceptedByShieldType = 1,
      paralyzeTime            = 2,
      range                   = 420,
      reloadtime              = 3,
      rgbColor                = [[1 1 0.25]],
      soundStart              = [[weapon/more_lightning_fast]],
      soundTrigger            = true,
      sprayAngle              = 600,
      texture1                = [[lightning]],
      thickness               = 10,
      turret                  = true,
      weaponType              = [[LightningCannon]],
      weaponVelocity          = 400,
    },

    -- SLOW_BLAST = {
      -- name                    = [[Slow Blast]],
      -- accuracy                = 600,
      -- alphaDecay              = 0.5,
      -- areaOfEffect            = 175,
      -- craterAreaOfEffect      = 90,
      -- avoidFeature            = false,
      -- avoidGround             = false,
      -- cegTag                  = [[drp_trail_6]],
      -- craterBoost             = 0.1,
      -- craterMult              = 0.25,

      -- customparams = {
          -- lups_explodespeed = 1.04,
          -- lups_explodelife = 0.88,
          -- timeslow_damagefactor = 15,
          -- timeslow_overslow_frames = 2*30, --2 seconds before slow decays
          -- nofriendlyfire = 1,
          -- light_color = [[1.88 0.63 2.5]],
          -- light_radius = 200,
      -- },
      
      -- damage                  = {
        -- default =80.1,
      -- },

      -- edgeeffectiveness       = 0.8,
      -- explosionGenerator      = [[custom:riotballplus3_purple_limpet]],
      -- explosionScar           = false,
      -- explosionSpeed          = 6.5,
      -- impulseBoost            = 0.2,
      -- impulseFactor           = 0.1,
      -- interceptedByShieldType = 1,
      -- myGravity               = 0.05,
      -- nogap                   = false,
      -- nofriendlyfire          = true,
      -- range                   = 450,
      -- rgbColor                = [[0.7 0 0.7]],
      -- reloadtime              = 10,
      -- separation              = 1,
      -- size                    = 3,
      -- sizeDecay               = 0,
      -- soundHit                = [[weapon/aoe_aura2]],
      -- soundStart              = [[weapon/laser/corehlt_hit]],
      -- soundStartVolume        = 10,
      -- stages                  = 8,
      -- turret                  = true,
      -- weaponType              = [[Cannon]],
      -- weaponVelocity          = 500,
    -- },

  },

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[siegebomb_dead2.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
