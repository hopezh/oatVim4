return {
    "iamcco/markdown-preview.nvim",

    -- stylua: ignore
    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop",
    },

    ft = { "markdown" },

    build = function()
        vim.fn["mkdp#util#install"]()
    end,

    keys = {
        {
            "<leader>mdp",
            "<cmd>MarkdownPreviewToggle<cr>",
            desc = "toggle md file preview",
        },
    },
}
