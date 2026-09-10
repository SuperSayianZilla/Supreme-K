return { staticadvmex = {
  name                   = [[Advanced Metal Extractor]],
  description            = [[Produces +4 innate metal on top of regular production.Explosive.]],
  activateWhenBuilt      = true,
  builder                = false,
  buildingMask           = 0,
  buildPic               = [[staticadvmex.png]],
  category               = [[UNARMED FLOAT]],
  collisionVolumeOffsets = [[0 -8 0]],
  collisionVolumeScales  = [[40 58 40]],
  collisionVolumeType    = [[ellipsoid]],
  corpse                 = [[DEAD]],

  customParams           = {
    occupationStrength = 1,
    pylonrange         = 50,
    ismex              = 1,
    metal_extractor_mult = 1.0,
    aimposoffset       = [[0 11 0]],
    midposoffset       = [[0 0 0]],
    modelradius        = [[15]],
    removewait         = 1,
    removestop     = 1,
    selectionscalemult = 1.4,
    normaltex = [[unittextures/ametalextractorlvl1_normals.dds]],
	stats_show_death_explosion = 1,

    outline_x = 75,
    outline_y = 75,
    outline_yoff = 10,
    outline_sea_x = 200,
    outline_sea_y = 260,
    outline_sea_yoff = -70,
  },

  explodeAs              = [[ESTOR_BUILDINGEX]],
  floater                = true,
  footprintX             = 3,
  footprintZ             = 3,
  health                 = 1000,
  iconType               = [[advmex]],
  levelGround            = false,
  maxSlope               = 28,
  maxWaterDepth          = 5000,
  metalCost              = 800,
  noAutoFire             = false,
  objectName             = [[staticadvmex.dae]],
  onoffable              = false,
  script                 = "staticadvmex.lua",
  selfDestructAs         = [[SMALL_BUILDINGEX]],
  sightDistance          = 273,
  waterline              = 1,
  workerTime             = 0,
  yardMap                = [[ooooooooo]],
  metalMake         = 4,

  featureDefs            = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[staticadvdead.dae]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 3,
      footprintZ       = 3,
      object           = [[debris3x3c.s3o]],
    },

  },

} }
