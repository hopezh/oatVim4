return {
    "lukas-reineke/headlines.nvim",

    opts = function()
        local opts = {}
        for _, ft in ipairs({ "markdown", "quarto", "norg", "rmd", "org" }) do
            opts[ft] = {
                headline_highlights = {},
            }
            for i = 1, 6 do
                local hl = "Headline" .. i
                vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
                table.insert(opts[ft].headline_highlights, hl)
            end
        end
        return opts
    end,

    ft = { "markdown", "quarto", "norg", "rmd", "org" },

    config = function(_, opts)
        -- PERF: schedule to prevent headlines slowing down opening a file
        vim.schedule(function()
            require("headlines").setup(opts)
            require("headlines").refresh()
        end)

        -- highlight color for headlines.nvim ----------------------------------
        -- vim.cmd([[highlight Headline1 guibg=#c5c5c5 guifg=#000000]])
        vim.cmd([[highlight Headline1 guibg=#999999 guifg=#000000]])
        vim.cmd([[highlight Headline2 guibg=#777777 guifg=#000000]])
        vim.cmd([[highlight Headline3 guibg=#555555 guifg=#000000]])
        -- vim.cmd([[highlight Headline4 guibg=#808080 guifg=#000000]])
        -- vim.cmd([[highlight Headline5 guibg=#696969 guifg=#000000]])
        -- vim.cmd([[highlight Headline6 guibg=#525252 guifg=#000000]])
        vim.cmd([[highlight CodeBlock guibg=#252525]])
        -- vim.cmd([[highlight Dash guibg=#202020 gui=bold]])

        -- custom config for each file types -----------------------------------
        require("headlines").setup({
            quarto = {
                query = vim.treesitter.query.parse(
                    "markdown",
                    [[
                                (atx_heading [
                                    (atx_h1_marker)
                                    (atx_h2_marker)
                                    (atx_h3_marker)
                                    (atx_h4_marker)
                                    (atx_h5_marker)
                                    (atx_h6_marker)
                                ] @headline)

                                (thematic_break) @dash

                                (fenced_code_block) @codeblock

                                (block_quote_marker) @quote
                                (block_quote (paragraph (inline (block_continuation) @quote)))
                            ]]
                ),

                treesitter_language = "markdown",
                headline_highlights = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                fat_headline_upper_string = "",
                fat_headline_lower_string = "",
            },

            markdown = {
                query = vim.treesitter.query.parse(
                    "markdown",
                    [[
                                (atx_heading [
                                    (atx_h1_marker)
                                    (atx_h2_marker)
                                    (atx_h3_marker)
                                    (atx_h4_marker)
                                    (atx_h5_marker)
                                    (atx_h6_marker)
                                ] @headline)

                                (thematic_break) @dash

                                (fenced_code_block) @codeblock

                                (block_quote_marker) @quote
                                (block_quote (paragraph (inline (block_continuation) @quote)))
                            ]]
                ),

                -- headline_highlights = { "Headline" },
                headline_highlights = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                },

                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                -- fat_headline_upper_string = "▃",
                -- fat_headline_lower_string = "🬂",
                fat_headline_upper_string = "",
                fat_headline_lower_string = "",
            },

            rmd = {
                query = vim.treesitter.query.parse(
                    "markdown",
                    [[
                                (atx_heading [
                                    (atx_h1_marker)
                                    (atx_h2_marker)
                                    (atx_h3_marker)
                                    (atx_h4_marker)
                                    (atx_h5_marker)
                                    (atx_h6_marker)
                                ] @headline)

                                (thematic_break) @dash

                                (fenced_code_block) @codeblock

                                (block_quote_marker) @quote
                                (block_quote (paragraph (inline (block_continuation) @quote)))
                            ]]
                ),
                treesitter_language = "markdown",
                headline_highlights = { "Headline" },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "🬂",
            },

            norg = {
                query = vim.treesitter.query.parse(
                    "norg",
                    [[
                                [
                                    (heading1_prefix)
                                    (heading2_prefix)
                                    (heading3_prefix)
                                    (heading4_prefix)
                                    (heading5_prefix)
                                    (heading6_prefix)
                                ] @headline

                                (weak_paragraph_delimiter) @dash
                                (strong_paragraph_delimiter) @doubledash

                                ((ranged_tag
                                    name: (tag_name) @_name
                                    (#eq? @_name "code")
                                ) @codeblock (#offset! @codeblock 0 0 1 0))

                                (quote1_prefix) @quote
                            ]]
                ),
                headline_highlights = { "Headline" },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                doubledash_highlight = "DoubleDash",
                doubledash_string = "=",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "🬂",
            },

            org = {
                query = vim.treesitter.query.parse(
                    "org",
                    [[
                                (headline (stars) @headline)

                                (
                                    (expr) @dash
                                    (#match? @dash "^-----+$")
                                )

                                (block
                                    name: (expr) @_name
                                    (#eq? @_name "SRC")
                                ) @codeblock

                                (paragraph . (expr) @quote
                                    (#eq? @quote ">")
                                )
                            ]]
                ),
                headline_highlights = { "Headline" },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                dash_string = "-",
                quote_highlight = "Quote",
                quote_string = "┃",
                fat_headlines = true,
                fat_headline_upper_string = "▃",
                fat_headline_lower_string = "🬂",
            },
        })
    end,
}
