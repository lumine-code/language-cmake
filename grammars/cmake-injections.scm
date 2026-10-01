((line_comment) @injection.owner @injection.content
  (#set! injection.language "hyperlink")
  (#set! injection.language-scope "none")
  (#set! injection.include-children))
((line_comment) @injection.owner @injection.content
  (#set! injection.language "todo")
  (#set! injection.language-scope "none")
  (#set! injection.include-children))
((bracket_comment (bracket_comment_content) @injection.content) @injection.owner
  (#set! injection.language "hyperlink")
  (#set! injection.language-scope "none"))

((bracket_comment (bracket_comment_content) @injection.content) @injection.owner
  (#set! injection.language "todo")
  (#set! injection.language-scope "none"))
