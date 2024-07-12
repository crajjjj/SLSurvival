Scriptname SlaInternals Hidden

Function ClearLocks() Global Native
Bool Function TryLock(Int lockID) Global Native
Bool Function Unlock(Int lockID) Global Native
Actor[] Function DuplicateActorArray(Actor[] list, Int count) Global Native


Float Function GetRandomFloat(Float lo, Float hi) Global Native
Float Function UpdateExposure(Float actorExposure, Float actorExposureDelta, Float timeRateHalfLife, Float currentTime, Float lastExposureTime) Global Native
