from PIL import Image

# Open the image
image_path = "X:\\Projects\\intern_assign\\editor\\assets\\images\\square.png"
image = Image.open(image_path)

# Ensure the image is in RGBA mode (with alpha channel)
image = image.convert("RGBA")

# Iterate over each pixel
for i in range(image.width):
    for j in range(image.height):
        # Check if the current pixel is completely transparent
        if image.getpixel((i, j)) == (0, 0, 0, 0):
            # Make it completely opaque (white)
            image.putpixel((i, j), (255, 255, 255, 255))
        else:
            # Make it completely transparent (black)
            image.putpixel((i, j), (0, 0, 0, 0))

# Save the modified image
image.save("X:\\Projects\\intern_assign\\editor\\assets\\images\\s.png")
