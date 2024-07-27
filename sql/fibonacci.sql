CREATE FUNCTION fibonacci("count" INT)
  RETURNS INT[]
  LANGUAGE plpgsql
  AS $$
DECLARE
  "memo" INT[] := ARRAY[0, 1];
  "start_index" INT := array_length("memo", 1);
BEGIN
  FOR i IN "start_index".."count" LOOP
    "memo" := "memo" || memo[-1] + memo[-2];
  END LOOP;
  RETURN "memo";
END;
$$;

\x
SELECT 
  ROW_NUMBER() OVER() AS "row",
  "num"
FROM unnest(fibonacci(200)) AS "num";
