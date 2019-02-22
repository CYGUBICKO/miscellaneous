## Target
current: target
-include target.mk

## Makestuff setup
Sources += Makefile 
msrepo = https://github.com/dushoff
ms = makestuff
-include $(ms)/os.mk

Ignore += $(ms)
Makefile: $(ms)/Makefile
$(ms)/Makefile:
	git clone $(msrepo)/$(ms)
	ls $@

######################################################################

Sources += datasets/multi_response.csv

## subdirs += data_mgt
## Ignore += $(subdirs)

######################################################################

### Makestuff rules

-include $(ms)/git.mk
-include $(ms)/visual.mk

