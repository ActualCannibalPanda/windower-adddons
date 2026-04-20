_addon.name = 'scholar'
_addon.author = 'Cromakre'
_addon.version = '1.0.0'
_addon.command = 'sch'

require('tables')
require('sets')
require('lists')
local resources = require('resources')
local skillchain_commands = require('data/skillchains')

local function get_buffs()
  local player = windower.ffxi.get_player()
  local buffs = S()
  for _, v in ipairs(player.buffs) do
    if resources.buffs[v] then
      buffs:add(resources.buffs[v].en)
    end
  end
  return buffs
end

local function is_valid_target(mob)
  if not mob then
    return false
  end

  local zone = windower.ffxi.get_info().zone
  local zonedata = require('data/zonedata/' .. zone)
  if zonedata.Names[mob.name] or mob.name == 'Macro Test' then
    return true
  end
  return false
end

local function skillchain(commands)
  if is_valid_target(windower.ffxi.get_mob_by_target('t')) then
    local skillchain_command = skillchain_commands[commands[1]]
    if skillchain_command then
      windower.send_command(skillchain_command)
    end
  else
    windower.add_to_chat(122, 'Scholar: Invalid target for skillchain')
  end
end

local function dark_arts()
  local buffs = get_buffs()

  if not buffs:contains('Addendum: Black') then
    if buffs:contains('Dark Arts') then
      windower.add_to_chat(122, 'Scholar: Addenddum: Black')
      windower.send_command('input /ja "Addendum: Black" <me>')
    else
      windower.add_to_chat(122, 'Scholar: Dark Arts')
      windower.send_command('input /ja "Dark Arts" <me>')
    end
  else
    windower.add_to_chat(122, 'Scholar: Addendum: Black is already active')
  end
end

local function light_arts()
  local buffs = get_buffs()

  if not buffs:contains('Addendum: White') then
    if buffs:contains('Light Arts') then
      windower.add_to_chat(122, 'Scholar: Addenddum: White')
      windower.send_command('input /ja "Addendum: White" <me>')
    else
      windower.add_to_chat(122, 'Scholar: Light Arts')
      windower.send_command('input /ja "Light Arts" <me>')
    end
  else
    windower.add_to_chat(122, 'Scholar: Addendum: White is already active')
  end
end

local function sublimation()
  local buffs = get_buffs()

  if buffs:contains('Sublimation: Complete') or buffs:contains('Sublimation: Activated') then
    windower.add_to_chat(122, 'Scholar: Claiming MP from Sublimation')
    windower.send_command('input /ja "Sublimation" <me>; wait 1')
  else
    windower.add_to_chat(122, 'Scholar: Activating Sublimation')
    windower.send_command('input /ja "Sublimation" <me>; wait 1')
  end
end

