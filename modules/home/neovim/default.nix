{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    # withNodeJs = true;
    # withPython3 = true;

    coc.enable = true;
    coc.settings = {
      "suggest.noselect" = true;
      "suggest.enablePreview" = true;
      "suggest.enablePreselect" = false;
      "suggest.disableKind" = true;
    };

    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      nvim-treesitter.withAllGrammars
      lightline-vim
      vim-code-dark
    ];

    extraConfig = ''
                  set nocompatible
                  set encoding=utf-8
                  set autoindent
                  set smartindent
      	    set nu

                  :colorscheme codedark

                  set laststatus=2
                  let g:lightline = {
                    \ 'colorscheme': 'nord',
            	\ 'active': {
            	\    'left': [ ['mode', 'paste'], ['readonly', 'filename', 'modified', 'lineinfo'] ],
            	\    'right': [ ['filetype'] ]
            	\ },
            	\ }

                  function! LightlineLineInfo()
                    let current_line = line('.')
            	let total_lines = line('$')
            	let percent = current_line * 100 / total_lines
            	return 'Line' . current_line . '(' . percent . '%)'
                  endfunction

                  let g:lightline.component_function = {
                    \ 'lineinfo': 'LightlineLineInfo',
            	\ }
    '';
  };

}
