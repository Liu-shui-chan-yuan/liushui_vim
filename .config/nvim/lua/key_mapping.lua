local map = vim.keymap

local function DefaultOpt()
    return { noremap = true, silent = true }
end

-- use c-j and c-k to navigate in cmd mode
-- don't set silent for this, completion depend on output
-- TODO add fuzzy completion for this
map.set({ 'c' }, '<c-j>', '<c-n>', { noremap = true })
map.set({ 'c' }, '<c-k>', '<c-p>', { noremap = true })
-- left and right to move cursor when wildmenu is on
map.set({ 'c' }, '<left>', '<space><bs><left>', { noremap = true })
map.set({ 'c' }, '<right>', '<space><bs><right>', { noremap = true })
map.set({ 'c' }, '<c-h>', '<left>', { noremap = false })
map.set({ 'c' }, '<c-l>', '<right>', { noremap = false })

map.set({ 'n' }, '<leader>sc', '<cmd>set spell!<cr>', DefaultOpt())
map.set({ 'n' }, '<leader><cr>', '<cmd>nohlsearch<cr>', DefaultOpt())
map.set({ 'n', 'x' }, '<leader>y', '"+y', DefaultOpt())
map.set({ 'n', 'x' }, '<leader>p', '"+p', DefaultOpt())
map.set({ 'n', 'x' }, '<leader>P', '"+P', DefaultOpt())
map.set({ 'n' }, '<leader>ya', 'mzggVG"+y`z<cmd>delmark z<cr>`', DefaultOpt())
map.set({ 'n' }, '<leader>Y', '"+y$', DefaultOpt())
map.set({ 'n' }, 'Y', 'y$', DefaultOpt())

local function autoClose()
    if #vim.api.nvim_list_tabpages() == 1 then
        local buffer = vim.api.nvim_list_bufs()
        local bufferCnt = 0
        for _, buf in ipairs(buffer) do
            if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_buf(win) == buf then
                        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
                        if not AutoCloseFileType[filetype] then
                            return
                        end
                        break
                    end
                end
                bufferCnt = bufferCnt + 1
            end
        end
        if bufferCnt ~= 0 then
            vim.cmd'qa'
        end
        return
    end
    local windows = vim.api.nvim_tabpage_list_wins(0)
    for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        if not AutoCloseFileType[filetype] then
            return
        end
    end
    vim.cmd'tabclose!'
end
function QuitNotSaveOnBuffer()
    local fileType = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")
    if AutoCloseFileType[fileType] then
        vim.cmd('q!')
        autoClose()
        return
    end
    local windows = vim.api.nvim_tabpage_list_wins(0)
    local tabCnt = #vim.api.nvim_list_tabpages()
    local visibleBufCntCurrentTab = 0
    for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            visibleBufCntCurrentTab = visibleBufCntCurrentTab + 1
        end
    end
    local buffer = vim.api.nvim_list_bufs()
    local bufferCnt = 0
    for _, buf in ipairs(buffer) do
        if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
            bufferCnt = bufferCnt + 1
        end
    end
    if tabCnt == 1 and visibleBufCntCurrentTab == 1 and bufferCnt > 1 then
        pcall(require("bufdelete").bufdelete, 0, true)
    else
        vim.cmd('q!')
    end
    autoClose()
end
function QuitSaveOnBuffer()
    vim.cmd('w')
    QuitNotSaveOnBuffer()
end
map.set({ 'n' }, 'Q', QuitNotSaveOnBuffer, DefaultOpt())
map.set({ 'n' }, 'S', QuitSaveOnBuffer, DefaultOpt())
map.set({ 'n' }, '<c-s>', '<cmd>w<cr>', DefaultOpt())
map.set({ 'i' }, '<c-s>', '<c-o><cmd>w<cr>', DefaultOpt())

