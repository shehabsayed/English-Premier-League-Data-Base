--Tables:-

CREATE TABLE ALL_Match
(
  Date DATE NOT NULL,
  Hometeam VARCHAR(50) NOT NULL,
  Result TIME NOT NULL,
  AwayTeam VARCHAR(50) NOT NULL
);

CREATE TABLE ALL_Player
(
  Team VARCHAR(50) NOT NULL,
  Jerseyno INT NOT NULL,
  Player VARCHAR(50) NOT NULL,
  Position VARCHAR(50) NOT NULL,
  Appearance INT NOT NULL,
  Substitution INT NOT NULL,
  Goals INT NOT NULL,
  Penalties INT NOT NULL,
  RedCards FLOAT NOT NULL,
  YellowCards FLOAT NOT NULL,
);


CREATE TABLE Points
(
  POS INT NOT NULL,
  Team VARCHAR(50) NOT NULL,
  PLD INT NOT NULL,
  W INT NOT NULL,
  D INT NOT NULL,
  L INT NOT NULL,
  GF INT NOT NULL,
  GA INT NOT NULL,
  GD INT NOT NULL,
  Pts INT NOT NULL,
  PRIMARY KEY (POS)
);


CREATE TABLE Matches
(
  MatchID INT IDENTITY (1,1) PRIMARY KEY,
  Date DATE NOT NULL,
  Hometeam VARCHAR(50) NOT NULL,
  Result TIME NOT NULL,
  AwayTeam VARCHAR(50) NOT NULL,
);


CREATE TABLE Players
(
  PlayerID INT IDENTITY (1,1) PRIMARY KEY,
  Team VARCHAR(50) NOT NULL,
  Jerseyno INT NOT NULL,
  Player VARCHAR(50) NOT NULL,
  Position VARCHAR(50) NOT NULL,
  Appearance INT NOT NULL,
  Substitution INT NOT NULL,
  Goals INT NOT NULL,
  Penalties INT NOT NULL,
  RedCards FLOAT NOT NULL,
  YellowCards FLOAT NOT NULL,
);


CREATE TABLE Fact
(
  FactID INT IDENTITY (1,1) PRIMARY KEY,
  GF INT,
  GD INT,
  PLD INT,
  GA INT,
  W INT,
  D INT ,
  L INT ,
  Pts INT,
  Substitution INT,
  Goals INT,
  YellowCards FLOAT,
  Penalties INT,
  RedCards FLOAT,
  Appearance INT,
  MatchID INT NOT NULL,
  PlayerID INT NOT NULL,
  POS INT NOT NULL,
  FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
  FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
  FOREIGN KEY (POS) REFERENCES Points(POS)
);

--Load Data:-

--BULK INSERT ALL_Match
FROM 'C:\Users\PC\Downloads\archive_2\all_match_results.csv'
WITH (
    FORMAT = 'CSV', 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


--BULK INSERT ALL_Player
FROM 'C:\Users\PC\Downloads\archive_2\all_players_stats.csv'
WITH (
    FORMAT = 'CSV', 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


--BULK INSERT Points
FROM 'C:\Users\PC\Downloads\archive_2\points_table.csv'
WITH (
    FORMAT = 'CSV', 
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


INSERT INTO Matches
SELECT * FROM ALL_Match;

INSERT INTO Players
SELECT * FROM ALL_Player;


INSERT INTO Fact (GF,GD,PLD,GA,W,D,L,Pts,Substitution,Goals,YellowCards,Penalties,RedCards,Appearance, MatchID, PlayerID, POS)
SELECT 
    Po.GF,
    Po.GD,
    Po.PLD,
    Po.GA,
    Po.W,
    Po.D,
    Po.L,
    Po.Pts,
    p.Substitution,
    p.Goals,
    p.YellowCards,
    p.Penalties,
    p.RedCards,
    P.Appearance,
    m.MatchID,
    p.PlayerID,
    po.POS
FROM Matches as m
JOIN Players as p ON m.Hometeam = p.Team OR m.AwayTeam = p.Team
JOIN Points as po ON p.Team = po.Team;