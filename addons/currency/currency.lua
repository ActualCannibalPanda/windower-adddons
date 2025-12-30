_addon.name = 'currency'
_addon.author = 'Cromakre'
_addon.version = '1.0.0.0000'
_addon.command = 'curr'

packets = require('packets')

local incomingCurrencyMenu1 = 0x113
local incomingCurrencyMenu2 = 0x118

local outgoingCurrencyMenu1 = 0x10F
local outgoingCurrencyMenu2 = 0x115

local packetARecieved = false
local packetBRecieved = false

local currencyCache = {}

local function inject()
  packets.inject(packets.new('outgoing', outgoingCurrencyMenu1, {}))
  packets.inject(packets.new('outgoing', outgoingCurrencyMenu2, {}))
end

local function stripNames(str)
  local ret = string.lower(str)
  ret = string.gsub(ret, "[.'-]+", '')
  ret = string.gsub(ret, ' ', '')
  return ret
end

local function generateSearchTerm(...)
  local searchTerm = ''
  for i, v in ipairs(arg) do
    searchTerm = searchTerm .. tostring(v)
  end

  return stripNames(searchTerm)
end

local function search(searchTerm)
  local results = {}
  for name, val in pairs(currencyCache) do
    local altered = stripNames(name)
    if string.match(altered, searchTerm) then
      results[name] = val
    end
  end
  local keys = {}
  for k in pairs(results) do
    table.insert(keys, k)
  end
  table.sort(keys)
  if #keys > 0 then
    for _, val in ipairs(keys) do
      windower.add_to_chat(4, val .. '   ' .. results[val])
    end
  else
    windower.add_to_chat(4, "Couldn't find " .. searchTerm)
  end
end

windower.register_event('addon command', function(...)
  inject()
  local searchTerm = generateSearchTerm(table.unpack(arg))
  packetARecieved = false
  packetBRecieved = false
  windower.add_to_chat(4, 'Loading currency...')
  while not (packetARecieved and packetBRecieved) do
    -- use this so the game doesn't crash
    coroutine.sleep(0.01)
  end
  search(searchTerm)
end)

windower.register_event('incoming chunk', function(id, original, modified, injected, blocked)
  if id == incomingCurrencyMenu1 or id == incomingCurrencyMenu2 then
    local data = packets.parse('incoming', original)
    for name, val in pairs(data) do
      if name ~= nil and not string.match(name, '^_') then
        currencyCache[name] = val
      end
    end
  end
  if id == incomingCurrencyMenu1 then
    packetARecieved = true
  end
  if id == incomingCurrencyMenu2 then
    packetBRecieved = true
  end
end)