map.set({ 'n' }, '<leader>h', '<cmd>set nosplitright<cr><cmd>vsplit<cr><cmd>set splitright<cr>', DefaultOpt())
map.set({ 'n' }, '<leader>l', '<cmd>set splitright<cr><cmd>vsplit<cr>', DefaultOpt())
map.set({ 'n' }, '<leader>t', '<cmd>tabnew<cr>', DefaultOpt())
-- No need this, this has been done by tmux navigator
-- map.set({ 'n' }, '<c-j>', '<c-w>j', DefaultOpt())
-- map.set({ 'n' }, '<c-k>', '<c-w>k', DefaultOpt())
-- map.set({ 'n' }, '<c-h>', '<c-w>h', DefaultOpt())
-- map.set({ 'n' }, '<c-l>', '<c-w>l', DefaultOpt())
map.set({ 'n' }, '<leader>J', '<c-w>J', DefaultOpt())
map.set({ 'n' }, '<leader>K', '<c-w>K', DefaultOpt())
map.set({ 'n' }, '<leader>H', '<c-w>H', DefaultOpt())
map.set({ 'n' }, '<leader>L', '<c-w>L', DefaultOpt())
map.set({ 'n' }, '<leader>T', '<c-w>T', DefaultOpt())

map.set({ 'n' }, '<leader>b', '<cmd>BufferLineCyclePrev<cr>', DefaultOpt())
map.set({ 'n' }, '<leader>n', '<cmd>BufferLineCycleNext<cr>', DefaultOpt())
map.set({ 'n' }, "gp", "<cmd>BufferLinePick<CR>", DefaultOpt())
map.set({ 'n' }, '<leader>1', '1gt', DefaultOpt())
map.set({ 'n' }, '<leader>2', '2gt', DefaultOpt())
map.set({ 'n' }, '<leader>3', '3gt', DefaultOpt())
map.set({ 'n' }, '<leader>4', '4gt', DefaultOpt())
map.set({ 'n' }, '<leader>5', '5gt', DefaultOpt())
map.set({ 'n' }, '<leader>6', '6gt', DefaultOpt())
map.set({ 'n' }, '<leader>7', '7gt', DefaultOpt())
map.set({ 'n' }, '<leader>8', '8gt', DefaultOpt())
map.set({ 'n' }, '<leader>9', '9gt', DefaultOpt())
map.set({ 'n' }, '<leader>gb','10gt', DefaultOpt())
-- vim.keymap.set({"v", "n"}, "g<Tab>", "<cmd>BufferLineTogglePin<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "g<BS>", "<cmd>bdelete<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "go", "<cmd>blast<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "gO", "<cmd>bfirst<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "gB", "<cmd>BufferLineMovePrev<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "gT", "<cmd>BufferLineMoveNext<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "g<S-Tab>", "<cmd>BufferLineCloseOthers<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "g<C-b>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
-- vim.keymap.set({"v", "n"}, "g<C-t>", "<cmd>BufferLineCloseRight<CR>", { silent = true })
--
-- vim.keymap.set({"v", "n", "i"}, "<F1>", "<cmd>BufferLineTogglePin<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<F13>", "<cmd>BufferLinePickClose<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<F14>", "<cmd>BufferLineMovePrev<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<F15>", "<cmd>BufferLineMoveNext<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<C-F13>", "<cmd>BufferLineCloseOthers<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<C-F14>", "<cmd>BufferLineCloseLeft<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<C-F15>", "<cmd>BufferLineCloseRight<CR>", { silent = true })

map.set({ 'n' }, 'j', [[(v:count == 0 ? 'gj' : 'j')]], { expr = true, noremap = true, silent = true })
map.set({ 'n' }, 'k', [[(v:count == 0 ? 'gk' : 'k')]], { expr = true, noremap = true, silent = true })
map.set({ 'n' }, '0', [[(v:count == 0 ? 'g0' : '0')]], { expr = true, noremap = true, silent = true })
map.set({ 'n' }, '$', [[(v:count == 0 ? 'g$' : '$')]], { expr = true, noremap = true, silent = true })

map.set({ 'n' }, '<up>', '<cmd>res +5<cr>', DefaultOpt())
map.set({ 'n' }, '<down>', '<cmd>res -5<cr>', DefaultOpt())
map.set({ 'n' }, '<left>', '<cmd>vertical resize -5<cr>', DefaultOpt())
map.set({ 'n' }, '<right>', '<cmd>vertical resize +5<cr>', DefaultOpt())

map.set({ 'v' }, 'J', '<cmd>m \'>+1<CR>gv=gv', DefaultOpt())
map.set({ 'v' }, 'K', '<cmd>m \'<-2<CR>gv=gv', DefaultOpt())

map.set({ 'n' }, '[g', '<Plug>(coc-git-prevchunk)', DefaultOpt())
map.set({ 'n' }, ']g', '<Plug>(coc-git-nextchunk)', DefaultOpt())
map.set({ 'n' }, '[c', '<Plug>(coc-git-prevconflict)', DefaultOpt())
map.set({ 'n' }, ']c', '<Plug>(coc-git-nextconflict)', DefaultOpt())
map.set({ 'n' }, '<leader>gdf', '<Plug>(coc-git-chunkinfo)', DefaultOpt())
map.set({ 'n' }, '[d', '<Plug>(coc-diagnostic-prev)', DefaultOpt())
map.set({ 'n' }, ']d', '<Plug>(coc-diagnostic-next)', DefaultOpt())
map.set({ 'n' }, 'gd', '<Plug>(coc-definition)', DefaultOpt())
map.set({ 'n' }, 'gr', '<Plug>(coc-references)', DefaultOpt())
map.set({ 'n' }, 'gi', '<Plug>(coc-implementation)', DefaultOpt())
map.set({ 'n' }, 'gh', '<cmd>CocCommand clangd.switchSourceHeader<CR>', DefaultOpt())
map.set({ 'n' }, '<leader>R', '<Plug>(coc-rename)', DefaultOpt())
map.set({ 'n' }, 'gl', ':<C-u>CocList<space>', { noremap = true })
map.del({ 'n' }, 'gcc')
map.set({ 'n' }, 'gc', ':<C-u>CocList commands<CR>', DefaultOpt())
map.set({ 'n' }, 'H', '<Plug>(coc-fix-current)', DefaultOpt())
map.set({ 'n' }, '<leader>i', ':<C-u>CocCommand document.toggleInlayHint<CR>', DefaultOpt())
function CocShowDocument()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
map.set({ 'n' }, '<leader>d', CocShowDocument, DefaultOpt())
map.set({ 'n' }, 'gy', ':<C-u>CocList -A --normal yank<CR>', DefaultOpt())
-- Remap for do codeAction of selected region
-- function! s:cocActionsOpenFromSelected(type) abort
--   execute 'CocCommand actions.open ' . a:type
-- endfunction
-- xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
-- nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

vim.cmd [[
function! CopilotVisible()
    let s = copilot#GetDisplayedSuggestion()
    if !empty(s.text)
        return 1
    endif
    return 0
endfunction
]]
function SelectOneWordForCopilot()
    if vim.fn['CopilotVisible']() ~= 0 then
        return vim.fn['copilot#AcceptWord']()
    else
        return vim.api.nvim_input('<esc>f')
    end
end
function SelectOneLineForCopilotOrLiveGrep()
    if vim.fn['CopilotVisible']() ~= 0 then
        return vim.fn['copilot#AcceptLine']()
    else
        return LiveGrepOnRootDirectory()
    end
end

map.set({ 'i' }, '<esc>f', SelectOneWordForCopilot, DefaultOpt())
map.set({ 'i' }, '<c-f>', SelectOneLineForCopilotOrLiveGrep, DefaultOpt())
-- imap <script><silent><expr> <ESC>f CopilotVisible() ? copilot#AcceptWord() : "\<ESC>f"

function GetRootDirectory()
    local rootDir = vim.fn.finddir(".root", ";")
    if rootDir ~= "" then
        return rootDir
    else
        local gitDir = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
        if gitDir ~= "" and vim.fn.filereadable(gitDir) then
            return gitDir:sub(1, -2)
        else
            return vim.fn.getcwd()
        end
    end
end
function HasRootDirectory()
    local rootDir = vim.fn.finddir(".root", ";")
    if rootDir ~= "" then
        return true
    else
        local gitDir = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
        if gitDir ~= "" and vim.fn.filereadable(gitDir) then
            return true
        else
            return false
    end
end
end
function NvimTreeToggleOnRootDirectory()
    require('nvim-tree.api').tree.toggle({
        path = GetRootDirectory(),
        update_root = false,
        find_file = false,
        focus = true,
    })
end
local function OpenNvimTreeOnStart(data)
    -- buffer is a real file on the disk
    local nameFile = vim.fn.filereadable(data.file) == 1

    -- buffer is a [No Name]
    local noName = data.file == "" and vim.bo[data.buf].buftype == ""

    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- with no parameter or a file, then open nvim-tree on root directory, but do not focus
    if HasRootDirectory() and (nameFile or noName) then
        -- open the tree, find the file but don't focus it
        require('nvim-tree.api').tree.toggle({
            path = GetRootDirectory(),
            update_root = false,
            find_file = false,
            focus = false,
        })
    elseif directory then
        require('nvim-tree.api').tree.toggle({
            path = data.file,
            update_root = false,
            find_file = false,
            focus = true,
        })
    end
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = OpenNvimTreeOnStart })

