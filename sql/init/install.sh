#!/bin/bash

cd $HOME/db-sample-schemas
sqlplus system/oracle@localhost:1521 <<EOF
    @mksample oracle oracle HR OE PM IX SH BI users temp /logs localhost:1521
    quit
EOF
