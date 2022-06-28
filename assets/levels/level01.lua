return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 3,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tilesets01",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 8,
      image = "tilesets01.png",
      imagewidth = 256,
      imageheight = 1024,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {}
    },
    {
      name = "numbers",
      firstgid = 257,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 60,
      image = "numbers.png",
      imagewidth = 1920,
      imageheight = 32,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 60,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 1,
      name = "background",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 184, 65,
        65, 25, 254, 25, 25, 25, 25, 65, 25, 182, 182, 182, 25, 65, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 25, 25, 176, 176, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 65, 25, 25, 182, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 65, 65, 25, 25, 25, 25, 65, 25, 25, 25, 65, 25, 25, 25, 25, 65, 65, 25, 25, 25, 176, 25, 65,
        65, 57, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 65, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 176, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 39, 25, 25, 65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 25, 65, 25, 25, 25, 65, 65, 65, 65,
        65, 25, 25, 25, 25, 25, 65, 252, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 65, 65, 65, 65, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 65, 25, 25, 65, 65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 65, 65,
        65, 25, 25, 25, 65, 65, 25, 65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 65, 65, 65, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 65, 25, 25, 25, 65, 65, 65, 65, 65, 65, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 65, 65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 65, 65, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 65, 65, 65, 65, 65, 25, 25, 65, 25, 25, 25, 25, 25, 25, 65,
        65, 25, 25, 25, 25, 10, 11, 12, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 65, 25, 25, 25, 25, 25, 163, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 2,
      name = "players",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 257, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 259, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
