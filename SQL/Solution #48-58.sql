--48. The Report
SELECT (CASE WHEN B.GRADE<8 THEN NULL ELSE A.NAME END), B.GRADE, A.MARKS
FROM STUDENTS A, GRADES B
WHERE A.MARKS BETWEEN B.MIN_MARK AND B.MAX_MARK
ORDER BY B.GRADE DESC, A.NAME


--49. Top Competitors
SELECT H.HACKER_ID, H.NAME
FROM SUBMISSIONS S
    JOIN CHALLENGES C
    ON S.CHALLENGE_ID = C.CHALLENGE_ID
    JOIN DIFFICULTY D
    ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL 
    JOIN HACKERS H
    ON S.HACKER_ID = H.HACKER_ID
WHERE S.SCORE = D.SCORE
GROUP BY H.HACKER_ID, H.NAME
  HAVING COUNT(H.HACKER_ID) > 1
ORDER BY COUNT(H.HACKER_ID) DESC, H.HACKER_ID ASC


--50. Print Prime Numbers
DELIMITER $$
CREATE PROCEDURE getPrime(IN n int, OUT result varchar(16383))
BEGIN
DECLARE j, i, isPrime int;
SET j := 2; 
SET result := ' '; 
WHILE(j < n) DO
    SET i := 2;
    SET isPrime := 0;

    WHILE(i <= j) DO
        IF(j%i = 0)THEN
            SET isPrime := isPrime + 1;
        END if;
    SET i := i + 1; /* Increment i */
    END WHILE;

    IF (isPrime = 1) THEN
        SET result:=concat(result, j, '&'); 
    END IF;

    SET j := j + 1;
end while;
End $$

call getPrime(1000, @result);
select substr(@result, 1, length(@result)-1);


--51. Ollivander's Inventory
SELECT W.ID, P.AGE, W.COINS_NEEDED, W.POWER
FROM WANDS W JOIN WANDS_PROPERTY P 
    ON W.CODE = P.CODE
WHERE P.IS_EVIL = 0 
  AND W.COINS_NEEDED = (
      SELECT MIN(COINS_NEEDED) 
      FROM WANDS 
      WHERE CODE = W.CODE
        AND POWER = W.POWER)
ORDER BY W.POWER DESC, P.AGE DESC


--52. Challenges
SELECT C.HACKER_ID, H.NAME, COUNT(C.HACKER_ID) as CNT
FROM HACKERS H JOIN CHALLENGES C
    ON H.HACKER_ID = C.HACKER_ID
GROUP BY C.HACKER_ID, H.NAME
HAVING CNT = (SELECT MAX(TMP.C_CNT) 
                   FROM (SELECT COUNT(HACKER_ID) AS C_CNT
                         FROM CHALLENGES
                        GROUP BY HACKER_ID
                        ORDER BY HACKER_ID)TMP)
       OR CNT IN (SELECT TMP2.CNT
             FROM (SELECT COUNT(*) AS CNT 
                   FROM CHALLENGES
                   GROUP BY HACKER_ID) TMP2
             GROUP BY TMP2.CNT
             HAVING COUNT(TMP2.CNT) = 1)
ORDER BY CNT DESC, C.HACKER_ID


--53. Contest Leaderboard
--54. SQL Project Planning
--55. Placements
--56. Symmetric Pairs
--57. Interviews
--58. 15 Days of Learning SQL