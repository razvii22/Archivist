term.clear()
term.setCursorPos(1,1)
--innitialise locals
local version = "1.1.1"
local chest = {}
local vault = {}

--find and wrap a vault else error

if peripheral.find("create:item_vault") then
    vault = peripheral.find("create:item_vault")
else
    error("This program requires a vault to operate on...",2)
end

--find and wrap an output inventory else error

if peripheral.find("quark:variant_chest") then
    chest = peripheral.find("quark:variant_chest")
elseif peripheral.find("minecraft:chest") then
    chest = peripheral.find("minecraft:chest")
elseif peripheral.find("minecraft:barrel") then
    chest = peripheral.find("minecraft:barrel")
else
    error("This program requires a chest to output to...",2)
end

--main loop
local command
if #arg ~= 0 then
    command = true
else
    command = false
end
while true do
print("Indexing vault...")
local index = vault.list()
print("Welcome to the Archivist "..version.."!")
print("My job is to help extract items out of the vault.")
print('Please provide a FULL item name to search or "exit"')
term.setTextColor(colors.red)
term.write(">")
local search = arg[1] or read()
    
if search == "exit" then textutils.slowPrint("Exiting...") return 0 end
term.setTextColor(colors.white)
local item 
 for k,v in pairs(index) do
     --print(k,textutils.serialise(index[k]))
     if index[k].name == search then
         item = k
         break
     end
 end
 if item then 
     print("Found the "..search:sub(11,search:len()).." on slot "..item)
     print("Attempting to eject "..index[item].count.." "..search:sub(11,search:len()).." into the chest...")
     vault.pushItems(peripheral.getName(chest),item)
     print("Ejected!")
 else
     print("No item of that name found...")
 end
 sleep(3)
 term.clear()
 term.setCursorPos(1,1)
 if command then return true end
end
