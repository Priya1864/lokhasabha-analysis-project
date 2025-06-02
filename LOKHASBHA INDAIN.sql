CREATE TABLE constituencywise_details (Serialnumber int,Candidate varchar(100),
Party varchar(100),	EVMVotes decimal,PostalVotes int,	
TotalVotes int,	percenatgeofvotes float,ConstituencyID varchar(30));---constituencyid
drop table if exists constituencywise_details ;

create table constituencywise_results(serialnumber int,ParliamentConstituency varchar(100),
ConstituencyName varchar(100),	WinningCandidate varchar(150),
TotalVotes int,	Margin int,	ConstituencyID  varchar(100),PartyID int);--constituencyid connect to constituencywise_details and parliamentconstituency connncet to statewise results

create table statewise_results(Constituency varchar(100),ConstNo int,
ParliamentConstituency	 varchar(100),LeadingCandidate varchar(150),
TrailingCandidate varchar(150),Margin	 int,Status varchar(100),StateID varchar(100),
State varchar(100));---parlimentconstituency ,and ststeid connects to state
 
create table partywise_results(Party varchar(100),	Won int,PartyID int);--partityid connects to consistuencywise_results partyid

create table state(StateID	varchar(100),State varchar(100));---connects  stateid to satewise_results

--EDA
select*from constituencywise_details
WHERE SERIALNUMBER IS NULL OR
CANDIDATE IS NULL 
OR PARTY IS NULL 
OR EVMVOTES IS NULL
OR POSTALVOTES IS NULL
OR TOTALVOTES IS NULL
OR CONSTITUENCYID IS NULL
or percentageofvotes is null;

---#checking duplicates
SELECT CONSTITUENCYID, COUNT(*) AS VOTES
FROM CONSTITUENCYWISE_DETAILS
GROUP BY CONSTITUENCYID
HAVING COUNT(*) > 1;

SELECT*FROM CONSTITUENCYWISE_RESULTS
WHERE SERIALNUMBER IS NULL 
OR PARLIAMENTCONSTITUENCY IS NULL 
OR CONSTITUENCYNAME IS NULL OR WINNINGCANDIDATE IS NULL 
OR TOTALVOTES IS NULL 
OR MARGIN IS NULL
OR CONSTITUENCYID IS NULL 
OR PARTYID IS NULL;

 SELECT *FROM STATEWISE_RESULTS 
 WHERE CONSTITUENCY IS NULL 
 OR CONSTNO IS NULL 
 OR PARLIAMENTCONSTITUENCY IS NULL 
 OR LEADINGCANDIDATE IS NULL 
 OR TRAILINGCANDIDATE IS NULL 
 OR MARGIN IS NULL 
 OR STATUS IS NULL
 OR STATEID IS NULL;
 delete from statewise_results where constno=24;
 OR STATE IS NULL;

 SELECT*FROM PARTYWISE_RESULTS
 WHERE PARTY IS NULL 
OR WON IS NULL
OR PARTYID IS NULL;

 SELECT*FROM STATE 
 WHERE STATEid IS NULL
 OR STATE IS NULL;


 ---WHAT ARE THE TOTAL OF SEATS AVAILABLE FOR ELECTIONS IN EACH STATE
 SELECT 
    s.state, 
    COUNT(cr.parliamentconstituency) AS seats 
FROM constituencywise_results cr
JOIN statewise_results sr ON cr.parliamentconstituency = sr.parliamentconstituency
JOIN state s ON sr.stateid = s.stateid
GROUP BY s.state
ORDER BY seats DESC;


 --total seats won by NDA ALLIANCE
SELECT 
    SUM(CASE 
            WHEN PARTY IN (
                'Bharatiya Janata Party - BJP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Apna Dal (Soneylal) - ADAL',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Asom Gana Parishad - AGP',
                'Sikkim Krantikari Morcha - SKM',
                'Shiromani Akali Dal - SAD',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Telugu Desam - TDP',
                'United People’s Party, Liberal - UPPL'
            ) 
            THEN WON 
            ELSE 0 
        END
    ) AS NDA_ALLIANCE_SEATS
FROM PARTYWISE_RESULTS;
 


