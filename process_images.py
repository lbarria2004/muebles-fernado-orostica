import os
import shutil

source_dir = r"c:\Users\56951\Downloads\fotos cocina\fotos_originales"
dest_dir = r"c:\Users\56951\Downloads\fotos cocina\site\assets\img\gallery"
html_output_path = r"c:\Users\56951\Downloads\fotos cocina\site\gallery_items.html"

# Create specific gallery folder to keep things tidy
os.makedirs(dest_dir, exist_ok=True)

# Allowed extensions
valid_extensions = {".jpg", ".jpeg", ".png", ".webp"}

html_parts = []

# List all files
files = [f for f in os.listdir(source_dir) if os.path.isfile(os.path.join(source_dir, f))]
files.sort()

count = 0
for filename in files:
    ext = os.path.splitext(filename)[1].lower()
    if ext in valid_extensions:
        count += 1
        new_filename = f"project_{count}{ext}"
        src_path = os.path.join(source_dir, filename)
        dst_path = os.path.join(dest_dir, new_filename)
        
        # Copy file
        shutil.copy2(src_path, dst_path)
        
        # Generate HTML
        # Using lazy loading for performance since there are many images
        html_item = f'''
        <div class="gallery-item">
            <img src="assets/img/gallery/{new_filename}" alt="Proyecto Mueble {count}" loading="lazy">
        </div>'''
        html_parts.append(html_item)

# Write HTML snippet to file
with open(html_output_path, "w", encoding="utf-8") as f:
    f.write("\n".join(html_parts))

print(f"Processed {count} images.")
