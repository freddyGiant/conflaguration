cd
# just exclude those dirs whether or not they're there, it's fine
rsync --verbose --recursive --relative --archive --copy-links \
  --exclude .local/share/Steam \
  --exclude .local/share/Trash/ \
  --exclude .local/state/nix \
  --exclude .local/state/home-manager \
  .local .zen .mozilla hm med projects sync \
  "backup/$USER/"
prevd
