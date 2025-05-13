{{ config(materialized="table") }}

with
    facts_cte as (
        select
<<<<<<< HEAD
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
            sharesoutstanding as total_shares_outstanding
        from public.otc_data_raw r
        inner join {{ ref("DIM_SECURITY") }} ds on r.secid = ds.security_id
        inner join {{ ref('DIM_TRADING_VENUE') }} as dv on r.venue = dv.trading_venue
=======
            LASTPRICE as CLOSING_LAST_INSIDE_BID,
            CLOSINGINSIDEBIDPRICE as CLOSING_LAST_INSIDE_ASK,
            INSIDEBID_ASKMIDPRICE as CLOSING_MID_PRICE,
            OPENPRICE as PRICE_OPEN,
            HIGHPRICE as PRICE_HIGH,
            LOWPRICE as PRICE_LOW,
            LASTPRICE as PRICE_LAST,
            PREVIOUSCLOSEPRICE as PREVIOUS_CLOSE_PRICE,
            SHAREVOLUME as SHARE_VOLUME,
            DOLLARVOL as DOLLAR_VOLUME,
            TRADECOUNT as TRADE_COUNT,
            OTCLINKSHAREVOL as OTC_LINK_SHARE_VOLUME,
            OTCLINKDOLVOL as OTC_LINK_DOLLAR_VOLUME,
            OTCLINKEXECCOUNT as OTC_LINK_TRADE_COUNT,
            SHOFLAG as REG_SHO_STATUS_FLAG,
            RULE3210FLAG as RULE_3210_STATUS_FLAG,
            SHORTINTVOL as SHORT_INTEREST_SHARES,
            MMIDCOUNT as NUMBER_OF_MARKET_MAKERS,
            BFCMMID as BONA_FILDE_CONTINUOUS_BFC,
            CLOSINGBESTBID as CLOSING_BEST_BID,
            CLOSINGBESTASK as CLOSING_BEST_ASK,
            SHARESOUTSTANDING as TOTAL_SHARES_OUTSTANDING,
            CAVEATEMPTOR as CAVEAT_EMPTOR_FLAG,
            symbol as trading_symbol,
            TO_NUMBER(TO_CHAR(TO_TIMESTAMP(CLOSINGBESTASKDATE), 'YYYYMMDDHH')) AS closing_ask_date_id,            
            TO_NUMBER(TO_CHAR(TO_TIMESTAMP(CLOSINGBESTBIDDATE), 'YYYYMMDDHH')) AS closing_bid_date_id,
            TO_NUMBER(TO_CHAR(TO_TIMESTAMP(CLOSINGINSIDEASKPRICEDATE), 'YYYYMMDDHH')) AS closing_inside_best_ask_date_id,
            TO_NUMBER(TO_CHAR(TO_TIMESTAMP(CLOSINGINSIDEBIDPRICEDATE), 'YYYYMMDDHH')) AS closing_inside_bid_price_date_id,
            TO_NUMBER(TO_CHAR(TO_TIMESTAMP(PREVIOUSCLOSEDATE), 'YYYYMMDDHH')) AS previous_close_date_id,
            price_high - price_low as closing_spread
        FROM public.otc_data_raw
        ),

    --date_cte as (
    --    select
    --        date_id
    --    from public.DIM_DATE
    --),

    otc_tier_cte as (
        select
            otc_tier_id,
            trading_symbol
        from public.DIM_OTC_TIER
    ),
    
    sec_cte as (
        select
            SECURITY_ID,
            trading_symbol
        from public.DIM_SECURITY
    ),
    
    source_cte as (
        select
            SOURCE_ID,
            trading_symbol
        from public.DIM_SOURCE
    ),
    
    trading_venue_cte as (
        select
            TRADING_VENUE_ID,
            trading_symbol
        from public.dim_trading_venue
>>>>>>> 47b936023ccaf08a8bb45c81eb5fbe9392da0a4e
    )

select f.*, o.*, se.*, so.*, tr.*
from facts_cte f
--left join date_cte d on f.trading_symbol = d.trading_symbol
left join otc_tier_cte o on f.trading_symbol = o.trading_symbol
left join sec_cte se on f.trading_symbol = se.trading_symbol
left join source_cte so on f.trading_symbol = so.trading_symbol
left join trading_venue_cte tr on f.trading_symbol = tr.trading_symbol
where
    price_open is not null
    and price_last is not null
    and price_low is not null
    and price_high is not null
