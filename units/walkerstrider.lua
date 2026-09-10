return { walkerstrider = {
  name                   = [[Harbinger]],
  description            = [[Giant Laser/Artillery Walker]],
  acceleration           = 0.13,
  brakeRate              = 2.96,
  buildPic               = [[walkerstrider.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  --canManualFire          = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 5 0]],
  collisionVolumeScales  = [[128 128 128]],
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
	bait_level_default = 1,
	draw_reload_num       = 2,
	stats_show_death_explosion = 1,
	combatrange = 680,
	
    extradrawrange     = 1400,
	turnatfullspeed = [[1]],
	
  },

  explodeAs              = [[ESTOR_BUILDING]],
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 9200,
  iconType               = [[walkerstrider1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 4600,
  movementClass          = [[TKBOT4]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SUB]],
  objectName             = [[legelrpcmech.s3o]],
  script                 = [[walkerstrider.lua]],
  selfDestructAs         = [[ESTOR_BUILDING]],
  sightDistance          = 720,
  speed                  = 40.5,
  trackOffset            = 0,
  trackStrength          = 12,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 88,
  turnRate               = 500,
  turninplace = 0,
  



weapons = {


	    -- {
      -- def                = [[CUTTER]],
	  -- mainDir            = [[0 0 1]],
      -- maxAngleDif        = 180,
      -- badTargetCategory  = [[GUNSHIP]],
      -- onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
    -- },
	    {
      def                = [[HEATRAY]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
	  mainDir            = [[0 0 1]],
      maxAngleDif        = 90,

    },

	    {
      def                = [[ARM_CRABE_GAUSS]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
    },

},



   weaponDefs             = {

    ARM_CRABE_GAUSS = {
      name                    = [[Heavy Burst Plasma Cannon]],
      areaOfEffect            = 220,
      cegTag                  = [[crab_plasma_trail]],
      craterBoost             = 0,
      craterMult              = 0.5,

      customParams            = {
        force_ignore_ground = [[1]],
        light_color = [[1.5 1.13 0.6]],
        light_radius = 450,
		burst = Shared.BURST_RELIABLE,
		
      },

      damage                  = {
        default = 650.5,
      },
	  
	  burst                   = 4,
	  burstrate               = 0.3,
      edgeEffectiveness       = 0.3,
      explosionGenerator      = [[custom:spidercrabe_EXPLOSION]],
      impulseBoost            = 0,
      impulseFactor           = 0.32,
	  myGravity               = 0.08,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 1400,
      reloadtime              = 40,
      soundHit                = [[weapon/cannon/cannon_hit3]],
      soundStart              = [[weapon/cannon/heavy_cannon2]],
	  sprayangle              = 1024,
      -- size = 5, -- maybe find a good size that is bigger than default
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 335,
	  --commandFire             = true,
	  
    },
	    HEATRAY = {
      name                    = [[Tachyon Ray]],
      accuracy                = 300,
      areaOfEffect            = 140,
      coreThickness           = 0.5,
      craterBoost             = 0.15,
      craterMult              = 0.15,
	  avoidFriendly           = true,
	  avoidFeature            = false,
      avoidNeutral            = false,
      avoidGround             = true,
	  --collideFriendly         = false,

      customParams        = {
        light_camera_height = 1500,
       
        
        light_fade_time = 25,
        light_fade_offset = 10,
        light_beam_mult_frames = 30,
        light_beam_mult = 8,
		light_color = [[3 0.2 4]],
        light_radius = 1200,
        light_beam_start = 0.8,
      },

      damage                  = {
        default = 600,
        planes  = 600,
      },

      duration                = 0.4,
      dynDamageExp            = 1,
      dynDamageInverted       = false,
      dynDamageRange          = 1000,
      explosionGenerator      = [[custom:FLASHLAZER]],
      fallOffRate             = 1.0,
      fireStarter             = 90,
      heightMod               = 1,
      impactOnly              = false,
      impulseBoost            = 50,
      impulseFactor           = 0.3,
      interceptedByShieldType = 1,
      leadLimit               = 5,
      lodDistance             = 10000,
      noSelfDamage            = true,
      proximityPriority       = 10,
      range                   = 720,
      reloadtime              = 4,
      rgbColor                = [[0.25 0 1]],
	  soundStart              = [[weapon/laser/heavy_laser6]],
      soundStartVolume        = 9,
      soundTrigger            = true,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 14,
	  --fireTolerance           = 16192,
      tolerance               = 9600,
      turret                  = false,
	  waterWeapon             = true,
	  sprayangle              = 900,
	  burst                   = 5,
	  burstrate               = 0.2,
      weaponType              = [[LaserCannon]],
      weaponVelocity          = 720,
    },
    -- CUTTER    = {
      -- name                    = [[Groovecutter]],
      -- alwaysVisible           = 0,
      -- areaOfEffect            = 120,
      -- avoidFeature            = false,
      -- avoidNeutral            = false,
      -- avoidGround             = true,
      -- beamTime                = 2,
      -- coreThickness           = 0.5,
      -- craterBoost             = 0.02,
      -- craterMult              = 0.02,

      -- customParams              = {
        -- light_color = [[3 0.2 4]],
        -- light_radius = 1200,
        -- light_beam_start = 0.8,
      -- },
      
      -- damage                  = {
        -- default = 2500,
      -- },

      -- explosionGenerator      = [[custom:FLASHLAZER]],
      -- impulseBoost            = 0,
      -- impulseFactor           = 0,
      -- interceptedByShieldType = 1,
      -- largeBeamLaser          = true,
      -- laserFlareSize          = 8,
      -- minIntensity            = 1,
	  -- reloadtime              = 3,
      -- range                   = 720,
      -- rgbColor                = [[0.25 0 1]],
      -- scrollSpeed             = 8,
	  -- soundStart              = [[weapon/laser/heavy_laser6]],
      -- soundStartVolume        = 9,
      -- soundTrigger            = true,
      -- texture1                = [[largelaser]],
      -- texture2                = [[flare]],
      -- texture3                = [[flare]],
      -- texture4                = [[smallflare]],
      -- thickness               = 14,
	  -- sweepfire               = true,
	  -- fireTolerance           = 10192,
      -- tolerance               = 9536,
      -- tileLength              = 1200,
      -- turret                  = true,
      -- waterWeapon             = true,
      -- weaponType              = [[BeamLaser]],
    -- },
      },


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legelrpcmech_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
