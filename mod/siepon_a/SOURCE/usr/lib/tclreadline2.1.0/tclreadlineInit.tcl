#!/usr/local/bin/tclsh
# FILE: "/home/joze/src/tclreadline/tclreadlineInit.tcl.in"
# LAST MODIFICATION: "Mit, 20 Sep 2000 19:29:26 +0200 (joze)"
# (C) 1998 - 2000 by Johannes Zellner, <johannes@zellner.org>
# $Id: tclreadlineInit.tcl.in,v 2.6 2000/09/20 17:44:34 joze Exp $
# ---
# tclreadline -- gnu readline for tcl
# http://www.zellner.org/tclreadline/
# Copyright (c) 1998 - 2000, Johannes Zellner <johannes@zellner.org>
# This software is copyright under the BSD license.

package provide tclreadline 2.1.0

namespace eval tclreadline:: {
    namespace export Init
}

proc ::tclreadline::Init {} {
    uplevel #0 {
	if ![info exists tclreadline::library] {
	    if [catch {load [file join /usr/lib libtclreadline[info sharedlibextension]]} msg] {
		puts stderr $msg
		exit 2
	    }
	}
    }
}

tclreadline::Init
::tclreadline::readline customcompleter ::tclreadline::ScriptCompleter

source [file join [file dirname [info script]] tclreadlineSetup.tcl]

set auto_index(::tclreadline::ScriptCompleter) \
[list source [file join [file dirname [info script]] tclreadlineCompleter.tcl]]
