CREATE FUNCTION fibonacci("count" INT)
  RETURNS INT[]
  LANGUAGE plpgsql
  AS $$
DECLARE
  memo INT[] := ARRAY[0, 1];
  start_index INT := array_length(memo, 1);
BEGIN
  RAISE NOTICE 'start_index: %', start_index;
  FOR i IN start_index..count LOOP
    memo = memo || memo[i] + memo[i - 1];
    -- RAISE NOTICE 'i: %, l: %, e: %, v: %', i, array_length(memo, 1), memo[i], memo[i - 1] + memo[];
  END LOOP;
  RETURN memo;
END;
$$;

SELECT 
  ROW_NUMBER() OVER() AS "row",
  "num"
FROM unnest(fibonacci(200)) AS "num";
