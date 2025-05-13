{{ config(materialized="table") }}

with
    sec_cte as (
        select
            secid as security_id,
            compid as company_id,
            symbol as trading_symbol,
            cusip as cusip_number,
            issue as security_name_issue,
            sectype as security_type,
            class as security_class,
            securitystatus as security_status
        from public.otc_data_raw
    ),

    finra_cte as (
        select
            issuesymbolidentifier as trading_symbol,
            securitydescription as security_description,
            issuername as company_name,
            country as country
        from public.otc_securities_raw
    ),

    state_cte as (
        select
            state as state,
            symbol as trading_symbol
        from public.otc_company_info_raw
    )

select distinct s.*, coalesce(f.security_description,'N/A'), coalesce(f.company_name,'N/A'), coalesce(f.country,'N/A') as country, coalesce(st.state,'N/A') as state
from sec_cte s
left join finra_cte f on s.trading_symbol = f.trading_symbol
left join state_cte st on s.trading_symbol = st.trading_symbol
