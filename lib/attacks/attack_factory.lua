AttackFactory = {}
function AttackFactory.get(stage)
	if stage == 0 then
		return Hadouken.new()
	elseif stage == 1 then
		return GreenBall.new()
	elseif stage == 2 then
		return Spread.new()
	elseif stage == 3 then
		return Stars.new()
	elseif stage == 4 then
		return BallBlast.new()
	elseif stage == 5 then
		return FireRain.new()
	end
	return nil
end

function AttackFactory.max()
	return 6
end