import subprocess
import os

def take_and_audit_screenshot():
    # Use a temporary file path for the screenshot
    screenshot_path = "/tmp/audit_screenshot.png"
    
    try:
        # Take screenshot
        subprocess.run(["termux-screenshot", screenshot_path], check=True)
        
        # Check if file was created and pass to sentinel_vision.sh
        if os.path.exists(screenshot_path):
            # Assumes sentinel_vision.sh is executable and in the same directory or accessible
            script_dir = os.path.dirname(os.path.abspath(__file__))
            vision_script = os.path.join(script_dir, "sentinel_vision.sh")
            
            subprocess.run([vision_script, screenshot_path], check=True)
            
            # Clean up
            os.remove(screenshot_path)
    except subprocess.CalledProcessError as e:
        print(f"Error occurred: {e}")

if __name__ == "__main__":
    take_and_audit_screenshot()
