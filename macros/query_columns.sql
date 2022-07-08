{% macro query_columns(source_table) %}

    {% if caller() is defined and caller()|length %}
        {% set relation %}{{ caller() }}{% endset %}
    {% elif source_table is defined and source_table|length %}
        {% set relation %}{{ source_table }}{% endset %}
    {% endif %}

    {% if relation %}
        {%- set source_cols = adapter.get_columns_in_relation(relation) -%}
        {%- for col in source_cols -%}
            {{ col.column }}{{ ", " if not loop.last else '' }}
        {%- endfor -%}
    {% else %}
        Must pass source_table argument or call this function using call query_columns
    {% endif %}

{% endmacro %}