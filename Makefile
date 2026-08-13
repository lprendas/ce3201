SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES = $(wildcard $(CURDIR)/src/*.sv)
TOPLEVEL ?= adder
MODULE ?= test_adder

export PYTHONPATH := $(CURDIR)/tests:$(PYTHONPATH)

include $(shell cocotb-config --makefiles)/Makefile.sim
