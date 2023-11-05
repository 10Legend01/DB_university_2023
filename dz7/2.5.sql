update Students
set GroupId = coalesce((select GroupId from Groups where GroupName = :GroupName), GroupId)
where GroupId = (select GroupId from Groups where GroupName = :FromGroupName)