# exercises-TCCM

Small bash tools to launch ORCA calculations and read their outputs.
Practice repository for *Introduction to Linux, Session 5: Git and GitHub* (Universidad de Zaragoza).

## What is here

| File | What it does |
|---|---|
| `orca_summary.sh` | One line per ORCA output: file name, status (OK / ERROR / RUNNING) and final energy |
| `examples/` | Eleven small ORCA outputs to test the scripts on |
| `.gitignore` | Files Git must never track (job files, messages, scratch) |

The files in `examples/` are trimmed, synthetic outputs made for the course: they keep the input
and only the lines the scripts read, and their numbers are illustrative (B3LYP/def2-SVP-like).

| Output | Calculation | What to notice |
|---|---|---|
| `water_sp.out` | Single point | One energy, no optimisation, no frequencies |
| `water_opt.out` | Opt + Freq | A true minimum: no imaginary frequency |
| `methanol_opt.out` | Opt | Converged, but no frequencies were computed |
| `hcn_opt.out`, `hnc_opt.out` | Opt + Freq | The two isomers, both minima |
| `hcn_ts.out` | OptTS + Freq | The transition state between them: exactly one imaginary frequency |
| `ethane_stag_opt.out` | Opt + Freq | Staggered ethane: a minimum |
| `ethane_ecl_opt.out` | Opt + Freq | Eclipsed ethane: the optimisation "converged", but one imaginary frequency says it is not a minimum |
| `nh3_opt.out` | Opt, `MaxIter 5` | Ended normally, but the optimisation did **not** converge |
| `formaldehyde_opt.out` | Opt + Freq | Crashed in the first SCF: no energy at all |
| `benzene_opt.out` | Opt + Freq | Still running |

## Usage

```
./orca_summary.sh examples/*.out
```

```
FILE                   STATUS          ENERGY_Eh
benzene_opt.out        RUNNING    -232.245830119
ethane_ecl_opt.out     OK          -79.733251688
ethane_stag_opt.out    OK          -79.737952771
formaldehyde_opt.out   ERROR
hcn_opt.out            OK          -93.401351892
hcn_ts.out             OK          -93.324566038
hnc_opt.out            OK          -93.377602115
methanol_opt.out       OK         -115.671213574
nh3_opt.out            OK          -56.522290174
water_opt.out          OK          -76.320654207
water_sp.out           OK          -76.319548712
```

## How to contribute

1. Fork this repository on GitHub and clone **your fork**.
2. Create a branch named after your task: `git switch -c add-imaginary`
3. Change, test on `examples/*.out`, commit. Small commits with clear messages.
4. `git push -u origin add-imaginary` and open a pull request against this repository.

## Tasks

Pick one (pairs welcome). Each one is a branch and a pull request: the branch name is the task name.

| Branch | Level | Task |
|---|---|---|
| `no-energy` | easier | Print `no-energy` instead of an empty energy field (hint: `[ -z "$energy" ]`) |
| `no-file` | easier | Report `NOT FOUND` when a file given does not exist (hint: `[ ! -f "$f" ]`) |
| `help-option` | easier | Show the usage message with `-h`, as well as when no files are given (hint: `[ "$1" = "-h" ]`) |
| `add-converged` | intermediate | Print `NON-CONVERGED` after the energy when an optimisation has not converged (hint: `THE OPTIMIZATION HAS CONVERGED`, in capitals; a single point is not an optimisation) |
| `add-imaginary` | intermediate | Add an `I-FREQ` column with the number of imaginary frequencies; leave it empty when no frequency calculation was done (hint: `VIBRATIONAL FREQUENCIES`, then `grep -c "imaginary mode"`) |
| `unit-option` | hard | Add `-u kcal` and `-u kJ` to show the energies in kcal/mol or kJ/mol (hint: `getopts`, and multiply inside `awk`) |

Check your work on these files in particular: `water_sp`, `methanol_opt` and `nh3_opt` for
`add-converged`; `water_sp`, `methanol_opt`, `hcn_ts` and `ethane_ecl_opt` for `add-imaginary`;
`formaldehyde_opt` for `no-energy`.
