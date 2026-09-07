--- Smart hover for Go: LSP docs, language keywords, then `go doc`.
local M = {}

-- gopls does not document language keywords; these are short manuals + spec links.
local keywords = {
  ["break"] = {
    "### `break`",
    "",
    "Terminates execution of the innermost `for`, `switch`, or `select` statement.",
    "With a label, breaks out of the labeled statement.",
    "",
    "[Language spec](https://go.dev/ref/spec#Break_statements)",
  },
  ["case"] = {
    "### `case`",
    "",
    "Introduces a case clause in a `switch` or `select` statement.",
    "",
    "[Language spec](https://go.dev/ref/spec#Switch_statements)",
  },
  ["chan"] = {
    "### `chan`",
    "",
    "Channel type: `chan T`, `chan<- T` (send-only), or `<-chan T` (receive-only).",
    "Create with `make(chan T)` or `make(chan T, capacity)`.",
    "",
    "[Language spec](https://go.dev/ref/spec#Channel_types)",
  },
  ["const"] = {
    "### `const`",
    "",
    "Declares named constants. Values must be compile-time constant expressions.",
    "Within a `const` block, `iota` enumerates successive untyped integer constants.",
    "",
    "[Language spec](https://go.dev/ref/spec#Constant_declarations)",
  },
  ["continue"] = {
    "### `continue`",
    "",
    "Begins the next iteration of the innermost `for` loop.",
    "With a label, continues the labeled loop.",
    "",
    "[Language spec](https://go.dev/ref/spec#Continue_statements)",
  },
  ["default"] = {
    "### `default`",
    "",
    "Default clause in a `switch` or `select` when no other case matches.",
    "",
    "[Language spec](https://go.dev/ref/spec#Switch_statements)",
  },
  ["defer"] = {
    "### `defer`",
    "",
    "Schedules a function call to run when the surrounding function returns.",
    "Deferred calls run LIFO. Arguments are evaluated immediately.",
    "",
    "[Language spec](https://go.dev/ref/spec#Defer_statements)",
  },
  ["else"] = {
    "### `else`",
    "",
    "Optional branch of an `if` statement when the condition is false.",
    "",
    "[Language spec](https://go.dev/ref/spec#If_statements)",
  },
  ["fallthrough"] = {
    "### `fallthrough`",
    "",
    "In an expression `switch`, transfers control to the next case clause.",
    "Not allowed in type switches or at the end of the final case.",
    "",
    "[Language spec](https://go.dev/ref/spec#Fallthrough_statements)",
  },
  ["for"] = {
    "### `for`",
    "",
    "Go's only looping construct. Forms:",
    "- `for { }` — infinite loop",
    "- `for condition { }`",
    "- `for init; condition; post { }`",
    "- `for range expr { }` — iterate over array, slice, string, map, or channel",
    "",
    "[Language spec](https://go.dev/ref/spec#For_statements)",
  },
  ["func"] = {
    "### `func`",
    "",
    "Declares a function, method, or function literal (closure).",
    "",
    "[Language spec](https://go.dev/ref/spec#Function_declarations)",
  },
  ["go"] = {
    "### `go`",
    "",
    "Starts a function call as a new goroutine: `go f(args)`.",
    "Arguments are evaluated in the current goroutine.",
    "",
    "[Language spec](https://go.dev/ref/spec#Go_statements)",
  },
  ["goto"] = {
    "### `goto`",
    "",
    "Transfers control to a labeled statement in the same function.",
    "",
    "[Language spec](https://go.dev/ref/spec#Goto_statements)",
  },
  ["if"] = {
    "### `if`",
    "",
    "Conditional execution: `if [init;] condition { } else if ... else { }`.",
    "The condition must be a boolean expression.",
    "",
    "[Language spec](https://go.dev/ref/spec#If_statements)",
  },
  ["import"] = {
    "### `import`",
    "",
    'Declares package imports. Forms: `"pkg"`, `alias "pkg"`, `. "pkg"`, `_ "pkg"`.',
    "",
    "[Language spec](https://go.dev/ref/spec#Import_declarations)",
  },
  ["interface"] = {
    "### `interface`",
    "",
    "Defines a set of method signatures (and optionally type terms in Go 1.18+).",
    "The empty interface `interface{}` / `any` holds any value.",
    "",
    "[Language spec](https://go.dev/ref/spec#Interface_types)",
  },
  ["map"] = {
    "### `map`",
    "",
    "Hash map type: `map[Key]Value`. Create with `make(map[K]V)` or a literal.",
    "",
    "[Language spec](https://go.dev/ref/spec#Map_types)",
  },
  ["package"] = {
    "### `package`",
    "",
    "Every Go source file starts with a package clause.",
    "Package `main` with `func main()` builds an executable.",
    "",
    "[Language spec](https://go.dev/ref/spec#Package_clause)",
  },
  ["range"] = {
    "### `range`",
    "",
    "Iterates over an array, slice, string, map, channel, or (Go 1.23+) an iterator.",
    "Used in `for` loops: `for i, v := range coll { }`.",
    "",
    "[Language spec](https://go.dev/ref/spec#For_statements)",
  },
  ["return"] = {
    "### `return`",
    "",
    "Returns from a function, optionally with result values.",
    "A naked `return` uses named result parameters.",
    "",
    "[Language spec](https://go.dev/ref/spec#Return_statements)",
  },
  ["select"] = {
    "### `select`",
    "",
    "Waits on multiple channel send/receive operations.",
    "Chooses one ready case at random; `default` makes it non-blocking.",
    "",
    "[Language spec](https://go.dev/ref/spec#Select_statements)",
  },
  ["struct"] = {
    "### `struct`",
    "",
    "A sequence of named fields. Supports embedding for composition.",
    "",
    "[Language spec](https://go.dev/ref/spec#Struct_types)",
  },
  ["switch"] = {
    "### `switch`",
    "",
    "Multi-way execution branch.",
    "",
    "**Expression switch:** `switch [init;] expr { case v: ... default: ... }`",
    "Cases are expressions; no automatic fallthrough (use `fallthrough`).",
    "",
    "**Type switch:** `switch x := expr.(type) { case T: ... }`",
    "Cases are types.",
    "",
    "[Language spec](https://go.dev/ref/spec#Switch_statements)",
  },
  ["type"] = {
    "### `type`",
    "",
    "Declares a named type, alias (`type T = U`), or type parameter constraints.",
    "",
    "[Language spec](https://go.dev/ref/spec#Type_declarations)",
  },
  ["var"] = {
    "### `var`",
    "",
    "Declares variables. Zero value is used when no initializer is given.",
    "Short declaration `:=` is allowed inside functions.",
    "",
    "[Language spec](https://go.dev/ref/spec#Variable_declarations)",
  },
}

