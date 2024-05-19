echo "vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.o.packpath = vim.o.runtimepath
vim.cmd('source ~/.vimrc')

local api = vim.api

-- Only setup gnvim when it attaches.
api.nvim_create_autocmd({'UIEnter'}, {
  callback = function(event)
    local chanid = vim.v.event['chan']
    local chan = vim.api.nvim_get_chan_info(chanid)
    if chan.client and chan.client.name ~= 'gnvim' then
      return
    end

    -- Gnvim brings its own runtime files.
    local gnvim = require('gnvim')

    -- Set the font
    vim.opt.guifont = 'Blex Mono Nerd Font 14'

    -- Increase/decrease font.
    vim.keymap.set('n', '<c-+>', function() gnvim.font_size(1) end)
    vim.keymap.set('n', '<c-->', function() gnvim.font_size(-1) end)
  end
})

-- if exists('g:GtkGuiLoaded')
  -- some code here
-- endif

--require(\"alpha\").setup {require'alpha.themes.dashboard'.config}

" > ~/.config/nvim/init.lua 
nvim -c "PlugInstall | PlugUpdate | PlugUpgrade | qa"
nvim -c "CocInstall coc-pyright | qa"
nvim -c "CocInstall coc-json | qa"
