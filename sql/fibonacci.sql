CREATE FUNCTION fibonacci("count" INT)
  RETURNS BIGINT[]
  LANGUAGE plpgsql
  AS $$
DECLARE
  memo BIGINT[] := ARRAY[0, 1];
  start_index INT := array_length(memo, 1);
BEGIN
  FOR i IN start_index..count LOOP
    memo := memo || memo[i] + memo[i - 1];
  END LOOP;
  RETURN memo;
END;
$$;

SELECT 
  ROW_NUMBER() OVER() AS "row",
  "num"
FROM unnest(fibonacci(50)) AS "num";
