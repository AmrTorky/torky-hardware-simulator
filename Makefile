CXX ?= g++
CXXFLAGS = -O3 -std=c++20 -march=native -Wall -Wextra -Iinclude -pthread

TARGET = build/torky-hardware-simulator
SIM_BIN = build/hardware_cycle_sim

all: $(TARGET) $(SIM_BIN)

$(TARGET): src/torky_cli_kernel.cpp include/torky_continuum_core.hpp
	@mkdir -p build
	$(CXX) $(CXXFLAGS) src/torky_cli_kernel.cpp -o $(TARGET)

$(SIM_BIN): src/sim/hardware_cycle_sim.cpp include/torky_continuum_core.hpp
	@mkdir -p build
	$(CXX) $(CXXFLAGS) src/sim/hardware_cycle_sim.cpp -o $(SIM_BIN)

test: all
	./$(TARGET)
	./$(SIM_BIN)
	python3 tests/test_sim_registers.py
	./run_audit.sh

clean:
	rm -rf build local_verification_certificate.json
