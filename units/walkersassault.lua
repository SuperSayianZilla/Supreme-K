return { walkerassault = {
  name                   = [[Rallehop]],
  description            = [[Heavy Assault Walker]],
  acceleration           = 0.57,
  brakeRate              = 3.46,
  buildPic               = [[walkerassault.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 5 0]],
  collisionVolumeScales  = [[100 100 100]],
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
	bait_level_default = 0,
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 4, 
  footprintZ             = 4,
  health                 = 9000,
  iconType               = [[walkerassault1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 1200,
  movementClass          = [[TKBOT4]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SUB]],
  objectName             = [[legeallterrainmech.s3o]],
  script                 = [[walkerassault.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 500,
  speed                  = 56.5,
  trackOffset            = 0,
  trackStrength          = 12,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 88,
  turnRate               = 400,


weapons = {

    {
      def                = [[COR_GOL]],
      badTargetCategory  = [[FIXEDWING GUNSHIP]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP FIXEDWING]],
    },

},



   weaponDefs             = {

    COR_GOL             = {
      name                    = [[Dual Tankbuster Cannon]],
      areaOfEffect            = 60,
      cegTag                  = [[cyclops_plasma_trail]],
      craterBoost             = 0,
      craterMult              = 0,
	  avoidFriendly           = true,

      customParams            = {
        burst = Shared.BURST_RELIABLE,
        gatherradius = [[105]],
        smoothradius = [[70]],
        smoothmult   = [[0.4]],
        force_ignore_ground = [[1]],
        
        light_color = [[3 2.33 1.5]],
        light_radius = 150,
      },
      
      damage                  = {
        default = 500.2,
      },
      
	  burst                   = 2,
	  burstrate               = 0.3,
      explosionGenerator      = [[custom:TESS]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 430,
      reloadtime              = 5,
      soundHit                = [[weapon/cannon/supergun_bass_boost]],
      soundStart              = [[weapon/cannon/rhino]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 290,
    },

  },
    


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legeallterrainmech_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
