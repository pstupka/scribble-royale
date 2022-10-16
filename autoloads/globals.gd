extends Node

enum COLOR {WHITE, DEFAULT}

var COLORS: Dictionary = {
	"Black": Color("2a2a2a"),
	"White": Color("ffffff"),
	"Purple": Color("9179ff"),
	"Red": Color("fc5c65"),
	"Green": Color("37d98c"),
	"Yellow": Color("ffb600"),
	"Grey": Color("c9c9c9")
}

var color_palette_vinik_24: Array = [ # This seems ok
	Color("c5ccb8"),
	Color("7ca1c0"),
	Color("6f6776"),
	Color("9a9a97"),
	Color("8b5580"),
	Color("c38890"),
	Color("a593a5"),
	Color("666092"),
	Color("9a4f50"),
	Color("c28d75"),
	Color("416aa3"),
	Color("8d6268"),
	Color("be955c"),
	Color("68aca9"),
	Color("387080"),
	Color("6e6962"),
	Color("93a167"),
	Color("6eaa78"),
	Color("557064"),
	Color("9d9f7f"),
	Color("7e9e99"),
	Color("5d6872"),
]

var color_palette_sweetie_16: Array = [
	Color("f4f4f4"),
	Color("94b0c2"),
	Color("41a6f6"),
	Color("73eff7"),
	Color("566c86"),
#	Color("1a1c2c"),
	Color("5d275d"),
	Color("b13e53"),
	Color("ef7d57"),
	Color("ffcd75"),
	Color("a7f070"),
	Color("38b764"),
	Color("257179"),
	Color("29366f"),
	Color("3b5dc9"),
	Color("333c57"),
]  

var color_palette_CC_29: Array = [
	Color("f2f0e5"),# white
	Color("b8b5b9"),# default
	Color("868188"),
	Color("4b80ca"),
	Color("68c2d3"),
	Color("a2dcc7"),
	Color("ede19e"),
	Color("d3a068"),
	Color("b45252"),
	Color("a77b5b"),
	Color("e5ceb4"),
	Color("c2d368"),
	Color("8ab060"),
	Color("567b79"),
	Color("b2b47e"),
	Color("edc8c4"),
	Color("cf8acb"),
]

var color_palette_vexed_paper_pixels: Array = [
	Color("eee1c4"),# white
	Color("c3b797"),# default
	Color("e6d9bd"), 
	Color("dbcfb1"),
	Color("d6c7a3"),
	Color("ada387"),
	Color("cc9970"),
	Color("a97e5c"),
	Color("937b6a"),
	Color("a0a0a0"),
	Color("838383"),
	Color("9eb5c0"),
	Color("839ca9"),
	Color("6d838e"),
	Color("c87e7e"),
	Color("a05e5e"),
	Color("b089ab"),
	Color("8e6d89"),
	Color("b9ab73"),
	Color("978c63"),
	Color("87a985"),
	Color("6f8b6e"),
]


var color_palette_vexed_chroma_noir: Array = [
	Color("d9d9d9"),# white
	Color("828282"),# default
	Color("4f4f4f"),
	Color("383838"),
	Color("0d0d0d"),
	Color("b5b5b5"),
	Color("4c2712"),
	Color("60361d"),
	Color("a86437"),
	Color("e67a30"),
	Color("4ae364"),
	Color("99e550"),
	Color("d151ee"),
	Color("f873e4"),
	Color("9c3a2b"),
	Color("e64e35"),
	Color("f25a5a"),
	Color("ad8830"),
	Color("f7c756"),
	Color("306082"),
	Color("639bff"),
	Color("4dcced"),
]

const COLORS_ARRAY_FIRST_ATTEMPT: Array = [
	Color("9179ff"),
	Color("fc5c65"),
	Color("37d98c"),
	Color("ffb600"),
	Color("56cbf9"),
	Color("8ee3ef"),
	Color("5286ff"),
	Color("aa46db"),
	Color("db46d1"),
	Color("d9c73d"),
	Color("ff78c2"),
	Color("5fd936"),
]

var color_palette = color_palette_vinik_24
