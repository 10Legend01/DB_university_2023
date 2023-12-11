π{TeamName}(
    π{TeamId, TeamName}(Teams) \ π{TeamId, TeamName}(
        σ{Accepted = 1}(Teams ⋈ Sessions ⋈ Runs)
    )
)