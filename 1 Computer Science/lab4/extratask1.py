import yaml
import json
def json_to_yaml_with_lib():
    with open('schedule.json', 'r', encoding='utf-8') as json_file:
        data = json.load(json_file)
        with open('extratask1_output.yml', 'w', encoding='utf-8') as yaml_file:
            yaml.dump(data, yaml_file, allow_unicode=True, default_flow_style=False, sort_keys=False)
json_to_yaml_with_lib()
