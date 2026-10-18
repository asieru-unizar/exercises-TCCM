#!/bin/bash
# orca_summary.sh: one line per ORCA output with its status and final energy
# Usage: ./orca_summary.sh examples/*.out

if [ $# -eq 0 ]; then
    echo "Usage: $0 file.out [more files]"
    exit 1
fi

printf "%-22s %-8s %16s\n" "FILE" "STATUS" "ENERGY_Eh"

for f in "$@"; do
    if grep -q "ORCA TERMINATED NORMALLY" "$f"; then
        status="OK"
    elif grep -q "error termination" "$f"; then
        status="ERROR"
    else
        status="RUNNING"
    fi

    energy=$(grep "FINAL SINGLE POINT ENERGY" "$f" | tail -1 | awk '{print $5}')

    printf "%-22s %-8s %16s\n" "$(basename "$f")" "$status" "$energy"
done
