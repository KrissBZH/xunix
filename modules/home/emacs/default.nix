{ pkgs, config, ... }:
{
  imports = [ ./__modules/emacs-init.nix ];
  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.arguments = [ "-c" ];
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];

    init = {
      enable = true;
      recommendedGcSettings = true;
      earlyInit = ''
        (menu-bar-mode 0)
        (tool-bar-mode 0)
        (scroll-bar-mode 0)
      '';

      prelude = ''
        ;; Set a font
        (add-to-list 'default-frame-alist
                      '(font . "Iosevka q Semibold 15"))

        (column-number-mode 1)
        (global-display-line-numbers-mode)
        (setq-default indent-tabs-mode nil)
        (setq-default tab-width 2)

        ;; Remembering minibuffer prompt history
        (setq history-length 25)
        (savehist-mode 1)

        ;; Prevent using UI dialogs for prompts
        (setq use-dialog-box nil)

        ;; Disable lock files (.#filenameblabla)
        (setq create-lockfiles nil)

        ;; Automatically revert buffers when files change on disk
        (global-auto-revert-mode t)

        ;; You can select text and delete it by typing.
        (delete-selection-mode 1)

        (setq make-backup-files nil
              auto-save-default nil)

        ;; Default is 4k, which is too low for LSP.
        (setq read-process-output-max (* 1024 1024))

        ;; Improved handling of clipboard
        (setq select-enable-clipboard t
              select-enable-primary t
              save-interprogram-paste-before-kill t)

        ;; Avoid noisy bell.
        ;; (setq visible-bell t
        ;;      ring-bell-function #'ignore)

        ;; Long text goes below
        (global-visual-line-mode t)

        ;; Trailing white space are banned!
        (setq-default show-trailing-whitespace t)

        ;; Use one space to end sentences.
        (setq sentence-end-double-space nil)

        ;; I typically want to use UTF-8.
        (prefer-coding-system 'utf-8)

      '';

      usePackageVerbose = true;
      usePackage = {
        c-ts-mode.enable = true;
        lsp-clangd = {
          enable = true;
          defer = true;
          hook = [
            "(c-ts-mode . airi-lsp)"
            "(c-or-c++-ts-mode . airi-lsp)"
            "(c++-ts-mode . airi-lsp)"
          ];
        };

        cmake-ts-mode.enable = true;
        lsp-cmake = {
          enable = true;
          defer = true;
          hook = [ "(cmake-ts-mode . airi-lsp)" ];
        };

        haskell-mode = {
          enable = true;
          mode = [
            ''("\\.hs\\'" . haskell-mode)''
            ''("\\.hsc\\'" . haskell-mode)''
            ''("\\.c2hs\\'" . haskell-mode)''
            ''("\\.cpphs\\'" . haskell-mode)''
            ''("\\.lhs\\'" . haskell-literate-mode)''
          ];
          hook = [ "(haskell-mode . subword-mode)" ];
          bindLocal.haskell-mode-map = {
            "C-c C-l" = "haskell-interactive-bring";
          };
          config = ''
            (setq tab-width 2)

            (setq haskell-process-log t
                  haskell-notify-p t)

            (setq haskell-process-args-cabal-repl
                  '("--ghc-options=+RTS -M500m -RTS -ferror-spans -fshow-loaded-modules"))
          '';
        };
        lsp-haskell = {
          enable = true;
          defer = true;
          hook = [ "(haskell-mode . airi-lsp)" ];
        };

        lsp-kotlin = {
          enable = true;
          hook = [ "(kotlin-mode . airi-lsp)" ];
        };

        purescript-mode.enable = true;
        lsp-purescript = {
          enable = true;
          defer = true;
          hook = [ "(purescript-mode . airi-lsp) " ];
          config = ''
            (setq lsp-purescript-formatter "purs-tidy")
          '';
        };

        lsp-completion = {
          enable = true;
          after = [ "lsp-mode" ];
          config = ''
            (setq lsp-completion-enable-additional-text-edit nil)
          '';
        };

        lsp-diagnostics = {
          enable = true;
          after = [ "lsp-mode" ];
        };

        lsp-lens = {
          enable = true;
          command = [ "lsp-lens--enable" ];
          after = [ "lsp-mode" ];
        };

        lsp-mode = {
          enable = true;
          command = [ "lsp" ];
          after = [
            "company"
            "flycheck"
          ];
          bindLocal = {
            lsp-mode-map = {
              "C-c f r" = "lsp-find-references";
              "C-r a" = "lsp-execute-code-action";
              "C-r f" = "lsp-format-buffer";
              "C-r g" = "lsp-format-region";
              "C-r l" = "lsp-avy-lens";
              "C-r r" = "lsp-rename";
            };
          };
          init = ''
            (setq lsp-keymap-prefix "C-r l")
          '';
          config = ''
            (setq lsp-diagnostics-provider :flycheck
                  lsp-eldoc-render-all nil
                  lsp-headerline-breadcrumb-enable nil
                  lsp-modeline-code-actions-enable nil
                  lsp-modeline-diagnostics-enable nil
                  lsp-modeline-workspace-status-enable nil
                  lsp-lens-enable t
                  lsp-enable-on-type-formatting nil)
          '';
        };

        python-ts-mode.enable = true;
        lsp-pylsp = {
          enable = true;
          defer = true;
          hook = [ "(python-ts-mode . airi-lsp)" ];
        };

        rust-ts-mode.enable = true;
        lsp-rust = {
          enable = true;
          defer = true;
          hook = [ "(rust-ts-mode . airi-lsp)" ];
        };

        lsp-treemacs = {
          enable = true;
          after = [ "lsp-mode" ];
          command = [ "lsp-treemacs-errors-list" ];
        };
      };
    };
  };
}
