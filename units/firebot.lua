return { siegeriot = {
  name                  = [[Ragnarok]],
  description           = [[Napalm Riot Siegebot]],
  acceleration          = 0.5,
  brakeRate             = 3.6,
  builder               = false,
  buildPic              = [[firebot.png]],
  canGuard              = true,
  canMove               = true,
  canPatrol             = true,
  category              = [[LAND FIREPROOF]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[45 45 45]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                = [[DEAD]],

  customParams          = {
  normaltex = [[unittextures/firebotnormal.dds]],
    --canjump            = 0, 
   -- jump_range         = 450,
   -- jump_speed         = 6.6,
   -- jump_reload        = 20,
   -- jump_from_midair   = 1,
    fireproof          = [[1]],
    stats_show_death_explosion = 1,
    aim_lookahead      = 100,

	--turnatfullspeed = 1,---testing tip
  },

  explodeAs             = [[PYRO_DEATH]],
  footprintX            = 4,
  footprintZ            = 4,
  health                = 2700,
  iconType              = [[siegeriot]],
  leaveTracks           = true,
  maxSlope              = 36,
  maxWaterDepth         = 22,
  metalCost             = 600,
  movementClass         = [[KBOT4]],
  noAutoFire            = false,
  noChaseCategory       = [[FIXEDWING GUNSHIP SUB]],
  objectName            = [[firebot.s3o]],
  script                = [[firebot.lua]],
  selfDestructAs        = [[PYRO_DEATH]],
  selfDestructCountdown = 5,

  sfxtypes              = {

    explosiongenerators = {
      [[custom:PILOT]],
      [[custom:PILOT2]],
      [[custom:RAIDMUZZLE]],
      [[custom:VINDIBACK]],
    },

  },

  sightDistance         = 560,
  speed                 = 60,
  trackOffset           = 0,
  trackStrength         = 9,
  trackStretch          = 1,
  trackType             = [[ComTrack]],
  trackWidth            = 32,
  turnRate              = 850,
  upright               = true,
  workerTime            = 0,
 -- turninplace = 0,--tip test was 0
  

  weapons               = {

    {
      def                = [[NAPALM_BOMBLET]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[LAND SINK TURRET SHIP SWIM FLOAT HOVER GUNSHIP]],
    },
    {
      def                = [[NAPALM_BOMBLET]],
      badTargetCategory  = [[GUNSHIP]],
      onlyTargetCategory = [[LAND SINK TURRET SHIP SWIM FLOAT HOVER GUNSHIP]],
    },

  },


  weaponDefs            = {

NAPALM_BOMBLET = {
      name                    = [[Flame Bomb]],
      accuracy                = 1000,
      areaOfEffect            = 96,
      avoidFeature            = true,
      avoidFriendly           = true,
      burnblow                = true,
      cegTag                  = [[flamer_koda]],
      craterBoost             = 0,
      craterMult              = 0,

      customParams              = {
	  
        setunitsonfire = "1",
        burnchance     = "1",
        burntime       = 150,
        force_ignore_ground = [[1]],

        area_damage = 1,
        area_damage_radius = 54,
        area_damage_dps = 50,
        area_damage_plateau_radius = 20,
        area_damage_duration = 1.6,
        
        light_color = [[1.6 0.8 0.32]],
        light_radius = 300,
		burst = Shared.BURST_RELIABLE,
      },
      
      damage                  = {
        default = 70,
        planes  = 70,
      },

      explosionGenerator      = [[custom:napalm_koda_small]],
      fireStarter             = 100,
      flameGfxTime            = 0.1,
      impulseBoost            = 0,
      impulseFactor           = 0.2,
      interceptedByShieldType = 1,
      leadLimit               = 90,
      model                   = [[wep_b_fabby.s3o]],
      myGravity               = 0.2,
      noSelfDamage            = true,
      range                   = 330,
      reloadtime              = 0.5,
      soundHit                = [[FireHit]],
      soundHitVolume          = 5,
      soundStart              = [[FireLaunch]],
      soundStartVolume        = 4,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 580,
	  tolerance               = 14000,
    },

    PYRO_DEATH = {
        name                    = [[Napalm Blast]],
        areaofeffect            = 280,
        craterboost             = 1.2,
        cratermult              = 3.5,

        customparams              = {
            setunitsonfire = "1",
            burnchance     = "1",
            burntime       = 90,

            area_damage = 1,
            area_damage_radius = 128,
            area_damage_dps = 20,
            area_damage_duration = 13.3,
        },

        damage                  = {
            default = 100,
        },

        edgeeffectiveness       = 0.5,
        explosionGenerator      = [[custom:napalm_pyro]],
        impulseboost            = 0,
        impulsefactor           = 0,
        soundhit                = [[explosion/ex_med3]],
    },
  },

  featureDefs           = {

    DEAD  = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[firebot_dead.s3o]],
    },

    
    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