vim.cmd[[
func! CompileRun()
    write
    if &filetype == 'c'
        !clear; gcc -g -Wall % -o %<.out && echo RUNNING && time ./%<.out
    elseif &filetype == 'cpp'
        !clear; g++ -g -Wall -std=c++17 % -o %<.out && echo RUNNING && time ./%<.out
    elseif &filetype == 'java'
        !clear; javac % && echo RUNNING && time java %<
    elseif &filetype == 'sh'
        !clear; time ./%
    elseif &filetype == 'python'
        !clear; time python3 %
    elseif &filetype == 'html'
        !wslview % &
    elseif &filetype == 'markdown'
        MarkdownPreviewToggle
    elseif &filetype == 'vimwiki'
        MarkdownPreviewToggle
    endif
endfunc
nnoremap <LEADER>r :call CompileRun()<CR>
]]

-- I don't know which plugin bind these two, this makes <c-w> slow
map.del({ 'n' }, '<c-w>d')
map.del({ 'n' }, '<c-w><c-d>')
map.set({ 'n' }, '<c-w>', '<cmd>AerialToggle<cr>', DefaultOpt())
map.set({ 'i' }, '<c-w>', '<esc><cmd>AerialToggle<cr>', DefaultOpt())

map.set({ 'n' }, '<c-e>', NvimTreeToggleOnRootDirectory, DefaultOpt())
map.set({ 'i' }, '<c-e>', NvimTreeToggleOnRootDirectory, DefaultOpt())
vim.cmd[[
set pumheight=30
nnoremap <leader>gcm <Plug>(coc-git-commit)
inoremap <silent><expr> <C-j>
        \ coc#pum#visible() ? coc#pum#next(1) :
        \ CopilotVisible() ? copilot#Next() : "\<Down>"
inoremap <silent><expr> <C-k>
        \ coc#pum#visible() ? coc#pum#prev(1) :
        \ CopilotVisible() ? copilot#Previous() : "\<Up>"
]]
-- set nobackup
-- set nowritebackup

