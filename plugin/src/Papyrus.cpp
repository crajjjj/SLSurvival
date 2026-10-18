#include "Papyrus.h"

#include "AliasFill.h"
#include "Contraband.h"

// A released native never changes signature: the VM rejects a call whose argument count
// differs, and callers compiled against the old one send the old count forever. New
// options mean a new native and a higher API version.

namespace Papyrus
{
	namespace
	{
		constexpr auto SCRIPT = "_SLS_Native"sv;
		constexpr std::int32_t API_VERSION = 1;

		std::int32_t GetAPIVersion(RE::StaticFunctionTag*)
		{
			return API_VERSION;
		}

		std::vector<RE::Actor*> FillQuestAliases(RE::StaticFunctionTag*, RE::TESQuest* a_quest)
		{
			return AliasFill::Fill(a_quest);
		}

		bool HasContraband(RE::StaticFunctionTag*, RE::TESObjectREFR* a_target, std::int32_t a_kind,
			RE::BGSListForm* a_armorExceptions, RE::BGSListForm* a_weaponExceptions, std::int32_t a_followerLicStyle)
		{
			if (a_kind < 0 || a_kind > 3) {
				return false;
			}
			return Contraband::Has(a_target, static_cast<Contraband::Kind>(a_kind), a_armorExceptions, a_weaponExceptions, a_followerLicStyle);
		}
	}

	bool Register(RE::BSScript::IVirtualMachine* a_vm)
	{
		// The last argument is "callable from tasklets". The two that read live game state
		// (alias conditions, inventories) pass false, so they run on the main thread.
		a_vm->RegisterFunction("GetAPIVersion"sv, SCRIPT, GetAPIVersion, true);
		a_vm->RegisterFunction("FillQuestAliases"sv, SCRIPT, FillQuestAliases, false);
		a_vm->RegisterFunction("HasContraband"sv, SCRIPT, HasContraband, false);
		logger::info("registered {} natives, API {}", SCRIPT, API_VERSION);
		return true;
	}
}
