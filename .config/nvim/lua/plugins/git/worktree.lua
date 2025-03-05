local present, worktree = pcall(require, "git-worktree")
if not present then
    return
end

local utils = require('utils')
-- ╭──────────────────────────────────────────────────────────╮
-- │ Hooks                                                    │
-- ╰──────────────────────────────────────────────────────────╯
-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

worktree.on_tree_change(function(op, metadata)
    if op == worktree.Operations.Switch then
        utils.log("Switched from " .. metadata.prev_path .. " to " .. metadata.path, "Git Worktree")
        utils.closeOtherBuffers()
        vim.cmd('e')
    end
end)
