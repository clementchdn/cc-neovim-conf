local leap = require("leap")

-- leap.create_default_mappings()
vim.keymap.set({'n', 'x', 'o'}, 'zj', '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'zk', '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

leap.opts.special_keys.prev_target = '<bs>'
leap.opts.special_keys.prev_group = '<bs>'
require('leap.user').set_repeat_keys('<cr>', '<bs>')
