require("include")

-- Random Digimon Selection Function
function GetRandomDigimon(count)
  -- All available Digimon chr IDs from 00_digimon_status_data.csv (538 total)
  local allDigimon = {
    "chr001", "chr002", "chr003", "chr004", "chr005", "chr006", "chr009", "chr010",
    "chr011", "chr012", "chr013", "chr014", "chr015", "chr016", "chr017", "chr019",
    "chr020", "chr021", "chr023", "chr024", "chr025", "chr026", "chr027", "chr028",
    "chr030", "chr031", "chr032", "chr033", "chr034", "chr035", "chr036", "chr037",
    "chr038", "chr039", "chr040", "chr041", "chr042", "chr043", "chr044", "chr045",
    "chr046", "chr047", "chr048", "chr049", "chr050", "chr051", "chr052", "chr053",
    "chr054", "chr055", "chr056", "chr057", "chr058", "chr059", "chr060", "chr061",
    "chr068", "chr069", "chr070", "chr071", "chr072", "chr073", "chr074", "chr075",
    "chr076", "chr077", "chr078", "chr079", "chr080", "chr081", "chr082", "chr083",
    "chr084", "chr085", "chr086", "chr087", "chr088", "chr090", "chr091", "chr092",
    "chr093", "chr094", "chr095", "chr096", "chr097", "chr098", "chr100", "chr101",
    "chr102", "chr103", "chr104", "chr105", "chr106", "chr107", "chr111", "chr112",
    "chr113", "chr114", "chr115", "chr116", "chr117", "chr118", "chr126", "chr127",
    "chr128", "chr129", "chr130", "chr132", "chr133", "chr134", "chr135", "chr136",
    "chr137", "chr138", "chr139", "chr140", "chr141", "chr142", "chr144", "chr145",
    "chr146", "chr147", "chr148", "chr149", "chr150", "chr151", "chr162", "chr163",
    "chr168", "chr169", "chr170", "chr171", "chr172", "chr173", "chr174", "chr176",
    "chr177", "chr178", "chr179", "chr180", "chr181", "chr183", "chr184", "chr185",
    "chr186", "chr187", "chr188", "chr189", "chr190", "chr191", "chr192", "chr193",
    "chr194", "chr195", "chr196", "chr197", "chr198", "chr199", "chr208", "chr209",
    "chr210", "chr211", "chr213", "chr214", "chr215", "chr217", "chr218", "chr219",
    "chr220", "chr222", "chr223", "chr224", "chr225", "chr226", "chr227", "chr228",
    "chr229", "chr230", "chr231", "chr232", "chr233", "chr234", "chr235", "chr237",
    "chr239", "chr240", "chr241", "chr242", "chr301", "chr302", "chr303", "chr304",
    "chr305", "chr306", "chr307", "chr308", "chr309", "chr310", "chr311", "chr312",
    "chr313", "chr314", "chr315", "chr316", "chr317", "chr320", "chr321", "chr322",
    "chr325", "chr326", "chr328", "chr338", "chr341", "chr342", "chr343", "chr344",
    "chr345", "chr346", "chr347", "chr348", "chr349", "chr359", "chr361", "chr363",
    "chr364", "chr365", "chr367", "chr368", "chr369", "chr370", "chr371", "chr372",
    "chr373", "chr374", "chr375", "chr376", "chr377", "chr378", "chr379", "chr380",
    "chr382", "chr383", "chr385", "chr387", "chr388", "chr389", "chr390", "chr391",
    "chr392", "chr393", "chr394", "chr395", "chr396", "chr397", "chr398", "chr399",
    "chr400", "chr401", "chr402", "chr403", "chr404", "chr405", "chr406", "chr407",
    "chr408", "chr409", "chr410", "chr411", "chr412", "chr413", "chr414", "chr416",
    "chr417", "chr419", "chr420", "chr421", "chr422", "chr423", "chr424", "chr425",
    "chr426", "chr427", "chr428", "chr429", "chr431", "chr434", "chr435", "chr437",
    "chr438", "chr439", "chr440", "chr450", "chr451", "chr452", "chr453", "chr454",
    "chr455", "chr456", "chr457", "chr458", "chr461", "chr463", "chr465", "chr466",
    "chr474", "chr479", "chr484", "chr489", "chr490", "chr491", "chr492", "chr510",
    "chr512", "chr514", "chr515", "chr548", "chr563", "chr564", "chr567", "chr569",
    "chr573", "chr574", "chr575", "chr576", "chr577", "chr578", "chr579", "chr580",
    "chr582", "chr584", "chr586", "chr588", "chr590", "chr592", "chr594", "chr595",
    "chr596", "chr597", "chr598", "chr600", "chr601", "chr602", "chr603", "chr604",
    "chr605", "chr606", "chr607", "chr609", "chr610", "chr611", "chr613", "chr614",
    "chr615", "chr616", "chr617", "chr621", "chr622", "chr623", "chr626", "chr627",
    "chr629", "chr630", "chr631", "chr632", "chr669", "chr670", "chr675", "chr676",
    "chr677", "chr678", "chr679", "chr680", "chr681", "chr682", "chr683", "chr687",
    "chr688", "chr697", "chr698", "chr699", "chr700", "chr701", "chr702", "chr703",
    "chr704", "chr705", "chr706", "chr707", "chr708", "chr709", "chr710", "chr711",
    "chr716", "chr718", "chr719", "chr720", "chr721", "chr722", "chr723", "chr724",
    "chr725", "chr726", "chr727", "chr728", "chr729", "chr730", "chr731", "chr732",
    "chr733", "chr734", "chr735", "chr737", "chr738", "chr739", "chr740", "chr741",
    "chr742", "chr743", "chr744", "chr745", "chr747", "chr748", "chr749", "chr750",
    "chr751", "chr752", "chr753", "chr754", "chr755", "chr756", "chr757", "chr758",
    "chr759", "chr760", "chr766", "chr767", "chr770", "chr771", "chr772", "chr773",
    "chr774", "chr775", "chr776", "chr777", "chr778", "chr779", "chr800", "chr801",
    "chr802", "chr804", "chr805", "chr807", "chr808", "chr809", "chr810", "chr811",
    "chr866", "chr865", "chr864", "chr876", "chr877", "chr875", "chr874", "chr789",
    "chr921", "chr846", "chr845", "chr844", "chr843", "chr823", "chr841", "chr840",
    "chr839", "chr838", "chr837", "chr836", "chr835", "chr834", "chr833", "chr832",
    "chr827", "chr828", "chr829", "chr830", "chr831", "chr826", "chr825", "chr842",
    "chr940", "chr907", "chr908", "chr909", "chr939", "chr936", "chr493", "chr913",
    "chr915", "chr916", "chr917", "chr918", "chr919", "chr920", "chr494", "chr924",
    "chr925", "chr926", "chr949", "chr950", "chr930", "chr934", "chr931", "chr824",
    "chr937", "chr938", "chr948", "chr927", "chr928", "chr929", "chr932", "chr933",
    "chr935", "chr942", "chr944", "chr945", "chr946", "chr947", "chr906", "chr813",
    "chr818", "chr820", "chr815", "chr817", "chr819", "chr812", "chr821", "chr814",
    "chr822", "chr816"
  }
  
  -- Shuffle and pick unique random entries
  local selected = {}
  local used = {}
  
  for i = 1, count do
    local index
    repeat
      index = math.random(1, #allDigimon)
    until not used[index]
    
    used[index] = true
    table.insert(selected, allDigimon[index])
  end
  
  return selected
end

-- Helper function to extract numeric ID from chr string (e.g., "chr096" -> 96)
function GetNumericID(chrID)
  local substring = string.sub(chrID, 4)
  local numericID = tonumber(substring)
  print("GetNumericID: chrID =", chrID, "substring =", substring, "numericID =", numericID)
  return numericID
end

-- Helper function to get character model name from chr ID
function GetCharacterName(chrID)
  print("GetCharacterName called with:", chrID, "Type:", type(chrID))
  local chrToChar = {
    chr001 = "char_EX-TYRANOMON", chr002 = "char_LUNAMON", chr003 = "char_LEKISMON",
    chr004 = "char_CRESCEMON", chr005 = "char_GOLEMON", chr006 = "char_SKULLSATAMON",
    chr009 = "char_HAGURUMON", chr010 = "char_MERAMON", chr011 = "char_AIRDRAMON",
    chr012 = "char_GARURUMON", chr013 = "char_BAKEMON", chr014 = "char_STARMON",
    chr015 = "char_AQUILAMON", chr016 = "char_STRIKEDRAMON", chr017 = "char_MINOTAURMON",
    chr019 = "char_DORUGORAMON", chr020 = "char_TYUMON", chr021 = "char_WHAMON",
    chr023 = "char_DINOBEEMON", chr024 = "char_MARINEANGEMON", chr025 = "char_RAPTORDRAMON",
    chr026 = "char_GRADEMON", chr027 = "char_WARGREYMON", chr028 = "char_BIGMAMEMON",
    chr030 = "char_SANGLOUPMON", chr031 = "char_MATADRMON", chr032 = "char_GRANDDRACUMON",
    chr033 = "char_TRICERAMON", chr034 = "char_LILITHMON", chr035 = "char_BEELZEBUMON",
    chr036 = "char_BARBAMON", chr037 = "char_LEVIAMON", chr038 = "char_DEMON",
    chr039 = "char_LUCEMON_FM", chr040 = "char_BELPHEMON_RM", chr041 = "char_PANDAMON",
    chr042 = "char_FUNBEEMON", chr043 = "char_BLACKTAILMON", chr044 = "char_CATCHMAMEMON",
    chr045 = "char_CHRONOMON", chr046 = "char_CHRONOMON_DESTROY", chr047 = "char_MEGIDRAMON",
    chr048 = "char_GODDRAMON", chr049 = "char_BANCHOLEOMON", chr050 = "char_AGUMON",
    chr051 = "char_GAWAPPAMON", chr052 = "char_KAMEMON", chr053 = "char_KUDAMON",
    chr054 = "char_GEOGREYMON", chr055 = "char_GAOMON", chr056 = "char_LALAMON",
    chr057 = "char_ROSEMON", chr058 = "char_SUNFLOWMON", chr059 = "char_VOLCAMON",
    chr060 = "char_PILEVOLCAMON", chr061 = "char_MONZAEMON", chr068 = "char_GAOGAMON",
    chr069 = "char_PLATINUMNUMEMON", chr070 = "char_NUMEMON", chr071 = "char_RIZEGREYMON",
    chr072 = "char_LEOMON", chr073 = "char_LILAMON", chr074 = "char_MACHGAOGAMON",
    chr075 = "char_NEPTUNEMON", chr076 = "char_SHAWUJINMON", chr077 = "char_REPPAMON",
    chr078 = "char_GROWMON", chr079 = "char_SUPERSTARMON", chr080 = "char_MERCURYMON",
    chr081 = "char_IMPMON", chr082 = "char_HIPPOGRIFFOMON", chr083 = "char_GRIFFOMON",
    chr084 = "char_TYILINMON", chr085 = "char_VAMDEMON", chr086 = "char_SLEIPMON",
    chr087 = "char_ANGEMON", chr088 = "char_OMEGAMON", chr090 = "char_GUILMON",
    chr091 = "char_STINGMON", chr092 = "char_TAILMON", chr093 = "char_DEVIMON",
    chr094 = "char_SHINEGREYMON", chr095 = "char_MIRAGEGAOGAMON", chr096 = "char_PATAMON",
    chr097 = "char_PICODEVIMON", chr098 = "char_JUMBOGAMEMON", chr100 = "char_WENDIMON",
    chr101 = "char_HOLYANGEMON", chr102 = "char_TURUIEMON", chr103 = "char_GANIMON",
    chr104 = "char_SUSANOOMON", chr105 = "char_DUKEMON_CM", chr106 = "char_ARMAGEMON",
    chr107 = "char_LADYDEVIMON", chr111 = "char_GOBURIMON", chr112 = "char_DORUMON",
    chr113 = "char_GOLDNUMEMON", chr114 = "char_V-MON", chr115 = "char_BAOHUCKMON",
    chr116 = "char_SAVIORHUCKMON", chr117 = "char_VALDURMON", chr118 = "char_CHAOSMONVALDURARM",
    chr126 = "char_DUKEMON", chr127 = "char_KINGETEMON", chr128 = "char_TYRANTKABUTERIMON",
    chr129 = "char_DAGOMON", chr130 = "char_COELAMON", chr132 = "char_MEGASEADRAMON",
    chr133 = "char_WARUSEADRAMON", chr134 = "char_MEGAGROWLMON", chr135 = "char_METALGARURUMON",
    chr136 = "char_CORONAMON", chr137 = "char_FIRAMON", chr138 = "char_FLAREMON",
    chr139 = "char_LIGHDRAMON", chr140 = "char_WEREGARURUMON", chr141 = "char_HOLSMON",
    chr142 = "char_SHURIMON", chr144 = "char_DIGMON", chr145 = "char_SABMARIMON",
    chr146 = "char_PEGASMON", chr147 = "char_NEFERTIMON", chr148 = "char_ANGEWOMON",
    chr149 = "char_OROCHIMON", chr150 = "char_CHAOSDUKEMON", chr151 = "char_GABUMON",
    chr162 = "char_RANAMON", chr163 = "char_CALAMARAMON", chr168 = "char_JUPITERMON",
    chr169 = "char_JUPITERMON_WRATHMODE", chr170 = "char_JUNOMON", chr171 = "char_JUNOMON_HYSTERICMODE",
    chr172 = "char_VENUSMON", chr173 = "char_APOLLOMON", chr174 = "char_MARSMON",
    chr176 = "char_CERESMON", chr177 = "char_BLUEMERAMON", chr178 = "char_VULCANUSMON",
    chr179 = "char_BACCHUSMON", chr180 = "char_PLUTOMON", chr181 = "char_MERVAMON",
    chr183 = "char_AEGIOMON", chr184 = "char_AEGIOCHUSMON", chr185 = "char_AEGIOCHUSMON_DARK",
    chr186 = "char_AEGIOCHUSMON_HOLLY", chr187 = "char_AEGIOCHUSMON_BLUE", chr188 = "char_AEGIOCHUSMON_GREEN",
    chr189 = "char_CERESMON_MEDIUM", chr190 = "char_RYUDAMON", chr191 = "char_GINRYUMON",
    chr192 = "char_HISYARYUMON", chr193 = "char_OURYUMON", chr194 = "char_GUNDRAMON",
    chr195 = "char_BEELSTARMON", chr196 = "char_PUKUMON", chr197 = "char_CROSSMON",
    chr198 = "char_LOCOMON", chr199 = "char_ARCHNEMON", chr208 = "char_DRACOMON",
    chr209 = "char_COREDRAMON_GR", chr210 = "char_WINGDRAMON", chr211 = "char_GROUNDRAMON",
    chr213 = "char_SLAYERDRAMON", chr214 = "char_BREAKDRAMON", chr215 = "char_EXAMON",
    chr217 = "char_DARKSUPERSTARMON", chr218 = "char_COREDRAMON_BL", chr219 = "char_KOTEMON",
    chr220 = "char_MUSYAMON", chr222 = "char_DOBERMON", chr223 = "char_CERBERUMON",
    chr224 = "char_CERBERUMON_WEREWOLFMODE", chr225 = "char_ZANBAMON", chr226 = "char_MUMMYMON",
    chr227 = "char_PHARAOHMON", chr228 = "char_DELTAMON", chr229 = "char_CHIMAIRAMON",
    chr230 = "char_MILLENNIUMON", chr231 = "char_BAKUMON", chr232 = "char_SIRENMON",
    chr233 = "char_BELIALVAMDEMON", chr234 = "char_BEARMON", chr235 = "char_GRYZMON",
    chr237 = "char_ASTAMON", chr239 = "char_SKULLBALUCHIMON", chr240 = "char_OCTMON",
    chr241 = "char_CHOROMON", chr242 = "char_CAPROMON", chr301 = "char_MEGADRAMON",
    chr302 = "char_METALGREYMON", chr303 = "char_TENTOMON", chr304 = "char_KABUTERIMON",
    chr305 = "char_ATLURKABUTERIMON", chr306 = "char_HERCULESKABUTERIMON", chr307 = "char_PIYOMON",
    chr308 = "char_BIRDRAMON", chr309 = "char_GARUDAMON", chr310 = "char_HOUOUMON",
    chr311 = "char_ETEMON", chr312 = "char_METALETEMON", chr313 = "char_SUKAMON",
    chr314 = "char_VEGIMON", chr315 = "char_SERAPHIMON", chr316 = "char_DODOMON",
    chr317 = "char_BOTAMON", chr320 = "char_POYOMON", chr321 = "char_WANYAMON",
    chr322 = "char_KOROMON", chr325 = "char_TOKOMON", chr326 = "char_GREYMON",
    chr328 = "char_APOCLYMON", chr338 = "char_ANCIENTWISETMON", chr341 = "char_GUARDROMON",
    chr342 = "char_ANDROMON", chr343 = "char_GOMAMON", chr344 = "char_IKKAKUMON",
    chr345 = "char_ZUDOMON", chr346 = "char_VIKEMON", chr347 = "char_SEADRAMON",
    chr348 = "char_PALMON", chr349 = "char_TOGEMON", chr359 = "char_LILLYMON",
    chr361 = "char_PLOTMON", chr363 = "char_TYRANNOMON", chr364 = "char_METALTYRANNOMON",
    chr365 = "char_XV-MON", chr367 = "char_KUWAGAMON", chr368 = "char_SHELLMON",
    chr369 = "char_MONOCHROMON", chr370 = "char_YUKIDARUMON", chr371 = "char_MOJYAMON",
    chr372 = "char_CENTALMON", chr373 = "char_DRIMOGEMON", chr374 = "char_DIGITAMAMON",
    chr375 = "char_NANIMON", chr376 = "char_TONOSAMAGEKOMON", chr377 = "char_WIZARDMON",
    chr378 = "char_DELUMON", chr379 = "char_JYUREIMON", chr380 = "char_GERBEMON",
    chr382 = "char_MAGNAMON", chr383 = "char_RUSTTYRANOMON", chr385 = "char_MUGENDRAMON",
    chr387 = "char_BUBBMON", chr388 = "char_MOCHIMON", chr389 = "char_BETAMON",
    chr390 = "char_LUCEMON", chr391 = "char_RENAMON", chr392 = "char_WORMMON",
    chr393 = "char_WOODMON", chr394 = "char_ORGEMON", chr395 = "char_KYUBIMON",
    chr396 = "char_DORUGAMON", chr397 = "char_V-DRAMON", chr398 = "char_CLOCKMON",
    chr399 = "char_GEKOMON", chr400 = "char_AEROVEEDRAMON", chr401 = "char_OKUWAMON",
    chr402 = "char_GIGADRAMON", chr403 = "char_GRAPLEOMON", chr404 = "char_SKULLGREYMON",
    chr405 = "char_TAOMON", chr406 = "char_DEATHMERAMON", chr407 = "char_DORUGREYMON",
    chr408 = "char_PAILDRAMON", chr409 = "char_PANJYAMON", chr410 = "char_PICKLEMON",
    chr411 = "char_VADEMON", chr412 = "char_MAMEMON", chr413 = "char_METALMAMEMON",
    chr414 = "char_PARROTMON", chr416 = "char_ALPHAMON", chr417 = "char_ULFORCEVDRAMON",
    chr419 = "char_IMPERIALDRAMON_FM", chr420 = "char_IMPERIALDRAMON_PM", chr421 = "char_OPHANIMON",
    chr422 = "char_CHAOSDRAMON", chr423 = "char_GRANKUWAGAMON", chr424 = "char_SABERLEOMON",
    chr425 = "char_SAKUYAMON", chr426 = "char_HIANDROMON", chr427 = "char_PIEDMON",
    chr428 = "char_PINOCHIMON", chr429 = "char_PRINCEMAMEMON", chr431 = "char_BOLTMON",
    chr434 = "char_METALSEADRAMON", chr435 = "char_LUCEMON_SM", chr437 = "char_PUNIMON",
    chr438 = "char_TUNOMON", chr439 = "char_BELPHEMON_SM", chr440 = "char_TITAMON",
    chr450 = "char_PLESIOMON", chr451 = "char_EBEMON", chr452 = "char_CYCLONEMON",
    chr453 = "char_HOLYDRAMON", chr454 = "char_WASPMON", chr455 = "char_KARATUKINUMEMON",
    chr456 = "char_REVOLMON", chr457 = "char_DRACUMON", chr458 = "char_MONODRAMON",
    chr461 = "char_SKULLMAMMON", chr463 = "char_BLIMPMON", chr465 = "char_MASTERBLIMPMON",
    chr466 = "char_DORIMON", chr474 = "char_DINOHUMON", chr479 = "char_LOADERLIOMON",
    chr484 = "char_JEWELBEEMON", chr489 = "char_AGUMON_KIZUNA", chr490 = "char_GABUMON_KIZUNA",
    chr491 = "char_GREATGRYZMON", chr492 = "char_CHARISMON", chr493 = "char_UNDEADPLUTOMON",
    chr494 = "char_ENBARRMON_CRANIAMON", chr510 = "char_PYOCOMON", chr512 = "char_TANEMON",
    chr514 = "char_PUKAMON", chr515 = "char_NYAROMON", chr548 = "char_YUNIMON",
    chr563 = "char_ELECMON", chr564 = "char_ELECMON", chr567 = "char_PAGUMON",
    chr569 = "char_GAZIMON", chr573 = "char_HYOKOMON", chr574 = "char_BURAIMON",
    chr575 = "char_BUTEN", chr576 = "char_NANOMON", chr577 = "char_SHAMAMON",
    chr578 = "char_SNOWGOBURIMON", chr579 = "char_FUGAMON", chr580 = "char_HYOUGAMON",
    chr582 = "char_OTAMAMON", chr584 = "char_FANTOMON", chr586 = "char_FLYMON",
    chr588 = "char_MAMMON", chr590 = "char_RAREMON", chr592 = "char_DOKUGUMON",
    chr594 = "char_GIZAMON", chr595 = "char_GOTTSUMON", chr596 = "char_PUMPMON",
    chr597 = "char_SNIMON", chr598 = "char_TUSKMON", chr600 = "char_VENOMMYOTISMON",
    chr601 = "char_WITCHMON_ADD", chr602 = "char_MISTYMON", chr603 = "char_MEDIEVALDUKEMON",
    chr604 = "char_GRACENOVAMON", chr605 = "char_ANOMALOCARIMON", chr606 = "char_HANGYOMON",
    chr607 = "char_MUSHMON", chr609 = "char_KOKUWAMON", chr610 = "char_KIWIMON",
    chr611 = "char_FLORAMON", chr613 = "char_CLAVISANGEMON", chr614 = "char_SLASHANGEMON",
    chr615 = "char_MECHANORIMON", chr616 = "char_MAGNAKIDMON", chr617 = "char_AVENGEKIDMON",
    chr621 = "char_TANKMON", chr622 = "char_PENMON", chr623 = "char_MUCHOMON",
    chr626 = "char_KERAMON", chr627 = "char_INFERMON", chr629 = "char_KURAMON",
    chr630 = "char_KURISARIMON", chr631 = "char_TSUMEMON", chr632 = "char_DIABOROMON",
    chr669 = "char_ALDAMON", chr670 = "char_BEOWOLFMON", chr675 = "char_MAGNAGARURUMON_SEPARATION",
    chr676 = "char_AGNIMON", chr677 = "char_KAISERGREYMON", chr678 = "char_MAGNAGARURUMON",
    chr679 = "char_VRITRAMON", chr680 = "char_WOLFMON", chr681 = "char_GARUMMON",
    chr682 = "char_SHOUTMON", chr683 = "char_OMEGASHOUTMON", chr687 = "char_HACKMON",
    chr688 = "char_GANKOOMON", chr697 = "char_ZUBAMON", chr698 = "char_ZUBAEAGERMON",
    chr699 = "char_DURAMON", chr700 = "char_DURANDAMON", chr701 = "char_TERRIERMON",
    chr702 = "char_PECKMON", chr703 = "char_LOADKNIGHTMON", chr704 = "char_GROUNDLOCOMON",
    chr705 = "char_FALCOMON", chr706 = "char_HAWKMON", chr707 = "char_ARMADILLOMON",
    chr708 = "char_TOYAGUMON", chr709 = "char_SHAKOMON", chr710 = "char_GARGOMON",
    chr711 = "char_ANKYLOMON", chr716 = "char_FLAMEDRAMON", chr718 = "char_KNIGHTMON",
    chr719 = "char_CYBERDRAMON", chr720 = "char_SILPHYMON", chr721 = "char_YATAGARAMON",
    chr722 = "char_RAPIDMON", chr723 = "char_SHAKKOUMON", chr724 = "char_BRAKIMON",
    chr725 = "char_ULTIMATEBRAKIMON", chr726 = "char_WISEMON", chr727 = "char_CANNONBEEMON",
    chr728 = "char_SOLARMON", chr729 = "char_GEREMON", chr730 = "char_ICEDEVIMON",
    chr731 = "char_ANTYLAMON", chr732 = "char_IMPERIALDRAMON_DM", chr733 = "char_DIANAMON",
    chr734 = "char_CRANIAMON", chr735 = "char_KERPYMON_GOOD", chr737 = "char_JUSTIMON",
    chr738 = "char_DYNASMON", chr739 = "char_DUFTMON", chr740 = "char_RAVEMON",
    chr741 = "char_SAINTGALGOMON", chr742 = "char_LOTOSMON", chr743 = "char_DUFTMON_LM",
    chr744 = "char_GAIOMON", chr745 = "char_TIGERVESPAMON", chr747 = "char_MINERVAMON",
    chr748 = "char_MASTEMON", chr749 = "char_JESMON", chr750 = "char_LOPMON",
    chr751 = "char_RAPIDMON_ARMOR", chr752 = "char_PLATINUM_SCUMON", chr753 = "char_BLACKKINGNUMEMON",
    chr754 = "char_KUZUHAMON", chr755 = "char_SOCERIMON", chr756 = "char_INSEKIMON",
    chr757 = "char_OMEGAMON_ZWART", chr758 = "char_ICEMON", chr759 = "char_TUCHIDARUMON",
    chr760 = "char_GUARDROMON_GL", chr766 = "char_ALPHAMON_OURYUKEN", chr767 = "char_BACCHUSMON_DRUNK",
    chr770 = "char_TANKDRAMON", chr771 = "char_DARKDRAMON", chr772 = "char_CHAOSMON",
    chr773 = "char_VALKYRIMON", chr774 = "char_KERPYMON_BAD", chr775 = "char_BEELZEMON_BM",
    chr776 = "char_SHINEGREYMON_BM", chr777 = "char_MIRAGEGAOGAMON_BM", chr778 = "char_RAVEMON_BM",
    chr779 = "char_ROSEMON_BM", chr789 = "char_UKKOMON", chr800 = "char_VULCANUS_LIGHTARM",
    chr801 = "char_VULCANUS_LEFTARM", chr802 = "char_CHRONOMONROBO_COMPLETE", chr804 = "char_CHRONOMON_BOSS",
    chr805 = "char_BLACKSHADOW", chr807 = "char_POWER_LOADER", chr808 = "char_CHRONOMONROBO_COMPLETE",
    chr809 = "char_VULCANUS_LIGHTARM", chr810 = "char_VULCANUS_LEFTARM", chr811 = "char_SPECIAL_FORCES",
    chr812 = "char_SLEIPMON_BIG", chr813 = "char_DUKEMON_BIG", chr814 = "char_EXAMON_BIG",
    chr815 = "char_MAGNAMON_BIG", chr816 = "char_ALPHAMON_BIG", chr817 = "char_ULFORCEVDRAMON_BIG",
    chr818 = "char_LOADKNIGHTMON_BIG", chr819 = "char_CRANIAMON_BIG", chr820 = "char_DYNASMON_BIG",
    chr821 = "char_DUFTMON_BIG", chr822 = "char_JESMON_BIG", chr823 = "char_VULCANUSMON_GUEST_BIG",
    chr824 = "char_DIANAMON_BIG", chr825 = "char_CLAVISANGEMON_BIG", chr826 = "char_MAMMON_BIG",
    chr827 = "char_GUNDRAMON_BIG", chr828 = "char_BREAKDRAMON_BIG", chr829 = "char_PHARAOHMON_BIG",
    chr830 = "char_VENOMMYOTISMON_BIG", chr831 = "char_RAPIDMON_ARMOR_BIG", chr832 = "char_TYRANTKABUTERIMON_BIG",
    chr833 = "char_BARBAMON_BIG", chr834 = "char_DEMON_BIG", chr835 = "char_MILLENNIUMON_BIG",
    chr836 = "char_MUGENDRAMON_BIG", chr837 = "char_SKULLGREYMON_BIG", chr838 = "char_INFERMON_BIG",
    chr839 = "char_BELPHEMON_RM_BIG", chr840 = "char_LUCEMON_SM_BIG", chr841 = "char_BELPHEMON_SM_BIG",
    chr842 = "char_VULCANUSMON_ADD", chr843 = "char_LEVIAMON_BIG", chr844 = "char_ZANBAMON_BIG",
    chr845 = "char_BEELZEMON_BM_BIG", chr846 = "char_CHARISMON_LAST", chr864 = "char_CHRONOMON_BOSS_ADD_LEFTWING",
    chr865 = "char_CHRONOMON_BOSS_WING", chr866 = "char_CHRONOMON_BOSS_LEFTARM11", chr874 = "char_TOYAGUMON_BIG",
    chr875 = "char_ENBARRMON_BIG", chr876 = "char_JUPITERMON_WRATHMODE_SUB", chr877 = "char_GRACENOVAMON_SUB",
    chr906 = "char_EXAMON_SMALL", chr907 = "char_SHARKMON", chr908 = "char_SKULLSEADRAMON",
    chr909 = "char_SKULLSEADRAMON", chr913 = "char_GREYMON_BIG_BL_ADD", chr915 = "char_SKULLBALUCHIMON_TITAMON",
    chr916 = "char_UNDEADPLUTOMON_BOSS_ADD1", chr917 = "char_UNDEADPLUTOMON_BOSS_ADD2", chr918 = "char_UNDEADPLUTOMON_BOSS_ADD3",
    chr919 = "char_UNDEADPLUTOMON_BOSS_ADD4", chr920 = "char_ENBARRMON", chr921 = "char_ENBARRMON_CRANIAMON_E",
    chr924 = "char_BEARMON_OB", chr925 = "char_BEARMON_YB", chr926 = "char_PARROTMON_BIG_ADD",
    chr927 = "char_NEPTUNEMON_BIG", chr928 = "char_MERCURYMON_BIG", chr929 = "char_OMEGAMON_BIG",
    chr930 = "char_CALAMARAMON", chr931 = "char_APOLLOMON_BIG", chr932 = "char_CERESMON_BIG",
    chr933 = "char_PLUTOMON_BIG", chr934 = "char_JUPITERMON_BIG", chr935 = "char_JUPITERMON_WRATHMODE_BIG",
    chr936 = "char_METALGREYMON_BIG_BL", chr937 = "char_TITAMON", chr938 = "char_CYCLONEMON_BIG",
    chr939 = "char_RAREMON_BIG", chr940 = "char_SHARKMON_BOSS_ADD", chr942 = "char_KUWAGAMON_BIG",
    chr944 = "char_HANGYOMON_SCAR", chr945 = "char_HANGYOMON_SCARF", chr946 = "char_JYUREIMON_BIG",
    chr947 = "char_ANOMALOCARIMON_BIG", chr948 = "char_GRANKUWAGAMON_BIG", chr949 = "char_SKULLBALUCHIMON",
    chr950 = "char_TITAMON_ADD"
  }
  local result = chrToChar[chrID] or "char_UNKNOWN"
  print("GetCharacterName returning:", result, "for chrID:", chrID)
  return result
end

-- Global variables for random Digimon selection
local RANDOM_DIGIMON = {}
local RANDOM_CHR_NAMES = {}
local RANDOM_DIGIMON_IDS = {}

function m010_090()
  -- Initialize random Digimon selection (pick 3 random unique Digimon)
  RANDOM_DIGIMON = GetRandomDigimon(3)
  
  -- Debug: Print selected Digimon
  print("=== SELECTED RANDOM DIGIMON ===")
  print("Digimon 1:", RANDOM_DIGIMON[1])
  print("Digimon 2:", RANDOM_DIGIMON[2])
  print("Digimon 3:", RANDOM_DIGIMON[3])
  
  -- Store character model names for the random Digimon
  RANDOM_CHR_NAMES = {
    GetCharacterName(RANDOM_DIGIMON[1]),
    GetCharacterName(RANDOM_DIGIMON[2]),
    GetCharacterName(RANDOM_DIGIMON[3])
  }
  
  -- Debug: Print character names
  print("=== CHARACTER NAMES ===")
  print("Name 1:", RANDOM_CHR_NAMES[1])
  print("Name 2:", RANDOM_CHR_NAMES[2])
  print("Name 3:", RANDOM_CHR_NAMES[3])
  
  -- Store numeric IDs for the random Digimon
  RANDOM_DIGIMON_IDS = {
    GetNumericID(RANDOM_DIGIMON[1]),
    GetNumericID(RANDOM_DIGIMON[2]),
    GetNumericID(RANDOM_DIGIMON[3])
  }
  
  -- Debug: Print numeric IDs
  print("=== NUMERIC IDS ===")
  print("ID 1:", RANDOM_DIGIMON_IDS[1])
  print("ID 2:", RANDOM_DIGIMON_IDS[2])
  print("ID 3:", RANDOM_DIGIMON_IDS[3])
  
  Fade_Out(0, 0)
  EVENT_BEGIN()
  Talk.Load("m010")
  LOAD_VOICE()
  SetEventCutNo(9)
  if Debug.IsEventView() then
    SetTimeZone("Noon")
    SetTimeAxis("X2028_daft_10")
    LoadMap("d1003")
  end
  Flg.Set("FLAG_MAIN_01_070")
  Flg.Set("TUT_FLAG_4503")
  Flg.Set("TUT_FLAG_4505")
  Flg.Set("TUT_FLAG_4506")
  Flg.Set("TUT_FLAG_4507")
  Flg.Set("TUT_FLAG_4515")
  Flg.Set("TUT_FLAG_4517")
  Flg.Set("TUT_FLAG_4518")
  Flg.Set("TUT_FLAG_4519")
  Flg.Set("TUT_FLAG_4502")
  Flg.Set("TUT_FLAG_4530")
  Flg.Set("TUT_FLAG_4602")
  Flg.Set("TUT_FLAG_4604")
  Flg.Set("TUT_FLAG_4624")
  Flg.Set("TUT_FLAG_4625")
  Flg.Set("TUT_FLAG_4520")
  Flg.Set("TUT_FLAG_4521")
  Flg.Set("TUT_FLAG_4522")
  Flg.Set("TUT_FLAG_4523")
  Flg.Set("TUT_FLAG_4525")
  Flg.Set("TUT_FLAG_4526")
  Flg.Set("TUT_FLAG_4527")
  Flg.Set("TUT_FLAG_4528")
  Flg.Set("TUT_FLAG_4529")
  Flg.Set("TUT_FLAG_4531")
  Flg.Set("TUT_FLAG_4532")
  Flg.Set("TUT_FLAG_4533")
  Flg.Set("TUT_FLAG_4534")
  Flg.Set("TUT_FLAG_4535")
  Flg.Set("TUT_FLAG_4536")
  Flg.Set("TUT_FLAG_4537")
  Flg.Set("TUT_FLAG_4538")
  Flg.Set("TUT_FLAG_4539")
  Flg.Set("TUT_FLAG_4540")
  Flg.Set("TUT_FLAG_4541")
  Flg.Set("TUT_FLAG_4606")
  Flg.Set("TUT_FLAG_4607")
  Flg.Set("TUT_FLAG_4608")
  Flg.Set("TUT_FLAG_4609")
  Flg.Set("TUT_FLAG_4610")
  Flg.Set("TUT_FLAG_4611")
  Flg.Set("TUT_FLAG_4616")
  Flg.Set("TUT_FLAG_4617")
  Flg.Set("TUT_FLAG_4623")
  Flg.Set("TUT_FLAG_4701")
  Flg.Set("TUT_FLAG_4710")
  Flg.Set("TUT_FLAG_4734")
  Flg.Set("TUT_FLAG_4903")
  LoadModel("HERO_01", "Player")
  LoadModel("chr458_01", "char_MONODRAMON")
  LoadModel("chr595_01", "char_GOTTSUMON")
  LoadModel("chr081_01", "char_IMPMON")
  LoadSceneViewerResource("c1.0", "d1003f_ca")
  LoadSceneViewerResource("c2.0", "m010_090_c2.0")
  LoadSceneViewerResource("c3.0", "d1003f_ca")
  LoadSceneViewerResource("c4.0", "d1003f_ca")
  LoadSceneViewerResource("c5.0", "d1003f_ca")
  LoadSceneViewerResource("c6.0", "m010_090_c2.0")
  LoadSceneViewerResource("c7.0", "d1003f_ca")
  LoadSceneViewerResource("c8.0", "m010_090_c2.0")
  LoadSceneViewerResource("c9.0", "m010_090_c2.0")
  LoadEnvironmentFile("c1.0", "es_m010_090_c1.0")
  LoadEnvironmentFile("c2.0", "es_m010_090_c2.0")
  LoadEnvironmentFile("c3.0", "es_m010_090_c3.0")
  LoadEnvironmentFile("c4.0", "es_m010_090_c4.0")
  LoadEnvironmentFile("c5.0", "es_m010_090_c5.0")
  LoadEnvironmentFile("c6.0", "es_m010_090_c6.0")
  LoadEnvironmentFile("c7.0", "es_m010_090_c7.0")
  LoadEnvironmentFile("c8.0", "es_m010_090_c8.0")
  LoadEnvironmentFile("c9.0", "es_m010_090_c9.0")
  Load_DigiviceHologram()
  Load_PDigiSelectHologram()
  WaitVistaLoad()
  SetPosition("HERO_01", 125.716, 0.025, 37.018, "LINEAR", 0, 0)
  SetRotation("HERO_01", 0, -76.5, 0, "LINEAR", 0, 0)
  SetPosition("chr458_01", 104.771, 0.12, 27.559, "LINEAR", 0, 0)
  SetRotation("chr458_01", 0, 47.5, 0, "LINEAR", 0, 0)
  SetPosition("chr595_01", 105.808, 0.007, 26.576, "LINEAR", 0, 0)
  SetRotation("chr595_01", 0, 426, 0, "LINEAR", 0, 0)
  SetPosition("chr081_01", 104.016, 0.178, 25.813, "LINEAR", 0, 0)
  SetRotation("chr081_01", 0, 48.5, 0, "LINEAR", 0, 0)
  PlayMotion("HERO_01", "fn01_01", 0, true, 0)
  SetFace("HERO_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  SetBlink("HERO_01", 0, 1, 0)
  SetMouth("HERO_01", 1, 0, 0)
  PlayMotion("chr458_01", "fq01", 0, false, 0)
  PlayMotion("chr458_01", "fe02", 0, true, 60)
  PlayMotion("chr458_01", "bn01", 0, false, 120)
  PlayMotion("chr458_01", "fq02", 0, false, 150)
  PlayMotion("chr458_01", "bn01", 0, false, 210)
  PlayMotion("chr458_01", "fq01", 0, true, 240)
  SetFace("chr458_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr595_01", "fe02", 0, false, 0)
  PlayMotion("chr595_01", "bv01", 7, true, 42)
  PlayMotion("chr595_01", "bn01", 12, true, 152)
  PlayMotion("chr595_01", "fe03", 7, false, 182)
  PlayMotion("chr595_01", "fe04", 0, true, 272)
  SetFace("chr595_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr081_01", "bn01", 0, false, 0)
  PlayMotion("chr081_01", "fe04", 0, false, 60)
  PlayMotion("chr081_01", "fe02", 0, false, 126)
  PlayMotion("chr081_01", "bn01", 0, false, 186)
  PlayMotion("chr081_01", "fe04", 0, true, 216)
  SetFace("chr081_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  BlendEye("HERO_01", 5, -15, "SCURVE", 0, 0)
  BlendFace("HERO_01", -1, -45, 0, true, "SCURVE", 0, 0)
  BlendFaceDigi("chr458_01", -8, -90, 0, "SCURVE", 0, 0)
  SetEyeUVOffsetDigi("chr458_01", -0.011, 0, "SCURVE", 10, 0)
  BlendFaceDigi("chr458_01", -8, 10, 0, "SCURVE", 30, 0)
  SetEyeUVOffsetDigi("chr595_01", 0, -0, "SCURVE", 0, 0)
  BlendFaceDigi("chr595_01", 6, 29, 0, "SCURVE", 0, 0)
  SetEyeUVOffsetDigi("chr595_01", 0.012, -0.026, "SCURVE", 10, 10)
  BlendFaceDigi("chr595_01", 6, -18, 0, "SCURVE", 30, 15)
  BlendFaceDigi("chr081_01", 0, -90, 0, "SCURVE", 0, 0)
  BlendFaceDigi("chr081_01", 0, 0, 0, "SCURVE", 30, 0)
  Set_DigiviceHologram()
  Set_PDigiSelectHologram()
  SetCamera(112.235, 1.408, 30.987, 0, 30, "LINEAR", 0, false, 0, false)
  SetCameraTarget(103.88, 0.051, 25.861, "LINEAR", 0, false, 0, false)
  SetCamera(108.559, 1.341, 28.672, 0, 30, "SCURVE_B", 80, true, 0, false)
  SetCameraTarget(103.773, -0.01, 25.817, "SCURVE_B", 80, true, 0, false)
  SetEnv_All("c1.0", 0)
  FIELD_SET()
  NpcInvisible(FOR_ALL)
  Vista.GimmickObjectInvisible(FOR_ALL)
  Vista.Play()
  Vista.SetSkip(false, true)
  if not Flg.Check("FLAG_IS_LETTERBOX") then
    Talk.OpenLetterBox()
    Flg.Set("FLAG_IS_LETTERBOX")
    print("===================================")
    print("FLAG_IS_LETTERBOX_ON")
    print("===================================")
  end
  SetMobTransparentRange(20, 20, 20)
  CUT("1.0")
  Fade_In(0, FADE_TIME)
  WaitFrame(FADE_TIME)
  WaitFrame(80)
  CUT("2.0")
  SetEnv_All("c2.0", 0)
  SetCamera(125.032, 1.525, 37.146, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(125.876, 1.593, 36.906, "LINEAR", 0, false, 0)
  BlendEye("HERO_01", 9, -15, "SCURVE", 10, 0)
  BlendFace("HERO_01", -13, -45, 0, true, "SCURVE", 13, 0)
  WaitFrame(5)
  SetFace("HERO_01", "F16", 0, 1, FACE_BLENDTIME, 0)
  WaitFrame(40)
  CUT("3.0")
  SetEnv_All("c3.0", 0)
  ModelVisible("chr595_01", false, 0, 0)
  SetPosition("chr458_01", 104.771, 0.12, 27.34, "LINEAR", 0, 0)
  SetRotation("chr458_01", 0, 47.5, 0, "LINEAR", 0, 0)
  PlayMotion("chr595_01", "bn01", 0, true, 0)
  SetFace("chr595_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr081_01", "bn01", 0, true, 0)
  SetFace("chr081_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr458_01", "fq01", 0, false, 0)
  PlayMotion("chr458_01", "fe02", 5, true, 60)
  PlayMotion("chr458_01", "fq02", 7, false, 180)
  PlayMotion("chr458_01", "bn01", 7, false, 240)
  PlayMotion("chr458_01", "fq01", 5, true, 270)
  SetFace("chr458_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  SetCamera(106.447, 0.53, 26.871, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(103.384, 0.952, 27.906, "LINEAR", 0, false, 0)
  CameraOffsetMove(0.15, 0, 0, "LINEAR", true, true, 300, 0)
  WaitFrame(10)
  MessageTalk("m010_090_010")
  MessageClose()
  WaitFrame(10)
  CUT("4.0")
  SetEnv_All("c4.0", 0)
  PlayMotion("chr595_01", "bn01", 0, true, 0)
  SetFace("chr595_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr081_01", "fe02", 0, false, 0)
  PlayMotion("chr081_01", "fe04", 3, false, 60)
  PlayMotion("chr081_01", "fe02", 5, true, 126)
  PlayMotion("chr081_01", "fq02", 7, true, 186)
  PlayMotion("chr081_01", "ba01", 10, true, 246)
  PlayMotion("chr081_01", "fe04", 7, true, 298)
  SetFace("chr081_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr458_01", "bn01", 0, true, 0)
  SetCamera(105.752, 0.532, 26.693, 0, 27, "LINEAR", 0, false, 0)
  SetCameraTarget(103.716, 0.714, 25.621, "LINEAR", 0, false, 0)
  CameraOffsetMove(0.15, 0, 0, "LINEAR", true, true, 300, 0)
  WaitFrame(10)
  MessageTalk("m010_090_020")
  MessageClose()
  WaitFrame(10)
  PlayMotion("chr081_01", "bn01", 5, true, 0)
  CUT("5.0")
  SetEnv_All("c5.0", 0)
  ModelVisible("chr595_01", true, 0, 0)
  ModelVisible("chr081_01", false, 0, 0)
  SetPosition("chr595_01", 105.808, 0.007, 26.576, "LINEAR", 0, 0)
  SetRotation("chr595_01", 0, 426, 0, "LINEAR", 0, 0)
  SetScale("chr595_01", 0.9, 0.9, 0.9)
  PlayMotion("chr595_01", "fe02", 0, false, 0)
  PlayMotion("chr595_01", "bv01", 7, true, 42)
  PlayMotion("chr595_01", "bn01", 12, true, 152)
  PlayMotion("chr595_01", "fe03", 7, false, 182)
  PlayMotion("chr595_01", "fe04", 7, true, 272)
  SetFace("chr595_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr081_01", "bn01", 0, true, 0)
  PlayMotion("chr458_01", "bn01", 0, true, 0)
  SetCamera(106.979, 0.69, 27.969, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(105.787, 0.661, 26.31, "LINEAR", 0, false, 0)
  CameraOffsetMove(0.15, 0, 0, "LINEAR", true, true, 300, 0)
  WaitFrame(10)
  MessageTalk("m010_090_030")
  MessageClose()
  PlayMotion("HERO_01", "e200", 0, true, 0)
  SetStartFrame("HERO_01", "e200", 100, 0)
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_AGENT", "holo")
  Vista.SetModelAlpha("Horo_AGENT", 0.7)
  Vista.SetModelPhantom("Horo_AGENT", 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_AGENT", 0.2)
  Vista.SetAttachModelPos("Horo_AGENT", 0, -0.7, -0.4)
  Vista.SetAttachModelRot("Horo_AGENT", -30, 0, 0)
  ModelVisible("ATCdigivice00_01", true, 0, 0)
  PlayMotion("ATCdigivice00_01", "e200", 0, true, 0)
  SetStartFrame("ATCdigivice00_01", "e200", 100, 0)
  SetLoopFrame("ATCdigivice00_01", "e200", 100, 200)
  Vista.AttachEffectToModel("Horo_Effect", "ATCdigivice00_01", "holo")
  PlayEffect("Horo_Effect", true, 0)
  ModelVisible("Horo_AGENT", true, 0, 0)
  Vista.PlayDissolve("Horo_AGENT", 401)
  WaitFrame(30)
  CUT("6.0")
  SetEnv_All("c6.0", 0)
  ModelVisible("chr081_01", true, 0, 0)
  SetCamera(125.023, 1.404, 37.65, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(125.615, 1.478, 37.031, "LINEAR", 0, false, 0)
  BlendEye("HERO_01", 9, -15, "SCURVE", 0, 0)
  BlendFace("HERO_01", -53, -45, 0, true, "SCURVE", 0, 0)
  BlendEye("HERO_01", 16, -5, "SCURVE", 15, 10)
  BlendFace("HERO_01", -0, -0, 0, false, "SCURVE", 30, 0)
  SetFace("HERO_01", "E01_M15", 0, 1, 0, 0)
  WaitFrame(10)
  PlayMotion("Horo_AGENT", "e023", 5, false, 0)
  EndMotion("Horo_AGENT", 100)
  MessageTalk("m010_090_040")
  MessageClose()
  WaitFrame(10)
  SetPosition("chr458_01", 104.771, 0.12, 27.49, "LINEAR", 0, 0)
  SetRotation("chr458_01", 0, 164.5, 0, "LINEAR", 0, 0)
  CUT("7.0")
  SetEnv_All("c7.0", 0)
  SetPosition("chr458_01", 104.771, 0.12, 27.559, "LINEAR", 0, 0)
  SetRotation("chr458_01", 0, 47.5, 0, "LINEAR", 0, 0)
  SetPosition("chr595_01", 105.531, 0.007, 26.487, "LINEAR", 0, 0)
  SetRotation("chr595_01", 0, 426, 0, "LINEAR", 0, 0)
  SetCamera(108.087, 1.423, 28.65, 0, 30, "LINEAR", 0, false, 0, false)
  SetCameraTarget(103.638, 0.167, 25.996, "LINEAR", 0, false, 0, false)
  SetCamera(107.76, 1.331, 28.455, 0, 30, "LINEAR", 180, true, 0, false)
  SetCameraTarget(103.638, 0.167, 25.996, "LINEAR", 180, true, 0, false)
  BlendFaceDigi("chr595_01", 0, -12, 0, "SCURVE", 0, 0)
  BlendFaceDigi("chr458_01", -8, 16, 0, "SCURVE", 0, 0)
  PlayMotion("chr458_01", "fq01", 0, false, 0)
  PlayMotion("chr458_01", "fe02", 5, true, 60)
  PlayMotion("chr458_01", "bn01", 7, false, 120)
  PlayMotion("chr458_01", "fq02", 7, false, 150)
  PlayMotion("chr458_01", "bn01", 7, false, 210)
  PlayMotion("chr458_01", "fq01", 7, true, 240)
  SetFace("chr458_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr595_01", "fe02", 0, false, 0)
  SetStartFrame("chr595_01", "fe02", 0, 0)
  PlayMotion("chr595_01", "bv01", 7, true, 42)
  PlayMotion("chr595_01", "bn01", 12, true, 152)
  PlayMotion("chr595_01", "fe03", 0, false, 182)
  PlayMotion("chr595_01", "fe04", 0, true, 272)
  SetFace("chr595_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  PlayMotion("chr081_01", "bn01", 0, false, 0)
  PlayMotion("chr081_01", "fe04", 0, false, 60)
  PlayMotion("chr081_01", "fe02", 0, false, 126)
  PlayMotion("chr081_01", "bn01", 0, false, 186)
  PlayMotion("chr081_01", "fe04", 0, true, 216)
  SetFace("chr081_01", "F01", 0, 1, FACE_BLENDTIME, 0)
  WaitFrame(10)
  MessageTalk("m010_090_050")
  MessageClose()
  WaitFrame(10)
  CUT("8.0")
  SetEnv_All("c8.0", 0)
  SetCamera(125.023, 1.404, 37.65, 0, 30, "LINEAR", 0, false, 0)
  SetCameraTarget(125.615, 1.478, 37.031, "LINEAR", 0, false, 0)
  SetFace("HERO_01", "F15", 0, 1, 0, 0)
  PlayMotion("Horo_AGENT", "e013", 5, true, 0)
  WaitFrame(10)
  if 1 <= Common.GetGameClearNum() then
    MessageTalk("m010_090_090")
    MessageTalk("m010_090_100")
    EndMotion("Horo_AGENT", 0)
    MessageClose()
    WaitFrame(10)
    Vista.PlayDissolve("Horo_AGENT", 402)
    WaitFrame(30)
  else
    MessageTalk("m010_090_060")
    EndMotion("Horo_AGENT", 0)
    MessageClose()
    WaitFrame(10)
    CUT("9.0")
    SetEnv_All("c9.0", 0)
    SetCamera(126.021, 1.603, 37.438, 0, 20, "LINEAR", 0, false, 0)
    SetCameraTarget(125.594, 1.487, 37.203, "LINEAR", 0, false, 0)
    WaitFrame(10)
    PlayMotion("Horo_AGENT", "e002", 5, true, 0)
    MessageTalk("m010_090_070")
    MessageClose()
    Talk.CloseLetterBox()
    Vista.PlayDissolve("Horo_AGENT", 402)
    WaitFrame(30)
    Vista.SetAttachEffectScale("Horo_Effect", 1.5, true)
    SetCamera(125.632, 1.436, 37.316, 0, 40, "LINEAR", 0, false, 0)
    SetCameraTarget(124.995, 1.318, 36.699, "LINEAR", 0, false, 0)
    WaitFrame(10)
    Play_PDigiSelectHologram()
    local digirotate = 0
    local padctrl = 0
    local selectpartner = 0
    local selectdigimon = ""
    Story.StartEventSelectDigimon(RANDOM_DIGIMON_IDS[1], 1, 15, 74, -1)
    Event_PlaySE(102001, 100, 0, 0, 0)
    while true do
      if padctrl == 0 then
        if Work.IsPushKey("RIGHT") then
          digirotate = digirotate + 1
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[3], 503)
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[2], 503)
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[1], 503)
          WaitFrame(15)
          padctrl = 1
        elseif Work.IsPushKey("LEFT") then
          digirotate = digirotate - 1
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[3], 503)
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[2], 503)
          Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[1], 503)
          WaitFrame(15)
          padctrl = 1
        end
      end
      if padctrl == 1 then
        if digirotate < 0 then
          digirotate = 2
        elseif digirotate > 2 then
          digirotate = 0
        end
        if digirotate == 0 then
          ModelVisible("Horo_" .. RANDOM_DIGIMON[1], true, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[2], false, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[3], false, 0, 0)
          Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[1], 0.5)
          Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[1], 0.085)
          Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[1], 0, 0.6, 0.2)
          Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[1], -32, -10, 10)
          selectpartner = 0
          Story.SetEventSelectDigimon(RANDOM_DIGIMON_IDS[1], 1, 15, 74, -1)
        elseif digirotate == 1 then
          ModelVisible("Horo_" .. RANDOM_DIGIMON[1], false, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[2], true, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[3], false, 0, 0)
          Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[2], 0.5)
          Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[2], 0.145)
          Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[2], 0.1, 0.2, 0.05)
          Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[2], -32, -10, 10)
          selectpartner = 1
          Story.SetEventSelectDigimon(RANDOM_DIGIMON_IDS[2], 1, 14, 70, -1)
        elseif digirotate == 2 then
          ModelVisible("Horo_" .. RANDOM_DIGIMON[1], false, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[2], false, 0, 0)
          ModelVisible("Horo_" .. RANDOM_DIGIMON[3], true, 0, 0)
          Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[3], 0.5)
          Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[3], 0.1)
          Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[3], 0, 0.55, 0.2)
          Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[3], -32, -10, 10)
          selectpartner = 2
          Story.SetEventSelectDigimon(RANDOM_DIGIMON_IDS[3], 1, 4, 17, -1)
        end
        Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[3], 501)
        Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[2], 501)
        Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[1], 501)
        WaitFrame(15)
        padctrl = 0
      end
      if Work.IsPushKey("DECIDE") then
        Story.OpenDigimonYNWindow()
        local yn_result = 0
        while true do
          WaitFrame(1)
          yn_result = Story.GetResultDigimonYNWindow()
          if yn_result == 0 then
          else
            break
          end
        end
        if yn_result == 1 then
          break
        end
      end
      WaitFrame(Util.SecondFromFrame(1))
    end
    Event_PlaySE(300006, 100, 0, 0, 0)
    Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[3], 503)
    Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[2], 503)
    Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[1], 503)
    WaitFrame(10)
    ModelVisible("Horo_" .. RANDOM_DIGIMON[3], false, 0, 0)
    ModelVisible("Horo_" .. RANDOM_DIGIMON[2], false, 0, 0)
    ModelVisible("Horo_" .. RANDOM_DIGIMON[1], false, 0, 0)
    if selectpartner == 0 then
      Party.Digimon.Add(RANDOM_DIGIMON_IDS[1], 1, 15, 74)
      Flg.Set("FLAG_IS_SELECT_DIGIMON_DATA")
      Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[1], 0.085)
      Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[1], 0, 0.6, 0.2)
      Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[1], -32, -10, 10)
      selectdigimon = "DECIDE_" .. RANDOM_DIGIMON[1]
    elseif selectpartner == 1 then
      Party.Digimon.Add(RANDOM_DIGIMON_IDS[2], 1, 15, 61)
      Flg.Set("FLAG_IS_SELECT_DIGIMON_VIRUS")
      Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[2], 0.145)
      Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[2], 0.1, 0.2, 0.05)
      Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[2], -32, -10, 10)
      selectdigimon = "DECIDE_" .. RANDOM_DIGIMON[2]
    elseif selectpartner == 2 then
      Party.Digimon.Add(RANDOM_DIGIMON_IDS[3], 1, 4, 17)
      Flg.Set("FLAG_IS_SELECT_DIGIMON_VACCINE")
      Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[3], 0.1)
      Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[3], 0, 0.6, 0.2)
      Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[3], -32, -10, 10)
      selectdigimon = "DECIDE_" .. RANDOM_DIGIMON[3]
    end
    print("=========selectdigimon===========", selectdigimon)
    WaitFrame(5)
    ModelVisible(selectdigimon, true, 0, 0)
    Vista.PlayDissolve(selectdigimon, 502)
    WaitFrame(50)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[1], "fe02", 5, true, 0)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[2], "fe02", 5, true, 0)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[3], "fe02", 5, true, 0)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[1], "bn01", 5, true, 65)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[2], "bn01", 5, true, 100)
    PlayMotion("DECIDE_" .. RANDOM_DIGIMON[3], "bn01", 5, true, 73)
    WaitFrame(80)
    Story.EndEventSelectDigimon()
    SetCamera(126.626, 1.824, 38.052, 0, 20, "LINEAR", 0, false, 0)
    SetCameraTarget(125.594, 1.487, 37.203, "LINEAR", 0, false, 0)
    ModelVisible(selectdigimon, false, 30, 0)
    WaitFrame(40)
  end
  Close_PDigiSelectHologram()
  WaitFrame(20)
  FadeOutWithWaitNotFlgCheck(0, FADE_TIME)
  if 1 <= Common.GetGameClearNum() then
    Talk.CloseLetterBox()
  end
  Vista.SetSkip(false, true)
  Flg.Clear("FLAG_IS_LETTERBOX")
  Event_Quake_Stop(0)
  TalkExit()
  VistaExit()
  Field_CancelInvisiblePlayer(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllGuest(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleFollowerAllPartyMember(INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleNpc("", INVISIBLE_KEY_EVENT, 0, true, false)
  Field_CancelInvisibleAllSymbolEnemy(INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleRumorNpc(FOR_ALL, INVISIBLE_KEY_EVENT, 0, false, false)
  Field_CancelInvisibleMob(FOR_ALL, INVISIBLE_KEY_EVENT, 0, true, false)
  local field_player_index = Field.GetPlayerIndex()
  if field_player_index then
    Field.ObjectResetAim(FLD_OBJ_PLAYER, field_player_index, 0)
  end
end

function CUT(cut_no)
  CUT_START(cut_no)
end

function main()
  m010_090()
end

function Load_PDigiSelectHologram()
  -- Load models using random Digimon selections
  LoadModel("Horo_" .. RANDOM_DIGIMON[1], RANDOM_CHR_NAMES[1])
  LoadModel("Horo_" .. RANDOM_DIGIMON[2], RANDOM_CHR_NAMES[2])
  LoadModel("Horo_" .. RANDOM_DIGIMON[3], RANDOM_CHR_NAMES[3])
  LoadModel("DECIDE_" .. RANDOM_DIGIMON[1], RANDOM_CHR_NAMES[1])
  LoadModel("DECIDE_" .. RANDOM_DIGIMON[2], RANDOM_CHR_NAMES[2])
  LoadModel("DECIDE_" .. RANDOM_DIGIMON[3], RANDOM_CHR_NAMES[3])
  LoadObject("ATCdigivice00_01", "ATCdigivice00")
  Vista.LoadDissolve("Horo_" .. RANDOM_DIGIMON[3], 501)
  Vista.LoadDissolve("Horo_" .. RANDOM_DIGIMON[2], 501)
  Vista.LoadDissolve("Horo_" .. RANDOM_DIGIMON[1], 501)
  Vista.LoadDissolve("DECIDE_" .. RANDOM_DIGIMON[1], 501)
  Vista.LoadDissolve("DECIDE_" .. RANDOM_DIGIMON[2], 501)
  Vista.LoadDissolve("DECIDE_" .. RANDOM_DIGIMON[3], 501)
  Vista.LoadAnimation("HERO_01", "e200")
  Vista.LoadAnimation("ATCdigivice00_01", "e200")
  Vista.LoadAnimation("DECIDE_" .. RANDOM_DIGIMON[1], "fq01")
  Vista.LoadAnimation("DECIDE_" .. RANDOM_DIGIMON[2], "fq01")
  Vista.LoadAnimation("DECIDE_" .. RANDOM_DIGIMON[3], "fq01")
end

function Set_PDigiSelectHologram()
  PlayMotion("Horo_" .. RANDOM_DIGIMON[3], "bn01", 0, true, 0)
  PlayMotion("Horo_" .. RANDOM_DIGIMON[2], "bn01", 0, true, 0)
  PlayMotion("Horo_" .. RANDOM_DIGIMON[1], "bn01", 0, true, 0)
  PlayMotion("DECIDE_" .. RANDOM_DIGIMON[1], "bn01", 0, true, 0)
  PlayMotion("DECIDE_" .. RANDOM_DIGIMON[2], "bn01", 0, true, 0)
  PlayMotion("DECIDE_" .. RANDOM_DIGIMON[3], "bn01", 0, true, 0)
  ModelVisible("Horo_" .. RANDOM_DIGIMON[3], false, 0, 0)
  ModelVisible("Horo_" .. RANDOM_DIGIMON[2], false, 0, 0)
  ModelVisible("Horo_" .. RANDOM_DIGIMON[1], false, 0, 0)
  ModelVisible("DECIDE_" .. RANDOM_DIGIMON[1], false, 0, 0)
  ModelVisible("DECIDE_" .. RANDOM_DIGIMON[2], false, 0, 0)
  ModelVisible("DECIDE_" .. RANDOM_DIGIMON[3], false, 0, 0)
  AttachObject("HERO_01", "ATCdigivice00_01", "9")
  ModelVisible("ATCdigivice00_01", false, 0, 0)
end

function Play_PDigiSelectHologram()
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_" .. RANDOM_DIGIMON[3], "holo")
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_" .. RANDOM_DIGIMON[2], "holo")
  Vista.AttachModelToModel("ATCdigivice00_01", "Horo_" .. RANDOM_DIGIMON[1], "holo")
  Vista.AttachModelToModel("ATCdigivice00_01", "DECIDE_" .. RANDOM_DIGIMON[1], "holo")
  Vista.AttachModelToModel("ATCdigivice00_01", "DECIDE_" .. RANDOM_DIGIMON[2], "holo")
  Vista.AttachModelToModel("ATCdigivice00_01", "DECIDE_" .. RANDOM_DIGIMON[3], "holo")
  Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[1], 0.5)
  Vista.SetModelPhantom("Horo_" .. RANDOM_DIGIMON[1], 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[1], 0.085)
  Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[1], 0, 0.6, 0.2)
  Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[1], -32, -10, 10)
  Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[2], 0.7)
  Vista.SetModelPhantom("Horo_" .. RANDOM_DIGIMON[2], 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[2], 0.05)
  Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[2], 0.5, 1.3, -2.2)
  Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[2], -30, -20, 0)
  Vista.SetModelAlpha("Horo_" .. RANDOM_DIGIMON[3], 0.7)
  Vista.SetModelPhantom("Horo_" .. RANDOM_DIGIMON[3], 0.3, 0.9, 1)
  Vista.SetAttachModelScale("Horo_" .. RANDOM_DIGIMON[3], 0.022)
  Vista.SetAttachModelPos("Horo_" .. RANDOM_DIGIMON[3], 5, -0.4, 0.1)
  Vista.SetAttachModelRot("Horo_" .. RANDOM_DIGIMON[3], -20, -50, 30)
  Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[1], 0.07)
  Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[1], 0, 0.5, 0.2)
  Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[1], -30, 0, 0)
  Vista.AttachModelToModel("ATCdigivice00_01", "DECIDE_" .. RANDOM_DIGIMON[2], "holo")
  Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[2], 0.05)
  Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[2], 1.3, 0.8, -1.9)
  Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[2], -30, 0, 0)
  Vista.AttachModelToModel("ATCdigivice00_01", "DECIDE_" .. RANDOM_DIGIMON[3], "holo")
  Vista.SetAttachModelScale("DECIDE_" .. RANDOM_DIGIMON[3], 0.03)
  Vista.SetAttachModelPos("DECIDE_" .. RANDOM_DIGIMON[3], 5.8, -0.5, 1)
  Vista.SetAttachModelRot("DECIDE_" .. RANDOM_DIGIMON[3], -30, 0, 0)
  Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[1], 501)
  Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[2], 501)
  Vista.PlayDissolve("Horo_" .. RANDOM_DIGIMON[3], 501)
  ModelVisible("Horo_" .. RANDOM_DIGIMON[1], true, 0, 0)
