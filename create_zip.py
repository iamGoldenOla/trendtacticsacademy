import shutil
import os

source_dir = os.path.join(os.getcwd(), 'lms-frontend', 'build')
output_filename = os.path.join(os.getcwd(), 'TRENDTACTICS_FINAL_PATCHED')

print(f"Zipping {source_dir} to {output_filename}.zip...")
try:
    shutil.make_archive(output_filename, 'zip', source_dir)
    print("Zip created successfully.")
except Exception as e:
    print(f"Error creating zip: {e}")