vim.cmd[[
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CopilotVisible() ? copilot#Accept() : "\<CR>"
autocmd FileType vimwiki inoremap <silent><buffer><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
              \: CopilotVisible() ? copilot#Accept() : "\<C-]>\<Esc>:VimwikiReturn 3 5\<CR>"
autocmd FileType vimwiki inoremap <silent><buffer> <S-CR>
              \ <Esc>:VimwikiReturn 2 2<CR>
autocmd Filetype vimwiki nnoremap <LEADER>wh :VimwikiAll2HTML<CR>
]]
vim.cmd[[
inoremap <silent><expr> <C-c>
            \ coc#pum#visible() ? coc#pum#cancel() :
            \ CopilotVisible() ? copilot#Dismiss() : "\<C-c>"
]]

local success, telescope = pcall(require, 'telescope.builtin')
function FindFilesOnRootDirectory()
    local rootDir = GetRootDirectory()
    telescope.find_files({search_dirs = {rootDir}, hidden = true})
end
function LiveGrepOnRootDirectory()
    local rootDir = GetRootDirectory()
    telescope.live_grep({search_dirs = {rootDir}, additional_args = {'--hidden'}})
end
if success then
    vim.keymap.set({ 'n', 'i' }, '<c-p>', FindFilesOnRootDirectory, DefaultOpt())
    vim.keymap.set({ 'n' }, '<c-f>', LiveGrepOnRootDirectory, DefaultOpt())
    vim.keymap.set({ 'n' }, '<leader><leader>', telescope.current_buffer_fuzzy_find, DefaultOpt())
