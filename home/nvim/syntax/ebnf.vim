" Vim syntax file
" Language:         EBNF
" Last Change:      $Date: 2023/04/04 00:57:00 $
" Version:          $Id: ebnf.vim,v 1.1 2003/01/28 14:42:09 fugalh Exp $    
" With thanks to Michael Brailsford for the BNF syntax file.
" With thanks Hans Fugal, original maintainer, for the EBNF syntax.

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match ebnfMetaIdentifier /[A-Za-z]/ skipwhite skipempty nextgroup=ebnfSeperator

syn match ebnfSeperator "=" contained nextgroup=ebnfProduction skipwhite skipempty

syn region ebnfProduction start=/\zs[^\.;]/ end=/[\.;]/me=e-1 contained contains=ebnfSpecial,ebnfDelimiter,ebnfTerminal,ebnfSpecialSequence,ebnfComment nextgroup=ebnfEndProduction skipwhite skipempty
syn match ebnfDelimiter #[,(|)\]}\[{/!]\|\(\*)\)\|\((\*\)\|\(/)\)\|\(:)\)\|\((/\)\|\((:\)# contained
syn match ebnfSpecial /[\-\*]/ contained
syn region ebnfSpecialSequence matchgroup=Delimiter start=/?/ end=/?/ contained
syn match ebnfEndProduction /[\.;]/ contained 
syn region ebnfTerminal matchgroup=delimiter start=/"/ end=/"/ contained
syn region ebnfTerminal matchgroup=delimiter start=/'/ end=/'/ contained
syn region ebnfComment start="(\*" end="\*)"


hi link ebnfComment Comment
hi link ebnfMetaIdentifier Identifier
hi link ebnfSeperator ebnfSpecial
hi link ebnfEndProduction ebnfDelimiter
hi link ebnfDelimiter Delimiter
hi link ebnfSpecial Special
hi link ebnfSpecialSequence Statement
hi link ebnfTerminal Constant
