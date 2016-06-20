import xmltodict

with open('scen12.plx') as fd:
    plan = xmltodict.parse(fd.read())

def recursive_print(node, indent=""):
    print indent, "*", node['@NodeType'], ": ", node['NodeId']
    if node['@NodeType'] == "NodeList":
        num_children = len(node['NodeBody']['NodeList']['Node'])
        if num_children > 0:
            for child_node in node['NodeBody']['NodeList']['Node']:
                recursive_print(child_node, indent + "  ")

recursive_print(plan['PlexilPlan']['Node'])


