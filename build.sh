#!/bin/sh

set -e

FLAGS="-use-ocamlfind"
OCAMLBUILD=ocamlbuild

ocb()
{
  ocamlrpcgen -aux -clnt -srv -int unboxed -hyper unboxed OMRRPC.x
  $OCAMLBUILD $FLAGS $*
}

rule() {
  case $1 in
    clean)  ocb -clean;;
    native) ocb slave.native master.native;;
    depend) echo "Not needed.";;
    *)      echo "Unknown action $1";;
  esac;
}

if [ $# -eq 0 ]; then
  rule native
else
  while [ $# -gt 0 ]; do
    rule $1;
    shift
  done
fi