π{RunId, TeamId, SubmitTime, Accepted}(
    σ{ContestId = :ContestId ⋀ Accepted = 1}(Sessions ⋈ Runs)
)