{% macro cleanse_name(name) %}
    {% set name = name | trim %}
    {% set name = name | replace(' ', '_') %}
    {% set name = name | replace('-', '_') %}
    {% set name = modules.re.sub('[^A-Z0-9_]+', '', name) %}
    {% if name[0]|int != 0 %}
        {% set name = '_' ~ name %}
    {% endif %}
    {{ return(name)}}
{% endmacro %}