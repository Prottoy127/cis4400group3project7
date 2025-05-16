{{ config(materialized="table") }}

with
    otc_tier_cte as (
        select distinct
            tierid as tier_id,
            tiername as tier_name
        from public.otc_data_raw
    )

select * from otc_tier_cte