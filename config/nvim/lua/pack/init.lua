-- Rudamentary logging, just use `vlog.nvim` and save yourself the trouble,
-- but its here if you want it
local echohl = vim.schedule_wrap(
    function(msg, hl)
        local emsg = vim.fn.escape(msg, '"')
        vim.cmd('echohl ' .. hl .. ' | echom "' .. emsg .. '" | echohl None')
    end
)

local info = function(msg) echohl(msg, 'None') end
local err = function(msg) echohl(msg, 'ErrorMsg') end

local function init(success)
    if not success then
        err('[packer]: Failed setup')
        return
    end

    info('[packer]: Loading package list')
    vim.cmd('packadd packer.nvim')

    -- Uncomment/change this depending on where you want your 'list' of packages
    -- to load from
    --
    -- This would be somewhere on your `:h runtimepath`, and would likely contain
    -- a call to `startup` provided by `packer`
    require('pack.list')
end

local function bootstrap()
    -- Bootstrap `packer` installation to manage packages
    local packer = {
        path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim',
        url = 'https://github.com/wbthomason/packer.nvim'
    }

    if vim.fn.executable('git') ~= 1 then
        err('[packer] Bootstrap failed, git not installed')
        return
    end

    if vim.fn.empty(vim.fn.glob(packer.path)) > 0 then
        info('[packer]: Installing...')

        local handle
        handle = vim.loop.spawn(
            'git',
            {
                args = {
                    'clone',
                    packer.url,
                    packer.path,
                },
            },
            vim.schedule_wrap(
                function(code, _)
                    -- Wrapper to call `init` based on the success of the above `git` operation
                    handle:close()
                    init(code == 0)
                end
            )
        )
    else
        -- `packer` already installed, continue to load package list
        init(true)
    end
end

bootstrap()
