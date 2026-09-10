return { siegebomb = {
  name                   = [[Hades]],
  description            = [[Explosive Fire Bomb]],
  acceleration           = 0.5,
  activateWhenBuilt      = true,
  brakeRate              = 1.2,
  buildPic               = [[siegebomb.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND]],
  cloakCost              = 0,
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[36 36 36]],
  collisionVolumeType    = [[ellipsoid]],
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[42 42 42]],
  selectionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    modelradius    = [[7]],
    selection_scale = 1, -- Maybe change later
	normaltex = [[unittextures/atlas_normal.dds]],
  },

  explodeAs              = [[shieldbomb_DEATH]],
  fireState              = 0,
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 680,
  iconType               = "siegebomb",
  kamikaze               = true,
  kamikazeDistance       = 80,
  kamikazeUseLOS         = true,
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 15,
  metalCost              = 290,
  movementClass          = [[KBOT3]],
  noChaseCategory        = [[FIXEDWING SINK SHIP SWIM GUNSHIP FLOAT SUB HOVER]],
  objectName             = [[siegebomb.s3o]],
  pushResistant          = 0,
  script                 = [[siegebomb.lua]],
  selfDestructAs         = [[shieldbomb_DEATH]],
  selfDestructCountdown  = 0,

  sfxtypes               = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
      [[custom:VINDIBACK]],
      [[custom:digdig]],
    },

  },

  sightDistance          = 320,
  speed                  = 106,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointy]],
  trackWidth             = 20,
  turnRate               = 800,
  
  featureDefs            = {

    DEAD      = {
      blocking         = false,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[siegebomb.s3o]],
    },

    HEAP      = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2c.s3o]],
    },

  },
  
    -- weapons                       = {

    -- {
      -- def                = [[shieldbomb_DEATH]],
      -- onlyTargetCategory = [[LAND TURRET FLOAT HOVER]],
    -- },
  -- },
  weaponDefs = {
    shieldbomb_DEATH = {
      areaOfEffect       = 400,
      craterBoost        = 1,
      craterMult         = 3.5,
      edgeEffectiveness  = 0.6,
      explosionGenerator = [[custom:napalm_pyro]],
      explosionSpeed     = 10000,
      impulseBoost       = 0,
      impulseFactor      = 0.3,
      fireStarter        = 100,
      name               = "Explosion",
      soundHit           ="explosion/burn_explode",
      damage = {
        default          = 1000.8,
      },
      customParams          = {
            setunitsonfire = "1",
            burnchance     = "1",
            burntime       = 600,

            area_damage = 1,
            area_damage_radius = 160,
            area_damage_dps = 40,
            area_damage_duration = 13.3,
        },

      },
  },
}
 }
