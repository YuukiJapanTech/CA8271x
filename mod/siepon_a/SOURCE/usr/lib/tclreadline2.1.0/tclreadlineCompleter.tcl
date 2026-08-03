# -*- tclsh -*-
# FILE: "/home/joze/src/tclreadline/tclreadlineCompleter.tcl"
# LAST MODIFICATION: "Sat, 01 Jul 2000 16:15:55 +0200 (joze)"
# (C) 1998 - 2000 by Johannes Zellner, <johannes@zellner.org>
# $Id: tclreadlineCompleter.tcl,v 2.23 2000/07/01 14:23:17 joze Exp $
# vim:set ts=4:
# ---
#
# tclreadline -- gnu readline for tcl
# http://www.zellner.org/tclreadline/
# Copyright (c) 1998 - 2000, Johannes Zellner <johannes@zellner.org>
#
# This software is copyright under the BSD license.
#
# ================================================================== 


# TODO:
#
#	- tcltest is missing
#	- better completion for CompleteListFromList:
#	  RemoveUsedOptions ...
#	- namespace eval fred {... <-- continue with a 
#								   substitution in fred.
#	- set tclreadline::pro<tab> doesn't work
#	  set ::tclreadline::pro<tab> does
#
#   - TextObj ...
#



namespace eval tclreadline {

