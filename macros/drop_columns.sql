{% macro drop_columns(include_cols, exclude_cols, source_table='cte_source_table') %}

    {{ return(adapter.dispatch('drop_columns', 'rasgo_transforms')(source_table, include_cols, exclude_cols)) }}

{% endmacro %}


{% macro default__drop_columns(source_table, include_cols, exclude_cols) %}

    {% if include_cols and exclude_cols is defined %}
        {{ raise_exception('You cannot pass both an include_cols list and an exclude_cols list') }}
    
    {% else %}
        {%- if include_cols is defined -%}
            SELECT
            {%- for col in include_cols %}
                {{col}}{{ ", " if not loop.last else '' }}
            {%- endfor %}
            FROM {{source_table}}
        {%- endif -%}

        {%- if exclude_cols is defined -%}
            {%- set source_cols = adapter.get_columns_in_relation(source_table) -%}
            {{ source_cols }}
            {% set new_columns = [] %}
            {%- for col in source_cols -%}
                {% do new_columns.append(col.column) if col.column not in exclude_cols %}
            {%- endfor -%}

            SELECT
            {%- for col in new_columns %}
                {{ col }}{{ ", " if not loop.last else '' }}
            {%- endfor %}
            FROM {{ source_table }}
        {%- endif -%}
    {%- endif -%}

{% endmacro %}