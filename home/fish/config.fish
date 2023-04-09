if status is-interactive
    function fish_prompt
    	if set -q IN_NIX_SHELL
	    set nix_status "$(set_color -o brwhite)(nix) "
	else
	    set nix_status ""
	end
        set mauve c78ecc 
        printf "%s%s%s%s %s%s$(set_color normal)" \
	    "$nix_status$(set_color normal)" \
	    "$(set_color $mauve)$hostname" \
	    "$(set_color white)->" \
	    "$(set_color -o $mauve)$USER" \
	    "$(set_color -o blue)$(prompt_pwd --dir-length=0 | string replace -r '^(~/)([\S\s]+)' '$2')" \
	    "$(set_color white): "
    end

    function fish_command_not_found
        echo "$argv[1]: command not found"
    end

    function fish_greeting
        
    end
end

# direnv stuff

set -gx DIRENV_LOG_FORMAT
direnv hook fish | source

function __direnv_output_cd_hook --on-variable DIRENV_DIFF
    if set -q DIRENV_DIFF
        echo "direnv: loading"
    else
        echo "direnv: unloading"
    end
end

set -g GPG_TTY "$(tty)"
