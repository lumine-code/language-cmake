((unquoted_argument) @constant.other.cmake
  (#is? test.typeAt "parent argument")
  (#is? test.typeAt "parent.parent argument_list")
  (#is? test.typeAt "parent.parent.parent normal_command"))

(quoted_argument) @string.quoted.double.cmake
(bracket_argument) @string.quoted.other.bracket.cmake

(variable_ref) @_IGNORE_.none

(variable) @variable.other.cmake

(line_comment) @comment.line.number-sign.cmake
(bracket_comment) @comment.block.cmake
((line_comment) @punctuation.definition.comment.cmake
  (#set! adjust.endAfterFirstMatchOf "^#"))

(normal_command
  (identifier) @entity.name.function.cmake)

[
  "ENV"
  "CACHE"
] @entity.name.namespace.cmake

; `${` is two tokens, not one.
(normal_var
  "$" @punctuation.definition.variable.begin.cmake
  "{" @punctuation.definition.variable.begin.cmake
  "}" @punctuation.definition.variable.end.cmake)

; The parentheses belong to the command node, not to its argument list, and
; every command spells them the same way, so match them wherever they appear.
"(" @punctuation.definition.arguments.begin.bracket.round.cmake
")" @punctuation.definition.arguments.end.bracket.round.cmake

[
  (function)
  (endfunction)
  (macro)
  (endmacro)
] @storage.type.function.cmake

[
  (if)
  (elseif)
  (else)
  (endif)
] @keyword.control.conditional.cmake

[
  (foreach)
  (endforeach)
  (while)
  (endwhile)
] @keyword.control.loop.cmake

(normal_command
  (identifier) @keyword.control.loop.cmake
  (#match? @keyword.control.loop.cmake "^([cC][oO][nN][tT][iI][nN][uU][eE]|[bB][rR][eE][aA][kK])$"))

(normal_command
  (identifier) @keyword.control.return.cmake
  (#match? @keyword.control.return.cmake "^[rR][eE][tT][uU][rR][nN]$"))

(function_command
  (function))

(macro_command
  (macro))

((argument) @entity.name.function.cmake
  (#is? test.typeAt "parent.parent function_command")
  (#is? test.firstOfType true))

((argument) @variable.parameter.cmake
  (#is? test.typeAt "parent.parent function_command")
  (#is-not? test.firstOfType true))

((argument) @entity.name.function.macro.cmake
  (#is? test.typeAt "parent.parent macro_command")
  (#is? test.firstOfType true))

((argument) @variable.parameter.cmake
  (#is? test.typeAt "parent.parent macro_command")
  (#is-not? test.firstOfType true))

(block_def
  (block_command
    (block) @support.function.builtin.cmake)
  (endblock_command (endblock) @support.function.builtin.cmake))

((argument) @constant.other.cmake
  (#is? test.typeAt "parent.parent block_command")
  (#any-of? @constant.other.cmake "SCOPE_FOR" "POLICIES" "VARIABLES" "PROPAGATE"))

((argument) @constant.language.boolean.cmake
  (#match? @constant.language.boolean.cmake "^(1|[oO][nN]|[yY][eE][sS]|[tT][rR][uU][eE]|[yY]|0|[oO][fF][fF]|[nN][oO]|[fF][aA][lL][sS][eE]|[nN]|[iI][gG][nN][oO][rR][eE]|[nN][oO][tT][fF][oO][uU][nN][dD]|.*-[nN][oO][tT][fF][oO][uU][nN][dD])$"))

(if_command
  (if))

((argument) @keyword.operator.word.cmake
  (#is? test.typeAt "parent.parent if_command")
  (#any-of? @keyword.operator.word.cmake
    "NOT" "AND" "OR" "COMMAND" "POLICY" "TARGET" "TEST" "DEFINED" "IN_LIST" "EXISTS" "IS_NEWER_THAN"
    "IS_DIRECTORY" "IS_SYMLINK" "IS_ABSOLUTE" "MATCHES" "LESS" "GREATER" "EQUAL" "LESS_EQUAL"
    "GREATER_EQUAL" "STRLESS" "STRGREATER" "STREQUAL" "STRLESS_EQUAL" "STRGREATER_EQUAL"
    "VERSION_LESS" "VERSION_GREATER" "VERSION_EQUAL" "VERSION_LESS_EQUAL" "VERSION_GREATER_EQUAL"))

(elseif_command
  (elseif))

((argument) @keyword.operator.word.cmake
  (#is? test.typeAt "parent.parent elseif_command")
  (#any-of? @keyword.operator.word.cmake
    "NOT" "AND" "OR" "COMMAND" "POLICY" "TARGET" "TEST" "DEFINED" "IN_LIST" "EXISTS" "IS_NEWER_THAN"
    "IS_DIRECTORY" "IS_SYMLINK" "IS_ABSOLUTE" "MATCHES" "LESS" "GREATER" "EQUAL" "LESS_EQUAL"
    "GREATER_EQUAL" "STRLESS" "STRGREATER" "STREQUAL" "STRLESS_EQUAL" "STRGREATER_EQUAL"
    "VERSION_LESS" "VERSION_GREATER" "VERSION_EQUAL" "VERSION_LESS_EQUAL" "VERSION_GREATER_EQUAL"))

(normal_command
  (identifier) @support.function.builtin.cmake
  (#match? @support.function.builtin.cmake
    "^([cC][mM][aA][kK][eE]_[hH][oO][sS][tT]_[sS][yY][sS][tT][eE][mM]_[iI][nN][fF][oO][rR][mM][aA][tT][iI][oO][nN]|[cC][mM][aA][kK][eE]_[lL][aA][nN][gG][uU][aA][gG][eE]|[cC][mM][aA][kK][eE]_[mM][iI][nN][iI][mM][uU][mM]_[rR][eE][qQ][uU][iI][rR][eE][dD]|[cC][mM][aA][kK][eE]_[pP][aA][rR][sS][eE]_[aA][rR][gG][uU][mM][eE][nN][tT][sS]|[cC][mM][aA][kK][eE]_[pP][aA][tT][hH]|[cC][mM][aA][kK][eE]_[pP][oO][lL][iI][cC][yY]|[cC][oO][nN][fF][iI][gG][uU][rR][eE]_[fF][iI][lL][eE]|[eE][xX][eE][cC][uU][tT][eE]_[pP][rR][oO][cC][eE][sS][sS]|[fF][iI][lL][eE]|[fF][iI][nN][dD]_[fF][iI][lL][eE]|[fF][iI][nN][dD]_[lL][iI][bB][rR][aA][rR][yY]|[fF][iI][nN][dD]_[pP][aA][cC][kK][aA][gG][eE]|[fF][iI][nN][dD]_[pP][aA][tT][hH]|[fF][iI][nN][dD]_[pP][rR][oO][gG][rR][aA][mM]|[fF][oO][rR][eE][aA][cC][hH]|[gG][eE][tT]_[cC][mM][aA][kK][eE]_[pP][rR][oO][pP][eE][rR][tT][yY]|[gG][eE][tT]_[dD][iI][rR][eE][cC][tT][oO][rR][yY]_[pP][rR][oO][pP][eE][rR][tT][yY]|[gG][eE][tT]_[fF][iI][lL][eE][nN][aA][mM][eE]_[cC][oO][mM][pP][oO][nN][eE][nN][tT]|[gG][eE][tT]_[pP][rR][oO][pP][eE][rR][tT][yY]|[iI][nN][cC][lL][uU][dD][eE]|[iI][nN][cC][lL][uU][dD][eE]_[gG][uU][aA][rR][dD]|[lL][iI][sS][tT]|[mM][aA][cC][rR][oO]|[mM][aA][rR][kK]_[aA][sS]_[aA][dD][vV][aA][nN][cC][eE][dD]|[mM][aA][tT][hH]|[mM][eE][sS][sS][aA][gG][eE]|[oO][pP][tT][iI][oO][nN]|[sS][eE][pP][aA][rR][aA][tT][eE]_[aA][rR][gG][uU][mM][eE][nN][tT][sS]|[sS][eE][tT]|[sS][eE][tT]_[dD][iI][rR][eE][cC][tT][oO][rR][yY]_[pP][rR][oO][pP][eE][rR][tT][iI][eE][sS]|[sS][eE][tT]_[pP][rR][oO][pP][eE][rR][tT][yY]|[sS][iI][tT][eE]_[nN][aA][mM][eE]|[sS][tT][rR][iI][nN][gG]|[uU][nN][sS][eE][tT]|[vV][aA][rR][iI][aA][bB][lL][eE]_[wW][aA][tT][cC][hH]|[aA][dD][dD]_[cC][oO][mM][pP][iI][lL][eE]_[dD][eE][fF][iI][nN][iI][tT][iI][oO][nN][sS]|[aA][dD][dD]_[cC][oO][mM][pP][iI][lL][eE]_[oO][pP][tT][iI][oO][nN][sS]|[aA][dD][dD]_[cC][uU][sS][tT][oO][mM]_[cC][oO][mM][mM][aA][nN][dD]|[aA][dD][dD]_[cC][uU][sS][tT][oO][mM]_[tT][aA][rR][gG][eE][tT]|[aA][dD][dD]_[dD][eE][fF][iI][nN][iI][tT][iI][oO][nN][sS]|[aA][dD][dD]_[dD][eE][pP][eE][nN][dD][eE][nN][cC][iI][eE][sS]|[aA][dD][dD]_[eE][xX][eE][cC][uU][tT][aA][bB][lL][eE]|[aA][dD][dD]_[lL][iI][bB][rR][aA][rR][yY]|[aA][dD][dD]_[lL][iI][nN][kK]_[oO][pP][tT][iI][oO][nN][sS]|[aA][dD][dD]_[sS][uU][bB][dD][iI][rR][eE][cC][tT][oO][rR][yY]|[aA][dD][dD]_[tT][eE][sS][tT]|[aA][uU][xX]_[sS][oO][uU][rR][cC][eE]_[dD][iI][rR][eE][cC][tT][oO][rR][yY]|[bB][uU][iI][lL][dD]_[cC][oO][mM][mM][aA][nN][dD]|[cC][rR][eE][aA][tT][eE]_[tT][eE][sS][tT]_[sS][oO][uU][rR][cC][eE][lL][iI][sS][tT]|[dD][eE][fF][iI][nN][eE]_[pP][rR][oO][pP][eE][rR][tT][yY]|[eE][nN][aA][bB][lL][eE]_[lL][aA][nN][gG][uU][aA][gG][eE]|[eE][nN][aA][bB][lL][eE]_[tT][eE][sS][tT][iI][nN][gG]|[eE][xX][pP][oO][rR][tT]|[fF][lL][tT][kK]_[wW][rR][aA][pP]_[uU][iI]|[gG][eE][tT]_[sS][oO][uU][rR][cC][eE]_[fF][iI][lL][eE]_[pP][rR][oO][pP][eE][rR][tT][yY]|[gG][eE][tT]_[tT][aA][rR][gG][eE][tT]_[pP][rR][oO][pP][eE][rR][tT][yY]|[gG][eE][tT]_[tT][eE][sS][tT]_[pP][rR][oO][pP][eE][rR][tT][yY]|[iI][nN][cC][lL][uU][dD][eE]_[dD][iI][rR][eE][cC][tT][oO][rR][iI][eE][sS]|[iI][nN][cC][lL][uU][dD][eE]_[eE][xX][tT][eE][rR][nN][aA][lL]_[mM][sS][pP][rR][oO][jJ][eE][cC][tT]|[iI][nN][cC][lL][uU][dD][eE]_[rR][eE][gG][uU][lL][aA][rR]_[eE][xX][pP][rR][eE][sS][sS][iI][oO][nN]|[iI][nN][sS][tT][aA][lL][lL]|[lL][iI][nN][kK]_[dD][iI][rR][eE][cC][tT][oO][rR][iI][eE][sS]|[lL][iI][nN][kK]_[lL][iI][bB][rR][aA][rR][iI][eE][sS]|[lL][oO][aA][dD]_[cC][aA][cC][hH][eE]|[pP][rR][oO][jJ][eE][cC][tT]|[rR][eE][mM][oO][vV][eE]_[dD][eE][fF][iI][nN][iI][tT][iI][oO][nN][sS]|[sS][eE][tT]_[sS][oO][uU][rR][cC][eE]_[fF][iI][lL][eE][sS]_[pP][rR][oO][pP][eE][rR][tT][iI][eE][sS]|[sS][eE][tT]_[tT][aA][rR][gG][eE][tT]_[pP][rR][oO][pP][eE][rR][tT][iI][eE][sS]|[sS][eE][tT]_[tT][eE][sS][tT][sS]_[pP][rR][oO][pP][eE][rR][tT][iI][eE][sS]|[sS][oO][uU][rR][cC][eE]_[gG][rR][oO][uU][pP]|[tT][aA][rR][gG][eE][tT]_[cC][oO][mM][pP][iI][lL][eE]_[dD][eE][fF][iI][nN][iI][tT][iI][oO][nN][sS]|[tT][aA][rR][gG][eE][tT]_[cC][oO][mM][pP][iI][lL][eE]_[fF][eE][aA][tT][uU][rR][eE][sS]|[tT][aA][rR][gG][eE][tT]_[cC][oO][mM][pP][iI][lL][eE]_[oO][pP][tT][iI][oO][nN][sS]|[tT][aA][rR][gG][eE][tT]_[iI][nN][cC][lL][uU][dD][eE]_[dD][iI][rR][eE][cC][tT][oO][rR][iI][eE][sS]|[tT][aA][rR][gG][eE][tT]_[lL][iI][nN][kK]_[dD][iI][rR][eE][cC][tT][oO][rR][iI][eE][sS]|[tT][aA][rR][gG][eE][tT]_[lL][iI][nN][kK]_[lL][iI][bB][rR][aA][rR][iI][eE][sS]|[tT][aA][rR][gG][eE][tT]_[lL][iI][nN][kK]_[oO][pP][tT][iI][oO][nN][sS]|[tT][aA][rR][gG][eE][tT]_[pP][rR][eE][cC][oO][mM][pP][iI][lL][eE]_[hH][eE][aA][dD][eE][rR][sS]|[tT][aA][rR][gG][eE][tT]_[sS][oO][uU][rR][cC][eE][sS]|[tT][rR][yY]_[cC][oO][mM][pP][iI][lL][eE]|[tT][rR][yY]_[rR][uU][nN]|[cC][tT][eE][sS][tT]_[bB][uU][iI][lL][dD]|[cC][tT][eE][sS][tT]_[cC][oO][nN][fF][iI][gG][uU][rR][eE]|[cC][tT][eE][sS][tT]_[cC][oO][vV][eE][rR][aA][gG][eE]|[cC][tT][eE][sS][tT]_[eE][mM][pP][tT][yY]_[bB][iI][nN][aA][rR][yY]_[dD][iI][rR][eE][cC][tT][oO][rR][yY]|[cC][tT][eE][sS][tT]_[mM][eE][mM][cC][hH][eE][cC][kK]|[cC][tT][eE][sS][tT]_[rR][eE][aA][dD]_[cC][uU][sS][tT][oO][mM]_[fF][iI][lL][eE][sS]|[cC][tT][eE][sS][tT]_[rR][uU][nN]_[sS][cC][rR][iI][pP][tT]|[cC][tT][eE][sS][tT]_[sS][lL][eE][eE][pP]|[cC][tT][eE][sS][tT]_[sS][tT][aA][rR][tT]|[cC][tT][eE][sS][tT]_[sS][uU][bB][mM][iI][tT]|[cC][tT][eE][sS][tT]_[tT][eE][sS][tT]|[cC][tT][eE][sS][tT]_[uU][pP][dD][aA][tT][eE]|[cC][tT][eE][sS][tT]_[uU][pP][lL][oO][aA][dD])$"))

; Command-sensitive argument classifications stay rooted on an argument. A
; normal command may contain thousands of siblings, and rooting these patterns
; on its argument list makes a six-row query scan the entire command.
((argument) @variable.other.cmake
  (#is? test.typeAt "parent argument_list")
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[sS][eE][tT]$")
  (#is? test.firstOfType true))

((argument) @_IGNORE_.cache @storage.modifier.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[sS][eE][tT]$")
  (#is-not? test.firstOfType true)
  (#is? test.matchAt "nextNamedSibling ^(?:BOOL|FILEPATH|PATH|STRING|INTERNAL)$")
  (#any-of? @_IGNORE_.cache "CACHE"))

((argument) @_IGNORE_.type @support.type.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[sS][eE][tT]$")
  (#is? test.textAt "previousNamedSibling CACHE")
  (#is? test.typeAt "previousNamedSibling.previousNamedSibling argument")
  (#any-of? @_IGNORE_.type "BOOL" "FILEPATH" "PATH" "STRING" "INTERNAL"))

((argument) @storage.modifier.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[uU][nN][sS][eE][tT]$")
  (#is-not? test.firstOfType true)
  (#any-of? @storage.modifier.cmake "CACHE" "PARENT_SCOPE"))

((argument) @variable.other.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[lL][iI][sS][tT]$")
  (#is? test.matchAt "previousNamedSibling ^(?:LENGTH|GET|JOIN|SUBLIST|FIND|APPEND|FILTER|INSERT|POP_BACK|POP_FRONT|PREPEND|REMOVE_ITEM|REMOVE_AT|REMOVE_DUPLICATES|REVERSE|SORT|TRANSFORM)$")
  (#is-not? test.typeAt "previousNamedSibling.previousNamedSibling argument"))

((argument) @variable.other.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[lL][iI][sS][tT]$")
  (#is? test.matchAt "parent.firstNamedChild ^(?:LENGTH|GET|JOIN|SUBLIST|FIND)$")
  (#is? test.lastOfType true))

((argument) @variable.other.cmake
  (#is? test.typeAt "parent.parent normal_command")
  (#is? test.matchAt "parent.parent.firstNamedChild ^[lL][iI][sS][tT]$")
  (#is? test.textAt "parent.firstNamedChild TRANSFORM")
  (#is? test.textAt "previousNamedSibling OUTPUT_VARIABLE"))

(escape_sequence) @constant.character.escape.cmake

((source_file
  .
  (line_comment) @keyword.control.directive.cmake @_IGNORE_.nospell)
  )