--     vim.keymap.set({ 'n' }, '<leader>fb', telescope.buffers, DefaultOpt())
--     vim.keymap.set({ 'n' }, '<leader>fh', telescope.help_tags, DefaultOpt())
end

vim.cmd [[
" find next placeholder and remove it.
autocmd Filetype markdown inoremap<buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype gitcommit inoremap<buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l

" bold
autocmd Filetype markdown inoremap<buffer> ,b ****<++><Esc>F*hi
autocmd Filetype gitcommit inoremap<buffer> ,b ****<++><Esc>F*hi

" italic
autocmd Filetype markdown inoremap<buffer> ,i **<++><Esc>F*i
autocmd Filetype gitcommit inoremap<buffer> ,i **<++><Esc>F*i

" for code blocks
autocmd Filetype markdown inoremap<buffer> ,c <CR><CR>```<CR>```<CR><CR><++><Esc>3kA
autocmd Filetype gitcommit inoremap<buffer> ,c <CR><CR>```<CR>```<CR><CR><++><Esc>3kA

" for pictures, mostly, we don't add pictures' descriptions
autocmd Filetype markdown inoremap<buffer> ,p <CR><CR>![]()<CR><CR><++><Esc>2k0f(a
autocmd Filetype gitcommit inoremap<buffer> ,p <CR><CR>![]()<CR><CR><++><Esc>2k0f(a

" for for links <a> are html links tag, so we use ,a
autocmd Filetype markdown inoremap<buffer> ,a [](<++>)<++><Esc>F[a
autocmd Filetype gitcommit inoremap<buffer> ,a [](<++>)<++><Esc>F[a

" for headers
autocmd Filetype markdown inoremap<buffer> ,1 #<Space>
autocmd Filetype gitcommit inoremap<buffer> ,1 #<Space>
autocmd Filetype markdown inoremap<buffer> ,2 ##<Space>
autocmd Filetype gitcommit inoremap<buffer> ,2 ##<Space>
autocmd Filetype markdown inoremap<buffer> ,3 ###<Space>
autocmd Filetype gitcommit inoremap<buffer> ,3 ###<Space>
autocmd Filetype markdown inoremap<buffer> ,4 ####<Space>
autocmd Filetype gitcommit inoremap<buffer> ,4 ####<Space>

" delete lines
autocmd Filetype markdown inoremap<buffer> ,d ~~~~<++><Esc>F~hi
autocmd Filetype gitcommit inoremap<buffer> ,d ~~~~<++><Esc>F~hi

" tilde
autocmd Filetype markdown inoremap<buffer> ,t ``<++><Esc>F`i
autocmd Filetype gitcommit inoremap<buffer> ,t ``<++><Esc>F`i

" math formulas
autocmd Filetype markdown inoremap<buffer> ,M <CR><CR>$$<CR><CR>$$<CR><CR><++><Esc>3kA
autocmd Filetype gitcommit inoremap<buffer> ,M <CR><CR>$$<CR><CR>$$<CR><CR><++><Esc>3kA

" math formulas in line
autocmd Filetype markdown inoremap<buffer> ,m $$<++><Esc>F$i
autocmd Filetype gitcommit inoremap<buffer> ,m $$<++><Esc>F$i

" newline but not new paragraph
autocmd FileType markdown inoremap<buffer> ,n <br><CR>
autocmd FileType gitcommit inoremap<buffer> ,n <br><CR>

autocmd FileType gitcommit set cc=50,72
]]
