--Queries:-

SELECT Team,AVG(GF * 1.0 / PLD) AS Average_team_Goals_Per_Match
FROM Points
GROUP BY Team
ORDER BY Average_team_Goals_Per_Match DESC


SELECT Team,AVG(GA * 1.0 / PLD) AS  Avg_team_goals_conceded_per_match
FROM Points
GROUP BY Team
ORDER BY  Avg_team_goals_conceded_per_match



SELECT PlayerID,Player,Team,AVG(CASE WHEN Appearance > 0 THEN Goals * 1.0 / Appearance ELSE 0 END) AS Avg_player_Goals_per_match
FROM Players
GROUP BY PlayerID,Player,Team
ORDER BY Avg_player_Goals_per_match DESC

SELECT PlayerID,Player,Players.Team,AVG(Goals*1.0/GF) AS avg_player_contribution_per_team
FROM Players,Points 
GROUP BY PlayerID,Player,Players.Team
ORDER BY avg_player_contribution_per_team DESC


SELECT Team, GA, GD, Pts, (W*1.0)/L AS Win_Loss_Ratio
FROM Points
ORDER BY Win_Loss_Ratio ASC, Pts ASC;


SELECT PlayerID, Player, Team, Goals,Penalties,
(Goals-Penalties) AS Total_Contribution_without_penalties
FROM Players
ORDER BY Total_Contribution_without_penalties DESC;


SELECT PlayerID, Player, Team, YellowCards, RedCards, Substitution,
       (YellowCards + RedCards) AS Total_Cards,
       CASE
           WHEN Substitution > 0 THEN ((YellowCards + RedCards) * 1.0) / Substitution
           ELSE 0
       END AS Cards_Per_Substitution
FROM Players
ORDER BY Cards_Per_Substitution DESC;
