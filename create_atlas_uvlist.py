import argparse
import os
import pickle

def generate_uv_list(pixels, rows, cols):
    ret = [
        """
    <region id="IconUVList">
        <node id="root">
           <children>"""
    ]
    # need to consider a 1 pixel wide padding between icons
    padding = 1 / pixels
    for r in range(rows):
        for c in range(cols):
            ret.append(f"""
				<node id="IconUV"> <!-- row {r} col {c} -->
                    <attribute id="MapKey" type="FixedString" value=""/>
                    <attribute id="U1" type="float" value="{c/cols + padding}"/>
                    <attribute id="U2" type="float" value="{(c+1)/cols - padding}"/>	   
                    <attribute id="V1" type="float" value="{r/rows + padding}"/>
                    <attribute id="V2" type="float" value="{(r+1)/rows - padding}"/>	    
                </node>""")

    ret.append("""
		   </children>
        </node>
    </region>""")

    # replace any multiple consecutive newlines with a single newline
    ret = [s.replace("\n+", "\n") for s in ret]

    return "".join(ret)

if __name__ == "__main__":
    # parse arguments with argparse
    parser = argparse.ArgumentParser(description="Create the IconUVList region for icon atlases")
    parser.add_argument("pixels", type=int, help="Number of pixels / width assuming square icons")
    parser.add_argument("rows", type=int, help="Number of rows of icons in the atlas")
    parser.add_argument("cols", type=int, help="Number of cols of icons in the atlas")
    parser.add_argument("-o", "--output_file", type=str, default="", help="Output file name, leave blank to just output to console")

    args = parser.parse_args()

    output = generate_uv_list(args.pixels, args.rows, args.cols)
    print(output)
    if args.output_file != "":
        with open(args.output_file, "w") as f:
            f.writelines(output)

