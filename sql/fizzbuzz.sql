CREATE VIEW fizzbuzz AS
  SELECT 
    "number",
    (
      CASE WHEN "number" % 3 = 0 
        THEN 'fizz'
        ELSE ''
      END
      ||
      CASE WHEN "number" % 5 = 0
        THEN 'buzz'
        ELSE ''
      END
    ) AS "kind"
  FROM generate_series(1, 200) AS "number";
  WHERE "kind" != '';
