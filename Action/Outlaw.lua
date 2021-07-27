local function precombat() then
	if A.ApplyPoison:IsReady(unitID, true) then
		return A.ApplyPoison:Show(icon)
	end

end

local function actions() then
	if A.ArcaneTorrent:IsReady(unitID, true) and Player:EnergyDeficit() >=15+ Player:EnergyRegen()  then
		return A.ArcaneTorrent:Show(icon)
	end
	if A.ArcanePulse:IsReady(unitID, true) then
		return A.ArcanePulse:Show(icon)
	end

	if A.LightsJudgment:IsReady(unitID, true) then
		return A.LightsJudgment:Show(icon)
	end

	if A.BagOfTricks:IsReady(unitID, true) then
		return A.BagOfTricks:Show(icon)
	end

end

local function build() then
	if A.Sepsis:IsReady(unitID, true) then
		return A.Sepsis:Show(icon)
	end

	if A.GhostlyStrike:IsReady(unitID, true) then
		return A.GhostlyStrike:Show(icon)
	end

	if A.Shiv:IsReady(unitID, true) and
	if A.EchoingReprimand:IsReady(unitID, true) then
		return A.EchoingReprimand:Show(icon)
	end

	if A.SerratedBoneSpike:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.SerratedBoneSpike.ID) == 0 then
		return A.SerratedBoneSpike:Show(icon)
	end
	if A.SerratedBoneSpike:IsReady(unitID, true) and Unit(unitID):HasDeBuffs(A.SerratedBoneSpike.ID) == 0 then
		return A.SerratedBoneSpike:Show(icon)
	end
	if A.SerratedBoneSpike:IsReady(unitID, true) and Unit(unitID):TimeToDie() <=5orcooldown.serrated_bone_spike.max_charges-charges_fractional<=0.25or Player:ComboPointsDeficit() =cp_gainand!buff.skull_and_crossbones.upand Player:EnergyTimeToMax() >1 then
		return A.SerratedBoneSpike:Show(icon)
	end
	if A.PistolShot:IsReady(unitID, true) and Unit('player'):HasBuffs(A.Opportunity.ID) ~= 0 and( Player:EnergyDeficit() >(energy.regen+10)or Player:ComboPointsDeficit() <=1+buff.broadside.uportalent.quick_draw.enabled) then
		return A.PistolShot:Show(icon)
	end
	if A.PistolShot:IsReady(unitID, true) and Unit('player'):HasBuffs(A.Opportunity.ID) ~= 0  then
		return A.PistolShot:Show(icon)
	end
	if A.SinisterStrike:IsReady(unitID, true) then
		return A.SinisterStrike:Show(icon)
	end

	if A.Gouge:IsReady(unitID, true) and Player:ComboPointsDeficit()  then
		return A.Gouge:Show(icon)
	end
end

local function cds() then
	if A.BladeFlurry:IsReady(unitID, true) and
	if A.Vanish:IsReady(unitID, true) and
	if A.Vanish:IsReady(unitID, true) and
	if A.AdrenalineRush:IsReady(unitID, true) and
	if A.Fleshcraft:IsReady(unitID, true) and Player:EnergyTimeToMax()  then
		return A.Fleshcraft:Show(icon)
	end
	if A.Dreadblades:IsReady(unitID, true) and
	if A.RollTheBones:IsReady(unitID, true) and
	if A.MarkedForDeath:IsReady(unitID, true) and Player:ComboPointsDeficit() or!stealthed.rogueand Player:ComboPointsDeficit() >=cp_max_spend-1) then
		return A.MarkedForDeath:Show(icon)
	end
	if A.MarkedForDeath:IsReady(unitID, true) and Player:ComboPointsDeficit()  then
		return A.MarkedForDeath:Show(icon)
	end
	if A.Variable:IsReady(unitID, true) and
	if A.KillingSpree:IsReady(unitID, true) and Player:EnergyDeficit() >( Player:EnergyRegen() *2+15)orspell_targets.blade_flurry>(2-buff.deathly_shadows.up)ormaster_assassin_remains>0) then
		return A.KillingSpree:Show(icon)
	end
	if A.BladeRush:IsReady(unitID, true) and Player:EnergyTimeToMax()  then
		return A.BladeRush:Show(icon)
	end
	if A.Shadowmeld:IsReady(unitID, true) and
	if A.Potion:IsReady(unitID, true) and Unit(unitID):TimeToDie()  then
		return A.Potion:Show(icon)
	end
	if A.BloodFury:IsReady(unitID, true) then
		return A.BloodFury:Show(icon)
	end

	if A.Berserking:IsReady(unitID, true) then
		return A.Berserking:Show(icon)
	end

	if A.Fireblood:IsReady(unitID, true) then
		return A.Fireblood:Show(icon)
	end

	if A.AncestralCall:IsReady(unitID, true) then
		return A.AncestralCall:Show(icon)
	end

	if A.UseItems:IsReady(unitID, true) and Unit(unitID):TimeToDie()  then
		return A.UseItems:Show(icon)
	end
	if A.UseItems:IsReady(unitID, true) and Unit(unitID):TimeToDie()  then
		return A.UseItems:Show(icon)
	end
end

local function finish() then
	if A.BetweenTheEyes:IsReady(unitID, true) and
	if A.SliceAndDice:IsReady(unitID, true) and Unit(unitID):TimeToDie()  then
		return A.SliceAndDice:Show(icon)
	end
	if A.Dispatch:IsReady(unitID, true) then
		return A.Dispatch:Show(icon)
	end

end

local function stealth() then
	if A.Ambush:IsReady(unitID, true) then
		return A.Ambush:Show(icon)
	end

end
