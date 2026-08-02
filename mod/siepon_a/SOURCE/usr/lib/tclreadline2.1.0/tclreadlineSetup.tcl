#!/usr/locanl/bin/tclsh
# FILE: "/home/joze/src/tclreadline/tclreadlineSetup.tcl.in"
# LAST MODIFICATION: "Sat, 01 Jul 2000 21:53:28 +0200 (joze)"
# (C) 1998 - 2000 by Johannes Zellner, <johannes@zellner.org>
# $Id: tclreadlineSetup.tcl.in,v 2.9 2000/07/01 22:18:08 joze Exp $
# ---
# tclreadline -- gnu readline for tcl
# http://www.zellner.org/tclreadline/
# Copyright (c) 1998 - 2000, Johannes Zellner <johannes@zellner.org>
# This software is copyright under the BSD license.


package provide tclreadline 2.1.0

proc unknown args {

    global auto_noexec auto_noload env unknown_pending tcl_interactive
    global errorCode errorInfo

    # Save the values of errorCode and errorInfo variables, since they
    # may get modified if caught errors occur below.  The variables will
    # be restored just before re-executing the missing command.

    set savedErrorCode $errorCode
    set savedErrorInfo $errorInfo
    set name [lindex $args 0]
    if ![info exists auto_noload] {
	#
	# Make sure we're not trying to load the same proc twice.
	#
	if [info exists unknown_pending($name)] {
	    return -code error "self-referential recursion in \"unknown\" for command \"$name\""
	}
	set unknown_pending($name) pending
	set ret [catch {auto_load $name [uplevel 1 {namespace current}]} msg]
	unset unknown_pending($name)
	if {$ret != 0} {
	    return -code $ret -errorcode $errorCode \
	    "error while autoloading \"$name\": $msg"
	}
	if ![array size unknown_pending] {
	    unset unknown_pending
	}
	if $msg {
	    set errorCode $savedErrorCode
	    set errorInfo $savedErrorInfo
	    set code [catch {uplevel 1 $args} msg]
	    if {$code ==  1} {
		#
		# Strip the last five lines off the error stack (they're
		    # from the "uplevel" command).
		#

		set new [split $errorInfo \n]
		set new [join [lrange $new 0 [expr [llength $new] - 6]] \n]
		return -code error -errorcode $errorCode \
		-errorinfo $new $msg
	    } else {
		return -code $code $msg
	    }
	}
    }

    # REMOVED THE [info script] TEST (joze, SEP 98)
    if {([info level] == 1) && [info exists tcl_interactive] && $tcl_interactive} {
	if ![info exists auto_noexec] {
	    set new [auto_execok $name]
	    if {$new != ""} {
		set errorCode $savedErrorCode
		set errorInfo $savedErrorInfo
		set redir ""
		if {[info commands console] == ""} {
		    set redir ">&@stdout <@stdin"
		}
		# LOOK FOR GLOB STUFF IN $ARGS (joze, SEP 98)
		return [uplevel eval exec $redir $new \
		[::tclreadline::Glob [lrange $args 1 end]]]
	    }
	}
	set errorCode $savedErrorCode
	set errorInfo $savedErrorInfo
	if {$name == "!!"} {
	    set newcmd [history event]
	} elseif {[regexp {^!(.+)$} $name dummy event]} {
	    set newcmd [history event $event]
	} elseif {[regexp {^\^([^^]*)\^([^^]*)\^?$} $name dummy old new]} {
	    set newcmd [history event -1]
	    catch {regsub -all -- $old $newcmd $new newcmd}
	}
	if [info exists newcmd] {
	    tclLog $newcmd
	    history change $newcmd 0
	    return [uplevel $newcmd]
	}

	set ret [catch {set cmds [info commands $name*]} msg]
	if {[string compare $name "::"] == 0} {
	    set name ""
	}
	if {$ret != 0} {
	    return -code $ret -errorcode $errorCode \
	    "error in unknown while checking if \"$name\" is a unique command abbreviation: $msg"
	}
	if {[llength $cmds] == 1} {
	    return [uplevel [lreplace $args 0 0 $cmds]]
	}
	if {[llength $cmds] != 0} {
	    if {$name == ""} {
		return -code error "empty command name \"\""
	    } else {
		return -code error \
		"ambiguous command name \"$name\": [lsort $cmds]"
	    }
	}
    }
    return -code error "invalid command name \"$name\""
}

