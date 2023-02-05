require("core.options")
require("core.lazy")
require("core.autocommands")
require("core.keymaps")
require("config.bufferline")
require("config.snip")
local format_onsave = true
if format_onsave then
	require("core.format_onsave")
end