---TOTAL SEATS WON BY INDIA ALAIANSS
SELECT  PARTY,WON  FROM PARTYWISE_RESULTS WHERE PARTY IN (
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian National Congress - INC',
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK',
                'Aazad Samaj Party (Kanshi Ram) - ASPKR')
GROUP BY 1,2
ORDER BY 2 DESC;

SELECT*FROM PARTYWISE_RESULTS;
ALTER TABLE PARTYWISE_RESULTS ADD COLUMN PARTYALAINANS VARCHAR(100);

UPDATE PARTYWISE_RESULTS
SET PARTYALAINANS='INDIA'
WHERE PARTY IN('Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian National Congress - INC',
                'Indian Union Muslim League - IUML',
                'Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK',
                'Aazad Samaj Party (Kanshi Ram) - ASPKR');


UPDATE PARTYWISE_RESULTS
SET PARTYALAINANS='NDA'
WHERE PARTY IN( 'Bharatiya Janata Party - BJP',
                'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS',
                'Lok Janshakti Party(Ram Vilas) - LJPRV',
                'Apna Dal (Soneylal) - ADAL',
                'Hindustani Awam Morcha (Secular) - HAMS',
                'Asom Gana Parishad - AGP',
                'Sikkim Krantikari Morcha - SKM',
                'Shiromani Akali Dal - SAD',
                'Janasena Party - JnP',
                'Janata Dal  (Secular) - JD(S)',
                'Telugu Desam - TDP',
                'United People’s Party, Liberal - UPPL');

UPDATE PARTYWISE_RESULTS
SET PARTYALAINANS = 'OTHERS'
WHERE PARTYALAINANS IS NULL;


SELECT PARTY,WON FROM PARTYWISE_RESULTS
WHERE PARTYALLIANCE='INDIA'
GROUP BY 1,2
ORDER BY 2 DESC;



SELECT PARTY,WON FROM PARTYWISE_RESULTS
WHERE PARTYALLIANCE='NDA'
GROUP BY 1,2
ORDER BY 2 DESC;


SELECT PARTY,WON FROM PARTYWISE_RESULTS
WHERE PARTYALLIANCE='OTHERS'
GROUP BY 1,2
ORDER BY 2 DESC;

---WINING CANDIDATE NAME,TOTALVOTES AND THE MARGIN OF VICTORY FOR A SPECIFIC STATE AND CONSTITUENCY
SELECT CR.WINNINGCANDIDATE ,CR.TOTALVOTES,CR.MARGIN,S.STATE,CR.CONSTITUENCYNAME ,PR.PARTY 
FROM constituencywise_RESULTS  CR
JOIN PARTYWISE_RESULTS PR
ON PR.PARTYID=CR.PARTYID
JOIN STATEWISE_RESULTS  SR 
ON CR.PARLIAMENTCONSTITUENCY=SR.PARLIAMENTCONSTITUENCY
JOIN STATE S
ON S.STATEID=SR.STATEID
WHERE CR.CONSTITUENCYNAME IN ('AGRA','BARAMATI');



---WHAT IS THE DISTRIBUTION OF EVM VOTES VERSUS POSTAL VOTES FOR CANDIDATES IN A SPECIFIC CONSTITUENCY?
SELECT CANDIDATE,EVMVOTES,POSTALVOTES,CR.CONSTITUENCYNAME 
FROM  constituencywise_DETAILS CD
JOIN  constituencywise_RESULTS CR 
ON  CR.CONSTITUENCYID=CD.CONSTITUENCYID
WHERE CR.CONSTITUENCYNAME='WARANGAL'
ORDER BY 2 DESC,3 DESC;



---WHICH PARTIES WON THE MOST SEATS IN A STATE ,AND HOW MANY SEATS DID EACH PARTY WIN
SELECT PARTY,COUNT(*) AS WONSEATSBYPARTY FROM (SELECT  PR.PARTY,S.STATE ,COUNT(cr.constituencyid) as wonresult  ,
DENSE_RANK() OVER(PARTITION BY S.STATE ORDER BY COUNT(cr.constituencyid) DESC) AS RNK FROM PARTYWISE_RESULTS PR
JOIN constituencywise_RESULTS CR ON CR.PARTYID=PR.PARTYID
JOIN STATEWISE_RESULTS SR
ON CR.parliamentconstituency=SR.parliamentconstituency
JOIN STATE  S 
ON SR.STATEID=S.STATEID
GROUP BY 1,2)T
WHERE RNK=1
GROUP BY 1
ORDER BY 2 DESC;



