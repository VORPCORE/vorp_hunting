------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- VORP HUNTING SCRIPT ------------------------------------------------------------------------

Config = {}

Config.DevMode = false -- DIABLE THIS IF YOUR SERVER IS LIVE

Config.Linux = false -- If they use a Linux server, then true

Config.butcherfunction = true -- set to true if you want to use butcher functions
----------------------------- TRANSLATE HERE -------------------------------------
Config.Language = {
    NotHoldingAnimal = "Je hebt niets om te verkopen",
    NotInTheButcher = "Dat dier koop ik niet",
    AnimalSold = "Bedankt voor de deal die je hebt ",
    SkinnableAnimalstowed = "Je kreeg ",
    stow = "Opbergen",
    press = "Druk",
    sell = "Verkoop",
    notabutcher = "Je hebt niet de juiste job",
    dollar = " $",
    join = " en ",
    FullInventory = "Voorraad is te vol."
}


------------------- PROMPT -----------------
Config.keys = {
    G = 0x760A9C6F, -- butcher sell and Stow
}

Config.aiButcherped = true -- spawn ai butched ped set to false if you dont want an ai butcher ped to spawn

Config.joblocked = false -- lock the butcher so only people with the job can access. u can change access to each butcher by editing this  butcherjob = "butcher"

Config.maxpelts = 2 -- max pelts allowed on back of horse

------------------- Item Quantity Instructions -----------------
-- The range for when a skinnableAnimal or Animal has a config value givenAmount of 0.
-- Example: Animals with givenAmount = {0} can be sold to the butcher or be skinned, which will give the player a random number between 1 and 3 amount of givenItem
Config.ItemQuantity = {
    Max = 3,
    Min = 1
}


Config.Butchers = {
    { butchername = "Valentine Slager",   butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(-339.0141, 767.6358, 115.5645),   heading = 100.41544342041,  radius = 3.0, showblip = true },
    { butchername = "Strawberry Slager",  butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(-1753.143, -392.4201, 155.2578),  heading = 181.37438964844,  radius = 3.0, showblip = true },
    { butchername = "Blackwater Slager",  butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(-754.0, -1285.158, 43.03),        heading = 273.579,          radius = 3.0, showblip = true },
    { butchername = "Annesburg Slager",   butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(2934.51, 1301.159, 43.48365),     heading = 70.572128295898,  radius = 3.0, showblip = true },
    { butchername = "Van Horn Slager",    butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(2991.844, 572.0218, 43.36182),    heading = 259.52850341797,  radius = 3.0, showblip = true },
    { butchername = "Rhodes Slager",      butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(1297.578, -1277.589, 74.88102),   heading = 146.60472106934,  radius = 3.0, showblip = true },
    { butchername = "Armadillo Slager",   butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(-3691.438, -2623.152, -14.75121), heading = 0.46632757782936, radius = 3.0, showblip = true },
    { butchername = "Tumbleweed Slager",  butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(-5510.371, -2947.005, -1.894515), heading = 251.54911804199,  radius = 3.0, showblip = true },
    { butchername = "Landing Slager",     butcherjob = "butcher", blip = 1369919445, npcmodel = "CS_MP_SHAKY",          coords = vector3(-1435.61, -2330.28, 43.66),       heading = 1.15,             radius = 4.0, showblip = true },
    { butchername = "Saint Denis Slager", butcherjob = "butcher", blip = 1369919445, npcmodel = "S_M_M_UNIBUTCHERS_01", coords = vector3(2819.54, -1331.21, 45.00),        heading = 51.8221321532,    radius = 4.0, showblip = true }
}

-----------------ANIMAL INSTRUCTIONS  -----------------
-- 1. To add more rewards on each animal, edit the givenItem table. For example change givenItem ={ "meat"}, to givenItem ={ "meat","feathers"}
-- 2. If using more than one item in givenItem, then you must add another value to givenAmount. For example change givenAmount ={0}, to givenAmount ={0,0}
-- 3. givenAmount = {0} will set an amount to random amount between ItemQuantity Max/Min
-- 4. givenAmount = {{2,5}} will set an amount to random between the first and second numbers in the supplied table, for the corresponding givenItem.
-- For example: givenItem = {"meat", "feathers", "claws", "beak"}, givenAmount = {{1,4}, {2,5}, 0, 1} will result in 1 to 4 "meat", 2 to 5 "feathers", ItemQuantity.Min to ItemQuanity.Max "claws" and 1 "beak".

----------------- !IMPORTANT! -----------------
-- TO ADD MORE ANIMALS AND FIND HASHES, HOLD ANIMALS OR PELTS AND DO /ANIMAL command
-- YOU CAN SEE WHAT ANIMAL HASH YOU Skined/plucked/stored IN THE f6/f8 logs.
-- THE ITEMS NAME MUST BE IN YOUR DATABASE FOR YOU TO RECEIVE THEM IN YOUR INVENTORY