	# the following three are from the icccm
	# and used in complete(selection) and
	# descendants.
	#
	variable selection-selections {
		PRIMARY SECONDARY CLIPBOARD
	}
	variable selection-types {
		ADOBE_PORTABLE_DOCUMENT_FORMAT
		APPLE_PICT
		BACKGROUND
		BITMAP
		CHARACTER_POSITION
		CLASS
		CLIENT_WINDOW
		COLORMAP
		COLUMN_NUMBER
		COMPOUND_TEXT
		DELETE
		DRAWABLE
		ENCAPSULATED_POSTSCRIPT
		ENCAPSULATED_POSTSCRIPT_INTERCHANGE
		FILE_NAME
		FOREGROUND
		HOST_NAME
		INSERT_PROPERTY
		INSERT_SELECTION
		LENGTH
		LINE_NUMBER
		LIST_LENGTH
		MODULE
		MULTIPLE
		NAME
		ODIF
		OWNER_OS
		PIXMAP
		POSTSCRIPT
		PROCEDURE
		PROCESS
		STRING
		TARGETS
		TASK
		TEXT
		TIMESTAMP
		USER
	}
	variable selection-formats {
		APPLE_PICT
		ATOM
		ATOM_PAIR
		BITMAP
		COLORMAP
		COMPOUND_TEXT
		DRAWABLE
		INTEGER
		NULL
		PIXEL
		PIXMAP7
		SPAN
		STRING
		TEXT
		WINDOW
	}

namespace export \
TryFromList CompleteFromList DisplayHints Rehash \
PreviousWord CommandCompletion RemoveUsedOptions \
HostList ChannelId InChannelId OutChannelId \
Lindex Llength CompleteBoolean WidgetChildren

# set tclreadline::trace to 1, if you
# want to enable explicit trace calls.
#
variable trace

# set tclreadline::trace_procs to 1, if you
# want to enable tracing every entry to a proc.
#
variable trace_procs

if {[info exists trace_procs] && $trace_procs} {
	::proc proc {name arguments body} {
		::proc $name $arguments [subst -nocommands {
			TraceText [lrange [info level 0] 1 end]
			$body
		}]
	}
} else { ;# !$trace_procs
	catch {rename ::tclreadline::proc ""}
}

if {[info exists trace] && $trace} {

	::proc TraceReconf {args} {
		eval .tclreadline_trace.scroll set $args
		.tclreadline_trace.text see end
	}

	::proc AssureTraceWindow {} {
		variable trace
		if {![info exists trace]} {
			return 0
		}
		if {!$trace} {
			return 0
		}
		if {![winfo exists .tclreadline_trace.text]} {
			toplevel .tclreadline_trace
			text .tclreadline_trace.text \
				-yscrollcommand { tclreadline::TraceReconf } \
				-wrap none
			scrollbar .tclreadline_trace.scroll \
				-orient vertical \
				-command { .tclreadline_trace.text yview }
			pack .tclreadline_trace.text -side left -expand yes -fill both
			pack .tclreadline_trace.scroll -side right -expand yes -fill y
		} else {
			raise .tclreadline_trace
		}
		return 1
	}

	::proc TraceVar vT {
		if {![AssureTraceWindow]} {
			return
		}
		upvar $vT v
		if {[info exists v]} {
			.tclreadline_trace.text insert end \
			"([lindex [info level -1] 0]) $vT=|$v|\n"
		}
		# silently ignore unset variables.
	}

	::proc TraceText txt {
		if {![AssureTraceWindow]} {
			return
		}
		.tclreadline_trace.text insert end \
		[format {%32s %s} ([lindex [info level -1] 0]) $txt\n]
	}

} else {
	::proc TraceReconf args {}
	::proc AssureTraceWindow args {}
	::proc TraceVar args {}
	::proc TraceText args {}
}

#**
# TryFromList will return an empty string, if
# the text typed so far does not match any of the
# elements in list. This might be used to allow
# subsequent filename completion by the builtin
# completer.
# If inhibit is non-zero, the result will be
# formatted such that readline will not insert
# a space after a complete (single) match.
#
proc TryFromList {text lst {allow ""} {inhibit 0}} {

	# puts stderr "(CompleteFromList) \ntext=|$text|"
	# puts stderr "(CompleteFromList) lst=|$lst|"
	set pre [GetQuotedPrefix ${text}]
	set matches [MatchesFromList ${text} ${lst} ${allow}]

	# puts stderr "(CompleteFromList) matches=|$matches|"
	if {1 == [llength $matches]} { ; # unique match
		# puts stderr \nunique=$matches\n
		# puts stderr "\n|${pre}${matches}[Right ${pre}]|\n"
		set null [string index $matches 0]
		if {("<" == ${null} || "?" == ${null}) && \
			-1 == [string first ${null} ${allow}]
		} {
			set completion [string trim "[list $text] $lst"]
		} else {
			set completion [string trim ${pre}${matches}[Right ${pre}]]
		}
		if {$inhibit} {
			return [list $completion {}]
		} else {
			return $completion
		}
	} elseif {"" != ${matches}} {
		# puts stderr \nmore=$matches\n
		set longest [CompleteLongest ${matches}]
		# puts stderr longest=|$longest|
		if {"" == $longest} {
			return [string trim "[list $text] ${matches}"]
		} else {
			return [string trim "${pre}${longest} ${matches}"]
		}
	} else {
		return ""; # nothing to complete
	}
}

#**
# CompleteFromList will never return an empty string.
# completes, if a completion can be done, or ring
# the bell if not. If inhibit is non-zero, the result
# will be formatted such that readline will not insert
# a space after a complete (single) match.
#
proc CompleteFromList {text lst {allow ""} {inhibit 0}} {
	set result [TryFromList ${text} ${lst} ${allow} ${inhibit}]
	if {![llength ${result}]} {
		Alert
		# return [string trim [list ${text}] ${lst}"]
		if {[llength ${lst}]} {
			return [string trim "${text} ${lst}"]
		} else {
			return [string trim [list ${text} {}]]
		}
	} else {
		return ${result}
	}
}

#**
# CompleteBoolean does a CompleteFromList
# with a list of all valid boolean values.
#
proc CompleteBoolean {text} {
	return [CompleteFromList $text {yes no true false 1 0}]
}

#**
# build a list of all executables which can be
# found in $env(PATH). This is (naturally) a bit
# slow, and should not called frequently. Instead
# it is a good idea to check if the variable
# `executables' exists and then just use it's
# content instead of calling Rehash.
# (see complete(exec)).
# 
proc Rehash {} {

	global env
	variable executables

	if {![info exists env] || ![array exists env]} {
		return
	}
	if {![info exists env(PATH)]} {
		return
	}

	set executables 0
	foreach dir [split $env(PATH) :] {
		if {[catch [list set files [glob -nocomplain ${dir}/*]]]} { continue }
		foreach file $files {
			if {[file executable $file]} {
				lappend executables [file tail ${file}]
			}
		}
	}
}

#**
# build a list hosts from the /etc/hosts file.
# this is only done once. This is sort of a
# dirty hack, /etc/hosts is hardcoded ...
# But on the other side, if the user supplies
# a valid host table in tclreadline::hosts
# before entering the event loop, this proc
# will return this list.
# 
proc HostList {} {
	# read the host table only once.
	#
	variable hosts
	if {![info exists hosts]} {
		catch {
			set hosts ""
			set id [open /etc/hosts r]
			if {0 != ${id}} {
				while {-1 != [gets ${id} line]} {
					regsub {#.*} ${line} {} line
					if {[llength ${line}] >= 2} {
						lappend hosts [lindex ${line} 1]
					}
				}
				close ${id} 
			} 
		}
	}
	return ${hosts} 
}

#**
# never return an empty string, never complete.
# This is useful for showing options lists for example.
#
proc DisplayHints {lst} {
	return [string trim "{} ${lst}"]
}

#**
# find (partial) matches for `text' in `lst'. Ring
# the bell and return the whole list, if the user
# tries to complete ?..? options or <..> hints.
#
# MatchesFromList returns a list which is not suitable
# for passing to the readline completer. Thus,
# MatchesFromList should not be called directly but
# from formatting routines as TryFromList.
#
proc MatchesFromList {text lst {allow ""}} {
	set result ""
	set text [StripPrefix $text]
	set null [string index $text 0]
	foreach char {< ?} {
		if {$char == $null && -1 == [string first $char $allow]} {
			Alert
			return $lst
		}
	}
	# puts stderr "(MatchesFromList) text=$text"
	# puts stderr "(MatchesFromList) lst=$lst"
	foreach word $lst {
		if {[string match ${text}* ${word}]} {
			lappend result ${word}
		}
	}
	return [string trim $result]
}

#**
# invoke cmd with a (hopefully) invalid string and
# parse the error message to get an option list.
# The strings are carefully chosen to match the
# results produced by known tcl routines. It's a
# pity, that not all object commands generate
# standard error messages!
#
# @param   cmd
# @return  list of options for cmd
# @date    Sep-14-1999
#
proc TrySubCmds {text cmd} {

	set trystring ----

	# try the command with and w/o trystring.
	# Some commands, e.g.
	#     .canvas bind
	# return an error if invoked w/o arguments
	# but not, if invoked with arguments. Breaking
	# the loop is eventually done at the end ...
	#
	for {set str ${trystring}} {1} {set str ""} {

		set code [catch {set result [eval ${cmd} ${str}]} msg]
		set result ""

		if {$code} {
			set tcmd [string trim ${cmd}]
			# puts stderr msg=$msg
			# XXX see
			#         tclIndexObj.c
			#         tkImgPhoto.c
			# XXX
			if {[regexp \
				{(bad|ambiguous|unrecognized) .*"----": *must *be( .*$)} \
				${msg} all junk raw]
			} {
				regsub -all -- , ${raw} { } raw
				set len [llength ${raw}]
				set len_2 [expr ${len} - 2]
				for {set i 0} {${i} < ${len}} {incr i} {
					set word [lindex ${raw} ${i}]
					if {"or" != ${word} && ${i} != ${len_2}} {
						lappend result ${word}
					}
				}
				if {[string length ${result}] && \
					-1 == [string first ${trystring} ${result}]
				} {
					return [TryFromList ${text} ${result}]
				}

			} elseif {[regexp \
				"wrong # args: should be \"?${tcmd}\[^ \t\]*\(.*\[^\"\]\)" \
				${msg} all hint]

			} {

				# XXX see tclIndexObj.c XXX
				if {-1 == [string first ${trystring} ${hint}]} {
					return [DisplayHints [list <[string trim $hint]>]]
				}
			} else {
				# check, if it's a blt error msg ...
				#
				set msglst [split ${msg} \n]
				foreach line ${msglst} {
					if {[regexp "${tcmd}\[ \t\]\+\(\[^ \t\]*\)\[^:\]*$" \
						${line} all sub]
					} {
						lappend result [list ${sub}]
					}
				}
				if {[string length ${result}] && \
					-1 == [string first ${trystring} ${result}]
				} {
					return [TryFromList ${text} ${result}]
				}
			}
		}
		if {"" == ${str}} {
			break
		}
	}
	return ""
}

#**
# try to get casses for commands which
# allow `configure' (cget).
# @param  command.
# @param  optionsT where the table will be stored.
# @return number of options
# @date   Sat-Sep-18
#
proc ClassTable {cmd} {

	# first we build an option table.
	# We always use `configure' here,
	# because cget will not return the
	# option table.
	#
	if {[catch [list set option_table [eval ${cmd} configure]] msg]} {
		return ""
	}
	set classes ""
	foreach optline ${option_table} {
		if {5 != [llength ${optline}]} continue else {
			lappend classes [lindex ${optline} 2]
		}
	}
	return ${classes}
}

#**
# try to get options for commands which
# allow `configure' (cget).
# @param command.
# @param optionsT where the table will be stored.
# @return number of options
# @date Sep-14-1999
#
proc OptionTable {cmd optionsT} {
	upvar $optionsT options
	# first we build an option table.
	# We always use `configure' here,
	# because cget will not return the
	# option table.
	#
	if {[catch [list set option_table [eval ${cmd} configure]] msg]} {
		return 0
	}
	set retval 0
	foreach optline ${option_table} {
		if {5 == [llength ${optline}]} {
			# tk returns a list of length 5
			lappend options(switches) [lindex ${optline} 0]
			lappend options(value)    [lindex ${optline} 4]
			incr retval
		} elseif {3 == [llength ${optline}]} {
			# itcl returns a list of length 3
			lappend options(switches) [lindex ${optline} 0]
			lappend options(value)    [lindex ${optline} 2]
			incr retval
		}
	}
	return $retval
}

#**
# try to complete a `cmd configure|cget ..' from the command's options.
# @param   text start line cmd, standard tclreadlineCompleter arguments.
# @return  -- a flag indicating, if (cget|configure) was found.
# @return  resultT -- a tclreadline completer formatted string.
# @date    Sep-14-1999
#
proc CompleteFromOptions {text start line resultT} {

	upvar ${resultT} result
	set result ""

	# check if either `configure' or `cget' is present.
	#
	set lst [ProperList ${line}]
	foreach keyword {configure cget} {
		set idx [lsearch ${lst} ${keyword}]
		if {-1 != ${idx}} {
			break
		}
	}
	if {-1 == ${idx}} {
		return 0
	}

	if {[regexp {(cget|configure)$} ${line}]} {
		# we are at the end of (configure|cget)
		# but there's no space yet.
		#
		set result ${text}
		return 1
	}

	# separate the command, but exclude (cget|configure)
	# because cget won't return the option table. Instead
	# OptionTable always uses `configure' to get the
	# option table.
	#
	set cmd [lrange ${lst} 0 [expr ${idx} - 1]]

	TraceText ${cmd}
	if {0 < [OptionTable ${cmd} options]} {

		set prev [PreviousWord ${start} ${line}]
		if {-1 != [set found [lsearch -exact $options(switches) ${prev}]]} {

			# complete only if the user has not
			# already entered something here.
			#
			if {![llength ${text}]} {

				# check first, if the SpecificSwitchCompleter
				# knows something about this switch. (note that
				# `prev' contains the switch). The `0' as last
				# argument makes the SpecificSwitchCompleter
				# returning "" if it knows nothing specific
				# about this switch.
				#
				set values [SpecificSwitchCompleter \
				${text} ${start} ${line} ${prev} 0]

				if [string length ${values}] {
					set result ${values}
					return 1
				} else {
					set val [lindex $options(value) ${found}]
					if [string length ${val}] {
						# return the old value only, if it's non-empty.
						# Use this double list to quote option
						# values which have to be quoted.
						#
						set result [list [list ${val}]]
						return 1
					} else {
						set result ""
						return 1
					}
				}
			} else {
				set result [SpecificSwitchCompleter \
				${text} ${start} ${line} ${prev} 1]
				return 1
			}

		} else {
			set result [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} $options(switches)]]
			return 1
		}
	}
	return 1
}

proc ObjectClassCompleter {text start end line pos resultT} {
	upvar ${resultT} result
	set cmd [Lindex ${line} 0]
	if {"." == [string index ${line} 0]} {
		# it's a widget. Try to get it's class name.
		#
		if {![catch [list set class [winfo class [Lindex ${line} 0]]]]} {
			if {[string length [info proc ${class}Obj]]} {
				set result [${class}Obj ${text} ${start} ${end} ${line} ${pos}]
				# puts stderr result=|$result|
				# joze, Thu Sep 30 16:43:17 1999
				if {[string length $result]} {
					return 1
				} else {
					return 0
				}
			} else {
				return 0
			}
		}
	}
	if {![catch [list set type [image type ${cmd}]]]} {
		switch -- ${type} {
			photo {
				set result [PhotoObj ${text} ${start} ${end} ${line} ${pos}]
				return 1
			}
			default {
				# let the fallback completers do the job.
				return 0
			}
		}
	}
	return 0
}

proc CompleteFromOptionsOrSubCmds {text start end line pos} {
	if [CompleteFromOptions ${text} ${start} ${line} from_opts] {
		# always return, if CompleteFromOptions returns non-zero,
		# that means (configure|cget) were present. This ensures
		# that TrySubCmds will not configure something by chance.
		#
		return ${from_opts}
	} else {
		# puts stderr \n\n[lrange [ProperList ${line}] 0 [expr $pos - 1]]\n
		return [TrySubCmds ${text} \
		[lrange [ProperList ${line}] 0 [expr $pos - 1]]]
	}
	return ""
}

#**
# TODO: shit. make this better!
# @param  text, a std completer argument (current word).
# @param  fullpart, the full text of the current position.
# @param  lst, the list to complete from.
# @param  pre, leading `quote'.
# @param  sep, word separator.
# @param  post, trailing `quote'.
# @return a formatted completer string.
# @date   Sep-15-1999
#
proc CompleteListFromList {text fullpart lst pre sep post} {

	# puts stderr ""
	# puts stderr text=|$text|
	# puts stderr lst=|$lst|
	# puts stderr pre=|$pre|
	# puts stderr sep=|$sep|
	# puts stderr post=|$post|

	if {![string length ${fullpart}]} {

		# nothing typed so far. Insert a $pre
		# and inhibit further completion.
		#
		return [list ${pre} {}]

	} elseif {${post} == [String index ${text} end]} {

		# finalize, append the post and a space.
		#
		set diff \
		[expr [CountChar ${fullpart} ${pre}] - [CountChar ${fullpart} ${post}]]
		for {set i 0} {${i} < ${diff}} {incr i} {
			append text ${post}
		}
		append text " "
		return ${text}

	} elseif {![regexp -- ^\(.*\[${pre}${sep}\]\)\(\[^${pre}${sep}\]*\)$ \
		${text} all left right]
	} {
		set left {}
		set right ${text}
	}

	# TraceVar left
	# TraceVar right

	# puts stderr \nleft=|$left|
	# puts stderr \nright=|$right|
	set exact_matches [MatchesFromList ${right} ${lst}]
	# TODO this is awkward. Think of making it better!
	#
	if {1 == [llength ${exact_matches}] && -1 != [lsearch ${lst} ${right}]
	} {
		#set completion [CompleteFromList ${right} [list ${sep} ${post}] 1]
		return [list ${left}${right}${sep} {}]
	} else {
		set completion [CompleteFromList ${right} ${lst} "" 1]
	}
	# puts stderr \ncompletion=|$completion|
	if {![string length [lindex $completion 0]]} {
		return [concat [list ${left}] [lrange $completion 1 end]]
	} elseif {[string length ${left}]} {
		return [list ${left}]${completion}
	} else {
		return ${completion}
	}
	return ""
}

proc FirstNonOption {line} {
	set expr_pos 1
	foreach word [lrange ${line} 1 end] {; # 0 is the command itself
		if {"-" != [string index ${word} 0]} {
			break
		} else {
			incr expr_pos
		}
	}
	return ${expr_pos}
}

proc RemoveUsedOptions {line opts {terminate {}}} {
	if {[llength ${terminate}]} {
		if {[regexp -- ${terminate} ${line}]} {
			return ""
		}
	}
	set new ""
	foreach word ${opts} {
		if {-1 == [string first ${word} ${line}]} {
			lappend new ${word}
		}
	}

	# check if the last word in the line is an options
	# and if this word is at the very end of the line,
	# that means no space after.
	# If this is so, the word is stuffed into the result,
	# so that it can be completed -- probably with a space.
	#
	set last [Lindex ${line} end]
	if {[expr [string last ${last} ${line}] + [string length ${last}]] == \
		[string length ${line}]
	} {
		if {-1 != [lsearch ${opts} ${last}]} {
			lappend new ${last}
		}
	}

	return [string trim ${new}]
}

proc Alert {} {
	::tclreadline::readline bell
}

#**
# get the longest common completion
# e.g. str == {tcl_version tclreadline_version tclreadline_library}
# --> [CompleteLongest ${str}] == "tcl"
#
proc CompleteLongest {str} {
	# puts stderr str=$str
	set match0 [lindex ${str} 0]
	set len0 [string length $match0]
	set no_matches [llength ${str}]
	set part ""
	for {set i 0} {$i < $len0} {incr i} {
		set char [string index $match0 $i]
		for {set j 1} {$j < $no_matches} {incr j} {
			if {$char != [string index [lindex ${str} $j] $i]} {
				break
			}
		}
		if {$j < $no_matches} {
			break
		} else {
			append part $char
		}
	}
	# puts stderr part=$part
	return ${part}
}

proc SplitLine {start line} {
	set depth 0
	# puts stderr SplitLine
	for {set i $start} {$i >= 0} {incr i -1} {
		set c [string index $line $i]
		if {{;} == $c} {
			incr i; # discard command break character
			return [list [expr $start - $i] [String range $line $i end]]
		} elseif {{]} == $c} {
			incr depth
		} elseif {{[} == $c} {
			incr depth -1
			if {$depth < 0} {
				incr i; # discard command break character
				return [list [expr $start - $i] [String range $line $i end]]
			}
		}
	}
	return ""
}

proc IsWhite {char} {
	if {" " == $char || "\n" == $char || "\t" == $char} {
		return 1
	} else {
		return 0
	}
}

proc PreviousWordOfIncompletePosition {start line} {
	return [lindex [ProperList [string range ${line} 0 ${start}]] end]
}

proc PreviousWord {start line} {
	incr start -1
	set found 0
	for {set i $start} {$i > 0} {incr i -1} {
		set c [string index $line $i]
		if {${found} && [IsWhite $c]} {
			break
		} elseif {!${found} && ![IsWhite $c]} {
			set found 1
		}
	}
	return [string trim [string range ${line} $i $start]]
}

proc Quote {value left} {
	set right [Right ${left}]
	if {1 < [llength $value] && "" == $right} {
		return [list \"${value}\"]
	} else {
		return [list ${left}${value}${right}]
	}
}

# the following two channel proc's make use of
# the brandnew (Sep 99) `file channels' command
# but have some fallback behaviour for older
# tcl version.
#
proc InChannelId {text {switches ""}} {
	if [catch {set chs [file channels]}] {
		set chs {stdin}
	}
	set result ""
	foreach ch $chs {
		if {![catch {fileevent $ch readable}]} {
			lappend result $ch
		}
	}
	return [ChannelId ${text} <inChannel> $result $switches]
}

proc OutChannelId {text {switches ""}} {
	if [catch {set chs [file channels]}] {
		set chs {stdout stderr}
	}
	set result ""
	foreach ch $chs {
		if {![catch {fileevent $ch writable}]} {
			lappend result $ch
		}
	}
	return [ChannelId ${text} <outChannel> $result $switches]
}

proc ChannelId {text {descript <channelId>} {chs ""} {switches ""}} {
	if {"" == ${chs}} {
		# the `file channels' command is present
		# only in pretty new versions.
		#
		if [catch {set chs [file channels]}] {
			set chs {stdin stdout stderr}
		}
	}
	if {[llength [set channel [TryFromList ${text} "${chs} ${switches}"]]]} {
		return ${channel}
	} else {
		return [DisplayHints [string trim "${descript} ${switches}"]]
	}
}

proc QuoteQuotes {line} {
	regsub -all -- \" $line {\"} line
	regsub -all -- \{ $line {\{} line; # \}\} (keep the editor happy)
	return $line
}

#**
# get the word position.
# @return the word position
# @note will returned modified values.
# @sa EventuallyEvaluateFirst
# @date Sep-06-1999
#
# % p<TAB>
# % bla put<TAB> $b
# % put<TAB> $b
# part  == put
# start == 0
# end   == 3
# line  == "put $b"
# [PartPosition] should return 0
#
proc PartPosition {partT startT endT lineT} {

	upvar $partT part $startT start $endT end $lineT line
	EventuallyEvaluateFirst part start end line
	return [Llength [string range $line 0 [expr $start - 1]]]

# 
#     set local_start [expr $start - 1]
#     set local_start_chr [string index $line $local_start]
#     if {"\"" == $local_start_chr || "\{" == $local_start_chr} {
#         incr local_start -1
#     }
# 
#     set pre_text [QuoteQuotes [string range $line 0 $local_start]]
#     return [llength $pre_text]
# 
}

proc Right {left} {
	# puts left=$left
	if {"\"" == $left} {
		return "\""
	} elseif {"\\\"" == $left} {
		return "\\\""
	} elseif {"\{" == $left} {
		return "\}"
	} elseif {"\\\{" == $left} {
		return "\\\}"
	}
	return ""
}

proc GetQuotedPrefix {text} {
	set null [string index $text 0]
	if {"\"" == $null || "\{" == $null} {
		return \\$null
	} else {
		return {}
	}
}

proc CountChar {line char} {
	# puts stderr char=|$char|
	set found 0
	set pos 0
	while {-1 != [set pos [string first $char $line $pos]]} {
		incr pos
		incr found
	}
	return $found
}

#**
# make a proper tcl list from an icomplete
# string, that is: remove the junk. This is
# complementary to `IncompleteListRemainder'.
# e.g.:
#       for {set i 1} "
#  -->  for {set i 1}
#
proc ProperList {line} {
	set last [expr [string length $line] - 1]
	for {set i $last} {$i >= 0} {incr i -1} {
		if {![catch {llength [string range $line 0 $i]}]} {
			break
		}
	}
	return [string range $line 0 $i]
}

#**
# return the last part of a line which
# prevents the line from beeing a list.
# This is complementary to `ProperList'.
#
proc IncompleteListRemainder {line} {
	set last [expr [string length $line] - 1]
	for {set i $last} {$i >= 0} {incr i -1} {
		if {![catch {llength [string range $line 0 $i]}]} {
			break
		}
	}
	incr i
	return [String range $line $i end]
}

#**
# save `lindex'. works also for non-complete lines
# with opening parentheses or quotes.
# usage as `lindex'.
# Eventually returns the Rest of an incomplete line,
# if the index is `end' or == [Llength $line].
#
proc Lindex {line pos} {
	if {[catch [list set sub [lindex ${line} ${pos}]]]} {
		if {"end" == ${pos} || [Llength ${line}] == ${pos}} {
			return [IncompleteListRemainder ${line}]
		}
		set line [ProperList ${line}]
		# puts stderr \nproper_line=|$proper_line|
		if {[catch [list set sub [lindex ${line} ${pos}]]]} { return {} }
	}
	return ${sub}
}

#**
# save `llength' (see above).
#
proc Llength {line} {
	if {[catch [list set len [llength ${line}]]]} {
		set line [ProperList ${line}]
		if {[catch [list set len [llength ${line}]]]} { return {} }
	}
	# puts stderr \nline=$line
	return ${len}
}

#**
# save `lrange' (see above).
#
proc Lrange {line first last} {
	if {[catch [list set range [lrange ${line} ${first} ${last}]]]} {
		set rest [IncompleteListRemainder ${line}]
		set proper [ProperList ${line}]
		if {[catch [list set range [lindex ${proper} ${first} ${last}]]]} {
			return {}
		}
		if {"end" == ${last} || [Llength ${line}] == ${last}} {
			append sub " ${rest}"
		}
	}
	return ${range}
}

#**
# Lunique -- remove duplicate entries from a sorted list
# @param   list
# @return  unique list
# @author  Johannes Zellner
# @date    Sep-19-1999
#
proc Lunique lst {
	set unique ""
	foreach element ${lst} {
		if {${element} != [lindex ${unique} end]} {
			lappend unique ${element}
		}
	}
	return ${unique}
}

#**
# string function, which works also for older versions
# of tcl, which don't have the `end' index.
# I tried also defining `string' and thus overriding
# the builtin `string' which worked, but slowed down
# things considerably. So I decided to call `String'
# only if I really need the `end' index.
#
proc String args {
	if {[info tclversion] < 8.2} {
		switch [lindex $args 1] {
			range -
			index {
				if {"end" == [lindex $args end]} {
					set str [lindex $args 2]
					lreplace args end end [expr [string length $str] - 1]
				}
			}
		}
	}
	return [eval string $args]
}

proc StripPrefix {text} {
	# puts "(StripPrefix) text=|$text|"
	set null [string index $text 0]
	if {"\"" == $null || "\{" == $null} {
		return [String range $text 1 end]
	} else {
		return $text
	}
}

proc VarCompletion {text {level -1}} {
	if {"#" != [string index ${level} 0]} {
		if {-1 == ${level}} {
			set level [info level]
		} else {
			incr level
		}
	}
	set pre [GetQuotedPrefix ${text}]
	set var [StripPrefix ${text}]
	# puts stderr "(VarCompletion) pre=|$pre|"
	# puts stderr "(VarCompletion) var=|$var|"

	# arrays
	#
	if {[regexp {([^(]*)\((.*)} ${var} all array name]} {
		set names [uplevel ${level} array names ${array} ${name}*]
		if {1 == [llength $names]} { ; # unique match
			return "${array}(${names})"
		} elseif {"" != ${names}} {
			return "${array}([CompleteLongest ${names}] ${names}"
		} else {
			return ""; # nothing to complete
		}
	}

	# non-arrays
	#
	regsub ":$" ${var} "::" var
	set namespaces [namespace children :: ${var}*]
	if {[llength ${namespaces}] && "::" != [string range ${var} 0 1]} {
		foreach name ${namespaces} {
			regsub "^::" ${name} "" name
			if {[string length ${name}]} {
				lappend new ${name}::
			}
		}
		set namespaces ${new}
		unset new
	}
	set matches \
	[string trim "[uplevel ${level} info vars ${var}*] ${namespaces}"]
	if {1 == [llength $matches]} { ; # unique match

		# check if this unique match is an
		# array name, (whith no "(" yet).
		#
		if {[uplevel ${level} array exists $matches]} {
			return [VarCompletion ${matches}( ${level}]; # recursion
		} else {
			return ${pre}${matches}[Right ${pre}]
		}
	} elseif {"" != $matches} { ; # more than one match
		  return [CompleteFromList ${text} ${matches}]
	} else {
		return ""; # nothing to complete
	}
}

proc CompleteControlStatement {text start end line pos mod pre new_line} {
	set pre [GetQuotedPrefix ${pre}]
	set cmd [Lindex $new_line 0]
	set diff [expr \
	[string length $line] - [string length $new_line]]
	if {$diff == [expr $start + 1]} {
		set mod1 $mod
	} else {
		set mod1 $text
		set pre ""
	}
	set new_end [expr $end - $diff]
	set new_start [expr $new_end - [string length $mod1]]
	# puts ""
	# puts new_start=$new_start
	# puts new_end=$new_end
	# puts new_line=$new_line
	# puts mod1=$mod1
	if {$new_start < 0} {
		return ""; # when does this occur?
	}
	# puts stderr ""
	# puts stderr start=|$start|
	# puts stderr end=|$end|
	# puts stderr mod=|$mod|
	# puts stderr new_start=|$new_start|
	# puts stderr new_end=|$new_end|
	# puts stderr new_line=|$new_line|
	# puts stderr ""
	set res [ScriptCompleter $mod1 $new_start $new_end $new_line]
	# puts stderr \n\${pre}\${res}=|${pre}${res}|
	if {[string length [Lindex ${res} 0]]} {
		return ${pre}${res}
	} else {
		return ${res}
	}
	return ""
}

proc BraceOrCommand {text start end line pos mod} {
	if {![string length [Lindex $line $pos]]} {
		return [list \{ {}]; # \}
	} else {
		set new_line [string trim [IncompleteListRemainder $line]]
		if {![regexp {^([\{\"])(.*)$} $new_line all pre new_line]} {
			set pre ""
		}
		return [CompleteControlStatement $text \
		$start $end $line $pos $mod $pre $new_line]
	}
}

proc FullQualifiedMatches {qualifier matchlist} {
	set new ""
	if {"" != $qualifier && ![regexp ::$ $qualifier]} {
		append qualifier ::
	}
	foreach entry ${matchlist} {
		set full ${qualifier}${entry}
		if {"" != [namespace which ${full}]} {
			lappend new ${full}
		}
	}
	return ${new}
}

proc ProcsOnlyCompletion {cmd} {
	return [CommandCompletion ${cmd} procs]
}

proc CommandsOnlyCompletion {cmd} {
	return [CommandCompletion ${cmd} commands]
}

proc CommandCompletion {cmd {action both} {spc ::}} {
	# get the leading colons in `cmd'.
	regexp {^:*} ${cmd} pre
	return [CommandCompletionWithPre $cmd $action $spc $pre]
}

proc CommandCompletionWithPre {cmd action spc pre} {
	# puts stderr "(CommandCompletion) cmd=|$cmd|"
	# puts stderr "(CommandCompletion) action=|$action|"
	# puts stderr "(CommandCompletion) spc=|$spc|"

	set cmd [StripPrefix ${cmd}]
	set quali [namespace qualifiers ${cmd}]
	if {[string length ${quali}]} {
		# puts stderr \nquali=|$quali|
		set matches [CommandCompletionWithPre \
		[namespace tail ${cmd}] ${action} ${spc}${quali} ${pre}]
		# puts stderr \nmatches1=|$matches|
		return $matches
	}
	set cmd [string trim ${cmd}]*
	# puts stderr \ncmd=|$cmd|\n
	if {"procs" != ${action}} {
		set all_commands [namespace eval $spc [list info commands ${cmd}]]
		# puts stderr all_commands=|$all_commands|
		set commands ""
		foreach command $all_commands {
			if {[namespace eval $spc [list namespace origin $command]] == \
				[namespace eval $spc [list namespace which $command]]} {
				lappend commands $command
			}
		}
	} else {
		set commands ""
	}
	if {"commands" != ${action}} {
		set all_procs [namespace eval $spc [list info procs ${cmd}]]
		# puts stderr procs=|$procs|
		set procs ""
		foreach proc $all_procs {
			if {[namespace eval $spc [list namespace origin $proc]] == \
				[namespace eval $spc [list namespace which $proc]]} {
				lappend procs $proc
			}
		}
	} else {
		set procs ""
	}
	set matches [namespace eval $spc concat ${commands} ${procs}]
	set namespaces [namespace children $spc ${cmd}]

	if {![llength ${matches}] && 1 == [llength ${namespaces}]} {
		set matches [CommandCompletionWithPre {} ${action} ${namespaces} ${pre}]
		# puts stderr \nmatches=|$matches|
		return $matches
	}

	# make `namespaces' having exactly
	# the same number of colons as `cmd'.
	#
	regsub -all {^:*} $spc $pre spc

	set matches [FullQualifiedMatches ${spc} ${matches}]
	# puts stderr \nmatches3=|$matches|
	return [string trim "${matches} ${namespaces}"]
}

#**
# check, if the first argument starts with a '['
# and must be evaluated before continuing.
# NOTE: trims the `line'.
#       eventually modifies all arguments.
# DATE: Sep-06-1999
#
proc EventuallyEvaluateFirst {partT startT endT lineT} {
	# return; # disabled
	upvar $partT part $startT start $endT end $lineT line

	set oldlen [string length ${line}]
	# set line [string trim ${line}]
	set line [string trimleft ${line}]
	set diff [expr [string length $line] - $oldlen]
	incr start $diff
	incr end $diff

	set char [string index ${line} 0]
	if {{[} != ${char} && {$} != ${char}} {return}

	set pos 0
	while {-1 != [set idx [string first {]} ${line} ${pos}]]} {
		set cmd [string range ${line} 0 ${idx}]
		if {[info complete ${cmd}]} {
			break;
		}
		set pos [expr ${idx} + 1]
	}

	if {![info exists cmd]} {return}
	if {![info complete ${cmd}]} {return}
	set cmd [string range ${cmd} 1 [expr [string length ${cmd}] - 2]]
	set rest [String range ${line} [expr ${idx} + 1] end]

	if {[catch [list set result [string trim [eval ${cmd}]]]]} {return}

	set line ${result}${rest}
	set diff [expr [string length ${result}] - ([string length ${cmd}] + 2)]
	incr start ${diff}
	incr end ${diff}
}

# if the line entered so far is
# % puts $b<TAB>
# part  == $b
# start == 5
# end   == 7
# line  == "$puts $b"
#
proc ScriptCompleter {part start end line} {

	# puts stderr "(ScriptCompleter) |$part| $start $end |$line|"

	# if the character before the cursor is a terminating
	# quote and the user wants completion, we insert a white
	# space here.
	#
	set char [string index $line [expr $end - 1]]
	if {"\}" == $char} {
		append $part " "
		return [list $part]
	}

	if {{$} == [string index $part 0]} {

		# check for a !$ history event
		#
		if {$start > 0} {
			if {{!} == [string index $line [expr $start - 1]]} {
				return ""
			}
		}
		# variable completion. Check first, if the
		# variable starts with a plain `$' or should
		# be enclosed in braces.
		#
		set var [String range $part 1 end]

		# check if $var is an array name, which
		# already has already a "(" somewhere inside.
		#
		if {"" != [set vc [VarCompletion $var]]} {
			if {"" == [lindex $vc 0]} {
				return "\$ [lrange ${vc} 1 end]"
			} else {
				return \$${vc}
			}
			# puts stderr vc=|$vc|
		} else {
			return ""
		}

	# SCENARIO:
	#
	# % puts bla; put<TAB> $b
	# part  == put
	# start == 10
	# end   == 13
	# line  == "puts bla; put $b"
	# [SplitLine] --> {1 " put $b"} == sub
	# new_start = [lindex $sub 0] == 1
	# new_end   = [expr $end - ($start - $new_start)] == 4
	# new_part  == $part == put
	# new_line  = [lindex $sub 1] == " put $b"
	# 
	} elseif {"" != [set sub [SplitLine $start $line]]} {

		set new_start [lindex $sub 0]
		set new_end [expr $end - ($start - $new_start)]
		set new_line [lindex $sub 1]
		# puts stderr "(SplitLine) $new_start $new_end $new_line"
		return [ScriptCompleter $part $new_start $new_end $new_line]

	} elseif {0 == [set pos [PartPosition part start end line]]} {

		# XXX
		#     note that line will be [string trimleft'ed]
		#     after PartPosition.
		# XXX

		# puts stderr "(PartPosition) $part $start $end $line"
		set all [CommandCompletion ${part}]
		# puts stderr "(ScriptCompleter) all=$all"
		#puts \nmatches=$matches\n
		# return [Format $all $part]
		return [TryFromList $part $all]

	} else {

		# try to use $pos further ...
		# puts stderr |$line|
		#
		# if {"." == [string index [string trim ${line}] 0]} {
		# 	set alias WIDGET
		# 	set namespc ""; # widgets are always in the global
		# } else {

			# the double `lindex' strips {} or quotes.
			# the subst enables variables containing
			# command names.
			#
			set alias [uplevel [info level] \
			subst [lindex [lindex [QuoteQuotes ${line}] 0] 0]]

			# make `alias' a fully qualified name.
			# this can raise an error, if alias is
			# no valid command.
			#
			if {[catch [list set alias [namespace origin $alias]]]} {
				return ""
			}

			# strip leading ::'s.
			#
			regsub -all {^::} $alias {} alias
			set namespc [namespace qualifiers $alias]
			set alias [namespace tail $alias]
		# }

		# try first a specific completer, then, and only then
		# the tclreadline_complete_unknown.
		#
		foreach cmd [list ${alias} tclreadline_complete_unknown] {
			# puts stderr ${namespc}complete(${cmd})
			if {"" != [namespace eval ::tclreadline::${namespc} \
				[list info procs complete(${cmd})]]
			} {
				# puts found=|complete($cmd)|
				# to be more error-proof, we check here,
				# if complete($cmd) takes exactly 5 arguments.
				#
				if {6 != [set arguments [llength \
					[namespace eval ::tclreadline::${namespc} \
					[list info args complete($cmd)]]]]
				} {
					error [list complete(${cmd}) takes ${arguments} \
					arguments, but should take exactly 6.]
				}

				# remove leading quotes
				#
				set mod [StripPrefix $part]
				# puts stderr mod=$mod

				if {[catch [list set script_result \
					[namespace eval ::tclreadline::${namespc} \
					[list complete(${cmd}) $part $start $end $line $pos $mod]]]\
					::tclreadline::errorMsg]
				} {
					error [list error during evaluation of `complete(${cmd})']
				}
				# puts stderr \nscript_result=|${script_result}|
				if {![string length ${script_result}] && \
					"tclreadline_complete_unknown" == ${cmd}
				} {
					# as we're here, the tclreadline_complete_unknown
					# returned an empty string. Fall thru and try
					# further fallback completers.
					#
				} else {
					# return also empty strings, if
					# they're from a specific completer.
					#
					TraceText script_result=|${script_result}|
					return ${script_result}
				}
			}
			# set namespc ""; # no qualifiers for tclreadline_complete_unknown
		}

		# as we've reached here no valid specific completer
		# was found. Check, if it's a proc and return the
		# arguments.
		#
		if {![string length ${namespc}]} {
			set namespc ::
		}
		if {[string length [uplevel [info level] \
			namespace eval ${namespc} [list ::info proc $alias]]]
		} {
			if ![string length [string trim $part]] {
				set args [uplevel [info level] \
				namespace eval ${namespc} [list info args $alias]]
				set arg [lindex $args [expr $pos - 1]]
				if {"" != $arg && "args" != $arg} {
					if {[uplevel [info level] namespace eval \
						${namespc} [list info default $alias $arg junk]]} {
							return [DisplayHints ?$arg?]
						} else {
							return [DisplayHints <$arg>]
						}
				}
			} else {
				return ""; # enable file name completion
			}
		}

		# check if the command is an object of known class.
		# 
		if [ObjectClassCompleter ${part} ${start} ${end} ${line} ${pos} res] {
			return ${res}
		}

		# Ok, also no proc. Try to do the same as for widgets now:
		# try to complete from the option table if the subcommand
		# is `configure' or `cget' otherwise try to get further
		# subcommands.
		#
		return [CompleteFromOptionsOrSubCmds \
		${part} ${start} ${end} ${line} ${pos}]
	}
	error "{NOTREACHED (this is probably an error)}"
}


# explicit command completers
#

# -------------------------------------
#                 TCL
# -------------------------------------

proc complete(after) {text start end line pos mod} {
	set sub [Lindex $line 1]
	# puts \npos=$pos
	switch -- $pos {
		1 {
			return [CompleteFromList ${text} {<ms> cancel idle info}]
		}
		2 {
			switch -- $sub {
				cancel {
					return [CompleteFromList $text "<script> [after info]"]
				}
				idle {
					return [DisplayHints <script>]
				}
				info {
					return [CompleteFromList $text [after info]]
				}
				default { return [DisplayHints ?script?] }
			}
		}
		default {
			switch -- $sub {
				info { return [DisplayHints {}] }
				default { return [DisplayHints ?script?] }
			}
		}
	}
	return ""
}

proc complete(append) {text start end line pos mod} {
	switch -- $pos {
		1       { return [VarCompletion ${text}] }
		default { return [DisplayHints ?value?] }
	}
	return ""
}

proc complete(array) {text start end line pos mod} {
	switch -- $pos {
		1 {
			set cmds {
				anymore donesearch exists get names
				nextelement set size startsearch
			}
			return [CompleteFromList $text $cmds]
		}
		2 {
			set matches ""
			# set vars [uplevel [info level] info vars ${mod}*]
			#
			# better: this displays a list of array names if the
			# user inters with something which cannot be matched.
			# The matching against `text' is done by CompleteFromList.
			#
			set vars [uplevel [info level] info vars]
			foreach var ${vars} {
				if {[uplevel [info level] array exists ${var}]} {
					lappend matches ${var}
				}
			}
			return [CompleteFromList ${text} ${matches}]
		}
		3 {
			set cmd [Lindex $line 1]
			set array_name [Lindex $line 2]
			switch -- $cmd {
				get -
				names {
					set pattern [Lindex $line 3]
					set matches [uplevel [info level] \
					array names ${array_name} ${pattern}*]
					if {![llength $matches]} {
						return [DisplayHints ?pattern?]
					} else {
						return [CompleteFromList ${text} ${matches}]
					}
				}
				anymore -
				donesearch -
				nextelement { return [DisplayHints <searchId>] }
			}
		}
	}
	return ""
}

# proc complete(bgerror) {text start end line pos mod} {
# }

proc complete(binary) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [CompleteFromList $text {format scan}]
		}
		2 {
			switch -- $cmd {
				format { return [DisplayHints <formatString>] }
				scan   { return [DisplayHints <string>] }
			}
		}
		3 {
			switch -- $cmd {
				format { return [DisplayHints ?arg?] }
				scan   { return [DisplayHints <formatString>] }
			}
		}
		default {
			switch -- $cmd {
				format { return [DisplayHints ?arg?] }
				scan   { return [DisplayHints ?varName?] }
			}
		}
	}
	return ""
}

# proc complete(break) {text start end line pos mod} {
# }

proc complete(catch) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <script>] }
		2 { return [DisplayHints ?varName?] }
	}
	return ""
}

proc complete(cd) {text start end line pos mod} {
	return ""
}

proc complete(clock) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [CompleteFromList $text {clicks format scan seconds}]
		}
		2 {
			switch -- $cmd {
				format  { return [DisplayHints <clockValue>] }
				scan    { return [DisplayHints <dateString>] }
				clicks  -
				seconds {}
			}
		}
		3 -
		5 {
			switch -- $cmd {
				format {
					set subcmds [RemoveUsedOptions $line {-format -gmt}]
					return [TryFromList $text $subcmds]
				}
				scan {
					set subcmds [RemoveUsedOptions $line {-base -gmt}]
					return [TryFromList $text $subcmds]
				}
				clicks  -
				seconds {}
			}
		}
		4 -
		6 {
			set sub [Lindex $line [expr $pos - 1]]
			switch -- $cmd {
				format {
					switch -- $sub {
						-format { return [DisplayHints <string>] }
						-gmt    { return [DisplayHints <boolean>] }
					}
				}
				scan {
					switch -- $sub {
						-base { return [DisplayHints <clockVal>] }
						-gmt  { return [DisplayHints <boolean>] }
					}
				}
				clicks  -
				seconds {}
			}
		}
	}
	return ""
}

proc complete(close) {text start end line pos mod} {
	switch -- $pos {
		1 { return [ChannelId $text] }
	}
	return ""
}

proc complete(concat) {text start end line pos mod} {
	return [DisplayHints ?arg?]
}

# proc complete(continue) {text start end line pos mod} {
# }

# proc complete(dde) {text start end line pos mod} {
#     We're not on windoze here ...
# }

proc complete(encoding) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [CompleteFromList $text {convertfrom convertto names system}]
		}
		2 {
			switch -- $cmd {
				convertfrom -
				convertto -
				system {
					return [CompleteFromList ${text} [encoding names]]
				}
			}
		}
		3 {
			switch -- $cmd {
				convertfrom { return [DisplayHints <data>] }
				convertto { return [DisplayHints <string>] }
			}
		}
	}
	return ""
}

proc complete(eof) {text start end line pos mod} {
	switch -- $pos {
		1 { return [InChannelId $text] }
	}
	return ""
}

proc complete(error) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <message>] }
		2 { return [DisplayHints ?info?] }
		3 { return [DisplayHints ?code?] }
	}
	return ""
}

proc complete(eval) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <arg>] }
		default { return [DisplayHints ?arg?] }
	}
	return ""
}

proc complete(exec) {text start end line pos mod} {
	set redir [list | |& < <@ << > 2> >& >> 2>> >>& >@ 2>@ >&@]
	variable executables
	if {![info exists executables]} {
		Rehash
	}
	switch -- $pos {
		1 {
			return [TryFromList $text "-keepnewline -- $executables"]
		}
		default {
			set prev [PreviousWord ${start} ${line}]
			if {"-keepnewline" == $prev && 2 == $pos} {
				return [TryFromList $text "-- $executables"]
			}
			switch -exact -- $prev {
				| -
				|& { return [TryFromList $text $executables] }
				< -
				> -
				2> -
				>& -
				>> -
				2>> -
				>>& { return "" }
				<@ -
				>@ -
				2>@ -
				>&@ { return [ChannelId $text] }
				<< { return [DisplayHints <value>] }
				default { return [TryFromList $text $redir "<>"] }
			}
		}
	}
	return ""
}

proc complete(exit) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints ?returnCode?] }
	}
	return ""
}

proc complete(expr) {text start end line pos mod} {
	set left $text
	set right ""
	set substitution [regexp -- {(.*)(\(.*)} $text all left right]; #-)

	set cmds {
		- + ~ !  * / % + - << >> < > <= >= == != & ^ | && || <x?y:z>
		acos    cos     hypot   sinh 
		asin    cosh    log     sqrt 
		atan    exp     log10   tan 
		atan2   floor   pow     tanh 
		ceil    fmod    sin     abs 
		double  int     rand    round 
		srand 
	}

	if {")" == [String index $text end] && -1 != [lsearch $cmds $left]} {
		return "$text "; # append a space after a closing ')'
	}

	switch -- $left {
		rand { return "rand() " }

		abs  -
		acos -
		asin -
		atan -
		ceil  -
		cos -
		cosh -
		double -
		exp -
		floor -
		int -
		log -
		log10 -
		round  -
		sin  -
		sinh  -
		sqrt  -
		srand  -
		tan  -
		tanh { return [DisplayHints <value>] }


		atan2 -
		fmod -
		hypot -
		pow { return [DisplayHints <value>,<value>] }
	}

	set completions [TryFromList $left $cmds <>]
	if {1 == [llength $completions]} {
		if {!$substitution} {
			if {"rand" == $completions} {
				return "rand() "; # rand() takes no arguments
			}
			append completions (; #-)
			return [list $completions {}]
		}
	} else {
		return $completions
	}
	return ""
}

proc complete(fblocked) {text start end line pos mod} {
	switch -- $pos {
		1 { return [InChannelId $text] }
	}
	return ""
}

proc complete(fconfigure) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [ChannelId ${text}]
		}
		default {
			set option [PreviousWord ${start} ${line}]
			switch -- $option {
				-blocking {
					return [CompleteBoolean ${text}]
				}
				-buffering {
					return [CompleteFromList ${text} {full line none}]
				}
				-buffersize {
					if {![llength ${text}]} {
						return [DisplayHints <newSize>]
					}
				}
				-encoding {
					return [CompleteFromList ${text} [encoding names]]
				}
				-eofchar {
					return [DisplayHints {\{<inChar>\ <outChar>\}}]
				}
				-translation {
					return [CompleteFromList ${text} {auto binary cr crlf lf}]
				}
				default {return [CompleteFromList $text \
					[RemoveUsedOptions $line {
					-blocking -buffering -buffersize
					-encoding -eofchar -translation}]]
				}
			}
		}
	}
	return ""
}

proc complete(fcopy) {text start end line pos mod} {
	switch -- $pos {
		1 {
			return [InChannelId ${text}]
		}
		2 {
			return [OutChannelId ${text}]
		}
		default {
			set option [PreviousWord ${start} ${line}]
			switch -- $option {
				-size    { return [DisplayHints <size>] }
				-command { return [DisplayHints <callback>] }
				default  { return [CompleteFromList $text \
					[RemoveUsedOptions $line {-size -command}]]
				}
			}
		}
	}
	return ""
}

proc complete(file) {text start end line pos mod} {
	switch -- $pos {
		1 {
			set cmds {
				atime attributes channels copy delete dirname executable exists
				extension isdirectory isfile join lstat mkdir mtime
				nativename owned pathtype readable readlink rename
				rootname size split stat tail type volumes writable
			}
			return [TryFromList $text $cmds]
		}
		2 {
			set cmd [Lindex $line 1]
			switch -- $cmd {
				atime -
				attributes -
				channels -
				dirname -
				executable -
				exists -
				extension -
				isdirectory -
				isfile -
				join -
				lstat -
				mtime -
				mkdir -
				nativename -
				owned -
				pathtype -
				readable -
				readlink -
				rootname -
				size -
				split -
				stat -
				tail -
				type -
				volumes -
				writable {
					return ""
				}

				copy -
				delete -
				rename {
					# return [TryFromList $text "-force [glob *]"]
					# this is not perfect. The  `-force' and `--'
					# options will not be displayed.
					return ""
				}
			}
		}
	}
	return ""
}

proc complete(fileevent) {text start end line pos mod} {
	switch -- $pos {
		1 {
			return [ChannelId ${text}]
		}
		2 {
			return [CompleteFromList ${text} {readable writable}]
		}
		3 {
			return [DisplayHints ?script?]
		}
	}
	return ""
}

proc complete(flush) {text start end line pos mod} {
	switch -- $pos {
		1 { return [OutChannelId ${text}] }
	}
	return ""
}

proc complete(for) {text start end line pos mod} {
	switch -- $pos {
		1 -
		2 -
		3 -
		4 {
			return [BraceOrCommand $text $start $end $line $pos $mod]
		}
	}
	return ""
}

proc complete(foreach) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <varname>] }
		2 { return [DisplayHints <list>] }
		default {
			if {[expr $pos % 2]} {
				return [DisplayHints [list ?varname? <body>]]
			} else {
				return [DisplayHints ?list?]
			}
		}
	}
	return ""
}

proc complete(format) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <formatString>] }
		default { return [DisplayHints ?arg?] }
	}
	return ""
}

proc complete(gets) {text start end line pos mod} {
	switch -- $pos {
		1 { return [InChannelId ${text}] }
		2 { return [VarCompletion ${text}]}
	}
	return ""
}

proc complete(glob) {text start end line pos mod} {
	switch -- $pos {
		1 {
			# This also is not perfect.
			# This will not display the options as hints!
			set matches [TryFromList ${text} {-nocomplain --}]
			if {[llength [string trim ${text}]] && [llength ${matches}]} {
				return ${matches}
			}
		}
	}
	return ""
}

proc complete(global) {text start end line pos mod} {
	return [VarCompletion ${text}]
}

proc complete(history) {text start end line pos mod} {
	switch -- $pos {
		1 {
			set cmds {add change clear event info keep nextid redo}
			return [TryFromList $text $cmds]
		}
		2 {
			set cmd [Lindex $line 1]
			switch -- $cmd {
				add { return [DisplayHints <command>] }
				change { return [DisplayHints <newValue>] }

				info -
				keep { return [DisplayHints ?count?] }

				event -
				redo { return [DisplayHints ?event?] }

				clear -
				nextid { return "" }
			}
		}
	}
	return ""
}

# --- HTTP PACKAGE ---

# create a http namespace inside
# tclreadline and import some commands.
#
namespace eval http {
	catch {
		namespace import \
		::tclreadline::DisplayHints ::tclreadline::PreviousWord \
		::tclreadline::CompleteFromList ::tclreadline::CommandCompletion \
		::tclreadline::RemoveUsedOptions ::tclreadline::HostList \
		::tclreadline::ChannelId ::tclreadline::Lindex \
		::tclreadline::CompleteBoolean
	}
}

proc http::complete(config) {text start end line pos mod} {
	set prev [PreviousWord ${start} ${line}]
	switch -- $prev {
		-accept { return [DisplayHints <mimetypes>] }
		-proxyhost {
			return [CompleteFromList $text [HostList]]
		}
		-proxyport { return [DisplayHints <number>] }
		-proxyfilter {
			return [CompleteFromList $text [CommandCompletion $text]]
		}
		-useragent { return [DisplayHints <string>] }
		default {
			return [CompleteFromList $text [RemoveUsedOptions $line {
				-accept -proxyhost -proxyport -proxyfilter -useragent
			}]]
		}
	}
	return ""
}

proc http::complete(geturl) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <url>] }
		default {
			set prev [PreviousWord ${start} ${line}]
			switch -- $prev {
				-blocksize { return [DisplayHints <size>] }
				-channel { return [ChannelId ${text}] }
				-command -
				-handler -
				-progress {
					return [CompleteFromList $text [CommandCompletion $text]]
				}
				-headers { return [DisplayHints <keyvaluelist>] }
				-query { return [DisplayHints <query>] }
				-timeout { return [DisplayHints <milliseconds>] }
				-validate { return [CompleteBoolean $text] }
				default {
					return [CompleteFromList $text [RemoveUsedOptions $line {
						-blocksize -channel -command -handler -headers
						-progress -query -timeout -validate
					}]]
				}
			}
		}
	}
	return ""
}

proc http::complete(formatQuery) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <key>] }
		2 { return [DisplayHints <value>] }
		default {
			switch [expr $pos % 2] {
				0 { return [DisplayHints ?value?] }
				1 { return [DisplayHints ?key?] }
			}
		}
	}
	return ""
}

proc http::complete(reset) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <token>] }
		2 { return [DisplayHints ?why?] }
	}
	return ""
}

# the unknown proc handles the rest
#
proc http::complete(tclreadline_complete_unknown) {text start end line pos mod} {
	set cmd [Lindex $line 0]
	regsub -all {^.*::} $cmd "" cmd
	switch -- $pos {
		1 {
			switch -- $cmd {
				reset -
				wait -
				data -
				status -
				code -
				size -
				cleanup {
					return [DisplayHints <token>]
				}
			}
		}
	}
	return ""
}

# --- END OF HTTP PACKAGE ---

proc complete(if) {text start end line pos mod} {
	# we don't offer the completion `then':
	# it's optional, more difficult to parse
	# and who uses it anyway?
	#
	switch -- $pos {
		1 -
		2 {
			return [BraceOrCommand $text $start $end $line $pos $mod]
		}
		default {
			set prev [PreviousWord ${start} ${line}]
			switch -- $prev {
				then -
				else -
				elseif {
					return [BraceOrCommand \
					$text $start $end $line $pos $mod]
				}
				default {
					if {-1 == [lsearch [ProperList $line] else]} {
						return [CompleteFromList $text {else elseif}]
					}
				}
			}
		}
	}
	return ""
}

proc complete(incr) {text start end line pos mod} {
	switch -- $pos {
		1 {
			set matches [uplevel [info level] info vars ${mod}*]
			set integers ""
			# check for integers
			#
			foreach match $matches {
				if {[uplevel [info level] array exists $match]} {
					continue
				}
				if {[regexp {^[0-9]+$} [uplevel [info level] set $match]]} {
					lappend integers $match
				}
			}
			return [CompleteFromList ${text} ${integers}]
		}
		2 { return [DisplayHints ?increment?] }
	}
	return ""
}

proc complete(info) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			set cmds {
				args body cmdcount commands complete default exists
				globals hostname level library loaded locals nameofexecutable
				patchlevel procs script sharedlibextension tclversion vars}
			return [CompleteFromList $text $cmds]
		}
		2 {
			switch -- $cmd {
				args -
				body -
				default -
				procs { return [complete(proc) ${text} 0 0 ${line} 1 ${mod}] }
				complete { return [DisplayHints <command>] }
				level { return [DisplayHints ?number?] }
				loaded { return [DisplayHints ?interp?] }
				commands -
				exists -
				globals -
				locals -
				vars {
					if {"exists" == $cmd} {
						set do vars
					} else {
						set do $cmd
					}
					# puts stderr [list complete(info) level = [info level]]
					return \
					[CompleteFromList ${text} [uplevel [info level] info ${do}]]
				}
			}
		}
		3 {
			switch -- $cmd {
				default {
					set proc [Lindex $line 2]
					return [CompleteFromList ${text} \
					[uplevel [info level] info args $proc]]
				}
				default {}
			}
		}
		4 {
			switch -- $cmd {
				default {
					return [VarCompletion ${text}]
				}
				default {}
			}
		}
	}
	return ""
}

proc complete(interp) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			set cmds {
				alias aliases create delete eval exists expose hide hidden
				invokehidden issafe marktrusted share slaves target transfer}
			return [TryFromList $text $cmds]
		}
		2 {
			switch -- $cmd {

				create {
					set cmds [RemoveUsedOptions ${line} {-save --} {--}]
					if {[llength $cmds]} {
						return [CompleteFromList $text "$cmds ?path?"]
					} else {
						return [DisplayHints ?path?]
					}
				}

				eval -
				exists -
				expose -
				hide -
				hidden -
				invokehidden -
				marktrusted -
				target { return [CompleteFromList ${text} [interp slaves]] }

				aliases -
				delete -
				issafe -
				slaves { return [CompleteFromList ${text} [interp slaves]] }

				alias -
				share -
				transfer { return [DisplayHints <srcPath>] }
			}
		}
		3 {
			switch -- $cmd {

				alias { return [DisplayHints <srcCmd>] }

				create {
					set cmds [RemoveUsedOptions ${line} {-save --} {--}]
					if {[llength $cmds]} {
						return [CompleteFromList $text "$cmds ?path?"]
					} else {
						return [DisplayHints ?path?]
					}
				}

				eval { return [DisplayHints <arg>] }
				delete { return [CompleteFromList ${text} [interp slaves]] }

				expose { return [DisplayHints <hiddenName>] }
				hide { return [DisplayHints <exposedCmdName>] }

				invokehidden {
					return \
					[CompleteFromList $text {?-global? <hiddenCmdName>}]
				}

				target { return [DisplayHints <alias>] }

				exists {}
				hidden {}
				marktrusted {}
				aliases {}
				issafe {}
				slaves {}

				share -
				transfer {return [ChannelId ${text}]}
			}
		}
		4 {
			switch -- $cmd {

				alias { return [DisplayHints <targetPath>] }
				eval { return [DisplayHints ?arg?] }

				invokehidden {
					return [CompleteFromList $text {<hiddenCmdName> ?arg?}]
				}

				create {
					set cmds [RemoveUsedOptions ${line} {-save --} {--}]
					if {[llength $cmds]} {
						return [CompleteFromList $text "$cmds ?path?"]
					} else {
						return [DisplayHints ?path?]
					}
				}

				expose { return [DisplayHints ?exposedCmdName?] }
				hide { return [DisplayHints ?hiddenCmdName?] }

				share -
				transfer { return [CompleteFromList ${text} [interp slaves]] }
			}
		}
		5 {
			switch -- $cmd {

				alias { return [DisplayHints <targetCmd>] }
				invokehidden -
				eval { return [DisplayHints ?arg?] }

				expose { return [DisplayHints ?exposedCmdName?] }
				hide { return [DisplayHints ?hiddenCmdName?] }

				share -
				transfer { return [CompleteFromList ${text} [interp slaves]] }
			}
		}
	}
	return ""
}

proc complete(join) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <list>] }
		2 { return [DisplayHints ?joinString?] }
	}
	return ""
}

proc complete(lappend) {text start end line pos mod} {
	switch -- $pos {
		1 { return [VarCompletion ${text}] }
		default { return [TryFromList ${text} ?value?] }
	}
	return ""
}

# the following routines are described in the
# `library' man page.
# --- LIBRARY ---

proc complete(auto_execok) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <cmd>] }
	}
	return ""
}

proc complete(auto_load) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <cmd>] }
	}
	return ""
}

proc complete(auto_mkindex) {text start end line pos mod} {
	switch -- $pos {
		1 { return "" }
		default { return [DisplayHints ?pattern?] }
	}
	return ""
}

# proc complete(auto_reset) {text start end line pos mod} {
# }

proc complete(tcl_findLibrary) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <basename>] }
		2 { return [DisplayHints <version>] }
		3 { return [DisplayHints <patch>] }
		4 { return [DisplayHints <initScript>] }
		5 { return [DisplayHints <enVarName>] }
		6 { return [DisplayHints <varName>] }
	}
	return ""
}

proc complete(parray) {text start end line pos mod} {
	switch -- $pos {
		1 {
			set vars [uplevel [info level] info vars]
			foreach var ${vars} {
				if {[uplevel [info level] array exists ${var}]} {
					lappend matches ${var}
				}
			}
			return [CompleteFromList $text $matches]
		}
	}
	return ""
}

proc complete(tcl_endOfWord) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <str>] }
		2 { return [DisplayHints <start>] }
	}
	return ""
}

proc complete(tcl_startOfNextWord) {text start end line pos mod} {
	return [complete(tcl_endOfWord) $text $start $end $line $pos $mod]
}

proc complete(tcl_startOfPreviousWord) {text start end line pos mod} {
	return [complete(tcl_endOfWord) $text $start $end $line $pos $mod]
}

proc complete(tcl_wordBreakAfter) {text start end line pos mod} {
	return [complete(tcl_endOfWord) $text $start $end $line $pos $mod]
}

proc complete(tcl_wordBreakBefore) {text start end line pos mod} {
	return [complete(tcl_endOfWord) $text $start $end $line $pos $mod]
}

# --- END OF `LIBRARY' ---

proc complete(lindex) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <list>] }
		2 { return [DisplayHints <index>] }
	}
	return ""
}

proc complete(linsert) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <list>] }
		2 { return [DisplayHints <index>] }
		3 { return [DisplayHints <element>] }
		default { return [DisplayHints ?element?] }
	}
	return ""
}

proc complete(list) {text start end line pos mod} {
	return [DisplayHints ?arg?]
}

proc complete(llength) {text start end line pos mod} {
	switch -- $pos {
		1 {
			return [DisplayHints <list>]
		}
	}
	return ""
}

proc complete(load) {text start end line pos mod} {
	switch -- $pos {
		1 {
			return ""; # filename
		}
		2 {
			if {![llength ${mod}]} {
				return [DisplayHints ?packageName?]
			}
		}
		3 {
			if {![llength ${mod}]} {
				return [DisplayHints ?interp?]
			}
		}
	}
	return ""
}

proc complete(lrange) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <list>] }
		2 { return [DisplayHints <first>] }
		3 { return [DisplayHints <last>] }
	}
	return ""
}

proc complete(lreplace) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <list>] }
		2 { return [DisplayHints <first>] }
		3 { return [DisplayHints <last>] }
		default { return [DisplayHints ?element?] }
	}
	return ""
}

proc complete(lsearch) {text start end line pos mod} {
	set options {-exact -glob -regexp}
	switch -- $pos {
		1 {
			return [CompleteFromList ${text} "$options <list>"]
		}
		2 -
		3 -
		4 {
			set sub [Lindex $line 1]
			if {-1 != [lsearch $options $sub]} {
				incr pos -1
			}
			switch -- $pos {
				1 { return [DisplayHints <list>] }
				2 { return [DisplayHints <pattern>] }
			}
		}
	}
	return ""
}

proc complete(lsort) {text start end line pos mod} {
	set options [RemoveUsedOptions ${line} {
		-ascii -dictionary -integer -real -command
		-increasing -decreasing -index <list>
	}]
	switch -- $pos {
		1 { return [CompleteFromList ${text} ${options}] }
		default {
			switch -- [PreviousWord ${start} ${line}] {
				-command {
					return [CompleteFromList $text [CommandCompletion $text]]
				}
				-index { return [DisplayHints <index>] }
				default { return [CompleteFromList ${text} ${options}] }
			}
		}
	}
	return ""
}

# --- MSGCAT PACKAGE ---

# create a msgcat namespace inside
# tclreadline and import some commands.
#
namespace eval msgcat {
	catch {namespace import ::tclreadline::DisplayHints}
}

proc msgcat::complete(mc) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <src-string>] }
	}
	return ""
}

proc msgcat::complete(mclocale) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints ?newLocale?] }
	}
	return ""
}

# proc msgcat::complete(mcpreferences) {text start end line pos mod} {
# }

proc msgcat::complete(mcload) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <dirname>] }
	}
	return ""
}

proc msgcat::complete(mcset) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <locale>] }
		2 { return [DisplayHints <src-string>] }
		3 { return [DisplayHints ?translate-string?] }
	}
	return ""
}

proc msgcat::complete(mcunknown) {text start end line pos mod} {
	switch -- $pos {
		1 { return [DisplayHints <locale>] }
		2 { return [DisplayHints <src-string>] }
	}
	return ""
}

# --- END OF MSGCAT PACKAGE ---

# TODO import ! -force
proc complete(namespace) {text start end line pos mod} {
	# TODO dosn't work ???
	set space_matches [namespace children :: [string trim ${mod}*]]
	# puts \nspace_matches=|${space_matches}|
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			set cmds {
				children code current delete eval export forget
				import inscope origin parent qualifiers tail which}
			return [TryFromList $text $cmds]
		}
		2 {
			switch -- $cmd {
				children -
				delete -
				eval -
				inscope -
				forget -
				parent -
				qualifiers -
				tail {
					regsub {^([^:])} ${mod} {::\1} mod; # full qual. name
					return [TryFromList ${mod} $space_matches]
				}
				code { return [DisplayHints <script> ] }
				current {}
				export { return [CompleteFromList ${text} {-clear ?pattern?}] }
				import {
					if {"-" != [string index ${mod} 0]} {
						regsub {^([^:])} ${mod} {::\1} mod; # full qual. name
					}
					return [CompleteFromList ${mod} "-force $space_matches"]
				}
				origin { return [DisplayHints <command>] }
				# qualifiers -
				# tail { return [DisplayHints <string>] }
				which { return [CompleteFromList ${mod} {
					-command -variable <name>}] }
			}
		}
		3 {
			switch -- $cmd {
				children -
				export -
				forget -
				import { return [DisplayHints ?pattern?] }
				delete { return [TryFromList ${mod} $space_matches] }
				eval -
				inscope {
					return [BraceOrCommand \
					$text $start $end $line $pos $mod]
				}
				which { return [CompleteFromList ${mod} {-variable <name>}] }
			}
		}
		4 {
			switch -- $cmd {
				export -
				forget -
				import { return [DisplayHints ?pattern?] }
				delete { return [TryFromList ${mod} $space_matches] }
				eval -
				inscope { return [DisplayHints ?arg?] }
				which { return [CompleteFromList ${mod} {<name>}] }
			}
		}
	}
	return ""
}

proc complete(open) {text start end line pos mod} {
		# 2 { return [DisplayHints ?access?] }
	switch -- $pos {
		2 {
			set access {r r+ w w+ a a+ 
				RDONLY WRONLY RDWR APPEND CREAT EXCL NOCTTY NONBLOCK TRUNC}
			return [CompleteFromList ${text} ${access}]
		}
		3 { return [DisplayHints ?permissions?] }
	}
	return ""
}

proc complete(package) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			set cmds {
				forget ifneeded names present provide require
				unknown vcompare versions vsatisfies}
			return [TryFromList $text $cmds]
		}
		2 {
			switch -- ${cmd} {
				forget -
				ifneeded -
				provide -
				versions { return [CompleteFromList ${mod} [package names]] }
				present -
				require {
					return [CompleteFromList ${mod} "-exact [package names]"] }
				names {}
				unknown { return [DisplayHints ?command?] }
				vcompare -
				vsatisfies { return [DisplayHints <version1>] }
			}
		}
		3 {
			set versions ""
			catch [list set versions [package versions [Lindex ${line} 2]]]
			switch -- ${cmd} {
				forget {}
				ifneeded {
					if {"" != $versions} {
						return [CompleteFromList ${text} ${versions}]
					} else {
						return [DisplayHints <version>]
					}
				}
				provide {
					if {"" != ${versions}} {
						return [CompleteFromList ${text} ${versions}]
					} else {
						return [DisplayHints ?version?]
					}
				}
				versions {}
				present -
				require {
					if {"-exact" == [PreviousWord ${start} ${line}]} {
						return [CompleteFromList ${mod} [package names]]
					} else {
						if {"" != ${versions}} {
							return [CompleteFromList ${text} ${versions}]
						} else {
							return [DisplayHints ?version?]
						}
					}
				}
				names {}
				unknown {}
				vcompare -
				vsatisfies { return [DisplayHints <version2>] }
			}
		}
	}
	return ""
}

proc complete(pid) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [ChannelId ${text}] }
	}
}

proc complete(pkg_mkIndex) {text start end line pos mod} {
	set cmds [RemoveUsedOptions ${line} {-direct -load -verbose -- <dir>} {--}]
	set res [string trim [TryFromList ${text} ${cmds}]]
	set prev [PreviousWord ${start} ${line}]
	if {"-load" == ${prev}} {
		return [DisplayHints <pkgPat>]
	} elseif {"--" == ${prev}} {
		return [TryFromList ${text} <dir>]
	}
	return ${res}
}

proc complete(proc) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			set known_procs [ProcsOnlyCompletion ${text}]
			return [CompleteFromList ${text} ${known_procs}]
		}
		2 {
			set proc [Lindex ${line} 1]
			if {[catch {set args [uplevel [info level] info args ${proc}]}]} {
				return [DisplayHints <args>]
			} else {
				return [list "\{${args}\}"]
			}
		}
		3 {
			if {![string length [Lindex ${line} ${pos}]]} {
				return [list \{ {}]; # \}
			} else {
				# return [DisplayHints <body>]
				return [BraceOrCommand \
				${text} ${start} ${end} ${line} ${pos} ${mod}]
			}
		}
	}
	return ""
}

proc complete(puts) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [OutChannelId ${text} "-nonewline"]
		}
		2 {
			switch -- $cmd {
				-nonewline { return [OutChannelId ${text}] }
				default { return [DisplayHints <string>] }
			}
		}
		3 {
			switch -- $cmd {
				-nonewline { return [DisplayHints <string>] }
			}
		}
	}
	return ""
}

# proc complete(pwd) {text start end line pos mod} {
# }

proc complete(read) {text start end line pos mod} {
	set cmd [Lindex $line 1]
	switch -- $pos {
		1 {
			return [InChannelId ${text} "-nonewline"]
		}
		2 {
			switch -- $cmd {
				-nonewline { return [InChannelId ${text}] }
				default { return [DisplayHints <numChars>] }
			}
		}
	}
	return ""
}

proc complete(regexp) {text start end line pos mod} {
	set prev [PreviousWord ${start} ${line}]
	if {[llength ${prev}] && "--" != $prev && \
		("-" == [string index ${prev} 0] || 1 == $pos)} {
		set cmds [RemoveUsedOptions ${line} {
			-nocase -indices -expanded -line 
			-linestop -lineanchor -about <expression> --} {--}]
		if {[llength ${cmds}]} {
			return [string trim [CompleteFromList ${text} ${cmds}]]
		}
	} else {
		set virtual_pos [expr ${pos} - [FirstNonOption ${line}]]
		switch -- ${virtual_pos} {
			0 { return [DisplayHints <string>] }
			1 { return [DisplayHints ?matchVar?] }
			default { return [DisplayHints ?subMatchVar?] }
		}
	}
	return ""
}

# proc complete(regexp) {text start end line pos mod} {
#     We're not on windoze here ...
# }

proc complete(regsub) {text start end line pos mod} {
	set prev [PreviousWord ${start} ${line}]
	if {[llength ${prev}] && "--" != $prev && \
		("-" == [string index ${prev} 0] || 1 == ${pos)}} {
		set cmds [RemoveUsedOptions ${line} {
			-all -nocase --} {--}]
		if {[llength ${cmds}]} {
			return [string trim [CompleteFromList ${text} ${cmds}]]
		}
	} else {
		set virtual_pos [expr ${pos} - [FirstNonOption ${line}]]
		switch -- ${virtual_pos} {
			0 { return [DisplayHints <expression>] }
			1 { return [DisplayHints <string>] }
			2 { return [DisplayHints <subSpec>] }
			3 { return [DisplayHints <varName>] }
		}
	}
	return ""
}

proc complete(rename) {text start end line pos mod} {
	switch -- $pos {
		1 {
			return [CompleteFromList ${text} [CommandCompletion ${text}]]
		}
		2 {
			return [DisplayHints <newName>]
		}
	}
	return ""
}

# proc complete(resource) {text start end line pos mod} {
#     This is not a mac ...
# }

proc complete(return) {text start end line pos mod} {
	# TODO this is not perfect yet
	set cmds {-code -errorinfo -errorcode ?string?}
	set res [PreviousWord ${start} ${line}]
	switch -- ${res} {
		-errorinfo { return [DisplayHints <info>] }
		-code -
		-errorcode {
			set codes {ok error return break continue}
			return [TryFromList ${mod} ${codes}]
		}
	}
	return [CompleteFromList ${text} [RemoveUsedOptions ${line} ${cmds}]]
}

# --- SAFE PACKAGE ---

# create a safe namespace inside
# tclreadline and import some commands.
#
namespace eval safe {
	catch {
		namespace import \
		::tclreadline::DisplayHints ::tclreadline::PreviousWord \
		::tclreadline::CompleteFromList ::tclreadline::CommandCompletion \
		::tclreadline::RemoveUsedOptions ::tclreadline::HostList \
		::tclreadline::ChannelId ::tclreadline::Lindex \
		::tclreadline::CompleteBoolean \
		::tclreadline::WidgetChildren
	}
	variable opts
	set opts {
		-accessPath -statics -noStatics -nested -nestedLoadOk -deleteHook
	}
	proc SlaveOrOpts {text start line pos slave} {
		set prev [PreviousWord ${start} ${line}]
		variable opts
		if {$pos > 1} {
			set slave ""
		}
		switch -- $prev {
			-accessPath { return [DisplayHints <directoryList>] }
			-statics { return [CompleteBoolean $text] }
			-nested { return [CompleteBoolean $text] }
			-deleteHook { return [DisplayHints <script>] }
			default {
				return [CompleteFromList ${text} \
				[RemoveUsedOptions ${line} "${opts} $slave"]]
			}
		}
	}
}

proc safe::complete(interpCreate) {text start end line pos mod} {
	return [SlaveOrOpts ${text} ${start} ${line} ${pos} ?slave?]
}

proc safe::complete(interpInit) {text start end line pos mod} {
	return [SlaveOrOpts ${text} ${start} ${line} ${pos} [interp slaves]]
}

proc safe::complete(interpConfigure) {text start end line pos mod} {
	return [SlaveOrOpts $text $start $line $pos [interp slaves]]
}

proc safe::complete(interpDelete) {text start end line pos mod} {
	return [CompleteFromList ${text} [interp slaves]]
}

proc safe::complete(interpAddToAccessPath) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [interp slaves]] }
	}
}

proc safe::complete(interpFindInAccessPath) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [interp slaves]] }
	}
}

proc safe::complete(setLogCmd) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [DisplayHints ?cmd?] }
		default { return [DisplayHints ?arg?] }
	}
}

proc safe::complete(loadTk) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [DisplayHints <slave>] }
		default {
			switch -- [PreviousWord ${start} ${line}] {
				-use {
					return [CompleteFromList ${text} \
					[::tclreadline::WidgetChildren ${text}]]
				}
				-display {
					return [DisplayHints <display>]
				}
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {-use -display}]]
				}
			}
		}
	}
}

# --- END OF SAFE PACKAGE ---

proc complete(scan) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [DisplayHints <string>] }
		2 { return [DisplayHints <format>] }
		default { return [VarCompletion ${text}] }
	}
	return ""
}

proc complete(seek) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [ChannelId ${text}] }
		2 { return [DisplayHints <offset>] }
		3 { return [TryFromList ${text} {start current end}] }
	}
	return ""
}

proc complete(set) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [VarCompletion ${text}] }
		2 {
			if {${text} == "" || ${text} == "\"" || ${text} == "\{"} {
				# set line [QuoteQuotes $line]
				if {[catch [list set value [list [uplevel [info level] \
					set [Lindex ${line} 1]]]] msg]
				} {
					return ""
				} else {
					return [Quote ${value} ${text}]
				}
			}
		}
	}
	return ""
}

proc complete(socket) {text start end line pos mod} {
	set cmd [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	if {"-server" == ${cmd}} {
		# server sockets
		#
		switch -- ${pos} {
			2 { return [DisplayHints <command>] }
			default {
				if {"-myaddr" == ${prev}} {
					return [DisplayHints <addr>]
				} else {
					return [CompleteFromList ${mod} \
					[RemoveUsedOptions $line {-myaddr -error -sockname <port>}]]
				}
			}
		}
	} else {
		# client sockets
		#
		switch -- ${prev} {
			-myaddr { return [DisplayHints <addr>] }
			-myport { return [DisplayHints <port>] }
		}

		set hosts [HostList]
		set cmds {-myaddr -myport -async -myaddr -error -sockname -peername}
		if {${pos} <= 1} {
			lappend cmds -server
		}
		set cmds [RemoveUsedOptions ${line} ${cmds}]
		if {-1 != [lsearch ${hosts} ${prev}]} {
			return [DisplayHints <port>]
		} else {
			return [CompleteFromList ${mod} [concat ${cmds} ${hosts}]]
		}
	}
	return ""
}

proc complete(source) {text start end line pos mod} {
	# allow file name completion
	return ""
}

proc complete(split) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [DisplayHints <string>] }
		2 { return [DisplayHints ?splitChars?] }
	}
}

proc complete(string) {text start end line pos mod} {
	set cmd [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	set cmds {
		bytelength compare equal first index is last length map match
		range repeat replace tolower toupper totitle trim trimleft
		trimright wordend wordstart}
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} ${cmds}]
		}
		2 {
			switch -- ${cmd} {
				compare -
				equal {
					return [CompleteFromList ${text} {
						-nocase -length <string> }]
				}

				first -
				last { return [DisplayHints <string1>] }

				map { return [CompleteFromList ${text} {-nocase <charMap>]} }
				match { return [CompleteFromList ${text} {-nocase <pattern>]} }

				is {
					return [CompleteFromList ${text} {
						alnum alpha ascii boolean control digit double 
						false graph integer lower print punct space 
						true upper wordchar xdigit 
					}]
				}

				bytelength -
				index -
				length -
				range -
				repeat -
				replace -
				tolower -
				totitle -
				toupper -
				trim -
				trimleft -
				trimright -
				wordend -
				wordstart { return [DisplayHints <string>] }
			}
		}
		3 {
			switch -- ${cmd} {
				compare -
				equal {
					if {"-length" == ${prev}} {
						return [DisplayHints <int>]
					}
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {-nocase -length <string>}]]
				}

				first -
				last { return [DisplayHints <string2>] }

				map {
					if {"-nocase" == ${prev}} {
						return [DisplayHints <charMap>]
					} else {
						return [DisplayHints <string>]
					}
				}
				match {
					if {"-nocase" == ${prev}} {
						return [DisplayHints <pattern>]
					} else {
						return [DisplayHints <string>]
					}
				}

				is {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {-strict -failindex <string>}]]
				}

				bytelength {}
				index -
				wordend -
				wordstart { return [DisplayHints <charIndex>] }
				range -
				replace { return [DisplayHints <first>] }
				repeat { return [DisplayHints <count>] }
				tolower -
				totitle -
				toupper { return [DisplayHints ?first?] }
				trim -
				trimleft -
				trimright { return [DisplayHints ?chars?] }
			}
		}
		4 {
			switch -- ${cmd} {
				compare -
				equal {
					if {"-length" == ${prev}} {
						return [DisplayHints <int>]
					}
					return [CompleteFromList ${text} \
					[RemoveUsedOptions $line {-nocase -length <string>}]]
				}

				first -
				last { return [DisplayHints ?startIndex?] }

				map -
				match { return [DisplayHints <string>] }

				is {
					if {"-failindex" == ${prev}} {
						return [VarCompletion ${text}]
					}
					return [CompleteFromList ${text} \
					[RemoveUsedOptions $line {-strict -failindex <string>}]]
				}

				bytelength {}
				index {}
				length {}
				range -
				replace { return [DisplayHints <last>] }
				repeat {}
				tolower -
				totitle -
				toupper { return [DisplayHints ?last?] }
				trim -
				trimleft -
				trimright {}
				wordend -
				wordstart {}
			}
		}
		default {
			switch -- ${cmd} {
				compare -
				equal {
					if {"-length" == ${prev}} {
						return [DisplayHints <int>]
					}
					return [CompleteFromList ${text} \
					[RemoveUsedOptions $line {-nocase -length <string>}]]
				}

				is {
					if {"-failindex" == ${prev}} {
						return [VarCompletion ${text}]
					}
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {-strict -failindex <string>}]]
				}

				replace { return [DisplayHints ?newString?] }
			}
		}
	}
	return ""
}

proc complete(subst) {text start end line pos mod} {
	return [CompleteFromList ${text} [RemoveUsedOptions ${line} {
		-nobackslashes -nocommands -novariables <string>}]]
}

proc complete(switch) {text start end line pos mod} {
	set prev [PreviousWord ${start} ${line}]
	if {[llength ${prev}] && "--" != ${prev} && \
		("-" == [string index ${prev} 0] || 1 == ${pos)}} {
		set cmds [RemoveUsedOptions ${line} {
			-exact -glob -regexp --} {--}]
		if {[llength ${cmds}]} {
			return [string trim [CompleteFromList ${text} ${cmds}]]
		}
	} else {
		set virtual_pos [expr ${pos} - [FirstNonOption ${line}]]
		switch -- ${virtual_pos} {
			0 { return [DisplayHints <string>] }
			1 { return [DisplayHints <pattern>] }
			2 { return [DisplayHints <body>] }
			default { 
				switch [expr ${virtual_pos} % 2] {
					0 { return [DisplayHints ?body?] }
					1 { return [DisplayHints ?pattern?] }
				}
			}
		}
	}
	return ""
}

# --- TCLREADLINE PACKAGE ---

# create a tclreadline namespace inside
# tclreadline and import some commands.
#
namespace eval tclreadline {
	catch {
		namespace import \
		::tclreadline::DisplayHints \
		::tclreadline::CompleteFromList \
		::tclreadline::Lindex \
		::tclreadline::CompleteBoolean
	}
}

proc tclreadline::complete(readline) {text start end line pos mod} {
	set cmd [Lindex ${line} 1]
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} {
			read initialize write add complete customcompleter
			builtincompleter eofchar reset-terminal bell}]
		}
		2 {
			switch -- ${cmd} {
				read {}
				initialize {}
				write {}
				add { return [DisplayHints <completerLine>] }
				completer { return [DisplayHints <line>] }
				customcompleter { return [DisplayHints ?scriptCompleter?] }
				builtincompleter { return [CompleteBoolean ${text}] }
				eofchar { return [DisplayHints ?script?] }
				reset-terminal {
					if {[info exists ::env(TERM)]} {
						return [CompleteFromList ${text} $::env(TERM)]
					} else {
						return [DisplayHints ?terminalName?]
					}
				}
			}
		}
	}
	return ""
}

# --- END OF TCLREADLINE PACKAGE ---

proc complete(tell) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [ChannelId ${text}] }
	}
	return ""
}

proc complete(testthread) {text start end line pos mod} {

	set cmd [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				-async create errorproc exit id names send wait
			}]
		}
		2 {
			switch -- [PreviousWord ${start} ${line}] {
				create {
					return [BraceOrCommand \
					${text} ${start} ${end} ${line} ${pos} ${mod}]
				}
				-async {
					return [CompleteFromList ${text} send]
				}
				send {
					return [CompleteFromList ${text} [testthread names]]
				}
				default {}
			}
		}
		3 {
			if {"send" == [PreviousWord ${start} ${line}]} {
				return [CompleteFromList ${text} [testthread names]]
			} elseif {"send" == ${cmd}} {
				return [BraceOrCommand \
				${text} ${start} ${end} ${line} ${pos} ${mod}]
			}
		}
		4 {
			if {"send" == [Lindex ${line} 2]} {
				return [BraceOrCommand \
				${text} ${start} ${end} ${line} ${pos} ${mod}]
			}
		}
	}
	return ""
}

proc complete(time) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [BraceOrCommand \
			${text} ${start} ${end} ${line} ${pos} ${mod}]
		}
		2 { return [DisplayHints ?count?] }
	}
	return ""
}

proc complete(trace) {text start end line pos mod} {
	set cmd [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${mod} {variable vdelete vinfo}]
		}
		2 {
			return [CompleteFromList ${text} \
			[uplevel [info level] info vars "${mod}*"]]
		}
		3 {
			switch -- ${cmd} {
				variable -
				variable { return [CompleteFromList ${text} {r w u}] }
				vdelete {
					set var [PreviousWord ${start} ${line}]
					set modes ""
					foreach info [uplevel [info level] trace vinfo ${var}] {
						lappend modes [lindex ${info} 0]
					}
					return [CompleteFromList ${text} ${modes}]
				}
			}
		}
		4 {
			switch -- ${cmd} {
				variable {
					return [CompleteFromList ${text} \
					[CommandCompletion ${text}]]
				}
				vdelete {
					set var [Lindex ${line} 2]
					set mode [PreviousWord ${start} ${line}]
					set scripts ""
					foreach info [uplevel [info level] trace vinfo ${var}] {
						if {${mode} == [lindex ${info} 0]} {
							lappend scripts [list [lindex ${info} 1]]
						}
					}
					return [DisplayHints ${scripts}]
				}
			}
		}
	}
	return ""
}

proc complete(unknown) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} [CommandCompletion ${text}]]
		}
		default { return [DisplayHints ?arg?] }
	}
	return ""
}

proc complete(unset) {text start end line pos mod} {
	return [VarCompletion ${text}]
}

proc complete(update) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return idletasks }
	}
	return ""
}

proc complete(uplevel) {text start end line pos mod} {
	set one [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList \
			${text} "?level? [CommandCompletion ${text}]"]
		}
		2 {
			if {"#" == [string index ${one} 0] || [regexp {^[0-9]*$} ${one}]} {
				return [CompleteFromList ${text} [CommandCompletion ${text}]]
			} else {
				return [DisplayHints ?arg?]
			}
		}
		default { return [DisplayHints ?arg?] }
	}
	return ""
}

proc complete(upvar) {text start end line pos mod} {
	set one [Lindex ${line} 1]
	switch -- $pos {
		1 {
			return [DisplayHints {?level? <otherVar>}]
		}
		2 {
			if {"#" == [string index $one 0] || [regexp {^[0-9]*$} $one]} {
				return [DisplayHints <otherVar>]
			} else {
				return [DisplayHints <myVar>]
			}
		}
		3 {
			if {"#" == [string index $one 0] || [regexp {^[0-9]*$} $one]} {
				return [DisplayHints <myVar>]
			} else {
				return [DisplayHints ?otherVar?]
			}
		}
		default {
			set virtual_pos $pos
			if {"#" == [string index $one 0] || [regexp {^[0-9]*$} $one]} {
				incr virtual_pos
			}
			switch [expr $virtual_pos % 2] {
				0 { return [DisplayHints ?myVar?] }
				1 { return [DisplayHints ?otherVar?] }
			}
		}
	}
	return ""
}

proc complete(variable) {text start end line pos mod} {
	set modulo [expr $pos % 2]
	switch -- $modulo {
		1 { return [VarCompletion ${text}] }
		0 {
			if {$text == "" || $text == "\"" || $text == "\{"} {
				set line [QuoteQuotes $line]
				if {[catch [list set value [list [uplevel [info level] \
					set [PreviousWord $start $line]]]] msg]
				} {
					return ""
				} else {
					return [Quote $value ${text}]
				}
			}
		}
	}
	return ""
}

proc complete(vwait) {text start end line pos mod} {
	switch -- $pos {
		1 { return [VarCompletion ${mod}] }
	}
	return ""
}

proc complete(while) {text start end line pos mod} {
	switch -- $pos {
		1 -
		2 {
			return [BraceOrCommand $text $start $end $line $pos $mod]
		}
	}
	return ""
}

# -------------------------------------
#                  TK
# -------------------------------------

# GENERIC WIDGET CONFIGURATION

proc WidgetChildren {{pattern .}} {
	regsub {^([^\.])} ${pattern} {\.\1} pattern
	if {![string length ${pattern}]} {
		set pattern .
	}
	if {[winfo exists ${pattern}]} {
		return [concat ${pattern} [winfo children ${pattern}]]
	} else {
		regsub {.[^.]*$} $pattern {.} pattern
		if {[winfo exists ${pattern}]} {
			return [concat ${pattern} [winfo children ${pattern}]]
		} else {
			return ""
		}
	}
}

proc WidgetDescendants {{pattern .}} {
	set tree [WidgetChildren ${pattern}]
	foreach widget $tree {
		append tree " [WidgetDescendants $widget]"
	}
	return $tree
}

proc ToplevelWindows {} {
	set children [WidgetChildren ""]
	set toplevels ""
	foreach widget $children {
		set toplevel [winfo toplevel $widget]
		if {-1 == [lsearch $toplevels $toplevel]} {
			lappend toplevels $toplevel
		}
	}
	return $toplevels
}

# TODO
# write a dispatcher here, which gets the widget class name
# and calls specific completers.
#
# proc complete(WIDGET_COMMAND) {text start end line pos mod} {
# 	return [CompleteFromOptionsOrSubCmds ${text} ${start} ${end} ${line} ${pos}]
# }

proc EventuallyInsertLeadingDot {text fallback} {
	if {![string length ${text}]} {
		return [list . {}]
	} else {
		return [DisplayHints ${fallback}]
	}
}

# TODO
proc CompleteColor {text {add ""}} {

	# we set the variable only once to speed up.
	#
	variable colors
	variable numberless_colors

	if ![info exists colors] {
		# from .. X11R6/lib/X11/rgb.txt
		# 
		set colors {
			snow GhostWhite WhiteSmoke gainsboro FloralWhite OldLace linen
			AntiqueWhite PapayaWhip BlanchedAlmond bisque PeachPuff NavajoWhite
			moccasin cornsilk ivory LemonChiffon seashell honeydew MintCream
			azure AliceBlue lavender LavenderBlush MistyRose white black
			DarkSlateGray DarkSlateGrey DimGray DimGrey SlateGray SlateGrey
			LightSlateGray LightSlateGrey gray grey LightGrey LightGray
			MidnightBlue navy NavyBlue CornflowerBlue DarkSlateBlue SlateBlue
			MediumSlateBlue LightSlateBlue MediumBlue RoyalBlue blue DodgerBlue
			DeepSkyBlue SkyBlue LightSkyBlue SteelBlue LightSteelBlue LightBlue
			PowderBlue PaleTurquoise DarkTurquoise MediumTurquoise turquoise
			cyan LightCyan CadetBlue MediumAquamarine aquamarine DarkGreen
			DarkOliveGreen DarkSeaGreen SeaGreen MediumSeaGreen LightSeaGreen
			PaleGreen SpringGreen LawnGreen green chartreuse MediumSpringGreen
			GreenYellow LimeGreen YellowGreen ForestGreen OliveDrab DarkKhaki
			khaki PaleGoldenrod LightGoldenrodYellow LightYellow yellow
			gold LightGoldenrod goldenrod DarkGoldenrod RosyBrown IndianRed
			SaddleBrown sienna peru burlywood beige wheat SandyBrown tan
			chocolate firebrick brown DarkSalmon salmon LightSalmon orange
			DarkOrange coral LightCoral tomato OrangeRed red HotPink DeepPink
			pink LightPink PaleVioletRed maroon MediumVioletRed VioletRed
			magenta violet plum orchid MediumOrchid DarkOrchid DarkViolet
			BlueViolet purple MediumPurple thistle snow1 snow2 snow3 snow4
			seashell1 seashell2 seashell3 seashell4 AntiqueWhite1 AntiqueWhite2
			AntiqueWhite3 AntiqueWhite4 bisque1 bisque2 bisque3 bisque4
			PeachPuff1 PeachPuff2 PeachPuff3 PeachPuff4 NavajoWhite1
			NavajoWhite2 NavajoWhite3 NavajoWhite4 LemonChiffon1 LemonChiffon2
			LemonChiffon3 LemonChiffon4 cornsilk1 cornsilk2 cornsilk3 cornsilk4
			ivory1 ivory2 ivory3 ivory4 honeydew1 honeydew2 honeydew3 honeydew4
			LavenderBlush1 LavenderBlush2 LavenderBlush3 LavenderBlush4
			MistyRose1 MistyRose2 MistyRose3 MistyRose4 azure1 azure2 azure3
			azure4 SlateBlue1 SlateBlue2 SlateBlue3 SlateBlue4 RoyalBlue1
			RoyalBlue2 RoyalBlue3 RoyalBlue4 blue1 blue2 blue3 blue4
			DodgerBlue1 DodgerBlue2 DodgerBlue3 DodgerBlue4 SteelBlue1
			SteelBlue2 SteelBlue3 SteelBlue4 DeepSkyBlue1 DeepSkyBlue2
			DeepSkyBlue3 DeepSkyBlue4 SkyBlue1 SkyBlue2 SkyBlue3 SkyBlue4
			LightSkyBlue1 LightSkyBlue2 LightSkyBlue3 LightSkyBlue4 SlateGray1
			SlateGray2 SlateGray3 SlateGray4 LightSteelBlue1 LightSteelBlue2
			LightSteelBlue3 LightSteelBlue4 LightBlue1 LightBlue2 LightBlue3
			LightBlue4 LightCyan1 LightCyan2 LightCyan3 LightCyan4
			PaleTurquoise1 PaleTurquoise2 PaleTurquoise3 PaleTurquoise4
			CadetBlue1 CadetBlue2 CadetBlue3 CadetBlue4 turquoise1
			turquoise2 turquoise3 turquoise4 cyan1 cyan2 cyan3 cyan4
			DarkSlateGray1 DarkSlateGray2 DarkSlateGray3 DarkSlateGray4
			aquamarine1 aquamarine2 aquamarine3 aquamarine4 DarkSeaGreen1
			DarkSeaGreen2 DarkSeaGreen3 DarkSeaGreen4 SeaGreen1 SeaGreen2
			SeaGreen3 SeaGreen4 PaleGreen1 PaleGreen2 PaleGreen3 PaleGreen4
			SpringGreen1 SpringGreen2 SpringGreen3 SpringGreen4 green1 green2
			green3 green4 chartreuse1 chartreuse2 chartreuse3 chartreuse4
			OliveDrab1 OliveDrab2 OliveDrab3 OliveDrab4 DarkOliveGreen1
			DarkOliveGreen2 DarkOliveGreen3 DarkOliveGreen4 khaki1 khaki2
			khaki3 khaki4 LightGoldenrod1 LightGoldenrod2 LightGoldenrod3
			LightGoldenrod4 LightYellow1 LightYellow2 LightYellow3 LightYellow4
			yellow1 yellow2 yellow3 yellow4 gold1 gold2 gold3 gold4 goldenrod1
			goldenrod2 goldenrod3 goldenrod4 DarkGoldenrod1 DarkGoldenrod2
			DarkGoldenrod3 DarkGoldenrod4 RosyBrown1 RosyBrown2 RosyBrown3
			RosyBrown4 IndianRed1 IndianRed2 IndianRed3 IndianRed4 sienna1
			sienna2 sienna3 sienna4 burlywood1 burlywood2 burlywood3 burlywood4
			wheat1 wheat2 wheat3 wheat4 tan1 tan2 tan3 tan4 chocolate1
			chocolate2 chocolate3 chocolate4 firebrick1 firebrick2 firebrick3
			firebrick4 brown1 brown2 brown3 brown4 salmon1 salmon2 salmon3
			salmon4 LightSalmon1 LightSalmon2 LightSalmon3 LightSalmon4 orange1
			orange2 orange3 orange4 DarkOrange1 DarkOrange2 DarkOrange3
			DarkOrange4 coral1 coral2 coral3 coral4 tomato1 tomato2 tomato3
			tomato4 OrangeRed1 OrangeRed2 OrangeRed3 OrangeRed4 red1 red2
			red3 red4 DeepPink1 DeepPink2 DeepPink3 DeepPink4 HotPink1
			HotPink2 HotPink3 HotPink4 pink1 pink2 pink3 pink4 LightPink1
			LightPink2 LightPink3 LightPink4 PaleVioletRed1 PaleVioletRed2
			PaleVioletRed3 PaleVioletRed4 maroon1 maroon2 maroon3 maroon4
			VioletRed1 VioletRed2 VioletRed3 VioletRed4 magenta1 magenta2
			magenta3 magenta4 orchid1 orchid2 orchid3 orchid4 plum1 plum2
			plum3 plum4 MediumOrchid1 MediumOrchid2 MediumOrchid3
			MediumOrchid4 DarkOrchid1 DarkOrchid2 DarkOrchid3 DarkOrchid4
			purple1 purple2 purple3 purple4 MediumPurple1 MediumPurple2
			MediumPurple3 MediumPurple4 thistle1 thistle2 thistle3 thistle4
			gray0 grey0 gray1 grey1 gray2 grey2 gray3 grey3 gray4 grey4 gray5
			grey5 gray6 grey6 gray7 grey7 gray8 grey8 gray9 grey9 gray10 grey10
			gray11 grey11 gray12 grey12 gray13 grey13 gray14 grey14 gray15
			grey15 gray16 grey16 gray17 grey17 gray18 grey18 gray19 grey19
			gray20 grey20 gray21 grey21 gray22 grey22 gray23 grey23 gray24
			grey24 gray25 grey25 gray26 grey26 gray27 grey27 gray28 grey28
			gray29 grey29 gray30 grey30 gray31 grey31 gray32 grey32 gray33
			grey33 gray34 grey34 gray35 grey35 gray36 grey36 gray37 grey37
			gray38 grey38 gray39 grey39 gray40 grey40 gray41 grey41 gray42
			grey42 gray43 grey43 gray44 grey44 gray45 grey45 gray46 grey46
			gray47 grey47 gray48 grey48 gray49 grey49 gray50 grey50 gray51
			grey51 gray52 grey52 gray53 grey53 gray54 grey54 gray55 grey55
			gray56 grey56 gray57 grey57 gray58 grey58 gray59 grey59 gray60
			grey60 gray61 grey61 gray62 grey62 gray63 grey63 gray64 grey64
			gray65 grey65 gray66 grey66 gray67 grey67 gray68 grey68 gray69
			grey69 gray70 grey70 gray71 grey71 gray72 grey72 gray73 grey73
			gray74 grey74 gray75 grey75 gray76 grey76 gray77 grey77 gray78
			grey78 gray79 grey79 gray80 grey80 gray81 grey81 gray82 grey82
			gray83 grey83 gray84 grey84 gray85 grey85 gray86 grey86 gray87
			grey87 gray88 grey88 gray89 grey89 gray90 grey90 gray91 grey91
			gray92 grey92 gray93 grey93 gray94 grey94 gray95 grey95 gray96
			grey96 gray97 grey97 gray98 grey98 gray99 grey99 gray100 grey100
			DarkGrey DarkGray DarkBlue DarkCyan DarkMagenta DarkRed LightGreen
		}
	}
	if ![info exists numberless_colors] {
		set numberless_colors ""
		foreach color ${colors} {
			regsub -all {[0-9]*} ${color} "" color
			lappend numberless_colors ${color}
		}
		set numberless_colors [Lunique [lsort ${numberless_colors}]]
	}
	set matches [MatchesFromList ${text} ${numberless_colors}]
	if {[llength ${matches}] < 5} {
		set matches [MatchesFromList ${text} ${colors}]
		if {[llength ${matches}]} {
			return [CompleteFromList ${text} [concat ${colors} ${add}]]
		} else {
			return [CompleteFromList ${text} \
			[concat ${numberless_colors} ${add}]]
		}
	} else {
		return [CompleteFromList ${text} [concat ${numberless_colors} ${add}]]
	}
}

proc CompleteCursor text {
	# from <X11/cursorfont.h>
	# 
	return [CompleteFromList ${text} {
		num_glyphs x_cursor arrow based_arrow_down based_arrow_up
		boat bogosity bottom_left_corner bottom_right_corner
		bottom_side bottom_tee box_spiral center_ptr circle clock
		coffee_mug cross cross_reverse crosshair diamond_cross dot
		dotbox double_arrow draft_large draft_small draped_box
		exchange fleur gobbler gumby hand1 hand2 heart icon iron_cross
		left_ptr left_side left_tee leftbutton ll_angle lr_angle
		man middlebutton mouse pencil pirate plus question_arrow
		right_ptr right_side right_tee rightbutton rtl_logo sailboat
		sb_down_arrow sb_h_double_arrow sb_left_arrow sb_right_arrow
		sb_up_arrow sb_v_double_arrow shuttle sizing spider spraycan
		star target tcross top_left_arrow top_left_corner
		top_right_corner top_side top_tee trek ul_angle umbrella
		ur_angle watch xterm
	}]
}

#**
# SpecificSwitchCompleter
# ---
# @param    text   -- the word to complete.
# @param    start  -- the char index of text's start in line
# @param    line   -- the line gathered so far.
# @param    switch -- the switch to complete for.
# @return   a std tclreadline formatted completer string.
# @sa       CompleteWidgetConfigurations
# @date     Sep-17-1999
#
proc SpecificSwitchCompleter {text start line switch {always 1}} {

	switch -- ${switch} {

		-activebackground -
		-activeforeground -
		-fg -
		-foreground -
		-bg -
		-background -
		-disabledforeground -
		-highlightbackground -
		-highlightcolor -
		-insertbackground -
		-troughcolor -
		-selectbackground -
		-selectforeground { return [CompleteColor ${text}] }

		-activeborderwidth -
		-bd -
		-borderwidth -
		-insertborderwidth -
		-insertwidth -
		-selectborderwidth -
		-highlightthickness -
		-padx -
		-pady -
		-wraplength {
			if ${always} {
				return [DisplayHints <pixels>]
			} else {
				return ""
			}
		}

		-anchor {
			return [CompleteFromList ${text} {
				n ne e se s sw w nw center
			}]
		}


		-bitmap { return [CompleteFromBitmaps ${text} ${always}] }


		-cursor {
			return [CompleteCursor ${text}]
			# return [DisplayHints <cursor>]
		}
		-exportselection -
		-jump -
		-setgrid -
		-takefocus { return [CompleteBoolean ${text}] }
		-font {
			set names [font names]
			if {[string length ${names}]} {
				return [CompleteFromList ${text} ${names}]
			} else {
				if ${always} {
					return [DisplayHints <font>]
				} else {
					return ""
				}
			}
		}


		-image -
		-selectimage { return [CompleteFromImages ${text} ${always}] }
		-selectmode {
			return [CompleteFromList ${text} {
				single browse multiple extended
			}]
		}

		-insertofftime -
		-insertontime -
		-repeatdelay -
		-repeatinterval {
			if ${always} {
				return [DisplayHints <milliSec>]
			} else {
				return ""
			}
		}
		-justify {
			return [CompleteFromList ${text} {
				left center right
			}]
		}
		-orient {
			return [CompleteFromList ${text} {
				vertical horizontal
			}]
		}
		-relief {
			return [CompleteFromList ${text} {
				raised sunken flat ridge solid groove
			}]
		}

		-text {
			if ${always} {
				return [DisplayHints <text>]
			} else {
				return ""
			}
		}
		-textvariable { return [VarCompletion ${text} #0] }
		-underline {
			if ${always} {
				return [DisplayHints <index>]
			} else {
				return ""
			}
		}

-xscrollcommand -
-yscrollcommand {
}
 
        # WIDGET SPECIFIC OPTIONS
		# ---
 
		-state {
			return [CompleteFromList ${text} {
				normal active disabled
			}]
		}

		-columnbreak -
		-hidemargin -
		-indicatoron {
			return [CompleteBoolean ${text}]
		}

		-variable {
			return [VarCompletion ${text} #0]
		}

		default {
			# if ${always} {
			#	set prev [PreviousWord ${start} ${line}]
			#	return [DisplayHints <[String range ${prev} 1 end]>]
			#} else {
				return ""
			#}
		}
	}
}
			# return [BraceOrCommand ${text} \
			# ${start}  ${line} ${pos} ${mod}]

#**
# CompleteWidgetConfigurations
# ---
# @param    text  -- the word to complete.
# @param    start -- the actual cursor position.
# @param    line  -- the line gathered so far.
# @param    lst   -- a list of possible completions.
# @return   a std tclreadline formatted completer string.
# @sa       SpecificSwitchCompleter
# @date     Sep-17-1999
#
proc CompleteWidgetConfigurations {text start line lst} {
	set prev [PreviousWord ${start} ${line}]
	if {"-" == [string index ${prev} 0]} {
		return [SpecificSwitchCompleter ${text} ${start} ${line} ${prev}]
	} else {
		return [CompleteFromList ${text} \
		[RemoveUsedOptions ${line} ${lst}]]
	}
}

# --------------------------------------
# === SPECIFIC TK COMMAND COMPLETERS ===
# --------------------------------------

proc complete(bell) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} -displayof] }
		2 {
			if {"-displayof" == [PreviousWord ${start} ${line}]} {
				return [CompleteFromList ${text} [ToplevelWindows]]
			}
		}
	}
}

proc CompleteSequence {text fulltext} {
	set modifiers {
		Alt Control Shift Lock Double Triple
		B1 B2 B3 B4 B5 Button1 Button2 Button3 Button4 Button5
		M M1 M2 M3 M4 M5        
		Meta Mod1 Mod2 Mod3 Mod4 Mod5
	}
	set events {
		Activate Button ButtonPress ButtonRelease
		Circulate Colormap Configure Deactivate Destroy
		Enter Expose FocusIn FocusOut Gravity
		Key KeyPress KeyRelease Leave Map Motion
		MouseWheel Property Reparent Unmap Visibility
	}
	set sequence [concat ${modifiers} ${events}]
	return [CompleteListFromList ${text} ${fulltext} ${sequence} < - >]
}

proc complete(bind) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			set widgets [WidgetChildren ${text}]
			set toplevels [ToplevelWindows]
			if {[catch {set toplevelClass [winfo class .]}]} {
				set toplevelClass ""
			}
			set rest {
				Button Canvas Checkbutton Entry Frame Label
				Listbox Menu Menubutton Message Radiobutton
				Scale Scrollbar Text
				all
			}
			return [CompleteFromList ${text} \
			[concat ${toplevels} ${widgets} ${toplevelClass} $rest]]
		}
		2 {
			return [CompleteSequence ${text} [Lindex ${line} 2]]
		}
		default {
			# return [DisplayHints {<script> <+script>}]
			return [BraceOrCommand ${text} \
			${start} ${end} ${line} ${pos} ${mod}]
		}
	}
	return ""
}

proc complete(bindtags) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
		2 {
			# set current_tags \
			# [RemoveUsedOptions ${line} [bindtags [Lindex ${line} 1]]]
			set current_tags [bindtags [Lindex ${line} 1]]
			return [CompleteListFromList ${text} [Lindex ${line} 2] \
			${current_tags} \{ { } \}]
		}
	}
	return ""
}

proc complete(button) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -activeforeground -anchor
				-background -bitmap -borderwidth -cursor
				-disabledforeground -font -foreground
				-highlightbackground -highlightcolor
				-highlightthickness -image -justify
				-padx -pady -relief -takefocus -text
				-textvariable -underline -wraplength
				-command -default -height -state -width
			}]
		}
	}
	return ""
}

proc complete(canvas) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-background -borderwidth -cursor -highlightbackground
				-highlightcolor -highlightthickness -insertbackground
				-insertborderwidth -insertofftime -insertontime
				-insertwidth -relief -selectbackground -selectborderwidth
				-selectforeground -takefocus -xscrollcommand -yscrollcommand
				-closeenough -confine -height -scrollregion -width
				-xscrollincrement -yscrollincrement
			}]
		}
	}
	return ""
}

proc complete(checkbutton) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground activeBackground Foreground 
				-activeforeground -anchor -background -bitmap
				-borderwidth -cursor -disabledforeground -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -image -justify -padx -pady
				-relief -takefocus -text -textvariable -underline
				-wraplength -command -height -indicatoron -offvalue
				-onvalue -selectcolor -selectimage -state -variable
				-width
			}]
		}
	}
	return ""
}

proc complete(clipboard) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} {append clear}] }
		default {
			set sub [Lindex ${line} 1]
			set prev [PreviousWord ${start} ${line}]
			switch -- ${sub} {
				append {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} [ToplevelWindows]]
						}
						-format { return [DisplayHints <format>] }
						-type { return [DisplayHints <type>] }
						default {
							set opts [RemoveUsedOptions ${line} {
								-displayof -format -type --
							} {--}]
							if {![string length ${opts}]} {
								return [DisplayHints <data>]
							} else {
								return [CompleteFromList ${text} ${opts}]
							}
						}
					}
				}
				clear {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} [ToplevelWindows]]
						}
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} {
								-displayof
							}]]
						}
					}
				}
			}
		}
	}
}

proc complete(destroy) {text start end line pos mod} {
	set remaining [RemoveUsedOptions ${line} [WidgetChildren ${text}]]
	return [CompleteFromList ${text} ${remaining}]
}

proc complete(entry) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-background -borderwidth -cursor -exportselection
				-font -foreground -highlightbackground -highlightcolor
				-highlightthickness -insertbackground -insertborderwidth
				-insertofftime -insertontime -insertwidth -justify -relief
				-selectbackground -selectborderwidth -selectforeground
				-takefocus -textvariable -xscrollcommand -show -state
				-width
			}]
		}
	}
	return ""
}

proc complete(event) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} { add delete generate info }]
		}
		2 {
			switch -- ${sub} {
				add { return [DisplayHints <<virtual>>] }
				info -
				delete {
					return [CompleteFromList ${text} [event info] "<"]
				}
				generate {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
			}
		}
		3 {
			switch -- ${sub} {
				add -
				delete -
				generate {
					return [CompleteSequence ${text} [Lindex ${line} 3]]
				}
				info {}
			}
		}
		default {
			switch -- ${sub} {
				add -
				delete {
					return [CompleteSequence ${text} [Lindex ${line} 3]]
				}
				info {}
				generate {

					switch -- [PreviousWord ${start} ${line}] {

						-above -
						-root -
						-subwindow {
							return [TryFromList ${text} \
							[WidgetChildren ${text}]]
						}

						-borderwidth { return [DisplayHints <size>] }

						-button -
						-delta -
						-keycode -
						-serial -
						-count { return [DisplayHints <number>] }

						-detail {
							return [CompleteFromList ${text} { 
								NotifyAncestor    NotifyNonlinearVirtual
								NotifyDetailNone  NotifyPointer
								NotifyInferior    NotifyPointerRoot
								NotifyNonlinear   NotifyVirtual
							}]
						}

						-focus -
						-override -
						-sendevent { return [CompleteBoolean ${text}] }

						-height -
						-width { return [DisplayHints <size>] }

						-keysym { return [DisplayHints <name>] }

						-mode {
							return [CompleteFromList ${text} { 
								NotifyNormal NotifyGrab
								NotifyUngrab NotifyWhileGrabbed
							}]
						}

						-place {
							return [CompleteFromList ${text} { 
								PlaceOnTop PlaceOnBottom
							}]
						}

						-rootx -
						-rooty -
						-x -
						-y { return [DisplayHints <coord>] }

						-state {
							return [CompleteFromList ${text} { 
								VisibilityUnobscured
								VisibilityPartiallyObscured
								VisibilityFullyObscured
								<integer>
							}]
						}

						-time { return [DisplayHints <integer>] }
						-when {
							return [CompleteFromList ${text} { 
								now tail head mark
							}]
						}

						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} {
								-above -borderwidth -button -count -delta
								-detail -focus -height -keycode -keysym
								-mode -override -place -root -rootx -rooty
								-sendevent -serial -state -subwindow -time
								-width -when -x -y
							}]]

						}
					}
					default { }
				}
			}
		}
	}
	return ""
}

proc complete(focus) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} \
			[concat [WidgetChildren ${text}] -displayof -force -lastfor]]
		}
		default {
			switch -- [PreviousWord ${start} ${line}] {
				-displayof -
				-force -
				-lastfor {
					return [CompleteFromList ${text} \
					[WidgetChildren ${text}]]
				}
			}
		}
	}
	return ""
}

proc FontConfigure {text line prev} {
	set fontopts {-family -overstrike -size -slant -underline -weight}
	switch -- ${prev} {
		-family {
			return [CompleteFromList ${text} [font families]]
		}
		-underline -
		-overstrike { return [CompleteBoolean ${text}] }
		-size { return [DisplayHints <size>] }
		-slant {
			return [CompleteFromList ${text} { roman italic }]
		}
		-weight {
			return [CompleteFromList ${text} { normal bold }]
		}
		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} ${fontopts}]]
		}
	}
}

proc complete(font) {text start end line pos mod} {
	set fontopts {-family -overstrike -size -slant -underline -weight}
	set fontmetrics {-ascent -descent -linespace -fixed}
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				actual configure create delete families measure metrics names
			}]
		}
		2 {
			switch -- ${sub} {
				actual -
				measure -
				metrics {
					return [DisplayHints <font>]
				}
				configure -
				delete {
					set names [font names]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <fontname>]
					}
				}
				create {
					return [CompleteFromList ${text} \
					[concat ?fontname? ${fontopts}]]
				}
				families {
					return [CompleteFromList ${text} -displayof]
				}
				names {}
			}
		}
		3 {
			switch -- ${sub} {
				actual {
					return [CompleteFromList ${text} \
					[concat -displayof ${fontopts}]]
				}
				configure -
				create {
					return [FontConfigure ${text} ${line} ${prev}]
				}
				delete {
					set names [font names]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <fontname>]
					}
				}
				families {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} \
							[WidgetChildren ${text}]]
						}
					}
				}
				measure {
					return [CompleteFromList ${text} {-displayof <text>}]
				}
				metrics {
					return [CompleteFromList ${text} \
					[concat -displayof ${fontmetrics}]]
				}
				names {}
			}
		}
		4 {
			switch -- ${sub} {
				actual {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default {
							return [FontConfigure ${text} ${line} ${prev}]
						}
					}
				}
				configure -
				create {
					return [FontConfigure ${text} ${line} ${prev}]
				}
				delete {
					set names [font names]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <fontname>]
					}
				}
				families {}
				measure {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default {
							return [DisplayHints <text>]
						}
					}
				}
				metrics {
					switch -- ${prev} {
						-displayof {
							return [CompleteFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default {
							return [CompleteFromList ${text} ${fontmetrics}]
						}
					}
				}
				names {}
			}
		}
		default {
			switch -- ${sub} {
				actual -
				configure -
				create {
					return [FontConfigure ${text} ${line} ${prev}]
				}
				delete {
					set names [font names]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <fontname>]
					}
				}
				families {}
				measure {
					return [DisplayHints <text>]
				}
				metrics {
					return [CompleteFromList ${text} ${fontmetrics}]
				}
				names {}
			}
		}
	}
	return ""
}

proc complete(frame) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-borderwidth -cursor -highlightbackground -highlightcolor
				-highlightthickness -relief -takefocus -background
				-class -colormap -container -height -visual -width
			}]
		}
	}
	return ""
}

proc complete(grab) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} [concat \
			current release set status -global [WidgetChildren ${text}]]]
		}
		2 {
			switch -- [Lindex ${line} 1] {
				-global -
				current -
				release -
				status {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				set {
					return [CompleteFromList ${text} \
					[concat -global [WidgetChildren ${text}]]]
				}
			}
		}
		3 {
			switch -- [Lindex ${line} 1] {
				set {
					switch -- [PreviousWord ${start} ${line}] {
						-global {
							return [CompleteFromList ${text} \
							[WidgetChildren ${text}]]
						}
					}
				}
			}
		}
	}
	return ""
}

proc GridConfig {text start line prev} {
	set opts {
		-column -columnspan -in -ipadx -ipady
		-padx -pady -row -rowspan -sticky
	}
	if {-1 == [string first "-" ${line}]} {
		set slave [WidgetChildren ${text}]
	} else {
		set slave ""
	}
	switch -- ${prev} {
		-column -
		-columnspan -
		-row -
		-rowspan { return [DisplayHints <n>] }

		-ipadx -
		-ipady -
		-padx -
		-pady { return [DisplayHints <amount>] }

		-in { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
		-sticky {
			set prev [PreviousWordOfIncompletePosition ${start} ${line}]
			return [CompleteListFromList ${text} \
			[string trimleft [IncompleteListRemainder ${line}]] \
			{n e s w} \{ { } \}]
		}


		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} [concat ${opts} ${slave}]]]
		}
	}
}
 
proc complete(grid) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} \
			[concat [WidgetChildren ${text}] {
				bbox columnconfigure configure forget
				info location propagate rowconfigure
				remove size slaves
			}]]
		}
		2 {
			switch -- ${sub} {
				bbox -
				columnconfigure -
				configure -
				forget -
				info -
				location -
				propagate -
				rowconfigure -
				remove -
				size -
				slaves {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				default {
					return [GridConfig ${text} ${start} ${line} ${prev}]
				}
			}
		}
		default {
			switch -- ${sub} {
				bbox {
					switch [expr ${pos} % 2] {
						0 { return [DisplayHints ?row?] }
						1 { return [DisplayHints ?column?] }
					}
				}
				rowconfigure -
				columnconfigure {
					switch -- ${pos} {
						3 { return [DisplayHints <index>] }
						default {
							switch -- ${prev} {
								-minsize { return [DisplayHints <minsize>] }
								-weight { return [DisplayHints <weight>] }
								-pad { return [DisplayHints <pad>] }
								default {
									return [CompleteFromList ${text} \
									[RemoveUsedOptions ${line}  {
										-minsize -weight -pad
									}]]
								}
							}
						}
					}
				}
				configure {
					return [GridConfig ${text} ${start} ${line} ${prev}]
				}
				forget -
				remove {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				info {}
				location {
					switch -- ${pos} {
						3 { return [DisplayHints <x>] }
						4 { return [DisplayHints <y>] }
					}
				}
				propagate {
					switch -- ${pos} {
						3 { return [CompleteBoolean ${text}] }
					}
				}
				size {}
				slaves {
					switch -- ${prev} {
						-row { return [DisplayHints <row>] }
						-column { return [DisplayHints <column>] }
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line}  { -row -column }]]
						}
					}
				}
				default {
					return [GridConfig ${text} ${start} ${line} ${prev}]
				}
			}
		}
	}
	return ""
}

proc complete(image) {text start end line pos mod} {
set sub [Lindex ${line} 1]
	switch -- ${pos} {
		1 { return [TrySubCmds ${text} image] }
		2 {
			switch -- ${sub} {
				create { return [CompleteFromList ${text} [image types]] }
				delete -
				height -
				type -
				width { return [CompleteFromList ${text} [image names]] }
				names {}
				types {}
			}
		}
		3 {
			switch -- ${sub} {
				create {
					set type [Lindex ${line} 2]
					switch -- ${type} {
						bitmap {
							return [CompleteFromList ${text} {
								?name? -background -data -file
								-foreground -maskdata -maskfile
							}]
						}
						photo {
							return [CompleteFromList ${text} {
								?name? -data -format -file -gamma
								-height -palette -width
							}]
						}
						default {}
					}
				}
				delete { return [CompleteFromList ${text} [image names]] }
				default {}
			}
		}
		default {
			switch -- ${sub} {
				create {
					set type [Lindex ${line} 2]
					set prev [PreviousWord ${start} ${line}]
					# puts stderr prev=$prev
					switch -- ${type} {
						bitmap {
							switch -- ${prev} {
								-background -
								-foreground { return [DisplayHints <color>] }
								-data -
								-maskdata { return [DisplayHints <string>] }
								-file -
								-maskfile { return "" }
								default {
									return [CompleteFromList ${text} \
									[RemoveUsedOptions ${line} {
										-background -data -file
										-foreground -maskdata -maskfile
									}]]
								}
							}
						}
						photo {
							switch -- ${prev} {
								-data { return [DisplayHints <string>] }
								-file { return "" }
								-format { return [DisplayHints <format-name>] }
								-gamma { return [DisplayHints <value>] }
								-height -
								-width { return [DisplayHints <number>] }
								-palette {
									return [DisplayHints <palette-spec>]
								}
								default {
									return [CompleteFromList ${text} \
									[RemoveUsedOptions ${line} {
										-data -format -file -gamma
										-height -palette -width
									}]]
								}
							}
						}
					}
				}
				delete { return [CompleteFromList ${text} [image names]] }
				default {}
			}
		}
	}
}

proc complete(label) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-anchor -background -bitmap -borderwidth -cursor -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -image -justify -padx -pady -relief
				-takefocus -text -textvariable -underline -wraplength
				-height -width
			}]
		}
	}
	return ""
}

proc complete(listbox) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-background -borderwidth -cursor -exportselection -font
				-foreground -height -highlightbackground -highlightcolor
				-highlightthickness -relief -selectbackground
				-selectborderwidth -selectforeground -setgrid -takefocus
				-width -xscrollcommand -yscrollcommand -height -selectmode
				-width
			}]
		}
	}
	return ""
}

proc complete(lower) {text start end line pos mod} {
	switch -- ${pos} {
		1 -
		2 {
			return [CompleteFromList ${text} [WidgetChildren ${text}]]
		}
	}
}

proc complete(menu) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -activeborderwidth -activeforeground
				-background -borderwidth -cursor -disabledforeground
				-font -foreground -relief -takefocus -postcommand
				-selectcolor -tearoff -tearoffcommand -title -type
			}]
		}
	}
	return ""
}

proc complete(menubutton) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -activeforeground -anchor -background
				-bitmap -borderwidth -cursor -disabledforeground -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -image -justify -padx -pady -relief
				-takefocus -text -textvariable -underline -wraplength
				-direction -height -indicatoron -menu -state -width
			}]
		}
	}
	return ""
}

proc complete(message) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-anchor -background -borderwidth -cursor -font -foreground
				-highlightbackground -highlightcolor -highlightthickness
				-padx -pady -relief -takefocus -text -textvariable -width 
				-aspect -justify -width
			}]
		}
	}
	return ""
}

proc OptionPriority text {
	return [CompleteFromList ${text} {
		widgetDefault startupFile userDefault interactive
	}]
}

proc complete(option) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				add clear get readfile
			}]
		}
		2 {
			switch -- ${sub} {
				add { return [DisplayHints <pattern>] }
				get {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				readfile { return "" }
			}
		}
		3 {
			switch -- ${sub} {
				add { return [DisplayHints <value>] }
				get { return [DisplayHints <name>] }
				readfile { return [OptionPriority ${text}] }
			}
		}
		4 {
			switch -- ${sub} {
				add { return [OptionPriority ${text}] }
				get {
					return [CompleteFromList ${text} \
					[ClassTable [Lindex ${line} 2]]]
				}
				readfile {}
			}
		}
	}
}

proc PackConfig {text line prev} {
	set opts {
		-after -anchor -before -expand -fill
		-in -ipadx -ipady -padx -pady -side
	}
	if {-1 == [string first "-" ${line}]} {
		set slave [WidgetChildren ${text}]
	} else {
		set slave ""
	}
	switch -- ${prev} {
		-after -
		-before  { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
		-anchor { return [CompleteAnchor ${text}] }
		-expand { return [CompleteBoolean ${text}] }
		-fill { return [CompleteFromList ${text} { none x y both }] }

		-ipadx -
		-ipady -
		-padx -
		-pady { return [DisplayHints <amount>] }

		-in { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
		-side { return [CompleteFromList ${text} { left right top bottom }] }

		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} [concat ${opts} ${slave}]]]
		}
	}
}

proc complete(pack) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} \
			[concat [WidgetChildren ${text}] {
				configure forget info propagate slaves
			}]]
		}
		2 {
			switch -- ${sub} {
				configure -
				forget -
				info -
				propagate -
				slaves {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				default {
					return [PackConfig ${text} ${line} ${prev}]
				}
			}
		}
		default {
			switch -- ${sub} {
				configure {
					return [PackConfig ${text} ${line} ${prev}]
				}
				forget {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				info {}
				propagate {
					switch -- ${pos} {
						3 { return [CompleteBoolean ${text}] }
					}
				}
				slaves {}
				default {
					return [PackConfig ${text} ${line} ${prev}]
				}
			}
		}
	}
	return ""
}

proc PlaceConfig {text line prev} {
	set opts {
		-in -x -relx -y -rely -anchor -width
		-relwidth -height -relheight -bordermode
	}
	switch -- ${prev} {

		-in { return [CompleteFromList ${text} [WidgetChildren ${text}]] }

		-x -
		-relx -
		-y -
		-rely { return [DisplayHints <location>] }

		-anchor { return [CompleteAnchor ${text}] }

		-width -
		-relwidth -
		-height -
		-relheight { return [DisplayHints <size>] }

		-bordermode {
			return [CompleteFromList ${text} {ignore inside outside}]
		}

		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} ${opts}]]
		}
	}
}

proc complete(place) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} \
			[concat [WidgetChildren ${text}] {
				configure forget info slaves
			}]]
		}
		2 {
			switch -- ${sub} {
				configure -
				forget -
				info -
				slaves {
					return [CompleteFromList ${text} [WidgetChildren ${text}]]
				}
				default {
					return [PlaceConfig ${text} ${line} ${prev}]
				}
			}
		}
		default {
			switch -- ${sub} {
				configure {
					return [PlaceConfig ${text} ${line} ${prev}]
				}
				forget {}
				info {}
				slaves {}
				default {
					return [PlaceConfig ${text} ${line} ${prev}]
				}
			}
		}
	}
	return ""
}

proc complete(radiobutton) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -activeforeground -anchor -background
				-bitmap -borderwidth -cursor -disabledforeground -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -image -justify -padx -pady -relief
				-takefocus -text -textvariable -underline -wraplength -command
				-height -indicatoron -selectcolor -selectimage -state -value
				-variable -width
			}]
		}
	}
	return ""
}

proc complete(raise) {text start end line pos mod} {
	return [complete(lower) ${text} ${start} ${end} ${line} ${pos} ${mod}]
}

proc complete(scale) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -background -borderwidth -cursor -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -orient -relief -repeatdelay
				-repeatinterval -takefocus -troughcolor -bigincrement
				-command -digits -from -label -length -resolution
				-showvalue -sliderlength -sliderrelief -state -tickinterval
				-to -variable -width
			}]
		}
	}
	return ""
}

proc complete(scrollbar) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-activebackground -background -borderwidth -cursor
				-highlightbackground -highlightcolor -highlightthickness
				-jump -orient -relief -repeatdelay -repeatinterval
				-takefocus -troughcolor -activerelief -command
				-elementborderwidth -width
			}]
		}
	}
	return ""
}

proc SelectionOpts {text start end line pos mod lst} {
	set prev [PreviousWord ${start} ${line}]
	if {-1 == [lsearch ${lst} ${prev}]} {
		set prev "" ;# force the default arm
	}
	switch -- ${prev} {
		-displayof {
			return [CompleteFromList ${text} \
			[WidgetChildren ${text}]]
		}
		-selection {
			variable selection-selections
			return [CompleteFromList ${text} ${selection-selections}]
		}
		-type {
			variable selection-types
			return [CompleteFromList ${text} ${selection-types}]
		}
		-command {
			return [BraceOrCommand ${text} \
			${start} ${end} ${line} ${pos} ${mod}]
		}
		-format {
			variable selection-formats
			return [CompleteFromList ${text} ${selection-formats}]
		}
		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} ${lst}]]
		}
	}
}

proc complete(selection) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [TrySubCmds ${text} [Lindex ${line} 0]]
		}
		default {
			set sub [Lindex ${line} 1]
			set widgets [WidgetChildren ${text}]
			switch -- ${sub} {
				clear {
					return [SelectionOpts \
					${text} ${start} ${end} ${line} ${pos} ${mod} {
						-displayof -selection
					}]
				}
				get {
					return [SelectionOpts \
					${text} ${start} ${end} ${line} ${pos} ${mod} {
						-displayof -selection -type
					}]
				}
				handle {
					return [SelectionOpts \
					${text} ${start} ${end} ${line} ${pos} ${mod} \
					[concat {-selection -type -format} ${widgets}]]
				}
				own {
					return [SelectionOpts \
					${text} ${start} ${end} ${line} ${pos} ${mod} \
					[concat {-command -selection} ${widgets}]]
				}
			}
		}
	}
}

proc complete(send) {text start end line pos mod} {
	set prev [PreviousWord ${start} ${line}]
	if {"-displayof" == ${prev}} {
		return [TryFromList ${text} [WidgetChildren ${text}]]
	}
	set cmds [RemoveUsedOptions ${line} {
		-async -displayof --
	} {--}]
	if {[llength ${cmds}]} {
		return [string trim [CompleteFromList ${text} \
		[concat ${cmds} <app>]]]
	} else {
		if {[regexp -- --$ ${line}]} {
			return [list {--}]; # append a blank
		} else {
			# TODO make this better!
			return [DisplayHints [list {<app cmd ?arg ...?>}]]
		}
	}
	return ""
}

proc complete(text) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-background -borderwidth -cursor -exportselection -font
				-foreground -highlightbackground -highlightcolor
				-highlightthickness -insertbackground -insertborderwidth
				-insertofftime -insertontime -insertwidth -padx -pady
				-relief -selectbackground -selectborderwidth
				-selectforeground -setgrid -takefocus -xscrollcommand
				-yscrollcommand -height -spacing1 -spacing2 -spacing3
				-state -tabs -width -wrap
			}]
		}
	}
	return ""
}

proc complete(tk) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [TrySubCmds ${text} [Lindex ${line} 0]]
		}
		default {
			switch -- [Lindex ${line} 1] {
				appname { return [DisplayHints ?newName?]  }
				scaling {
					switch -- [PreviousWord ${start} ${line}] {
						-displayof {
							return [TryFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} {-displayof ?number?}]]
						}
					}
				}
			}
		}
	}
}

# proc complete(tk_bisque) {text start end line pos mod} {
# }

proc complete(tk_chooseColor) {text start end line pos mod} {
	switch -- [PreviousWord ${start} ${line}] {
		-initialcolor { return [CompleteColor ${text}] }
		-parent { return [TryFromList ${text} [WidgetChildren ${text}]] }
		-title { return [DisplayHints <string>] }
		default {
			return [TryFromList ${text} \
			[RemoveUsedOptions ${line} {-initialcolor -parent -title}]]
		}
	}
}

proc complete(tk_dialog) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [ToplevelWindows]] }
		2 { return [DisplayHints <title>] }
		3 { return [DisplayHints <text>] }
		4 { return [CompleteFromBitmaps ${text}] }
		5 { return [DisplayHints <defaultIndex>] }
		default { return [DisplayHints ?buttonName?] }
	}
}

proc complete(tk_focusNext) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
	}
}

proc complete(tk_focusPrev) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [CompleteFromList ${text} [WidgetChildren ${text}]] }
	}
}

# proc complete(tk_focusFollowsMouse) {text start end line pos mod} {
# }

proc GetOpenSaveFile {text start end line pos mod {add ""}} {
	# enable filename completion for the first four switches.
	switch -- [PreviousWord ${start} ${line}] {
		-defaultextension {}
		-filetypes {}
		-initialdir {}
		-initialfile {}
		-parent {
			return [CompleteFromList ${text} [WidgetChildren ${text}]]
		}
		-title { return [DisplayHints <titleString>] }
		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} [concat {
				-defaultextension -filetypes -initialdir -parent -title
			} ${add}]]]
		}
	}
}

proc complete(tk_getOpenFile) {text start end line pos mod} {
	return [GetOpenSaveFile \
	${text} ${start} ${end} ${line} ${pos} ${mod}]
}

proc complete(tk_getSaveFile) {text start end line pos mod} {
	return [GetOpenSaveFile \
	${text} ${start} ${end} ${line} ${pos} ${mod} -initialfile]
}

proc complete(tk_messageBox) {text start end line pos mod} {
	switch -- [PreviousWord ${start} ${line}] {
		-default {
			return [CompleteFromList ${text} {
				abort cancel ignore no ok retry yes
			}]
		}
		-icon {
			return [CompleteFromList ${text} {
				error info question warning
			}]
		}
		-message { return [DisplayHints <string>] }
		-parent {
			return [CompleteFromList ${text} [WidgetChildren ${text}]]
		}
		-title { return [DisplayHints <titleString>] }
		-type {
			return [CompleteFromList ${text} {
				abortretryignore ok okcancel retrycancel yesno yesnocancel
			}]
		}
		default {
			return [CompleteFromList ${text} \
			[RemoveUsedOptions ${line} {
				-default -icon -message -parent -title -type
			}]]
		}
	}
}

proc complete(tk_optionMenu) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		2 { return [VarCompletion ${text} #0] }
		3 { return [DisplayHints <value>] }
		default { return [DisplayHints ?value?] }
	}
}

proc complete(tk_popup) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			# display only menu widgets
			#
			set widgets [WidgetChildren ${text}]
			set menu_widgets ""
			foreach widget ${widgets} {
				if {"Menu" == [winfo class ${widget}]} {
					lappend menu_widgets ${widget}
				}
			}
			if {[llength ${menu_widgets}]} {
				return [TryFromList ${text} ${menu_widgets}]
			} else {
				return [DisplayHints <menu>]
			}
		}
		2 { return [DisplayHints <x>] }
		3 { return [DisplayHints <y>] }
		4 { return [DisplayHints ?entryIndex?] }
	}
}

# TODO: the name - value construct didn't work in my wish.
#
proc complete(tk_setPalette) {text start end line pos mod} {
	set database {
		activeBackground        foreground              selectColor
		activeForeground        highlightBackground     selectBackground
		background              highlightColor          selectForeground
		disabledForeground      insertBackground        troughColor
	}
	switch -- ${pos} {
		1 {
			return [CompleteColor ${text} ${database}]
		}
		default {
			switch [expr ${pos} % 2] {
				1 {
					return [CompleteFromList ${text} ${database}]
				}
				0 {
					return [CompleteColor ${text}]
				}
			}
		}
	}
}

proc complete(tkwait) {text start end line pos mod} {
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				variable visibility window
			}]
		}
		2 {
			switch [Lindex ${line} 1] {
				variable {
					return [VarCompletion ${text} #0]
				}
				visibility -
				window {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
			}
		}
	}
}

proc complete(toplevel) {text start end line pos mod} {
	switch -- ${pos} {
		1 { return [EventuallyInsertLeadingDot ${text} <pathName>] }
		default {
			return [CompleteWidgetConfigurations ${text} ${start} ${line} {
				-borderwidth -cursor -highlightbackground -highlightcolor
				-highlightthickness -relief -takefocus -background
				-class -colormap -container -height -menu -screen
				-use -visual -width
			}]
		}
	}
	return ""
}

proc complete(winfo) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [TrySubCmds ${text} winfo]
		}
		2 {
			switch -- ${sub} {
				atom {
					return [TryFromList ${text} {-displayof <name>}]
				}
				containing {
					return [TryFromList ${text} {-displayof <rootX>}]
				}
				interps {
					return [TryFromList ${text} -displayof]
				}
				atomname -
				pathname {
					return [TryFromList ${text} {-displayof <id>}]
				}
				default {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
			}
		}
		default {
			switch -- ${sub} {
				atom {
					switch -- [PreviousWord ${start} ${line}] {
						-displayof {
							return [TryFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default { return [DisplayHints <name>] }
					}
				}
				containing {
					switch -- [Lindex ${line} 2] {
						-displayof {
							switch -- ${pos} {
								3 {
									return [TryFromList ${text} \
									[WidgetChildren ${text}]]
								}
								4 {
									return [DisplayHints <rootX>]
								}
								5 {
									return [DisplayHints <rootY>]
								}
							}
						}
						default { return [DisplayHints <rootY>] }
					}
				}
				interps {
					switch -- [PreviousWord ${start} ${line}] {
						-displayof {
							return [TryFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default {}
					}
				}
				atomname -
				pathname {
					switch -- [PreviousWord ${start} ${line}] {
						-displayof {
							return [TryFromList ${text} \
							[WidgetChildren ${text}]]
						}
						default { return [DisplayHints <id>] }
					}
				}
				visualsavailable { return [DisplayHints ?includeids?] }
				default {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
			}
		}
	}
	return ""
}

proc complete(wm) {text start end line pos mod} {
	set sub [Lindex ${line} 1]
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				aspect client colormapwindows command deiconify focusmodel
				frame geometry grid group iconbitmap iconify iconmask iconname
				iconposition iconwindow maxsize minsize overrideredirect
				positionfrom protocol resizable sizefrom state title transient
				withdraw
			}]
		}
		2 {
			return [TryFromList ${text} [ToplevelWindows]]
		}
		3 {
			switch -- ${sub} {
				aspect { return [DisplayHints ?minNumer?] }
				client { return [DisplayHints ?name?] }
				colormapwindows {
					return [CompleteListFromList ${text} \
					[string trimleft [IncompleteListRemainder ${line}]] \
					[WidgetChildren .] \{ { } \}]
				}
				command { return [DisplayHints ?value?] }
				focusmodel {
					return [CompleteListFromList ${text} {active passive}]
				}
				geometry {
					return [DisplayHints ?<width>x<height>+-<x>+-<y>?]
				}
				grid { return [DisplayHints ?baseWidth?] }
				group {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
				iconbitmap -
				iconmask { return [CompleteFromBitmaps ${text}] }
				iconname { return [DisplayHints ?newName?] }
				iconposition { return [DisplayHints ?x?] }
				iconwindow {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
				maxsize -
				minsize { return [DisplayHints ?width?] }
				overrideredirect { return [CompleteBoolean ${text}] }
				positionfrom -
				sizefrom {
					return [CompleteFromList ${text} {position user}]
				}
				protocol {
					return [CompleteFromList ${text} {
						WM_TAKE_FOCUS WM_SAVE_YOURSELF WM_DELETE_WINDOW
					}]
				}
				resizable { return [DisplayHints ?width?] }
				title { return [DisplayHints ?string?] }
				transient {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
				default {
					return [TryFromList ${text} [ToplevelWindows]]
				}
			}
		}
		4 {
			switch -- ${sub} {
				aspect { return [DisplayHints ?minDenom?] }
				grid { return [DisplayHints ?baseHeight?] }
				iconposition { return [DisplayHints ?y?] }
				maxsize -
				minsize { return [DisplayHints ?height?] }
				protocol {
					return [BraceOrCommand ${text} \
					${start} ${end} ${line} ${pos} ${mod}]
				}
				resizable { return [DisplayHints ?height?] }
			}
		}
		5 {
			switch -- ${sub} {
				aspect { return [DisplayHints ?maxNumer?] }
				grid { return [DisplayHints ?widthInc?] }
			}
		}
		6 {
			switch -- ${sub} {
				aspect { return [DisplayHints ?maxDenom?] }
				grid { return [DisplayHints ?heightInc?] }
			}
		}
	}
	return ""
}

# ==== ObjCmd completers ==========================
#
# @note when a proc is commented out, the fallback
#       completers do the job rather well.
#
# =================================================


# proc ButtonObj {text start end line pos} {
# 	return ""
# }

proc CompleteFromBitmaps {text {always 1}} {
	set inames [image names]
	set bitmaps ""
	foreach name $inames {
		if {"bitmap" == [image type $name]} {
			lappend bitmaps ${name}
		}
	}
	if {[string length ${bitmaps}]} {
		return [CompleteFromList \
		${text} ${bitmaps}]
	} else {
		if ${always} {
			return [DisplayHints <bitmaps>]
		} else {
			return ""
		}
	}
}

proc CompleteFromImages {text {always 1}} {
	set inames [image names]
	if {[string length ${inames}]} {
		return [CompleteFromList ${text} ${inames}]
	} else {
		if ${always} {
			return [DisplayHints <image>]
		} else {
			return ""
		}
	}
}

proc CompleteAnchor text {
	return [CompleteFromList ${text} {
		n ne e se s sw w nw center
	}]
}

proc CompleteJustify text {
	return [CompleteFromList ${text} {
		left center right
	}]
}

proc CanvasItem {text start end line pos prev type} {

	switch -- ${type} {
		arc {
			switch -- ${prev} {
				-extent { return [DisplayHints <degrees>] }
				-fill -
				-outline { return [DisplayHints <color>] }
				-outlinestipple -
				-stipple {
					set inames [image names]
					set bitmaps ""
					foreach name $inames {
						if {"bitmap" == [image type $name]} {
							lappend bitmaps ${name}
						}
					}
					if {[string length ${bitmaps}]} {
						return [CompleteFromList \
						${text} ${bitmaps}]
					} else {
						return [DisplayHints <bitmaps>]
					}
				}
				-start { return [DisplayHints <degrees>] }
				-style { return [DisplayHints <type>] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <outlineWidth>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-extent -fill -outline -outlinestipple
						-start -stipple -style -tags -width
					}]]
				}
			}
		}
		bitmap {
			switch -- ${prev} {
				-anchor { return [CompleteAnchor ${text}] }
				-background -
				-foreground { return [DisplayHints <color>] }
				-bitmap { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-anchor -background -bitmap
						-foreground -tags
					}]]
				}
			}
		}
		image {
			switch -- ${prev} {
				-anchor { return [CompleteAnchor ${text}] }
				-image { return [CompleteFromImages ${text}] }
				-tags { return [DisplayHints <tagList>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-anchor -image -tags
					}]]
				}
			}
		}
		line {
			switch -- ${prev} {
				-arrow {
					return [CompleteFromList ${text} {
						none first last both
					}]
				}
				-arrowshape { return [DisplayHints <shape>] }
				-capstyle {
					return [CompleteFromList ${text} {
						butt projecting round
					}]
				}
				-fill { return [DisplayHints <color>] }
				-joinstyle {
					return [CompleteFromList ${text} {
						bevel miter round
					}]
				}
				-smooth { return [CompleteBoolean ${text}] }
				-splinesteps { return [DisplayHints <number>] }
				-stipple { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <lineWidth>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-arrow -arrowshape -capstyle -fill -joinstyle
						-smooth -splinesteps -stipple -tags -width
					}]]
				}
			}
		}
		oval {
			switch -- ${prev} {
				-fill -
				-outline { return [DisplayHints <color>] }
				-stipple { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <lineWidth>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-fill -outline -stipple -tags -width
					}]]
				}
			}
		}
		polygon {
			switch -- ${prev} {
				-fill -
				-outline { return [DisplayHints <color>] }
				-smooth { return [CompleteBoolean ${text}] }
				-splinesteps { return [DisplayHints <number>] }
				-stipple { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <outlineWidth>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-fill -outline -smooth -splinesteps
						-stipple -tags -width
					}]]
				}
			}
		}
		rectangle {
			switch -- ${prev} {
				-fill -
				-outline { return [DisplayHints <color>] }
				-stipple { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <lineWidth>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-fill -outline -stipple -tags -width
					}]]
				}
			}
		}
		text {
			switch -- ${prev} {
				-anchor { return [CompleteAnchor ${text}] }
				-fill { return [DisplayHints <color>] }
				-font { return [DisplayHints <font>] }
				-justify { return [CompleteJustify ${text}] }
				-stipple { return [CompleteFromBitmaps ${text}] }
				-tags { return [DisplayHints <tagList>] }
				-text { return [DisplayHints <string>] }
				-width { return [DisplayHints <lineLength>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-anchor -fill -font -justify
						-stipple -tags -text -width
					}]]
				}
			}
		}
		window {
			switch -- ${prev} {
				-anchor { return [CompleteAnchor ${text}] }
				-height { return [DisplayHints <pixels>] }
				-tags { return [DisplayHints <tagList>] }
				-width { return [DisplayHints <lineWidth>] }
				-window {
					return [TryFromList ${text} [WidgetChildren ${text}]]
				}
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-anchor -height -tags -width -window
					}]]
				}
			}
		}
	}
}

#**
# WidgetXviewYview
# 
# @param    text  -- the word to complete.
# @param    line  -- the line gathered so far.
# @param    pos   -- the current word position.
# @param    prev  -- the previous word.
# @return   a std tclreadline formatted completer string.
# @sa       CanvasObj, EntryObj
# @date     Sep-18-1999
#
proc WidgetXviewYview {text line pos prev} {
	switch -- ${pos} {
		2 { return [CompleteFromList ${text} {<index> moveto scroll}] }
		3 {
			switch -- ${prev} {
				moveto { return [DisplayHints <fraction>] }
				scroll { return [DisplayHints <number>] }
			}
		}
		4 {
			set subcmd [Lindex ${line} 2]
			switch -- ${subcmd} {
				scroll { return [DisplayHints <what>] }
			}
		}
	}
}

#**
# WidgetScan
# 
# @param    text  -- the word to complete.
# @param    pos   -- the current word position.
# @return   a std tclreadline formatted completer string.
# @sa       CanvasObj, EntryObj
# @date     Sep-18-1999
#
proc WidgetScan {text pos} {
	switch -- ${pos} {
		2 { return [CompleteFromList ${text} {mark dragto}] }
		3 { return [DisplayHints <x>] }
		4 { return [DisplayHints <y>] }
	}
}

proc CanvasObj {text start end line pos} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	if {1 == $pos} {
		return [TrySubCmds ${text} [Lindex ${line} 0]]
	}
	switch -- ${sub} {
		addtag {
			switch -- ${pos} {
				2 { return [DisplayHints <tag>] }
				3 {
					return [CompleteFromList ${text} {
						above all below closest enclosed
						overlapping withtag
					}]
				}
				default {
					set search [Lindex ${line} 3]
					switch -- ${search} {
						all {}
						above -
						withtag -
						below { return [DisplayHints <tagOrId>] }
						closest {
							switch -- ${pos} {
								4 { return [DisplayHints <x>] }
								5 { return [DisplayHints <y>] }
								6 { return [DisplayHints ?halo?] }
								7 { return [DisplayHints ?start?] }
							}
						}
						enclosed -
						overlapping {
							switch -- ${pos} {
								4 { return [DisplayHints <x1>] }
								5 { return [DisplayHints <y1>] }
								6 { return [DisplayHints <x2>] }
								7 { return [DisplayHints <y2>] }
							}
						}
					}
				}
			}
		}
		bbox {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				default { return [DisplayHints ?tagOrId?] }
			}
		}
		bind {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 {
					set fulltext [Lindex ${line} 3]
					return [CompleteSequence ${text} ${fulltext}]
					# return [DisplayHints ?sequence?]
				}
				default {
					return [BraceOrCommand ${text} \
					${start} ${end} ${line} ${pos} ${text}]
				}
			}
		}
		canvasx {
			switch -- ${pos} {
				2 { return [DisplayHints <screenx>] }
				3 { return [DisplayHints ?gridspacing?] }
			}
		}
		canvasy {
			switch -- ${pos} {
				2 { return [DisplayHints <screeny>] }
				3 { return [DisplayHints ?gridspacing?] }
			}
		}
		coords {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				default {
					switch [expr ${pos} % 2] {
						1 { return [DisplayHints ?x?] }
						0 { return [DisplayHints ?y?] }
					}
				}
			}
		}
		dchars {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints <first>] }
				4 { return [DisplayHints ?last?] }
			}
		}
		delete { return [DisplayHints ?tagOrId?] }
		dtag {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints ?tagToDelete?] }
			}
		}
		find {
			switch -- ${pos} {
				2 {
					return [TrySubCmds ${text} [Lrange ${line} 0 1]]
				}
				default { return [DisplayHints ?arg?] }
			}
		}
		focus {
			switch -- ${pos} {
				2 { return [DisplayHints ?tagOrId?] }
			}
		}
		gettags {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
			}
		}
		icursor -
		index {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints <index>] }
			}
		}
		insert {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints <beforeThis>] }
				4 { return [DisplayHints <string>] }
			}
		}
		lower {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints ?belowThis?] }
			}
		}
		move {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints <xAmount>] }
				4 { return [DisplayHints <yAmount>] }
			}
		}
		postscript {
			switch -- ${prev} {
				-file { return "" }
				-colormap -
				-colormode -
				-fontmap -
				-height -
				-pageanchor -
				-pageheight -
				-pagewidth -
				-pagex -
				-pagey -
				-rotate -
				-width -
				-x -
				-y { return [DisplayHints <[String range ${prev} 1 end]>] }
				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-colormap -colormode -file -fontmap -height
						-pageanchor -pageheight -pagewidth -pagex
						-pagey -rotate -width -x -y
					}]]
				}
			}
		}
		raise {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints ?aboveThis?] }
			}
		}
		scale {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				3 { return [DisplayHints <xOrigin>] }
				4 { return [DisplayHints <yOrigin>] }
				5 { return [DisplayHints <xScale>] }
				6 { return [DisplayHints <yScale>] }
			}
		}
		scan { return [WidgetScan ${text} ${pos}] }
		select {
			switch -- ${pos} {
				2 {
					return [CompleteFromList ${text} {
						adjust clear item from to
					}]
				}
				3 {
					set sub [Lindex ${line} 2]
					switch -- ${sub} {
						adjust -
						from -
						to { return [DisplayHints <tagOrId>] }
					}
				}
				4 {
					set sub [Lindex ${line} 2]
					switch -- ${sub} {
						adjust -
						from -
						to { return [DisplayHints <index>] }
					}
				}
			}
		}
		xview -
		yview { return [XviewYview ${text} ${line} ${pos} ${prev}] }
		create {
			switch -- ${pos} {
				2 {
					return [CompleteFromList ${text} {
						arc bitmap image line oval
						polygon rectangle text window
					}]
				}
				3 { return [DisplayHints <x1>] }
				4 { return [DisplayHints <y1>] }
				5 {
					set type [Lindex ${line} 2]
					switch -- ${type} {
						arc -
						oval -
						rectangle { return [DisplayHints <x2>] }
						# TODO items with more than 4 coordinates
						default {
							return [CanvasItem ${text} ${start} \
							${end} ${line} ${pos} ${prev} ${type}]
						}
					}
				}
				6 {
					set type [Lindex ${line} 2]
					switch -- ${type} {
						arc -
						oval -
						rectangle { return [DisplayHints <y2>] }
						# TODO items with more than 4 coordinates
						default {
							return [CanvasItem ${text} ${start} \
							${end} ${line} ${pos} ${prev} ${type}]
						}
					}
				}
				default {
					set type [Lindex ${line} 2]
					# TODO items with more than 4 coordinates
					return [CanvasItem ${text} ${start} \
					${end} ${line} ${pos} ${prev} ${type}]
				}
			}
		}
		itemconfigure -
		itemcget {
			switch -- ${pos} {
				2 { return [DisplayHints <tagOrId>] }
				default {

					set id [Lindex ${line} 2]
					set type [[Lindex ${line} 0] type ${id}]
					if {![string length ${type}]} {
						return ""; # no such element
					}

					return [CanvasItem ${text} ${start} \
					${end} ${line} ${pos} ${prev} ${type}]
				}
			}
		}
	}
	return ""
}

proc EntryIndex text {
	return [CompleteFromList ${text} {
		<number> <@number> anchor end sel.first sel.last
	}]
}

proc EntryObj {text start end line pos} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	if {1 == $pos} {
		return [TrySubCmds ${text} [Lindex ${line} 0]]
	}
	switch -- ${sub} {
		bbox -
		icursor -
		index { return [EntryIndex ${text}] }
		cget {}
		configure {}
		get {}
		insert {
			switch -- ${pos} {
				2 { return [EntryIndex ${text}] }
				3 { return [DisplayHints <string>] }
			}
		}
		scan { return [WidgetScan ${text} ${pos}] }
		selection {
			switch -- ${pos} {
				2 {
					return [TrySubCmds ${text} [Lrange ${line} 0 1]]
				}
				3 {
					switch -- ${prev} {
						adjust -
						from -
						to { return [EntryIndex ${text}] }
						clear -
						present {}
						range { return [DisplayHints <start>] }
					}
				}
				4 {
					switch -- [Lindex ${line} 2] {
						range { return [DisplayHints <end>] }
					}
				}
			}
		}
		xview -
		yview { return [WidgetXviewYview ${text} ${line} ${pos} ${prev}] }
	}
	return ""
}

# proc CheckbuttonObj {text start end line pos} {
# the fallback routines do the job pretty well.
# }

# proc FrameObj {text start end line pos} {
# the fallback routines do the job pretty well.
# }

# proc LabelObj {text start end line pos} {
# the fallback routines do the job pretty well.
# }

proc ListboxObj {text start end line pos} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	if {1 == $pos} {
		return [TrySubCmds ${text} [Lindex ${line} 0]]
	}
	switch -- ${sub} {
		activate -
		bbox -
		index -
		see {
			switch -- ${pos} {
				2 {
					return [DisplayHints <index>]
				}
			}
		}
		insert {
			switch -- ${pos} {
				2 {
					return [DisplayHints <index>]
				}
				default {
					return [DisplayHints ?element?]
				}
			}
		}
		cget {}
		configure {}
		curselection {}
		delete -
		get {
			switch -- ${pos} {
				2 {
					return [DisplayHints <first>]
				}
				3 {
					return [DisplayHints ?last?]
				}
			}
		}
		nearest {
			switch -- ${pos} {
				2 {
					return [DisplayHints <y>]
				}
			}
		}
		size {}     

		scan { return [WidgetScan ${text} ${pos}] }

		xview -
		yview { return [WidgetXviewYview ${text} ${line} ${pos} ${prev}] }

		selection {
			switch -- ${pos} {
				2 {
					return [CompleteFromList ${text} {
						anchor clear includes set
					}]
				}
				3 {
					switch -- ${prev} {
						anchor -
						includes {
							return [CompleteFromList ${text} {
								active anchor end @x @y <number>
							}]
						}
						clear -
						set { return [DisplayHints <first>] }
					}
				}
				4 {
					switch -- [Lindex ${line} 2] {
						clear -
						set { return [DisplayHints ?last?] }
					}
				}
			}
		}
	}
}

proc MenuIndex text {
	return [CompleteFromList ${text} {
		<number> active end last none <@number> <labelPattern>
	}]
}

proc MenuItem {text start end line pos virtualpos} {
	switch -- ${virtualpos} {
		2 {
			return [CompleteFromList ${text} {
				cascade checkbutton command radiobutton separator
			}]
		}
		default {
			switch -- [PreviousWord ${start} ${line}] {
				-activebackground -
				-activeforeground -
				-background -
				-foreground -
				-selectcolor {
					return [DisplayHints <color>]
				}

				-accelerator { return [DisplayHints <accel>] }
				-bitmap { return [CompleteFromBitmaps ${text}] }

				-columnbreak -
				-hidemargin -
				-indicatoron {
					return [CompleteBoolean ${text}]
				}
				-command {
					return [BraceOrCommand ${text} \
					${start} ${end} ${line} ${pos} ${text}]
				}
				-font {
					set names [font names]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <fontname>]
					}
				}
				-image -
				-selectimage { return [CompleteFromImages ${text}] }

				-label { return [DisplayHints <label>] }
				-menu {
					set names [WidgetChildren [Lindex ${line} 0]]
					if {[string length ${names}]} {
						return [CompleteFromList ${text} ${names}]
					} else {
						return [DisplayHints <menu>]
					}
				}

				-offvalue -
				-onvalue { return [DisplayHints <value>] }

				-state {
					return [CompleteFromList ${text} {
						normal active disabled
					}]
				}
				-underline { return [DisplayHints <integer>] }
				-value { return [DisplayHints <value>] }
				-variable {
					return [VarCompletion ${text} #0]
				}

				default {
					return [CompleteFromList ${text} \
					[RemoveUsedOptions ${line} {
						-activebackground -activeforeground
						-accelerator -background -bitmap -columnbreak
						-command -font -foreground -hidemargin -image
						-indicatoron -label -menu -offvalue -onvalue
						-selectcolor -selectimage -state -underline
						-value -variable
					}]]
				}
			}
		}
	}
}

proc MenuObj {text start end line pos} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	if {1 == $pos} {
		return [TrySubCmds ${text} [Lindex ${line} 0]]
	}
	switch -- ${sub} {
		activate -
		index -
		invoke -
		postcascade -
		type -
		yposition {
			switch -- ${pos} {
				2 {
					return [MenuIndex ${text}]
				}
			}
		}
		configure {}
		cget {}

		add {
			return [MenuItem ${text} ${start} ${end} ${line} ${pos} ${pos}]
		}
		clone {
			switch -- ${pos} {
				2 { return [DisplayHints <newPathname>] }
				3 {
					return [CompleteFromList ${text} {
						normal menubar tearoff
					}]
				}
			}
		}
		delete {
			switch -- ${pos} {
				2 -
				3 { return [MenuIndex ${text}] }
			}
		}
		insert {
			switch -- ${pos} {
				2 { return [MenuIndex ${text}] }
				default {
					return [MenuItem ${text} ${start} ${end} \
					${line} ${pos} [expr ${pos} - 1]]
				}
			}
		}
		entrycget -
		entryconfigure {
			switch -- ${pos} {
				2 { return [MenuIndex ${text}] }
				default {
					return [MenuItem ${text} ${start} \
					${end} ${line} ${pos} ${pos}]
				}
			}
		}
		post {
			switch -- ${pos} {
				2 { return [DisplayHints <x>] }
				3 { return [DisplayHints <y>] }
			}
		}
		# ??? XXX
		unpost {}
	}
}

proc PhotoObj {text start end line pos} {
	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]
	set copy_opts { -from -to -shrink -zoom -subsample }
	set read_opts { -from -to -shrink -format }
	set write_opts { -from -format }
	switch -- ${pos} {
		1 {
			return [CompleteFromList ${text} {
				blank cget configure copy get put read redither write  
			}]
		}
		2 {
			switch -- ${sub} {
				blank {}
				cget {}
				configure {}
				redither {}
				copy { return [CompleteFromImages ${text}] }
				get { return [DisplayHints <x>] }
				put { return [DisplayHints <data>] }
				read {}
				write {}
			}
		}
		3 {
			switch -- ${sub} {
				blank {}
				cget {}
				configure {}
				redither {}
				copy { return [CompleteFromList ${text} ${copy_opts}] }
				get { return [DisplayHints <y>] }
				put { return [CompleteFromList ${text} -to] }
				read { return [CompleteFromList ${text} ${read_opts}] }
				write { return [CompleteFromList ${text} ${write_opts}] }
			}
		}
		default {
			switch -- ${sub} {
				blank {}
				cget {}
				configure {}
				redither {}
				get {}
				copy {
					switch -- ${prev} {
						-from -
						-to { return [DisplayHints [list <x1 y1 x2 y2>]] }
						-zoom -
						-subsample { return [DisplayHints [list <x y>]] }
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} ${copy_opts}]]
						}
					}
				}
				put {
					switch -- ${prev} {
						-to {
							return [DisplayHints [list <x1 y1 x2 y2>]]
						}
					}
				}
				read {
					switch -- ${prev} {
						-from { return [DisplayHints [list <x1 y1 x2 y2>]] }
						-to { return [DisplayHints [list <x y>]] }
						-format { return [DisplayHints <formatName>] }
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} ${read_opts}]]
						}
					}
				}
				write {
					switch -- ${prev} {
						-from { return [DisplayHints [list <x1 y1 x2 y2>]] }
						-format { return [DisplayHints <formatName>] }
						default {
							return [CompleteFromList ${text} \
							[RemoveUsedOptions ${line} ${write_opts}]]
						}
					}
				}
			}
		}
	}
}

# proc RadiobuttonObj {text start end line pos} {
# the fallback routines do the job pretty well.
# }

proc ScaleObj {text start end line pos} {

	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]

	switch -- ${pos} {
		1 {
			return [TrySubCmds ${text} [Lindex ${line} 0]]
		}
		2 {
			switch -- ${sub} {
				coords { return [DisplayHints ?value?] }
				get { return [DisplayHints ?x?] }
				identify { return [DisplayHints <x>] }
				set { return [DisplayHints <value>] }
			}
		}
		3 {
			switch -- ${sub} {
				get { return [DisplayHints ?y?] }
				identify { return [DisplayHints <y>] }
			}
		}
	}
}

proc ScrollbarObj {text start end line pos} {

	set sub [Lindex ${line} 1]
	set prev [PreviousWord ${start} ${line}]

	# note that the `prefix moveto|scroll'
	# construct is hard to complete.
	#
	switch -- ${pos} {
		1 {
			return [TrySubCmds ${text} [Lindex ${line} 0]]
		}
		2 {
			switch -- ${sub} {
				activate {
					return [CompleteFromList ${text} {
						arrow1 slider arrow2
					}]
				}

				fraction -
				identify { return [DisplayHints <x>] }
				delta { return [DisplayHints <deltaX>] }
				set { return [DisplayHints <first>] }
			}
		}
		3 {
			switch -- ${sub} {

				fraction -
				identify { return [DisplayHints <y>] }
				delta { return [DisplayHints <deltaY>] }
				set { return [DisplayHints <last>] }
			}
		}
	}
}

proc TextObj {text start end line pos} {
	# TODO ...
	return [CompleteFromOptionsOrSubCmds \
	${text} ${start} ${end} ${line} ${pos}]
}

}; # namespace tclreadline
