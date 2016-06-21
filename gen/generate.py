import xmltodict

with open('scen12.plx') as fd:
    plan = xmltodict.parse(fd.read())

def print_plan(node, indent=""):
    epx = ""
    if "@epx" in node.keys():
        epx = node["@epx"]
        print indent, "*", node['@NodeType'], ":", node['NodeId'], "; epx:", epx
    else:
        print indent, "*", node['@NodeType'], ": ", node['NodeId']
    if "VariableDeclarations" in node.keys():
        variables = []
        if "DeclareVariable" in node["VariableDeclarations"].keys():
            variables = node["VariableDeclarations"]["DeclareVariable"]
        for variable in variables:
            variable_type = variable['Type']
            initial_value = "0"
            if "InitialValue" in variable.keys():
                initial_value = variable['InitialValue'][variable_type + 'Value']
            print indent, "  Variable -", variable['Name'], variable_type, initial_value
    if node['@NodeType'] == "NodeList":
        num_children = len(node['NodeBody']['NodeList']['Node'])
        if num_children > 0:
            for child_node in node['NodeBody']['NodeList']['Node']:
                print_plan(child_node, indent + "  ")

print_plan(plan['PlexilPlan']['Node'])


