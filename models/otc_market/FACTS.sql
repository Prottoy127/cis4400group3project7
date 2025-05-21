{{ config(materialized="table") }}

with
    facts_cte as (
        select
            ds.security_id,
            dsr.source_id,
            dtv.trading_venue_id,
            dot.tier_id,
            openprice as price_open,
            lastprice as price_last,
            lowprice as price_low,
            highprice as price_high,
            price_last - price_open as price_change,
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
                to_char(to_timestamp(closingbestaskdate), 'YYYYMMDD')
            ) as closing_ask_date_id,
            to_number(
                to_char(to_timestamp(closingbestbiddate), 'YYYYMMDD')
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
        inner join {{ ref("DIM_SOURCE") }} as dsr on r.symbol = dsr.trading_symbol
        inner join {{ ref("DIM_TRADING_VENUE") }} as dtv on r.venue = dtv.trading_venue
        inner join {{ ref("DIM_OTC_TIER") }} as dot on r.tierid = dot.tier_id
    )

select *
from facts_cte
WHERE price_open  > 0
  AND price_last  > 0
  AND price_low   > 0
  AND price_high  > 0