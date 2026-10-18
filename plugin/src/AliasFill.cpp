#include "AliasFill.h"

// Replaces SL Survival's "restart a search quest and read its aliases" pattern: the guard
// searches restarted a quest every 1.5-3 s while a toll was due or the player carried
// something a town forbids, only to see who the engine put in the aliases. Evaluating the
// same alias conditions here gives the same answer without the restart, the quest's OnInit
// and the alias bookkeeping.
//
// Deliberate differences from the engine, all on the side of a false "someone matched" (the
// callers then restart the quest as before and get the engine's own answer):
// - reservations by other quests' aliases are not checked;
// - candidates are the actors in the high and middle-high process lists, which is every
//   actor in the loaded area, references that are not actors are never offered.
// A candidate the engine would accept is never dropped: the conditions are the alias's own.

namespace AliasFill
{
	namespace
	{
		struct Candidate
		{
			RE::Actor* actor;
			float      distance;
		};

		void Collect(const RE::BSTArray<RE::ActorHandle>& a_handles, const RE::Actor* a_player, std::vector<Candidate>& a_out)
		{
			for (const auto& handle : a_handles) {
				const auto actorPtr = handle.get();
				auto*      actor = actorPtr.get();
				if (!actor || actor == a_player || actor->IsDeleted()) {
					continue;
				}
				a_out.push_back({ actor, actor->GetPosition().GetDistance(a_player->GetPosition()) });
			}
		}

		bool Eligible(const RE::BGSRefAlias& a_alias, RE::Actor* a_actor, RE::PlayerCharacter* a_player)
		{
			using FLAGS = RE::BGSBaseAlias::FLAGS;
			if (!a_alias.flags.any(FLAGS::kAllowDead) && a_actor->IsDead()) {
				return false;
			}
			if (!a_alias.flags.any(FLAGS::kAllowDisabled) && a_actor->IsDisabled()) {
				return false;
			}
			// Subject = the candidate, as in the engine's fill; the player as target only
			// matters to a condition run on "Target", which none of SLS's search aliases use
			return !a_alias.conditions || a_alias.conditions->IsTrue(a_actor, a_player);
		}
	}

	std::vector<RE::Actor*> Fill(RE::TESQuest* a_quest)
	{
		if (!a_quest || a_quest->aliases.empty()) {
			return { nullptr };
		}
		std::vector<RE::Actor*> result(a_quest->aliases.size(), nullptr);

		auto* player = RE::PlayerCharacter::GetSingleton();
		auto* lists = RE::ProcessLists::GetSingleton();
		if (!player || !lists) {
			return result;
		}

		std::vector<Candidate> candidates;
		Collect(lists->highActorHandles, player, candidates);
		Collect(lists->middleHighActorHandles, player, candidates);
		std::ranges::sort(candidates, {}, &Candidate::distance);  // the aliases here are all "Closest"

		for (std::uint32_t i = 0; i < a_quest->aliases.size(); ++i) {
			auto* base = a_quest->aliases[i];
			if (!base || base->QType() != "Ref"sv) {
				continue;
			}
			auto* alias = static_cast<RE::BGSRefAlias*>(base);
			if (alias->fillType.get() != RE::BGSBaseAlias::FILL_TYPE::kConditions) {
				continue;
			}
			const bool reuse = alias->flags.any(RE::BGSBaseAlias::FLAGS::kAllowReuse);
			for (const auto& candidate : candidates) {
				if (!reuse && std::ranges::find(result, candidate.actor) != result.end()) {
					continue;  // already holds an earlier alias of this quest
				}
				if (Eligible(*alias, candidate.actor, player)) {
					result[i] = candidate.actor;
					break;
				}
			}
		}
		return result;
	}
}
