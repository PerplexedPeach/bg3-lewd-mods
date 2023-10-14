--- @meta
--- @diagnostic disable

--- Table that contains every ModTable entry for active mods.
Mods = {}

--- Special global value that contains the current mod UUID during load
--- @type FixedString
ModuleUUID = "UUID"

--- Table that gets stored in the save, unique for each ModTable entry.
--- @type table
PersistentVars = {}

--- @alias OsirisValue number|string

--- Using a DB like a function will allow inserting new values into the database (ex. `Osi.DB_IsPlayer("02a77f1f-872b-49ca-91ab-32098c443beb")`  
--- @overload fun(...:OsirisValue|nil)
--- @class OsiDatabase
local OsiDatabase = {}
--- Databases can be read using the Get method. The method checks its parameters against the database and only returns rows that match the query.  
--- The number of parameters passed to Get must be equivalent to the number of columns in the target database.  
--- Each parameter defines an (optional) filter on the corresponding column.  
--- If the parameter is nil, the column is not filtered (equivalent to passing _ in Osiris). If the parameter is not nil, only rows with matching values will be returned.
--- @vararg OsirisValue|nil
--- @return table<integer,table<integer,OsirisValue>>
function OsiDatabase:Get(...) end
--- The Delete method can be used to delete rows from databases.  
--- The number of parameters passed to Delete must be equivalent to the number of columns in the target database.  
--- Each parameter defines an (optional) filter on the corresponding column.  
--- If the parameter is nil, the column is not filtered (equivalent to passing _ in Osiris). If the parameter is not nil, only rows with matching values will be deleted. 
--- @vararg OsirisValue|nil
function OsiDatabase:Delete(...) end

--- @alias OsiFunction fun(...:OsirisValue):OsirisValue|nil
--- @alias OsiDynamic table<string, OsiFunction|OsiDatabase>

--- @class OsiCommonDatabases
--- @field DB_IsPlayer OsiDatabase|fun(Guid:string) All player characters
--- @field DB_Origins OsiDatabase|fun(Guid:string) All origin characters
--- @field DB_Avatars OsiDatabase|fun(Guid:string) All player characters that were created in character creation, or that have an `AVATAR` tag
--- @field DB_CombatObjects OsiDatabase|fun(Guid:string, combatID:integer) All objects in combat
--- @field DB_CombatCharacters OsiDatabase|fun(Guid:string, combatID:integer) All characters in combat
--- @field DB_Dialogs OsiDatabase|fun(Guid:string, dialog:string)|fun(GUID1:string, GUID2:string, dialog:string)|fun(GUID1:string, GUID2:string, GUID3:string, dialog:string)|fun(GUID1:string, GUID2:string, GUID3:string, GUID4:string, dialog:string) All registered dialogs for objects, the most common being the version with a single character

--- The Osi table contains databases as well as calls, queries, events, and custom PROC / QRY defintions, as long as they are used in a script.  
--- @type OsiCommonDatabases|OsiDynamic
Osi = {}

--- @alias OsirisEventType string|"before"|"after"|"beforeDelete"|"afterDelete"
--- @alias i16vec2 int16[]

--- @alias SkillAbility "None"|"Warrior"|"Ranger"|"Rogue"|"Source"|"Fire"|"Water"|"Air"|"Earth"|"Death"|"Summoning"|"Polymorph"
--- @alias SkillElement SkillAbility
--- @alias YesNo "Yes"|"No"

--- @alias GameDifficultyValue uint32
---|0 # Story
---|1 # Explorer
---|2 # Classic
---|3 # Tactician
---|4 # Honour

--- @alias RTPCName "PlaybackSpeed"|"RTPC_Rumble"|"RTPC_Volume_Ambient"|"RTPC_Volume_Cinematic"|"RTPC_Volume_FX"|"RTPC_Volume_MAIN"|"RTPC_Volume_Music"|"RTPC_Volume_Music_Fight"|"RTPC_Volume_UI"|"RTPC_Volume_VO_Dialog"|"RTPC_Volume_VO_Master"|"RTPC_Volume_VO_Narrator"|"RTPC_Volume_VO_Overhead"
--- @alias SoundObjectId "Global"|"Music"|"Ambient"|"HUD"|"GM"|"Player1"|"Player2"|"Player3"|"Player4"
--- @alias StateGroupName "ARX_Dead"|"ARX_Krakenbattle"|"Amb_ARX_Frozen"|"Amb_Endgame_State"|"Amb_LV_State"|"Amb_Tuto_State"|"COS_OrcTemple"|"CoS_ElfTempleNuked"|"DLC_01_Amb_LV_State"|"DLC_01_Amb_WindBlender"|"GM_Theme"|"Items_Objects_MCH_Laboratory_Machines_Turbine_A"|"Menu_Themes"|"Music_Theme"|"Music_Type"|"Proj_Gren_ClusterBomb_Impact_Multi_VoiceLimitSwitch"|"Skill_NPC_VoidGlide"|"Soundvol_Arx_Sewers_DeathfogMachine_Active"|"State_Dialogue"
--- @alias SwitchGroupName "Armor_Type"|"Bear"|"Boar"|"Burning_Witch"|"Cat"|"Chicken"|"Deer"|"Dog"|"Dragon"|"Drillworm_Hatchlings"|"Elemental_Ooze"|"Items_Material"|"Items_Objects_TOOL_Ladder_Material"|"Items_SurfaceType"|"Items_Weight"|"Movement_FX_Type"|"PlayerType"|"Raanaar_Automaton"|"Race"|"Sex"|"Skill_CharacterType"|"Spider"|"Steps_Speed"|"Steps_Terrain"|"Steps_Type"|"Steps_Weight"|"Tiger"|"Troll"|"Variation"|"Vocal_Combat_Type"|"WarOwl"|"Weapon_Action"|"Weapon_Hit_Armor_Type"|"Weapon_Hit_Bloodtype"|"Weapon_Hit_Material_Type"|"Weapon_Material"|"Weapon_Race"|"Weapon_Type"|"Whoosh_Magic"|"Whoosh_Type"|"Whoosh_Weight"|"Wolf"

--- @alias LevelMapName "Armor ArmorValue"|"Armor ConstitutionBoost"|"Armor FinesseBoost"|"Armor HearingBoost"|"Armor IntelligenceBoost"|"Armor MagicArmorValue"|"Armor MagicPointsBoost"|"Armor MemoryBoost"|"Armor SightBoost"|"Armor StrengthBoost"|"Armor Value"|"Armor VitalityBoost"|"Armor WitsBoost"|"ArmorUsageSkill"|"Character Act Strength"|"Character AirSpecialist"|"Character Armor"|"Character Constitution"|"Character Critical Chance"|"Character DualWielding"|"Character EarthSpecialist"|"Character Finesse"|"Character FireSpecialist"|"Character Gain"|"Character Hearing"|"Character Intelligence"|"Character Leadership"|"Character MagicArmor"|"Character Memory"|"Character Necromancy"|"Character Polymorph"|"Character Ranged"|"Character RangerLore"|"Character RogueLore"|"Character Sight"|"Character SingleHanded"|"Character Sourcery"|"Character Strength"|"Character Summoning"|"Character Telekinesis"|"Character TwoHanded"|"Character WarriorLore"|"Character WaterSpecialist"|"Character Wits"|"EmbellishSkill"|"IdentifyRangeSkill"|"Object Armor"|"Object Constitution"|"Object MagicArmor"|"Object Value"|"ObjectDurabilitySkill"|"Potion Armor"|"Potion Constitution"|"Potion Damage"|"Potion Finesse"|"Potion Gain"|"Potion Hearing"|"Potion Intelligence"|"Potion MagicArmor"|"Potion Memory"|"Potion Strength"|"Potion Value"|"Potion Vitality"|"Potion Wits"|"RepairRangeSkill"|"RewardExperience"|"Shield ArmorValue"|"Shield Blocking"|"Shield ConstitutionBoost"|"Shield FinesseBoost"|"Shield HearingBoost"|"Shield IntelligenceBoost"|"Shield MagicArmorValue"|"Shield MagicPointsBoost"|"Shield MemoryBoost"|"Shield SightBoost"|"Shield StrengthBoost"|"Shield Value"|"Shield VitalityBoost"|"Shield WitsBoost"|"SkillData AreaRadius"|"SkillData BackStart"|"SkillData ChanceToPierce"|"SkillData Duration"|"SkillData EndPosRadius"|"SkillData ExplodeRadius"|"SkillData ForkChance"|"SkillData FrontOffset"|"SkillData GrowSpeed"|"SkillData GrowTimeout"|"SkillData HealAmount"|"SkillData Height"|"SkillData HitPointsPercent"|"SkillData HitRadius"|"SkillData Lifetime"|"SkillData MaxDistance"|"SkillData NextAttackChance"|"SkillData NextAttackChanceDivider"|"SkillData Offset"|"SkillData Radius"|"SkillData Range"|"SkillData StatusChance"|"SkillData StatusClearChance"|"SkillData StatusLifetime"|"SkillData SurfaceRadius"|"SkillData TargetRadius"|"SkillData TravelSpeed"|"StatusData Radius"|"Value"|"Weapon ConstitutionBoost"|"Weapon Damage"|"Weapon FinesseBoost"|"Weapon HearingBoost"|"Weapon IntelligenceBoost"|"Weapon MagicPointsBoost"|"Weapon MemoryBoost"|"Weapon SightBoost"|"Weapon StrengthBoost"|"Weapon Value"|"Weapon VitalityBoost"|"Weapon WitsBoost"|"WisdomSkill"

--- @alias StatsHealValueType "FixedValue"|"Percentage"|"Qualifier"|"Shield"|"TargetDependent"|"DamagePercentage"

--- @alias ComponentHandle userdata
--- @alias EntityHandle userdata
--- @alias EntityRef number
--- @alias FixedString string
--- @alias Guid string
--- @alias NetId integer
--- @alias Path string
--- @alias PersistentRef any
--- @alias PersistentRegistryEntry any
--- @alias Ref any
--- @alias RegistryEntry any
--- @alias UserId integer
--- @alias UserReturn any
--- @alias int16 integer
--- @alias int32 integer
--- @alias int64 integer
--- @alias int8 integer
--- @alias uint16 integer
--- @alias uint32 integer
--- @alias uint64 integer
--- @alias uint8 integer
--- @alias Version int32[]
--- @alias ivec2 int32[]
--- @alias mat3 number[]
--- @alias mat3x4 number[]
--- @alias mat4 number[]
--- @alias mat4x3 number[]
--- @alias vec2 number[]
--- @alias vec3 number[]
--- @alias vec4 number[]


--- @alias AIFlags string|"CanNotUse"|"IgnoreSelf"|"IgnoreDebuff"|"IgnoreBuff"|"StatusIsSecondary"|"IgnoreControl"|"CanNotTargetFrozen"
--- @alias AbilityId string|"Charisma"|"Wisdom"|"Intelligence"|"None"|"Constitution"|"Dexterity"|"Strength"|"Sentinel"
--- @alias AdvantageBoostType string|"Advantage"|"Disadvantage"
--- @alias AdvantageTypeId string|"DeathSavingThrow"|"Ability"|"SavingThrow"|"Skill"|"AllSavingThrows"|"AllAbilities"|"Concentration"|"AttackTarget"|"AllSkills"|"SourceDialogue"|"AttackRoll"
--- @alias ArmorType string|"ChainShirt"|"RingMail"|"HalfPlate"|"Splint"|"None"|"Padded"|"Plate"|"BreastPlate"|"ScaleMail"|"Hide"|"ChainMail"|"StuddedLeather"|"Leather"|"Cloth"|"Sentinel"
--- @alias AttackRoll string|"Charisma"|"Wisdom"|"Intelligence"|"None"|"Constitution"|"Dexterity"|"SpellCastingAbility"|"WeaponAttackAbility"|"Strength"|"UnarmedAttackAbility"
--- @alias AttributeFlags string|"Floating"|"SlippingImmunity"|"Torch"|"Arrow"|"Unbreakable"|"Unrepairable"|"Unstorable"|"PickpocketableWhenEquipped"|"Grounded"|"LoseDurabilityOnCharacterHit"|"InvulnerableAndInteractive"|"IgnoreClouds"|"EnableObscurityEvents"|"LootableWhenEquipped"|"ObscurityWithoutSneaking"|"ThrownImmunity"|"InvisibilityImmunity"|"Backstab"|"BackstabImmunity"|"FloatingWhileMoving"|"ForceMainhandAlternativeEquipBones"|"UseMusicalInstrumentForCasting"|"InventoryBound"
--- @alias BoostCauseType string|"Stats"|"Passive"|"Osiris"|"Unknown5"|"Progression"|"Item"|"Status"|"Undefined"|"Character"
--- @alias BoostType string|"Resistance"|"WeaponDamageResistance"|"CarryCapacityMultiplier"|"AreaDamageEvade"|"CannotHarmCauseEntity"|"FactionOverride"|"Reroll"|"WeaponDamageDieOverride"|"BlockSomaticComponent"|"WeaponAttackTypeOverride"|"AiArchetypeOverride"|"ExpertiseBonus"|"RedirectDamage"|"Advantage"|"ProjectileDeflect"|"WeaponAttackRollAbilityOverride"|"BlockAbilityModifierFromAC"|"EntityThrowDamage"|"ProficiencyBonus"|"DualWielding"|"BlockAbilityModifierDamageBonus"|"AdvanceSpells"|"WeaponAttackRollBonus"|"AddProficiencyToAC"|"Proficiency"|"DownedStatus"|"UnarmedMagicalProperty"|"ArmorAbilityModifierCapOverride"|"AddProficiencyToDamage"|"ActiveCharacterLight"|"ObjectSizeOverride"|"DodgeAttackRoll"|"SourceAllyAdvantageOnAttack"|"ActionResourceBlock"|"Tag"|"NullifyAbilityScore"|"ActionResourceReplenishTypeOverride"|"SourceAdvantageOnAttack"|"Weight"|"ACOverrideFormula"|"NonLethal"|"ActionResourcePreventReduction"|"AC"|"ActionResourceOverride"|"WeaponProperty"|"ReduceCriticalAttackThreshold"|"Detach"|"NoAOEDamageOnLand"|"ProficiencyBonusOverride"|"ActionResourceMultiplier"|"DarkvisionRangeMin"|"WeaponEnchantment"|"ActionResourceConsumeMultiplier"|"DarkvisionRange"|"WeaponDamage"|"MovementSpeedLimit"|"PhysicalForceRangeBonus"|"MinimumRollResult"|"AbilityOverrideMinimum"|"VoicebarkBlock"|"DamageReduction"|"MonkWeaponDamageDiceOverride"|"AbilityFailedSavingThrow"|"UseBoosts"|"FallDamageMultiplier"|"DamageBonus"|"MonkWeaponAttackOverride"|"MaximumRollResult"|"Ability"|"JumpMaxDistanceMultiplier"|"UnlockSpellVariant"|"MaximizeHealing"|"CriticalHitExtraDice"|"UnlockSpell"|"Lootable"|"CriticalDamageOnHit"|"IntrinsicSummonerProficiency"|"CriticalHit"|"Lock"|"UnlockInterrupt"|"IntrinsicSourceProficiency"|"RollBonus"|"TwoWeaponFighting"|"ConsumeItemBlock"|"IgnorePointBlankDisadvantage"|"LeaveTriggers"|"TemporaryHP"|"CanWalkThrough"|"JumpMaxDistanceBonus"|"IgnoreLowGroundPenalty"|"IgnoreLeaveAttackRange"|"ItemReturnToOwner"|"CanShootThrough"|"StatusImmunity"|"Invulnerable"|"IgnoreEnterAttackRange"|"CanSeeThrough"|"WeightCategory"|"IgnoreDamageThreshold"|"Invisibility"|"CannotBeDisarmed"|"SpellSaveDC"|"BlockVerbalComponent"|"Initiative"|"SpellResistance"|"HorizontalFOVOverride"|"IncreaseMaxHP"|"BlockTravel"|"HiddenDuringCinematic"|"ObjectSize"|"SoundsBlocked"|"ActionResource"|"BlockSpellCast"|"Skill"|"GuaranteedChanceRollOutcome"|"IgnoreSurfaceCover"|"BlockRegainHP"|"SightRangeOverride"|"IgnoreResistance"|"EnableBasicItemInteractions"|"BlockGatherAtCamp"|"SightRangeMaximum"|"DetectDisturbancesBlock"|"HalveWeaponDamage"|"DarkvisionRangeOverride"|"Attribute"|"SightRangeMinimum"|"SightRangeAdditive"|"GameplayObscurity"|"ConcentrationIgnoreDamage"|"GameplayLight"|"CharacterWeaponDamage"|"ScaleMultiplier"|"AttackSpellOverride"|"Savant"|"WeaponDamageTypeOverride"|"CharacterUnarmedDamage"
--- @alias CauseType string|"None"|"InventoryItem"|"SurfaceMove"|"SurfaceCreate"|"SurfaceStatus"|"StatusEnter"|"StatusTick"|"Offhand"|"GM"|"WorldItemThrow"|"AURA"|"Attack"
--- @alias ClientGameState string|"UnloadLevel"|"UnloadModule"|"UnloadSession"|"Paused"|"PrepareRunning"|"Running"|"Disconnect"|"Join"|"Save"|"StartLoading"|"StopLoading"|"StartServer"|"Movie"|"Installation"|"LoadModule"|"ModReceiving"|"Lobby"|"BuildStory"|"GeneratePsoCache"|"LoadPsoCache"|"AnalyticsSessionEnd"|"Init"|"InitMenu"|"InitNetwork"|"InitConnection"|"Unknown"|"Idle"|"LoadMenu"|"Menu"|"Exit"|"SwapLevel"|"LoadLevel"|"LoadSession"
--- @alias CombatParticipantFlags string|"IsBoss"|"IsInspector"|"StayInAiHints"|"CanFight"|"CanJoinCombat"
--- @alias ConditionRollType string|"DifficultyRoll"|"SavingThrowRoll"|"SkillCheckRoll"|"AbilityCheckRoll"|"AttackRoll"
--- @alias CraftingStationType string|"Anvil"|"Oven"|"Wetstone"|"Well"|"None"|"BoilingPot"|"Beehive"|"SpinningWheel"|"Cauldron"|"Misc1"|"Misc2"|"Misc3"|"Misc4"
--- @alias CriticalHitBoostFlags string|"Failure"|"Success"|"SuccessNever"|"FailureNever"|"AttackTarget"|"AttackRoll"
--- @alias DamageFlags string|"Hit"|"Projectile"|"Surface"|"StatusEnter"|"Magical"|"Backstab"|"Dodge"|"Critical"|"Miss"|"Invulnerable"|"Invisible"|"SavingThrow"|"HitpointsDamaged"|"Status"|"AttackAdvantage"|"AttackDisadvantage"
--- @alias DamageType string|"Cold"|"Radiant"|"Psychic"|"None"|"Necrotic"|"Piercing"|"Acid"|"Lightning"|"Poison"|"Bludgeoning"|"Slashing"|"Thunder"|"Force"|"Sentinel"|"Fire"
--- @alias DealDamageWeaponDamageType string|"None"|"OffhandWeaponDamageType"|"MainMeleeWeaponDamageType"|"OffhandMeleeWeaponDamageType"|"MainRangedWeaponDamageType"|"OffhandRangedWeaponDamageType"|"SourceWeaponDamageType"|"ThrownWeaponDamageType"|"MainWeaponDamageType"
--- @alias DealDamageWeaponType string|"None"|"SourceWeapon"|"UnarmedDamage"|"MainWeapon"|"OffhandWeapon"|"MainMeleeWeapon"|"OffhandMeleeWeapon"|"MainRangedWeapon"|"OffhandRangedWeapon"|"ThrownWeapon"|"ImprovisedWeapon"
--- @alias DiceSizeId string|"D4"|"D6"|"D8"|"D10"|"D12"|"D20"|"D100"|"Default"
--- @alias ESurfaceFlag string|"MovementBlock"|"WaterCloud"|"Frozen"|"ProjectileBlock"|"PoisonCloud"|"HasCharacter"|"ExplosionCloud"|"HasItem"|"ShockwaveCloud"|"GroundSurfaceBlock"|"CloudSurfaceBlock"|"Occupied"|"BloodCloud"|"SurfaceExclude"|"Water"|"Web"|"Sulfurium"|"Deepwater"|"FireCloud"|"Source"|"SmokeCloud"|"FrostCloud"|"Deathfog"|"Blessed"|"Poison"|"Cursed"|"Purified"|"CloudBlessed"|"CloudCursed"|"Lava"|"CloudPurified"|"Electrified"|"Oil"|"CloudElectrified"|"ElectrifiedDecay"|"SomeDecay"|"Fire"|"Irreplaceable"|"IrreplaceableCloud"|"HasInteractableObject"|"Blood"
--- @alias EquipmentStatsType string|"Armor"|"Shield"|"Weapon"
--- @alias ExecuteWeaponFunctorsType string|"BothHands"|"Undefined"|"OffHand"|"MainHand"
--- @alias ExtComponentType string|"InventoryData"|"InterruptZone"|"Visual"|"Equipable"|"CanDeflectProjectiles"|"ClientItem"|"WeaponAttackTypeOverrideBoost"|"DamageReductionBoost"|"ConcentrationIgnoreDamageBoost"|"Armor"|"InventoryOwner"|"SpellCast"|"InterruptZoneSource"|"Stealth"|"ProgressionContainer"|"CharacterCreationAppearance"|"ClientProjectile"|"WeaponDamageDieOverrideBoost"|"ObjectSizeBoost"|"ActionResourceReplenishTypeOverrideBoost"|"IgnoreLowGroundPenaltyBoost"|"InventoryContainer"|"Floating"|"ProgressionMeta"|"ServerExperienceGaveOut"|"ArmorClassBoost"|"CarryCapacityMultiplierBoost"|"ExpertiseBonusBoost"|"IgnoreSurfaceCoverBoost"|"Player"|"IsInCombat"|"CustomIcon"|"Disarmable"|"CanTravel"|"Active"|"ServerReplicationDependency"|"AbilityBoost"|"WeaponAttackRollAbilityOverrideBoost"|"MaximizeHealingBoost"|"SurfacePathInfluences"|"CombatParticipant"|"SummonContainer"|"DualWielding"|"ObjectInteraction"|"ServerActivationGroupContainer"|"RollBonusBoost"|"SightRangeAdditiveBoost"|"DamageBonusBoost"|"Stats"|"ActionResourceConsumeMultiplierBoost"|"CombatState"|"Background"|"ClientControl"|"StaticPhysics"|"ServerDisplayNameList"|"AdvantageBoost"|"SightRangeMinimumBoost"|"AdvanceSpellsBoost"|"MaterialParameterOverride"|"TurnBased"|"Voice"|"DisabledEquipment"|"ActiveCharacterLight"|"Pathing"|"ServerToggledPassives"|"CriticalHitBoost"|"SightRangeMaximumBoost"|"SpellResistanceBoost"|"Tag"|"TurnOrder"|"ServerCombatGroupMapping"|"LootingState"|"ActiveSkeletonSlots"|"ServerDelayDeathCause"|"ResistanceBoost"|"SightRangeOverrideBoost"|"SpellSaveDCBoost"|"Experience"|"SpellBook"|"ServerCanStartCombat"|"SpellModificationContainer"|"Loot"|"Net"|"ServerReplicationDependencyOwner"|"UnlockSpellBoost"|"MovementSpeedLimitBoost"|"RedirectDamageBoost"|"StatusImmunities"|"ServerEnterRequest"|"SpellCastAnimationInfo"|"SummonLifetime"|"Physics"|"FTBParticipant"|"ActionResourceValueBoost"|"SourceAdvantageBoost"|"UnlockSpellVariantBoost"|"CanSeeThroughBoost"|"Health"|"Use"|"ServerFleeBlocked"|"SpellCastCanBeTargeted"|"HotbarContainer"|"ApprovalRatings"|"AbilityFailedSavingThrowBoost"|"ProficiencyBoost"|"DetectCrimesBlockBoost"|"CanShootThroughBoost"|"Passive"|"Wielding"|"ServerImmediateJoin"|"SpellCastInterruptResults"|"Savegame"|"OriginTag"|"InteractionFilter"|"Steering"|"AttitudesToPlayers"|"WeaponDamageResistanceBoost"|"IncreaseMaxHPBoost"|"BlockAbilityModifierFromACBoost"|"CanWalkThroughBoost"|"CustomStats"|"SpellContainer"|"ServerSpellCastHitDelay"|"OriginPassives"|"ServerRecruitedBy"|"ProficiencyBonusOverrideBoost"|"StatusImmunityBoost"|"ReduceCriticalAttackThresholdBoost"|"LockBoost"|"BoostCondition"|"PlayerPrepareSpell"|"ServerSpellCastResponsible"|"ClassTag"|"AnimationSet"|"Movement"|"ServerGameTimer"|"JumpMaxDistanceMultiplierBoost"|"UseBoosts"|"TemporaryHPBoost"|"PhysicalForceRangeBonusBoost"|"DodgeAttackRollBoost"|"BaseHp"|"BoostsContainer"|"CCPrepareSpell"|"ServerSpellClientInitiated"|"Icon"|"BackgroundTag"|"ServerIsUnsummoning"|"HalveWeaponDamageBoost"|"WeightBoost"|"ObjectSizeOverrideBoost"|"UnlockInterruptBoost"|"SpellBookPrepares"|"AddedSpells"|"ServerSpellHitRegister"|"BackgroundPassives"|"ServerAnubisTag"|"ProficiencyBonusBoost"|"WeightCategoryBoost"|"AiArchetypeOverrideBoost"|"Uuid"|"Transform"|"PassiveContainer"|"SpellBookCooldowns"|"ServerSpellInterruptRequests"|"InterruptData"|"God"|"Lock"|"FleeCapability"|"DisplayName"|"ServerDialogTag"|"ActionResourceBlockBoost"|"FactionOverrideBoost"|"EntityThrowDamageBoost"|"UuidToHandleMapping"|"ActionResources"|"BoostInfo"|"Relation"|"SpellAiConditions"|"ServerSpellInterruptResults"|"CanDoRest"|"ServerIconList"|"CannotHarmCauseEntityBoost"|"InitiativeBoost"|"WeaponDamageTypeOverrideBoost"|"Value"|"CanInteract"|"SpellCastCache"|"InterruptConditionallyDisabled"|"IsInTurnBasedMode"|"ServerRaceTag"|"ActionResourceMultiplierBoost"|"DarkvisionRangeBoost"|"WeaponAttackRollBonusBoost"|"CanSpeak"|"SpellCastIsCasting"|"InterruptZoneParticipant"|"ShortRest"|"ItemBoosts"|"ServerTemplateTag"|"DarkvisionRangeMinBoost"|"AddTagBoost"|"MonkWeaponDamageDiceOverrideBoost"|"EocLevel"|"BodyType"|"SpellCastMovement"|"ServerInterruptAddRemoveRequests"|"AnimationBlueprint"|"ServerBoostTag"|"DarkvisionRangeOverrideBoost"|"SkillBoost"|"HorizontalFOVOverrideBoost"|"Origin"|"Classes"|"SpellCastRolls"|"ServerInterruptActionRequests"|"Invisibility"|"CanModifyHealth"|"ServerSafePosition"|"IgnoreDamageThresholdMinBoost"|"WeaponDamageBoost"|"CharacterUnarmedDamageBoost"|"Max"|"OffStage"|"SpellCastState"|"ServerInterruptZoneRequests"|"IsSummon"|"IsGlobal"|"AvailableLevel"|"ServerAnubisExecutor"|"NullifyAbilityBoost"|"WeaponEnchantmentBoost"|"ActionResourcePreventReductionBoost"|"Data"|"PickingState"|"Speaker"|"ObjectSize"|"SpellSyncTargeting"|"ServerInterruptInitialParticipants"|"CanBeLooted"|"ServerLeader"|"RerollBoost"|"GuaranteedChanceRollOutcomeBoost"|"AttackSpellOverrideBoost"|"SimpleCharacter"|"ServerSpellExternals"|"ServerInterruptTurnOrderInZone"|"CanBeDisarmed"|"ServerBreadcrumb"|"DownedStatusBoost"|"MinimumRollResultBoost"|"IgnorePointBlankDisadvantageBoost"|"WeaponSet"|"ServerSpellCastState"|"LevelUp"|"CharacterCreationStats"|"CanDoActions"|"Race"|"ServerPickpocket"|"AttributeBoost"|"CharacterWeaponDamageBoost"|"CriticalHitExtraDiceBoost"|"Level"|"DifficultyCheck"|"AttributeFlags"|"LearnedSpells"|"InterruptActionState"|"GlobalShortRestDisabled"|"CanMove"|"ServerCharacter"|"GameplayLightBoost"|"ProjectileDeflectBoost"|"GameplayObscurityBoost"|"BaseStats"|"InterruptContainer"|"GlobalLongRestDisabled"|"CanSense"|"Concentration"|"Sight"|"ServerItem"|"DualWieldingBoost"|"AbilityOverrideMinimumBoost"|"MaximumRollResultBoost"|"Hearing"|"Expertise"|"InterruptDecision"|"StoryShortRestDisabled"|"Darkness"|"ServerProjectile"|"SavantBoost"|"ACOverrideFormulaBoost"|"JumpMaxDistanceBonusBoost"|"Weapon"|"HealBlock"|"InterruptPreferences"|"CanTriggerRandomCasts"|"GameObjectVisual"|"GameplayLight"|"ServerOsirisTag"|"FallDamageMultiplierBoost"|"WeaponPropertyBoost"|"ArmorAbilityModifierCapOverrideBoost"|"InventoryMember"|"InterruptPrepared"|"GravityDisabled"|"GravityDisabledUntilMoved"|"ClientCharacter"|"ActiveCharacterLightBoost"|"ScaleMultiplierBoost"|"IgnoreResistanceBoost"
--- @alias ExtQueryType string|"UuidToHandleMapping"|"Max"
--- @alias ExtResourceManagerType string|"Gossip"|"CharacterCreationAppearanceVisual"|"Faction"|"CharacterCreationAppearanceMaterial"|"ClassDescription"|"ActionResourceGroup"|"Background"|"AbilityList"|"CharacterCreationAccessorySet"|"TutorialEntries"|"TutorialModalEntries"|"Tag"|"ProgressionDescription"|"AbilityDistributionPreset"|"EquipmentType"|"CompanionPreset"|"Progression"|"VFX"|"ColorDefinition"|"God"|"CharacterCreationSkinColor"|"CharacterCreationSharedVisual"|"CharacterCreationPassiveAppearance"|"Flag"|"Origin"|"CharacterCreationPreset"|"Max"|"CharacterCreationMaterialOverride"|"ActionResource"|"CharacterCreationHairColor"|"Race"|"CharacterCreationEyeColor"|"SkillList"|"PassiveList"|"CharacterCreationEquipmentIcons"|"FeatDescription"|"Feat"|"CharacterCreationIconSettings"|"SpellList"
--- @alias ForceFunctorAggression string|"Aggressive"|"Friendly"|"Undefined"
--- @alias ForceFunctorOrigin string|"TargetToEntity"|"Undefined"|"OriginToEntity"|"OriginToTarget"
--- @alias FunctorExecParamsType string|"Type1"|"Type2"|"Type3"|"Type4"|"Type5"|"Type6"|"Type7"|"Type8"
--- @alias GameActionType string|"RainAction"|"StormAction"|"WallAction"|"TornadoAction"|"PathAction"|"GameObjectMoveAction"|"StatusDomeAction"
--- @alias Gender string|"Male"|"Female"
--- @alias HandednessType string|"Two"|"One"|"Any"
--- @alias HealDirection string|"Incoming"|"Outgoing"
--- @alias HealEffect string|"Surface"|"None"|"Heal"|"ResistDeath"|"Behavior"|"Unknown4"|"Sitting"|"Lifesteal"|"NegativeDamage"|"Unknown9"|"HealSharing"|"Necromantic"|"HealSharingReflected"|"Script"
--- @alias HitType string|"Magic"|"Reflected"|"Surface"|"Ranged"|"WeaponDamage"|"DoT"|"Melee"
--- @alias HitWith string|"Magic"|"Projectile"|"Surface"|"Redirection"|"None"|"FallDamage"|"CrushByFall"|"Unknown10"|"Unknown11"|"Item"|"Trap"|"Unknown"|"Weapon"
--- @alias IngredientTransformType string|"Consume"|"None"|"Boost"|"Transform"|"Poison"
--- @alias IngredientType string|"None"|"Object"|"Property"|"Category"
--- @alias InputType string|"ValueChange"|"Hold"|"Repeat"|"AcceleratedRepeat"|"Unknown"|"Press"|"Release"
--- @alias ItemDataRarity string|"Legendary"|"Rare"|"Epic"|"Uncommon"|"Divine"|"Common"|"Unique"|"Sentinel"
--- @alias ItemSlot string|"Wings"|"Underwear"|"Gloves"|"Helmet"|"Breast"|"Cloak"|"MeleeMainHand"|"MeleeOffHand"|"VanityBoots"|"RangedMainHand"|"MusicalInstrument"|"VanityBody"|"RangedOffHand"|"Ring"|"Boots"|"Amulet"|"Ring2"|"Overhead"|"OffHand"|"MainHand"|"Horns"
--- @alias ItemSlot32 string|"Wings"|"Gloves"|"Helmet"|"Breast"|"Cloak"|"Ring"|"Boots"|"MainWeapon"|"Amulet"|"OffhandWeapon"|"Ring2"|"Overhead"|"MeleeMainWeapon"|"MeleeOffhandWeapon"|"RangedMainWeapon"|"RangedOffhandWeapon"|"Belt"|"Sentinel"|"Horns"
--- @alias LuaTypeId string|"Function"|"Float"|"Void"|"Boolean"|"Integer"|"Set"|"Map"|"Tuple"|"Object"|"Enumeration"|"Nullable"|"Variant"|"Array"|"Unknown"|"String"|"Module"|"Any"
--- @alias NetMessage string|"NETMSG_CLIENT_ACCEPT"|"NETMSG_CHARACTER_BOOST"|"NETMSG_ITEM_MOVE_TO_WORLD"|"NETMSG_EGG_CREATE"|"NETMSG_SHOW_ENTER_REGION_UI_MESSAGE"|"NETMSG_CAMERA_MODE"|"NETMSG_ACHIEVEMENT_PROGRESS_MESSAGE"|"NETMSG_GM_VIGNETTE_ANSWER"|"NETMSG_READYCHECK"|"NETMSG_SET_CHARACTER_ARCHETYPE"|"NETMSG_PARTY_PRESET_SAVE"|"NETMSG_PLAYER_JOINED"|"NETMSG_CHARACTER_TRANSFORM"|"NETMSG_ITEM_STATUS_LIFETIME"|"NETMSG_EGG_DESTROY"|"NETMSG_CHARACTER_TELEPORT"|"NETMSG_SHROUD_UPDATE"|"NETMSG_PLAY_HUD_SOUND"|"NETMSG_GM_POSITION_SYNC"|"NETMSG_DIPLOMACY"|"NETMSG_TRIGGER_CREATE"|"NETMSG_PARTY_PRESET_LOAD"|"NETMSG_PLAYER_ACCEPT"|"NETMSG_CHARACTER_ACTION_REQUEST_RESULT"|"NETMSG_CHARACTER_PICKPOCKET"|"NETMSG_ITEM_TRANSFORM"|"NETMSG_SURFACE_META"|"NETMSG_SCREEN_FADE_DONE"|"NETMSG_PLAYSOUND"|"NETMSG_COMBINE_RESULT"|"NETMSG_UPDATE_CHARACTER_TAGS"|"NETMSG_TRIGGER_DESTROY"|"NETMSG_PING_BEACON"|"NETMSG_PARTY_PRESET_LEVELUP"|"NETMSG_HOST_REFUSEPLAYER"|"NETMSG_PLAYER_LEFT"|"NETMSG_CHARACTER_OFFSTAGE"|"NETMSG_CHARACTER_ANIMATION_SET_UPDATE"|"NETMSG_ITEM_CONFIRMATION"|"NETMSG_GAMEACTION"|"NETMSG_OPEN_CUSTOM_BOOK_UI_MESSAGE"|"NETMSG_PLAYMOVIE"|"NETMSG_DIALOG_STATE_MESSAGE"|"NETMSG_UPDATE_ITEM_TAGS"|"NETMSG_TRIGGER_UPDATE"|"NETMSG_GIVE_REWARD"|"NETMSG_PARTY_PRESET_SPELL"|"NETMSG_CLIENT_CONNECT"|"NETMSG_VOICEDATA"|"NETMSG_CHARACTER_IN_DIALOG"|"NETMSG_TURNBASED_STARTTURN_CONFIRMATION"|"NETMSG_ITEM_MOVED_INFORM"|"NETMSG_GAMEOVER"|"NETMSG_CLOSE_CUSTOM_BOOK_UI_MESSAGE"|"NETMSG_TRADE_ACTION"|"NETMSG_DIALOG_NODE_MESSAGE"|"NETMSG_GM_CAMPAIGN_SAVE"|"NETMSG_CUSTOM_STATS_CREATE"|"NETMSG_DLC_UPDATE"|"NETMSG_ITEM_TOGGLE_IS_WARE"|"NETMSG_PLAYER_CONNECT"|"NETMSG_MIC_DISABLED"|"NETMSG_CHARACTER_LOOT"|"NETMSG_UI_FORCETURNBASED_TURN_STARTED"|"NETMSG_ITEM_MOVE_UUID"|"NETMSG_ACT_OVER"|"NETMSG_OPEN_MESSAGE_BOX_MESSAGE"|"NETMSG_GAMETIME_SYNC"|"NETMSG_DIALOG_ANSWER_MESSAGE"|"NETMSG_GM_SYNC_ASSETS"|"NETMSG_CUSTOM_STATS_UPDATE"|"NETMSG_RESPEC_UPDATE"|"NETMSG_ROLL_STREAM_ROLL_MODE_TYPE"|"NETMSG_PLAYER_DISCONNECT"|"NETMSG_CHAT"|"NETMSG_CHARACTER_ITEM_USED"|"NETMSG_INVENTORY_CREATE"|"NETMSG_SPELL_LEARN"|"NETMSG_CLOSED_MESSAGE_BOX_MESSAGE"|"NETMSG_ITEM_ENGRAVE"|"NETMSG_DIALOG_ANSWER_HIGHLIGHT_MESSAGE"|"NETMSG_DIALOG_HISTORY_MESSAGE"|"NETMSG_GM_ASSETS_PENDING_SYNCS_INFO"|"NETMSG_LOAD_GAME_WITH_ADDONS"|"NETMSG_SHORT_REST"|"NETMSG_SCRIPT_EXTENDER"|"NETMSG_SKIPMOVIE_RESULT"|"NETMSG_PEER_ACTIVATE"|"NETMSG_CHARACTER_UNSHEATHING"|"NETMSG_INVENTORY_CREATE_AND_OPEN"|"NETMSG_SPELL_PREPARE"|"NETMSG_OPEN_WAYPOINT_UI_MESSAGE"|"NETMSG_TELEPORT_ACK"|"NETMSG_DIALOG_ACTORJOINS_MESSAGE"|"NETMSG_GM_SYNC_SCENES"|"NETMSG_CUSTOM_STATS_DEFINITION_CREATE"|"NETMSG_LOAD_GAME_WITH_ADDONS_FAIL"|"NETMSG_END_THE_DAY"|"NETMSG_PEER_DEACTIVATE"|"NETMSG_MODULE_LOAD"|"NETMSG_CHARACTER_BEHAVIOR"|"NETMSG_INVENTORY_DESTROY"|"NETMSG_SPELL_SHEATH"|"NETMSG_CLOSE_UI_MESSAGE"|"NETMSG_UNLOCK_ITEM"|"NETMSG_DIALOG_ACTORLEAVES_MESSAGE"|"NETMSG_GM_SYNC_OVERVIEW_MAPS"|"NETMSG_CUSTOM_STATS_DEFINITION_REMOVE"|"NETMSG_CLIENT_GAME_SETTINGS"|"NETMSG_MODULE_LOADED"|"NETMSG_SESSION_LOADED"|"NETMSG_PARTYCREATEGROUP"|"NETMSG_INVENTORY_VIEW_CREATE"|"NETMSG_SPELL_CANCEL"|"NETMSG_OPEN_CRAFT_UI_MESSAGE"|"NETMSG_DIALOG_LISTEN"|"NETMSG_DIALOG_REPLACESPEAKER_MESSAGE"|"NETMSG_GM_SYNC_VIGNETTES"|"NETMSG_CUSTOM_STATS_DEFINITION_UPDATE"|"NETMSG_TIMELINE_HANDSHAKE"|"NETMSG_SESSION_LOAD"|"NETMSG_SESSION_UNLOADED"|"NETMSG_PARTY_UNLOCKED_RECIPE"|"NETMSG_INVENTORY_VIEW_DESTROY"|"NETMSG_SPELL_START"|"NETMSG_TELEPORT_WAYPOINT"|"NETMSG_DIALOG_INVALID_ANSWER"|"NETMSG_CAMERA_SPLINE"|"NETMSG_GM_REORDER_ELEMENTS"|"NETMSG_TIMELINE_ACTOR_HANDSHAKE"|"NETMSG_FORCE_TURN_BASED_END_PLAYER_TURN_REQUEST"|"NETMSG_LEVEL_LOAD"|"NETMSG_LEVEL_INSTANTIATE_SWAP"|"NETMSG_PARTY_NPC_DATA"|"NETMSG_INVENTORY_VIEW_UPDATE_ITEMS"|"NETMSG_SPELL_END"|"NETMSG_QUEST_CATEGORY_UPDATE"|"NETMSG_DIALOG_SUGGESTANSWER_MESSAGE"|"NETMSG_GM_SPAWN"|"NETMSG_GM_SET_START_POINT"|"NETMSG_TIMELINE_NODECOMPLETED"|"NETMSG_FORCE_TURN_BASED_TOGGLE_REQUEST"|"NETMSG_LEVEL_CREATED"|"NETMSG_LEVEL_SWAP_READY"|"NETMSG_PARTY_SPLIT_NOTIFICATION"|"NETMSG_INVENTORY_VIEW_UPDATE_PARENTS"|"NETMSG_SHOW_ERROR"|"NETMSG_QUEST_PROGRESS"|"NETMSG_LOBBY_DATAUPDATE"|"NETMSG_GM_DELETE"|"NETMSG_GM_CONFIGURE_CAMPAIGN"|"NETMSG_TIMELINE_JOIN_FINALIZE"|"NETMSG_CHARACTER_REQUEST_WEAPON_SET_SWITCH"|"NETMSG_LEVEL_LOADED"|"NETMSG_LEVEL_SWAP_COMPLETE"|"NETMSG_PARTY_MERGE_NOTIFICATION"|"NETMSG_INVENTORY_VIEW_SORT"|"NETMSG_FACTION_CLEAR"|"NETMSG_JOURNALRECIPE_UPDATE"|"NETMSG_LOBBY_USERUPDATE"|"NETMSG_FACTION_SET"|"NETMSG_GM_LOAD_CAMPAIGN"|"NETMSG_SYNC_CONCENTRATION_COMPONENT"|"NETMSG_LOAD_START"|"NETMSG_CHARACTER_CREATE"|"NETMSG_PROJECTILE_CREATE"|"NETMSG_INVENTORY_ITEM_UPDATE"|"NETMSG_SAVEGAME"|"NETMSG_MARKER_UI_UPDATE"|"NETMSG_LOBBY_STARTGAME"|"NETMSG_GM_DAMAGE"|"NETMSG_GM_REQUEST_CAMPAIGN_DATA"|"NETMSG_REQUESTED_ROLL"|"NETMSG_LOAD_STARTED"|"NETMSG_CHARACTER_DESTROY"|"NETMSG_PROJECTILE_UPDATE"|"NETMSG_INVENTORY_LOCKSTATE_SYNC"|"NETMSG_EFFECT_CREATE"|"NETMSG_MARKER_UI_CREATE"|"NETMSG_GM_ITEM_CHANGE"|"NETMSG_GM_HEAL"|"NETMSG_GM_MAKE_TRADER"|"NETMSG_PASSIVE_ROLL_SEQUENCE"|"NETMSG_LEVEL_START"|"NETMSG_CHARACTER_CONFIRMATION"|"NETMSG_DISCOVERED_PORTALS"|"NETMSG_SURFACE_CREATE"|"NETMSG_EFFECT_FORGET"|"NETMSG_JOURNALDIALOGLOG_UPDATE"|"NETMSG_GM_DRAW_SURFACE"|"NETMSG_GM_EXPORT"|"NETMSG_GM_GIVE_REWARD"|"NETMSG_CHARACTER_PATHING"|"NETMSG_CHARACTER_ACTIVATE"|"NETMSG_CHARACTER_AOO"|"NETMSG_MULTIPLE_TARGET_OPERATION"|"NETMSG_DARKNESSTILE_UPDATE"|"NETMSG_CACHETEMPLATE"|"NETMSG_UI_QUESTSELECTED"|"NETMSG_GM_TOGGLE_OVERVIEWMAP"|"NETMSG_GM_POSSESS"|"NETMSG_GM_CREATE_ITEM"|"NETMSG_CHARACTER_CREATION_ABORT"|"NETMSG_CHARACTER_DEACTIVATE"|"NETMSG_PARTY_CREATE"|"NETMSG_TURNBASED_FINISHTEAM"|"NETMSG_SPELL_REMOVE_LEARNED"|"NETMSG_OVERHEADTEXT"|"NETMSG_MYSTERY_ADVANCED"|"NETMSG_GM_TOGGLE_VIGNETTE"|"NETMSG_GM_DUPLICATE"|"NETMSG_GM_SET_LIGHTING"|"NETMSG_CHARACTER_CREATION_READY"|"NETMSG_CHARACTER_ASSIGN"|"NETMSG_PARTY_DESTROY"|"NETMSG_TURNBASED_SETTEAM"|"NETMSG_GAMECONTROL_UPDATE_S2C"|"NETMSG_COMBATLOG"|"NETMSG_MYSTERY_DISABLED"|"NETMSG_GM_REMOVE_EXPORTED"|"NETMSG_GM_ITEM_USE"|"NETMSG_GM_SET_ATMOSPHERE"|"NETMSG_CHARACTER_CREATION_UPDATE"|"NETMSG_CHARACTER_CHANGE_OWNERSHIP"|"NETMSG_PARTYGROUP"|"NETMSG_TURNBASED_FLEECOMBATRESULT"|"NETMSG_GAMECONTROL_UPDATE_C2S"|"NETMSG_SCREEN_FADE"|"NETMSG_REGISTER_WAYPOINT"|"NETMSG_GM_ADD_EXPERIENCE"|"NETMSG_GM_TELEPORT"|"NETMSG_GM_SOUND_PLAYBACK"|"NETMSG_LEVEL_UP_UPDATE"|"NETMSG_CHARACTER_STEERING"|"NETMSG_PARTYORDER"|"NETMSG_TURNBASED_FLEE_REQUEST"|"NETMSG_GAMECONTROL_PRICETAG"|"NETMSG_JOURNAL_RESET"|"NETMSG_UNLOCK_WAYPOINT"|"NETMSG_GM_TOGGLE_PAUSE"|"NETMSG_GM_SYNC_NOTES"|"NETMSG_GM_CHANGE_SCENE_NAME"|"NETMSG_CHARACTER_CREATION_LEVELUP"|"NETMSG_CHARACTER_MOVEMENT_FALLING"|"NETMSG_PARTYUPDATE"|"NETMSG_TURNBASED_ENDTURN_REQUEST"|"NETMSG_DIFFICULTY_CHANGED"|"NETMSG_QUEST_STEP"|"NETMSG_LIGHTING_OVERRIDE"|"NETMSG_GM_TOGGLE_PEACE"|"NETMSG_GM_CHANGE_SCENE_PATH"|"NETMSG_GM_EDIT_ITEM"|"NETMSG_CHARACTER_CREATION_RESPEC"|"NETMSG_CHARACTER_ACTION"|"NETMSG_PARTYUSER"|"NETMSG_TURNBASED_SKIP_START_DELAY"|"NETMSG_REALTIME_MULTIPLAY"|"NETMSG_QUESTS_LOADED"|"NETMSG_ATMOSPHERE_OVERRIDE"|"NETMSG_GM_CHANGE_LEVEL"|"NETMSG_GM_UI_OPEN_STICKY"|"NETMSG_GM_HOST"|"NETMSG_UI_COMBINE_OPEN"|"NETMSG_CHARACTER_ACTION_DATA"|"NETMSG_UI_FORCETURNBASED_ENTERED"|"NETMSG_ITEM_CREATE"|"NETMSG_CHARACTER_ERROR"|"NETMSG_TROPHY_UPDATE"|"NETMSG_CAMERA_ACTIVATE"|"NETMSG_GM_TRAVEL_TO_DESTINATION"|"NETMSG_GM_SET_STATUS"|"NETMSG_GM_REMOVE_STATUS"|"NETMSG_UI_INTERACTION_STOPPED"|"NETMSG_HANDSHAKE"|"NETMSG_CHARACTER_STATUS"|"NETMSG_UI_FORCETURNBASED_LEFT"|"NETMSG_ITEM_DESTROY"|"NETMSG_FACTION_RELATION"|"NETMSG_QUEST_TRACK"|"NETMSG_SECRET_REGION_UNLOCK"|"NETMSG_GM_STOP_TRAVELING"|"NETMSG_GM_CLEAR_STATUSES"|"NETMSG_GM_DEACTIVATE"|"NETMSG_UI_REQUEST_TUTORIAL"|"NETMSG_HOST_WELCOME"|"NETMSG_CHARACTER_STATUS_LIFETIME"|"NETMSG_UI_FORCETURNBASED_TURN_ENDED"|"NETMSG_ITEM_ACTIVATE"|"NETMSG_REQUESTAUTOSAVE"|"NETMSG_NOTIFICATION"|"NETMSG_ACHIEVEMENT_UNLOCKED_MESSAGE"|"NETMSG_GM_CHANGE_NAME"|"NETMSG_GM_MAKE_FOLLOWER"|"NETMSG_MUSIC_EVENT"|"NETMSG_PASSIVE_TOGGLE"|"NETMSG_HOST_REFUSE"|"NETMSG_CHARACTER_DIALOG"|"NETMSG_ITEM_DEACTIVATE"|"NETMSG_ITEM_UPDATE"|"NETMSG_SAVEGAMEHANDSHAKE"|"NETMSG_LOCK_WAYPOINT"|"NETMSG_SAVEGAME_LOAD_FAIL"|"NETMSG_GM_SET_INTERESTED_CHARACTER"|"NETMSG_GM_INVENTORY_OPERATION"|"NETMSG_MUSIC_STATE"|"NETMSG_DUALWIELDING_TOGGLE"|"NETMSG_CLIENT_JOINED"|"NETMSG_CHARACTER_USE_MOVEMENT"|"NETMSG_ITEM_DESTINATION"|"NETMSG_ITEM_ACTION"|"NETMSG_EFFECT_DESTROY"|"NETMSG_FLAG_UPDATE"|"NETMSG_SERVER_COMMAND"|"NETMSG_MODULES_DOWNLOAD"|"NETMSG_GM_SET_REPUTATION"|"NETMSG_RUNECRAFT"|"NETMSG_SNEAKING_CONES_VISIBLE_TOGGLE"|"NETMSG_CLIENT_LEFT"|"NETMSG_CHARACTER_UPDATE"|"NETMSG_ITEM_USE_REMOTELY"|"NETMSG_ITEM_STATUS"|"NETMSG_COMBATLOGITEMINTERACTION"|"NETMSG_CAMERA_ROTATE"|"NETMSG_SERVER_NOTIFICATION"|"NETMSG_NET_ENTITY_CREATE"|"NETMSG_GM_REQUEST_CHARACTERS_REROLL"|"NETMSG_PAUSE"|"NETMSG_HOTBAR_SLOT_SET"|"NETMSG_HOST_LEFT"|"NETMSG_CHARACTER_CONTROL"|"NETMSG_ITEM_MOVE_TO_INVENTORY"|"NETMSG_ITEM_OFFSTAGE"|"NETMSG_COMBATLOGENTRIES"|"NETMSG_CAMERA_TARGET"|"NETMSG_STORY_ELEMENT_UI"|"NETMSG_NET_ENTITY_DESTROY"|"NETMSG_GM_JOURNAL_UPDATE"|"NETMSG_UNPAUSE"|"NETMSG_HOTBAR_COLUMN_SET"
--- @alias PathRootType string|"Root"|"Debug"|"Scripts"|"LocalAppData"|"UserProfile"|"Public"|"Localization"|"Mods"|"Bin"|"Data"|"Bin2"|"Projects"|"Public2"|"GameMod"|"EngineMod"|"WorkingDir"
--- @alias ProficiencyBonusBoostType string|"Ability"|"SavingThrow"|"WeaponActionDC"|"Skill"|"AllSavingThrows"|"AllAbilities"|"AttackTarget"|"AllSkills"|"SourceDialogue"|"AttackRoll"
--- @alias ProficiencyGroupFlags string|"LightArmor"|"LightCrossbows"|"LightHammers"|"Longbows"|"Longswords"|"Maces"|"MartialWeapons"|"Mauls"|"MediumArmor"|"Morningstars"|"Pikes"|"Quarterstaffs"|"Rapiers"|"Scimitars"|"Shields"|"MusicalInstrument"|"Shortbows"|"Battleaxes"|"Shortswords"|"Clubs"|"Sickles"|"Daggers"|"SimpleWeapons"|"Darts"|"Slings"|"Flails"|"Spears"|"Glaives"|"Tridents"|"Greataxes"|"Warhammers"|"Greatclubs"|"Warpicks"|"Greatswords"|"Halberds"|"HandCrossbows"|"Handaxes"|"HeavyArmor"|"HeavyCrossbows"|"Javelins"
--- @alias ProjectileTypeIds string|"Physical"|"Magical"
--- @alias RecipeCategory string|"Objects"|"Common"|"Weapons"|"Potions"|"Grenades"|"Arrows"|"Armour"|"Food"|"Runes"|"Grimoire"
--- @alias RequirementType string|"Sneaking"|"Wisdom"|"Intelligence"|"None"|"Constitution"|"Persuasion"|"Dexterity"|"Strength"|"Intimidate"|"TurnBased"|"Tag"|"Ranged"|"Reason"|"Combat"|"Necromancy"|"PainReflection"|"Reflexes"|"Sourcery"|"Telekinesis"|"Level"|"Summoning"|"Pickpocket"|"Loremaster"|"Vitality"|"Barter"|"Charm"|"Immobile"
--- @alias ResistanceBoostFlags string|"ImmuneToNonMagical"|"ResistantToNonMagical"|"VulnerableToNonMagical"|"BelowDamageThreshold"|"ResistantToMagical"|"ImmuneToMagical"|"VulnerableToMagical"
--- @alias ResourceBankType string|"Visual"|"IKRig"|"Skeleton"|"VirtualTexture"|"VoiceBark"|"TerrainBrush"|"ColorList"|"Lighting"|"CharacterVisual"|"SkinPreset"|"ClothCollider"|"ColorPreset"|"Physics"|"Dialog"|"MaterialPreset"|"Sound"|"AnimationSet"|"Texture"|"Material"|"Script"|"Atmosphere"|"AnimationBlueprint"|"Timeline"|"Animation"|"MeshProxy"|"Sentinel"|"VisualSet"|"MaterialSet"|"BlendSpace"|"TileSet"|"Effect"|"FCurve"
--- @alias ResourceReplenishType string|"Rest"|"Never"|"Combat"|"ExhaustedRest"|"FullRest"|"Default"|"ShortRest"
--- @alias ServerCharacterFlags string|"CannotRun"|"Unknown80000000"|"Floating"|"DontCacheTemplate"|"WalkThrough"|"ReservedForDialog"|"PartyFollower"|"DisableWaypointUsage"|"Temporary"|"IgnoresTriggers"|"SpotSneakers"|"Totem"|"IsTrading"|"SteeringEnabled"|"Unknown10000000000"|"Loaded"|"IsCompanion_M"|"Unknown40000000000"|"Deactivated"|"CustomLookEnabled"|"IsHuge"|"DisableCulling"|"DoNotFaceFlag"|"Multiplayer"|"GMReroll"|"HostControl"|"FindValidPositionOnActivate"|"CannotMove"|"CanShootThrough"|"Detached"|"IsPlayer"|"Activated"|"Invulnerable"|"CharCreationInProgress"|"RequestStartTurn"|"Dead"|"Invisible"|"CharacterCreationFinished"|"OffStage"|"HasOwner"|"NeedsMakePlayerUpdate"|"InDialog"|"DeferredRemoveEscapist"|"CannotDie"|"LevelTransitionPending"|"StoryNPC"|"RegisteredForAutomatedDialog"|"CharacterControl"|"Unknown80000000000000"|"Unknown8000"|"ForceNonzeroSpeed"|"InParty"|"CannotAttachToGroups"|"Summon"|"FightMode"|"CoverAmount"
--- @alias ServerCharacterFlags2 string|"CanGossip"|"Global"|"TreasureGeneratedForTrader"|"Unknown0x10"|"Unknown0x40"|"Trader"|"IsResurrected"|"IsPet"
--- @alias ServerCharacterFlags3 string|"NeedsPlacementSnapping"|"CrimeWarningsEnabled"
--- @alias ServerGameState string|"UnloadLevel"|"UnloadModule"|"UnloadSession"|"Paused"|"Running"|"Disconnect"|"Save"|"LoadModule"|"Sync"|"BuildStory"|"Init"|"Uninitialized"|"ReloadStory"|"Unknown"|"Idle"|"Exit"|"LoadLevel"|"LoadSession"
--- @alias ServerItemFlags string|"LoadedTemplate"|"IsSecretDoor"|"IsDoor"|"Invulnerable2"|"ClientSync1"|"Floating"|"IsSurfaceBlocker"|"ForceClientSync"|"WalkThrough"|"ReservedForDialog"|"InPartyInventory"|"FreezeGravity"|"SourceContainer"|"StoryItem"|"Frozen"|"TeleportOnUse"|"Totem"|"InAutomatedDialog"|"WalkOn"|"PinnedContainer"|"Destroyed"|"CanBePickedUp"|"WakePhysics"|"IsMoving"|"CanUse"|"IsContainer"|"CanShootThrough"|"HideHP"|"Activated"|"LuckyFind"|"Invulnerable"|"Invisible"|"ForceSync"|"OffStage"|"Invisible2"|"DisableSync"|"IsLadder"|"LevelTransitionPending"|"DontAddToHotbar"|"PositionChanged"|"IsSurfaceCloudBlocker"|"CanBeMoved"|"NoCover"|"Destroy"|"InteractionDisabled"|"GMFolding"|"TransformChanged"|"Known"|"DisableInventoryView80"|"InUse"|"CanOnlyBeUsedByOwner"|"Summon"|"Sticky"
--- @alias ServerItemFlags2 string|"UnsoldGenerated"|"TreasureGenerated"|"UnEquipLocked"|"Global"|"UseRemotely"
--- @alias ServerStatusFlags string|"RequestDelete"|"RequestClientSync2"|"RequestClientSync"|"Loaded"|"RequestDeleteAtTurnEnd"|"Started"|"ForceStatus"|"ForceFailStatus"
--- @alias ServerStatusFlags2 string|"KeepAlive"|"IsFromItem"|"IsLifeTimeSet"|"Influence"|"Channeled"|"DontTickWhileOnSurface"|"InitiateCombat"|"ExcludeFromPortraitRendering"
--- @alias ServerStatusFlags3 string|"IsUnique"|"DisableImmunityOverhead"|"NotifiedPlanManager"|"StatusFlags3_0x08"|"StatusFlags3_0x10"|"StatusFlags3_0x20"|"StatusFlags3_0x40"|"StatusFlags3_0x80"
--- @alias ServerStatusFlags4 string|"StatusFlags4_0x80"|"IsInvulnerable"|"IsInvulnerableVisible"|"BringIntoCombat"|"IsHostileAct"|"StatusFlags4_0x04"|"StatusFlags4_0x20"|"StatusFlags4_0x40"
--- @alias ServerStatusFlags5 string|"HasTriedEntering"
--- @alias ShroudType string|"Shroud"|"RegionMask"|"Sight"|"Sneak"
--- @alias SkillId string|"Arcana"|"Stealth"|"SleightOfHand"|"Acrobatics"|"Persuasion"|"Performance"|"Invalid"|"Deception"|"Intimidation"|"Survival"|"Perception"|"Medicine"|"Insight"|"AnimalHandling"|"Athletics"|"Religion"|"Sentinel"|"Nature"|"Investigation"|"History"
--- @alias SourceAdvantageType string|"SourceAllyAdvantageOnAttack"|"SourceAdvantageOnAttack"
--- @alias SpellAttackType string|"None"|"RangedOffHandWeaponAttack"|"MeleeOffHandWeaponAttack"|"RangedUnarmedAttack"|"MeleeUnarmedAttack"|"RangedSpellAttack"|"MeleeSpellAttack"|"RangedWeaponAttack"|"MeleeWeaponAttack"|"DirectHit"
--- @alias SpellAttackTypeOverride string|"Target_UnarmedAttack"|"Target_OffhandAttack"|"Target_MainHandAttack"|"Projectile_MainHandAttack"|"Projectile_OffhandAttack"
--- @alias SpellChildSelectionType string|"Singular"|"AddChildren"|"MostPowerful"
--- @alias SpellCooldownType string|"OncePerTurn"|"OncePerCombat"|"UntilRest"|"Default"|"UntilShortRest"|"UntilPerRestPerItem"|"OncePerTurnNoRealtime"|"OncePerShortRestPerItem"
--- @alias SpellFlags string|"ConcentrationIgnoresResting"|"InventorySelection"|"IsTrap"|"IsSpell"|"CombatLogSetSingleLineRoll"|"Stealth"|"TrajectoryRules"|"IsEnemySpell"|"CannotTargetCharacter"|"CannotTargetItems"|"RangeIgnoreSourceBounds"|"CannotTargetTerrain"|"RangeIgnoreTargetBounds"|"IgnoreVisionBlock"|"RangeIgnoreVerticalThreshold"|"AddWeaponRange"|"IsDefaultWeaponAction"|"Temporary"|"IgnoreSilence"|"TargetClosestEqualGroundSurface"|"ImmediateCast"|"IsLinkedSpellContainer"|"NoSurprise"|"AbortOnSecondarySpellRollFail"|"NoAOEDamageOnLand"|"IsHarmful"|"IgnorePreviouslyPickedEntities"|"CallAlliesSpell"|"CannotRotate"|"NoCameraMove"|"CanDualWield"|"AllowMoveAndCast"|"UNUSED_D"|"Wildshape"|"UNUSED_E"|"UnavailableInDialogs"|"PickupEntityAndMove"|"Invisible"|"RangeIgnoreBlindness"|"AbortOnSpellRollFail"|"CanAreaDamageEvade"|"HasVerbalComponent"|"DontAbortPerforming"|"HasSomaticComponent"|"NoCooldownOnMiss"|"IsJump"|"IsSwarmAttack"|"IsAttack"|"DisplayInItemTooltip"|"IsMelee"|"HideInItemTooltip"|"IsConcentration"|"DisableBlood"|"HasHighGroundRangeExtension"|"AddFallDamageOnLand"|"IgnoreAoO"
--- @alias SpellPrepareType string|"AlwaysPrepared"|"RequiresPreparation"|"Unknown"
--- @alias SpellSchoolId string|"None"|"Abjuration"|"Conjuration"|"Divination"|"Enchantment"|"Evocation"|"Illusion"|"Necromancy"|"Transmutation"
--- @alias SpellSourceType string|"Boost"|"Behavior"|"CreateExplosion"|"Progression0"|"Progression1"|"SpellSet"|"Progression2"|"GameActionCreateSurface"|"SpellSet2"|"WeaponAttack"|"Shapeshift"|"UnarmedAttack"|"Osiris"|"Anubis"|"Progression"|"EquippedItem"|"AiTest"|"ActiveDefense"|"Learned"|"Unknown15"|"Unknown16"|"Unknown17"|"Unknown18"|"Unknown19"|"Spell"|"Unknown1A"|"Sentinel"|"PartyPreset"
--- @alias SpellType string|"Zone"|"Projectile"|"Rush"|"Wall"|"Throw"|"Shout"|"ProjectileStrike"|"Storm"|"MultiStrike"|"Teleportation"|"Target"
--- @alias StatAttributeFlags string|"Floating"|"SlippingImmunity"|"Torch"|"Arrow"|"Unbreakable"|"Unrepairable"|"Unstorable"|"PickpocketableWhenEquipped"|"Grounded"|"LoseDurabilityOnCharacterHit"|"EMPTY"|"InvulnerableAndInteractive"|"IgnoreClouds"|"EnableObscurityEvents"|"LootableWhenEquipped"|"ObscurityWithoutSneaking"|"ThrownImmunity"|"InvisibilityImmunity"|"Backstab"|"BackstabImmunity"|"FloatingWhileMoving"
--- @alias StatCharacterFlags string|"Blind"|"DrinkedPotion"|"EquipmentValidated"|"IsPlayer"|"Invisible"|"InParty"|"IsSneaking"
--- @alias StatsDeathType string|"Cold"|"CinematicDeath"|"Radiant"|"Psychic"|"None"|"Physical"|"Necrotic"|"Lifetime"|"KnockedDown"|"Incinerate"|"Falling"|"Explode"|"Electrocution"|"DoT"|"Chasm"|"Acid"|"Disintegrate"
--- @alias StatsExpressionParamType string|"StatsExpressionType"|"RollDefinition"|"StatsContextType"|"Type1"|"StatsExpressionVariableDataType"|"StatsExpressionVariableDataModifier"|"ResourceRollDefinition"|"Int"|"Bool"
--- @alias StatsExpressionParamType2 string|"STDString"|"StatusGroup"|"Ability"|"StatsExpressionVariableData"|"Skill"
--- @alias StatsFunctorFlags string|"Self"|"Owner"|"Swap"
--- @alias StatsFunctorId string|"ResetCombatTurn"|"RemoveUniqueStatus"|"RemoveStatusByLevel"|"CustomDescription"|"RemoveStatus"|"Stabilize"|"RegainHitPoints"|"SpawnInInventory"|"CreateZone"|"Spawn"|"CreateWall"|"CreateSurface"|"SetStatusDuration"|"CreateExplosion"|"CreateConeSurface"|"SetRoll"|"Pickup"|"Counterspell"|"SetReroll"|"SetDisadvantage"|"SetDamageResistance"|"Douse"|"SetAdvantage"|"MaximizeRoll"|"Sabotage"|"ResetCooldowns"|"CameraWait"|"Resurrect"|"UseSpell"|"BreakConcentration"|"UseAttack"|"RestoreResource"|"Kill"|"UseActionResource"|"ApplyStatus"|"Equalize"|"Unsummon"|"ApplyEquipmentStatus"|"Unlock"|"ShortRest"|"Extender"|"TriggerRandomCast"|"Force"|"TeleportSource"|"FireProjectile"|"AdjustRoll"|"SpawnExtraProjectiles"|"RemoveAuraByChildStatus"|"SwitchDeathType"|"SwapPlaces"|"RegainTemporaryHitPoints"|"SurfaceClearLayer"|"Drop"|"SurfaceChange"|"GainTemporaryHitPoints"|"DoTeleport"|"ExecuteWeaponFunctors"|"DisarmWeapon"|"SummonInInventory"|"DisarmAndStealWeapon"|"TutorialEvent"|"Summon"|"DealDamage"
--- @alias StatsItemSlot string|"Wings"|"Underwear"|"Gloves"|"Helmet"|"Breast"|"Cloak"|"MeleeMainHand"|"MeleeOffHand"|"VanityBoots"|"RangedMainHand"|"MusicalInstrument"|"VanityBody"|"RangedOffHand"|"Ring"|"Boots"|"Amulet"|"Ring2"|"Overhead"|"Max"|"Sentinel"|"OffHand"|"MainHand"|"Horns"
--- @alias StatsObserverType string|"Observer"|"None"|"Target"|"Source"
--- @alias StatsPropertyContext string|"STATUS_REMOVED"|"ACTION_RESOURCES_CHANGED"|"DAMAGED_PREVENTED"|"STATUS_REMOVE"|"DAMAGE_PREVENTED"|"STATUS_APPLY"|"DAMAGED"|"STATUS_APPLIED"|"DAMAGE"|"PUSHED"|"SHORT_REST"|"PUSH"|"PROJECTILE"|"PROFICIENCY_CHANGED"|"OBSCURITY_CHANGED"|"COMBAT_ENDED"|"MOVED_DISTANCE"|"CAST_RESOLVED"|"CAST"|"LONG_REST"|"LEAVE_ATTACK_RANGE"|"ATTACKED"|"ATTACK"|"INVENTORY_CHANGED"|"INTERRUPT_USED"|"HEALED"|"AOE"|"HEAL"|"TURN"|"GROUND"|"AI_ONLY"|"AI_IGNORE"|"TARGET"|"CREATE"|"EQUIP"|"ABILITY_CHECK"|"ENTER_ATTACK_RANGE"|"LOCKPICKING_SUCCEEDED"|"SURFACE_ENTER"|"ATTACKING_IN_MELEE_RANGE"|"ATTACKED_IN_MELEE_RANGE"
--- @alias StatsRollAdjustmentType string|"Distribute"|"All"
--- @alias StatsRollType string|"None"|"DeathSavingThrow"|"RangedUnarmedDamage"|"MeleeUnarmedDamage"|"Damage"|"RangedSpellDamage"|"MeleeSpellDamage"|"RangedWeaponDamage"|"MeleeWeaponDamage"|"RawAbility"|"RangedOffHandWeaponAttack"|"RangedUnarmedAttack"|"SavingThrow"|"MeleeOffHandWeaponAttack"|"MeleeUnarmedAttack"|"SkillCheck"|"Attack"|"RangedSpellAttack"|"MeleeSpellAttack"|"RangedWeaponAttack"|"MeleeWeaponAttack"|"Sentinel"
--- @alias StatsStatusGroup string|"SG_Charmed_Subtle"|"SG_Drunk"|"SG_Charmed"|"SG_WeaponCoating"|"SG_Unconscious"|"SG_CanBePickedUp"|"SG_Blinded"|"SG_Taunted"|"SG_Surface"|"SG_Approaching"|"SG_Stunned"|"SG_Restrained"|"SG_Rage"|"SG_Prone"|"SG_Possessed"|"SG_Polymorph"|"SG_Poisoned"|"SG_Petrified"|"SG_Paralyzed"|"SG_Mad"|"SG_Light"|"SG_Invisible"|"SG_Incapacitated"|"SG_HexbladeCurse"|"SG_Frightened"|"SG_Fleeing"|"SG_Exhausted"|"SG_Doppelganger"|"SG_Dominated"|"SG_ScriptedPeaceBehaviour"|"SG_Disguise"|"SG_Polymorph_BeastShape_NPC"|"SG_Disease"|"SG_Polymorph_BeastShape"|"SG_Poisoned_Story_Removable"|"SG_DifficultTerrain"|"SG_Poisoned_Story_NonRemovable"|"SG_DetectThoughts"|"SG_Cursed"|"SG_Helpable_Condition"|"SG_Confused"|"SG_DropForNonMutingDialog"|"SG_RemoveOnRespec"|"SG_Condition"|"SG_Sleeping"
--- @alias StatsTargetTypeFlags string|"Living"|"Guaranteed"|"Construct"|"Undead"
--- @alias StatsZoneShape string|"Square"|"Cone"
--- @alias StatusHealType string|"PhysicalArmor"|"None"|"MagicArmor"|"AllArmor"|"Source"|"All"|"Vitality"
--- @alias StatusMaterialApplyFlags string|"ApplyOnBody"|"ApplyOnArmor"|"ApplyOnWeapon"|"ApplyOnWings"|"ApplyOnHorns"|"ApplyOnOverhead"
--- @alias StatusType string|"BOOST"|"TELEPORT_FALLING"|"EFFECT"|"DEACTIVATED"|"REACTION"|"DOWNED"|"DYING"|"SMELLY"|"INVISIBLE"|"HEAL"|"ROTATE"|"MATERIAL"|"KNOCKED_DOWN"|"CLIMBING"|"INCAPACITATED"|"STORY_FROZEN"|"INSURFACE"|"SNEAKING"|"POLYMORPHED"|"UNLOCK"|"FEAR"
--- @alias SurfaceActionType string|"CreatePuddleAction"|"ExtinguishFireAction"|"ZoneAction"|"PolygonSurfaceAction"|"TransformSurfaceAction"|"ChangeSurfaceOnPathAction"|"RectangleSurfaceAction"|"CreateSurfaceAction"
--- @alias SurfaceChange string|"None"|"DestroyWater"|"Condense"|"Vaporize"|"Melt"|"Freeze"|"Deelectrify"|"Electrify"|"Douse"|"Ignite"
--- @alias SurfaceLayer string|"None"|"Cloud"|"Ground"
--- @alias SurfaceLayer8 string|"None"|"Cloud"|"Ground"
--- @alias SurfaceTransformActionType string|"None"|"Condense"|"Vaporize"|"Melt"|"Freeze"|"Deelectrify"|"Electrify"|"Douse"|"Ignite"
--- @alias SurfaceType string|"PurpleWormPoison"|"SerpentVenom"|"InvisibleGithAcid"|"BladeBarrier"|"None"|"Sewer"|"WaterCloud"|"PoisonCloud"|"WaterElectrified"|"ExplosionCloud"|"WaterFrozen"|"ShockwaveCloud"|"BloodElectrified"|"CloudkillCloud"|"BloodFrozen"|"MaliceCloud"|"Grease"|"Ash"|"BloodCloud"|"WyvernPoison"|"StinkingCloud"|"Water"|"Web"|"Chasm"|"WaterCloudElectrified"|"DarknessCloud"|"Deepwater"|"Acid"|"FogCloud"|"GithPheromoneGasCloud"|"Vines"|"SporeWhiteCloud"|"PotionHealingGreaterCloud"|"TrialFire"|"SporeGreenCloud"|"PotionHealingSuperiorCloud"|"BlackPowder"|"SporeBlackCloud"|"PotionHealingSupremeCloud"|"ShadowCursedVines"|"DrowPoisonCloud"|"PotionInvisibilityCloud"|"Poison"|"AlienOil"|"IceCloud"|"PotionResistanceAcidCloud"|"Mud"|"PotionHealingCloud"|"PotionResistanceColdCloud"|"Alcohol"|"PotionSpeedCloud"|"PotionResistanceFireCloud"|"InvisibleWeb"|"PotionVitalityCloud"|"PotionResistanceForceCloud"|"Lava"|"BloodSilver"|"PotionAntitoxinCloud"|"PotionResistanceLightningCloud"|"Hellfire"|"PotionResistancePoisonCloud"|"SporePinkCloud"|"Oil"|"CausticBrine"|"BlackPowderDetonationCloud"|"VoidCloud"|"BloodExploding"|"CrawlerMucusCloud"|"SpikeGrowth"|"Cloudkill6Cloud"|"Sentinel"|"Fire"|"HolyFire"|"BlackTentacles"|"Blood"|"Overgrowth"
--- @alias WeaponFlags string|"Net"|"Torch"|"Ammunition"|"Finesse"|"Heavy"|"Loading"|"Magical"|"Reach"|"Lance"|"Thrown"|"Twohanded"|"Light"|"Versatile"|"Dippable"|"NoDualWield"|"NotSheathable"|"Unstowable"|"AddToHotbar"|"NeedDualWieldingBoost"|"Range"|"Melee"
--- @alias WeaponType string|"Sword"|"Club"|"None"|"Axe"|"Staff"|"Crossbow"|"Spear"|"Knife"|"Arrow"|"Wand"|"Rifle"|"Bow"|"Sentinel"


--#region Flash Types

--- @alias FlashTextFormatAlign "center"|"end"|"justify"|"left"|"right"|"start"

--- Represents an object in Flash
--- Implements the __index and __newindex metamethods using string keys (i.e. allows table-like behavior):
--- obj.field = 123 -- Can assign values to any object property
--- Ext.Print(obj.field) -- Can read any object property
--- Field values are returned using the appropriate Lua type;
--- Flash Boolean/Number/string = Lua boolean/number/string
--- Flash Object = Lua engine class FlashObject
--- Flash array = Lua engine class FlashArray
--- Flash function = Lua engine class FlashFunction
--- @class FlashObject
--- @field toString fun():string Returns the string representation of the specified object.
--- @field toLocaleString fun():string Returns the string representation of this object, formatted according to locale-specific conventions.
--- @field hasOwnProperty fun(name:string):boolean Indicates whether an object has a specified property defined.

--- Represents an array in Flash that begins at index 0
--- Implements the __index, __newindex and __len metamethods using integer keys (i.e. allows table-like behavior):
--- arr[2] = 123 -- Can assign values to any array index
--- Ext.Print(arr[2]) -- Can read any array index
--- Ext.Print(#arr) -- Can query length of array
--- @class FlashArray<T>: { [integer]: T }

--- Represents a function or method in Flash
--- Implements the __call metamethod (i.e. can be called)
--- The passed arguments are forwarded to the Flash method and the return value of the Flash method is returned
--- @class FlashFunction

--- @class FlashEvent:FlashObject

--- @class FlashEventDispatcher:FlashObject
--- @field dispatchEvent fun(event:FlashEvent):boolean Dispatches an event into the event flow.
--- @field hasEventListener fun(type:string):boolean Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
--- @field willTrigger fun(type:string):boolean Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.

--- Currently unsupported type 12
--- @class FlashDisplayObject:FlashEventDispatcher
--- @field alpha number Indicates the alpha transparency value of the object specified.
--- @field blendMode string A value from the BlendMode class that specifies which blend mode to use.
--- @field blendShader Shader [write-only] Sets a shader that is used for blending the foreground and background.
--- @field cacheAsBitmap boolean If set to true, Flash runtimes cache an internal bitmap representation of the display object.
--- @field cacheAsBitmapMatrix Matrix If non-null, this Matrix object defines how a display object is rendered when cacheAsBitmap is set to true.
--- @field filters Array An indexed array that contains each filter object currently associated with the display object.
--- @field height number Indicates the height of the display object, in pixels.
--- @field loaderInfo LoaderInfo [read-only] Returns a LoaderInfo object containing information about loading the file to which this display object belongs.
--- @field mask FlashDisplayObject The calling display object is masked by the specified mask object.
--- @field metaData FlashObject Obtains the meta data object of the DisplayObject instance if meta data was stored alongside the the instance of this DisplayObject in the SWF file through a PlaceObject4 tag.
--- @field mouseX number [read-only] Indicates the x coordinate of the mouse or user input device position, in pixels.
--- @field mouseY number [read-only] Indicates the y coordinate of the mouse or user input device position, in pixels.
--- @field name string Indicates the instance name of the DisplayObject.
--- @field opaqueBackground FlashObject Specifies whether the display object is opaque with a certain background color.
--- @field parent FlashDisplayObjectContainer [read-only] Indicates the DisplayObjectContainer object that contains this display object.
--- @field root FlashDisplayObject [read-only] For a display object in a loaded SWF file, the root property is the top-most display object in the portion of the display list's tree structure represented by that SWF file.
--- @field rotation number Indicates the rotation of the DisplayObject instance, in degrees, from its original orientation.
--- @field rotationX number Indicates the x-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
--- @field rotationY number Indicates the y-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
--- @field rotationZ number Indicates the z-axis rotation of the DisplayObject instance, in degrees, from its original orientation relative to the 3D parent container.
--- @field scale9Grid FlashRectangle The current scaling grid that is in effect.
--- @field scaleX number Indicates the horizontal scale (percentage) of the object as applied from the registration point.
--- @field scaleY number Indicates the vertical scale (percentage) of an object as applied from the registration point of the object.
--- @field scaleZ number Indicates the depth scale (percentage) of an object as applied from the registration point of the object.
--- @field scrollRect FlashRectangle The scroll rectangle bounds of the display object.
--- @field stage Stage [read-only] The Stage of the display object.
--- @field transform flash.geom:Transform An object with properties pertaining to a display object's matrix, color transform, and pixel bounds.
--- @field visible boolean Whether or not the display object is visible.
--- @field width number Indicates the width of the display object, in pixels.
--- @field x number Indicates the x coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
--- @field y number Indicates the y coordinate of the DisplayObject instance relative to the local coordinates of the parent DisplayObjectContainer.
--- @field z number Indicates the z coordinate position along the z-axis of the DisplayObject instance relative to the 3D parent container.
--- @field hitTestPoint fun(x:number, y:number, shapeFlag:boolean|nil):boolean Evaluates the display object to see if it overlaps or intersects with the point specified by the x and y parameters.

--- @class FlashInteractiveObject:FlashDisplayObject
--- @field doubleClickEnabled boolean Specifies whether the object receives doubleClick events
--- @field mouseEnabled boolean Specifies whether this object receives mouse, or other user input, messages
--- @field tabEnabled boolean Specifies whether this object is in the tab order
--- @field tabIndex integer Specifies the tab ordering of objects in a SWF file

--- flash.text:TextFormat
--- @class FlashTextFormat:FlashObject
--- @field align FlashTextFormatAlign Indicates the alignment of the paragraph.
--- @field blockIndent boolean|nil Indicates the block indentation in pixels.
--- @field bold boolean|nil Specifies whether the text is boldface.
--- @field bullet boolean|nil Indicates that the text is part of a bulleted list.
--- @field color uint32|nil Indicates the color of the text.
--- @field font string The name of the font for text in this text format, as a string.
--- @field indent number|nil Indicates the indentation from the left margin to the first character in the paragraph.
--- @field italic boolean|nil Indicates whether text in this text format is italicized.
--- @field kerning number|nil A Boolean value that indicates whether kerning is enabled (true) or disabled (false).
--- @field leading number|nil An integer representing the amount of vertical space (called leading) between lines.
--- @field leftMargin number|nil The left margin of the paragraph, in pixels.
--- @field letterSpacing number|nil A number representing the amount of space that is uniformly distributed between all characters.
--- @field rightMargin number|nil The right margin of the paragraph, in pixels.
--- @field size number|nil The size in pixels of text in this text format.
--- @field tabStops FlashArray Specifies custom tab stops as an array of non-negative integers.
--- @field target string Indicates the target window where the hyperlink is displayed.
--- @field underline boolean|nil Indicates whether the text that uses this text format is underlined (true) or not (false).
--- @field url string Indicates the target URL for the text in this text format.

--- @class FlashTextField:FlashInteractiveObject
--- @field alwaysShowSelection boolean When set to true and the text field is not in focus, Flash Player highlights the selection in the text field in gray.
--- @field antiAliasType string The type of anti-aliasing used for this text field.
--- @field autoSize string Controls automatic sizing and alignment of text fields.
--- @field background boolean Specifies whether the text field has a background fill.
--- @field backgroundColor uint32 The color of the text field background.
--- @field border boolean Specifies whether the text field has a border.
--- @field borderColor uint32 The color of the text field border.
--- @field bottomScrollV integer [read-only] An integer (1-based index) that indicates the bottommost line that is currently visible in the specified text field.
--- @field caretIndex integer [read-only] The index of the insertion point (caret) position.
--- @field condenseWhite boolean A Boolean value that specifies whether extra white space (spaces, line breaks, and so on) in a text field with HTML text is removed.
--- @field defaultTextFormat FlashTextFormat Specifies the format applied to newly inserted text, such as text entered by a user or text inserted with the replaceSelectedText() method.
--- @field displayAsPassword boolean Specifies whether the text field is a password text field.
--- @field embedFonts boolean Specifies whether to render by using embedded font outlines.
--- @field gridFitType string The type of grid fitting used for this text field.
--- @field htmlText string Contains the HTML representation of the text field contents.
--- @field length integer [read-only] The number of characters in a text field.
--- @field maxChars integer The maximum number of characters that the text field can contain, as entered by a user.
--- @field maxScrollH integer [read-only] The maximum value of scrollH.
--- @field maxScrollV integer [read-only] The maximum value of scrollV.
--- @field mouseWheelEnabled boolean A Boolean value that indicates whether Flash Player automatically scrolls multiline text fields when the user clicks a text field and rolls the mouse wheel.
--- @field multiline boolean Indicates whether field is a multiline text field.
--- @field numLines integer [read-only] Defines the number of text lines in a multiline text field.
--- @field restrict string Indicates the set of characters that a user can enter into the text field.
--- @field scrollH integer The current horizontal scrolling position.
--- @field scrollV integer The vertical position of text in a text field.
--- @field selectable boolean A Boolean value that indicates whether the text field is selectable.
--- @field selectionBeginIndex integer [read-only] The zero-based character index value of the first character in the current selection.
--- @field selectionEndIndex integer [read-only] The zero-based character index value of the last character in the current selection.
--- @field sharpness number The sharpness of the glyph edges in this text field.
--- @field styleSheet StyleSheet Attaches a style sheet to the text field.
--- @field text string A string that is the current text in the text field.
--- @field textColor uint32 The color of the text in a text field, in hexadecimal format.
--- @field textHeight number [read-only] The height of the text in pixels.
--- @field textInteractionMode string [read-only] The interaction mode property, Default value is TextInteractionMode.NORMAL.
--- @field textWidth number [read-only] The width of the text in pixels.
--- @field thickness number The thickness of the glyph edges in this text field.
--- @field type string The type of the text field.
--- @field useRichTextClipboard boolean Specifies whether to copy and paste the text formatting along with the text.
--- @field wordWrap boolean A Boolean value that indicates whether the text field has word wrap.
--- @field appendText fun(newText:string) Appends the string specified by the newText parameter to the end of the text of the text field.
--- @field getCharBoundaries fun(charIndex:integer):FlashRectangle Returns a rectangle that is the bounding box of the character.
--- @field getCharIndexAtPoint fun(x:Number, y:Number):integer Returns the zero-based index value of the character at the point specified by the x and y parameters.
--- @field getFirstCharInParagraph fun(charIndex:integer):integer Given a character index, returns the index of the first character in the same paragraph.
--- @field getImageReference fun(id:string):FlashDisplayObject Returns a DisplayObject reference for the given id, for an image or SWF file that has been added to an HTML-formatted text field by using an <img> tag.
--- @field getLineIndexAtPoint fun(x:Number, y:Number):integer Returns the zero-based index value of the line at the point specified by the x and y parameters.
--- @field getLineIndexOfChar fun(charIndex:integer):integer Returns the zero-based index value of the line containing the character specified by the charIndex parameter.
--- @field getLineLength fun(lineIndex:integer):integer Returns the number of characters in a specific text line.
--- @field getLineMetrics fun(lineIndex:integer):flash.text:TextLineMetrics Returns metrics information about a given text line.
--- @field getLineOffset fun(lineIndex:integer):integer Returns the character index of the first character in the line that the lineIndex parameter specifies.
--- @field getLineText fun(lineIndex:integer):string Returns the text of the line specified by the lineIndex parameter.
--- @field getParagraphLength fun(charIndex:integer):integer Given a character index, returns the length of the paragraph containing the given character.	
--- @field getTextFormat fun(beginIndex:integer, endIndex:integer):flash.text:TextFormat Returns a TextFormat object that contains formatting information for the range of text that the beginIndex and endIndex parameters specify.
--- @field isFontCompatible fun(fontName:string, fontStyle:string):boolean [static] Returns true if an embedded font is available with the specified fontName and fontStyle where Font.fontType is flash.text.FontType.EMBEDDED.
--- @field replaceSelectedText fun(value:string) Replaces the current selection with the contents of the value parameter.	
--- @field replaceText fun(beginIndex:integer, endIndex:integer, newText:string) Replaces the range of characters that the beginIndex and endIndex parameters specify with the contents of the newText parameter.	
--- @field setSelection fun(beginIndex:integer, endIndex:integer) Sets as selected the text designated by the index values of the first and last characters, which are specified with the beginIndex and endIndex parameters.
--- @field setTextFormat fun(FlashTextFormat, beginIndex:integer, endIndex:integer) Applies the text formatting that the format parameter specifies to the specified text in a text field.

--- @class FlashBitmapData
--- @class FlashMatrix
--- @class FlashVector
--- @class FlashTextSnapshot
--- @class FlashPoint
--- @class FlashEvent
--- @class FlashMouseEvent

--- @class FlashGraphics:FlashObject
--- @field beginBitmapFill fun(bitmap:FlashBitmapData, matrix:FlashMatrix, repeat:boolean, smooth:boolean) Fills a drawing area with a bitmap image
--- @field beginFill fun(color:integer, alpha:number) Specifies a simple one-color fill that subsequent calls to other Graphics methods (such as lineTo or drawCircle) use when drawing
--- @field beginGradientFill fun(type:string, colors:FlashArray, alphas:FlashArray, ratios:FlashArray, matrix:FlashMatrix, spreadMethod:string, interpolationMethod:string, focalPointRatio:number) Specifies a gradient fill used by subsequent calls to other Graphics methods (such as lineTo or drawCircle) for the object
--- @field clear function Clears the graphics that were drawn to this Graphics object, and resets fill and line style settings
--- @field curveTo fun(controlX:number, controlY:number, anchorX:number, anchorY:number) Draws a quadratic Bezier curve using the current line style from the current drawing position to the control point specified
--- @field drawCircle fun(x:number, y:number, radius:number) Draws a circle
--- @field drawEllipse fun(x:number, y:number, width:number, height:number) Draws an ellipse
--- @field drawPath fun(commands:FlashVector, data:FlashVector, winding:string) Submits a series of commands for drawing
--- @field drawRect fun(x:number, y:number, width:number, height:number) Draws a rectangle
--- @field drawRoundRect fun(x:number, y:number, width:number, height:number, ellipseWidth:number, ellipseHeight:number) Draws a rounded rectangle
--- @field endFill function Applies a fill to the lines and curves that were added since the last call to beginFill, beginGradientFill, or beginBitmapFill methods
--- @field lineGradientStyle fun(type:string, colors:FlashArray, alphas:FlashArray, ratios:FlashArray, matrix:FlashMatrix, spreadMethod:string, interpolationMethod:string, focalPointRatio:number) Specifies a gradient to use for the stroke when drawing lines
--- @field lineStyle fun(thickness:number, color:integer, alpha:number, pixelHinting:boolean, scaleMode:string, caps:string, joints:string, miterLimit:number) Specifies a line style used for subsequent calls to Graphics methods such as the lineTo method or the drawCircle method
--- @field lineTo fun(x:number, y:number) Draws a line using the current line style from the current drawing position
--- @field moveTo fun(x:number, y:number) Moves the current drawing position,

--- @class FlashDisplayObjectContainer:FlashInteractiveObject
--- @field mouseChildren boolean Determines whether or not the children of the object are mouse, or user input device, enabled
--- @field numChildren integer Returns the number of children of this object. [read-only]
--- @field tabChildren boolean Determines whether the children of the object are tab enabled
--- @field textSnapshot FlashTextSnapshot Returns a TextSnapshot object for this DisplayObjectContainer instance. [read-only]
--- @field addChild fun(child:FlashDisplayObject):FlashDisplayObject Adds a child DisplayObject instance to this DisplayObjectContainer instance
--- @field addChildAt fun(child:FlashDisplayObject, index:integer):FlashDisplayObject Adds a child DisplayObject instance to this DisplayObjectContainer instance
--- @field areInaccessibleObjectsUnderPoint fun(point:FlashPoint):boolean Indicates whether the security restrictions would cause any display objects to be omitted from the list returned by calling the DisplayObjectContainer.getObjectsUnderPoint() method with the specified point point
--- @field contains fun(child:FlashDisplayObject):boolean Determines whether the specified display object is a child of the DisplayObjectContainer instance or the instance itself
--- @field getChildAt fun(index:integer):FlashDisplayObject Returns the child display object instance that exists at the specified index
--- @field getChildByName fun(name:string):FlashDisplayObject Returns the child display object that exists with the specified name
--- @field getChildIndex fun(child:FlashDisplayObject):integer Returns the index position of a child DisplayObject instance
--- @field getObjectsUnderPoint fun(point:FlashPoint):table Returns an array of objects that lie under the specified point and are children (or grandchildren, and so on) of this DisplayObjectContainer instance
--- @field removeChild fun(child:FlashDisplayObject):FlashDisplayObject Removes the specified child DisplayObject instance from the child list of the DisplayObjectContainer instance
--- @field removeChildAt fun(index:integer):FlashDisplayObject Removes a child DisplayObject from the specified index position in the child list of the DisplayObjectContainer
--- @field removeChildren fun(beginIndex:integer, endIndex:integer) Removes all child DisplayObject instances from the child list of the DisplayObjectContainer instance
--- @field setChildIndex fun(child:FlashDisplayObject, index:integer) Changes the position of an existing child in the display object container
--- @field swapChildren fun(child1:FlashDisplayObject, child2:FlashDisplayObject) Swaps the z-order (front-to-back order) of the two specified child objects
--- @field swapChildrenAt fun(index1:integer, index2:integer) Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list

--- @class FlashRectangle:FlashObject
--- @field x number
--- @field y number
--- @field top number
--- @field bottom number
--- @field left number
--- @field right number

--- @class FlashSprite:FlashDisplayObjectContainer
--- @field buttonMode boolean Specifies the button mode of this sprite
--- @field graphics FlashGraphics Specifies the Graphics object that belongs to this sprite where vector drawing commands can occur. [read-only]
--- @field soundTransform number Controls sound within this sprite
--- @field useHandCursor boolean A value that indicates whether the pointing hand (hand cursor) appears when the pointer rolls over a sprite in which the buttonMode property is set to true

--- @class FlashMovieClip:FlashSprite
--- @field currentFrame integer Specifies the number of the frame in which the playhead is located in the timeline of the MovieClip instance. [read-only]
--- @field currentFrameLabel string The label at the current frame in the timeline of the MovieClip instance. [read-only]
--- @field currentLabel string The current label in which the playhead is located in the timeline of the MovieClip instance. [read-only]
--- @field currentLabels string[] Returns an array of FrameLabel objects from the current scene. [read-only]
--- @field currentScene FlashObject The current scene in which the playhead is located in the timeline of the MovieClip instance. [read-only]
--- @field scenes FlashArray[] An array of Scene objects, each listing the name, the number of frames, and the frame labels for a scene in the MovieClip instance. [read-only]
--- @field enabled boolean A Boolean value that indicates whether a movie clip is enabled
--- @field framesLoaded integer The number of frames that are loaded from a streaming SWF file. [read-only]
--- @field isPlaying boolean A Boolean value that indicates whether a movie clip is curently playing. [read-only]
--- @field totalFrames integer The total number of frames in the MovieClip instance. [read-only]
--- @field trackAsMenu boolean Indicates whether other display objects that are SimpleButton or MovieClip objects can receive mouse release events or other user input release events
--- @field gotoAndPlay fun(frame:string|integer, scene:string|nil) Starts playing the SWF file at the specified frame
--- @field gotoAndStop fun(frame:string|integer, scene:string|nil) Brings the playhead to the specified frame of the movie clip and stops it there
--- @field nextFrame function Sends the playhead to the next frame and stops it
--- @field nextScene function Moves the playhead to the next scene of the MovieClip instance
--- @field play function Moves the playhead in the timeline of the movie clip
--- @field prevFrame function Sends the playhead to the previous frame and stops it
--- @field prevScene function Moves the playhead to the previous scene of the MovieClip instance
--- @field stop function Stops the playhead in the movie clip
--- @field hitTest fun(x:number, y:number, shapeFlag:boolean|nil):boolean

--- @class FlashMainTimeline:FlashMovieClip
--- @field events string[] An array of input keys this UI should listen for, in the form of 'IE Name', such as 'IE UICreationTabPrev'. The engine will invoke onEventDown/onEventUp when these keys are pressed, if they haven't been handled
--- @field onEventDown fun(id:number):boolean Invoked by the engine when a valid input key in this.events is pressed. If true is returned, the key is"handled"and won't send events to other UI objects
--- @field onEventUp fun(id:number):boolean Invoked by the engine when a valid input key in this.events is released. If true is returned, the key is"handled"and won't send events to other UI objects
--- @field onEventResolution fun(width:number, height:number) Invoked by the engine when the screen is resized
--- @field onEventInit function Invoked by the engine. Typically used to register the anchor id and layout with ExternalInterface.call

--#endregion
--- @class ACOverrideFormulaBoostComponent:BaseComponent
--- @field AC int32
--- @field AddAbilityModifiers AbilityId[]
--- @field field_4 boolean


--- @class AbilityBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field Value int32
--- @field field_8 int32
--- @field field_C int8


--- @class AbilityFailedSavingThrowBoostComponent:BaseComponent
--- @field Ability AbilityId


--- @class AbilityOverrideMinimumBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field Amount int32


--- @class ActionOriginator
--- @field ActionGuid Guid
--- @field CanApplyConcentration boolean
--- @field InterruptId FixedString
--- @field PassiveId FixedString
--- @field StatusId FixedString


--- @class ActionResourceBlockBoostComponent:BaseComponent
--- @field IntParam int32
--- @field ResourceUUID Guid


--- @class ActionResourceConsumeMultiplierBoostComponent:BaseComponent
--- @field Multiplier int32
--- @field ResourceUUID Guid
--- @field field_30 int64


--- @class ActionResourceMultiplierBoostComponent:BaseComponent
--- @field DiceSize DiceSizeId
--- @field IntParam int32
--- @field IntParam2 int32
--- @field ResourceUUID Guid


--- @class ActionResourcePreventReductionBoostComponent:BaseComponent
--- @field ActionResource Guid
--- @field Amount int32


--- @class ActionResourceReplenishTypeOverrideBoostComponent:BaseComponent
--- @field ActionResource Guid
--- @field ReplenishType ResourceReplenishType


--- @class ActionResourceValueBoostComponent:BaseComponent
--- @field Amount number
--- @field Amount2 int32
--- @field DiceSize DiceSizeId
--- @field ResourceUUID Guid


--- @class ActionResourcesComponent:BaseComponent
--- @field Resources table<Guid, ActionResourcesComponentAmount[]>


--- @class ActionResourcesComponentAmount
--- @field Amount number
--- @field MaxAmount number
--- @field ResourceId int32
--- @field ResourceUUID Guid
--- @field SubAmounts ActionResourcesComponentAmountSubAmount[]|nil
--- @field field_28 uint64
--- @field field_30 uint64


--- @class ActionResourcesComponentAmountSubAmount
--- @field Amount number
--- @field MaxAmount number


--- @class ActivationGroupContainerComponent:BaseComponent
--- @field Groups ActivationGroupContainerComponentActivationGroup[]


--- @class ActivationGroupContainerComponentActivationGroup
--- @field field_0 FixedString
--- @field field_4 FixedString


--- @class ActiveCharacterLightBoostComponent:BaseComponent
--- @field LightUUID FixedString


--- @class ActiveCharacterLightComponent:BaseComponent
--- @field Light FixedString


--- @class ActiveComponent:BaseComponent


--- @class ActiveSkeletonSlotsComponent:BaseComponent
--- @field Slots FixedString[]


--- @class AddTagBoostComponent:BaseComponent
--- @field Tag Guid


--- @class AdvanceSpellsBoostComponent:BaseComponent
--- @field field_0 FixedString
--- @field field_4 int32


--- @class AdvantageBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field AdvantageType AdvantageTypeId
--- @field Skill SkillId
--- @field Tags Guid[]
--- @field Type AdvantageBoostType


--- @class AiArchetypeOverrideBoostComponent:BaseComponent
--- @field Archetype FixedString
--- @field Priority int32


--- @class AnubisTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class ApprovalRatingsComponent:BaseComponent
--- @field Ratings table<EntityHandle, int32>
--- @field field_70 Array_Guid


--- @class ArmorAbilityModifierCapOverrideBoostComponent:BaseComponent
--- @field ArmorType ArmorType
--- @field Value int32


--- @class ArmorClassBoostComponent:BaseComponent
--- @field AC int32


--- @class ArmorComponent:BaseComponent
--- @field AbilityModifierCap int32
--- @field ArmorClass int32
--- @field ArmorClassAbility uint8
--- @field ArmorType int32
--- @field Shield uint8


--- @class AttackSpellOverrideBoostComponent:BaseComponent
--- @field AttackType SpellAttackTypeOverride
--- @field SpellId FixedString


--- @class AttitudesToPlayersComponent:BaseComponent
--- @field Attitudes table<AttitudesToPlayersComponentKey, int32>


--- @class AttitudesToPlayersComponentKey
--- @field field_0 EntityHandle
--- @field field_10 Guid
--- @field field_20 uint8
--- @field field_8 uint8


--- @class AttributeBoostComponent:BaseComponent
--- @field AttributeFlags AttributeFlags


--- @class AttributeFlagsComponent:BaseComponent
--- @field AttributeFlags uint32


--- @class AvailableLevelComponent:BaseComponent
--- @field Level int32


--- @class BackgroundComponent:BaseComponent
--- @field Background Guid


--- @class BackgroundPassivesComponent:BaseComponent
--- @field field_18 PassiveInfo[]


--- @class BackgroundTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class BaseComponent


--- @class BaseHpComponent:BaseComponent
--- @field Vitality int32
--- @field VitalityBoost int32


--- @class BaseStatsComponent:BaseComponent
--- @field BaseAbilities int32[]


--- @class BlockAbilityModifierFromACComponent:BaseComponent
--- @field Ability AbilityId


--- @class BodyTypeComponent:BaseComponent
--- @field BodyType uint8
--- @field BodyType2 uint8


--- @class BoostCause
--- @field Cause FixedString
--- @field Entity EntityHandle
--- @field Type BoostCauseType
--- @field field_10 uint64


--- @class BoostConditionComponent:BaseComponent
--- @field ConditionFlags int32
--- @field field_1C uint8


--- @class BoostInfoComponent:BaseComponent
--- @field BoostEntity EntityHandle
--- @field Cause BoostCause
--- @field Owner EntityHandle
--- @field Params BoostParameters
--- @field Type BoostType
--- @field field_10 Guid
--- @field field_20 uint8
--- @field field_80 Guid


--- @class BoostParameters
--- @field Boost FixedString
--- @field Params string
--- @field Params2 string


--- @class BoostTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class BoostsContainerComponent:BaseComponent
--- @field Boosts table<BoostType, EntityHandle[]>
--- @field field_0 uint64


--- @class BreadcrumbComponent:BaseComponent
--- @field field_118 vec3
--- @field field_18 BreadcrumbComponentElement[]


--- @class BreadcrumbComponentElement
--- @field field_0 int32
--- @field field_14 vec3
--- @field field_4 uint8
--- @field field_8 vec3


--- @class CanBeDisarmedComponent:BaseComponent
--- @field Flags uint16


--- @class CanBeLootedComponent:BaseComponent
--- @field Flags uint16


--- @class CanDeflectProjectilesComponent:BaseComponent
--- @field Flags uint16


--- @class CanDoActionsComponent:BaseComponent
--- @field Flags uint16


--- @class CanDoRestComponent:BaseComponent
--- @field field_18 uint8
--- @field field_19 uint8
--- @field field_1A uint8
--- @field field_1B uint8


--- @class CanInteractComponent:BaseComponent
--- @field Flags uint16


--- @class CanModifyHealthComponent:BaseComponent
--- @field Flags uint16


--- @class CanMoveComponent:BaseComponent
--- @field Flags uint16


--- @class CanSeeThroughBoostComponent:BaseComponent
--- @field CanSeeThrough boolean


--- @class CanSenseComponent:BaseComponent
--- @field Flags uint16


--- @class CanShootThroughBoostComponent:BaseComponent
--- @field CanShootThrough boolean


--- @class CanSpeakComponent:BaseComponent
--- @field Flags uint16


--- @class CanTravelComponent:BaseComponent
--- @field field_18 int16
--- @field field_1A int16
--- @field field_1C int16


--- @class CanTriggerRandomCastsComponent:BaseComponent


--- @class CanWalkThroughBoostComponent:BaseComponent
--- @field CanWalkThrough boolean


--- @class CannotHarmCauseEntityBoostComponent:BaseComponent
--- @field Type FixedString


--- @class CarryCapacityMultiplierBoostComponent:BaseComponent
--- @field Multiplier number


--- @class CharacterCreationAppearanceComponent:BaseComponent
--- @field AdditionalChoices int32[]
--- @field Elements GameObjectVisualDataAppearanceElement[]
--- @field EyeColor Guid
--- @field HairColor Guid
--- @field SecondEyeColor Guid
--- @field SkinColor Guid
--- @field Visuals Guid[]


--- @class CharacterCreationStatsComponent:BaseComponent
--- @field Abilities int32[]
--- @field BodyType uint8
--- @field Name string
--- @field Race Guid
--- @field SubRace Guid
--- @field field_21 uint8
--- @field field_5C uint8


--- @class CharacterTemplate:EoCGameObjectTemplate
--- @field ActivationGroupId FixedString
--- @field ActiveCharacterLightID FixedString
--- @field AliveInventoryType uint8
--- @field AnimationSetResourceID FixedString
--- @field AnubisConfigName FixedString
--- @field AvoidTraps boolean
--- @field BloodSurfaceType uint8
--- @field BloodType FixedString
--- @field CanBePickedUp boolean
--- @field CanBePickpocketed boolean
--- @field CanBeTeleported boolean
--- @field CanClimbLadders boolean
--- @field CanConsumeItems boolean
--- @field CanOpenDoors boolean
--- @field CanShootThrough boolean
--- @field CanWalkThroughDoors boolean
--- @field CharacterVisualResourceID FixedString
--- @field CombatComponent CombatComponentTemplate
--- @field CoverAmount uint8
--- @field CriticalHitType FixedString
--- @field DeathEffect Guid
--- @field DeathRaycastHeight number
--- @field DeathRaycastMaxLength number
--- @field DeathRaycastMinLength number
--- @field DeathRaycastVerticalLength number
--- @field DefaultDialog FixedString
--- @field DefaultState uint8
--- @field DisableEquipping boolean
--- @field DisintegrateFX FixedString
--- @field DisintegratedResourceID FixedString
--- @field Equipment FixedString
--- @field EquipmentRace Guid
--- @field EquipmentTypes Guid[]
--- @field ExcludeInDifficulty Guid[]
--- @field ExplodedResourceID FixedString
--- @field ExplosionFX FixedString
--- @field FoleyLongResourceID FixedString
--- @field FoleyMediumResourceID FixedString
--- @field FoleyShortResourceID FixedString
--- @field ForceLifetimeDeath boolean
--- @field GeneratePortrait string
--- @field HasPlayerApprovalRating boolean
--- @field Icon FixedString
--- @field InfluenceTreasureLevel boolean
--- @field InventoryType uint8
--- @field IsDroppedOnDeath boolean
--- @field IsEquipmentLootable boolean
--- @field IsLootable boolean
--- @field IsMovementEnabled boolean
--- @field IsPlayer boolean
--- @field IsSimpleCharacter boolean
--- @field IsSteeringEnabled boolean
--- @field IsTradable uint8
--- @field IsWorldClimbingEnabled boolean
--- @field JumpUpLadders boolean
--- @field LadderAttachOffset number
--- @field LadderBlendspace_Attach_Down FixedString
--- @field LadderBlendspace_Attach_Up FixedString
--- @field LadderBlendspace_Detach_Down FixedString
--- @field LadderBlendspace_Detach_Up FixedString
--- @field LadderLoopSpeed number
--- @field LevelOverride int32
--- @field LightChannel uint8
--- @field LightID FixedString
--- @field MaxDashDistance number
--- @field MovementAcceleration number
--- @field MovementSpeedDash number
--- @field MovementSpeedRun number
--- @field MovementSpeedSprint number
--- @field MovementSpeedStroll number
--- @field MovementSpeedWalk number
--- @field MovementStepUpHeight number
--- @field MovementTiltToRemap FixedString
--- @field OnlyInDifficulty Guid[]
--- @field PickingPhysicsTemplates table<FixedString, FixedString>
--- @field ProbeLookAtOffset number
--- @field ProbeSpineAOffset number
--- @field ProbeSpineBOffset number
--- @field ProbeTiltToOffset number
--- @field Race Guid
--- @field RagdollTemplate FixedString
--- @field ShootThroughType uint8
--- @field SoftBodyCollisionTemplate FixedString
--- @field SoundAttenuation int16
--- @field SoundInitEvent FixedString
--- @field SoundMovementStartEvent FixedString
--- @field SoundMovementStopEvent FixedString
--- @field SoundObjectIndex int8
--- @field SpeakerGroupList Array_Guid
--- @field SpellSet FixedString
--- @field SpotSneakers boolean
--- @field Stats FixedString
--- @field StatusList FixedString[]
--- @field SteeringSpeedCurveWithoutTransitions FixedString
--- @field SteeringSpeedFallback number
--- @field SteeringSpeed_CastingCurve FixedString
--- @field SteeringSpeed_MovingCurve FixedString
--- @field Title TranslatedString
--- @field TradeTreasures FixedString[]
--- @field Treasures FixedString[]
--- @field TrophyID FixedString
--- @field TurningNodeAngle number
--- @field TurningNodeOffset number
--- @field UseOcclusion boolean
--- @field UseSoundClustering boolean
--- @field UseStandAtDestination boolean
--- @field VocalAlertResourceID FixedString
--- @field VocalAngryResourceID FixedString
--- @field VocalAnticipationResourceID FixedString
--- @field VocalAttackResourceID FixedString
--- @field VocalAwakeResourceID FixedString
--- @field VocalBoredResourceID FixedString
--- @field VocalBuffResourceID FixedString
--- @field VocalCinematicSuffix FixedString
--- @field VocalDeathResourceID FixedString
--- @field VocalDodgeResourceID FixedString
--- @field VocalEffortsResourceID FixedString
--- @field VocalExhaustedResourceID FixedString
--- @field VocalFallResourceID FixedString
--- @field VocalGaspResourceID FixedString
--- @field VocalIdle1ResourceID FixedString
--- @field VocalIdle2ResourceID FixedString
--- @field VocalIdle3ResourceID FixedString
--- @field VocalIdleCombat1ResourceID FixedString
--- @field VocalIdleCombat2ResourceID FixedString
--- @field VocalIdleCombat3ResourceID FixedString
--- @field VocalInitiativeResourceID FixedString
--- @field VocalLaughterManiacalResourceID FixedString
--- @field VocalLaughterResourceID FixedString
--- @field VocalNoneResourceID FixedString
--- @field VocalPainResourceID FixedString
--- @field VocalRebornResourceID FixedString
--- @field VocalRecoverResourceID FixedString
--- @field VocalRelaxedResourceID FixedString
--- @field VocalShoutResourceID FixedString
--- @field VocalSnoreResourceID FixedString
--- @field VocalSpawnResourceID FixedString
--- @field VocalVictoryResourceID FixedString
--- @field VocalWeakResourceID FixedString
--- @field WalkThrough boolean
--- @field WorldClimbingBlendspace_DownA FixedString
--- @field WorldClimbingBlendspace_DownB FixedString
--- @field WorldClimbingBlendspace_DownBHeight number
--- @field WorldClimbingBlendspace_UpA FixedString
--- @field WorldClimbingBlendspace_UpB FixedString
--- @field WorldClimbingBlendspace_UpBHeight number
--- @field WorldClimbingHeight number
--- @field WorldClimbingRadius number
--- @field WorldClimbingSpeed number


--- @class CharacterUnarmedDamageBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam
--- @field DamageType DamageType


--- @class CharacterWeaponDamageBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam
--- @field DamageType DamageType


--- @class ClassTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class ClassesComponent:BaseComponent
--- @field Classes ClassesComponentClass[]


--- @class ClassesComponentClass
--- @field ClassUUID Guid
--- @field Level int32
--- @field SubClassUUID Guid


--- @class ClientControlComponent:BaseComponent


--- @class CombatComponentTemplate
--- @field AiHint Guid
--- @field AiUseCombatHelper FixedString
--- @field Archetype FixedString
--- @field CanFight boolean
--- @field CanJoinCombat boolean
--- @field CombatGroupID FixedString
--- @field CombatName string
--- @field Faction Guid
--- @field IsBoss boolean
--- @field IsInspector boolean
--- @field ProxyAttachment FixedString
--- @field ProxyOwner Guid
--- @field StartCombatRange number
--- @field StayInAiHints boolean
--- @field SwarmGroup FixedString
--- @field Unknown uint8
--- @field Unknown2 uint8


--- @class ConcentrationComponent:BaseComponent
--- @field SpellId SpellId
--- @field field_0 EntityHandle
--- @field field_8 ConcentrationComponentElement[]


--- @class ConcentrationComponentElement
--- @field field_0 EntityHandle
--- @field field_10 EntityHandle
--- @field field_18 int16
--- @field field_1A boolean
--- @field field_8 EntityHandle


--- @class ConcentrationIgnoreDamageBoostComponent:BaseComponent
--- @field SpellSchool SpellSchoolId


--- @class ConditionRoll
--- @field Ability AbilityId
--- @field DataType uint8
--- @field Difficulty int32
--- @field Roll Variant<StatsRollType0,StatsRollType1,>
--- @field RollType ConditionRollType
--- @field Skill SkillId
--- @field field_120 Guid
--- @field field_130 boolean


--- @class CriticalHitBoostComponent:BaseComponent
--- @field Flags CriticalHitBoostFlags
--- @field Value int32
--- @field field_1 uint8


--- @class CriticalHitExtraDiceBoostComponent:BaseComponent
--- @field Amount uint8
--- @field AttackType SpellAttackType


--- @class CustomIconComponent:BaseComponent


--- @class CustomStatsComponent:BaseComponent
--- @field Stats table<FixedString, int32>


--- @class DamageBonusBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam
--- @field DamageType DamageType
--- @field field_31 uint8


--- @class DamageModifierMetadata
--- @field Argument Variant<DiceValues,int32,StatsRollType1,>
--- @field DamageType DamageType
--- @field Description TranslatedString
--- @field MetadataType uint8
--- @field SourceType uint8
--- @field Value int32


--- @class DamagePair
--- @field Amount int32
--- @field DamageType DamageType


--- @class DamageReductionBoostComponent:BaseComponent
--- @field Amount Variant<int32,StatsExpressionParam,>
--- @field DamageType DamageType
--- @field Flat boolean
--- @field Half boolean


--- @class DamageResistance
--- @field Flags uint32
--- @field Meta DamageModifierMetadata


--- @class DamageSums
--- @field DamagePercentage int8
--- @field TotalDamageDone int32
--- @field TotalHealDone int32
--- @field field_9 int8
--- @field field_A int8


--- @class DarknessComponent:BaseComponent
--- @field field_18 uint8
--- @field field_19 uint8
--- @field field_1A uint8
--- @field field_1B uint8
--- @field field_1C uint8
--- @field field_1D uint8
--- @field field_20 int32


--- @class DarkvisionRangeBoostComponent:BaseComponent
--- @field Range number


--- @class DarkvisionRangeMinBoostComponent:BaseComponent
--- @field Range number


--- @class DarkvisionRangeOverrideBoostComponent:BaseComponent
--- @field Range number


--- @class DataComponent:BaseComponent
--- @field StatsId FixedString
--- @field StepsType uint32
--- @field Weight int32


--- @class DelayDeathCauseComponent:BaseComponent
--- @field Blocked_M int32
--- @field DelayCount int32


--- @class DetectCrimesBlockBoostComponent:BaseComponent
--- @field field_0 boolean


--- @class DialogTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class DiceValues
--- @field AmountOfDices uint8
--- @field DiceAdditionalValue int32
--- @field DiceValue DiceSizeId
--- @field field_8 uint8


--- @class DifficultyCheckComponent:BaseComponent
--- @field SpellDC int32
--- @field field_4 int32
--- @field field_8 int32


--- @class DisabledEquipmentComponent:BaseComponent
--- @field ShapeshiftFlag boolean


--- @class DisarmableComponent:BaseComponent
--- @field field_0 Guid
--- @field field_10 uint8
--- @field field_11 uint8


--- @class DisplayNameComponent:BaseComponent
--- @field Name string
--- @field NameKey TranslatedString
--- @field UnknownKey TranslatedString


--- @class DodgeAttackRollBoostComponent:BaseComponent
--- @field StatusGroup StatsStatusGroup
--- @field StatusType StatusType
--- @field field_0 uint8
--- @field field_4 int32


--- @class DownedStatusBoostComponent:BaseComponent
--- @field StatusId FixedString
--- @field field_4 int32


--- @class DualWieldingBoostComponent:BaseComponent
--- @field DualWielding boolean


--- @class DualWieldingComponent:BaseComponent
--- @field field_18 uint8
--- @field field_19 uint8
--- @field field_1A uint8
--- @field field_1B uint8
--- @field field_1C uint8
--- @field field_1D uint8
--- @field field_1E uint8


--- @class EntityThrowDamageBoostComponent:BaseComponent
--- @field Roll DiceValues
--- @field field_C uint8


--- @class EoCGameObjectTemplate:GameObjectTemplate
--- @field CollideWithCamera boolean
--- @field DisplayName TranslatedString
--- @field FadeChildren FixedString[]
--- @field FadeGroup FixedString
--- @field Fadeable boolean
--- @field HierarchyOnlyFade boolean
--- @field SeeThrough boolean


--- @class EoCGameObjectTemplate2:EoCGameObjectTemplate
--- @field AllowCameraMovement boolean
--- @field BlockAoEDamage boolean
--- @field CanClickThrough boolean
--- @field CanClimbOn boolean
--- @field CanShineThrough boolean
--- @field CanShootThrough boolean
--- @field CoverAmount boolean
--- @field HLOD Guid
--- @field IsBlocker boolean
--- @field IsDecorative boolean
--- @field IsPointerBlocker boolean
--- @field LoopSound FixedString
--- @field ReferencedInTimeline boolean
--- @field ShadowPhysicsProxy FixedString
--- @field ShootThroughType uint8
--- @field SoundAttenuation int16
--- @field SoundInitEvent FixedString
--- @field Wadable boolean
--- @field WadableSurfaceType uint8
--- @field WalkOn boolean
--- @field WalkThrough boolean


--- @class EocLevelComponent:BaseComponent
--- @field Level int32


--- @class EquipableComponent:BaseComponent
--- @field Slot ItemSlot
--- @field field_18 Guid


--- @class ExperienceComponent:BaseComponent
--- @field CurrentLevelExperience int32
--- @field NextLevelExperience int32
--- @field SomeExperience int32
--- @field TotalExperience int32
--- @field field_28 uint8


--- @class ExperienceGaveOutComponent:BaseComponent
--- @field Experience int32


--- @class ExpertiseBonusBoostComponent:BaseComponent
--- @field Skill SkillId


--- @class ExpertiseComponent:BaseComponent
--- @field Expertise Array_SkillId


--- @class FTBParticipantComponent:BaseComponent
--- @field field_18 EntityHandle


--- @class FactionOverrideBoostComponent:BaseComponent
--- @field Faction Guid
--- @field field_10 uint8


--- @class FallDamageMultiplierBoostComponent:BaseComponent
--- @field Amount number


--- @class FleeCapabilityComponent:BaseComponent
--- @field field_18 uint8
--- @field field_1C number
--- @field field_20 number


--- @class FloatingComponent:BaseComponent
--- @field field_18 int32
--- @field field_1C int32


--- @class GameObjectTemplate
--- @field AllowReceiveDecalWhenAnimated boolean
--- @field CameraOffset vec3
--- @field CastShadow boolean
--- @field FileName string
--- @field Flags uint32
--- @field GroupID uint32
--- @field HasGameplayValue boolean
--- @field HasParentModRelation boolean
--- @field Id FixedString
--- @field IsDeleted boolean
--- @field IsGlobal boolean
--- @field IsReflecting boolean
--- @field IsShadowProxy boolean
--- @field LevelName FixedString
--- @field Name string
--- @field ParentTemplateId FixedString
--- @field PhysicsOpenTemplate FixedString
--- @field PhysicsTemplate FixedString
--- @field ReceiveDecal boolean
--- @field RenderChannel uint8
--- @field TemplateName FixedString
--- @field Transform Transform
--- @field VisualTemplate FixedString
--- @field field_50 int32


--- @class GameObjectVisualComponent:BaseComponent
--- @field Icon FixedString
--- @field RootTemplateId FixedString
--- @field RootTemplateType uint8
--- @field VisualData GameObjectVisualData
--- @field field_24 number
--- @field field_28 uint8
--- @field field_F0 FixedString


--- @class GameObjectVisualData
--- @field Elements GameObjectVisualDataAppearanceElement[]
--- @field Visuals Guid[]
--- @field field_58 Guid
--- @field field_68 Guid
--- @field field_78 Guid
--- @field field_88 Guid
--- @field field_98 Guid
--- @field field_C8 int32[]


--- @class GameObjectVisualDataAppearanceElement
--- @field Color Guid
--- @field ColorIntensity number
--- @field GlossyTint number
--- @field Material Guid
--- @field MetallicTint uint32


--- @class GameTime
--- @field DeltaTime number
--- @field Ticks int32
--- @field Time number


--- @class GameTimerComponent:BaseComponent
--- @field field_18 FixedString
--- @field field_20 EntityHandle
--- @field field_28 int32
--- @field field_2C int32
--- @field field_30 int32
--- @field field_34 int32
--- @field field_38 uint8


--- @class GameplayLightBoostComponent:BaseComponent
--- @field field_0 int32
--- @field field_4 boolean
--- @field field_8 int32
--- @field field_C uint8


--- @class GameplayLightComponent:BaseComponent
--- @field field_18 int32
--- @field field_1C uint8
--- @field field_20 int32
--- @field field_24 int32
--- @field field_28 int32


--- @class GameplayObscurityBoostComponent:BaseComponent
--- @field Obscurity number


--- @class GlobalLongRestDisabledComponent:BaseComponent


--- @class GlobalShortRestDisabledComponent:BaseComponent


--- @class GlobalSwitches


--- @class GodComponent:BaseComponent
--- @field God Guid


--- @class GravityDisabledComponent:BaseComponent


--- @class GravityDisabledUntilMovedComponent:BaseComponent


--- @class GuaranteedChanceRollOutcomeBoostComponent:BaseComponent
--- @field field_0 boolean


--- @class HalveWeaponDamageBoostComponent:BaseComponent
--- @field Ability AbilityId


--- @class HealthComponent:BaseComponent
--- @field AC int32
--- @field Hp int32
--- @field IsInvulnerable boolean
--- @field MaxHp int32
--- @field MaxTemporaryHp int32
--- @field PerDamageTypeHealthThresholds int32[]
--- @field PerDamageTypeHealthThresholds2 int32[]
--- @field Resistances int32[]
--- @field TemporaryHp int32
--- @field field_38 int32
--- @field field_40 Guid


--- @class HearingComponent:BaseComponent
--- @field FOV number
--- @field Hearing number
--- @field Sight number


--- @class Hit
--- @field ArmorAbsorption int32
--- @field AttackFlags uint8
--- @field AttackRollAbility AbilityId
--- @field AttackType SpellAttackType
--- @field CauseType CauseType
--- @field ConditionRolls ConditionRoll[]
--- @field DamageList DamagePair[]
--- @field DamageType DamageType
--- @field DeathType StatsDeathType
--- @field EffectFlags uint32
--- @field HitDescFlags uint8
--- @field HitWith HitWith
--- @field ImpactDirection vec3
--- @field ImpactForce number
--- @field ImpactPosition vec3
--- @field Inflicter EntityHandle
--- @field InflicterOwner EntityHandle
--- @field LifeSteal int32
--- @field OriginalDamageValue int32
--- @field Results HitResultMetadata
--- @field SaveAbility AbilityId
--- @field SpellCastGuid Guid
--- @field SpellId FixedString
--- @field SpellLevel int32
--- @field SpellPowerLevel int32
--- @field SpellSchool SpellSchoolId
--- @field StoryActionId int32
--- @field Throwing EntityHandle
--- @field TotalDamageDone int32
--- @field TotalHealDone int32
--- @field field_150 FixedString
--- @field field_158 EntityHandle
--- @field field_160 uint8
--- @field field_174 int32
--- @field field_17C int32
--- @field field_180 int32
--- @field field_184 int32
--- @field field_188 number
--- @field field_18C int32
--- @field field_190 vec3[]


--- @class HitResultMetadata
--- @field AdditionalDamage int32
--- @field ConditionRoll StatsRollType1
--- @field DamageRolls table<DamageType, StatsRollType0[]>
--- @field FinalDamage int32
--- @field FinalDamagePerType table<DamageType, int32>
--- @field Modifiers DamageModifierMetadata[]
--- @field Modifiers2 DamageModifierMetadata[]
--- @field Resistances DamageResistance[]
--- @field TotalDamage int32
--- @field TotalDamagePerType table<DamageType, int32>


--- @class HitResult
--- @field DamageList DamagePair[]
--- @field DamageSums DamageSums
--- @field Hit Hit
--- @field NumConditionRolls uint32
--- @field Results HitResultData


--- @class HitResultData
--- @field field_0 int32[]
--- @field field_10 int32[]
--- @field field_20 uint8[]
--- @field field_30 int32[]


--- @class HorizontalFOVOverrideBoostComponent:BaseComponent
--- @field FOV number


--- @class HotbarContainerComponent:BaseComponent
--- @field ActiveContainer FixedString
--- @field Containers table<FixedString, HotbarContainerComponentBar[]>


--- @class HotbarContainerComponentBar
--- @field Elements HotbarContainerComponentElement[]
--- @field Index uint8
--- @field field_1 uint8
--- @field field_18 uint8
--- @field field_1C uint32
--- @field field_20 string


--- @class HotbarContainerComponentElement
--- @field Item EntityHandle
--- @field Passive FixedString
--- @field SpellId SpellId
--- @field field_34 uint32
--- @field field_38 uint8


--- @class IconComponent:BaseComponent
--- @field Icon FixedString


--- @class IgnoreDamageThresholdMinBoostComponent:BaseComponent
--- @field All boolean
--- @field Amount int32
--- @field DamageType DamageType


--- @class IgnoreLowGroundPenaltyBoostComponent:BaseComponent
--- @field RollType StatsRollType


--- @class IgnorePointBlankDisadvantageBoostComponent:BaseComponent
--- @field Flags WeaponFlags


--- @class IgnoreResistanceBoostComponent:BaseComponent
--- @field DamageType DamageType
--- @field Flags ResistanceBoostFlags


--- @class IgnoreSurfaceCoverBoostComponent:BaseComponent
--- @field SurfaceType SurfaceType


--- @class IncreaseMaxHPComponent:BaseComponent
--- @field Amount Variant<int32,StatsExpressionParam,>
--- @field field_30 int32


--- @class InitiativeBoostComponent:BaseComponent
--- @field Amount int32


--- @class InteractionFilterComponent:BaseComponent
--- @field field_0 Array_Guid
--- @field field_30 uint8
--- @field field_31 uint8


--- @class InvisibilityComponent:BaseComponent
--- @field field_0 uint8
--- @field field_10 uint8
--- @field field_4 vec3


--- @class IsGlobalComponent:BaseComponent


--- @class IsInTurnBasedModeComponent:BaseComponent


--- @class IsSummonComponent:BaseComponent
--- @field Owner_M EntityHandle


--- @class IsUnsummoningComponent:BaseComponent


--- @class ItemBoostsComponent:BaseComponent
--- @field Boosts EntityHandle[]


--- @class ItemTemplate:EoCGameObjectTemplate2
--- @field ActivationGroupId FixedString
--- @field AllowSummonTeleport boolean
--- @field Amount int32
--- @field AnubisConfigName FixedString
--- @field AttackableWhenClickThrough boolean
--- @field BloodSurfaceType uint8
--- @field BloodType FixedString
--- @field BookType uint8
--- @field CanBeImprovisedWeapon boolean
--- @field CanBeMoved boolean
--- @field CanBePickedUp boolean
--- @field CanBePickpocketed boolean
--- @field CinematicArenaFlags uint32
--- @field ColorPreset Guid
--- @field CombatComponent CombatComponentTemplate
--- @field ConstellationConfigName FixedString
--- @field ContainerAutoAddOnPickup boolean
--- @field ContainerContentFilterCondition string
--- @field CriticalHitType FixedString
--- @field DefaultState FixedString
--- @field Description TranslatedString
--- @field DestroyWithStack boolean
--- @field Destroyed boolean
--- @field DisarmDifficultyClassID Guid
--- @field DisplayNameAlchemy TranslatedString
--- @field DropSound FixedString
--- @field EquipSound FixedString
--- @field EquipmentTypeID Guid
--- @field ExamineRotation vec3
--- @field ExcludeInDifficulty Guid[]
--- @field ForceAffectedByAura boolean
--- @field GravityType uint8
--- @field Hostile boolean
--- @field Icon FixedString
--- @field IgnoreGenerics boolean
--- @field ImpactSound FixedString
--- @field InteractionFilterList Array_Guid
--- @field InteractionFilterRequirement uint8
--- @field InteractionFilterType uint8
--- @field InventoryList FixedString[]
--- @field InventoryMoveSound FixedString
--- @field InventoryType uint8
--- @field IsBlueprintDisabledByDefault boolean
--- @field IsDroppedOnDeath boolean
--- @field IsInteractionDisabled boolean
--- @field IsKey boolean
--- @field IsPlatformOwner boolean
--- @field IsPortal boolean
--- @field IsPortalProhibitedToPlayers boolean
--- @field IsPublicDomain boolean
--- @field IsSourceContainer boolean
--- @field IsSurfaceBlocker boolean
--- @field IsSurfaceCloudBlocker boolean
--- @field IsTradable uint8
--- @field IsTrap boolean
--- @field Key FixedString
--- @field LightChannel uint8
--- @field LockDifficultyClassID Guid
--- @field MaterialPreset Guid
--- @field MaxStackAmount int32
--- @field OnUseDescription TranslatedString
--- @field OnlyInDifficulty Guid[]
--- @field Owner FixedString
--- @field PermanentWarnings FixedString
--- @field PhysicsCollisionSound FixedString
--- @field PhysicsFollowAnimation boolean
--- @field PickupSound FixedString
--- @field Race int32
--- @field ShortDescription TranslatedString
--- @field ShortDescriptionParams string
--- @field ShowAttachedSpellDescriptions boolean
--- @field SpeakerGroups Array_Guid
--- @field Stats FixedString
--- @field StatusList FixedString[]
--- @field StoryItem boolean
--- @field TechnicalDescription TranslatedString
--- @field TechnicalDescriptionParams string
--- @field TimelineCameraRigOverride Guid
--- @field Tooltip uint32
--- @field TreasureLevel int32
--- @field TreasureOnDestroy boolean
--- @field UnequipSound FixedString
--- @field Unimportant boolean
--- @field UnknownDescription TranslatedString
--- @field UnknownDisplayName TranslatedString
--- @field UseOcclusion boolean
--- @field UseOnDistance boolean
--- @field UsePartyLevelForTreasureLevel boolean
--- @field UseRemotely boolean
--- @field UseSound FixedString
--- @field V4_0_0_26Flag boolean


--- @class JumpMaxDistanceBonusBoostComponent:BaseComponent
--- @field DistanceBonus number


--- @class JumpMaxDistanceMultiplierBoostComponent:BaseComponent
--- @field Amount number


--- @class LeaderComponent:BaseComponent
--- @field Followers_M Array_EntityHandle


--- @class LevelComponent:BaseComponent
--- @field LevelName FixedString
--- @field field_0 EntityHandle


--- @class LevelUpComponent:BaseComponent
--- @field field_18 LevelUpData[]


--- @class LevelUpData
--- @field Abilities int32[]
--- @field AccessorySet Guid
--- @field Class Guid
--- @field Feat Guid
--- @field SubClass Guid
--- @field Upgrades LevelUpUpgrades
--- @field field_B0 LevelUpData3[]


--- @class LevelUpData3
--- @field _Pad uint64
--- @field field_0 FixedString
--- @field field_10 Guid
--- @field field_4 uint8


--- @class LevelUpUpgrades
--- @field AbilityBonuses LevelUpUpgradesAbilityBonusData[]
--- @field Feats LevelUpUpgradesFeatData[]
--- @field Skills LevelUpUpgradesSkillData[]
--- @field Spells LevelUpUpgradesSpellData[]
--- @field Spells2 LevelUpUpgradesSpell2Data[]
--- @field Unknowns2 LevelUpUpgradesUnknown2Data[]
--- @field Unknowns4 LevelUpUpgradesUnknown4[]


--- @class LevelUpUpgradesAbilityBonusData:LevelUpUpgradesReference
--- @field AbilityBonus Guid
--- @field Array_b8 uint8[]
--- @field Array_i32 uint32[]
--- @field field_30 int32
--- @field field_60 string
--- @field field_80 int32


--- @class LevelUpUpgradesFeatData:LevelUpUpgradesReference
--- @field Array_b8 uint8[]
--- @field Feat Guid
--- @field FeatName string
--- @field field_30 int32
--- @field field_80 int32


--- @class LevelUpUpgradesReference
--- @field Class Guid
--- @field Subclass Guid
--- @field field_0 uint8
--- @field field_28 int32
--- @field field_2C uint8


--- @class LevelUpUpgradesSkillData:LevelUpUpgradesReference
--- @field Array_b8 uint8[]
--- @field Skill Guid
--- @field field_30 int32
--- @field field_60 string
--- @field field_80 int32


--- @class LevelUpUpgradesSpell2Data:LevelUpUpgradesReference
--- @field Array_FS2 LevelUpUpgradesSpell2DataStringPair[]
--- @field SpellList Guid
--- @field Spells FixedString[]
--- @field field_30 int32
--- @field field_78 string
--- @field field_80 int32


--- @class LevelUpUpgradesSpell2DataStringPair
--- @field A FixedString
--- @field B FixedString


--- @class LevelUpUpgradesSpellData:LevelUpUpgradesReference
--- @field Array_FS2 LevelUpUpgradesSpellDataStringPair[]
--- @field SpellList Guid
--- @field Spells FixedString[]
--- @field field_30 int32
--- @field field_78 string


--- @class LevelUpUpgradesSpellDataStringPair
--- @field A FixedString
--- @field B FixedString


--- @class LevelUpUpgradesUnknown2Data:LevelUpUpgradesReference
--- @field Array_b8 uint8[]
--- @field field_30 int32
--- @field field_38 Guid
--- @field field_48 uint8
--- @field field_60 string
--- @field field_80 int32


--- @class LevelUpUpgradesUnknown4:LevelUpUpgradesReference
--- @field Array_FS FixedString[]
--- @field field_30 int32
--- @field field_38 Guid
--- @field field_60 string
--- @field field_80 int32


--- @class LockBoostComponent:BaseComponent
--- @field Lock Guid


--- @class LockComponent:BaseComponent
--- @field Key_M FixedString
--- @field LockDC int32
--- @field field_18 Guid[]
--- @field field_8 Guid


--- @class LootComponent:BaseComponent
--- @field Flags uint8
--- @field InventoryType uint8


--- @class LootingStateComponent:BaseComponent
--- @field Looter_M EntityHandle
--- @field State uint8
--- @field field_24 int32


--- @class MaterialParameterOverrideComponent:BaseComponent
--- @field field_0 Guid[]
--- @field field_10 MaterialParameterOverrideComponentParam[]


--- @class MaterialParameterOverrideComponentParam
--- @field field_0 string
--- @field field_18 FixedString


--- @class MaximizeHealingBoostComponent:BaseComponent
--- @field Direction HealDirection
--- @field TargetTypes StatsTargetTypeFlags


--- @class MaximumRollResultBoostComponent:BaseComponent
--- @field Result int8
--- @field RollType StatsRollType


--- @class MinimumRollResultBoostComponent:BaseComponent
--- @field Result int8
--- @field RollType StatsRollType


--- @class ModManager
--- @field AvailableMods Module[]
--- @field BaseModule Module
--- @field Flag uint8
--- @field Settings ModuleSettings
--- @field Unknown uint64


--- @class Module
--- @field AddonModules Module[]
--- @field ContainedModules Module[]
--- @field DependentModules Module[]
--- @field FinishedLoading boolean
--- @field HasValidHash boolean
--- @field Info ModuleInfo
--- @field LoadOrderedModules Module[]
--- @field UsesLsfFormat boolean


--- @class ModuleInfo
--- @field Author string
--- @field CharacterCreationLevelName FixedString
--- @field Description string
--- @field Directory string
--- @field Hash string
--- @field LobbyLevelName FixedString
--- @field MainMenuBackgroundVideo FixedString
--- @field MenuLevelName FixedString
--- @field ModVersion Version
--- @field ModuleType FixedString
--- @field ModuleUUID Guid
--- @field ModuleUUIDString FixedString
--- @field Name string
--- @field NumPlayers uint8
--- @field PhotoBoothLevelName FixedString
--- @field PublishVersion Version
--- @field StartLevelName FixedString
--- @field Tags string[]
--- @field TargetModes FixedString[]

--- Separate from ModuleInfo, this is a table with specific keys.  
--- @class LegacyModuleInfo
--- @field UUID FixedString
--- @field Name string
--- @field Description string
--- @field Directory string
--- @field ModuleType FixedString
--- @field Version integer
--- @field PublishVersion integer
--- @field Dependencies FixedString[]



--- @class ModuleSettings
--- @field ModOrder FixedString[]
--- @field Mods ModuleShortDesc[]


--- @class ModuleShortDesc
--- @field Folder string
--- @field Hash string
--- @field ModVersion Version
--- @field ModuleUUID FixedString
--- @field Name string
--- @field PublishVersion Version


--- @class MonkWeaponDamageDiceOverrideBoostComponent:BaseComponent
--- @field DamageDice FixedString


--- @class MovementComponent:BaseComponent
--- @field field_18 number
--- @field field_1C number
--- @field field_20 number
--- @field field_24 number
--- @field field_28 int32
--- @field field_2C int32


--- @class MovementSpeedLimitBoostComponent:BaseComponent
--- @field MovementType uint8


--- @class NetComponent:BaseComponent


--- @class NullifyAbilityBoostComponent:BaseComponent
--- @field Ability AbilityId


--- @class ObjectInteractionComponent:BaseComponent
--- @field Interactions EntityHandle[]


--- @class ObjectSizeBoostComponent:BaseComponent
--- @field SizeCategoryAdjustment int32


--- @class ObjectSizeComponent:BaseComponent
--- @field Size uint8
--- @field field_1 uint8


--- @class ObjectSizeOverrideBoostComponent:BaseComponent
--- @field field_0 uint8


--- @class OffStageComponent:BaseComponent


--- @class OriginComponent:BaseComponent
--- @field Origin FixedString
--- @field field_18 Guid


--- @class OriginPassivesComponent:BaseComponent
--- @field field_18 PassiveInfo[]


--- @class OriginTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class OsirisTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class PassiveComponent:BaseComponent
--- @field PassiveId FixedString
--- @field field_0 uint8
--- @field field_10 EntityHandle
--- @field field_18 uint8
--- @field field_19 uint8
--- @field field_1C uint32
--- @field field_8 EntityHandle


--- @class PassiveContainerComponent:BaseComponent
--- @field Passives EntityHandle[]


--- @class PassiveInfo
--- @field Passive uint32
--- @field field_0 uint32


--- @class PathingComponent:BaseComponent
--- @field PathParameters table<FixedString, PathingComponentParam>
--- @field VectorParameters table<FixedString, vec4>
--- @field field_20 int64
--- @field field_28 int32
--- @field field_2C FixedString
--- @field field_30 int64
--- @field field_38 int32
--- @field field_3C int32
--- @field field_40 uint8
--- @field field_44 number
--- @field field_48 int32
--- @field field_4C uint8


--- @class PathingComponentParam
--- @field Values1 int32[]
--- @field Values2 number[]
--- @field Values3 vec3[]
--- @field field_30 int32


--- @class PhysicalForceRangeBonusBoostComponent:BaseComponent
--- @field field_0 number
--- @field field_4 uint8


--- @class PhysicsComponent:BaseComponent


--- @class PickingStateComponent:BaseComponent


--- @class PickpocketComponent:BaseComponent
--- @field field_18 PickpocketComponentPickpocketEntry[]


--- @class PickpocketComponentPickpocketEntry
--- @field field_0 EntityHandle
--- @field field_10 int32
--- @field field_14 boolean
--- @field field_18 EntityHandle
--- @field field_8 EntityHandle


--- @class PlayerComponent:BaseComponent


--- @class ProficiencyBonusBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field Skill SkillId
--- @field Type ProficiencyBonusBoostType


--- @class ProficiencyBonusOverrideBoostComponent:BaseComponent
--- @field Value StatsExpressionParam


--- @class ProficiencyBoostComponent:BaseComponent
--- @field Flags ProficiencyGroupFlags


--- @class ProgressionContainerComponent:BaseComponent
--- @field Progressions EntityHandle[][]


--- @class ProgressionMetaComponent:BaseComponent
--- @field Owner EntityHandle
--- @field Progression Guid
--- @field Race Guid
--- @field field_18 uint8
--- @field field_40 int32
--- @field field_44 uint8
--- @field field_48 int32


--- @class ProjectileDeflectBoostComponent:BaseComponent
--- @field ProjectileTypes ProjectileTypeIds


--- @class ProjectileTemplate:EoCGameObjectTemplate
--- @field Acceleration number
--- @field BeamFX FixedString
--- @field CastBone FixedString
--- @field DestroyTrailFXOnImpact boolean
--- @field DetachBeam boolean
--- @field GroundImpactFX string
--- @field IgnoreRoof boolean
--- @field ImpactFX FixedString
--- @field LifeTime number
--- @field MaxPathRadius number
--- @field MinPathRadius number
--- @field NeedsImpactSFX boolean
--- @field PathMaxArcDist number
--- @field PathMinArcDist number
--- @field PathRadius number
--- @field PathRepeat int32
--- @field PathShift number
--- @field PreviewPathImpactFX FixedString
--- @field PreviewPathMaterial FixedString
--- @field PreviewPathRadius number
--- @field ProjectilePath uint8
--- @field RotateImpact boolean
--- @field Speed number
--- @field TrailFX FixedString


--- @class RaceComponent:BaseComponent
--- @field Race Guid


--- @class RaceTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class RecruitedByComponent:BaseComponent
--- @field RecruitedBy EntityHandle


--- @class RedirectDamageBoostComponent:BaseComponent
--- @field Amount int32
--- @field DamageType1 DamageType
--- @field DamageType2 DamageType
--- @field field_6 boolean


--- @class ReduceCriticalAttackThresholdBoostComponent:BaseComponent
--- @field field_0 int32
--- @field field_4 int32
--- @field field_8 int64


--- @class RelationComponent:BaseComponent
--- @field field_0 table<uint32, uint8>
--- @field field_100 table<uint32, uint8>
--- @field field_140 Array_uint32
--- @field field_170 Array_uint32
--- @field field_40 table<uint32, uint8>
--- @field field_80 table<uint32, uint8>
--- @field field_C0 table<RelationComponentGuidAndHandle, uint8>


--- @class RelationComponentGuidAndHandle
--- @field field_0 Guid
--- @field field_10 EntityHandle


--- @class RerollBoostComponent:BaseComponent
--- @field RollType StatsRollType
--- @field field_1 int8
--- @field field_2 boolean


--- @class ResistanceBoostComponent:BaseComponent
--- @field DamageType DamageType
--- @field IsResistantToAll boolean
--- @field ResistanceFlags ResistanceBoostFlags


--- @class ResolvedRollBonus
--- @field Description TranslatedString
--- @field DiceSize DiceSizeId
--- @field NumDice uint8
--- @field ResolvedRollBonus int32


--- @class ResolvedUnknown
--- @field Description TranslatedString
--- @field field_0 int32


--- @class Resource


--- @class ResourceRollDefinition
--- @field field_0 Guid
--- @field field_10 uint8


--- @class RollBonusBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field Amount StatsExpressionParam
--- @field RollType StatsRollType
--- @field Skill SkillId


--- @class RuntimeStringHandle
--- @field Handle FixedString
--- @field Version uint16


--- @class SafePositionComponent:BaseComponent
--- @field Position vec3
--- @field field_24 boolean


--- @class SavantBoostComponent:BaseComponent
--- @field SpellSchool SpellSchoolId


--- @class SavegameComponent:BaseComponent


--- @class ScaleMultiplierBoostComponent:BaseComponent
--- @field Multiplier number


--- @class ShortRestComponent:BaseComponent
--- @field StateId uint8


--- @class SightRangeAdditiveBoostComponent:BaseComponent
--- @field Range number


--- @class SightRangeMaximumBoostComponent:BaseComponent
--- @field Range number


--- @class SightRangeMinimumBoostComponent:BaseComponent
--- @field Range number


--- @class SightRangeOverrideBoostComponent:BaseComponent
--- @field Range number


--- @class SimpleCharacterComponent:BaseComponent


--- @class SkillBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam
--- @field Skill SkillId


--- @class SomeSharedServerClientObjId
--- @field field_0 int64
--- @field field_8 int32


--- @class SomeSharedServerClientObjId2:SomeSharedServerClientObjId
--- @field field_10 int64
--- @field field_18 int32


--- @class SourceAdvantageBoostComponent:BaseComponent
--- @field Type SourceAdvantageType


--- @class SpeakerComponent:BaseComponent
--- @field field_0 FixedString[]


--- @class SpellId
--- @field OriginatorPrototype FixedString
--- @field ProgressionSource Guid
--- @field Prototype FixedString
--- @field SourceType SpellSourceType


--- @class SpellIdBase
--- @field OriginatorPrototype FixedString
--- @field ProgressionSource Guid
--- @field SourceType SpellSourceType


--- @class SpellIdWithPrototype:SpellId
--- @field SpellCastSource Guid|nil
--- @field SpellProto StatsSpellPrototype


--- @class SpellResistanceBoostComponent:BaseComponent
--- @field Resistance ResistanceBoostFlags


--- @class SpellSaveDCBoostComponent:BaseComponent
--- @field DC int32


--- @class StaticPhysicsComponent:BaseComponent


--- @class StatsComponent:BaseComponent
--- @field Abilities int32[]
--- @field AbilityModifiers int32[]
--- @field ArmorType int32
--- @field ArmorType2 int32
--- @field ProficiencyBonus int32
--- @field RangedAttackAbility AbilityId
--- @field Skills int32[]
--- @field SpellCastingAbility AbilityId
--- @field UnarmedAttackAbility AbilityId
--- @field field_0 int32
--- @field field_8C int32
--- @field field_90 int32


--- @class StatsExpressionParam
--- @field Code string
--- @field Params Variant<uint8,Variant<uint8,AbilityId,SkillId,uint8,STDString,>,uint8,uint8,DiceValues,ResourceRollDefinition,uint8,int32,bool,>[]


--- @class StatsExpressionParamEx:StatsExpressionParam


--- @class StatsRollMetadata
--- @field AbilityBoosts table<AbilityId, int32>
--- @field AutoAbilityCheckFail boolean
--- @field AutoAbilitySavingThrowFail boolean
--- @field AutoSkillCheckFail boolean
--- @field HasCustomMetadata boolean
--- @field IsCritical boolean
--- @field ProficiencyBonus int32
--- @field ResolvedRollBonuses ResolvedRollBonus[]
--- @field ResolvedUnknowns ResolvedUnknown[]
--- @field RollBonus int32
--- @field SkillBonuses table<SkillId, int32>
--- @field field_10 int32
--- @field field_14 int32
--- @field field_8 int64


--- @class StatsRollResult
--- @field Critical boolean
--- @field DiceSize uint32
--- @field DiscardedDiceTotal int32
--- @field NaturalRoll int32
--- @field Total int32
--- @field field_14 uint8
--- @field field_18 int16[]


--- @class StatsRollRoll
--- @field Advantage boolean
--- @field Disadvantage boolean
--- @field Roll DiceValues
--- @field RollType StatsRollType
--- @field field_10 int16[]


--- @class StatsRollType0
--- @field Metadata StatsRollMetadata
--- @field Result StatsRollResult
--- @field Roll StatsRollRoll


--- @class StatsRollType1
--- @field DamageTypeIndex int32
--- @field DamageTypeParams DamageType[]
--- @field IntIndex int32
--- @field IntParams int32[]
--- @field RollIndex int32
--- @field RollParams StatsRollType0[]
--- @field StatExpression string


--- @class StatusImmunitiesComponent:BaseComponent
--- @field PersonalStatusImmunities table<FixedString, Guid>


--- @class StatusImmunityBoostComponent:BaseComponent
--- @field StatusID FixedString
--- @field UnknownUUIDs Guid[]


--- @class StealthComponent:BaseComponent
--- @field Position vec3
--- @field SeekHiddenFlag boolean
--- @field SeekHiddenTimeout number
--- @field field_2C int32


--- @class SteeringComponent:BaseComponent
--- @field field_0 vec3
--- @field field_10 number
--- @field field_14 uint8
--- @field field_18 number
--- @field field_1C uint8
--- @field field_C number


--- @class StoryShortRestDisabledComponent:BaseComponent


--- @class SummonContainerComponent:BaseComponent
--- @field Characters Array_EntityHandle
--- @field Items Array_EntityHandle
--- @field field_18 table<FixedString, EntityHandle[]>


--- @class SummonLifetimeComponent:BaseComponent
--- @field Lifetime number


--- @class SurfacePathInfluence
--- @field Influence int32
--- @field IsCloud boolean
--- @field SurfaceType SurfaceType


--- @class SurfacePathInfluencesComponent:BaseComponent
--- @field PathInfluences SurfacePathInfluence[]


--- @class SurfaceTemplate:GameObjectTemplate
--- @field AiPathColor vec3
--- @field AiPathIconFX FixedString
--- @field AlwaysUseDefaultLifeTime boolean
--- @field CanEnterCombat boolean
--- @field CanSeeThrough boolean
--- @field CanShootThrough boolean
--- @field DecalMaterial FixedString
--- @field DefaultLifeTime number
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field FX SurfaceTemplateVisualData[]
--- @field FadeInSpeed number
--- @field FadeOutSpeed number
--- @field FallDamageMultiplier number
--- @field InstanceVisual SurfaceTemplateVisualData[]
--- @field IntroFX SurfaceTemplateVisualData[]
--- @field MaterialType uint8
--- @field NormalBlendingFactor number
--- @field ObscuredStateOverride uint8
--- @field OnEnterDistanceOverride number
--- @field OnMoveDistanceOverride number
--- @field RemoveDestroyedItems boolean
--- @field RollConditions string
--- @field Seed int32
--- @field Statuses SurfaceTemplateStatusData[]
--- @field Summon FixedString
--- @field SurfaceCategory uint8
--- @field SurfaceGrowTimer number
--- @field SurfaceName FixedString
--- @field SurfaceType SurfaceType
--- @field field_188 uint32


--- @class SurfaceTemplateStatusData
--- @field AffectedByRoll boolean
--- @field ApplyToCharacters boolean
--- @field ApplyToItems boolean
--- @field ApplyTypes uint8
--- @field Chance number
--- @field Duration number
--- @field Force boolean
--- @field KeepAlive boolean
--- @field OnlyOncePerTurn boolean
--- @field Remove boolean
--- @field StatusId FixedString
--- @field VanishOnApply boolean


--- @class SurfaceTemplateVisualData
--- @field GridSize number
--- @field Height vec2
--- @field RandomPlacement int32
--- @field Rotation ivec2
--- @field Scale vec2
--- @field SpawnCell int32
--- @field SurfaceNeeded int32
--- @field SurfaceRadiusMax int32
--- @field Visual FixedString


--- @class TagComponent:BaseComponent
--- @field Tags Guid[]


--- @class TemplateTagComponent:BaseComponent
--- @field Tags Guid[]


--- @class TemporaryHPBoostComponent:BaseComponent
--- @field HP StatsExpressionParam


--- @class ToggledPassivesComponent:BaseComponent
--- @field Passives table<FixedString, boolean>


--- @class Transform
--- @field Scale vec3
--- @field Translate vec3


--- @class TransformComponent:BaseComponent
--- @field Transform Transform


--- @class TranslatedString
--- @field ArgumentString RuntimeStringHandle
--- @field Handle RuntimeStringHandle


--- @class TypeInformation
--- @field ElementType TypeInformationRef
--- @field EnumValues table<FixedString, uint64>
--- @field HasWildcardProperties boolean
--- @field IsBuiltin boolean
--- @field KeyType TypeInformationRef
--- @field Kind LuaTypeId
--- @field Members table<FixedString, TypeInformationRef>
--- @field Methods table<FixedString, TypeInformation>
--- @field ModuleRole FixedString
--- @field NativeName FixedString
--- @field Params TypeInformationRef[]
--- @field ParentType TypeInformationRef
--- @field ReturnValues TypeInformationRef[]
--- @field TypeName FixedString
--- @field VarargParams boolean
--- @field VarargsReturn boolean


--- @class TypeInformationRef:TypeInformation


--- @class UnlockInterruptBoostComponent:BaseComponent
--- @field Interrupt FixedString


--- @class UnlockSpellBoostComponent:BaseComponent
--- @field Ability AbilityId
--- @field CooldownType SpellCooldownType
--- @field SomeUUID Guid
--- @field SpellChildSelection SpellChildSelectionType
--- @field SpellId FixedString


--- @class UnlockSpellVariantBoostComponent:BaseComponent
--- @field Modifications Variant<SpellModificationModifyAreaRadius,SpellModificationModifyMaximumTargets,SpellModificationModifyNumberOfTargets,SpellModificationModifySavingThrowDisadvantage,SpellModificationModifySpellFlags,SpellModificationModifySpellRoll,SpellModificationModifyStatusDuration,SpellModificationModifySummonDuration,SpellModificationModifySurfaceDuration,SpellModificationModifyTargetRadius,SpellModificationModifyUseCosts,SpellModificationModifyVisuals,SpellModificationModifyIconGlow,SpellModificationModifyTooltipDescription,>[]
--- @field Spell string


--- @class UseBoostsComponent:BaseComponent
--- @field Boosts BoostParameters[]


--- @class UseComponent:BaseComponent
--- @field Boosts BoostParameters[]
--- @field BoostsOnEquipMainHand BoostParameters[]
--- @field BoostsOnEquipOffHand BoostParameters[]
--- @field Charges int32
--- @field ItemUseType uint8
--- @field MaxCharges int32
--- @field Requirements StatsRequirement[]
--- @field field_19 uint8
--- @field field_1A uint8
--- @field field_1B uint8


--- @class UuidComponent:BaseComponent
--- @field EntityUuid Guid


--- @class UuidToHandleMappingComponent:BaseComponent
--- @field Mappings table<Guid, EntityHandle>


--- @class ValueComponent:BaseComponent
--- @field Rarity uint8
--- @field Unique boolean
--- @field Value int32


--- @class VisualComponent:BaseComponent
--- @field field_18 int64
--- @field field_20 uint8
--- @field field_21 uint8


--- @class VoiceComponent:BaseComponent
--- @field Voice Guid


--- @class WeaponAttackRollAbilityOverrideBoostComponent:BaseComponent
--- @field Ability AbilityId


--- @class WeaponAttackRollBonusBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam


--- @class WeaponAttackTypeOverrideBoostComponent:BaseComponent
--- @field AttackType SpellAttackType


--- @class WeaponComponent:BaseComponent
--- @field Ability AbilityId
--- @field DamageDice DiceSizeId
--- @field DamageRange number
--- @field Rolls table<AbilityId, DiceValues[]>
--- @field Rolls2 table<AbilityId, DiceValues[]>
--- @field VersatileDamageDice DiceSizeId
--- @field WeaponGroup uint8
--- @field WeaponProperties uint32
--- @field WeaponRange number
--- @field field_38 WeaponComponentElement1[]


--- @class WeaponComponentElement1:StatsExpressionParam
--- @field Cause BoostCause
--- @field field_28 uint8
--- @field field_48 TranslatedString
--- @field field_58 uint8


--- @class WeaponDamageBoostComponent:BaseComponent
--- @field Amount StatsExpressionParam
--- @field DamageType DamageType
--- @field field_30 boolean


--- @class WeaponDamageDieOverrideBoostComponent:BaseComponent
--- @field Roll DiceValues


--- @class WeaponDamageResistanceBoostComponent:BaseComponent
--- @field DamageTypes DamageType[]


--- @class WeaponDamageTypeOverrideBoostComponent:BaseComponent
--- @field DamageType DamageType


--- @class WeaponEnchantmentBoostComponent:BaseComponent
--- @field Value int32


--- @class WeaponPropertyBoostComponent:BaseComponent
--- @field Properties WeaponFlags


--- @class WeaponSetComponent:BaseComponent


--- @class WeightBoostComponent:BaseComponent
--- @field Amount int32


--- @class WeightCategoryBoostComponent:BaseComponent
--- @field Amount int32


--- @class WieldingComponent:BaseComponent
--- @field Owner EntityHandle


--- @class CombatIsInCombatComponent:BaseComponent


--- @class CombatParticipantComponent:BaseComponent
--- @field AiHint Guid
--- @field CombatGroupId FixedString
--- @field CombatHandle EntityHandle
--- @field Flags CombatParticipantFlags
--- @field field_C int32


--- @class CombatStateComponent:BaseComponent
--- @field Initiatives table<EntityHandle, int32>
--- @field Level FixedString
--- @field MyGuid Guid
--- @field Participants EntityHandle[]
--- @field field_98 EntityHandle
--- @field field_A0 EntityHandle
--- @field field_AC uint8
--- @field field_B0 number
--- @field field_B8 EntityHandle[]
--- @field field_D0 uint8


--- @class CombatTurnBasedComponent:BaseComponent
--- @field ActedThisRoundInCombat boolean
--- @field CanAct_M boolean
--- @field Combat Guid
--- @field Entity EntityHandle
--- @field HadTurnInCombat boolean
--- @field IsInCombat_M boolean
--- @field RequestedEndTurn boolean
--- @field field_10 int32
--- @field field_18 int32
--- @field field_1C uint8
--- @field field_20 int32
--- @field field_24 uint8
--- @field field_28 uint64
--- @field field_8 uint8
--- @field field_A boolean
--- @field field_C boolean


--- @class CombatTurnOrderComponent:BaseComponent
--- @field Participants CombatTurnOrderComponentParticipant[]
--- @field Participants2 CombatTurnOrderComponentParticipant[]
--- @field TurnOrderIndices uint64[]
--- @field TurnOrderIndices2 uint64[]
--- @field field_78 int32
--- @field field_7C int32


--- @class CombatTurnOrderComponentParticipant
--- @field Handles CombatTurnOrderComponentParticipantHandleInfo[]
--- @field Initiative int32
--- @field Participant Guid
--- @field field_28 uint32
--- @field field_30 uint8


--- @class CombatTurnOrderComponentParticipantHandleInfo
--- @field Entity EntityHandle
--- @field Initiative int32


--- @class EclLuaGameStateChangeEvent:LuaEventBase
--- @field FromState ClientGameState
--- @field ToState ClientGameState


--- @class EocPlayerCustomData
--- @field Initialized boolean
--- @field OwnerProfileID FixedString
--- @field ReservedProfileID FixedString


--- @class EsvAnubisExecutorComponent:BaseComponent
--- @field field_18 int64
--- @field field_20 int64
--- @field field_28 uint8
--- @field field_29 uint8


--- @class EsvChangeSurfaceOnPathAction:EsvCreateSurfaceActionBase
--- @field CheckExistingSurfaces boolean
--- @field FollowHandle EntityRef
--- @field IgnoreIrreplacableSurfaces boolean
--- @field IgnoreOwnerCells boolean
--- @field IsFinished boolean
--- @field Radius number


--- @class EsvCharacter
--- @field Activated boolean
--- @field BlockNewDisturbanceReactions boolean
--- @field CanGossip boolean
--- @field CanShootThrough boolean
--- @field CannotAttachToGroups boolean
--- @field CannotDie boolean
--- @field CannotMove boolean
--- @field CannotRun boolean
--- @field CharCreationInProgress boolean
--- @field CharacterControl boolean
--- @field CharacterCreationFinished boolean
--- @field CoverAmount boolean
--- @field CreatedTemplateItems FixedString[]
--- @field CrimeHandle int32
--- @field CrimeState uint8
--- @field CrimeWarningsEnabled boolean
--- @field CustomLookEnabled boolean
--- @field CustomTradeTreasure FixedString
--- @field Deactivated boolean
--- @field Dead boolean
--- @field DeferredRemoveEscapist boolean
--- @field Detached boolean
--- @field Dialog int32
--- @field DisableCulling boolean
--- @field DisableWaypointUsage boolean
--- @field DisabledCrime FixedString[]
--- @field DoNotFaceFlag boolean
--- @field DontCacheTemplate boolean
--- @field EnemyCharacter EntityHandle
--- @field FightMode boolean
--- @field FindValidPositionOnActivate boolean
--- @field Flags ServerCharacterFlags
--- @field Flags2 ServerCharacterFlags2
--- @field Flags3 ServerCharacterFlags3
--- @field Floating boolean
--- @field FollowCharacter EntityHandle
--- @field ForceNonzeroSpeed boolean
--- @field ForceSynch uint8
--- @field GMReroll boolean
--- @field Global boolean
--- @field HasOsirisDialog uint8
--- @field HasOwner boolean
--- @field HostControl boolean
--- @field IgnoresTriggers boolean
--- @field InDialog boolean
--- @field InParty boolean
--- @field Inventory EntityHandle
--- @field InvestigationTimer number
--- @field Invisible boolean
--- @field Invulnerable boolean
--- @field IsCompanion_M boolean
--- @field IsHuge boolean
--- @field IsPet boolean
--- @field IsPlayer boolean
--- @field IsResurrected boolean
--- @field IsTrading boolean
--- @field Level FixedString
--- @field LevelTransitionPending boolean
--- @field Loaded boolean
--- @field Multiplayer boolean
--- @field MyHandle EntityRef
--- @field NeedsMakePlayerUpdate boolean
--- @field NeedsPlacementSnapping boolean
--- @field NeedsUpdate uint8
--- @field NumConsumables uint8
--- @field OffStage boolean
--- @field OriginalTemplate CharacterTemplate
--- @field OwnerCharacter EntityHandle
--- @field PartyFollower boolean
--- @field PlayerData EsvPlayerData
--- @field PreferredAiTargets Guid[]
--- @field PreviousCrimeHandle int32
--- @field PreviousCrimeState uint8
--- @field PreviousLevel FixedString
--- @field RegisteredForAutomatedDialog boolean
--- @field RequestStartTurn boolean
--- @field ReservedForDialog boolean
--- @field SpotSneakers boolean
--- @field StatusManager EsvStatusMachine
--- @field SteeringEnabled boolean
--- @field StoryNPC boolean
--- @field Summon boolean
--- @field Template CharacterTemplate
--- @field TemplateUsedForSpells CharacterTemplate
--- @field Temporary boolean
--- @field Totem boolean
--- @field Trader boolean
--- @field TreasureGeneratedForTrader boolean
--- @field Treasures FixedString[]
--- @field Unknown0x10 boolean
--- @field Unknown0x40 boolean
--- @field Unknown10000000000 boolean
--- @field Unknown40000000000 boolean
--- @field Unknown8000 boolean
--- @field Unknown80000000 boolean
--- @field Unknown80000000000000 boolean
--- @field UserID UserId
--- @field UserID2 UserId
--- @field WalkThrough boolean
--- @field field_14C FixedString
--- @field field_B8 FixedString[]
--- @field GetStatus fun(self:EsvCharacter, a1:FixedString):EsvStatus
--- @field GetStatusByType fun(self:EsvCharacter, a1:StatusType):EsvStatus


--- @class EsvCharacterComponent:BaseComponent
--- @field Character EsvCharacter


--- @class EsvCreatePuddleAction:EsvCreateSurfaceActionBase
--- @field GrowSpeed number
--- @field GrowTimer number
--- @field IgnoreIrreplacableSurfaces boolean
--- @field IsFinished boolean
--- @field Step int32
--- @field SurfaceCells int32


--- @class EsvCreateSurfaceAction:EsvCreateSurfaceActionBase
--- @field CheckExistingSurfaces boolean
--- @field CurrentCellCount int32
--- @field ExcludeRadius number
--- @field GrowStep int32
--- @field GrowTimer number
--- @field IgnoreIrreplacableSurfaces boolean
--- @field InitialChangesPushed boolean
--- @field LineCheckBlock uint64
--- @field MaxHeight number
--- @field Radius number
--- @field SpellId SpellId
--- @field SurfaceConcentrationTarget uint16
--- @field SurfaceLayer SurfaceLayer8
--- @field Timer number


--- @class EsvCreateSurfaceActionBase:EsvSurfaceAction
--- @field Duration number
--- @field IsControlledByConcentration boolean
--- @field Owner EntityRef
--- @field Position vec3
--- @field SurfaceType SurfaceType


--- @class EsvDisplayName
--- @field Name string
--- @field NameKey TranslatedString
--- @field field_10 uint8


--- @class EsvDisplayNameListComponent:BaseComponent
--- @field Names EsvDisplayName[]
--- @field TranslatedStrings EsvDisplayNameTranslatedString[]


--- @class EsvDisplayNameTranslatedString
--- @field NameKey TranslatedString
--- @field field_10 uint8


--- @class EsvExtinguishFireAction:EsvCreateSurfaceActionBase
--- @field ExtinguishGrowTimer number
--- @field ExtinguishPosition vec3
--- @field Percentage number
--- @field Radius number
--- @field Step number


--- @class EsvIconListComponent:BaseComponent
--- @field Icons EsvIconListComponentIcon[]
--- @field field_30 uint8


--- @class EsvIconListComponentIcon
--- @field Icon FixedString
--- @field field_4 uint32


--- @class EsvItem
--- @field Activated boolean
--- @field CanBeMoved boolean
--- @field CanBePickedUp boolean
--- @field CanOnlyBeUsedByOwner boolean
--- @field CanShootThrough boolean
--- @field CanUse boolean
--- @field ClientSync1 boolean
--- @field Destroy boolean
--- @field Destroyed boolean
--- @field DisableInventoryView80 boolean
--- @field DisableSync boolean
--- @field DisableUse uint8
--- @field DontAddToHotbar boolean
--- @field Flags ServerItemFlags
--- @field Flags2 ServerItemFlags2
--- @field Floating boolean
--- @field ForceClientSync boolean
--- @field ForceSync boolean
--- @field ForceSynch uint8
--- @field FreezeGravity boolean
--- @field Frozen boolean
--- @field GMFolding boolean
--- @field Global boolean
--- @field HideHP boolean
--- @field InAutomatedDialog boolean
--- @field InPartyInventory boolean
--- @field InUse boolean
--- @field InheritedForceSynch uint8
--- @field InteractionDisabled boolean
--- @field Invisible boolean
--- @field Invisible2 boolean
--- @field Invulnerable boolean
--- @field Invulnerable2 boolean
--- @field IsContainer boolean
--- @field IsDoor boolean
--- @field IsLadder boolean
--- @field IsMoving boolean
--- @field IsSecretDoor boolean
--- @field IsSurfaceBlocker boolean
--- @field IsSurfaceCloudBlocker boolean
--- @field ItemType FixedString
--- @field Known boolean
--- @field Level FixedString
--- @field LevelTransitionPending boolean
--- @field LoadedTemplate boolean
--- @field LuckyFind boolean
--- @field MovingCount uint8
--- @field MyHandle EntityRef
--- @field NoCover boolean
--- @field OffStage boolean
--- @field OriginalTemplate ItemTemplate
--- @field PinnedContainer boolean
--- @field PositionChanged boolean
--- @field PreviousLevel FixedString
--- @field ReservedForDialog boolean
--- @field SourceContainer boolean
--- @field Stats FixedString
--- @field StatusManager EsvStatusMachine
--- @field Sticky boolean
--- @field StoryItem boolean
--- @field Summon boolean
--- @field TeleportOnUse boolean
--- @field Template ItemTemplate
--- @field Totem boolean
--- @field TransformChanged boolean
--- @field TreasureGenerated boolean
--- @field TreasureLevel int32
--- @field UnEquipLocked boolean
--- @field UnsoldGenerated boolean
--- @field UseRemotely boolean
--- @field WakePhysics boolean
--- @field WalkOn boolean
--- @field WalkThrough boolean
--- @field field_10 EntityHandle
--- @field field_68 EntityHandle
--- @field field_70 FixedString


--- @class EsvItemComponent:BaseComponent
--- @field Item EsvItem


--- @class EsvPlayerData
--- @field CachedTension uint8
--- @field CustomData EocPlayerCustomData
--- @field HelmetOption uint8
--- @field IsInDangerZone boolean
--- @field PlayerHandle EntityHandle
--- @field PreviousPositionId int32
--- @field PreviousPositions vec3[]
--- @field QuestSelected FixedString
--- @field Region FixedString
--- @field Renown int32
--- @field field_4C int32
--- @field field_68 EntityHandle
--- @field field_94 boolean


--- @class EsvPolygonSurfaceAction:EsvCreateSurfaceActionBase
--- @field Characters EntityHandle[]
--- @field CurrentGrowTimer number
--- @field GrowStep int32
--- @field GrowTimer number
--- @field Items EntityHandle[]
--- @field LastSurfaceCellCount int32
--- @field PolygonVertices vec2[]
--- @field SomePosition vec3


--- @class EsvProjectile:BaseComponent
--- @field CanDeflect boolean
--- @field Caster EntityHandle
--- @field CauseType uint8
--- @field CleanseChance number
--- @field CleanseStatuses FixedString
--- @field DamageMovingObjectOnLand boolean
--- @field DamageType DamageType
--- @field EffectHandle EntityHandle
--- @field ExplodeRadius number
--- @field Flags uint64
--- @field Hit Hit
--- @field HitInterpolation number
--- @field HitObject EntityHandle
--- @field IgnoreObjects boolean
--- @field IgnoreTargetChecks boolean
--- @field IsFromItem boolean
--- @field IsOnHold boolean
--- @field IsThrown boolean
--- @field IsTrap boolean
--- @field Launched boolean
--- @field LevelName FixedString
--- @field MyEntityHandle EntityRef
--- @field NetID NetId
--- @field Originator ActionOriginator
--- @field PathRadius number
--- @field PreviousTranslate vec3
--- @field RequestDelete boolean
--- @field ShouldFall boolean
--- @field Source EntityHandle
--- @field SourcePosition vec3
--- @field SourceWeapon EntityHandle
--- @field SpawnEffect FixedString
--- @field SpawnFXOverridesImpactFX boolean
--- @field SpellFlag0x04 boolean
--- @field SpellId SpellId
--- @field StoryActionID int32
--- @field Success boolean
--- @field TargetObject EntityHandle
--- @field TargetPosition vec3
--- @field TextKey FixedString
--- @field Used boolean
--- @field field_22C number
--- @field field_484 number
--- @field field_515 boolean
--- @field field_518 boolean
--- @field field_51E boolean
--- @field field_520 boolean


--- @class EsvRectangleSurfaceAction:EsvCreateSurfaceActionBase
--- @field Characters EntityRef[]
--- @field CurrentCellCount int32
--- @field DeathType StatsDeathType
--- @field GrowStep int32
--- @field GrowTimer number
--- @field Items EntityRef[]
--- @field Length number
--- @field LineCheckBlock uint64
--- @field MaxHeight number
--- @field SurfaceArea_M number
--- @field Target vec3
--- @field Width number


--- @class EsvReplicationDependencyComponent:BaseComponent
--- @field Dependency EntityHandle


--- @class EsvReplicationDependencyOwnerComponent:BaseComponent
--- @field Dependents EntityHandle[]


--- @class EsvStatus
--- @field BringIntoCombat boolean
--- @field Cause EntityRef
--- @field CauseGUID Guid
--- @field CauseType uint8
--- @field Channeled boolean
--- @field Combat_M EntityRef
--- @field ConditionsId int32
--- @field CurrentLifeTime number
--- @field DifficultyStatus FixedString
--- @field DisableImmunityOverhead boolean
--- @field DontTickWhileOnSurface boolean
--- @field ExcludeFromPortraitRendering boolean
--- @field Flags ServerStatusFlags
--- @field Flags2 ServerStatusFlags2
--- @field Flags3 ServerStatusFlags3
--- @field Flags4 ServerStatusFlags4
--- @field ForceFailStatus boolean
--- @field ForceStatus boolean
--- @field FreezeDuration boolean
--- @field Influence boolean
--- @field InitiateCombat boolean
--- @field IsFromItem boolean
--- @field IsHostileAct boolean
--- @field IsInvulnerable boolean
--- @field IsInvulnerableVisible boolean
--- @field IsLifeTimeSet boolean
--- @field IsRecoverable boolean
--- @field IsUnique boolean
--- @field KeepAlive boolean
--- @field LifeTime number
--- @field Loaded boolean
--- @field NotifiedPlanManager boolean
--- @field OriginCauseType uint8
--- @field Originator ActionOriginator
--- @field Owner EntityHandle
--- @field RemoveEvents uint32
--- @field RequestClientSync boolean
--- @field RequestClientSync2 boolean
--- @field RequestDelete boolean
--- @field RequestDeleteAtTurnEnd boolean
--- @field SourceEquippedItem EntityHandle
--- @field SourceSpell SpellId
--- @field SourceUsedItem EntityHandle
--- @field SpellCastSourceUuid Guid
--- @field SpellCastingAbility uint8
--- @field StackId FixedString
--- @field StackPriority int32
--- @field StartTimer number
--- @field Started boolean
--- @field StatusFlags3_0x08 boolean
--- @field StatusFlags3_0x10 boolean
--- @field StatusFlags3_0x20 boolean
--- @field StatusFlags3_0x40 boolean
--- @field StatusFlags3_0x80 boolean
--- @field StatusFlags4_0x04 boolean
--- @field StatusFlags4_0x20 boolean
--- @field StatusFlags4_0x40 boolean
--- @field StatusFlags4_0x80 boolean
--- @field StatusHandle ComponentHandle
--- @field StatusId FixedString
--- @field StatusOwner EntityHandle[]
--- @field StatusSource EntityHandle
--- @field StoryActionID int32
--- @field Strength number
--- @field SyncEntity EntityHandle
--- @field TickType uint8
--- @field TurnTimer number
--- @field field_104 uint8
--- @field field_105 uint8
--- @field field_150 Guid
--- @field field_18 int64
--- @field field_48 number
--- @field field_8 Guid
--- @field field_E0 EntityHandle
--- @field field_E8 Guid


--- @class EsvStatusAura:EsvStatus


--- @class EsvStatusBoost:EsvStatusAura
--- @field BoostStackId FixedString
--- @field EffectTime number
--- @field ItemHandles EntityHandle[]
--- @field Items FixedString[]
--- @field LoseControl boolean
--- @field SourceDirection vec3
--- @field Spell FixedString[]


--- @class EsvStatusClimbing:EsvStatus
--- @field Direction boolean
--- @field Incapacitated_M boolean
--- @field Item EntityHandle
--- @field JumpUpLadders_M boolean
--- @field Level FixedString
--- @field MoveDirection_M vec3
--- @field Started_M boolean
--- @field Status uint8


--- @class EsvStatusDeactivated:EsvStatusBoost


--- @class EsvStatusDowned:EsvStatusIncapacitated
--- @field DamageFailures int32
--- @field IsHealed boolean
--- @field IsStable boolean
--- @field NumStableFailed int32
--- @field NumStableSuccess int32
--- @field RollFailures int32
--- @field RollSuccesses int32
--- @field StableRollDC int32


--- @class EsvStatusDying:EsvStatus
--- @field Combat Guid
--- @field DyingFlags uint8
--- @field HitDescription Hit
--- @field Source EntityRef


--- @class EsvStatusEffect:EsvStatus


--- @class EsvStatusFear:EsvStatusBoost


--- @class EsvStatusHeal:EsvStatus
--- @field AbsorbSurfaceRange int32
--- @field EffectTime number
--- @field HealAmount int32
--- @field HealEffect int32
--- @field HealEffectId FixedString
--- @field HealType uint8
--- @field TargetDependentHeal uint8
--- @field TargetDependentHealAmount int32
--- @field TargetDependentValue int32


--- @class EsvStatusInSurface:EsvStatus
--- @field Translate vec3


--- @class EsvStatusIncapacitated:EsvStatusBoost
--- @field CurrentFreezeTime number
--- @field FreezeTime number
--- @field IncapacitateFlags uint8
--- @field IncapacitationAnimationFinished boolean


--- @class EsvStatusInvisible:EsvStatusBoost
--- @field InvisiblePosition vec3


--- @class EsvStatusKnockedDown:EsvStatus
--- @field IsInstant boolean
--- @field KnockedDownState uint8


--- @class EsvStatusMachine
--- @field Statuses EsvStatus[]


--- @class EsvStatusMaterial:EsvStatus
--- @field ApplyFlags uint8
--- @field ApplyNormalMap boolean
--- @field Fading boolean
--- @field Force boolean
--- @field IsOverlayMaterial boolean
--- @field MaterialUUID FixedString


--- @class EsvStatusPolymorphed:EsvStatusBoost
--- @field Id Guid


--- @class EsvStatusReaction:EsvStatus
--- @field IgnoreChecks boolean
--- @field IgnoreHasSpell boolean
--- @field Partner EntityHandle
--- @field ShowOverhead boolean
--- @field Source EntityRef
--- @field Spell SpellId
--- @field Target EntityRef
--- @field TargetPosition vec3


--- @class EsvStatusRotate:EsvStatus
--- @field RotationSpeed number
--- @field Yaw number


--- @class EsvStatusSmelly:EsvStatus


--- @class EsvStatusSneaking:EsvStatusBoost
--- @field ClientRequestStop boolean


--- @class EsvStatusStoryFrozen:EsvStatus


--- @class EsvStatusTeleportFalling:EsvStatus
--- @field HasDamage boolean
--- @field HasDamageBeenApplied boolean
--- @field ReappearTime number
--- @field Spell SpellId
--- @field Target vec3


--- @class EsvStatusUnlock:EsvStatus
--- @field Source EntityHandle
--- @field Success boolean
--- @field Unlocked int32


--- @class EsvSurfaceAction
--- @field Handle EntityHandle
--- @field Originator ActionOriginator
--- @field StoryActionID int32


--- @class EsvTransformSurfaceAction:EsvSurfaceAction
--- @field Finished boolean
--- @field GrowCellPerSecond number
--- @field OriginSurface uint8
--- @field OwnerHandle EntityRef
--- @field PlayerCharacterNearby boolean
--- @field Position vec3
--- @field SurfaceLayer SurfaceLayer8
--- @field SurfaceLifetime number
--- @field SurfaceTransformAction uint8
--- @field Timer number


--- @class EsvZoneAction:EsvCreateSurfaceActionBase
--- @field CurrentCellCount int64
--- @field Flags uint8
--- @field GrowStep int32
--- @field Params EsvZoneActionParams
--- @field Spell SpellId
--- @field Target vec3
--- @field Targets EntityRef[]
--- @field TextKey FixedString


--- @class EsvZoneActionParams
--- @field Flags uint8
--- @field FrontOffset number
--- @field Height number
--- @field MaxHeight number
--- @field Radius number
--- @field Shape int32
--- @field ZoneParam number


--- @class EsvCombatCanStartCombatComponent:BaseComponent


--- @class EsvCombatCombatGroupMappingComponent:BaseComponent
--- @field CombatGroups table<FixedString, Array_EntityHandle>
--- @field Entity EntityHandle


--- @class EsvCombatEnterRequestComponent:BaseComponent
--- @field EnterRequests Array_EntityHandle


--- @class EsvCombatFleeBlockedComponent:BaseComponent


--- @class EsvCombatImmediateJoinComponent:BaseComponent


--- @class EsvInterruptActionRequest1
--- @field MHM_EH_MHS_EH table<EntityHandle, Array_EntityHandle>
--- @field field_0 int64
--- @field field_10 InterruptInterruptVariant2
--- @field field_158 int64
--- @field field_8 int64


--- @class EsvInterruptActionRequest2
--- @field field_0 int64
--- @field field_10 InterruptInterruptVariant2
--- @field field_118 int64
--- @field field_8 int64


--- @class EsvInterruptActionRequest3
--- @field MHM_EH_MHS_EH table<EntityHandle, Array_EntityHandle>
--- @field field_0 int64
--- @field field_8 int64


--- @class EsvInterruptActionRequest4
--- @field UseCosts StatsSpellPrototypeUseCostGroup[]
--- @field field_0 int64
--- @field field_18 table<EntityHandle, table<InterruptInterruptVariant2, ConditionRoll>>


--- @class EsvInterruptActionRequestsComponent
--- @field Requests1 EsvInterruptActionRequest1[]
--- @field Requests2 EsvInterruptActionRequest2[]
--- @field Requests3 EsvInterruptActionRequest3[]


--- @class EsvInterruptAddRemoveRequestsComponent
--- @field Requests table<EntityHandle, uint8>


--- @class EsvInterruptInitialParticipantsComponent
--- @field Participants table<EntityHandle, EsvInterruptInitialParticipantsComponentParticipant>


--- @class EsvInterruptInitialParticipantsComponentParticipant
--- @field Entities Array_EntityHandle
--- @field Request1 EsvInterruptActionRequest1


--- @class EsvInterruptTurnOrderInZoneComponent
--- @field InZone Array_EntityHandle


--- @class EsvInterruptZoneRequestsComponent
--- @field Requests1 EsvInterruptActionRequest1[]
--- @field Requests2 EsvInterruptActionRequest2[]


--- @class EsvLuaAfterExecuteFunctorEvent:LuaEventBase
--- @field Functor StatsFunctors
--- @field Hit HitResult
--- @field Params StatsBaseFunctorExecParams


--- @class EsvLuaBeforeDealDamageEvent:LuaEventBase
--- @field DamageSums DamageSums
--- @field Hit Hit


--- @class EsvLuaDealDamageEvent:LuaEventBase
--- @field Caster EntityHandle
--- @field DamageSums DamageSums
--- @field Functor StatsDealDamageFunctor
--- @field Hit Hit
--- @field HitWith HitWith
--- @field IsFromItem boolean
--- @field Originator ActionOriginator
--- @field Position vec3
--- @field SpellId SpellIdWithPrototype
--- @field StoryActionId int32
--- @field Target EntityHandle


--- @class EsvLuaDealtDamageEvent:EsvLuaDealDamageEvent
--- @field Result HitResult


--- @class EsvLuaDoConsoleCommandEvent:LuaEventBase
--- @field Command string


--- @class EsvLuaExecuteFunctorEvent:LuaEventBase
--- @field Functor StatsFunctors
--- @field Params StatsBaseFunctorExecParams


--- @class EsvLuaGameStateChangeEvent:LuaEventBase
--- @field FromState ServerGameState
--- @field ToState ServerGameState


--- @class EsvSpellCastCastHitDelayComponent:BaseComponent
--- @field CastHitDelays EsvSpellCastCastHitDelayComponentCastHitDelay[]
--- @field CastTargetHitDelay number
--- @field CastTargetHitDelay2 number


--- @class EsvSpellCastCastHitDelayComponentCastHitDelay
--- @field field_0 int32
--- @field field_10 int32
--- @field field_14 FixedString
--- @field field_18 int32
--- @field field_4 int32
--- @field field_8 int32
--- @field field_C int32


--- @class EsvSpellCastCastResponsibleComponent:BaseComponent
--- @field Entity EntityHandle


--- @class EsvSpellCastCastState
--- @field field_0 Guid
--- @field field_10 FixedString
--- @field field_14 FixedString
--- @field field_18 FixedString
--- @field field_1C uint8


--- @class EsvSpellCastClientInitiatedComponent:BaseComponent
--- @field Dummy uint8


--- @class EsvSpellCastExternalsComponent:BaseComponent
--- @field Externals Guid[]


--- @class EsvSpellCastHitRegisterComponent:BaseComponent
--- @field Hits Guid[]


--- @class EsvSpellCastInterruptIdentifier
--- @field field_0 uint64
--- @field field_10 uint64
--- @field field_8 uint64


--- @class EsvSpellCastInterruptRequestsComponent
--- @field Requests1 EsvInterruptActionRequest1[]
--- @field Requests2 EsvInterruptActionRequest2[]
--- @field Requests3 EsvInterruptActionRequest3[]
--- @field Requests4 EsvInterruptActionRequest4[]


--- @class EsvSpellCastInterruptResult
--- @field field_0 table<uint8, table<uint8, EsvSpellCastInterruptRollData>>
--- @field field_40 table<uint8, table<uint8, uint64>>
--- @field field_50 uint16[]
--- @field field_60 Array_uint8
--- @field field_90 Array_uint8


--- @class EsvSpellCastInterruptResult2
--- @field Roll Variant<StatsRollType0,StatsRollType1,>
--- @field _Pad uint32
--- @field field_0 int64
--- @field field_10 int64
--- @field field_138 int32
--- @field field_140 int64
--- @field field_148 int64
--- @field field_150 uint8
--- @field field_151 uint8
--- @field field_152 uint8
--- @field field_18 int32
--- @field field_1C uint8
--- @field field_20 uint8
--- @field field_21 uint8
--- @field field_8 int64


--- @class EsvSpellCastInterruptResultsComponent
--- @field Results table<EsvSpellCastInterruptIdentifier, EsvSpellCastInterruptResult>
--- @field Results2 EsvSpellCastInterruptResult2[]


--- @class EsvSpellCastInterruptRollData
--- @field field_0 int64
--- @field field_8 ResolvedUnknown[]


--- @class EsvSpellCastStateComponent:BaseComponent
--- @field State EsvSpellCastCastState
--- @field field_0 uint8
--- @field field_28 int32
--- @field field_4 int32


--- @class HealBlockComponent:BaseComponent


--- @class InterruptActionStateComponent:BaseComponent
--- @field Arr_EHx2 InterruptInterruptEntities[]
--- @field Variant InterruptInterruptVariant2
--- @field field_118 Guid


--- @class InterruptConditionallyDisabledComponent:BaseComponent
--- @field Dummy uint8


--- @class InterruptContainerComponent:BaseComponent
--- @field Interrupts EntityHandle[]


--- @class InterruptDataComponent
--- @field Interrupt FixedString
--- @field field_10 EntityHandle
--- @field field_18 FixedString
--- @field field_4 uint8
--- @field field_8 EntityHandle


--- @class InterruptDecisionComponent
--- @field Decisions table<InterruptInterruptVariant2, uint8>


--- @class InterruptExecuteResult
--- @field ResolveData table<Guid, InterruptResolveData>
--- @field field_0 uint8


--- @class InterruptInterruptEntities
--- @field field_0 EntityHandle
--- @field field_8 EntityHandle


--- @class InterruptInterruptIdentifier
--- @field field_0 uint64
--- @field field_10 uint64
--- @field field_8 uint64


--- @class InterruptInterruptType0
--- @field field_0 FixedString
--- @field field_18 SpellId
--- @field field_8 Guid


--- @class InterruptInterruptType1
--- @field field_0 int64
--- @field field_18 int32
--- @field field_1C uint8
--- @field field_20 int32
--- @field field_28 EntityHandle[]
--- @field field_38 EntityHandle
--- @field field_40 SpellId
--- @field field_68 uint8
--- @field field_69 uint8
--- @field field_8 Guid


--- @class InterruptInterruptType2
--- @field field_0 Guid
--- @field field_10 FixedString
--- @field field_18 Guid
--- @field field_28 uint8
--- @field field_2C uint8
--- @field field_2D uint8
--- @field field_30 int32
--- @field field_34 int32
--- @field field_38 int32
--- @field field_3C uint8
--- @field field_3D uint8
--- @field field_40 int32
--- @field field_44 uint8
--- @field field_48 int32
--- @field field_4C uint8
--- @field field_50 uint8
--- @field field_51 uint8
--- @field field_52 uint8
--- @field field_58 Guid
--- @field field_68 SpellId


--- @class InterruptInterruptType3
--- @field field_0 int64
--- @field field_10 int64
--- @field field_18 int64
--- @field field_20 int64
--- @field field_28 int64
--- @field field_30 FixedString
--- @field field_34 uint8
--- @field field_38 int64
--- @field field_40 int64
--- @field field_48 int64
--- @field field_50 int32
--- @field field_54 uint8
--- @field field_55 uint8
--- @field field_8 int64


--- @class InterruptInterruptType4
--- @field field_0 FixedString
--- @field field_4 vec3


--- @class InterruptInterruptType5
--- @field field_0 FixedString
--- @field field_4 vec3


--- @class InterruptInterruptType6
--- @field field_0 Guid
--- @field field_10 FixedString
--- @field field_18 Guid
--- @field field_28 string
--- @field field_40 string
--- @field field_44 int32
--- @field field_48 string
--- @field field_49 string
--- @field field_50 Guid
--- @field field_60 string
--- @field field_68 Guid
--- @field field_78 string
--- @field field_80 SpellId


--- @class InterruptInterruptType7
--- @field field_0 Guid
--- @field field_10 Guid
--- @field field_20 FixedString
--- @field field_28 Guid
--- @field field_38 Guid
--- @field field_48 uint8
--- @field field_50 int64
--- @field field_58 FixedString
--- @field field_5C int32


--- @class InterruptInterruptType8
--- @field field_0 Guid
--- @field field_10 FixedString
--- @field field_18 Guid
--- @field field_28 Guid
--- @field field_38 int32
--- @field field_40 int64
--- @field field_48 string
--- @field field_4C int32


--- @class InterruptInterruptVariant2
--- @field Source EntityHandle
--- @field SourcePos vec3|nil
--- @field SourceProxy EntityHandle
--- @field Target EntityHandle
--- @field TargetPos vec3|nil
--- @field TargetProxy EntityHandle
--- @field Variant Variant<InterruptInterruptType0,InterruptInterruptType1,InterruptInterruptType2,InterruptInterruptType3,InterruptInterruptType4,InterruptInterruptType5,InterruptInterruptType6,InterruptInterruptType7,InterruptInterruptType8,>
--- @field field_100 uint8
--- @field field_D0 InterruptInterruptEntities[]


--- @class InterruptInterruptVariantContainer
--- @field MHM_EH_MHS_EH table<EntityHandle, Array_EntityHandle>
--- @field Variant InterruptInterruptVariant2
--- @field field_108 boolean
--- @field field_110 InterruptInterruptVariant2


--- @class InterruptPreferencesComponent
--- @field Preferences table<FixedString, uint8>


--- @class InterruptPreparedComponent:BaseComponent
--- @field Dummy uint8


--- @class InterruptResolveData
--- @field Arr2_2b InterruptResolveDataElement[]
--- @field Arr_2b InterruptResolveDataElement[]
--- @field ResolvedRolls ResolvedUnknown[]
--- @field field_0 int32
--- @field field_18 int32|nil
--- @field field_20 uint8
--- @field field_48 int32|nil
--- @field field_50 uint8


--- @class InterruptResolveDataElement
--- @field A uint8
--- @field B uint8


--- @class InterruptZoneComponent:BaseComponent
--- @field field_0 Guid


--- @class InterruptZoneParticipantComponent:BaseComponent
--- @field field_0 table<EntityHandle, uint8>


--- @class InterruptZoneSourceComponent:BaseComponent
--- @field Dummy uint8


--- @class InventoryContainerComponent:BaseComponent
--- @field Items table<uint16, InventoryContainerComponentItem>


--- @class InventoryContainerComponentItem
--- @field Item EntityHandle
--- @field field_8 uint32


--- @class InventoryDataComponent:BaseComponent
--- @field Flags uint16
--- @field field_0 uint8


--- @class InventoryMemberComponent:BaseComponent
--- @field EquipmentSlot int16
--- @field Inventory EntityHandle


--- @class InventoryOwnerComponent:BaseComponent
--- @field Inventories EntityHandle[]
--- @field PrimaryInventory EntityHandle


--- @class LuaEmptyEvent:LuaEventBase


--- @class LuaEventBase
--- @field ActionPrevented boolean
--- @field CanPreventAction boolean
--- @field Name FixedString
--- @field Stopped boolean
--- @field PreventAction fun(self:LuaEventBase)
--- @field StopPropagation fun(self:LuaEventBase)


--- @class LuaTickEvent:LuaEventBase
--- @field Time GameTime


--- @class ResourceActionResource:ResourceGuidResource
--- @field Description TranslatedString
--- @field DiceType DiceSizeId
--- @field DisplayName TranslatedString
--- @field Error TranslatedString
--- @field IsHidden boolean
--- @field IsSpellResource boolean
--- @field MaxLevel uint32
--- @field MaxValue number
--- @field Name FixedString
--- @field PartyActionResource boolean
--- @field ReplenishType ResourceReplenishType
--- @field ShowOnActionResourcePanel boolean
--- @field UpdatesSpellPowerLevel boolean


--- @class ResourceActionResourceGroup:ResourceGuidResource
--- @field ActionResourceDefinitions Guid[]
--- @field Name string
--- @field field_38 TranslatedString
--- @field field_48 TranslatedString


--- @class ResourceBackground:ResourceGuidResource
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field Hidden boolean
--- @field Passives string
--- @field Tags Guid[]
--- @field field_40 int64
--- @field field_48 int64


--- @class ResourceCharacterCreationAccessorySet:ResourceGuidResource
--- @field CharacterCreationSet boolean
--- @field DefaultForRootTemplates Guid[]
--- @field DisplayName TranslatedString
--- @field RaceUUID Guid
--- @field SlotName FixedString
--- @field VisualUUID Guid[]


--- @class ResourceCharacterCreationAppearanceMaterial:ResourceGuidResource
--- @field DisplayName TranslatedString
--- @field DragonbornFemaleRootTemplate Guid
--- @field DragonbornMaleRootTemplate Guid
--- @field FemaleCameraName FixedString
--- @field FemaleRootTemplate Guid
--- @field MaleCameraName FixedString
--- @field MaleRootTemplate Guid
--- @field MaterialPresetUUID Guid
--- @field MaterialType FixedString
--- @field MaterialType2 FixedString
--- @field Name FixedString
--- @field UIColor vec4


--- @class ResourceCharacterCreationAppearanceVisual:ResourceGuidResource
--- @field BodyShape uint8
--- @field BodyType uint8
--- @field DefaultForBodyType uint8
--- @field DefaultSkinColor Guid
--- @field DisplayName TranslatedString
--- @field HeadAppearanceUUID Guid
--- @field IconIdOverride FixedString
--- @field RaceUUID Guid
--- @field RootTemplate Guid
--- @field SlotName FixedString
--- @field Tags Guid[]
--- @field VisualResource Guid
--- @field field_3C uint32


--- @class ResourceCharacterCreationColor:ResourceGuidResource
--- @field DisplayName TranslatedString
--- @field MaterialPresetUUID Guid
--- @field Name FixedString
--- @field SkinType FixedString
--- @field UIColor vec4


--- @class ResourceCharacterCreationEquipmentIcons:ResourceGuidResource
--- @field AnimationUUID Guid
--- @field EquipmentTemplate Guid
--- @field IconGenerationTrigger FixedString
--- @field MeshIsTwoSided boolean
--- @field RootTemplate Guid
--- @field SlotName FixedString


--- @class ResourceCharacterCreationEyeColor:ResourceCharacterCreationColor


--- @class ResourceCharacterCreationHairColor:ResourceCharacterCreationColor


--- @class ResourceCharacterCreationIconSettings:ResourceGuidResource
--- @field BodyShape uint8
--- @field HeadAppearanceUUID Guid
--- @field RootTemplate Guid


--- @class ResourceCharacterCreationMaterialOverride:ResourceGuidResource
--- @field ActiveMaterialPresetUUID Guid
--- @field InactiveMaterialPresetUUID Guid
--- @field MaterialType int32
--- @field SourceMaterialUUID FixedString
--- @field TargetMaterialUUID FixedString


--- @class ResourceCharacterCreationPassiveAppearance:ResourceGuidResource
--- @field AccessorySetUUIDs Guid[]
--- @field AppearanceMaterialUUIDs Guid[]
--- @field ColorMaterialUUIDs Guid[]
--- @field Passive FixedString
--- @field RaceUUID Guid


--- @class ResourceCharacterCreationPreset:ResourceGuidResource
--- @field BodyShape uint8
--- @field BodyType uint8
--- @field CloseUpA string
--- @field CloseUpB string
--- @field Overview string
--- @field RaceUUID Guid
--- @field RootTemplate Guid
--- @field SubRaceUUID Guid
--- @field VOLinesTableUUID Guid


--- @class ResourceCharacterCreationSharedVisual:ResourceGuidResource
--- @field BoneName FixedString
--- @field DisplayName TranslatedString
--- @field SlotName FixedString
--- @field Tags Guid[]
--- @field VisualResource Guid


--- @class ResourceCharacterCreationSkinColor:ResourceCharacterCreationColor


--- @class ResourceClassDescription:ResourceGuidResource
--- @field AnimationSetPriority int32
--- @field BaseHp int32
--- @field CanLearnSpells boolean
--- @field CharacterCreationPose FixedString
--- @field ClassEquipment FixedString
--- @field ClassHotbarColumns int32
--- @field CommonHotbarColumns int32
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field HasGod boolean
--- @field HpPerLevel int32
--- @field IsDefaultForUseSpellAction boolean
--- @field IsSomaticWithInstrument boolean
--- @field ItemsHotbarColumns int32
--- @field LearningStrategy uint8
--- @field MulticlassSpellcasterModifier number
--- @field MustPrepareSpells boolean
--- @field Name FixedString
--- @field ParentGuid Guid
--- @field PrimaryAbility uint8
--- @field ProgressionTableUUID Guid
--- @field SoundClassType FixedString
--- @field SpellCastingAbility uint8
--- @field SpellList Guid
--- @field SubclassTitle TranslatedString
--- @field Tags Guid[]
--- @field Unused TranslatedString
--- @field field_71 uint8


--- @class ResourceColor:ResourceGuidResource
--- @field Color vec4
--- @field DisplayName TranslatedString
--- @field Name FixedString


--- @class ResourceEquipmentType:ResourceGuidResource
--- @field BoneMainSheathed FixedString
--- @field BoneMainUnsheathed FixedString
--- @field BoneOffHandSheathed FixedString
--- @field BoneOffHandUnsheathed FixedString
--- @field BoneVersatileSheathed FixedString
--- @field BoneVersatileUnsheathed FixedString
--- @field Name FixedString
--- @field SoundAttackType FixedString
--- @field SoundEquipmentType FixedString
--- @field SourceBoneAlternativeUnsheathed FixedString
--- @field SourceBoneSheathed FixedString
--- @field SourceBoneVersatileSheathed FixedString
--- @field SourceBoneVersatileUnsheathed FixedString
--- @field WeaponType_OneHanded FixedString
--- @field WeaponType_TwoHanded FixedString


--- @class ResourceFaction:ResourceGuidResource
--- @field Faction FixedString
--- @field ParentGuid Guid


--- @class ResourceFeat:ResourceGuidResource
--- @field AddSpells ResourceProgressionAddedSpell[]
--- @field Boosts string
--- @field CanBeTakenMultipleTimes boolean
--- @field Name FixedString
--- @field PassivesAdded string
--- @field PassivesRemoved string
--- @field Requirements string
--- @field SelectAbilities ResourceProgressionAbility[]
--- @field SelectAbilityBonus ResourceProgressionAbilityBonus[]
--- @field SelectEquipment ResourceProgressionEquipment[]
--- @field SelectPassives ResourceProgressionPassive[]
--- @field SelectSkills ResourceProgressionSkill[]
--- @field SelectSkillsExpertise ResourceProgressionSkillExpertise[]
--- @field SelectSpells ResourceProgressionSpell[]


--- @class ResourceFeatDescription:ResourceGuidResource
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field ExactMatch FixedString
--- @field FeatId Guid
--- @field Hidden boolean
--- @field ParamMatch FixedString
--- @field PassivePrototype FixedString
--- @field SelectorId FixedString
--- @field Type FixedString


--- @class ResourceFlag:ResourceGuidResource
--- @field Description string
--- @field Name FixedString
--- @field Usage uint8


--- @class ResourceGod:ResourceGuidResource
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field Name FixedString
--- @field Tags Guid[]


--- @class ResourceGossip:ResourceGuidResource
--- @field ConditionFlags Guid[]
--- @field DialogUUID Guid
--- @field Name FixedString
--- @field Priority int32
--- @field ResultFlags Guid[]
--- @field Type FixedString


--- @class ResourceGuidResource
--- @field ResourceUUID Guid


--- @class ResourceOrigin:ResourceGuidResource
--- @field AppearanceTags Guid[]
--- @field AvailableInCharacterCreation uint8
--- @field BackgroundUUID Guid
--- @field BodyShape uint8
--- @field BodyType uint8
--- @field ClassEquipmentOverride FixedString
--- @field ClassUUID Guid
--- @field CloseUpA string
--- @field CloseUpB string
--- @field DefaultsTemplate Guid
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field ExcludesOriginUUID Guid
--- @field Flags uint32
--- @field GlobalTemplate Guid
--- @field GodUUID Guid
--- @field Identity uint8
--- @field IntroDialogUUID Guid
--- @field IsHenchman boolean
--- @field LockBody boolean
--- @field LockClass boolean
--- @field LockRace boolean
--- @field Name FixedString
--- @field Overview string
--- @field Passives string
--- @field RaceUUID Guid
--- @field ReallyTags Guid[]
--- @field SubClassUUID Guid
--- @field SubRaceUUID Guid
--- @field VoiceTableUUID Guid


--- @class ResourcePassiveList:ResourceGuidResource
--- @field Passives FixedString[]


--- @class ResourceProgression:ResourceGuidResource
--- @field AddSpells ResourceProgressionAddedSpell[]
--- @field AllowImprovement boolean
--- @field Boosts string
--- @field IsMulticlass boolean
--- @field Level uint8
--- @field Name string
--- @field PassivesAdded string
--- @field PassivesRemoved string
--- @field ProgressionType uint8
--- @field SelectAbilities ResourceProgressionAbility[]
--- @field SelectAbilityBonus ResourceProgressionAbilityBonus[]
--- @field SelectEquipment ResourceProgressionEquipment[]
--- @field SelectPassives ResourceProgressionPassive[]
--- @field SelectSkills ResourceProgressionSkill[]
--- @field SelectSkillsExpertise ResourceProgressionSkillExpertise[]
--- @field SelectSpells ResourceProgressionSpell[]
--- @field SubClasses Guid[]
--- @field TableUUID Guid
--- @field field_D0 FixedString[]


--- @class ResourceProgressionAbility
--- @field Arg2 int32
--- @field Arg3 int32
--- @field Arg4 string
--- @field UUID Guid


--- @class ResourceProgressionAbilityBonus
--- @field Amount int32
--- @field Amounts int32[]
--- @field BonusType string
--- @field UUID Guid


--- @class ResourceProgressionAddedSpell
--- @field Ability AbilityId
--- @field ActionResource Guid
--- @field ClassUUID Guid
--- @field CooldownType SpellCooldownType
--- @field PrepareType SpellPrepareType
--- @field SelectorId string
--- @field SpellUUID Guid


--- @class ResourceProgressionEquipment
--- @field Amount int32
--- @field Arg3 string
--- @field UUID Guid


--- @class ResourceProgressionPassive
--- @field Amount int64
--- @field Arg3 string
--- @field UUID Guid


--- @class ResourceProgressionSkill
--- @field Amount int32
--- @field Arg3 string
--- @field UUID Guid


--- @class ResourceProgressionSkillExpertise
--- @field Amount int32
--- @field Arg3 boolean
--- @field Arg4 string
--- @field UUID Guid


--- @class ResourceProgressionSpell
--- @field ActionResource Guid
--- @field Amount int32
--- @field Arg3 int32
--- @field CastingAbility AbilityId
--- @field ClassUUID Guid
--- @field CooldownType SpellCooldownType
--- @field PrepareType SpellPrepareType
--- @field SelectorId string
--- @field SpellUUID Guid


--- @class ResourceProgressionDescription:ResourceGuidResource
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field ExactMatch FixedString
--- @field Hidden boolean
--- @field ParamMatch FixedString
--- @field PassivePrototype FixedString
--- @field ProgressionId Guid
--- @field ProgressionTableId Guid
--- @field SelectorId FixedString
--- @field Type FixedString


--- @class ResourceRace:ResourceGuidResource
--- @field Description TranslatedString
--- @field DisplayName TranslatedString
--- @field DisplayTypeUUID Guid
--- @field ExcludedGods Guid[]
--- @field EyeColors Guid[]
--- @field Gods Guid[]
--- @field HairColors Guid[]
--- @field HairGrayingColors Guid[]
--- @field HairHighlightColors Guid[]
--- @field HornColors Guid[]
--- @field HornTipColors Guid[]
--- @field LipsMakeupColors Guid[]
--- @field MakeupColors Guid[]
--- @field Name FixedString
--- @field ParentGuid Guid
--- @field ProgressionTableUUID Guid
--- @field RaceEquipment FixedString
--- @field RaceSoundSwitch FixedString
--- @field SkinColors Guid[]
--- @field Tags Guid[]
--- @field TattooColors Guid[]
--- @field Visuals Guid[]


--- @class ResourceSkillList:ResourceGuidResource
--- @field Skills SkillId[]


--- @class ResourceSpellList:ResourceGuidResource
--- @field Spells Array_FixedString


--- @class ResourceTag:ResourceGuidResource
--- @field Categories uint32
--- @field Description string
--- @field DisplayDescription TranslatedString
--- @field DisplayName TranslatedString
--- @field Icon FixedString
--- @field Name FixedString
--- @field Properties uint32


--- @class SpellAddedSpellsComponent:BaseComponent
--- @field Spells SpellSpellContainerComponentSpell[]


--- @class SpellBookComponent:BaseComponent
--- @field Spells SpellSpellBookEntry[]
--- @field field_0 uint64


--- @class SpellBookPreparesComponent:BaseComponent
--- @field PreparedSpells SpellIdBase[]
--- @field field_30 table<Guid, int32>
--- @field field_88 table<Guid, int32>


--- @class SpellCCPrepareSpellComponent:BaseComponent
--- @field Spells SpellPlayerPrepareSpellComponentSpell[]


--- @class SpellLearnedSpellsComponent:BaseComponent
--- @field field_18 table<Guid, Array_FixedString>
--- @field field_70 Array_uint8


--- @class SpellModification
--- @field Modification Variant<SpellModificationModifyAreaRadius,SpellModificationModifyMaximumTargets,SpellModificationModifyNumberOfTargets,SpellModificationModifySavingThrowDisadvantage,SpellModificationModifySpellFlags,SpellModificationModifySpellRoll,SpellModificationModifyStatusDuration,SpellModificationModifySummonDuration,SpellModificationModifySurfaceDuration,SpellModificationModifyTargetRadius,SpellModificationModifyUseCosts,SpellModificationModifyVisuals,SpellModificationModifyIconGlow,SpellModificationModifyTooltipDescription,>
--- @field Spells Array_SpellId
--- @field field_0 uint8
--- @field field_4 FixedString


--- @class SpellModificationModifyAreaRadius
--- @field Value uint64


--- @class SpellModificationModifyIconGlow
--- @field Value uint8


--- @class SpellModificationModifyMaximumTargets
--- @field Value uint64


--- @class SpellModificationModifyNumberOfTargets
--- @field Value vec3


--- @class SpellModificationModifySavingThrowDisadvantage
--- @field Value uint8


--- @class SpellModificationModifySpellFlags
--- @field Value uint8
--- @field field_1 uint8


--- @class SpellModificationModifySpellRoll
--- @field field_0 string
--- @field field_18 string
--- @field field_30 int32


--- @class SpellModificationModifyStatusDuration
--- @field Value uint64


--- @class SpellModificationModifySummonDuration
--- @field Value uint64


--- @class SpellModificationModifySurfaceDuration
--- @field Value uint64


--- @class SpellModificationModifyTargetRadius
--- @field Value uint64


--- @class SpellModificationModifyTooltipDescription
--- @field Value uint8


--- @class SpellModificationModifyUseCosts
--- @field Type uint8
--- @field field_10 Guid
--- @field field_18 string
--- @field field_30 int32
--- @field field_38 Guid


--- @class SpellModificationModifyVisuals
--- @field Value uint8


--- @class SpellPlayerPrepareSpellComponent:BaseComponent
--- @field Spells SpellPlayerPrepareSpellComponentSpell[]
--- @field field_30 uint8


--- @class SpellPlayerPrepareSpellComponentSpell
--- @field _Pad int32
--- @field field_0 FixedString
--- @field field_10 Guid
--- @field field_8 uint8


--- @class SpellSpellAiConditionsComponent:BaseComponent
--- @field field_18 table<FixedString, uint64>


--- @class SpellSpellBookCooldownsComponent:BaseComponent
--- @field Cooldowns SpellSpellBookCooldownsComponentCooldown[]


--- @class SpellSpellBookCooldownsComponentCooldown
--- @field Cooldown number
--- @field CooldownType SpellCooldownType
--- @field SpellId SpellId
--- @field field_29 uint8
--- @field field_30 Guid


--- @class SpellSpellBookEntry
--- @field CooldownType SpellCooldownType
--- @field Id SpellId
--- @field SpellCastingAbility AbilityId
--- @field SpellUUID Guid
--- @field field_38 int32
--- @field field_3C int32
--- @field field_41 uint8
--- @field field_42 uint8


--- @class SpellSpellBookEntryInnerEntry
--- @field field_0 uint8
--- @field field_8 Array_int32


--- @class SpellSpellCastComponent:BaseComponent
--- @field field_18 FixedString
--- @field field_1C uint8
--- @field field_20 int64
--- @field field_28 int32
--- @field field_2C int32
--- @field field_30 int32
--- @field field_34 int32
--- @field field_38 uint8
--- @field field_39 uint8
--- @field field_3A uint8
--- @field field_3B uint8


--- @class SpellSpellContainerComponent:BaseComponent
--- @field Spells SpellSpellContainerComponentSpell[]


--- @class SpellSpellContainerComponentSpell
--- @field ContainerSpell FixedString
--- @field CooldownType SpellCooldownType
--- @field ItemHandle EntityHandle
--- @field SelectionType SpellChildSelectionType
--- @field SpellCastingAbility AbilityId
--- @field SpellId SpellIdBase
--- @field SpellUUID Guid
--- @field field_29 uint8
--- @field field_48 uint8


--- @class SpellSpellModificationContainerComponent:BaseComponent
--- @field Modifications table<FixedString, SpellModification[]>


--- @class SpellCastAnimationInfoComponent:BaseComponent
--- @field field_0 uint8
--- @field field_10 uint8
--- @field field_14 vec3
--- @field field_20 EntityHandle
--- @field field_28 uint8
--- @field field_29 uint8
--- @field field_2A uint8
--- @field field_2B uint8
--- @field field_2C uint8
--- @field field_2D uint8
--- @field field_2E uint8
--- @field field_4 vec3


--- @class SpellCastCacheComponent:BaseComponent
--- @field field_0 uint8
--- @field field_4 uint32


--- @class SpellCastCanBeTargetedComponent:BaseComponent
--- @field Dummy uint8


--- @class SpellCastInterruptResultsComponent:BaseComponent
--- @field Results Array_EntityHandle
--- @field field_0 string


--- @class SpellCastIsCastingComponent:BaseComponent
--- @field Cast EntityHandle


--- @class SpellCastMovementComponent:BaseComponent
--- @field field_0 vec3
--- @field field_18 boolean
--- @field field_C vec3


--- @class SpellCastReposeState
--- @field field_0 int64
--- @field field_10 EntityHandle|nil
--- @field field_20 vec3|nil
--- @field field_8 EntityHandle


--- @class SpellCastReposeState2
--- @field Repose SpellCastReposeState
--- @field Repose2 SpellCastReposeState|nil
--- @field field_30 uint8


--- @class SpellCastRollsComponent:BaseComponent
--- @field Rolls SpellCastRollsComponentRoll[]


--- @class SpellCastRollsComponentRoll
--- @field Hits SpellCastRollsComponentRollHit[]
--- @field MHS_FS_i32 table<FixedString, int32>
--- @field field_0 EntityHandle
--- @field field_68 int32
--- @field field_6C uint8
--- @field field_70 int64
--- @field field_78 int64
--- @field field_8 EntityHandle|nil
--- @field field_80 int64
--- @field field_88 uint8


--- @class SpellCastRollsComponentRollHit
--- @field Hit Hit
--- @field field_0 FixedString


--- @class SpellCastStateComponent:BaseComponent
--- @field Entity EntityHandle
--- @field Repose SpellCastReposeState2[]
--- @field SpellId SpellIdBase
--- @field field_38 int32
--- @field field_50 vec3|nil
--- @field field_60 vec3|nil
--- @field field_70 vec3
--- @field field_8 EntityHandle
--- @field field_80 EntityHandle
--- @field field_88 int32
--- @field field_90 Guid
--- @field field_A0 string


--- @class SpellCastSyncTargetingComponent
--- @field Repose SpellCastReposeState2[]
--- @field field_10 EntityHandle|nil
--- @field field_20 vec3|nil
--- @field field_40 uint8
--- @field field_44 int32
--- @field field_48 vec3|nil
--- @field field_58 vec3|nil
--- @field field_68 vec3|nil
--- @field field_78 vec3|nil
--- @field field_8 EntityHandle
--- @field field_88 vec3|nil


--- @class StatsApplyEquipmentStatusFunctor:StatsApplyStatusFunctor
--- @field EquipmentSlot StatsItemSlot


--- @class StatsApplyStatusFunctor:StatsFunctor
--- @field HasParam6 boolean
--- @field StatsConditions string
--- @field StatusId FixedString
--- @field StringParam FixedString


--- @class StatsBaseFunctorExecParams
--- @field EntityToThothContextIndex table<EntityHandle, int32>
--- @field HistoryEntity EntityHandle
--- @field Originator ActionOriginator
--- @field ParamsTypeId FunctorExecParamsType
--- @field PropertyContext StatsPropertyContext
--- @field StatusSource EntityHandle
--- @field StoryActionId int32
--- @field field_98 int32
--- @field field_9C boolean


--- @class StatsBreakConcentrationFunctor:StatsFunctor


--- @class StatsCreateConeSurfaceFunctor:StatsFunctor
--- @field Arg0 number
--- @field Arg1 number
--- @field Arg2 FixedString
--- @field Arg3 boolean


--- @class StatsCreateExplosionFunctor:StatsFunctor
--- @field SpellId FixedString


--- @class StatsCreateSurfaceFunctor:StatsFunctor
--- @field Arg4 number
--- @field Duration number
--- @field IsControlledByConcentration boolean
--- @field Radius number
--- @field SurfaceType FixedString


--- @class StatsCustomDescriptionFunctor:StatsFunctor
--- @field Description FixedString


--- @class StatsDealDamageFunctor:StatsFunctor
--- @field DamageType DamageType
--- @field Magical boolean
--- @field Nonlethal boolean
--- @field WeaponDamageType DealDamageWeaponDamageType
--- @field WeaponType DealDamageWeaponType
--- @field field_34 int32


--- @class StatsDisarmWeaponFunctor:StatsFunctor


--- @class StatsDouseFunctor:StatsFunctor
--- @field field_20 number
--- @field field_24 number


--- @class StatsEqualizeFunctor:StatsFunctor
--- @field HealType StatusHealType


--- @class StatsExecuteWeaponFunctorsFunctor:StatsFunctor
--- @field WeaponType ExecuteWeaponFunctorsType


--- @class StatsExtenderFunctor:StatsFunctor


--- @class StatsForceFunctor:StatsFunctor
--- @field Aggression ForceFunctorAggression
--- @field Origin ForceFunctorOrigin


--- @class StatsFunctor
--- @field ObserverType StatsObserverType
--- @field RollConditions StatsFunctorRollCondition[]
--- @field StatsConditionsId int32
--- @field TypeId StatsFunctorId
--- @field UniqueName FixedString


--- @class StatsFunctorRollCondition
--- @field ConditionId int32
--- @field Type StatsRollType


--- @class StatsFunctorExecParamsType1:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field CasterProxy EntityRef
--- @field DamageSums DamageSums
--- @field Hit Hit
--- @field HitWith HitWith
--- @field IsFromItem boolean
--- @field Position vec3
--- @field SomeRadius number
--- @field SpellId SpellIdWithPrototype
--- @field Target EntityRef
--- @field TargetProxy EntityRef
--- @field field_26C FixedString
--- @field field_2F8 uint64
--- @field field_300 uint64
--- @field field_310 uint32
--- @field field_314 uint32
--- @field field_31C uint8


--- @class StatsFunctorExecParamsType2:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field DamageSums DamageSums
--- @field ExplodeRadius number
--- @field Hit Hit
--- @field IsFromItem boolean
--- @field Position vec3
--- @field SomeRadius number
--- @field SpellId SpellIdWithPrototype


--- @class StatsFunctorExecParamsType3:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field Distance number
--- @field Position vec3
--- @field Target EntityRef
--- @field field_C0 EntityRef


--- @class StatsFunctorExecParamsType4:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field DamageSums DamageSums
--- @field Hit Hit
--- @field Position vec3
--- @field SpellId SpellIdWithPrototype
--- @field field_2D8 uint64
--- @field field_2E0 uint64
--- @field field_2E8 uint32
--- @field field_2EC FixedString
--- @field field_2F0 uint8
--- @field field_B0 EntityRef


--- @class StatsFunctorExecParamsType5:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field DamageSums DamageSums
--- @field Hit Hit
--- @field IsFromItem boolean
--- @field Owner_M EntityRef
--- @field Position vec3
--- @field SpellId SpellIdWithPrototype
--- @field Target EntityRef
--- @field field_D0 EntityRef
--- @field field_E0 EntityRef


--- @class StatsFunctorExecParamsType6:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field DamageSums DamageSums
--- @field Hit Hit
--- @field IsFromItem boolean
--- @field Position vec3
--- @field SpellId SpellIdWithPrototype
--- @field Target EntityRef
--- @field TargetProxy EntityRef
--- @field field_D0 EntityRef
--- @field field_E0 EntityRef


--- @class StatsFunctorExecParamsType7:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field Target EntityRef
--- @field UseCasterStats boolean


--- @class StatsFunctorExecParamsType8:StatsBaseFunctorExecParams
--- @field Caster EntityRef
--- @field Target EntityRef


--- @class StatsFunctorExecParamsType9:StatsBaseFunctorExecParams
--- @field DamageList DamagePair[]
--- @field DamageSums DamageSums
--- @field ExecuteInterruptResult InterruptExecuteResult
--- @field Hit Hit
--- @field Interrupt InterruptInterruptVariant2
--- @field Observer EntityRef
--- @field ObserverProxy EntityRef
--- @field OnlyAllowRollAdjustments boolean
--- @field ResolveData InterruptResolveData|nil
--- @field Source EntityRef
--- @field SourceProxy EntityRef
--- @field Target EntityRef
--- @field TargetProxy EntityRef


--- @class StatsFunctors
--- @field NextFunctorIndex int32
--- @field UniqueName FixedString


--- @class StatsPickupFunctor:StatsFunctor
--- @field Arg0 FixedString


--- @class StatsRPGStats
--- @field ExtraData table<FixedString, number>


--- @class StatsRegainHitPointsFunctor:StatsFunctor


--- @class StatsRemoveAuraByChildStatusFunctor:StatsFunctor
--- @field StatusId FixedString


--- @class StatsRemoveStatusFunctor:StatsFunctor
--- @field StatusId FixedString


--- @class StatsRemoveUniqueStatusFunctor:StatsFunctor
--- @field StatusId FixedString


--- @class StatsRequirement
--- @field IntParam int32
--- @field Not boolean
--- @field RequirementId RequirementType
--- @field TagParam Guid


--- @class StatsResetCombatTurnFunctor:StatsFunctor


--- @class StatsRestoreResourceFunctor:StatsFunctor
--- @field ActionResourceUUID Guid
--- @field Amount number
--- @field Hex int32
--- @field IsPercentage boolean
--- @field field_34 int32


--- @class StatsResurrectFunctor:StatsFunctor
--- @field HealthPercentage number
--- @field Probability number


--- @class StatsSabotageFunctor:StatsFunctor
--- @field Amount int32


--- @class StatsSetStatusDurationFunctor:StatsFunctor
--- @field Duration number
--- @field SetIfLonger boolean
--- @field StatusId FixedString


--- @class StatsSpawnFunctor:StatsFunctor
--- @field Arg1 FixedString
--- @field StatusesToApply Array_FixedString
--- @field TemplateId FixedString


--- @class StatsSpawnInInventoryFunctor:StatsFunctor
--- @field AdditionalArgs Array_FixedString
--- @field Arg1 FixedString
--- @field Arg2 number
--- @field Arg3 boolean
--- @field Arg4 boolean
--- @field Arg5 boolean
--- @field Arg6 FixedString


--- @class StatsSpellPrototype


--- @class StatsSpellPrototypeUseCostGroup
--- @field Amount number
--- @field ResourceGroup Guid
--- @field Resources Guid[]
--- @field SubResourceId int32


--- @class StatsStabilizeFunctor:StatsFunctor


--- @class StatsSummonFunctor:StatsFunctor
--- @field Arg2 FixedString
--- @field Arg3 boolean
--- @field MovingObject FixedString
--- @field SpawnLifetime number
--- @field StatusesToApply Array_FixedString


--- @class StatsSummonInInventoryFunctor:StatsFunctor
--- @field AdditionalArgs Array_FixedString
--- @field Arg1 FixedString
--- @field Arg3 number
--- @field Arg4 boolean
--- @field Arg5 boolean
--- @field Arg6 boolean
--- @field Arg7 boolean
--- @field Arg8 FixedString


--- @class StatsSurfaceChangeFunctor:StatsFunctor
--- @field Chance number
--- @field SurfaceChange SurfaceChange
--- @field field_24 number
--- @field field_28 number
--- @field field_2C number


--- @class StatsSwapPlacesFunctor:StatsFunctor


--- @class StatsTeleportSourceFunctor:StatsFunctor


--- @class StatsTreasureTable


--- @class StatsUnlockFunctor:StatsFunctor


--- @class StatsUseActionResourceFunctor:StatsFunctor
--- @field ActionResourceUUID Guid
--- @field Amount number
--- @field IsPercentage boolean
--- @field ResourceIndex int32


--- @class StatsUseAttackFunctor:StatsFunctor
--- @field IgnoreChecks boolean


--- @class StatsUseSpellFunctor:StatsFunctor
--- @field Arg3 boolean
--- @field IgnoreChecks boolean
--- @field IgnoreHasSpell boolean
--- @field SpellId FixedString


--- @class Ext_Debug
--- @field Crash fun(a1:int32)
--- @field DebugBreak fun()
--- @field DebugDumpLifetimes fun()
--- @field DumpStack fun()
--- @field GenerateIdeHelpers fun()
--- @field IsDeveloperMode fun():boolean
local Ext_Debug = {}



--- @class Ext_Entity
--- @field Get fun(a1:Guid)
--- @field GetAllEntities fun():EntityHandle[]
--- @field GetAllEntitiesWithComponent fun(a1:ExtComponentType):EntityHandle[]
--- @field GetAllEntitiesWithUuid fun():table<Guid, EntityHandle>
--- @field HandleToUuid fun(a1:EntityHandle):Guid|nil
--- @field UuidToHandle fun(a1:Guid):EntityHandle
local Ext_Entity = {}



--- @class Ext_IO
--- @field AddPathOverride fun(a1:string, a2:string)
--- @field GetPathOverride fun(a1:string)
--- @field LoadFile fun(a1:string)
--- @field SaveFile fun(a1:string, a2:string):boolean
local Ext_IO = {}



--- @class Ext_Json
--- @field Parse fun()
--- @field Stringify fun()
local Ext_Json = {}
--- @class JsonStringifyOptions
--- @field Beautify boolean Sorts the output table, and indents with tabs. Defaults to true.
--- @field StringifyInternalTypes boolean Defaults to false.
--- @field IterateUserdata boolean Defaults to false.
--- @field AvoidRecursion boolean Defaults to false.
--- @field MaxDepth integer Defaults to 64, the maximum value.
--- @field LimitDepth integer Defaults to -1 (off).
--- @field LimitArrayElements integer Defaults to -1 (off).



--- @class Ext_Math
--- @field Acos fun(a1:number):number
--- @field Add fun()
--- @field Angle fun()
--- @field Asin fun(a1:number):number
--- @field Atan fun(a1:number):number
--- @field Atan2 fun(a1:number, a2:number):number
--- @field BuildFromAxisAngle3 fun(a1:vec3, a2:number):mat3
--- @field BuildFromAxisAngle4 fun(a1:vec3, a2:number):mat4
--- @field BuildFromEulerAngles3 fun(a1:vec3):mat3
--- @field BuildFromEulerAngles4 fun(a1:vec3):mat4
--- @field BuildRotation3 fun(a1:vec3, a2:number):mat3
--- @field BuildRotation4 fun(a1:vec3, a2:number):mat4
--- @field BuildScale fun(a1:vec3):mat4
--- @field BuildTranslation fun(a1:vec3):mat4
--- @field Clamp fun(a1:number, a2:number, a3:number):number
--- @field Cross fun(a1:vec3, a2:vec3)
--- @field Decompose fun(a1:mat4, a2:vec3, a3:vec3, a4:vec3)
--- @field Determinant fun()
--- @field Distance fun(a1:vec3, a2:vec3):number
--- @field Div fun()
--- @field Dot fun(a1:vec3, a2:vec3):number
--- @field ExtractAxisAngle fun():number
--- @field ExtractEulerAngles fun():vec3
--- @field Fract fun(a1:number):number
--- @field Inverse fun()
--- @field IsInf fun(a1:number):boolean
--- @field IsNaN fun(a1:number):boolean
--- @field Length fun()
--- @field Lerp fun(a1:number, a2:number, a3:number):number
--- @field Mul fun()
--- @field Normalize fun()
--- @field OuterProduct fun()
--- @field Perpendicular fun()
--- @field Project fun()
--- @field Reflect fun()
--- @field Rotate fun()
--- @field Scale fun(a1:mat4, a2:vec3)
--- @field Sign fun(a1:number):number
--- @field Smoothstep fun(a1:number, a2:number, a3:number):number
--- @field Sub fun()
--- @field Translate fun(a1:mat4, a2:vec3)
--- @field Transpose fun()
--- @field Trunc fun(a1:number):number
local Ext_Math = {}



--- @class Ext_Mod
--- @field GetBaseMod fun():Module
--- @field GetLoadOrder fun()
--- @field GetMod fun(a1:string):Module
--- @field GetModManager fun():ModManager
--- @field IsModLoaded fun(a1:string):boolean
local Ext_Mod = {}



--- @class Ext_Resource
--- @field Get fun(a1:FixedString, a2:ResourceBankType):Resource
--- @field GetAll fun(a1:ResourceBankType):FixedString[]
local Ext_Resource = {}



--- @class Ext_StaticData
--- @field Get fun(a1:Guid, a2:ExtResourceManagerType)
--- @field GetAll fun(a1:ExtResourceManagerType):Guid[]
local Ext_StaticData = {}


--- @class Ext_Stats
--- @field TreasureCategory Ext_StatsTreasureCategory
--- @field TreasureTable Ext_StatsTreasureTable
--- @field AddAttribute fun(modifierList:FixedString, modifierName:FixedString, typeName:FixedString):boolean
--- @field AddEnumerationValue fun(typeName:FixedString, enumLabel:FixedString):int32
--- @field Create fun(a1:FixedString, a2:FixedString)
--- @field EnumIndexToLabel fun(a1:FixedString, a2:int32)
--- @field EnumLabelToIndex fun(a1:FixedString, a2:FixedString)
--- @field Get fun(a1:string, a2:int32|nil)
--- @field GetModifierAttributes fun(a1:FixedString)
--- @field GetStats fun():FixedString[]
--- @field GetStatsLoadedBefore fun(a1:FixedString):FixedString[]
--- @field GetStatsManager fun():StatsRPGStats
--- @field SetPersistence fun(a1:FixedString, a2:boolean)
--- @field Sync fun(a1:FixedString)
local Ext_Stats = {}



--- @class Ext_StatsTreasureCategory
--- @field GetLegacy fun(id:FixedString):StatTreasureCategory
--- @field Update fun(id:FixedString, tbl:StatTreasureCategory)
local Ext_StatsTreasureCategory = {}



--- @class Ext_StatsTreasureTable
--- @field Get fun(a1:FixedString):StatsTreasureTable
--- @field GetLegacy fun(id:FixedString):StatTreasureTable
--- @field Update fun(tbl:StatTreasureTable)
local Ext_StatsTreasureTable = {}



--- @class Ext_Types
--- @field Construct fun(a1:FixedString)
--- @field GetAllTypes fun():FixedString[]
--- @field GetObjectType fun()
--- @field GetTypeInfo fun(a1:FixedString):TypeInformation
--- @field Serialize fun()
--- @field Unserialize fun()
--- @field Validate fun():boolean
local Ext_Types = {}
--- @class GenerateIdeHelpersOptions
--- @field AddOsiris boolean Add all Osiris functions to the global Osi table. This is optional, due to the possible performance cost of having so many functions.
--- @field AddDeprecated boolean Add deprecated functions to the helpers file.
--- @field AddAliasEnums boolean Add the enums in alias format, for string comparison. Defaults to true.
--- @field UseBaseExtraData boolean Only include the base ExtraData keys/values in Shared, instead of grabbing whatever the current keys are in the mod environment.
--- @field GenerateExtraDataAsClass boolean Annotate ExtraData as a class, so it only has fields with no fixed/hardcoded values.

--- Generate an ExtIdeHelpers file  
--- @param outputPath string|nil Optional path to save the generated helper file, relative to the `Documents\Larian Studios\Divinity Original Sin 2 Definitive Edition\Osiris Data` folder  
--- @param addOsi boolean|nil If true, all Osiris functions will be included in the Osi global table. This is optional, due to the possible performance cost of having so many functions  
--- @return string fileContents Returns the file contents, for use with Ext.IO.SaveFile
function Ext_Types.GenerateIdeHelpers(outputPath, addOsi) end




--- @class ComponentHandleProxy:userdata
--- @field Get (fun():IEoCServerObject|IEoCClientObject)
--- @field TypeId integer
--- @field Type FixedString
--- @field Salt uint32
--- @field Index uint32

--- ## Synchronization 
--- A variable is only eligible for synchronization if: 
--- * Both `Server` and `Client` is true. 
--- * For server to client synchronization, both `WriteableOnServer` and `SyncToClient` is true. 
--- * For client to server synchronization, both `WriteableOnClient` and `SyncToServer` is true. 
--- @class RegisterUserVariableOptions
--- @field Server boolean Variable is present on server entities. Defaults to `true`.
--- @field Client boolean Variable is present on client entities. Defaults to `false`.
--- @field WriteableOnServer boolean Variable can be modified on server side. Defaults to `true`.
--- @field WriteableOnClient boolean Variable can be modified on client side. Defaults to `false`.
--- @field Persistent boolean Variable is written to/restored from savegames. Defaults to `true`.
--- @field SyncToClient boolean Server-side changes to the variable are synced to all clients. Defaults to `false`.
--- @field SyncToServer boolean Client-side changes to the variable are synced to the server. Defaults to `false`.
--- @field SyncOnTick boolean Client-server sync is performed once per game loop tick. Defaults to `true`.
--- @field SyncOnWrite boolean Client-server sync is performed immediately when the variable is written. This is disabled by default for performance reasons.
--- @field DontCache boolean Disable Lua caching of variable values.<br>See here: https://github.com/Norbyte/ositools/blob/master/Docs/ReleaseNotesv58.md#caching-behavior

--- @class Ext_Utils
--- @field GameVersion fun()
--- @field GetCommandLineParams fun():string[]
--- @field GetGlobalSwitches fun():GlobalSwitches
--- @field GetValueType fun():string
--- @field HandleToInteger fun(a1:EntityHandle):int64
--- @field Include fun()
--- @field IntegerToHandle fun(a1:int64):EntityHandle
--- @field IsValidHandle fun():boolean
--- @field LoadString fun(str:string):UserReturn Similar to lua `loadstring`, with extra safeguards.
--- @field MonotonicTime fun():int64
--- @field Print fun()
--- @field PrintError fun()
--- @field PrintWarning fun()
--- @field Random fun()
--- @field Round fun(a1:number):int64
--- @field ShowErrorAndExitGame fun(a1:string)
--- @field Version fun():int32
local Ext_Utils = {}



--- @class ExtClient
--- @field Debug Ext_Debug
--- @field Entity Ext_Entity
--- @field IO Ext_IO
--- @field Json Ext_Json
--- @field Math Ext_Math
--- @field Mod Ext_Mod
--- @field Resource Ext_Resource
--- @field StaticData Ext_StaticData
--- @field Stats Ext_Stats
--- @field Types Ext_Types
--- @field Utils Ext_Utils

--- @class ExtServer
--- @field Debug Ext_Debug
--- @field Entity Ext_Entity
--- @field IO Ext_IO
--- @field Json Ext_Json
--- @field Math Ext_Math
--- @field Mod Ext_Mod
--- @field Resource Ext_Resource
--- @field StaticData Ext_StaticData
--- @field Stats Ext_Stats
--- @field Types Ext_Types
--- @field Utils Ext_Utils

--#region Generated Enums

--- @class Ext_Enums
local Ext_Enums = {}


--#endregion

--- @class Ext
--- @field Debug Ext_Debug
--- @field Entity Ext_Entity
--- @field IO Ext_IO
--- @field Json Ext_Json
--- @field Math Ext_Math
--- @field Mod Ext_Mod
--- @field Resource Ext_Resource
--- @field StaticData Ext_StaticData
--- @field Stats Ext_Stats
--- @field Types Ext_Types
--- @field Utils Ext_Utils
--- @field Enums Ext_Enums
Ext = {Events = {}}


--- @class SubscribableEvent<T>:{ (Subscribe:fun(self:SubscribableEvent, callback:fun(e:T|LuaEventBase), opts:{Priority:integer, Once:boolean}|nil):integer), (Unsubscribe:fun(self:SubscribableEvent, index:integer))}

--- Developer functions for the SubscribableEvent type. 
--- Throw can be used to manually throw the event, but special care may be needed to ensure the table used for the event data is valid.  
--- @class SubscribableEventDev<T>:{ (Throw:fun(self:SubscribableEvent, e:T|LuaEventBase))}

--#region Extender Events
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.DoConsoleCommand = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EclLuaGameStateChangeEvent>  
Ext.Events.EclLuaGameStateChange = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.Empty = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaAfterExecuteFunctorEvent>  
Ext.Events.EsvLuaAfterExecuteFunctor = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaBeforeDealDamageEvent>  
Ext.Events.EsvLuaBeforeDealDamage = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaDealDamageEvent>  
Ext.Events.EsvLuaDealDamage = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaDoConsoleCommandEvent>  
Ext.Events.EsvLuaDoConsoleCommand = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaExecuteFunctorEvent>  
Ext.Events.EsvLuaExecuteFunctor = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<EsvLuaGameStateChangeEvent>  
Ext.Events.EsvLuaGameStateChange = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.GameStateChanged = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.ModuleLoadStarted = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.ModuleLoading = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.ModuleResume = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.ResetCompleted = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.SessionLoaded = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.SessionLoading = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaEmptyEvent>  
Ext.Events.StatsLoaded = {}
--- 🔨🔧**Server/Client**🔧🔨  
--- @type SubscribableEvent<LuaTickEvent>  
Ext.Events.Tick = {}
--#endregion


--#region Extender Functions / Globals

--- @alias NetListenerCallback fun(channel:string, payload:string, user:UserId|nil)

--- Registers a listener that is called when a network message is received on the specified channel
--- @param channel string Network channel name
--- @param handler NetListenerCallback Lua handler
function Ext.RegisterNetListener(channel, handler) end

--- Loads the specified Lua file
--- @param fileName string|nil Path of Lua file, relative to Mods/<Mod>/Story/RawFiles/Lua
--- @see Ext_Utils#Include
--- @return any
function Ext.Require(fileName) end

--- Returns whether the code is executing in a client context
--- @return boolean
function Ext.IsClient() end

--- Returns whether the code is executing in a server context
--- @return boolean
function Ext.IsServer() end

--- Console window shortcut for Ext.Dump
_D = Ext.Dump

--- Console window shortcut for Ext.Utils.Print
_P = Ext.Utils.Print

--- Console window helper to get current player character 
--- This is the host on the server, or the hotbar character on the client  
--- @return EsvCharacter|EclCharacter
_C = function() end

--- Console window helper to get character being examined on the client-side  
--- @return EclCharacter
_E = function() end

--- Console window helper to get the host's equipped weapon on the server-side  
--- @return EsvItem
_W = function() end

--- Helper for dumping variables to the console  
--- This is essentially `Ext.Utils.Print(Ext.DumpExport(val))`  
--- @param val any
function Ext.Dump(val) end

--- Helper for dumping variables to a string
--- @param val any
--- @return string
function Ext.DumpExport(val) end

--- Register a callback that runs on the next tick, and is then unregistered afterwards  
--- @param callback fun(e:LuaTickEventParams)
function Ext.OnNextTick(callback) end

--- @class CustomSkillProperty
--- @field GetDescription fun(property:StatsPropertyExtender):string|nil
--- @field ExecuteOnPosition fun(property:StatsPropertyExtender, attacker: EsvCharacter|EsvItem, position: vec3, areaRadius: number, isFromItem: boolean, skill: StatsSkillPrototype|nil, hit: StatsHitDamageInfo|nil)
--- @field ExecuteOnTarget fun(property:StatsPropertyExtender, attacker: EsvCharacter|EsvItem, target: EsvCharacter|EsvItem, position: vec3, isFromItem: boolean, skill: StatsSkillPrototype|nil, hit: StatsHitDamageInfo|nil)

--- Registers a new skill property that can be triggered via SkillProperties
--- Stat syntax: data"SkillProperties""EXT:<PROPERTY_NAME>[,<int>,<int>,<string>,<int>,<int>]"
--- The property name must always be preceded by the string "EXT:". 
--- Target contexts (SELF:, TARGET:, ...) and useing multiple actions in the same SkillProperties are supported
--- Conditions for EXT: properties (i.e. "IF(COND):") are _NOT YET_ supported
--- @param name string Skill property name
--- @param defn CustomSkillProperty Event handlers for the skill property
function Ext.RegisterSkillProperty(name, defn) end

--- @alias UICallbackHandler fun(ui:UIObject, event:string, ...:string|boolean|number)
--- @alias UICallbackEventType "Before"|"After"

--- Registers a listener that is called when the specified function is called from Flash
--- @param object UIObject UI object returned from Ext.CreateUI, Ext.GetUI or Ext.GetBuiltinUI
--- @param name string ExternalInterface function name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUICall(object, name, handler, type) end

--- Registers a listener that is called when the specified function is called from Flash
--- The event is triggered for every UI element with the specified type ID
--- @param typeId number Engine UI element type ID
--- @param name string ExternalInterface function name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUITypeCall(typeId, name, handler, type) end

--- Registers a listener that is called when the specified function is called from Flash
--- The event is triggered regardless of which UI element it was called on
--- (Function call capture must be enabled for every element type that needs to monitored!)
--- @param name string ExternalInterface function name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUINameCall(name, handler, type) end

--- Registers a listener that is called when the specified method is called on the main timeline of the Flash object
--- @param object UIObject UI object returned from Ext.CreateUI, Ext.GetUI or Ext.GetBuiltinUI
--- @param name string Flash method name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUIInvokeListener(object, name, handler, type) end

--- Registers a listener that is called when the specified method is called on the main timeline of the Flash object
--- The event is triggered for every UI element with the specified type ID
--- @param typeId number Engine UI element type ID
--- @param name string Flash method name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUITypeInvokeListener(typeId, name, handler, type) end

--- Registers a listener that is called when the specified method is called on the main timeline of the Flash object
--- The event is triggered regardless of which UI element it was called on
--- @param name string Flash method name
--- @param handler UICallbackHandler Lua handler
--- @param type UICallbackEventType|nil Event type - 'Before' or 'After'
function Ext.RegisterUINameInvokeListener(name, handler, type) end

--- Registers a listener that is called when a console command is entered in the dev console
--- @param cmd string Console command
--- @param handler fun(cmd:string, ...:string)
function Ext.RegisterConsoleCommand(cmd, handler) end

--- Prepares a new surface action for execution
--- @param type string Surface action type
--- @return EsvSurfaceAction
function Ext.CreateSurfaceAction(type) end

--- Executes a surface action
--- @param action EsvSurfaceAction Action to execute
function Ext.ExecuteSurfaceAction(action) end

--- @deprecated
--- Cancels a surface action
--- @param actionHandle integer Action to cancel
function Ext.CancelSurfaceAction(actionHandle) end

--- @class ItemDefinition
--- @field RootTemplate FixedString
--- @field OriginalRootTemplate FixedString
--- @field Slot integer
--- @field Amount integer
--- @field GoldValueOverwrite integer
--- @field WeightValueOverwrite integer
--- @field DamageTypeOverwrite StatsDamageType
--- @field ItemType ItemDataRarity
--- @field CustomDisplayName string
--- @field CustomDescription string
--- @field CustomBookContent string
--- @field GenerationStatsId FixedString
--- @field GenerationItemType ItemDataRarity
--- @field GenerationRandom integer
--- @field GenerationLevel integer
--- @field StatsLevel integer
--- @field Key string
--- @field LockLevel integer
--- @field EquipmentStatsType integer
--- @field HasModifiedSkills boolean
--- @field Skills string
--- @field HasGeneratedStats boolean
--- @field IsIdentified boolean
--- @field GMFolding boolean
--- @field CanUseRemotely boolean
--- @field GenerationBoosts FixedString[]
--- @field RuneBoosts FixedString[]
--- @field DeltaMods FixedString[]
local ItemDefinition = {}

--- Clears item progression data (name group, level group, etc.)
function ItemDefinition:ResetProgression() end

--- @alias ItemConstructorDefinitionAccessor ItemDefinition[]

--- Creates an item based on a parsed item or newly created item definition.
--- Should be initialized using Ext.CreateItemConstructor(item/template) first.
--- Item definitions can be accessed using c[1], c[2], etc.
--- For non-recursive item cloning (i.e. creating a single item), there is only one item (c[1]).
--- For container cloning, the contained items are accessible using c[2], c[3], etc.
--- @class ItemConstructorBase
local ItemConstructorBase = {}

--- Constructs an instance of the item contained in the constructor definition.
--- The definition is cleared after the item is created.
--- @return EsvItem|nil
function ItemConstructorBase:Construct() end

--- @alias ItemConstructor ItemConstructorBase|ItemConstructorDefinitionAccessor

--- Starts creating a new item using template UUID or cloning an existing item
--- @param from EsvItem|string Template UUID or item to clone
--- @param recursive boolean|nil Copy items in container? (cloning only)
--- @return ItemConstructor
function Ext.CreateItemConstructor(from, recursive) end

--- Begin applying a status on the specified character or item
--- @param target string|ComponentHandle Target character/item
--- @param statusId string Status ID to apply
--- @param lifeTime number Status lifetime (-1 = infinite, -2 = keep alive)
--- @return EsvStatus|nil
function Ext.PrepareStatus(target, statusId, lifeTime) end

--- Finish applying a status on the specified character or item
--- @param status EsvStatus Status to apply
function Ext.ApplyStatus(status) end

--- Returns the current client/server game state machine state
--- @return EsvGameState
function Ext.GetGameState() end

--#endregion

--#region ExtraData

Ext.ExtraData = {
	["NPC max combat turn time"] = 20.0,
	["ThrowDistanceMin"] = 3.0,
	["ThrowDistanceMax"] = 18.0,
	["ThrowStrengthCapMultiplier"] = 0.20000000298023,
	["ThrowWeightMultiplier"] = 2.0,
	["Telekinesis Range"] = 4.0,
	["End Of Combat SightRange Multiplier"] = 3.0,
	["Sneak Damage Multiplier"] = 1.0,
	["Infectious Disease Depth"] = 5.0,
	["Infectious Disease Radius"] = 5.0,
	["Haste Speed Modifier"] = 1.5,
	["Slow Speed Modifier"] = 0.80000001192093,
	["Ally Joins Ally SightRange Multiplier"] = 2.5,
	["Surface Distance Evaluation"] = 2.0,
	["Once Per Combat Spell Realtime Cooldown"] = 1.0,
	["HintDuration"] = 5.0,
	["Projectile Terrain Offset"] = 3.0,
	["Surface Clear Owner Time"] = 1.0,
	["Decaying Touch Damage Modifier"] = 1.0,
	["FirstItemTypeShift"] = 9.0,
	["SecondItemTypeShift"] = 16.0,
	["PickpocketGoldValuePerPoint"] = 50.0,
	["PickpocketWeightPerPoint"] = 2000.0,
	["PickpocketExperienceLevelsPerPoint"] = 4.0,
	["PersuasionAttitudeBonusPerPoint"] = 5.0,
	["AbilityBaseValue"] = 10.0,
	["AbilityCharCreationBonus"] = 1.0,
	["AbilityLevelGrowth"] = 0.0,
	["AbilityBoostGrowth"] = 0.0,
	["AbilityGrowthDamp"] = 0.0,
	["AbilitySoftCap"] = 40.0,
	["WitsGrowthDamp"] = 0.0,
	["VitalityStartingAmount"] = 21.0,
	["VitalityExponentialGrowth"] = 1.25,
	["VitalityLinearGrowth"] = 9.0909996032715,
	["VitalityToDamageRatio"] = 5.0,
	["VitalityToDamageRatioGrowth"] = 0.20000000298023,
	["ExpectedDamageBoostFromAbilityPerLevel"] = 0.064999997615814,
	["ExpectedDamageBoostFromSpellSchoolPerLevel"] = 0.014999999664724,
	["ExpectedDamageBoostFromWeaponSkillPerLevel"] = 0.025000000372529,
	["ExpectedConGrowthForArmorCalculation"] = 1.0,
	["FirstVitalityLeapLevel"] = 9.0,
	["FirstVitalityLeapGrowth"] = 1.25,
	["SecondVitalityLeapLevel"] = 13.0,
	["SecondVitalityLeapGrowth"] = 1.25,
	["ThirdVitalityLeapLevel"] = 16.0,
	["ThirdVitalityLeapGrowth"] = 1.25,
	["FourthVitalityLeapLevel"] = 18.0,
	["FourthVitalityLeapGrowth"] = 1.3500000238419,
	["DamageBoostFromAbility"] = 0.050000000745058,
	["MonsterDamageBoostPerLevel"] = 0.019999999552965,
	["PhysicalArmourBoostFromAbility"] = 0.0,
	["MagicArmourBoostFromAbility"] = 0.0,
	["VitalityBoostFromAbility"] = 0.070000000298023,
	["DodgingBoostFromAbility"] = 0.0,
	["HealToDamageRatio"] = 1.2999999523163,
	["ArmorToVitalityRatio"] = 0.55000001192093,
	["ArmorRegenTimer"] = 0.0099999997764826,
	["ArmorRegenConstGrowth"] = 1.0,
	["ArmorRegenPercentageGrowth"] = 10.0,
	["ArmorAfterHitCooldown"] = -7.0,
	["MagicArmorRegenTimer"] = 0.0099999997764826,
	["MagicArmorRegenConstGrowth"] = 1.0,
	["MagicArmorRegenPercentageGrowth"] = 10.0,
	["MagicArmorAfterHitCooldown"] = -7.0,
	["ArmorHeadPercentage"] = 0.15000000596046,
	["ArmorUpperBodyPercentage"] = 0.30000001192093,
	["ArmorLowerBodyPercentage"] = 0.20000000298023,
	["ArmorShieldPercentage"] = 0.5,
	["ArmorHandsPercentage"] = 0.15000000596046,
	["ArmorFeetPercentage"] = 0.15000000596046,
	["ArmorAmuletPercentage"] = 0.11999999731779,
	["ArmorRingPercentage"] = 0.079999998211861,
	["CharacterBaseMemoryCapacity"] = 100.0,
	["CharacterBaseMemoryCapacityGrowth"] = 0.5,
	["CharacterAbilityPointsPerMemoryCapacity"] = 1.0,
	["CombatSkillCap"] = 10.0,
	["CombatSkillLevelGrowth"] = 100.0,
	["CombatSkillNpcGrowth"] = 0.0,
	["CombatSkillDamageBonus"] = 5.0,
	["CombatSkillCritBonus"] = 1.0,
	["CombatSkillCritMultiplierBonus"] = 5.0,
	["CombatSkillAccuracyBonus"] = 5.0,
	["CombatSkillDodgingBonus"] = 1.0,
	["CombatSkillReflectionBonus"] = 5.0,
	["NumStartingCivilSkillPoints"] = 2.0,
	["CivilSkillCap"] = 5.0,
	["CivilSkillLevelGrowth"] = 100.0,
	["CivilPointOffset"] = 0.0,
	["SavethrowLowChance"] = 15.0,
	["SavethrowHighChance"] = 50.0,
	["SavethrowBelowLowPenalty"] = 5.0,
	["SavethrowPenaltyCap"] = -30.0,
	["CriticalBonusFromWits"] = 1.0,
	["InitiativeBonusFromWits"] = 1.0,
	["WeaponAccuracyPenaltyPerLevel"] = -20.0,
	["WeaponAccuracyPenaltyCap"] = -80.0,
	["ShieldAPCost"] = 0.0,
	["WeaponWeightLight"] = 500.0,
	["WeaponWeightMedium"] = 1050.0,
	["WeaponWeightHeavy"] = 2600.0,
	["WeaponWeightGiant"] = 8200.0,
	["HighGroundThreshold"] = 2.2999999523163,
	["LowGroundAttackRollPenalty"] = -2.0,
	["HighGroundAttackRollBonus"] = 2.0,
	["LowGroundMeleeRange"] = 0.0,
	["HighGroundMeleeRange"] = 0.5,
	["HighGroundRangeMultiplier"] = 1.0,
	["SneakDefaultAPCost"] = 1.0,
	["BlindRangePenalty"] = 3.0,
	["RangeBoostedGlobalCap"] = 30.0,
	["SurfaceDurationFromHitFloorReaction"] = 18.0,
	["SurfaceDurationFireIgniteOverride"] = 12.0,
	["SurfaceDurationFromCharacterBleeding"] = -1.0,
	["SurfaceDurationAfterDecay"] = -1.0,
	["SmokeDurationAfterDecay"] = 6.0,
	["DualWieldingAPPenalty"] = 2.0,
	["DualWieldingDamagePenalty"] = 0.5,
	["ChanceToSetStatusOnContact"] = 100.0,
	["SkillPhysArmorBonusBase"] = 5.0,
	["SkillPhysArmorBonusPerPoint"] = 2.0,
	["SkillPhysArmorBonusMax"] = 5.0,
	["SkillMagicArmorBonusBase"] = 5.0,
	["SkillMagicArmorBonusPerPoint"] = 2.0,
	["SkillMagicArmorBonusMax"] = 5.0,
	["SkillVitalityBonusBase"] = 3.0,
	["SkillVitalityBonusPerPoint"] = 1.0,
	["SkillVitalityBonusMax"] = 3.0,
	["SpellSchoolDamageToPhysicalArmorPerPoint"] = 0.0,
	["SpellSchoolDamageToMagicArmorPerPoint"] = 0.0,
	["SpellSchoolArmorRestoredPerPoint"] = 5.0,
	["SpellSchoolVitalityRestoredPerPoint"] = 5.0,
	["SpellSchoolHighGroundBonusPerPoint"] = 5.0,
	["SpellSchoolFireDamageBoostPerPoint"] = 5.0,
	["SpellSchoolPoisonAndEarthDamageBoostPerPoint"] = 5.0,
	["SpellSchoolAirDamageBoostPerPoint"] = 5.0,
	["SpellSchoolWaterDamageBoostPerPoint"] = 5.0,
	["SpellSchoolPhysicalDamageBoostPerPoint"] = 5.0,
	["SpellSchoolSulfuricDamageBoostPerPoint"] = 5.0,
	["SpellSchoolLifeStealPerPoint"] = 10.0,
	["SpiritVisionFallbackRadius"] = 10.0,
	["AiCoverProjectileTurnMemory"] = 2.0,
	["CarryWeightBase"] = 40.0,
	["CarryWeightPerStr"] = 10000.0,
	["DeflectProjectileRange"] = 1.0,
	["CleaveRangeOverride"] = 125.0,
	["FleeDistance"] = 13.0,
	["GlobalGoldValueMultiplier"] = 1.0,
	["PriceBarterCoefficient"] = 0.10000000149012,
	["PriceAttitudeCoefficient"] = 0.0049999998882413,
	["PriceRoundToFiveAfterAmount"] = 100.0,
	["PriceRoundToTenAfterAmount"] = 1000.0,
	["GMCharacterAbilityCap"] = 100.0,
	["GMCharacterArmorCap"] = 999999.0,
	["GMCharacterResistanceMin"] = -1000.0,
	["GMCharacterResistanceMax"] = 1000.0,
	["GMCharacterAPCap"] = 100.0,
	["GMCharacterSPCap"] = 3.0,
	["GMItemLevelCap"] = 50.0,
	["GMItemAbilityCap"] = 100.0,
	["GMItemArmorMin"] = -999999.0,
	["GMItemArmorMax"] = 999999.0,
	["GMItemResistanceMin"] = -1000.0,
	["GMItemResistanceMax"] = 1000.0,
	["TraderDroppedItemsPercentage"] = 51.0,
	["TraderDroppedItemsCap"] = 3.0,
	["TraderDonationsRequiredAttitude"] = -45.0,
	["TeleportUnchainDistance"] = 50.0,
	["FlankingElevationThreshold"] = 1.2000000476837,
	["DefaultDC"] = 15.0,
	["FallDamageBaseDamage"] = 0.0099999997764826,
	["FallDamageMinimumDistance"] = 4.0,
	["FallDamageMaximumDistance"] = 21.0,
	["FallDamageDamageType"] = 3.0,
	["FallDamagePronePercent"] = 0.25,
	["FallDamageMultiplierHugeGargantuan"] = 2.0,
	["FallImpactPushDistance"] = 2.0,
	["FallImpactConstant"] = 4.9999998736894e-06,
	["FallImpactMinWeight"] = 0.5,
	["LethalHP"] = 1.0,
	["SpinningSpeed"] = 5.0,
	["ItemWeightLight"] = 100.0,
	["ItemWeightMedium"] = 1000.0,
	["ItemWeightHeavy"] = 50000.0,
	["WisdomTierHigh"] = 10.0,
	["CoinPileMediumThreshold"] = 100.0,
	["CoinPileBigThreshold"] = 500.0,
	["DarknessHeightOffset"] = 0.10000000149012,
	["DarknessGracePeriod"] = 0.20000000298023,
	["DarknessGraceFrames"] = 6.0,
	["SightConePreviewMaxDistanceFromPlayerSq"] = 900.0,
	["SpellMoveFloodMaxSourceDistance"] = 9.0,
	["UnarmedRange"] = 1.5,
	["ActiveRollRerollInspirationCost"] = 1.0,
	["PickpocketWeightSquaredThreshold"] = 250000.0,
	["PickpocketPriceSquaredThreshold"] = 100.0,
	["JoinAllyInCombatRadius"] = 7.0,
	["AbilityMaxValue"] = 30.0,
	["PassiveRollDelay"] = 0.40000000596046,
	["PickpocketingMaxPrice"] = 1000.0,
	["PickpocketingWeightModifierConstant"] = 0.20000000298023,
	["PickpocketingPriceModifierConstant"] = 0.5,
	["PickpocketingPriceDC"] = 20.0,
	["PickpocketingMinimumDC"] = 5.0,
	["FollowDistance"] = 70.0,
	["SneakFollowDistance"] = 5.0,
	["SeekHiddenRange"] = 3.0,
	["SeekHiddenTimeout"] = 0.5,
	["DamageTerrainOffset"] = 3.25,
	["SurfaceOnMoveDistanceMultiplier"] = 1.0,
	["SurfaceOnEnterDistanceMultiplier"] = 0.5,
	["GameplayLightsFadeTime"] = 0.5,
	["MaxPickingDistance"] = 30.0,
	["LearnSpellCostPerLevel"] = 50.0,
	["SavantLearnSpellCostPerLevel"] = 25.0,
	["MaxShortRestPoints"] = 2.0,
	["DualWieldingPlayersDefaultOn"] = 1.0,
	["DualWieldingNPCsDefaultOn"] = 1.0,
	["MaximumXPCap"] = 200000.0,
	["CombatCameraEndDelay"] = 1.0,
	["DamagingSurfacesThreshold"] = 35.0,
	["FollowThroughDamagingSurfaceDistance"] = 20.0,
	["CameraTakeControlTimer"] = 1.0,
	["CameraEnableTakeControlOnEndTurn"] = 1.0,
	["CombatCameraRangedAttackWait"] = 1.0,
	["CCTurnPauseTime"] = 1.0,
	["BaseSpellDifficultyCheck"] = 8.0,
	["GlobalBaseACModifier"] = 0.0,
	["RollStreamDialogDebtRange"] = 1.0,
	["RollStreamPlayerSpellDebtRange"] = 1.0,
	["RollStreamNPCSpellDebtRange"] = 1.0,
	["RollStreamPlayerRandomCastDebtRange"] = 1.0,
	["RollStreamNPCRandomCastDebtRange"] = 1.0,
	["RollStreamSuccessDebtConsumeMultiplier"] = 2.0,
	["RollStreamFailDebtConsumeMultiplier"] = 2.0,
	["ContainerCloseDistance"] = 0.0099999997764826,
	["CharacterInteractionHeightMin"] = 1.0,
	["MaxPickUpMultiplier"] = 5.0,
	["PointAndClickPostDelay"] = 0.10000000149012,
	["PortraitClickSpamThreshold"] = 10.0,
	["CombatCameraStatusEndTurnWait"] = 1.0,
	["Disarm_MaxDistance"] = 4.0,
	["Disarm_ThrowAngle"] = 100.0,
	["Disarm_RandomConeAngle"] = 40.0,
	["EncumberedMultiplier"] = 7.0,
	["HeavilyEncumberedMultiplier"] = 9.0,
	["CarryLimitMultiplier"] = 10.0,
	["ShoveCurveConstant"] = 65.0,
	["ShoveDistanceMax"] = 6.0,
	["ShoveDistanceMin"] = 1.0,
	["ShoveMultiplier"] = 12.0,
	["DragCheckMultiplier"] = 12.0,
	["DragCurveConstant"] = 65.0,
	["DragDistanceMax"] = 6.0,
	["ForceFunctorFallbackStrength"] = 10.0,
	["ExhaustedRest_HealthPercent"] = 50.0,
	["ExhaustedRest_ResourcePercent"] = 50.0,
	["ActiveRollPartyNearbyDistance"] = 9.0,
	["ActiveRollDisableIgnoreRange"] = 0.0,
	["CannotActTimeout"] = 2.0,
	["AutoSuccessCastingInActiveRoll"] = 1.0,
	["SplatterDistanceThreshold"] = 120.0,
	["SplatterDirtPerDistance"] = 0.10000000149012,
	["SplatterBloodPerDistance"] = 0.20000000298023,
	["SplatterBloodPerAttack"] = 0.10000000149012,
	["SplatterMaxBloodLimit"] = 1.0,
	["SplatterMaxDirtLimit"] = 0.89999997615814,
	["SplatterSweatDelta"] = 0.10000000149012,
	["PickupObjectMultiplier"] = 5.0,
	["MoveObjectMultiplier"] = 12.0,
	["MoveObjectRangeCheckMultiplier"] = 12.0,
	["MoveObjectRangeCurveConstant"] = 65.0,
	["MoveObjectRangeDistanceMax"] = 6.0,
	["ReactTimeThreshold"] = 0.20000000298023,
	["AISwarmMoveGroupMinDistance"] = 15.0,
	["ScaleChangeSpeed"] = 0.5,
	["SizeChangeWeightMultiplier"] = 2.3499999046326,
	["PickpocketInteractionRange"] = 1.0,
	["DangerousLevelGap"] = 2.0,
	["FallMinDamagePathfindingCost"] = 1000.0,
	["FallMaxDamagePathfindingCost"] = 2000.0,
	["FallDeadPathfindingCost"] = 10000.0,
	["PerformerZoneJoinRadius"] = 8.0,
	["PerformerZoneSilenceRadius"] = 0.0,
	["MaxPerformerZones"] = 4.0,
	["PerformerZoneMaxPlayersByType"] = 4.0,
	["FootstepMixdownTime"] = 10.0,
	["FootstepMixWaitTime"] = 5.0,
	["AmbienceMixDownDelayTime"] = 10.0,
	["DefaultInstrumentStowedVisuals"] = 2.0,
	["HoverStateMixLeaveDelayTime"] = 1.0,
	["HoverStateMixEnterDelayTime"] = 2.0,
	["Minimum SightRange When Calculating End Of Combat Range"] = 12.0,
	["InterruptZoneRange"] = 23.0,
	["CameraFlyingZoomDistanceExtra"] = 10.0,
	["CameraFlyingZoomDistanceRemap"] = 0.5,
	["InterruptNearbyDistance"] = 18.0,
	["PingCooldownTime"] = 2.0,
	["SoundFootstepGroupMinSize"] = 3.0,
	["SoundFootstepGroupMaxRadius"] = 8.0,
	["SoundFootstepGroupBoundRadius"] = 0.5,
	["PingMarkerLifeTime"] = 4.0,
	["EscortStragglerDistance"] = 10.0,
	["DefaultUnifiedTutorialsLifeTime"] = 12000.0,
	["ForceFunctorConeAngle"] = 30.0,
	["SplitScreenMaxSoundListenerDistance"] = 20.0,
	["TutorialHotbarSlotRemovedTimeout"] = 2.0,
	["CamListener_DistPercentFromCam_Close"] = 0.0,
	["CamListener_DistPercentFromCam_Medium"] = 70.0,
	["CamListener_DistPercentFromCam_Far"] = 40.0,
	["CamListener_ZoomOut_Close"] = 0.0,
	["CamListener_ZoomOut_Medium"] = 0.40000000596046,
	["CamListener_ZoomOut_Far"] = 0.60000002384186,
	["InitiativeDie"] = 4.0,
	["PassiveSkillScoreAdvMod"] = 5.0,
	["TransferredEvidenceOnGroundRadius"] = 8.0,
	["PointLightVerticalLimit"] = 2.5,
	["CombatCameraDeathAnimationWait"] = 2.0,
	["MoveToTargetCloseEnoughMin"] = 0.5,
	["MoveToTargetCloseEnoughMax"] = 3.5,
	["DialogInstanceFlagRange"] = 10.0,
	["Level1"] = 300.0,
	["Level10"] = 20000.0,
	["Level11"] = 24000.0,
	["Level12"] = 30000.0,
	["Level2"] = 600.0,
	["Level3"] = 1800.0,
	["Level4"] = 3800.0,
	["Level5"] = 6500.0,
	["Level6"] = 8000.0,
	["Level7"] = 9000.0,
	["Level8"] = 12000.0,
	["Level9"] = 14000.0,
	["MaxXPLevel"] = 12.0,
}

--#endregion

