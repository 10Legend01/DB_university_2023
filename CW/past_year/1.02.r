π{RunId, SessionId, Letter, SubmitTime, Accepted}(
    σ{ContestId = :ContestId ⋀ TeamId = :TeamId}(Sessions ⋈ Runs)
)