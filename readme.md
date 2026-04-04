## Requirements

### OS Config

- **Currently, any use of OS Config utilizes Home Config as a module. Thus, all dependencies therein apply here too.**
- Presence of /etc/conflaguration-secreates/flake.nix

```
# /etc/conflaguration/secrets.nix
```

### Home Config

## Options

### OS Config

#### `my.username`
*type:* string matching `/^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$/`
*default:* `"vrad"`
System username (anticipate change). Overrides `home-manager.config.home.username` (`mkForce`).

## Philisophical Tips to Keep Your Head On Straight

- All configuration included by a nixosSystem as created by the flake should behave as if this is machine over which we have full, godlike control. Otherwise, we'd just be using home-manager!
- Declaring attrs separately is often more readable-- only group them when they only make sense together.
  - the options and config attrsets are probably exceptions (esp. since the latter is optional)
