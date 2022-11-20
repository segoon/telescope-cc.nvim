local actions = require 'telescope.actions'
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local state = require 'telescope.actions.state'
local util = require 'lspconfig.util'

function list_cc_files(bufnr, opts)
    exclude_paths = opts['exclude']

    name = vim.api.nvim_buf_get_name(bufnr)
    cc_json_dirpath = util.root_pattern({'compile_commands.json'})(name)
    if not cc_json_dirpath then
        error 'No compile_commands.json found.'
    end
    cc_json_filepath = cc_json_dirpath .. '/compile_commands.json'

    files = {}
    contents = vim.fn.readfile(cc_json_filepath)
    json = vim.fn.json_decode(contents)
    for i, v in ipairs(json) do
        file = v['file']
	if file then
	    for i, exclude in ipairs(exclude_paths) do
	        if string.find(file, exclude) then
	            file = nil
	            break
                end
	    end
	end

	if file then
            table.insert(files, file)
	end
    end
    return files
end

return function(_, opts)
    pickers
        .new(_, {
            prompt_title = 'Files from compile_commands.json',
            finder = finders.new_table {
                results = list_cc_files(0, opts),
            },
            sorter = sorters.get_generic_fuzzy_sorter(),
        })
        :find()
end
