vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")

require("conform").formatters.biome = {
  condition = function(self, ctx)
    return vim.fs.find({ "biome.json", "biome.jsonc" }, { path = ctx.filename, upward = true })[1]
  end,
}

require("conform").formatters.prettierd = {
  condition = function(self, ctx)
    return vim.fs.find({ ".prettierrc", ".prettierrc.json", ".prettierrc.js", "prettier.config.js", "prettier.config.mjs" }, { path = ctx.filename, upward = true })[1]
  end,
}
