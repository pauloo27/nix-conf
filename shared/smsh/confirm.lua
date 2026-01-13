require("helpers")
require("wrapper")

load_stylesheet("./style.css")

confirm({
	message = "Are you sure",
	tooltip = "Sure????",
	present = true,
	exit_on_close = true,
})
