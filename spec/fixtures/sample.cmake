# Assertions live in the comments: `<- scope` checks the marker's own column
# on the previous non-comment line, `^ scope` checks the caret's. Scopes
# match by prefix, so the trailing `.cmake` segment is left off.

cmake_minimum_required(VERSION 3.20)
# <- support.function.builtin
#                     ^ punctuation.definition.arguments.begin.bracket.round
#                      ^ constant.other
#                                  ^ punctuation.definition.arguments.end.bracket.round

set(GREETING "hello")
# <- support.function.builtin
#            ^ string.quoted.double

function(my_helper ARG)
# <- storage.type.function
#        ^ entity.name.function

  message(STATUS ${ARG})
#                ^ punctuation.definition.variable.begin
#                  ^ variable
#                     ^ punctuation.definition.variable.end

endfunction()
# <- storage.type.function

# a line comment
# <- punctuation.definition.comment
