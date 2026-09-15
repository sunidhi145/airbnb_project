{% set cols=['NIGHTS_BOOKED', 'BOOKING_ID','BOOKIN_AMOUNT']%}

SELECT
{%for col in cols%}
    {{col}}
        {%if not loop.last%},{%endif%}
{%endfor%}
FROM{{ref('bronze_bookings')}}