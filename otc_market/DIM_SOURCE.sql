USE WAREHOUSE COMPUTE_WH;

{{ config(materialized="table") }}


with source_cte as (
    select distinct ISSUERNAME 
    from public.OTC_SECURITIES_RAW
)

select 
    row_number() over (order by ISSUERNAME) as source_id, ISSUERNAME as source_name
from source_cte
