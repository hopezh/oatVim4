return {
    "lukas-reineke/virt-column.nvim",

    ----------------------------------------------------------------------------
    config = function()
        require("virt-column").setup({
            -- char = "║",
            -- char = "|",
            char = "│",
            -- char = "▏",
        })
    end,
}
