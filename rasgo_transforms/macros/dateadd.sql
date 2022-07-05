{% macro dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {{ return(adapter.dispatch('dateadd', 'rasgo_transforms')(source_table, date_part, date, offset, alias, overwrite_columns)) }}

{% endmacro %}


{% macro default__dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {%- if overwrite_columns -%}
    {%- set alias = date -%}
    {%- set untouched_cols = get_columns(source_table)|list|reject('in', [alias])|join(',') -%}
    {%- else -%}
    {%- set untouched_cols = "*" -%}
    {%- endif -%}

    {%- set alias = alias if alias is defined else date + '_add' + offset|string + date_part -%}

    SELECT {{ untouched_cols }},
      {{ date }} + INTERVAL {{ offset }} {{ date_part }} AS {{ cleanse_name(alias) }}
    FROM {{ source_table }}

{% endmacro %}


{% macro bigquery__dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {%- if overwrite_columns -%}
    {%- set alias = date -%}
    {%- set untouched_cols = get_columns(source_table)|list|reject('in', [alias])|join(',') -%}
    {%- else -%}
    {%- set untouched_cols = "*" -%}
    {%- endif -%}

    {%- set alias = alias if alias is defined else date + '_add' + offset|string + date_part -%}

    SELECT {{ untouched_cols }},
      DATE_ADD({{ date }}, INTERVAL {{ offset }} {{ date_part }}) AS {{ cleanse_name(alias) }}
    FROM {{ source_table }}

{% endmacro %}


{% macro postgres__dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {%- if overwrite_columns -%}
    {%- set alias = date -%}
    {%- set untouched_cols = get_columns(source_table)|list|reject('in', [alias])|join(',') -%}
    {%- else -%}
    {%- set untouched_cols = "*" -%}
    {%- endif -%}

    {%- set alias = alias if alias is defined else date + '_add' + offset|string + date_part -%}

    SELECT {{ untouched_cols }},
      {{ date }} + INTERVAL '{{ offset }} {{ date_part }}' AS {{ cleanse_name(alias) }}
    FROM {{ source_table }}

{% endmacro %}


{% macro redshift__dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {%- if overwrite_columns -%}
    {%- set alias = date -%}
    {%- set untouched_cols = get_columns(source_table)|list|reject('in', [alias])|join(',') -%}
    {%- else -%}
    {%- set untouched_cols = "*" -%}
    {%- endif -%}

    {%- set alias = alias if alias is defined else date + '_add' + offset|string + date_part -%}

    SELECT {{ untouched_cols }},
      {{ date }} + INTERVAL '{{ offset }} {{ date_part }}' AS {{ cleanse_name(alias) }}
    FROM {{ source_table }}

{% endmacro %}


{% macro snowflake__dateadd(source_table, date_part, date, offset, alias, overwrite_columns)%}

    {%- if overwrite_columns -%}
    {%- set alias = date -%}
    {%- set untouched_cols = get_columns(source_table)|list|reject('in', [alias])|join(',') -%}
    {%- else -%}
    {%- set untouched_cols = "*" -%}
    {%- endif -%}

    {%- set alias = alias if alias is defined else date + '_add' + offset|string + date_part -%}

    SELECT {{ untouched_cols }},
      DATEADD({{ date_part }}, {{ offset }}, {{ date }}) AS {{ cleanse_name(alias) }}
    FROM {{ source_table }}

{% endmacro %}