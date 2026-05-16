local if_nil = vim.F.if_nil

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local default_header = {
    type = "text",
    val = {
        [[NN\    N| V\    V\ I\ MM\    MM\]],
        [[N/N\   N| V|    V|    M\M\  M/M|]],
        [[N| N\  N| V\    V/ I\ M| M\M/ M|]],
        [[N|  N\ N|  V\  V/  I| M|  M/  M|]],
        [[N|   N\N|   V\V/   I| M|      M|]],
        [[N|    NN/    V/    I/ M|      M|]],
        [[]],
        [[+==========-> NVIM <-==========+]],
    },
    opts = {
        position = "center",
        hl = "CursorLineNr",
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = {
      [[]],
      [[+==============================+]]
    },
    opts = {
        position = "center",
        hl = "CursorLineNr",
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 32,
        align_shortcut = "right",
        hl_shortcut = "CursorLineNr",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("w", "  New file", "<cmd>ene <CR>"),
        button("Space e", "󱇧  Edit file"),
        button("Space t", "  Toggle tree"),
        button("q", "  Exit", "<cmd>q <CR>"),
    },
    opts = {
        spacing = 0,
    },
}

local section = {
    terminal = default_terminal,
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 5 },
        section.header,
        { type = "padding", val = 1 },
        section.buttons,
        section.footer,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}
