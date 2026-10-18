#pragma once

namespace Contraband
{
	// _SLS_LicenceUtil's inventory checks, one native call instead of a Papyrus walk over
	// the whole inventory per licence type. Values are the aiKind of _SLS_Native.HasContraband.
	enum class Kind : std::int32_t
	{
		kArmor = 0,    // ActorHasArmor
		kWeapon = 1,   // HasWeapon
		kMagic = 2,    // HasMagicItem
		kClothes = 3,  // HasClothes
	};

	// Resolves the vanilla and SexLab keywords the checks use. Call on kDataLoaded.
	void Init();

	bool Has(RE::TESObjectREFR* a_target, Kind a_kind, RE::BGSListForm* a_armorExceptions,
		RE::BGSListForm* a_weaponExceptions, std::int32_t a_followerLicStyle);
}