namespace eval tclreadline {

namespace export Setup Loop InitTclCmds InitTkCmds Print ls

proc ls {args} {
	if {[exec uname -s] == "Linux"} {
		eval exec ls --color -FC [Glob $args]
	} else {
		eval exec ls -FC [Glob $args]
	}
}

proc Setup {args} {

    uplevel #0 {

	if {"" == [info commands ::tclreadline::readline]} {
	    ::tclreadline::Init
	}

	if {[catch {set a [::tclreadline::prompt1]}] && [info nameofexecutable] != ""} {

	    namespace eval ::tclreadline {
		variable prompt_string
		set base [file tail [info nameofexecutable]]

		if {[string match tclsh* $base] && [info exists tcl_version]} {
		    set prompt_string \
		    "\[0;31mtclsh$tcl_version\[0m"
		} elseif {[string match wish* $base] \
		    && [info exists tk_version]} {
			set prompt_string "\[0;34mwish$tk_version\[0m"
		    } else {
			set prompt_string "\[0;31m$base\[0m"
		    }

	    }

	    if {"" == [info procs ::tclreadline::prompt1]} {
		proc ::tclreadline::prompt1 {} {
		    variable prompt_string
		    global env
		    if {[catch {set pwd [pwd]} tmp]} {
			set pwd "unable to get pwd"
		    }

		    if [info exists env(HOME)] {
			regsub $env(HOME) $pwd "~" pwd
		    }
		    return "$prompt_string \[$pwd\]"
		}
	    }
	    # puts body=[info body ::tclreadline::prompt1]
	}

	if {"" == [info procs exit]} {

	    catch {rename ::tclreadline::Exit ""}
	    rename exit ::tclreadline::Exit

	    proc exit {args} {

		if {[catch {
		    ::tclreadline::readline write \
		    [::tclreadline::HistoryFileGet]
		} ::tclreadline::errorMsg]} {
		    puts stderr $::tclreadline::errorMsg
		}

		# this call is ignored, if tclreadline.c
		# was compiled with CLEANUP_AFER_SIGNAL
		# not defined. This is the case for
		# older versions of libreadline.
		#
		::tclreadline::readline reset-terminal

		if [catch "eval ::tclreadline::Exit $args" message] {
		    puts stderr "error:"
		    puts stderr "$message"
		}
		# NOTREACHED
	    }
	}

    }

    global env
    variable historyfile

    if {[string trim [llength ${args}]]} {
	set historyfile ""
	catch {
	    set historyfile [file nativename [lindex ${args} 0]]
	}
	if {"" == [string trim $historyfile]} {
	    set historyfile [lindex ${args} 0]
	}
    } else {
	if [info exists env(HOME)] {
	    set historyfile  $env(HOME)/.tclsh-history
	} else {
	    set historyfile  .tclsh-history
	}
    }
    set ::tclreadline::errorMsg [readline initialize $historyfile]
    if {$::tclreadline::errorMsg != ""} {
	puts stderr $::tclreadline::errorMsg
    }

    # InitCmds

    rename Setup ""
}

proc HistoryFileGet {} {
    variable historyfile
    return $historyfile
}

# obsolete
#
proc Glob {string} {

    set commandstring ""
    foreach name $string {
	set replace [glob -nocomplain -- $name]
	if {$replace == ""} {
	    lappend commandstring $name
	} else {
	    lappend commandstring $replace
	}
    }
    # return $commandstring
    # Christian Krone <krischan@sql.de> proposed
    return [eval concat $commandstring]
}



proc Loop {args} {

    eval Setup ${args}

    uplevel #0 {

	while {1} {

	    if [info exists tcl_prompt2] {
		set prompt2 $tcl_prompt2
	    } else {
		set prompt2 ">"
	    }

	    if {[catch {
		if {"" != [namespace eval ::tclreadline {info procs prompt1}]} {
		    set LINE [::tclreadline::readline read \
		    [::tclreadline::prompt1]]
		} else {
		    set LINE [::tclreadline::readline read %]
		}
		while {![::tclreadline::readline complete $LINE]} {
		    append LINE "\n"
		    append LINE [tclreadline::readline read ${prompt2}]
		}
	    } ::tclreadline::errorMsg]} {
		puts stderr [list tclreadline::Loop: error. \
		$::tclreadline::errorMsg]
		continue
	    }

	    # Magnus Eriksson <magnus.eriksson@netinsight.se> proposed
	    # to add the line also to tclsh's history.
	    #
	    # I decided to add only lines which are different from
	    # the previous one to the history. This is different
	    # from tcsh's behaviour, but I found it quite convenient
	    # while using mshell on os9.
	    #
	    if {[string length $LINE] && [history event 0] != $LINE} {
		history add $LINE
	    }

	    if [catch {
		set result [eval $LINE]
		if {$result != "" && [tclreadline::Print]} {
		    puts $result
		}
		set result ""
	    } ::tclreadline::errorMsg] {
		puts stderr $::tclreadline::errorMsg
		puts stderr [list while evaluating $LINE]
	    }

	}
    }
}

