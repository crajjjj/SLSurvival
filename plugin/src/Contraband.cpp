#include "Contraband.h"

// Native twins of _SLS_LicenceUtil.ActorHasArmor, HasWeapon, HasMagicItem and HasClothes.
// Each follows its Papyrus original rule for rule: change one, change the other. The
// keywords are the ones the licence quest's properties hold in SL Survival.esp.

namespace Contraband
{
	namespace
	{
		RE::BGSKeyword* g_vendorItemArmor = nullptr;
		RE::BGSKeyword* g_vendorItemWeapon = nullptr;
		RE::BGSKeyword* g_vendorItemClothing = nullptr;
		RE::BGSKeyword* g_vendorItemStaff = nullptr;
		RE::BGSKeyword* g_vendorItemSpellTome = nullptr;
		RE::BGSKeyword* g_armorJewelry = nullptr;
		RE::BGSKeyword* g_sexLabNoStrip = nullptr;

		RE::BGSKeyword* Keyword(RE::TESDataHandler* a_data, RE::FormID a_id, std::string_view a_file)
		{
			auto* keyword = a_data->LookupForm<RE::BGSKeyword>(a_id, a_file);
			if (!keyword) {
				logger::warn("keyword {:06X} of {} not found", a_id, a_file);
			}
			return keyword;
		}

		bool HasKeyword(RE::TESForm* a_form, const RE::BGSKeyword* a_keyword)
		{
			const auto* keywords = a_keyword ? a_form->As<RE::BGSKeywordForm>() : nullptr;
			return keywords && keywords->HasKeyword(a_keyword);
		}

		bool HasName(const RE::TESForm* a_form)
		{
			const char* name = a_form->GetName();  // a game getter: null when unset
			return name && *name;
		}

		bool InList(const RE::BGSListForm* a_list, const RE::TESForm* a_form)
		{
			return a_list && a_list->HasForm(a_form);
		}

		// What every check does once an item qualifies. The player carrying it is enough.
		// A follower's worn piece counts under follower licence style 1, or if they carry a
		// second one. A container (a licence search container) always counts: the Papyrus
		// original asks a None actor IsEquipped, which is false.
		bool Counts(RE::Actor* a_actor, bool a_isPlayer, bool a_worn, std::int32_t a_count, std::int32_t a_style)
		{
			if (a_isPlayer || !a_actor) {
				return true;
			}
			return !a_worn || a_style == 1 || a_count > 1;
		}

		bool ArmorType(RE::TESForm* a_form, std::uint32_t& a_type)
		{
			auto* armor = a_form->As<RE::TESObjectARMO>();
			if (!armor) {
				return false;
			}
			a_type = static_cast<std::uint32_t>(armor->GetArmorType());  // Papyrus GetWeightClass: 0 light, 1 heavy, 2 clothing
			return true;
		}
	}

	void Init()
	{
		auto* data = RE::TESDataHandler::GetSingleton();
		if (!data) {
			return;
		}
		g_vendorItemArmor = Keyword(data, 0x08F959, "Skyrim.esm");
		g_vendorItemWeapon = Keyword(data, 0x08F958, "Skyrim.esm");
		g_vendorItemClothing = Keyword(data, 0x08F95B, "Skyrim.esm");
		g_vendorItemStaff = Keyword(data, 0x0937A4, "Skyrim.esm");
		g_vendorItemSpellTome = Keyword(data, 0x0937A5, "Skyrim.esm");
		g_armorJewelry = Keyword(data, 0x06BBE9, "Skyrim.esm");
		g_sexLabNoStrip = Keyword(data, 0x02F16E, "SexLab.esm");
	}

	bool Has(RE::TESObjectREFR* a_target, Kind a_kind, RE::BGSListForm* a_armorExceptions,
		RE::BGSListForm* a_weaponExceptions, std::int32_t a_style)
	{
		if (!a_target) {
			return false;
		}
		auto*      actor = a_target->As<RE::Actor>();
		const bool isPlayer = a_target->IsPlayerRef();

		for (auto& [item, data] : a_target->GetInventory()) {
			const auto  count = data.first;
			const auto* entry = data.second.get();
			if (!item || count <= 0) {
				continue;
			}
			const bool    worn = entry && entry->IsWorn();
			std::uint32_t type = 0;

			switch (a_kind) {
			case Kind::kArmor:  // ActorHasArmor (the original checks no exception list here)
				if (ArmorType(item, type) && type < 2 && HasKeyword(item, g_vendorItemArmor) &&
					!HasKeyword(item, g_sexLabNoStrip) && item->GetPlayable() && HasName(item) &&
					Counts(actor, isPlayer, worn, count, a_style)) {
					return true;
				}
				break;

			case Kind::kWeapon:  // HasWeapon
				if (item->Is(RE::FormType::Weapon)) {
					if (HasKeyword(item, g_vendorItemWeapon) && !InList(a_weaponExceptions, item) &&
						Counts(actor, isPlayer, worn, count, a_style)) {
						return true;
					}
				} else if (item->Is(RE::FormType::Ammo)) {
					// ammo ignores the follower licence style
					if (isPlayer || !actor || !worn || count > 1) {
						return true;
					}
				}
				break;

			case Kind::kMagic:  // HasMagicItem
				if (ArmorType(item, type)) {
					const auto* armor = item->As<RE::TESObjectARMO>();
					if (type == 2 && armor->formEnchanting && !HasKeyword(item, g_armorJewelry) &&
						!HasKeyword(item, g_sexLabNoStrip) && item->GetPlayable() && !InList(a_armorExceptions, item) &&
						HasName(item) && Counts(actor, isPlayer, worn, count, a_style)) {
						return true;
					}
				} else if (item->Is(RE::FormType::Weapon)) {
					if (HasKeyword(item, g_vendorItemStaff)) {
						return true;
					}
				} else if (item->Is(RE::FormType::Book)) {
					if (HasKeyword(item, g_vendorItemSpellTome)) {
						return true;
					}
				} else if (item->Is(RE::FormType::Scroll)) {
					return true;
				}
				break;

			case Kind::kClothes:  // HasClothes
				if (ArmorType(item, type) && type == 2 && HasKeyword(item, g_vendorItemClothing) &&
					!HasKeyword(item, g_sexLabNoStrip) && item->GetPlayable() && !InList(a_armorExceptions, item) &&
					HasName(item) && Counts(actor, isPlayer, worn, count, a_style)) {
					return true;
				}
				break;
			}
		}
		return false;
	}
}
