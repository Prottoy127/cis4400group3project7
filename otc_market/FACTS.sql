use warehouse compute_wh
;

{{ config(materialized="table") }}

with
    facts_cte as (
        select
            secid as security_id,
            compid as company_id,
            openprice as price_open,
            lastprice as price_last,
            lowprice as price_low,
            highprice as price_high,
            price_high - price_low as closing_spread,
            closinginsidebidprice as closing_last_inside_bid,
            closinginsideaskprice as closing_last_inside_ask,
            insidebid_askmidprice as closing_mid_price,
            previouscloseprice as previous_close_price,
            sharevolume as share_volume,
            dollarvol as dollar_volume,
            tradecount as trade_count,
            otclinksharevol as otc_link_share_volume,
            otclinkdolvol as otc_link_dollar_volume,
            rule3210flag as rule_3120_status_flag,
            shortintvol as short_interest_shares,
            bfcmmid as bona_fide_continuous,
            sharesoutstanding as total_shares_outstanding
        from public.otc_data_raw
    )

select *
from facts_cte
where price_open   is not null
  and price_last   is not null
  and price_low    is not null
  and price_high   is not null