local ls = require "luasnip"

local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local s = ls.snippet
local c = ls.choice_node
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node

ls.add_snippets("cpp", {
	s(
		"dbg",
		fmta(
			[[
			dbgprintf("[ECNET][AAD] <fmt>\n", <args>);<finish>
			]],
			{
				fmt = i(1),
				args = i(2),
				finish = i(0)
			}
		)
	)
})
