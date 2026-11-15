import os

lib_dir = 'lib'
files_info = []
for root, _, files in os.walk(lib_dir):
    for f in files:
        if f.endswith('.dart'):
            path = os.path.join(root, f)
            with open(path, 'r', encoding='utf-8') as fp:
                lines = fp.readlines()
            line_count = len(lines)
            classes = [l.strip().split()[1].split('<')[0] for l in lines if l.strip().startswith('class ')]
            files_info.append((line_count, path.replace('\\', '/'), classes))

files_info.sort(key=lambda x: x[0], reverse=True)
print(f"Total files: {len(files_info)}, Total lines: {sum(x[0] for x in files_info)}")
print("-" * 90)
for count, path, classes in files_info:
    c_str = ", ".join(classes)
    print(f"{count:4d} | {path:65s} | {c_str}")
