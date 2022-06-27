-- [[ plug.lua ]]

-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	if vim.fn.input("Hent packer.nvim? (y for yada)") ~= "y" then
		return
	end

	local directory = string.format(
	'%s/site/pack/packer/opt/',
	vim.fn.stdpath('data')
	)

	vim.fn.mkdir(directory, 'p')

	local git_clone_cmd = vim.fn.system(string.format(
	'git clone %s %s',
	'https://github.com/wbthomason/packer.nvim',
	directory .. '/packer.nvim'
	))

	print(git_clone_cmd)
	print("Henter packer.nvim...")

	return
end

return require('packer').startup(function(use)
    -- [[ Plugin Go Here ]]
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}
    use {'wbthomason/packer.nvim'}
    use {                                              -- filesystem navigation
        'kyazdani42/nvim-tree.lua',
        requires = {'kyazdani42/nvim-web-devicons',        -- filesystem icons
                    opt = true},
        cmd = {"NvimTreeToggle"},
        config = [[require('config.nvim-tree')]]
    }

    -- [[ Theme ]]
    --use {'mhinz/vim-startify'}
    use {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        config = [[require('config.alpha-nvim')]]
    }
    use {
        'nvim-lualine/lualine.nvim',                     -- statusline
        requires = {'kyazdani42/nvim-web-devicons',
                    opt = true},
        event = 'VimEnter',
        config = [[require('config.lualine')]]
    }
    use { 'Mofiqul/dracula.nvim' }

    -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',                 -- fuzzy finder
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { 'majutsushi/tagbar' }
    use { 'tpope/vim-fugitive' }
    use { 'junegunn/gv.vim' }
    use {
        "windwp/nvim-autopairs",
        event = "BufEnter",
        config = function() require("nvim-autopairs").setup {} end
    }

    use {'voldikss/vim-floaterm'}
    use {'tpope/vim-commentary'}
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }

    -- lspconfig
    use {'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer'}
    --use{'williamboman/nvim-lsp-installer'}
    --use {'neovim/nvim-lspconfig', event = "VimEnter", config = [[require('config.lsp')]]}
    -- lspkind
    use {'onsails/lspkind-nvim', event = "VimEnter"}

    -- nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        after = "lspkind-nvim",
        config = [[require('config.nvim-cmp')]]
    }
    use {'hrsh7th/cmp-nvim-lsp', after = "nvim-cmp"} -- { name = nvim_lsp }
    use {'hrsh7th/cmp-buffer', after = "nvim-cmp"}   -- { name = 'buffer' },
    use {'hrsh7th/cmp-path', after = "nvim-cmp"}     -- { name = 'path' }
    use {'hrsh7th/cmp-cmdline', after = "nvim-cmp"}  -- { name = 'cmdline' }
    -- vsnip
    use {'hrsh7th/cmp-vsnip', after = "nvim-cmp"}    -- { name = 'vsnip' }
    use {'hrsh7th/vim-vsnip', after = "nvim-cmp"}
    use {'rafamadriz/friendly-snippets', after = "nvim-cmp"}

    use({
        "akinsho/bufferline.nvim",
        event = "VimEnter",
        config = [[require('config.bufferline')]]
    })

end)
