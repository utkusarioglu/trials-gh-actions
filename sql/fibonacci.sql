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

DECLARE TYPE t_assignment AS (
  divisor INT,
  label VARCHAR(4)
);

CREATE FUNCTION fizzbuzzbar(num INT)
  RETURNS VARCHAR(20)
  LANGUAGE plpgsql
  AS $$
DECLARE
  val VARCHAR(20) := '';
  assignments t_assignment[]: [
    ROW(3, 'fizz')::t_assignment,
    ROW(5, 'buzz')::t_assignment,
    ROW(7, 'bar')::t_assignment
  ];
BEGIN
  FOR a in assignments LOOP
    IF "num" % a.divisor = 0 THEN
      val := val || a.label;
    END IF; 
  END LOOP;
  -- IF "num" % 3 = 0 THEN
  --   val := val || 'fizz';
  -- END IF; 

  -- IF "num" % 5 = 0 THEN
  --   val := val || 'buzz';
  -- END IF; 
  
  -- IF "num" % 7 = 0 THEN
  --   val := val || 'bar';
  -- END IF; 

  RETURN val;
END;
$$;

CREATE VIEW v_fizzbuzz AS
  SELECT *
  FROM (
    SELECT 
      "number",
      fizzbuzzbar("number") AS "kind"
    FROM generate_series(1, 100) AS "number"
  )
  WHERE "kind" != ''
;

SELECT * FROM v_fizzbuzz;