---WHAT IS THE TOTAL NO.OF SEATS WON BY EACH PARTY ALLIANCE


	WITH party_alliance_map AS (
    SELECT 'Bharatiya Janata Party - BJP' AS party, 'NDA' AS alliance UNION
    SELECT 'Janata Dal  (United) - JD(U)', 'NDA' UNION
    SELECT 'Shiv Sena - SHS', 'NDA' UNION
    SELECT 'Lok Janshakti Party(Ram Vilas) - LJPRV', 'NDA' UNION
    SELECT 'Apna Dal (Soneylal) - ADAL', 'NDA' UNION
    SELECT 'Indian National Congress - INC', 'INDIA' UNION
    SELECT 'Dravida Munnetra Kazhagam - DMK', 'INDIA' UNION
    SELECT 'Aam Aadmi Party - AAAP', 'INDIA' UNION
    SELECT 'All India Trinamool Congress - AITC', 'INDIA' UNION
    SELECT 'Samajwadi Party - SP', 'INDIA'
),
combined_data AS (
    SELECT 
        s.state,
        COALESCE(pam.alliance, 'OTHERS') AS alliance
    FROM 
        constituencywise_results cr
    JOIN partywise_results pr ON cr.partyid = pr.partyid
    JOIN statewise_results sr ON cr.parliamentconstituency = sr.parliamentconstituency
    JOIN state s ON sr.stateid = s.stateid
    LEFT JOIN party_alliance_map pam ON pr.party = pam.party
)
SELECT 
    state,
    alliance,
    COUNT(*) AS seats_won
FROM 
    combined_data
GROUP BY 
    state, alliance
ORDER BY 
    state, seats_won DESC;


	SELECT
    s.state,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'INDIA' THEN 1 ELSE 0 END) AS INDIA_Seats,
    SUM(CASE WHEN pr.PARTYALLIANCE = 'OTHERS' THEN 1 ELSE 0 END) AS OTHERS_Seats
FROM
    constituencywise_results cr
JOIN
    partywise_results pr ON cr.partyid = pr.partyid
JOIN
    statewise_results sr ON cr.parliamentconstituency = sr.parliamentconstituency
JOIN
    state s ON sr.stateid = s.stateid
GROUP BY
    s.state
ORDER BY
    s.state;
---partywise totalwons
SELECT 
    PARTYALLIANCE AS ALLIANCE,
    SUM(WON) AS TOTAL_SEATS_WON
FROM 
    PARTYWISE_RESULTS
GROUP BY 
   PARTYALLIANCE
ORDER BY 
    TOTAL_SEATS_WON DESC;


--winningcandiate from each state and party,constituency
SELECT 
    cr.ConstituencyName,
    cr.WinningCandidate,

cr.TotalVotes,
    cr.Margin,
    s.State,
    pr.Party
FROM constituencywise_results cr
JOIN partywise_results pr ON pr.PartyID = cr.PartyID
JOIN statewise_results sr ON cr.ParliamentConstituency = sr.ParliamentConstituency
JOIN state s ON sr.StateID = s.StateID;


---wiinnimgcandidate and constiuency from maharashtra 
SELECT 
    S.State,
    CR.ConstituencyName,
    CD.Candidate,
    PR.Party
FROM Constituencywise_Results CR
JOIN Partywise_Results PR ON CR.PartyID = PR.PartyID
JOIN Statewise_results sr  ON CR.parliamentconstituency = sr.parliamentconstituency
join state s on s.stateid=sr.stateid
JOIN Constituencywise_Details CD ON CR.ConstituencyID = CD.ConstituencyID
WHERE S.State = 'Maharashtra';
SELECT*FROM Constituencywise_RESULTS;


--total seats per party
SELECT 
    PR.Party,
    COUNT(CR.ConstituencyID) AS TotalSeats
FROM Constituencywise_Results CR
JOIN Partywise_Results PR ON CR.PartyID = PR.PartyID
GROUP BY PR.Party
ORDER BY TotalSeats DESC;











