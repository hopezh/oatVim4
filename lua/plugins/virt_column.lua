return {
    "lukas-reineke/virt-column.nvim",
    enabled = false,
    ----------------------------------------------------------------------------
    config = function()
        require("virt-column").setup({
            -- char = ".",
            -- char = "║",
            -- char = "|",
            -- char = "│",
            -- char = "▏",
        })
    end,
}