-- Animals that are skinned/plucked/stored
Config.SkinnableAnimals = {
    --small animals skin them and sell them at the butcher no need to add them to  CONFIG.ANIMALS
    [989669666]   = { name = "Rat", givenItem = { "meat" }, givenAmount = { 1 }, givenDisplay = {}, money = 100, gold = 0, rolPoints = 0, xp = 1 },
    [1458540991]  = { name = "Wasbeer", givenItem = { "pelt" }, givenAmount = { 2 }, givenDisplay = {}, money = 100, gold = 0, rolPoints = 0, xp = 1 },
    [-1003616053] = { name = "Eend", givenItem = { "feathers" }, givenAmount = { 0 }, givenDisplay = {}, money = 100, gold = 0, rolPoints = 0, xp = 1 },

    -- big animals when you skin them it gives you items. if you have it added TO CONFIG.ANIMALS JUST COPY PASTE HERE AND REMOVE THE GIVE MONEY ETC LIKE SHOWN BELOW.
    [1110710183]  = { name = "Hert", givenItem = { "meat" }, givenAmount = { 0 }, givenDisplay = {}, money = 0, gold = 0, rolPoints = 0, xp = 1 },
    [-1124266369] = { name = "Beer", givenItem = { "bearHeart", "bearClaws" }, givenAmount = { 1, 3 }, givenDisplay = { "Heart", "Claw"}, money = 0, gold = 0, rolPoints = 0, xp = 1 },
}

