return { hoverheavy = {
  name                = [[Spear]],
  description         = [[Heavy Skirm-Assault Hovercraft]],
  acceleration        = 0.17,
  activateWhenBuilt   = true,
  brakeRate           = 0.5516,
  builder             = false,
  buildPic            = [[hoverheavy.png]],
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[HOVER]],
  collisionVolumeOffsets = [[0 -4 0]],
  collisionVolumeScales  = [[22 22 40]],
  collisionVolumeType    = [[cylZ]],
  corpse              = [[DEAD]],

  customParams        = {
    modelradius       = [[25]],
    selection_scale   = 0.85,
    aim_lookahead     = 120,
    turnatfullspeed_hover = [[1]],
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 4,
  footprintZ          = 4,
  health              = 7600,
  iconType            = [[hoverheavy]],
  maxSlope            = 36,
  metalCost           = 2100,
  movementClass       = [[HOVER4]],
  noChaseCategory     = [[TERRAFORM FIXEDWING SUB]],
  objectName          = [[legehovertank.s3o]],
  script              = [[hoverheavy.lua]],
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:HOVERS_ON_GROUND]],
      [[custom:RAIDMUZZLE]],
      [[custom:flashmuzzle1]],
    },

  },

  sightDistance       = 560,
  sonarDistance       = 560,
  speed               = 60.5,
  turninplace         = 0,
  turnRate            = 500,

  weapons             = {

    {
      def                = [[DISRUPTOR]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
	    {
      def                = [[DEPTHCHARGE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[SWIM FIXEDWING LAND SUB SINK TURRET FLOAT SHIP GUNSHIP HOVER]],
    },
	    {
      def                = [[MISSILE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER SUB]],
    },
		    {
      def                = [[MISSILE]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER SUB]],
    },

  },


  weaponDefs          = {

    DISRUPTOR      = {
      name                    = [[Disarming Pulse Beam]],
      areaOfEffect            = 24,
      beamdecay               = 0.9,
      beamTime                = 4/30,
      beamttl                 = 50,
      coreThickness           = 0.25,
      craterBoost             = 0,
      craterMult              = 0,
  
      customParams            = {
        disarmDamageMult = 4,
        disarmDamageOnly = 0,
        disarmTimer      = 3, -- seconds
        
        light_color = [[1 1 1]],
      },
      
      damage                  = {
        default = 400,
      },
  
      explosionGenerator      = [[custom:mixed_white_lightning_bomb_small]],
      fireStarter             = 30,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 4.43,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 385,
      reloadtime              = 3 + 1/30,
      rgbColor                = [[1 1 1]],
      soundStart              = [[weapon/laser/heavy_laser5]],
      soundStartVolume        = 5,
      soundTrigger            = true,
      sweepfire               = false,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 7,
      tolerance               = 18000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 550,
    },
	MISSILE = {
      name                    = [[Heavy Missile Battery]],
      areaOfEffect            = 80,
      cegTag                  = [[missiletrailyellow]],
      craterBoost             = 1,
      craterMult              = 1.4,
      
      customParams        = {
        burst = Shared.BURST_RELIABLE,
        force_ignore_ground = [[1]],

        light_camera_height = 3000,
        light_color = [[1 0.58 0.17]],
        light_radius = 180,
      },
      
      damage                  = {
        default = 300.1,
      },

      fireStarter             = 70,
      fixedlauncher           = true,
      flightTime              = 3.5,
      impulseBoost            = 0.75,
      impulseFactor           = 0.3,
      interceptedByShieldType = 2,
      leadlimit               = 0,
      model                   = [[wep_m_dragonsfang.s3o]],
	  burstrate               = 0.3,
      burst                   = 3,
      range                   = 500,
      reloadtime              = 12,
      smokeTrail              = true,
      soundHit                = [[explosion/ex_med5]],
      soundHitVolume          = 8,
      soundStart              = [[weapon/missile/rapid_rocket_fire2]],
      soundStartVolume        = 7,
      startVelocity           = 150,
      texture2                = [[lightsmoketrail]],
      tracks                  = true,
      trajectoryHeight        = 0.3,
      turnRate                = 23000,
      turret                  = true,
      weaponAcceleration      = 150,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 220,
    },
	DEPTHCHARGE = {
      name                    = [[Depth Charge]],
      areaOfEffect            = 160,
      avoidFriendly           = false,
      bounceSlip              = 0.94,
      bounceRebound           = 0.8,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      cegTag                  = [[torpedo_trail]],

      customParams = {
        burst = Shared.BURST_UNRELIABLE,
      },

      damage                  = {
        default = 480.1,
      },

      edgeEffectiveness       = 0.75,
      explosionGenerator      = [[custom:TORPEDOHITHUGE]],
      fixedLauncher           = true,
      flightTime              = 2.6,
      groundBounce            = false,
      heightMod               = 0,
      impulseBoost            = 0.2,
      impulseFactor           = 0.9,
      interceptedByShieldType = 1,
      leadLimit               = 0,
      model                   = [[depthcharge_big.s3o]],
      myGravity               = 0.2,
      noSelfDamage            = true,
      numbounce               = 3,
      range                   = 380,
      reloadtime              = 3.4,
      soundHitDry             = [[explosion/mini_nuke]],
      soundHitWet             = [[explosion/wet/ex_underwater]],
      soundStart              = [[weapon/torp_land]],
      soundStartVolume        = 8.5,
      soundHitVolume          = 11,
      startVelocity           = 10,
      tolerance               = 2000000,
      tracks                  = true,
      turnRate                = 60000,
      waterWeapon             = true,
      weaponAcceleration      = 25,
      weaponType              = [[TorpedoLauncher]],
      weaponVelocity          = 400,
    },

  },

  featureDefs         = {

    DEAD  = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legehovertank_dead.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
