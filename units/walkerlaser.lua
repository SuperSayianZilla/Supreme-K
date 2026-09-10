return { walkerlaser = {
  name                   = [[Zialith]],
  description            = [[Giant Laser Walker-Heavy Riot]],
  acceleration           = 0.61,
  brakeRate              = 3.96,
  buildPic               = [[walkerlaser.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 5 0]],
  collisionVolumeScales  = [[88 88 88]],
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
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 6000,
  iconType               = [[walkerlaser1]],
  leaveTracks            = true,
  maxSlope               = 72,
  maxWaterDepth          = 22,
  metalCost              = 1350,
  movementClass          = [[TKBOT4]],
  noChaseCategory        = [[TERRAFORM FIXEDWING SUB]],
  objectName             = [[legsrail.s3o]],
  script                 = [[walkerlaser.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  sightDistance          = 480,
  speed                  = 49.5,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 58,
  turnRate               = 650,


weapons = {

    {
      def                = [[LASER]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
},



  weaponDefs          = {

    LASER = {
      name                    = [[Omega Laserbeam]],
      areaOfEffect            = 90,
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
        
        combatrange = 420,
      },

      damage                  = {
        default = 50,
      },

      explosionGenerator      = [[custom:flash1red]],
      --heightMod             = 0.5,
      impactOnly              = false,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 2,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 460,
      reloadtime              = 4/30,
      rgbColor                = [[1 0 0]],
      soundStart              = [[weapon/laser/laser_burn9]],
      sweepfire               = true,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 8,
      tolerance               = 10000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
    },
  },
    


  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[legsrail_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3a.s3o]],
    },

  },

} }
