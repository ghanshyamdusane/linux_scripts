#!/bin/bash

    EMAIL="dusanegs@gmail.com"

    EMAIL1="ghanshyam.dusane@yourdomain.com"

    SUBJECT="Alert $(hostname) Disk Space & Memory Status"

    TEMPFILE="/tmp/$(hostname)"

    echo "Hostname: $(hostname)" >> $TEMPFILE

    echo "Local Date & Time : $(date)" >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    echo "| Disk Space information : |" >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    /bin/df -h >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    echo "| Memory and Swap status: |" >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    /usr/bin/free -m >> $TEMPFILE

    echo "-------------------------------------------" >> $TEMPFILE

    mail -s "$SUBJECT" "$EMAIL" < $TEMPFILE

    mail -s "$SUBJECT" "$EMAIL1" < $TEMPFILE

    rm -f $TEMPFILE
