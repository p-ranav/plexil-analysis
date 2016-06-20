# A simple unrobust Makefile for compiling the PLEXIL plans.

PLE = Fly.ple AdjustForLostComm.ple AdjustAltitudeForLostComm.ple \
          AdjustRouteForLostComm.ple Clock.ple 

XML = $(PLE:%.ple=%.plx)

%.plx: %.ple
	${PLEXIL_HOME}/scripts/plexilc $<

default: plans

plans: $(XML) 

clean:
	@ rm -f $(XML)