local function hover_nonempty(result)
  if not result or not result.contents then
    return false
  end
  local contents = result.contents
  if type(contents) == "string" then
    return vim.trim(contents) ~= ""
  end
  if contents.value then
    return vim.trim(contents.value) ~= ""
  end
  if contents.kind or contents.language then
    return true
  end
  for _, part in ipairs(contents) do
    if type(part) == "string" and vim.trim(part) ~= "" then
      return true
    end
    if type(part) == "table" and part.value and vim.trim(part.value) ~= "" then
      return true
    end
  end
  return false
end

local function show_markdown(lines, title)
  vim.lsp.util.open_floating_preview(lines, "markdown", {
    border = "rounded",
    title = title,
    max_width = 80,
    max_height = 30,
  })
end

local function show_keyword(word)
  local lines = keywords[word]
  if not lines then
    return false
  end
  show_markdown(lines, "go keyword")
  return true
end

local function go_doc_query()
  -- Prefer package.Symbol when the cursor is on a selector (fmt.Println).
  local word = vim.fn.expand("<cWORD>"):match "[%w%./]+" or vim.fn.expand "<cword>"
  return word
end

local function show_go_doc()
  local query = go_doc_query()
  if not query or query == "" then
    return
  end

  local goroot = vim.fn.trim(vim.fn.system { "go", "env", "GOROOT" })
  local cwd = (goroot ~= "" and (goroot .. "/src")) or vim.fn.getcwd()

  vim.system({ "go", "doc", query }, { text = true, cwd = cwd }, function(res)
    vim.schedule(function()
      if res.code ~= 0 or not res.stdout or vim.trim(res.stdout) == "" then
        vim.notify("No documentation for `" .. query .. "`", vim.log.levels.INFO)
        return
      end
      local lines = vim.split(vim.trim(res.stdout), "\n", { plain = true })
      show_markdown(lines, "go doc " .. query)
    end)
  end)
end

--- Hover: keyword manual, else LSP, else `go doc`.
function M.hover()
  local word = vim.fn.expand "<cword>"

  -- Keywords never come from gopls; show the local manual immediately.
  if keywords[word] then
    show_keyword(word)
    return
  end

  local clients = vim.lsp.get_clients { bufnr = 0, method = "textDocument/hover" }
  if #clients == 0 then
    show_go_doc()
    return
  end

  local encoding = clients[1].offset_encoding or "utf-8"
  local params = vim.lsp.util.make_position_params(0, encoding)
  vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, config)
    if not err and hover_nonempty(result) then
      vim.lsp.handlers.hover(err, result, ctx, config or {})
      return
    end
    show_go_doc()
  end)
end

return M
