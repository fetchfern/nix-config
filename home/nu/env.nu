def create_left_prompt [] {
    def replace_home_with_tilde [dir: string, user: string] {
        let homedir_path = $"/home/($user)"
        let homedir_path_len = ($homedir_path | str length)
        let start = ($dir | str substring 0..$homedir_path_len | str replace $homedir_path ~)
        let end = ($dir | str substring $homedir_path_len..)
        ([$start, $end] | str join)
    }

    def cut_off_tilde [path: string] {
        let start = ($path | str substring 0..2 | str replace ~/ "")
        let end = ($path | str substring 2..)
        ([$start, $end] | str join)
    }

    let prefix = $"(ansi purple)(hostname)(ansi white)->(ansi purple_bold)($env.USER)"
    let cwd = $"(ansi blue)(cut_off_tilde (replace_home_with_tilde $env.PWD $env.USER))"
    let suffix = if (is-admin) { "#" } else { ":" }

    $"($prefix) ($cwd)(ansi white_bold)($suffix)"
}

let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { "" }

let-env PROMPT_INDICATOR_VI_INSERT = { " " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "[n] " }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

let-env BROWSER = "firefox"
let-env TERMINAL = "kitty"

let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

def add_to_path [p: path] {
    let-env PATH = ($env.PATH | split row (char esep) | prepend $p)
}

