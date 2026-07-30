# RFC: avoid duplicate SDK loading in periodic SIEPON-A Force Bridge replay

Severity: **Low** — recurring overhead is proven statically, but no failure or
measurable runtime impact has been attributed to it.

## Summary

With Force Bridge enabled, `Background_API.sh` starts a new `iros` process
every 30 seconds and reissues 32 classifier rules. `/etc/ca-iros.rc` already
loads `SC_COMMAND_LIB.tcl`, but `Background_API.tcl` loads the same 657,238-byte
SDK library again.

This patch skips the second SDK evaluation when the two required WCA commands
are already available. If either command is missing, the existing full-library
load remains the fallback.

Static review found no top-level hardware operation in the SDK Tcl file; it
initializes Tcl variables and defines procedures. The second evaluation
therefore appears redundant in the shipped path.

The replay interval, classifier rules, LLID ranges, Force Traffic behavior, and
OAM library are unchanged. Please review whether this small recurring cleanup
is worth adopting.

## Follow-up question

Does the firmware or SDK provide a reliable notification after OLT/DPoE
classifier provisioning completes?

If so, could the current 30-second replay be replaced by reapplying the Force
Bridge rules only when that notification occurs? If the notification cannot
cover every rule update, the current periodic reconciliation should remain
unchanged.

This PR does not change the rule-replay mechanism.

## Validation

- Tcl 8.5 tests passed for preloaded, standalone, and partial-load paths.
- Hardware-facing Tcl procedure bodies are unchanged.
- No firmware image has been built or tested on hardware.