proc Print {args} {
    variable PRINT
    if ![info exists PRINT] {
	set PRINT yes
    }
    if [regexp -nocase \(true\|yes\|1\) $args] {
	set PRINT yes
    } elseif [regexp -nocase \(false\|no\|0\) $args] {
	set PRINT no
    }
    return $PRINT
}
# 
# 
# proc InitCmds {} {
#     # XXX
#     return 
#     # XXX
#     global tcl_version tk_version
#     if {[info exists tcl_version]} {
#         InitTclCmds
#     }
#     if {[info exists tk_version]} {
#         InitTkCmds
#     }
#     rename InitCmds ""
# }
# 
# proc InitTclCmds {} {
#     variable known_cmds
#     foreach line {
#         "after option ?arg arg ...?"
#         "append varName ?value value ...?"
#         "array option arrayName ?arg ...?"
#         "bgerror"
#         "break"
#         "catch command ?varName?"
#         "cd"
#         "clock"
#         "close <channelId>"
#         "concat"
#         "continue"
#         "eof <channelId>"
#         "error message ?errorInfo? ?errorCode?"
#         "eval arg ?arg ...?"
#         "exec ?switches? arg ?arg ...?"
#         "exit ?returnCode?"
#         "fblocked <channelId>"
#         "for start test next command"
#         "foreach varList list ?varList list ...? command"
#         "format formatString ?arg arg ...?"
#         "gets channelId ?varName?"
#         "glob"
#         "global varName ?varName ...?"
#         "incr varName ?increment?"
#         "info option ?arg arg ...?"
#         "interp cmd ?arg ...?"
#         "join list ?joinString?"
#         "lappend varName ?value value ...?"
#         "lindex list index"
#         "linsert list <index> <element> ?element ...?"
#         "list"
#         "llength list"
#         "lrange list first last"
#         "lreplace list first last ?element element ...?"
#         "lsearch ?mode? list pattern"
#         "lsort ?options? list"
#         "namespace"
#         "package option ?arg arg ...?"
#         "proc name args body"
#         "read ?-nonewline? channelId"
#         "regexp ?switches? exp string ?matchVar? ?subMatchVar subMatchVar ...?"
#         "rename oldName newName"
#         "scan <string> <format> ?varName varName ...?"
#         "set varName ?newValue?"
#         "split <string> ?splitChars?"
#         "subst ?-nobackslashes? ?-nocommands? ?-novariables? string"
#         "switch ?switches? string pattern body ... ?default body?"
#         "time <command> ?count?"
#         "unknown <cmdName> ?arg? ?...?"
#         "uplevel ?level? command ?arg ...?"
#         "vwait name"
#         "while test command"
#     } {
#         readline add $line
#         set known_cmds([lindex $line 0]) ${line}
#     }
#     rename InitTclCmds ""
# }
# 
# proc InitTkCmds {} {
#     variable known_cmds
#     foreach line {
#         "bind window ?pattern? ?command?"
#         "bindtags window ?tags?"
#         "button pathName ?options?"
#         "canvas pathName ?options?"
#         "checkbutton pathName ?options?"
#         "clipboard option ?arg arg ...?"
#         "entry pathName ?options?"
#         "event option ?arg1?"
#         "font option ?arg?"
#         "frame pathName ?options?"
#         "grab option ?arg arg ...?"
#         "grid option arg ?arg ...?"
#         "image option ?args?"
#         "label pathName ?options?"
#         "listbox pathName ?options?"
#         "lower window ?belowThis?"
#         "menu pathName ?options?"
#         "menubutton pathName ?options?"
#         "message pathName ?options?"
#         "option cmd arg ?arg ...?"
#         "pack option arg ?arg ...?"
#         "radiobutton pathName ?options?"
#         "raise window ?aboveThis?"
#         "scale pathName ?options?"
#         "scrollbar pathName ?options?"
#         "selection option ?arg arg ...?"
#         "send ?options? interpName arg ?arg ...?"
#         "text pathName ?options?"
#         "tk option ?arg?"
#         "tkwait variable|visibility|window name"
#         "toplevel pathName ?options?"
#         "winfo option ?arg?"
#         "wm option window ?arg ...?"
#     } {
#         readline add $line
#         set known_cmds([lindex $line 0]) ${line}
#     }
#     rename InitTkCmds ""
# }
# 


}; # namespace tclreadline
