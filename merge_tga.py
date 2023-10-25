from PIL import Image
import argparse


def combine_targa(a, b, mask, output):
    # mask = 255 means take from B, mask = 0 means take from A
    # rewrite the following function using PIL
    img_A = Image.open(a).convert("RGBA")
    img_B = Image.open(b).convert("RGBA")
    mask_c = Image.open(mask).convert("L")
    print(f"Combining {a} and {b} with mask {mask} into {output}")
    print(f"Sizes Image A: {img_A.size} Image B: {img_B.size} Mask: {mask_c.size}")

    result = Image.composite(img_B, img_A, mask_c)
    result.save(output)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Initialize a new mod")
    parser.add_argument("imga", help="Image A .tga file")
    parser.add_argument("imgb", help="Image B .tga file")
    parser.add_argument("mask", help="Greyscale mask image")
    parser.add_argument("--output", default="combined.tga", help="Output file name")
    args = parser.parse_args()
    combine_targa(args.imga, args.imgb, args.mask, args.output)
