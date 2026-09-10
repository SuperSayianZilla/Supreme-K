return { walkercon = {
  name                   = [[TerraHauler]],
  description            = [[Construction Walker]],
  acceleration           = 0.64,
  activateWhenBuilt      = true,
  brakeRate              = 3.6,
  buildDistance          = 180,
  builder                = true,

  buildoptions           = {
  },

  buildPic               = [[walkercon.png]],
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  category               = [[LAND UNARMED]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[32 32 32]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    modelradius    = [[15]],
    selection_scale = 1.7,
	normaltex = [[unittextures/atlas_normal.dds]],
    -- disable_radar_preview = 1,

  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 2,
  footprintZ             = 2,
  health                 = 700,
  iconType               = [[builder]],
  leaveTracks            = true,
  maxSlope               = 36,
  maxWaterDepth          = 22,
  metalCost              = 100,
  movementClass          = [[TKBOT2]],
  objectName             = [[quadcon.s3o]],
  -- radarDistance          = 1200,
  -- radarEmitHeight        = 12,
  script                 = [[walkercon.lua]],
  selfDestructAs         = [[BIG_UNITEX]],
  showNanoSpray          = false,
  sightDistance          = 400,
  speed                  = 70,
  trackOffset            = 0,
  trackStrength          = 10,
  trackStretch           = 1,
  trackType              = [[ChickenTrackPointyShort]],
  trackWidth             = 48,
  turnRate               = 1280,
  workerTime             = 5,

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[quadcon_dead.s3o]],
    },

    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3b.s3o]],
    },

  },

} }