-- Animals that are traded in to the butcher
Config.Animals = {
    -- Animals
    [-1124266369]  = { name = "Beer", givenItem = { "meat" }, givenAmount = { 0 }, money = 100, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 957520252, good = 143941906, perfect = 1292673537 },
    [-15687816381] = { name = "Grote Hoorn Ram", givenItem = { "meat" }, givenAmount = { 0 }, money = 50, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1796037447, good = -476045512, perfect = 1795984405 },
    [2028722809]   = { name = "Zwijn", givenItem = { "meat" }, givenAmount = { 0 }, money = 4, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1248540072, good = nil, perfect = -1858513856 },
    [-1963605336]  = { name = "Bok", givenItem = { "meat" }, givenAmount = { 0 }, money = 7, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1603936352, good = -868657362, perfect = -702790226 },
    [1556473961]   = { name = "Bizon", givenItem = { "meat" }, givenAmount = { 0 }, money = 40, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -1730060063, good = -591117838, perfect = -237756948 },
    [1957001316]   = { name = "Stier", givenItem = { "meat" }, givenAmount = { 0 }, money = 40, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 9293261, good = -336086818, perfect = -53270317 },
    [1110710183]   = { name = "Hert", givenItem = { "meat" }, givenAmount = { 0 }, money = 10, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -662178186, good = -1827027577, perfect = -1035515486 },
    [-1003616053]  = { name = "Eend", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1459778951]   = { name = "Arend", givenItem = { "feathers" }, givenAmount = { 0 }, money = 5, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [831859211]    = { name = "Reiger", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-2021043433]  = { name = "Eland", givenItem = { "meat" }, givenAmount = { 0 }, money = 10, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 2053771712, good = 1181652728, perfect = -1332163079 },
    [252669332]    = { name = "Amerikaanse rode vos", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1647012424, good = 238733925, perfect = 500722008 },
    [-1143398950]  = { name = "Grote grijze wolf", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 85441452, good = 1145777975, perfect = 653400939 },
    [-885451903]   = { name = "Middelgrote grijze wolf", givenItem = { "meat" }, givenAmount = { 0 }, money = 6, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 85441452, good = 1145777975, perfect = 653400939 },
    [-829273561]   = { name = "Kleine grijze wolf", givenItem = { "meat" }, givenAmount = { 0 }, money = 6, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 85441452, good = 1145777975, perfect = 653400939 },
    [1104697660]   = { name = "Gier", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-407730502]   = { name = "Bijtende Schildpad", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-466054788]   = { name = "Wilde kalkoen", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-2011226991]  = { name = "Wilde kalkoen", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-166054593]   = { name = "Wilde kalkoen", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-229688157]   = { name = "Waterslang", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1790499186]  = { name = "Rode Boa", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1464167925]   = { name = "Fer-De-Lance Slang", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [846659001]    = { name = "Ratelslang met zwarte staart", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [545068538]    = { name = "Westerse ratelslang", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1211566332]  = { name = "Gestreept stinkdier", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [40345436]     = { name = "Merino Schaap", givenItem = { "wool" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1729948479, good = -1317365569, perfect = 1466150167 },
    [-164963696]   = { name = "Haringmeeuw", givenItem = { "feathers" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1076508705]  = { name = "Roze lepelaar", givenItem = { "feathers" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [2023522846]   = { name = "Dominique Haan", givenItem = { "feathers" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-466687768]   = { name = "Roodpootgent", givenItem = { "feathers" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-575340245]   = { name = "Westerraaf", givenItem = { "feathers" }, givenAmount = { 0 }, money = 1, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1458540991]   = { name = "Noord-Amerikaanse wasbeer", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-541762431]   = { name = "Jackrabbit met zwarte staart", givenItem = { "meat" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1755643085]   = { name = "Amerikaanse Pronghorn Hinde", givenItem = { "meat" }, givenAmount = { 0 }, money = 14, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -983605026, good = 554578289, perfect = -1544126829 },
    [2079703102]   = { name = "Grote Prairie Kip", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1414989025]  = { name = "Virginiaanse opossum", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1007418994]   = { name = "Berkshire-varken", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -308965548, good = -57190831, perfect = -1102272634 },
    [1416324601]   = { name = "Ringhalsfazant", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1265966684]   = { name = "Amerikaanse Witte Pelikaan", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1797450568]  = { name = "Blauw-Gele Ara", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1654513481]   = { name = "Panter", givenItem = { "meat" }, givenAmount = { 0 }, money = 20, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1584468323, good = -395646254, perfect = 1969175294 },
    [1205982615]   = { name = "Californische Condor", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-2063183075]  = { name = "Dominique Kip", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-2073130256]  = { name = "Dubbelkuifaalscholver", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [90264823]     = { name = "Poema", givenItem = { "meat" }, givenAmount = { 0 }, money = 35, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1914602340, good = 459744337, perfect = -1791452194 },
    [-50684386]    = { name = "Florida Cracker Koe", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 334093551, good = 1150594075, perfect = -845037222 },
    [480688259]    = { name = "Coyote", givenItem = { "meat" }, givenAmount = { 0 }, money = 6, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -1558096473, good = 1150939141, perfect = -794277189 },
    [-564099192]   = { name = "Huilende Kraan", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [457416415]    = { name = "Gila-monster", givenItem = { "meat" }, givenAmount = { 0 }, money = 70, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-753902995]   = { name = "Alpengeit", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 699990316, good = 1710714415, perfect = -1648383828 },
    [723190474]    = { name = "Canadese gans", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-2145890973]  = { name = "Ijzerhoudende Havik", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1095117488]   = { name = "Grote blauwe reiger", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1854059305]  = { name = "Groene leguaan", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-593056309]   = { name = "Woestijn leguaan", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1751700893]   = { name = "Pekari varken", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -99092070, good = -1379330323, perfect = 1963510418 },
    [386506078]    = { name = "Gewone duiker", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1098441944]  = { name = "Eland", givenItem = { "meat" }, givenAmount = { 0 }, money = 8, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1868576868, good = 1636891382, perfect = -217731719 },
    [-1134449699]  = { name = "Amerikaanse Muskusrat", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-861544272]   = { name = "Grote gehoornde uil", givenItem = { "feathers" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [556355544]    = { name = "Angus Ox", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 4623248928, good = 1208128650, perfect = 659601266 },
    [-1892280447]  = { name = "Kleine Alligator", givenItem = { "BigGameMeat" }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1806153689, good = -802026654, perfect = -1625078531 },
    [-2004866590]  = { name = "Alligator", givenItem = { "BigGameMeat" }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 3, poor = -1243878166, good = nil, perfect = -1475338121 },
    [759906147]    = { name = "Noord-Amerikaanse bever", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = -1569450319, good = -2059726619, perfect = 854596618 },
    [730092646]    = { name = "Amerikaanse zwarte beer", givenItem = { "meat" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = 1083865179, good = 1490032862, perfect = 663376218 },
    -- Fish
    [-711779521]   = { name = "Langneus Gar", givenItem = { "fish" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-1553593715]  = { name = "Muskie vis", givenItem = { "fish" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [-300867788]   = { name = "Steur", givenItem = { "fish" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1538187374]   = { name = "Meerval", givenItem = { "fish" }, givenAmount = { 0 }, money = 3, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [697075200]    = { name = "Snoek", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1867262572]   = { name = "Blauwkieuw", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1493541632]   = { name = "Donderpadmeerval", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [3111984125]   = { name = "Kettingsnoek", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [463643368]    = { name = "Grootmondbaars", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [3842742512]   = { name = "Baars", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [134747314]    = { name = "Regenboogforel", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [4051778898]   = { name = "Roodvinsnoek", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [2313405824]   = { name = "Steenbaars", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [2410477101]   = { name = "Kleine baars", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [543892122]    = { name = "Zalm roodbaars", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
    [1702636991]   = { name = "Zalm sockeye", givenItem = { "fish" }, givenAmount = { 0 }, money = 2, gold = 0, rolPoints = 0, xp = 3, poorQualityMultiplier = 1.0, goodQualityMultiplier = 1.5, perfectQualityMultiplier = 2, poor = nil, good = nil, perfect = nil },
}
