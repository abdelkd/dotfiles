"2 char-wide overrides
augroup two_space_tab
  autocmd!
  autocmd FileType json,html,htmldjango,hamlet,nix,scss,typescript,php,haskell,terraform setlocal tabstop=2
augroup END

" "Fix nvim size according to terminal
" "(https://github.com/neovim/neovim/issues/11330)
" augroup fix_size
"     autocmd VimEnter * silent exec "!kill -s SIGWINCH" getpid()
" augroup END

" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
