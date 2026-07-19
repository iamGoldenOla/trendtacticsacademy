import json

with open('C:/Users/Akinola Olujobi/.gemini/antigravity/brain/24a26cdb-ac7d-4c1d-bf20-857400faa4e8/scratch/prompt_engineering_lessons.json', 'r', encoding='utf-8') as f:
    lessons = json.load(f)

print(f"Total lessons: {len(lessons)}")
modules = {}
for i, l in enumerate(lessons):
    m = l.get('module', 'Unknown')
    if m not in modules:
        modules[m] = []
    modules[m].append((i, l.get('title')))

for m, titles in modules.items():
    print(f"\nModule: {m} ({len(titles)} lessons)")
    for idx, t in titles:
        print(f"  {idx}: {t}")
