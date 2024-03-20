require(jpeg)
require(tidyverse)
#img <- as.raster(readJPEG("thing.jpg"))
#plot(c(1, 450), c(1, 700), type = "n", xlab = "", ylab = "")
#rasterImage(img, 50, 800, 400, 50, interpolate=FALSE, angle=0)

#0 = nothing, 1 = skin, 2 = red, 3 = black hair
M <- tibble(v1 = seq(from=0, to=0, length.out=30), v2 = seq(from=0, to=0, length.out=30),
            v3 = seq(from=0, to=0, length.out=30), v4 = c(seq(from=0, to=0, length.out=21), seq(from=1, to=1, length.out=9)),
            v5 = c(seq(from=0, to=0, length.out=20), seq(from=1, to=1, length.out=10)), v6 = c(seq(from=0, to=0, length.out=20), seq(from=2, to=2, length.out=10)),
            v7 = c(seq(from=0, to=0, length.out=16), seq(from=3, to=3, length.out=4), seq(from=2, to=2, length.out=10)),
            v8 = c(seq(from=0, to=0, length.out=12), seq(from=3, to=3, length.out=8), seq(from=2, to=2, length.out=10)),
            v9 = c(seq(from=0, to=0, length.out=8), seq(from=3, to=3, length.out=11), 1, seq(from=2, to=2, length.out=10)),
            v10 = c(seq(from=0, to=0, length.out=7), 3, 3, seq(from=1,to=1,length.out=12), seq(from=2, to=2, length.out=9)),
            v11 = c(seq(from=0, to=0, length.out=6), 3, 3, seq(from=1,to=1,length.out=13), seq(from=2, to=2, length.out=9)),
            v12 = c(seq(from=0, to=0, length.out=6), 3, 3, seq(from=1,to=1,length.out=13), seq(from=2, to=2, length.out=9)),
            v13 = c(seq(from=0, to=0, length.out=6), 3, 3, seq(from=1,to=1,length.out=13), seq(from=2, to=2, length.out=9)),
            v14 = c(seq(from=0, to=0, length.out=7), 3, 3, seq(from=1,to=1,length.out=12), seq(from=2, to=2, length.out=9)),
            v15 = c(seq(from=0, to=0, length.out=8), seq(from=3, to=3, length.out=11), 1, seq(from=2, to=2, length.out=10)))

#dark hair, light hair, skin bottom, red, blue, grey, skin top
M <- tibble(x = 1:42, skin_bottom = c(0, 0, 0, 9, 10, 0, 0, 0, 11, 21, 22, 22, 22, 21, 11, 11, 0, 0, 10, 9, 0, 0, 575, 546, 24, 23, 22, 0, 0, 0, 0, 0, 0, 0, 2, 512, 454, 425, 423, 0, 0, 0),
            skin_top = c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 10, 126, 184, 0, 0, 0, 0, 3, 34, 67, 129, 216, 332, 0),
            red = c(0, 0, 0, 0, 0, 10, 10, 10, 10, 9, 9, 9, 9, 9, 10, 10, 11, 11, seq(from=0,to=0,length.out=24)),
            blue = c(seq(from=0,to=0,length.out=21), 1, 4, 14, 18, 18, 19, 20, 20, 18, 17, 16, 16, 11, seq(from=0,to=0,length.out=8)),
            grey = c(seq(from=0,to=0,length.out=35), 11, 11, 13, 14, 14, 14, 14),
            dark_hair = c(0, 0, 0, 0, 0, 0, 14, 18, 22, 23, 24, 24, 24, 23, 22, 20, 15, 14, seq(from=0,to=0,length.out=17), 21, 21, 20, 20, 19, 19, 0),
            light_hair = c(seq(from=0,to=0,length.out=22), 745, 745, 745, 715, 595, 623, seq(from=0,to=0,length.out=14)))
x <- 1:42
ggplot(M) +
  geom_ribbon(mapping = aes(x = x, ymin=light_hair%/%30, ymax=light_hair%%30), outline.type="full", show.legend=FALSE)
#see geom_polygon
