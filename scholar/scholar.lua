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
    else
      local buffs = get_buffs()
      local duration = false
      local aoe = false
      local command_buffer = L()
      local spell_command = nil
      for _, command in ipairs(commands) do
        if buffs:contains('Light Arts') or buffs:contains('Addendum: White') then
          if command == 'duration' or command == 'dur' then
            command_buffer:append('input /ja "Perpetuance" <me>; wait 1; ')
          elseif command == 'aoe' then
            command_buffer:append('input /ja "Accession" <me>; wait 1; ')
          else
            for _, spell in ipairs(resources.spells) do
              if spell.en == command and spell.type == 'WhiteMagic' then
                spell_command = 'input /ma "' .. command .. '" <me>; wait 1; '
              end
            end
          end
        elseif buffs:contains('Dark Arts') or buffs:contains('Addendum: Black') then
          if not aoe and command == 'aoe' then
            command_buffer:append('input /ja "Manifestation" <me>; wait 1; ')
          elseif not duration and command == 'duration' or command == 'dur' then
            windower.add_to_chat(122, 'Scholar: No Duration skill exists for Dark Arts')
          else
            for _, spell in ipairs(resources.spells) do
              if spell.en == command and spell.type == 'BlackMagic' then
                spell_command = 'input /ma "' .. command .. ' <me>"; wait 1; '
              end
            end
          end
        end
      end
      if #command_buffer > 0 then
        if spell_command then
          windower.send_command(command_buffer:concat(' ') .. spell_command)
        else
          windower.send_command(command_buffer:concat(' '))
        end
      end
    end
  end
end)
