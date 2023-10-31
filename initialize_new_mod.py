import os
import argparse
import uuid
import pickle

saved_path_file = ".cache.pk"


# e.g. b3a212d7-e669-4f3d-aa2f-3a629d00ba01
def generate_uuid():
    return str(uuid.uuid4())


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
        mod_uuid = generate_uuid()
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
                <attribute id="UUID" type="FixedString" value="{mod_uuid}"/> 
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
        print(f"Created mod {name} with UUID {mod_uuid}")

        if args.items:
            with Folder(f"Public/{name}/RootTemplates"):
                with XMLFile(f"{name}.lsf.lsx") as f:
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
                    with File(f"{name}_Stats.txt") as f:
                        f.add_line(" ")
                with File("TreasureTable.txt"):
                    f.add_line(" ")
            # large icons
            with Folder(f"Public/Game/GUI/Assets/Tooltips"):
                with Folder("Icons"):
                    with File("large 380 DDS DXT3 icons for abilities here.txt") as f:
                        f.add_line(" ")
                with Folder("ItemIcons"):
                    with File("large 380 DDS DXT3 icons for items here.txt") as f:
                        f.add_line(" ")
            # small icons
            with Folder(f"Public/{name}/Assets/Textures/Icons"):
                with File(f"small icon tileset 256 DDS DXT3 each 64 here called {name}_Icons.dds.txt") as f:
                    f.add_line(" ")
            icon_uuid = generate_uuid()
            with Folder(f"Public/{name}/Content/UI/[PAK]_UI"):
                with XMLFile("_merged.lsf.lsx") as f:
                    f.add_line(f"""
<save>
    <version major="4" minor="0" revision="9" build="328" />
    <region id="TextureBank">
        <node id="TextureBank">
            <children>
                <node id="Resource">
                    <attribute id="ID" type="FixedString" value="{icon_uuid}" />
                    <attribute id="Localized" type="bool" value="False" />
                    <attribute id="Name" type="LSString" value="{name}_Icons" />
                    <attribute id="SRGB" type="bool" value="True" />
                    <attribute id="SourceFile" type="LSString" value="Public/{name}/Assets/Textures/Icons/{name}_Icons.dds" />
                    <attribute id="Streaming" type="bool" value="True" />
                    <attribute id="Template" type="FixedString" value="Icons_Items" />
                    <attribute id="Type" type="int64" value="0" />
                </node>
            </children>
        </node>
    </region>
</save>
                    """)
            with Folder(f"Public/{name}/GUI"):
                with XMLFile("Icons_Items.lsx") as f:
                    f.add_line(f"""
<save>
    <version major="4" minor="0" revision="9" build="328" />  This file is not converted to lsf!
    <region id="TextureAtlasInfo"> 
        <node id="root">
            <children>
                <node id="TextureAtlasIconSize">
                    <attribute id="Height" type="int64" value="64"/>
                    <attribute id="Width" type="int64" value="64"/>
                </node>
                <node id="TextureAtlasPath">
                    <attribute id="Path" type="LSString" value="Assets/Textures/Icons/{name}_Icons.dds"/>
                    <attribute id="UUID" type="FixedString" value="{icon_uuid}"/>
                </node>
                <node id="TextureAtlasTextureSize">
                    <attribute id="Height" type="int64" value="256"/>
                    <attribute id="Width" type="int64" value="256"/>
                </node>
            </children>
        </node>
    </region>
    <region id="IconUVList">
        <node id="root">
            <children>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="{name}"/> 1
                    <attribute id="U1" type="float" value="0.0"/> Left
                    <attribute id="U2" type="float" value="0.25"/> Right
                    <attribute id="V1" type="float" value="0.0"/> Top
                    <attribute id="V2" type="float" value="0.25"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="LI_"/> 2
                    <attribute id="U1" type="float" value="0.25"/> Left
                    <attribute id="U2" type="float" value="0.5"/> Right
                    <attribute id="V1" type="float" value="0.0"/> Top
                    <attribute id="V2" type="float" value="0.25"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="LI_"/> 3
                    <attribute id="U1" type="float" value="0.5"/> Left
                    <attribute id="U2" type="float" value="0.75"/> Right
                    <attribute id="V1" type="float" value="0.0"/> Top
                    <attribute id="V2" type="float" value="0.25"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="LI_"/> 4
                    <attribute id="U1" type="float" value="0.75"/> Left
                    <attribute id="U2" type="float" value="1.0"/> Right
                    <attribute id="V1" type="float" value="0.0"/> Top
                    <attribute id="V2" type="float" value="0.25"/> Bottom
                </node>

                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="LI_"/> 1
                    <attribute id="U1" type="float" value="0.0"/> Left
                    <attribute id="U2" type="float" value="0.25"/> Right
                    <attribute id="V1" type="float" value="0.25"/> Top
                    <attribute id="V2" type="float" value="0.5"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="LI_"/> 2
                    <attribute id="U1" type="float" value="0.25"/> Left
                    <attribute id="U2" type="float" value="0.5"/> Right
                    <attribute id="V1" type="float" value="0.25"/> Top
                    <attribute id="V2" type="float" value="0.5"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 3
                    <attribute id="U1" type="float" value="0.5"/> Left
                    <attribute id="U2" type="float" value="0.75"/> Right
                    <attribute id="V1" type="float" value="0.25"/> Top
                    <attribute id="V2" type="float" value="0.5"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 4
                    <attribute id="U1" type="float" value="0.75"/> Left
                    <attribute id="U2" type="float" value="1.0"/> Right
                    <attribute id="V1" type="float" value="0.25"/> Top
                    <attribute id="V2" type="float" value="0.5"/> Bottom
                </node>

                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 1
                    <attribute id="U1" type="float" value="0.0"/> Left
                    <attribute id="U2" type="float" value="0.25"/> Right
                    <attribute id="V1" type="float" value="0.5"/> Top
                    <attribute id="V2" type="float" value="0.75"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 2
                    <attribute id="U1" type="float" value="0.25"/> Left
                    <attribute id="U2" type="float" value="0.5"/> Right
                    <attribute id="V1" type="float" value="0.5"/> Top
                    <attribute id="V2" type="float" value="0.75"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 3
                    <attribute id="U1" type="float" value="0.5"/> Left
                    <attribute id="U2" type="float" value="0.75"/> Right
                    <attribute id="V1" type="float" value="0.5"/> Top
                    <attribute id="V2" type="float" value="0.75"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 4
                    <attribute id="U1" type="float" value="0.75"/> Left
                    <attribute id="U2" type="float" value="1.0"/> Right
                    <attribute id="V1" type="float" value="0.5"/> Top
                    <attribute id="V2" type="float" value="0.75"/> Bottom
                </node>

                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 1
                    <attribute id="U1" type="float" value="0.0"/> Left
                    <attribute id="U2" type="float" value="0.25"/> Right
                    <attribute id="V1" type="float" value="0.75"/> Top
                    <attribute id="V2" type="float" value="1.0"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 2
                    <attribute id="U1" type="float" value="0.25"/> Left
                    <attribute id="U2" type="float" value="0.5"/> Right
                    <attribute id="V1" type="float" value="0.75"/> Top
                    <attribute id="V2" type="float" value="1.0"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 3
                    <attribute id="U1" type="float" value="0.5"/> Left
                    <attribute id="U2" type="float" value="0.75"/> Right
                    <attribute id="V1" type="float" value="0.75"/> Top
                    <attribute id="V2" type="float" value="1.0"/> Bottom
                </node>
                <node id="IconUV">
                    <attribute id="MapKey" type="FixedString" value="DWE_"/> 4
                    <attribute id="U1" type="float" value="0.75"/> Left
                    <attribute id="U2" type="float" value="1.0"/> Right
                    <attribute id="V1" type="float" value="0.75"/> Top
                    <attribute id="V2" type="float" value="1.0"/> Bottom
                </node>
            </children>
        </node>
    </region>
</save>
                    """)

        if args.scripts:
            with Folder(f"Mods/{name}/ScriptExtender"):
                with File("Config.json") as f:
                    f.add_line(f"""
{{
    "RequiredVersion": 4,
    "ModTable": "{name}",
    "FeatureFlags": ["Lua"]
}}
                    """)
                with Folder("Lua"):
                    with File("BootstrapClient.lua") as f:
                        f.add_line(" ")
                    with File("BootstrapServer.lua") as f:
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

        if args.link:
            def generate_symlink(rel_path):
                full_rel_path = os.path.join(rel_path, name)

                path_in_data = os.path.join(args.data, full_rel_path)
                path_local = os.path.join(os.getcwd(), full_rel_path)

                # create the parent directory
                os.makedirs(os.path.dirname(path_in_data), exist_ok=True)
                os.symlink(path_local, path_in_data, target_is_directory=True)

            try:
                # create symlink to some folders to enable hot loading
                if args.assets:
                    generate_symlink("Generated/Public")
                if args.scripts:
                    generate_symlink("Mods")
                if args.items:
                    generate_symlink("Public")
                # Data\Generated\Public\GrazztRing should be linked to .\GrazztRing\Generated\Public\GrazztRing
            except OSError as e:
                print("Failed to create symlink. Please run this script with administrator privileges.")
                print(e)


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
    parser.add_argument("-l", "--link", action="store_true",
                        help="Whether to create a symlink to the mod to allow hot-loading (fast update of mod without restarting game, just needs to save or load)")
    parser.add_argument("-d", "--data",
                        help="Path to the BG3 data folder (default C:\Program Files (x86)\Steam\steamapps\common\Baldurs Gate 3\Data)",
                        default="")

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
        if not args.link:
            args.link = prompt_for_binary_response("Do you want to enable hot-loading to update mod without restarting game, just needs to save or load? (y/n) ")
    if args.link:
        if args.data == "":
            # see if the data path is cached
            if os.path.exists(saved_path_file):
                with open(saved_path_file, "rb") as f:
                    args.data = pickle.load(f)
                    print(f"Using cached data path '{args.data}'")
            else:
                while not os.path.exists(args.data):
                    args.data = input(
                        "Enter the path to the BG3 data folder e.g. C:\Program Files (x86)\Steam\steamapps\common\Baldurs Gate 3\Data\n")
                    with open(saved_path_file, "wb") as f:
                        pickle.dump(args.data, f)

    create_mod(args)
