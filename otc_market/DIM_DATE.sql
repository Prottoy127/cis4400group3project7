{{ config(materialized="table") }}

with recursive
    date_cte as (
        select cast('2022-01-01' as timestamp) as date_value
        union all
        select date_value + interval '1 day'
        from date_cte
        where date_value + interval '1 day' <= cast('2024-12-31' as timestamp)
    )

select
    {{date_to_int('date_value')}} as date_id,
    cast(extract(year from date_value) as integer) as year_number,
    cast(extract(quarter from date_value) as integer) as quarter_number,
    cast(extract(month from date_value) as integer) as month_number,
    cast(extract(day from date_value) as integer) as day_number,
    cast(floor((extract(day from date_value) - 1) / 7) as integer) + 1 as week_of_month,
    cast(extract(week from date_value) as integer) as week_of_year,
    to_char(date_value, 'Month') as month_name,
    cast(dayname(date_value) as varchar) as day_name,
from date_cte
