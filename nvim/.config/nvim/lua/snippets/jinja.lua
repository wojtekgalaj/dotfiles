local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s({
    trig = "ii",
    desc = "Basic one line ninja style tag. No special purpose.",
  }, {
    t "{% ",
    i(1, "anything"),
    t " %}",
    i(0, ""),
  }),
  s({
    trig = "bb",
    desc = "Self closing block. Use for loops and conditions.",
  }, {
    t "{% ",
    i(1, "if"),
    t " ",
    i(2, "condition"),
    t " %}",
    t { "", "" },
    i(3, "body"),
    t { "", "{% end" },
    -- repeat whatever was typed in node 1
    f(function(args)
      return args[1]
    end, { 1 }),
    t " %}",
    i(0),
  }),
}
