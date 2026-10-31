; Branch and end keywords return to the owning block's indentation.
[
  (endblock)
  (endfunction)
  (endmacro)
  (endif)
  (elseif)
  (else)
  (endforeach)
  (endwhile)
] @dedent

; Reindent code without rewriting whitespace that belongs to multiline text.
([(quoted_argument) (bracket_argument) (bracket_comment)] @preserve
  (#is? indent.reindent true)
  (#is-not? indent.matchesCurrentRow startPosition)
  (#set! indent.force true))

; Parentheses drive continuation lines; same-line command pairs cancel out.
"(" @indent
")" @dedent

(")" @indent
  (#is? test.childOfType "block_command function_command macro_command if_command elseif_command else_command foreach_command while_command"))
