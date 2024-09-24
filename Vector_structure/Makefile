CXX := g++
CXXFLAGS := -std=c++20 -Wall -Wextra -O2
LDFLAGS :=

SRC_DIR := src
LIB_DIR := lib
INC_DIR := include
BUILD_DIR := build

SRCS := $(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(LIB_DIR)/src/*.cpp)
LIBS := $(wildcard $(LIB_DIR)/include/*.h)
OBJS := $(patsubst %.cpp, $(BUILD_DIR)/%.o, $(notdir $(SRCS)))

TARGET := $(BUILD_DIR)/vector_structure

.PHONY: all clean help run

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) -I$(INC_DIR) -L$(LIB_DIR)/lib

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(INC_DIR) -I$(LIB_DIR)/include

$(BUILD_DIR)/%.o: $(LIB_DIR)/src/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I$(INC_DIR) -I$(LIB_DIR)/include

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
	@echo "  make clean   # Remove build artifacts"
	@echo "  make help    # Show this help message"
	@echo ""
	@echo "Current settings:"
	@echo "  CXX        = $(CXX)"
	@echo "  CXXFLAGS   = $(CXXFLAGS)"

print-%:
	@echo $* = $($*)
