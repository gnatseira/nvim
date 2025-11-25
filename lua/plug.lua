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

return require('packer').startup({function(use)
    -- [[ Plugin Go Here ]]
    use {'wbthomason/packer.nvim'}
    use {'kyazdani42/nvim-web-devicons', opt = false}
    use {                                              -- filesystem navigation
        'kyazdani42/nvim-tree.lua',
        cmd = {'NvimTreeToggle'},
        config = [[require('config.nvim-tree')]]
    }

    -- [[ Theme ]]
    use {
        'goolord/alpha-nvim',
        event = 'BufWinEnter',
        config = [[require('config.alpha-nvim')]]
    }
    use {
        'nvim-lualine/lualine.nvim',                     -- statusline
        config = [[require('config.lualine')]]
    }
    --use { 'Mofiqul/dracula.nvim' }
    use {
        'catppuccin/nvim',
        opt = false,
        as = 'catppuccin',
        commit = "f079dda3dc23450d69b4bad11bfbd9af2c77f6f3",
        config = [[require('config.catppuccin')]]
    }

    -- [[ Dev ]]
    use {
        'nvim-telescope/telescope.nvim',                 -- fuzzy finder
        config = [[require('config.telescope')]],
        requires = {
            {'nvim-lua/plenary.nvim', opt = false},
            {'nvim-lua/popup.nvim', opt = true},
        },

    }

    use {
        'nvim-telescope/telescope-fzy-native.nvim',
        opt = true,
        run = 'make',
        after = 'telescope.nvim',
    }

    use {
        'nvim-telescope/telescope-project.nvim',
        opt = true,
        after = 'telescope-fzy-native.nvim',
    }

    use {
        'nvim-telescope/telescope-frecency.nvim',
        opt = true,
        after = 'telescope-project.nvim',
        requires = { { "tami5/sqlite.lua", opt = true } },
    }

    use {
        'jvgrootveld/telescope-zoxide',
        opt = true,
        after = 'telescope-frecency.nvim',
    }

    use { 'simrat39/symbols-outline.nvim' }
    use { 'tpope/vim-fugitive' }

    use {
        'akinsho/toggleterm.nvim',
        opt = true,
        event = 'VimEnter',
        config = [[require('config.toggleterm')]]
    }
    use {'numToStr/FTerm.nvim', opt = true, event = "VimEnter"}
    use {'tpope/vim-commentary', event = 'BufWinEnter'}

    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufEnter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]]
    }

    --use {
    --   'p00f/nvim-ts-rainbow',
    --  opt = true,
    --  after = 'nvim-treesitter',
    --}

    use {'JoosepAlviste/nvim-ts-context-commentstring', opt = true, after = 'nvim-treesitter'}

    --use {
    --   'andymass/vim-matchup',
    --  opt = true,
    --  after = 'nvim-treesitter',
    --  config = [[require('config.matchup')]]
    --}

    -- mason
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim'}

    -- lspconfig
    use {
        'neovim/nvim-lspconfig',
        opt = true,
        event = 'BufEnter',
        config = [[require('config.lsp')]]
    }
    -- lspkind
    use {'onsails/lspkind-nvim', after = 'nvim-lspconfig'}

    -- nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        after = 'lspkind-nvim',
        config = [[require('config.nvim-cmp')]]
    }
    use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp'} -- { name = nvim_lsp }
    use {'hrsh7th/cmp-buffer', after = 'nvim-cmp'}   -- { name = 'buffer' },
    use {'hrsh7th/cmp-path', after = 'nvim-cmp'}     -- { name = 'path' }
    use {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}  -- { name = 'cmdline' }
    -- vsnip
    use {'hrsh7th/cmp-vsnip', after = 'nvim-cmp'}    -- { name = 'vsnip' }
    use {'hrsh7th/vim-vsnip', after = 'nvim-cmp'}
    use {'rafamadriz/friendly-snippets', after = 'nvim-cmp'}

    use {
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function() require('nvim-autopairs').setup {} end
    }

    -- bufferline
    use {
        'akinsho/bufferline.nvim',
        tag = '*',
        event = 'VimEnter',
        config = [[require('config.bufferline')]]
    }

    -- indent blankline
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'VimEnter',
        config = [[require('config.indent-blankline')]]
    }

    -- which-key
    use {
        'folke/which-key.nvim',
        opt = true,
        keys = ',',
        config = [[require('config.which-key')]]
    }

    -- nvim-notify
    use {
        'rcarriga/nvim-notify',
        opt = false,
        config = [[require('config.nvim-notify')]]
    }

    -- start time
    use {'dstein64/vim-startuptime', opt = true, cmd = 'StartupTime'}

    -- filetype
    -- use {
    --     'nathom/filetype.nvim',
    --     opt = false,
    --     config = [[require('config.filetype')]]
    -- }

    -- diffview
    use {
        'sindrets/diffview.nvim',
        opt = true,
        cmd = { "DiffviewOpen" },
    }

end,
config = {
    display = {
        open_fn = require('packer.util').float,
    },
}
})
