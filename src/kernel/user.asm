.ORIG	x3000
INFINITE_LOOP   ADD	R0,	R0,	0 ; this should fail
                BRnzp	INFINITE_LOOP
.END