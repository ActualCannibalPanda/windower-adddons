local t = {
  --------------------------------------------------------
  -- LEVEL 2 Skillchains
  ['fusion'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Fusion (Fire/Light) Skillchain >>>>>>>>>;'
    .. ' input /ma "Fire" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Ionohelix" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Fusion (Fire/Light) Skillchain <call20>',
  ['gravitation'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Gravitation (Earth/Darkness) Skillchain >>>>>>>>>;'
    .. ' input /ma "Aero" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Noctohelix" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Gravitation (Earth/Darkness) Skillchain <call20>',
  ['fragmentation'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Fragmentation (Wind/Thunder) Skillchain >>>>>>>>>;'
    .. ' input /ma "Blizzard" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Hydrohelix" <t>;'
    .. ' wait 1;'
    .. ' input /p <<<<<<<<< Closing Fragmentation (Wind/Thunder) Skillchain <call20>',
  ['distortion'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Distortion (Water/Ice) Skillchain >>>>>>>>>;'
    .. ' input /ma "Luminohelix" <t>;'
    .. ' wait 6;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 1;'
    .. ' input /p <<<<<<<<< Closing Distortion (Water/Ice) Skillchain <call20>',
  --------------------------------------------------------
  -- LEVEL 1 Skillchains
  ['liquefaction'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Liquefaction (Fire) Skillchain >>>>>>>>>;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Fire" <t>;'
    .. ' wait 1;'
    .. ' input /p <<<<<<<<< Closing Liquefaction (Fire) Skillchain <call20>',

  ['scission'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Scission (Earth) Skillchain >>>>>>>>>;'
    .. ' input /ma "Fire" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Scission (Earth) Skillchain <call20>',
  ['reverberation'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Reverberation (Water) Skillchain >>>>>>>>>;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Reverberation (Water) Skillchain <call20>',
  ['detonation'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Detonation (Wind) Skillchain >>>>>>>>>;'
    .. ' input /ma "Stone" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Aero" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Detonation (Wind) Skillchain <call20>',
  ['induration'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Induration (Blizzard) Skillchain >>>>>>>>>;'
    .. ' input /ma "Water" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Blizzard" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Induration (Blizzard) Skillchain <call20>',
  ['impaction'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Impaction (Thunder) Skillchain >>>>>>>>>;'
    .. ' input /ma "Water" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Thunderr" <t>;'
    .. ' wait 2;'
    .. ' input /p <<<<<<<<< Closing Impaction (Thunder) Skillchain <call20>',
  ['transfixion'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Transfixion (Light) Skillchain >>>>>>>>>;'
    .. ' input /ma "Noctohelix" <t>;'
    .. ' wait 6;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Luminohelix" <t>;'
    .. ' wait 3;'
    .. ' input /p <<<<<<<<< Closing Transfixion (Light) Skillchain <call20>',
  ['compression'] = 'input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. 'input /p Opening Compression (Darkness) Skillchain >>>>>>>>>;'
    .. ' input /ma "Blizzard" <t>;'
    .. ' wait 4;'
    .. ' input /ja "Immanence" <me>;'
    .. ' wait 2;'
    .. ' input /ma "Luminohelix" <t>;'
    .. ' wait 3;'
    .. ' input /p <<<<<<<<< Closing Compression (Darkness) Skillchain <call20>',
}

t['fus'] = t['fusion']
t['grav'] = t['gravitation']
t['frag'] = t['fragmentation']
t['dist'] = t['distortion']

t['liqu'] = t['liquefaction']
t['fire'] = t['liquefaction']

t['sci'] = t['scission']
t['stone'] = t['scission']

t['rev'] = t['reverberation']
t['water'] = t['reverberation']

t['det'] = t['detonation']
t['aero'] = t['detonation']

t['ind'] = t['induration']
t['ice'] = t['induration']

t['imp'] = t['impaction']
t['thun'] = t['impaction']
t['thunder'] = t['impaction']

t['tran'] = t['transfixion']
t['light'] = t['transfixion']

t['comp'] = t['compression']
t['dark'] = t['compression']

return t
