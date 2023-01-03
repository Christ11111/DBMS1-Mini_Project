-- 1

SELECT  ibd.BIDDER_ID, ibd1.BIDDER_NAME, (COUNT(BID_STATUS)/NO_OF_BIDS * 100) percentage_of_winnings
FROM ipl_bidding_details ibd  JOIN ipl_bidder_points ibp
ON ibd.BIDDER_ID = ibp.BIDDER_ID
JOIN ipl_bidder_details ibd1 
ON ibd1.BIDDER_ID = ibp.BIDDER_ID
WHERE BID_STATUS = 'WON'
GROUP BY ibd.BIDDER_ID
ORDER BY percentage_of_winnings DESC;

-- 2
SELECT COUNT(MATCH_ID), ims.STADIUM_ID,STADIUM_NAME, CITY FROM ipl_match_schedule ims JOIN ipl_stadium ips
ON ims.STADIUM_ID = ips.STADIUM_ID
GROUP BY STADIUM_NAME;

-- 3
select STADIUM_NAME
, ((select count(ims.match_id) from ipl_match_schedule ims join ipl_match on ims.match_id = ipl_match.match_id
where toss_winner = match_winner
and ims.stadium_id = ipl_stadium.stadium_id)/
(select count(*) from ipl_match_schedule ims where ims.stadium_id = ipl_stadium.stadium_id)*100) as Pecentage_of_wins
FROM ipl_stadium
order by stadium_name;
 
 -- 4
 
 select ibd.bid_team,team_name, count(*) bid_count from 
 ipl_bidding_details ibd
 join ipl_team
 on ibd.bid_team = ipl_team.team_id
 group by team_name;
 
 -- 5
 
 select win_details, match_winner from ipl_match
 group by win_details;
 
 -- 6
 
 select its.team_id,team_name, sum(matches_played)total_matches_played, 
 sum(matches_won)total_matches_won, sum(matches_lost) total_matches_lost from 
 ipl_team_standings its join ipl_team
 on its.team_id = ipl_team.team_id
 group by its.team_id;
 
 -- 7 
 
 select player_name from 
 ipl_team_players itp join
 ipl_team ON itp.team_id = ipl_team.team_id
 join ipl_player ON itp.player_id = ipl_player.player_id
 where team_name like '%Mumbai%' and player_role like '%bowler%';
 
 -- 8
 
 select itp.team_id, team_name, count(*) Count_of_All_Rounders from
 ipl_team_players itp join
 ipl_team ON itp.team_id = ipl_team.team_id
 where player_role like '%all%'
 group by team_name
 having Count_of_All_Rounders > 4
 