return { dronefaccon = {
  name                = [[Sprung]],
  description         = [[Construction VTOL]],
  acceleration        = 0.14,
  airStrafe           = 1,
  brakeRate           = 0.08,
  buildDistance       = 170,
  selectionVolumeOffsets = [[0 0 0]],
  selectionVolumeScales  = [[63 63 63]],
  selectionVolumeType    = [[ellipsoid]],
  builder             = true,

  buildoptions        = {
  },

  buildPic            = [[dronefaccon.png]],
  buildRange3D        = false,
  canFly              = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  canSubmerge         = false,
  category            = [[GUNSHIP UNARMED]],
  collisionVolumeOffsets        = [[0 0 -5]],
  collisionVolumeScales         = [[42 8 42]],
  collisionVolumeType           = [[cylY]],
  collide             = true,
  corpse              = [[DEAD]],
  cruiseAltitude      = 80,

  customParams        = {
    airstrafecontrol = [[1]],
    modelradius    = [[10]],
    midposoffset   = [[0 4 0]],

    outline_x = 80,
    outline_y = 80,
    outline_yoff = 7.5,
  },

  explodeAs           = [[GUNSHIPEX]],
  floater             = true,
  footprintX          = 2,
  footprintZ          = 2,
  health              = 420,
  hoverAttack         = true,
  iconType            = [[dronefaccon]],
  metalCost           = 160,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK TURRET]],
  objectName          = [[legca.s3o]],
  script              = [[dronefaccon.lua]],
  selfDestructAs      = [[GUNSHIPEX]],
  showNanoSpray       = false,
  sightDistance       = 375,
  speed               = 80,
  turnRate            = 500,
  workerTime          = 5,

  featureDefs         = {

    DEAD  = {
      blocking         = true,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[legca.s3o]],
    },


    HEAP  = {
      blocking         = false,
      footprintX       = 2,
      footprintZ       = 2,
      object           = [[debris2x2b.s3o]],
    },

  },

} }
