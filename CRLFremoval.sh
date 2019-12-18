#!/usr/bin/bash
#cd /home/otisuser/install
for f in *.sh; do 
tr -d '\r' < "$f" > "$f-bk"
chown otisuser:otisuser "$f-bk"
rm -rf "$f"
done
for f in *.sh-bk; do 
    mv -- "$f" "${f%.sh-bk}.sh"
done
file *
