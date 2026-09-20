{% set configs=[
    {
        "table" : "AIRBNB.SILVER.SILVER_BOOKINGS",
        "columns" : "bronze_bookings.*",
        "alias" : "bronze_bookings"
    },
    {
        "table" : "AIRBNB.SILVER.SILVER_LISTINGS",
        "columns" : "bronze_listings.HOST_ID, bronze_listings.PROPERTY_TYPE, bronze_listings.ROOM_TYPE, bronze_listings.CITY, bronze_listings.COUNTRY, bronze_listings.ACCOMMODATES, bronze_listings.BEDROOMS, bronze_listings.BATHROOMS, bronze_listings.PRICE_PER_NIGHT, bronze_listings.PRICE_PER_NIGHT_TAG, bronze_listings.CREATED_AT AS LISTINGS_CREATED_AT",
        "alias" : "bronze_listings",
        "join_condition" : "bronze_bookings.listing_id = bronze_listings.listing_id"
    },
    {
        "table" : "AIRBNB.SILVER.SILVER_HOSTS",
        "columns" : "bronze_hosts.HOST_NAME, bronze_hosts.HOST_SINCE, bronze_hosts.IS_SUPERHOST, bronze_hosts.RESPONSE_RATE, bronze_hosts.CREATED_AT AS HOST_CREATED_AS",
        "alias" : "bronze_hosts",
        "join_condition": "bronze_listings.host_id = bronze_hosts.host_id"
    }
]%}

SELECT
    {% for config in configs%}
        {{ config.columns }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM

    {% for config in configs %}

        {% if loop.first %}

            {{ config['table'] }} AS {{ config['alias'] }}

        {% else %}

            LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
            ON {{ config['join_condition'] }}

        {% endif %}

    {% endfor %}
