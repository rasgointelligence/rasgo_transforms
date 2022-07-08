{% macro cte(operations) %}

    {%- if operations|length > 1 -%}
        WITH
        {%- for op in operations -%}
            {% set alias = 'OP' ~ loop.index %}
            {% set cte_source_table = 'OP' ~ (loop.index - 1) if not loop.first else '' %}
            {% set running_ops = running_ops or [] %}
            {% do running_ops.append(op) %}
            {% set running_sql = cte(running_ops) %}
            {# How do we get this into the template? It is already rendered at this point. Look at call function... #}
            {{alias}} AS ( {{ op | replace('cte_source_table', cte_source_table) }} ){{ ',' if not loop.last else ''}}
        {%- endfor %}
        SELECT * FROM {{ 'OP' ~ operations|length }}

    {%- else -%}
        operations
    {%- endif -%}

{% endmacro %}