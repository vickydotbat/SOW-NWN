//::///////////////////////////////////////////////
//:: Divine Shield
//:: x0_s2_divshield.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
	Up to [turn undead] times per day the character may add his Charisma bonus to his armor
	class for a number of rounds equal to the Charisma bonus.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: Sep 13, 2002
//:://////////////////////////////////////////////

void main()
{
	object oCaster = OBJECT_SELF;
	if (!GetHasFeat(FEAT_TURN_UNDEAD, oCaster))
	{
		SendMessageToPC(oCaster, "You have no Turn Undead charges remaining.");
		return;
	}
	else
	{
		// We apply a Shield AC Bonus if the caster is wielding a shield.
		object oOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCaster);
		if (GetBaseItemType(oOffHand) == BASE_ITEM_SMALLSHIELD || GetBaseItemType(oOffHand) == BASE_ITEM_LARGESHIELD || GetBaseItemType(oOffHand) == BASE_ITEM_TOWERSHIELD)
		{
			int nLevel		   = GetHitDice(oCaster);
			int nCharismaBonus = GetAbilityModifier(ABILITY_CHARISMA, oCaster);
			ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUPER_HEROISM), oCaster);
			AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyACBonus(nCharismaBonus), oOffHand, RoundsToSeconds(nLevel));
			DecrementRemainingFeatUses(oCaster, FEAT_TURN_UNDEAD);
		}
		else
		{
			SendMessageToPC(oCaster, "You must be wielding a shield to use this ability.");
			return;
		}
	}
}
