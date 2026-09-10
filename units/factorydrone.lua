return { factorydrone = {
  name                          = [[VTOL Support Factory]],
  description                   = [[Produces VTOLs. Can not be plated]],
  buildDistance                 = 380,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 10,
  buildingGroundDecalSizeY      = 10,
  buildingGroundDecalType       = [[factorygunship_aoplane.dds]],

  buildoptions                  = {
    [[dronefaccon]],
    [[dronefacriot]],
    [[dronefacraid]],
    [[dronefacskirm]],
    [[dronefactorp]],
	[[dronefacassault]],
	[[dronefactrans]],

  },

  buildPic                      = [[factorydrone.png]],
  canMove                       = true,
  canPatrol                     = true,
  category                      = [[FLOAT UNARMED]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[86 86 86]],
  collisionVolumeType           = [[ellipsoid]],
  selectionVolumeOffsets        = [[0 10 0]],
  selectionVolumeScales         = [[104 60 104]],
  selectionVolumeType           = [[box]],
  corpse                        = [[DEAD]],

  customParams                  = {
    ploppable = 1,
    lab_hax_feature_only = 1,
    landflystate   = [[0]],
    factory_land_state = 0,
    sortName = [[3]],
    modelradius    = [[43]],
    default_spacing = 8,
    factorytab       = 1,
    shared_energy_gen = 1,
    buggeroff_offset    = 0,

    stats_show_death_explosion = 1,
	normaltex = [[unittextures/atlas_normal.dds]],

    outline_x = 250,
    outline_y = 250,
    outline_yoff = 5,
  },

  explodeAs                     = [[LARGE_BUILDINGEX]],
  footprintX                    = 7,
  footprintZ                    = 7,
  health                        = 4000,
  iconType                      = [[dronefac]],
  maxSlope                      = 15,
  metalCost                     = Shared.FACTORY_COST,
  moveState                     = 1,
  noAutoFire                    = false,
  objectName                    = [[legsplab.s3o]],
  script                        = [[factorydrone.lua]],
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = false,
  sightDistance                 = 273,
  useBuildingGroundDecal        = true,
  waterline                     = 0,
  workerTime                    = Shared.FACTORY_BUILDPOWER,
  yardMap                       = [[yyoooyy yoooooy ooooooo ooooooo ooooooo yoooooy yyoooyy]],

  featureDefs                   = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 7,
      footprintZ       = 7,
      object           = [[legsplab_dead.s3o]],
      collisionVolumeOffsets        = [[0 -20 0]],
      collisionVolumeScales         = [[86 86 86]],
      collisionVolumeType           = [[ellipsoid]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 6,
      footprintZ       = 6,
      object           = [[debris4x4c.s3o]],
    },

  },

} }
