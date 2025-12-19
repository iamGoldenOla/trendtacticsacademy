# Python script to count unique UUIDs in the SQL file
import re

# Read the SQL file
with open('insert-vibe-coding-course.sql', 'r') as file:
    content = file.read()

# Extract all UUIDs using regex
uuid_pattern = r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
uuids = re.findall(uuid_pattern, content)

print(f"Total UUIDs found: {len(uuids)}")

# Separate primary keys (being defined) from foreign keys (being referenced)
# Primary keys appear in the VALUES clause for INSERT statements
primary_keys = []

# Look for INSERT statements and extract the first UUID in each VALUES clause
insert_pattern = r'INSERT INTO \w+\s*\([^)]*\)\s*VALUES\s*\(\s*\'([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})\''
primary_key_matches = re.findall(insert_pattern, content)

print(f"Primary keys found: {len(primary_key_matches)}")

# Check for duplicates in primary keys
unique_primary_keys = set()
duplicates = []

for uuid in primary_key_matches:
    if uuid in unique_primary_keys:
        duplicates.append(uuid)
    else:
        unique_primary_keys.add(uuid)

if duplicates:
    print("❌ Duplicate primary keys found:")
    for dup in duplicates:
        print(f"  {dup}")
else:
    print("✅ All primary keys are unique!")
    print(f"Unique primary keys: {len(unique_primary_keys)}")

# Print summary
print("\nSummary:")
print(f"  Total UUIDs in file: {len(uuids)}")
print(f"  Unique primary keys: {len(unique_primary_keys)}")
print(f"  Expected entities: 21 (1 course + 5 modules + 15 lessons)")