### Hooks for the editor to set the default target

## https:cygubicko.github.io/projects

current: target
-include target.mk

##################################################################

# stuff

Sources += Makefile

msrepo = https://github.com/dushoff
ms = makestuff
Ignore += local.mk
-include local.mk
-include $(ms)/os.mk

# -include $(ms)/perl.def

Ignore += $(ms)
## Sources += $(ms)
Makefile: $(ms)/Makefile
	touch $@
$(ms)/Makefile:
	ls ../makestuff/Makefile && /bin/ln -s ../makestuff 

######################################################################

Sources += $(wildcard *.R *.rmd *.md)

## https://cygubicko.github.io/miscellaneous/separate_entries.html
separate_entries.html.pages: separate_entries.rmd


######################################################################

clean: 
	rm -f *Rout.*  *.Rout .*.RData .*.Rout.* .*.wrapR.* .*.Rlog *.RData *.wrapR.* *.Rlog *.rdeps *.rda .*.rdeps .*.rda

######################################################################

### Makestuff

-include $(ms)/pandoc.mk
-include $(ms)/git.mk
-include $(ms)/visual.mk
-include $(ms)/stepR.mk