local function nuke(commands)
  local spell = commands[1]
  local spell_command = 'input /ma '
  local tier = ''
  local num = tonumber(spell[#spell])
  if num == 1 then
    tier = ''
  elseif num == 2 then
    tier = ' II'
  elseif num == 3 then
    tier = ' III'
  elseif num == 4 then
    tier = ' IV'
  elseif num == 5 then
    tier = ' V'
  else
    windower.add_to_chat(122, 'Scholar: Invalid nuke tier')
    return
  end

  if spell:find('fh') then
    spell_command = spell_command .. '"Pyrohelix' .. tier .. '" <t>'
  elseif spell:find('wh') then
    spell_command = spell_command .. '"Hydrohelix' .. tier .. '" <t>'
  elseif spell:find('sh') then
    spell_command = spell_command .. 'Geohelix' .. tier .. '" <t>'
  elseif spell:find('bh') then
    spell_command = spell_command .. 'Cryohelix' .. tier .. '" <t>'
  elseif spell:find('th') then
    spell_command = spell_command .. '"Ionohelix' .. tier .. '" <t>'
  elseif spell:find('ah') then
    spell_command = spell_command .. '"Anemohelix' .. tier .. '" <t>'
  elseif spell:find('lh') then
    spell_command = spell_command .. '"Luminohelix' .. tier .. '" <t>'
  elseif spell:find('dh') then
    spell_command = spell_command .. '"Noctohelix' .. tier .. '" <t>'
  elseif spell[1] == 'f' then
    spell_command = spell_command .. '"Fire' .. tier .. '" <t>'
  elseif spell[1] == 'w' then
    spell_command = spell_command .. '"Water' .. tier .. '" <t>'
  elseif spell[1] == 's' then
    spell_command = spell_command .. 'Stone' .. tier .. '" <t>'
  elseif spell[1] == 'b' then
    spell_command = spell_command .. 'Blizzard' .. tier .. '" <t>'
  elseif spell[1] == 't' then
    spell_command = spell_command .. '"Thunder' .. tier .. '" <t>'
  elseif spell[1] == 'a' then
    spell_command = spell_command .. '"Aero' .. tier .. '" <t>'
  else
    windower.add_to_chat(122, 'Scholar: Failed to find nuke for ' .. spell)
    return
  end

  windower.send_command(spell_command)
end

windower.register_event('addon command', function(...)
  local commands = T({ ... })
  if #commands == 0 then
    windower.add_to_chat(122, 'Add help text later')
  else
    local command = commands[1]:lower()
    if command == 'dark' or command == 'd' then
      dark_arts()
    elseif command == 'light' or command == 'l' then
      light_arts()
    elseif command == 'sublimation' or command == 'sub' then
      sublimation()
    elseif command == 'skillchain' or command == 'sc' then
      skillchain(commands:slice(2, #commands))
    elseif command == 'nuke' or command == 'n' then
      nuke(commands:slice(2, #commands))
    else
      local buffs = get_buffs()
      local command_buffer = L()
      local spell_command = nil
      for _, command in ipairs(commands) do
        if buffs:contains('Light Arts') or buffs:contains('Addendum: White') then
          if command == 'duration' or command == 'dur' then
            command_buffer:append('input /ja "Perpetuance" <me>; wait 1')
          elseif command == 'aoe' then
            command_buffer:append('input /ja "Accession" <me>; wait 1')
          else
            if not resources.spells:en(command):empty() then
              spell_command = 'input /ma "' .. command .. '" <me>; wait 1; '
            end
          end
        elseif buffs:contains('Dark Arts') or buffs:contains('Addendum: Black') then
          if command == 'aoe' then
            command_buffer:append('input /ja "Manifestation" <me>; wait 1')
          elseif command == 'duration' or command == 'dur' then
            windower.add_to_chat(122, 'Scholar: No Duration skill exists for Dark Arts')
          else
            if not resources.spells:en(command):empty() then
              spell_command = 'input /ma "' .. command .. '" <me>; wait 1; '
            end
          end
        end
        if command == 'fs' then
          spell_command = 'input /ma "Firestorm" <me>'
        elseif command == 'ss' then
          spell_command = 'input /ma "Sandstorm" <me>'
        elseif command == 'is' then
          spell_command = 'input /ma "Hailstorm" <me>'
        elseif command == 'ws' then
          spell_command = 'input /ma "Windstorm" <me>'
        elseif command == 'ts' then
          spell_command = 'input /ma "Thunderstorm" <me>'
        elseif command == 'as' then
          spell_command = 'input /ma "Aurorastorm" <me>'
        elseif command == 'vs' then
          spell_command = 'input /ma "Voidstorm" <me>'
        elseif command == 'fs2' then
          spell_command = 'input /ma "Firestorm II" <me>'
        elseif command == 'ss2' then
          spell_command = 'input /ma "Sandstorm II" <me>'
        elseif command == 'hs2' then
          spell_command = 'input /ma "Hailstorm II" <me>'
        elseif command == 'ws2' then
          spell_command = 'input /ma "Windstorm II" <me>'
        elseif command == 'ts2' then
          spell_command = 'input /ma "Thunderstorm II" <me>'
        elseif command == 'as2' then
          spell_command = 'input /ma "Aurorastorm II" <me>'
        elseif command == 'vs2' then
          spell_command = 'input /ma "Voidstorm II" <me>'
        elseif command == 'kf' then
          spell_command = 'input /ma "Klimaform" <me>'
        end
      end
      if #command_buffer > 0 then
        if spell_command then
          windower.send_command(command_buffer:concat('; ') .. '; ' .. spell_command)
        else
          windower.send_command(command_buffer:concat('; '))
        end
      elseif spell_command then
        windower.send_command(spell_command)
      end
    end
  end
end)
