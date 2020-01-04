-- Thanks to matix on Discord. I used his code for the checkBuff() function. 
-- It goes without saying but, also thanks to atom0s for making all this possible.

_addon.author = 'Greasydeal';
_addon.name = "BuffWatch";
_addon.version = '1.0';

require 'common' 

local default_config = 
{
    font =
    {
        family      = 'Arial',
        size        = 16,
        color       = 0xFFFFFFFF,
        position    = { -380, 20 },
    },
	bgcolor     = 0x80000000,
    bgvisible   = true,
	buffs = nil
};
local buffWatch_config = default_config;

local resources = AshitaCore:GetResourceManager();
local player = AshitaCore:GetDataManager():GetPlayer();

ashita.register_event('load', function()
    -- Load the configuration file..
    buffWatch_config = ashita.settings.load_merged(_addon.path .. '/settings/settings.json', buffWatch_config);

    -- Create the font object..
    local f = AshitaCore:GetFontManager():Create('__buffWatch_addon');
    f:SetColor(buffWatch_config.font.color);
    f:SetFontFamily(buffWatch_config.font.family);
    f:SetFontHeight(buffWatch_config.font.size);
    f:SetBold(true);
    f:SetPositionX(buffWatch_config.font.position[1]);
    f:SetPositionY(buffWatch_config.font.position[2]);
	f:GetBackground():SetColor(buffWatch_config.font.bgcolor);
    f:GetBackground():SetVisibility(buffWatch_config .font.bgvisible);
    f:SetText("Loading...");
    f:SetVisibility(true);
end);

ashita.register_event('render', function()

	local f = AshitaCore:GetFontManager():Get('__buffWatch_addon');
	local e = T{};
	
	local buffs = getBuffsByJob();
	
	for x = 1, 1024  do
		if (buffs ~= nil) then
			if (buffs[x] ~= nil) then
				table.insert(e, colorBuff(buffs[x]));
			end
		end
	end
	
	f:SetText(e:concat('\n'));
	
end);

ashita.register_event('unload', function()
    -- Get the font object..
    local f = AshitaCore:GetFontManager():Get('__buffWatch_addon');

    -- Update the configuration position..
    buffWatch_config.font.position = { f:GetPositionX(), f:GetPositionY() };

    -- Save the configuration file..
    --ashita.settings.save(_addon.path .. '/settings/settings.json', buffWatch_config);

    -- Delete the font object..
    AshitaCore:GetFontManager():Delete('__buffWatch_addon');
end);

function colorBuff(buffname)
	if checkBuff(buffname) then
		return string.format('|cFF00FF00|%s|r', buffname);
	else
		return string.format('|cFFFF0000|%s|r', buffname);
	end
	
end;

function getBuffsByJob()
	local job = AshitaCore:GetDataManager():GetPlayer():GetMainJob();
	if (job == 1) then 
		return buffWatch_config.buffs.WAR; 
	elseif (job == 2) then 
		return buffWatch_config.buffs.MNK;
	elseif (job == 3) then 
		return buffWatch_config.buffs.WHM;
	elseif (job == 4) then 
		return buffWatch_config.buffs.BLM;
	elseif (job == 5) then 
		return buffWatch_config.buffs.RDM;
	elseif (job == 6) then 
		return buffWatch_config.buffs.THF;
	elseif (job == 7) then 
		return buffWatch_config.buffs.PLD; 
	elseif (job == 8) then 
		return buffWatch_config.buffs.DRK;
	elseif (job == 9) then 
		return buffWatch_config.buffs.BST;
	elseif (job == 10) then 
		return buffWatch_config.buffs.BRD;
	elseif (job == 11) then 
		return buffWatch_config.buffs.RNG;
	elseif (job == 12) then 
		return buffWatch_config.buffs.SMN;
	elseif (job == 13) then 
		return buffWatch_config.buffs.SAM;
	elseif (job == 14) then 
		return buffWatch_config.buffs.NIN;
	elseif (job == 15) then 
		return buffWatch_config.buffs.DRG;
	elseif (job == 16) then 
		return buffWatch_config.buffs.BLU;
	elseif (job == 17) then 
		return buffWatch_config.buffs.COR;
	elseif (job == 18) then 
		return buffWatch_config.buffs.PUP;
	elseif (job == 19) then 
		return buffWatch_config.buffs.DNC;
	elseif (job == 20) then 
		return buffWatch_config.buffs.SCH;
	elseif (job == 21) then 
		return buffWatch_config.buffs.GEO;
	elseif (job == 22) then 
		return buffWatch_config.buffs.RUN;
	end
end;

function checkBuff(buffname)
    if (tonumber(buffname) == nil) then--if string name given
        for k,v in pairs( player:GetBuffs() ) do
            if ((v ~= -1) and (v == resources:GetString("statusnames",buffname))) then
                return true;
            end
        end
	end
    return false;
end;