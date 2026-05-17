import tensorflow as tf
import os

def check_tflite_npu_delegate():
    print("Checking for TFLite NPU Delegate compatibility...")
    
    # Path where NPU delegates usually reside on Android
    npu_lib = "/vendor/lib64/libNpuDelegate.so"
    
    if os.path.exists(npu_lib):
        print(f"NPU Delegate library found at: {npu_lib}")
        try:
            # Attempt to load the delegate (this might fail if not properly linked, but is a good test)
            delegate = tf.lite.load_delegate(npu_lib)
            print("Successfully loaded NPU Delegate.")
            return True
        except Exception as e:
            print(f"Failed to load NPU Delegate: {e}")
            return False
    else:
        print(f"NPU Delegate library NOT found at: {npu_lib}")
        return False

if __name__ == "__main__":
    check_tflite_npu_delegate()
