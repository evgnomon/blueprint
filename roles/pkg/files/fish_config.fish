{% for item in paths %}
set -xp PATH {{ item }}
{% endfor %}
