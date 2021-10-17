# port-purescript-package

This repo contains a script `./port-purescript-package.sh`.  I use this script
to easily port a PureScript package to the
[PureNix](https://github.com/purenix-org/purenix) alternative Nix backend
for PureScript.

Some things are hard-coded in this script, so it is unlikely that someone would
be able to use it as-is for some other PureScript alternative backend.  But I
did want to share the code so that other people could get an idea of how to
semi-automate porting  a PureScript package to an alternative backend.
