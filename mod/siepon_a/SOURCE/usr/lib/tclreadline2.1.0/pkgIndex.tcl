#!/usr/local/bin/tclsh
# FILE: "/home/joze/src/tclreadline/pkgIndex.tcl.in"
# LAST MODIFICATION: "Sat, 01 Jul 2000 21:53:04 +0200 (joze)"
# (C) 1998 - 2000 by Johannes Zellner, <johannes@zellner.org>
# $Id: pkgIndex.tcl.in,v 2.3 2000/07/01 22:18:08 joze Exp $
# ---
# tclreadline -- gnu readline for tcl
# http://www.zellner.org/tclreadline/
# Copyright (c) 1998 - 2000, Johannes Zellner <johannes@zellner.org>
# This software is copyright under the BSD license.

package ifneeded tclreadline 2.1.0 \
    [list source [file join $dir tclreadlineInit.tcl]]
