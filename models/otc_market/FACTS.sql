{{ config(materialized="table") }}

with
    facts_cte as (
        select
            ds.security_id,
            dv.trading_venue_id as trading_venue_id,
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
            caveatemptor as caveat_emptor_flag,
            shortintvol as short_interest_shares,
            bfcmmid as bona_fide_continuous,
            sharesoutstanding as total_shares_outstandin,
            to_number(
                to_char(to_timestamp(closingbestaskdate), 'YYYYMMDDHH')
            ) as closing_ask_date_id,
            to_number(
                to_char(to_timestamp(closingbestbiddate), 'YYYYMMDDHH')
            ) as closing_bid_date_id,
            to_number(
                to_char(to_timestamp(closinginsideaskpricedate), 'YYYYMMDD')
            ) as closing_inside_best_ask_date_id,
            to_number(
                to_char(to_timestamp(closinginsidebidpricedate), 'YYYYMMDD')
            ) as closing_inside_bid_price_date_id,
            to_number(
                to_char(to_timestamp(previousclosedate), 'YYYYMMDD')
            ) as previous_close_date_id,
        from public.otc_data_raw r
        inner join {{ ref("DIM_SECURITY") }} ds on r.secid = ds.security_id
        inner join {{ ref("DIM_TRADING_VENUE") }} as dv on r.venue = dv.trading_venue
    )

select *
from facts_cte
where
    price_open is not null
    and price_last is not null
    and price_low is not null
    and price_high is not null
