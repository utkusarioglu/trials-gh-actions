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

CREATE TYPE t_assignment AS (
  divisor INT,
  label VARCHAR(4)
);

CREATE FUNCTION fizzbuzzbar(num INT)
  RETURNS VARCHAR(20)
  LANGUAGE plpgsql
  AS $$
DECLARE
  val VARCHAR(20) := '';
  assignments t_assignment[]: ARRAY[
    (3, 'fizz'),
    (5, 'buzz'),
    (7, 'bar')
  ];
BEGIN
  FOR a in assignments LOOP
    IF "num" % a.divisor = 0 THEN
      val := val || a.label;
    END IF; 
  END LOOP;
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
