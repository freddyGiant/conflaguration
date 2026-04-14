# vrad's Configuration Conflagaration

<!-- TODO: nice html? lol -->
> Conflagaration *noun* \
1 : fire \
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*especially* : a large disastrous fire \
2 : conflict, war \
<sub>(Merriam-Webster)</sub>

TODOs, FIXMEs, HACKs, NOTEs, and more exist throughout conflaguration.

## Installation

Working in this directory, run the following in your preferred shell:
```bash
sudo nixos-rebuild switch --override-input secrets <secrets_path> \
  --experimental-features 'nix-command flakes'
```
...where `<secrets_path>` is the path to the directory containing your secrets flake.

## Requirements

### NixOS

- NixOS
- **NixOS conflaguration always utilizes home conflaguration as a module. Thus, all dependencies therein apply here too.**
- A secrets flake, to override the input stub
<!-- TODO: elaborate -->

```
# /etc/conflaguration/secrets.nix
```

### Home

- Nix

## Options

### NixOS

#### `my.username`
*type:* string matching `/^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$/` \
*default:* `"vrad"` \
System username (anticipate change). Overrides `home-manager.config.home.username` (`mkForce`).

### Home

<!-- #### `my.fish.emitInitEnd` -->
<!-- *type:* bool \ -->
<!-- *default:* true \ -->
<!-- Whether to emit the `init_end` event at the very end of `config.fish`. Note that [fish makes no guarantees](https://fishshell.com/docs/current/language.html#event) about the execution order of functions attached to a given event. -->

<!-- Enables emitting the Fish `init_end` event before the init script finishes running (regardless of whether the shell is a login shell, an interactive shell, etc.). See [](https://fishshell.com/docs/current/language.html#event). Note that, as stated in the documentation, no guarantees are made about the order in which attached event-handling function are executed. For instance, as of writing, the only attached function is one that `exec`s the sway desktop environment. This could occur before other functions attached to `init_end` could be run. -->

#### my.ssh.enableFishIntegration
*type:* bool \
*default:* `home.shell.enableFishIntegration` \
Whether to enable our custom ssh-keychain-fish-shell integration.

<!-- #### my.neovim.grammars -->
<!-- *type:* list\[string] \ -->
<!-- *default:* \[ ] \ -->
<!---->
<!-- Names of `pkgs.vimPlugins` packages to install as treesitter grammars. -->

## Philisophical Tips to Keep Your Head On Straight

- All configuration included by a nixosSystem as created by the flake should behave as if this is machine over which we have full, godlike control. Otherwise, we'd just be using home-manager!
- Declaring attrs separately is often more readable-- only group them when they only make sense together.
  - the options and config attrsets are probably exceptions (esp. since the latter is optional)
