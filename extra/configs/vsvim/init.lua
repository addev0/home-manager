
-- local in_vscode = vim.g.vscode ~= nil
--     or (vim.env.VSCODE_PID and tonumber(vim.env.VSCODE_PID))
--     or vim.env.VSCODE_CWD ~= nil
--     or vim.env.VSCODE_IPC_HOOK_CLI ~= nil
--     or vim.env.TERM_PROGRAM == "vscode"


if vim.g.vscode then
    local ok, vscode = pcall(require, "vscode")
    if ok and vscode then
      vim.notify = vscode.notify
    else
      vim.notify(("Failed loading vscode module: %s"):format(vscode or "nil"),
      vim.log.levels.WARN)
    end

    vim.print("Loading VSVim Config...")
    vim.notify("Loading VSCode Neovim Config...", vim.log.levels.INFO, { title = "VSCode Neovim" })

    -- require("options.lua")
    vim.g.clipboard = vim.g.vscode_clipboard
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.unddofile = true

    return
else
    vim.opt.clipboard = "unnamedplus"
end
