use warehouse compute_wh
;

{{ config(materialized="table") }}


with source_cte as (select distinct issuername from public.otc_securities_raw)

select row_number() over (order by issuername) as source_id, issuername as source_name
from source_cte