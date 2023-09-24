import os
import argparse


class Folder:
    def __init__(self, name):
        self.name = name
        self.dir = None

    def __enter__(self):
        self.dir = os.getcwd()
        new_dir = os.path.join(self.dir, self.name)
        os.makedirs(new_dir, exist_ok=True)
        os.chdir(new_dir)

    def __exit__(self, exc_type, exc_value, traceback):
        os.chdir(self.dir)


class File:
    def __init__(self, name):
        self.name = name
        self._lines = []
        self.indent = 0

    def __enter__(self):
        self._lines = []
        return self

    def clear(self):
        self._lines = []

    def __exit__(self, exc_type, exc_value, traceback):
        with open(self.name, 'w') as f:
            f.writelines(self._lines)

    def add_line(self, text: str):
        self._lines.append("\t" * self.indent + text)


class XMLFile(File):
    def __enter__(self):
        ret = super().__enter__()
        self.add_line('<?xml version="1.0" encoding="utf-8"?>')
        return ret


def create_mod(args):
    name = args.name
    author = args.author
    with Folder(name):
        # only if there are models and textures
        # with Folder(f"Generated/Public/{name}"):
        with Folder("Localization/English"):
            with XMLFile(f"{name}.loca.xml") as f:
                f.add_line("""<contentList>\n</contentList>""")
        # every mod needs a meta
        with Folder(f"Mods/{name}"):
            with XMLFile("meta.lsx") as f:
                f.add_line(f"""
 <save>
  <version major="4" minor="0" revision="7" build="2" />
  <region id="Config">
    <node id="root">
        <children>
            <node id="Dependencies"/>
                <node id="ModuleInfo">
                    <attribute id="Author" type="LSWString" value="{author}"/> 
                    <attribute id="CharacterCreationLevelName" type="FixedString" value=""/>
                    <attribute id="Description" type="LSWString" value="{name}"/> 
                    <attribute id="Folder" type="LSWString" value="{name}"/> 
                    <attribute id="GMTemplate" type="FixedString" value=""/>
                    <attribute id="LobbyLevelName" type="FixedString" value=""/>
                    <attribute id="MD5" type="LSString" value=""/>
                    <attribute id="MainMenuBackgroundVideo" type="FixedString" value=""/>
                    <attribute id="MenuLevelName" type="FixedString" value=""/>
                    <attribute id="Name" type="FixedString" value="{name}"/>
                    <attribute id="NumPlayers" type="uint8" value="4"/>
                    <attribute id="PhotoBooth" type="FixedString" value=""/>
                    <attribute id="StartupLevelName" type="FixedString" value=""/>
                    <attribute id="Tags" type="LSWString" value=""/>
                    <attribute id="Type" type="FixedString" value="Add-on"/>
                    <attribute id="UUID" type="FixedString" value="GENERATE_AND_FILL"/> 
                    <attribute id="Version64" type="int64" value="36028797018963968"/>
                    <children>
                        <node id="PublishVersion">
                            <attribute id="Version64" type="int64" value="144115196665790673"/>
                        </node>
                        <node id="Scripts"/>
                        <node id="TargetModes">
                            <children>
                                <node id="Target">
                                    <attribute id="Object" type="FixedString" value="Story"/>
                                </node>
                            </children>
                        </node>
                    </children>
                </node>
            </children>
        </node>
    </region>
  </save>               
                """)

        if args.items:
            with Folder(f"Public/{name}/RootTemplates"):
                with XMLFile(f"{name}_Merged.lsf.lsx") as f:
                    f.add_line("""
    <save>
        <version major="4" minor="0" revision="6" build="5" />
        <region id="Templates">
            <node id="Templates">
                <children>        
                </children>
            </node>
        </region>
    </save>
                    """)
            # touch this file
            with Folder(f"Public/{name}/Stats/Generated"):
                with Folder("Data"):
                    with File("Armor.txt") as f:
                        f.add_line(" ")
                with File("TreasureTable.txt"):
                    f.add_line(" ")

        if args.scripts:
            with Folder(f"Mods/{name}/ScriptExtender"):
                with File("Config.json") as f:
                    f.add_line(f"""
{
                    "RequiredVersion": 1,
"ModTable": "{name}",
"FeatureFlags": ["Lua"]
}
                    """)
                with Folder("Lua"):
                    with File("BoostrapClient.lua") as f:
                        f.add_line(" ")
                    with File("BoostrapServer.lua") as f:
                        f.add_line(f"Ext.Require(\"Server/{name}.lua\")")
                    with Folder("Server"):
                        with File(f"{name}.lua") as f:
                            f.add_line(" ")
        if args.assets:
            with Folder(f"Generated/Public/{name}/Assets"):
                with File("place DDS and GR2 files here.txt") as f:
                    f.add_line(" ")
            with Folder(f"Public/{name}/Content/Assets/Characters"):
                with Folder(f"[PAK]_Armor"):
                    with File("define meshes materials and textures here.txt") as f:
                        f.add_line(" ")


def prompt_for_binary_response(message):
    while True:
        response = input(message).lower()
        if response in ["y", "yes"]:
            return True
        elif response in ["n", "no"]:
            return False
        else:
            print("Invalid response. Please enter y or n.")


if __name__ == "__main__":
    # parse arguments with argparse
    parser = argparse.ArgumentParser(description="Initialize a new mod")
    parser.add_argument("name", help="Name of the mod")
    parser.add_argument("author", help="Author of the mod")
    parser.add_argument("-q", "--quiet",
                        help="skip asking about optional creation features if they are not selected. By default each"
                             " option will prompt the user for them.",
                        action="store_true")
    parser.add_argument("-a", "--assets", action="store_true", help="Whether this mod will have custom assets such as"
                                                                    "textures and 3D models (default False)")
    parser.add_argument("-i", "--items", action="store_true", help="Whether this mod will add custom items "
                                                                   "(default False)")
    parser.add_argument("-s", "--scripts", action="store_true", help="Whether this mod will have custom scripts enabled"
                                                                     "by BG3SE (default False)")

    args = parser.parse_args()
    if args.assets:
        args.items = True
    if not args.quiet:
        if not args.assets:
            args.assets = prompt_for_binary_response("Will this mod have custom assets? (y/n) ")
            if args.assets:
                args.items = True
        if not args.items:
            args.items = prompt_for_binary_response("Will this mod have custom items? (y/n) ")
        if not args.scripts:
            args.scripts = prompt_for_binary_response("Will this mod have custom scripts? (y/n) ")
    create_mod(args)
