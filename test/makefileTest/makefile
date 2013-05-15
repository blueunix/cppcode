PATHS +=: .
PATHS +=: ../
PATHS +=: ../..

CXXFLAGS += $(subst :, -I, $(PATHS))

	
.PHONY: test

test:
	@echo  PATHS=$(PATHS)
	@echo  CXXFLAGS=$(CXXFLAGS)

