{% macro date_to_int(date) %}
    cast(to_char({{ date }}, 'YYYYMMDD') as integer)
{% endmacro %}
