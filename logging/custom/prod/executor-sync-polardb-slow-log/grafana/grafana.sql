SELECT
    t.data_timestamp AS "time",
    count( 1 ) AS "每小时出现次数"
FROM
    (
        SELECT DISTINCT sql_template_id,
                        data_timestamp
        FROM
            polardb_slow_log
        WHERE
            $__unixEpochFilter(data_timestamp)
          AND db_name IN ( $db_name )
          and sql_template_id in ($sql_template_id)
    ) t
GROUP BY
    t.data_timestamp
ORDER BY
    t.data_timestamp


--

select
    t.data_timestamp AS "time",
    count(1) as "每小时出现次数"
from (
         select data_timestamp
         from polardb_slow_log
         WHERE
             $__unixEpochFilter(data_timestamp)
           and db_name in ($db_name)
           and sql_template_id in ($sql_template_id)
     )t
group by data_timestamp
ORDER BY data_timestamp


--
SELECT
    t.id AS 'SQL模板ID',
        t.db_name AS '数据库',
        t.times AS '次数',
        FLOOR( t.avg_qt ) AS '平均耗时(秒)',
        t.max_qt AS '最大耗时(秒)',
        t.min_qt AS '最小耗时(秒)',
        t.parse_row_counts AS '扫描行数',
        t.sql_text AS 'SQL模板'
FROM
    (
        SELECT
            pslt.id,
            pslt.db_name,
            CONVERT ( pslt.sql_text USING utf8 ) sql_text,
            psl.data_timestamp,
            psl.parse_row_counts,
            psl.execution_start_time,
            count( 1 ) AS times,
            avg( psl.query_times ) avg_qt,
            max( psl.query_times ) max_qt,
            min( psl.query_times ) min_qt
        FROM
            polardb_slow_log_template pslt
                LEFT JOIN polardb_slow_log psl ON pslt.db_name = psl.db_name
                AND pslt.id = psl.sql_template_id
        WHERE $__unixEpochFilter(data_timestamp) and pslt.db_name in ($db_name) and pslt.id in ($sql_template_id)
        GROUP BY
            db_name,
            sql_text
    ) t
ORDER BY
    t.times DESC


--
SELECT
    execution_start_time as "执行开始时间",
    query_times as "耗时(秒)",
    db_name as "数据库",
    parse_row_counts as '扫描行数',
        convert(sql_text using utf8) "sql"
FROM polardb_slow_log
WHERE
    $__unixEpochFilter(data_timestamp)
  and db_name in ($db_name)
  and sql_template_id in ($sql_template_id)
ORDER BY data_timestamp