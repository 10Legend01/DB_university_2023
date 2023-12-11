π{TeamName}(
    π{ContestId, TeamId, TeamName}(Teams ⋈ Contests) ∖
    π{ContestId, TeamId, TeamName}(Teams ⋈ Sessions ⋈ Runs)
)
