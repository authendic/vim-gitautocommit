
vtest:
	nvim -u test/testrc --headless +"Vader! test/*"

neattest:
	nvim -u test/testrc +"Vader! test/*"

t:
	nvim -u test/testrc +"Vader test/*"

vint:
	vint --error --verbose --enable-neovim --color --style ./autoload ./plugin
