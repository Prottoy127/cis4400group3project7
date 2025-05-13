use warehouse compute_wh
;

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
    )

select distinct s.*, f.security_description, f.company_name, f.country
from sec_cte s
left join finra_cte f on s.trading_symbol = f.trading_symbol