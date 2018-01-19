BEGIN { FS=" "; print "Most Popular Browser" }
{ browser[$12]++ }
END {
    for (b in browser)
	print b, " has accessed ", browser[b], " times."
	if ( max < browser[b] ) {
	    max = browser[b];
	    maxbrowser = b;
	}
    print "Most access was from ", maxbrowser, " and ", max, " times."
}

