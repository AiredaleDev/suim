-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message.' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

if vim.g.neovide then
  local normal_sf = 0.9
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_normal_opacity = 1
  vim.g.neovide_scale_factor = normal_sf

  vim.o.guifont = 'FiraCode Nerd Font'

  vim.keymap.set({ 'n', 'v' }, '<C-+>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = ' .. normal_sf .. '<CR>')
end

-- My keybinds
-- When you use Neovide, sometimes it's nice to just open it
-- from something like wofi and switch it to your desired project.

local cdmap = function(keys, folder, desc)
  vim.keymap.set('n', keys, function()
    vim.cmd.cd(folder)
    vim.notify('Switched to ' .. folder)
  end, { desc = desc })
end

local map_cd_and_open = function(keys, folder, file_in_folder, desc)
  vim.keymap.set('n', keys, function()
    vim.cmd.cd(folder)
    vim.notify('Switched to ' .. folder)
    vim.cmd.e(file_in_folder)
  end, { desc = desc })
end

cdmap('<leader>cc', '~/.config', '[C]hange directory to .[C]onfig')
map_cd_and_open('<leader>ch', '~/.config/hypr', 'hyprland.conf', '[C]onfigure [H]yprland')
map_cd_and_open('<leader>cb', '~/.config/waybar', 'config.jsonc', '[C]onfigure Way[B]ar')
map_cd_and_open('<leader>cn', '~/.config/nvim', 'init.lua', '[C]onfigure [N]vim')
-- Better yet, we can use telescope or smth to list just *folders* immediately after.
-- Good way to keep the notion of a "project directory" loose.
cdmap('<leader>cr', '~/Programs/Repos', '[C]hange directory to Programs/[R]epos')

-- Floating terminal (more useful in Neovide)
-- Is there a way to run tmux in neovide? All I want is the smooth cursor
-- and scrolling since I find it aesthetically pleasing.
local term_is_open = false
vim.keymap.set('n', '<leader>tt', function()
  vim.cmd 'HauntTerm -t scratch'
end, { desc = '[T]oggle floating [T]erminal' })

-- vim: ts=2 sts=2 sw=2 et
