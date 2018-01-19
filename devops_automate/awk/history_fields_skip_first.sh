history | grep '[0-9]  dnf install' | awk '{for (i=2; i <= NF; i++) printf FS$i; print NL }'






