## Game Mechanics
- at the end of every turn, CON saving throw to not orgasm
    - failure resets stimulation counter and puts you prone + incapacitated for one turn and feeds the armor (+boosts until long rest)
    - success increases DC of next check (start at DC 2, increase by 3 per turn)
        - at DC > 10 receive penalties to AC and so on
- persistent buffs
    - base 12 AC (clothing)
    - +1 to spell attack rolls and spell save DC
    - resistance to acid damage
    - disadvantage on concentration checks
    - stage 0
        - add CHA modifier to cantrips (see Potent Robe)
        - add CHA to AC (vs melee only)
    - stage 1
        - add CHA modifier to cantrips
        - add CHA to AC (vs melee only)
        - +1 crit threshold
    - stage 2
        - add CHA modifier to attacks and spell damage
        - add CHA to AC (vs melee only)
        - +1 crit threshold
        - -1 damage from all sources (see Reaper's Embrace)
    - stage 3
        - add CHA modifier to attacks and spell damage
        - add CHA to AC (vs melee only)
        - +1 crit threshold
        - -2 damage from all sources
    - stage 4
        - add CHA modifier to attacks and spell damage
        - add CHA to AC
        - +1 crit threshold
        - -2 damage from all sources
        - spell once per combat: AOE psychic pull (like Myrkul's pull ability)
- stimulation each turn in combat
    - after each turn, make CON saving throw that gets progressively harder each time you succeed, reset upon failing
    - after failing, gain 1 sated stack, fall prone, and become incapacitated for one turn
- sated buffs (how many times you've cum) (can be stacked 3 times, you can 1 stack after failing CON save)
    - regeneration per round +per stack
    - removes disadvantage on concentration checks
    - +1 saving throw per stack
- to progress to the next form, need to have the required remodelled body stage, and long rest with at least 3 stacks of sated
        
## Structure
- one visual model per remodelled frame stage (4 stages)
    - may have to have different ones for different body types (4 x N total models)

## Development Process
base model Karlach's barbarian clothing (UNI_Barbarian_Karlach 2e3a2651-18ce-44b0-b7bd-3e2565bf666c)
- visual template (what you see in the examine window): LOOT_ARM_Barbarian_Karlach_A eec213cc-3484-4555-8ebe-bea181ecdb42 (VisualBank)
- Equipment/Visuals (for human female; located in [PAK]_Female_Armor): 
    - HUM_F_ARM_Barbarian_Karlach_A_Body 11a29e17-99fd-0db5-ec2e-d90a40ec5b1f (VisualBank)
        - mateial 8ddbf459-cdfd-46b2-366f-3389aefead46
    - HUM_F_ARM_Barbarian_Karlach_A_Pants 7cc5cafc-2bb8-3627-97e0-125d2c4fd084 (VisualBank)
        - material 714e3022-dbf1-85d5-3cd8-7eccd4701c5c
- materials and textures defined in Shared/Public/Shared/Content/Assets/_merged.lsf.lsx
- actual textures are in virtualtextures (can tell which one they are from by the prefix letter)
    - top is b7026cd8be87e5779be1092c0813c655
    - pants is Albedo_Normal_Physical_8 87f5fac7356dc95f1edd0d0e0eaca542 <attribute id="GTexFileName" type="FixedString" value="87f5fac7356dc95f1edd0d0e0eaca542" />
    - tentacles are Albedo_Normal_Physical_c c60191c1be35f9341b6919df6515d9f9 <attribute id="GTexFileName" type="FixedString" value="c60191c1be35f9341b6919df6515d9f9" />