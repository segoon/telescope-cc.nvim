local ok, telescope = pcall(require, 'telescope')

if not ok then
    error 'Install nvim-telescope/telescope.nvim to use segoon/telescope-cc.nvim.'
end

local default_opts = { exclude = {} }
local opts = {}
local list = require 'telescope._extensions.cc.list'

return telescope.register_extension {
    setup = function(cc_json_opts, xx)
        opts = vim.tbl_extend('force', default_opts, cc_json_opts)
    end,
    exports = {
        cc = function(_) list(_, opts) end,
    },
}
