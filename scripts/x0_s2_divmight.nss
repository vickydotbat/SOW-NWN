//::///////////////////////////////////////////////
//:: Divine Might
//:: x0_s2_divmight.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
	Up to (turn undead amount) per day the character may add his Charisma bonus to all
	weapon damage for a number of rounds equal to the Charisma bonus.

	MODIFIED JULY 3 2003
	+ Won't stack
	+ Set it up properly to give correct + to hit (to a max of +20)

	MODIFIED SEPT 30 2003
	+ Made use of new Damage Constants
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13 2002
//:://////////////////////////////////////////////

#include "nw_i0_spells"
#include "x2_inc_itemprop"

void main()
{
	object oCaster = OBJECT_SELF;
	if (!GetHasFeat(FEAT_TURN_UNDEAD, oCaster))
	{
		SendMessageToPC(oCaster, "You have no Turn Undead charges remaining.");
		return;
	}
	else if (GetHasFeatEffect(FEAT_DIVINE_MIGHT) == FALSE)
	{
		effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);

		int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA);
		if (nCharismaBonus > 0)
		{
			int nSpellId = GetSpellId();

			RemoveEffectsFromSpell(oCaster, nSpellId);

			effect eDamage1 = EffectDamageIncrease(nCharismaBonus, DAMAGE_TYPE_DIVINE);
			eDamage1		= SupernaturalEffect(eDamage1);

			ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamage1, oCaster, RoundsToSeconds(1));
			ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster);
		}

		DecrementRemainingFeatUses(OBJECT_SELF, FEAT_TURN_UNDEAD);
	}
}
