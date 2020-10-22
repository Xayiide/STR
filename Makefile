#-----------------------------------------------------------------------------
#                               EXAMPLES  Makefile
#-----------------------------------------------------------------------------

# the Main program
MAIN = main

# the gnatmake
GNATMAKE = sparc-ork-gnatmake

# the size binutil
SIZE = sparc-ork-size

# the nm binutil
NM = sparc-ork-nm

# Gnat1 compilation flags
GF = -g
# Do not use optimization for debugging
#GF = -O2

# Gnatbind flags
BF =

# Gnatlink flags
LF = -k -specs ork_specs -mcpu=cypress
# Use the following to obtain a diagnostic link file
LF_LINK_FILE = -Xlinker -Map -Xlinker $(MAIN).map

#-----------------------------------------------------------------------------
# Main rule

all :   $(MAIN).adb
	$(GNATMAKE) $(MAIN) -cargs $(GF) -bargs $(BF) -largs $(LF) $(LF_LINK_FILE)
	$(NM) $(MAIN) > $(MAIN).nm
	$(SIZE) $(MAIN)
	rm *.o *.ali *.nm *.map

clean : force
	@/bin/rm -f *.o *.nm *.ali b~*.* *.s *~ $(MAIN) *.map

force :

