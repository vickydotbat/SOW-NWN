
int ExtendSpell(int nDuration, object oCaster = OBJECT_SELF)
{
	int nSpellID   = GetSpellId();
	int nMetaMagic = GetMetaMagicFeat();

	// Extended metamagic
	if (nMetaMagic == METAMAGIC_EXTEND)
	{
		nDuration *= 2;
	}

	// We don't want durations below 1, they can cause permanent item properties.
	return nDuration >= 1 ? nDuration : 1;
}