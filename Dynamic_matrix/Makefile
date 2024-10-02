CXX := g++

CXXFLAGS := -std=c++20 -Wall -Wextra -O2

SRC_DIR := src
INC_DIR := include
BUILD_DIR := build

SRCS := $(wildcard $(SRC_DIR)/*.cpp) main.cpp
OBJS := $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(notdir $(SRCS)))

TARGET := $(BUILD_DIR)/dynamic_matrix

.PHONY: all clean help run

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ -I$(INC_DIR)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(INC_DIR)

$(BUILD_DIR)/main.o: main.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(INC_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

run: $(TARGET)
	@$(TARGET) ${ARGS}

help:
	@echo "Usage:"
	@echo "  make         # Build the project"
	@echo "  make run     # Build and run the project"
	@echo "  make clean   # Remove build artifacts and temporary files"
	@echo "  make help    # Show this help message"
	@echo ""
	@echo "Current settings:"
	@echo "  CXX        = $(CXX)"
	@echo "  CXXFLAGS   = $(CXXFLAGS)"

print-%:
	@echo $* = $($*)
