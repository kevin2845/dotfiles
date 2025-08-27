return{
-- lua/plugins/blink.lua (or wherever you call require('blink.cmp').setup)
-- lua/plugins/blink.lua (or wherever you call require('blink.cmp').setup)
require('blink.cmp').setup({
  keymap = {
    -- use 'default' so Tab doesn't accept
    preset = 'default',

    -- Tab = next item (no auto-insert), then try snippet jump, else literal <Tab>
    ['<Tab>']   = { function(cmp) return cmp.select_next({ auto_insert = false }) end,
                    'snippet_forward', 'fallback' },

    -- S-Tab = prev item (no auto-insert), then snippet back, else literal <S-Tab>
    ['<S-Tab>'] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end,
                    'snippet_backward', 'fallback' },

    -- Enter accepts the selected item; otherwise behaves like normal <CR>
    ['<CR>']    = { 'accept', 'fallback' },

    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>']     = { 'hide' },
  },

  -- optional: stop Blink from inserting previews while you’re cycling
  completion = {
    list = { selection = { preselect = true, auto_insert = false } },
    trigger = { show_in_snippet = false },
  },
})
}
