# :telescope: telescope-cc.nvim

Locate source files from "compile_commands.json" file

# Installation

## Vim-Plug

```viml
Plug 'segoon/telescope-cc'
```

# Setup and configuration

```lua
require('telescope').setup {
    extensions = {
        cc_json = {
	    -- Filepath with these substrings is skipped
            exclude = {
	        '/contrib/',
	        '/library/cpp',
	        '/library/python',
	        '/external/',
	    },
        },
    },
}

require('telescope').load_extension('cc')
```

# Usage

`:Telescope cc`

`nnoremap <leader>fc <cmd>Telescope cc<cr>`
