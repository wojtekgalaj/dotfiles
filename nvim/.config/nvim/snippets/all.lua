local ls = require "luasnip"
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local c = ls.choice_node

ls.add_snippets("svelte", {
  ls.parser.parse_snippet("ss", "<script lang='ts'>${1:body}</script>"),
})