end

function Close_PDigiSelectHologram()
  WaitFrame(5)
  EndMotion("HERO_01", 0)
  EndMotion("ATCdigivice00_01", 0)
  WaitFrame(10)
  Event_PlaySE(401053, 100, false, 0, 0)
  ModelVisible("Horo_Effect", false, 15, 0)
  ENDMOTION_WAIT("HERO_01", 0)
  ModelVisible("ATCdigivice00_01", false, 0, 0)
end

function PositionChange(manage_name)
  local countX = 0
  local countY = 0
  local countZ = 0
  while true do
    if Work.IsPushKey("UP") then
      countX = countX + 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("DOWN") then
      countX = countX - 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("RIGHT") then
      countZ = countZ + 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("LEFT") then
      countZ = countZ - 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("DECIDE") then
      countY = countY + 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("CANCEL") then
      countY = countY - 0.1
      Vista.SetAttachModelPos(manage_name, countX, countY, countZ)
    end
    print("===Xpara===", countX)
    print("===Ypara===", countY)
    print("===Zpara===", countZ)
    WaitFrame(Util.SecondFromFrame(1))
  end
end

function AngleChange(manage_name)
  local countX = 0
  local countY = 0
  local countZ = 0
  while true do
    if Work.IsPushKey("UP") then
      countX = countX + 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("DOWN") then
      countX = countX - 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("RIGHT") then
      countZ = countZ + 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("LEFT") then
      countZ = countZ - 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("DECIDE") then
      countY = countY + 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    elseif Work.IsPushKey("CANCEL") then
      countY = countY - 1
      Vista.SetAttachModelRot(manage_name, countX, countY, countZ)
    end
    print("===Xpara===", countX)
    print("===Ypara===", countY)
    print("===Zpara===", countZ)
    WaitFrame(Util.SecondFromFrame(1))
  end
end
