-- lrpc_explsmall

return {
  ["lrpc_explsmall"] = {
    usedefaultexplosions = true,

    bang = {
      air                = true,
      class              = [[heatcloud]],
      count              = 2,
      ground             = true,
      water              = true,
      properties = {
        heat               = 12,
        heatfalloff        = 1,
        maxheat            = 12,
        pos                = [[0, 5, 0]],
        size               = 6,
        sizegrowth         = 6,
        speed              = [[0, 0, 0]],
        texture            = [[sakexplo]],
      },
    },

    groundflash = {
      circlealpha        = .5,
      circlegrowth       = 4.8,
      flashalpha         = 1.8,
      flashsize          = 96,
      ttl                = 24,
      color = {
        [1]  = 1,
        [2]  = 0.69999998807907,
        [3]  = 0.40000000596046,
      },
    },

    heatcloud = {
      air                = true,
      count              = 5,
      ground             = true,
      properties = {
        heat               = 30,
        heatfalloff        = .5,
        maxheat            = 30,
        pos                = [[-15 r30, r15, -15 r30]],
        size               = 22,
        speed              = [[0.4 r-0.8, -0.4 r0.8, 0.4 r-0.8]],
      },
    },
  },

}