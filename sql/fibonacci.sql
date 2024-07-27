CREATE FUNCTION fibonacci(count INT)
  RETURNS BIGINT[]
  LANGUAGE plpgsql
  AS $$
DECLARE
  memo BIGINT[] := ARRAY[0, 1];
BEGIN
  FOR i IN array_length(memo, 1)..(count - 1) LOOP
    memo := memo || memo[i] + memo[i - 1];
  END LOOP;
  RETURN memo;
END;
$$;

SELECT 
  ROW_NUMBER() OVER() AS "row",
  "num"
FROM unnest(fibonacci(52)) AS "num";

CREATE FUNCTION fizzbuzzbar(num INT)
  RETURNS VARCHAR(20)
  LANGUAGE plpgsql
  AS $$
DECLARE
  val VARCHAR(20) := '';
BEGIN
  IF "num" % 3 = 0 THEN
    val := val || 'fizz';
  END IF; 

  IF "num" % 5 = 0 THEN
    val := val || 'buzz';
  END IF; 
  
  IF "num" % 7 = 0 THEN
    val := val || 'bar';
  END IF; 
END;
$$;

CREATE VIEW fizzbuzz AS
  SELECT * 
  FROM (
    SELECT 
      "number",
      fizzbuzzbar("number") AS "kind"
    FROM generate_series(1, 100) AS "number"
  )
  WHERE "kind" != ''
;
