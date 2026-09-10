return { siegescout = {
  name                   = [[Shiva]],
  description            = [[Bunker Buster]],
  acceleration           = 0.36,
  brakeRate              = 1.44,
  builder                = false,
  buildPic               = [[siegescout.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[83 83 83]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    bait_level_default = 1,
    selection_scale   = 0.88,

    outline_x = 125,
    outline_y = 125,
    outline_yoff = 21,
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 4,
  footprintZ             = 4,
  health                 = 1250,
  iconType               = "siegescout",
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 600,
  movementClass          = [[KBOT4]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM SATELLITE SUB]],
  objectName             = [[leglob.s3o]],
  script                 = [[leglob.lua]],
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {
    explosiongenerators = {
      [[custom:STORMMUZZLE]],
      [[custom:STORMBACK]],
    },
  },

  sightDistance          = 550,
  speed                  = 56.5,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 800,
  upright                = true,

    weapons             = {

    {
      def                = [[vehriot_WEAPON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs          = {

    vehriot_WEAPON = {
      name                    = [[Impulse Cannon]],
      areaOfEffect            = 144,
      avoidFeature            = true,
      avoidFriendly           = true,
      burnblow                = true,
      cegTag                  = [[riot_cannon_trail]],
      craterBoost             = 1,
      craterMult              = 0.5,

      customParams            = {
        gatherradius = [[90]],
        smoothradius = [[60]],
        smoothmult   = [[0.08]],
        force_ignore_ground = [[1]],

        light_camera_height = 1500,
      },
      
      damage                  = {
        default = 800.2,
        planes  = 800.2,
      },

      edgeEffectiveness       = 0.75,
      explosionGenerator      = [[custom:FLASH64]],
      impulseBoost            = 30,
      impulseFactor           = 0.6,
      interceptedByShieldType = 1,
      noSelfDamage            = true,
      range                   = 590,
      reloadtime              = 12.4 + 2/30, -- don't forget to tweak the high-alpha threshold at the bottom of `LuaRules/Configs/target_priority_defs.lua`
      soundHit                = [[weapon/cannon/generic_cannon]],
      soundStart              = [[weapon/cannon/outlaw_gun]],
      soundStartVolume        = 3,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1250,
  },
   },

  featureDefs            = {

    DEAD      = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[leglob_dead.s3o]],
    },

    HEAP      = {
      blocking         = false,
      footprintX       = 4,
      footprintZ       = 4,
      object           = [[debris2x2c.s3o]],
    },

  },

} }
