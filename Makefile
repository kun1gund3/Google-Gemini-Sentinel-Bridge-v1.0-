CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra
SRC_DIR = src
BUILD_DIR = build
TARGET = $(BUILD_DIR)/sentinel_daemon

all: $(TARGET)

$(TARGET): $(SRC_DIR)/sentinel_daemon.cpp
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@ -lpthread

gpush:
	git add .
	git commit -m "feat: v1.3 - Sentinel-Daemon implementiert" || true
	git push origin main || echo "Push failed: Auth required."

clean:
	rm -rf $(BUILD_DIR)
