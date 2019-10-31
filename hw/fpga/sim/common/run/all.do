set runtime    "15 us"

set exitstatus 0

if { !$exitstatus } { do c }

if { !$exitstatus } { do r }

if { !$exitstatus } { do w }

if { !$exitstatus } { run $runtime }


