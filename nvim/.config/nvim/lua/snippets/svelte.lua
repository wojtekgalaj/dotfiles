local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("st", {
    t "<script lang='ts'>",
    i(1),
    t "</script>",
  }),
}
