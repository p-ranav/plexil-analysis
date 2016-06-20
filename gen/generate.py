import xmltodict
import pprint

class PlexilNode():
    def __init__(self, node_type, node_id):
        self.node_type = node_type
        self.node_id = node_id
        self.children = []

plan = None
pp = pprint.PrettyPrinter(indent=4)

with open('scen12.plx') as fd:
    plan = xmltodict.parse(fd.read())

root = plan['PlexilPlan']['Node']
if root['@NodeType'] == "NodeList":
    print "Found Root Node!"
    print "NodeType:", root['@NodeType']
    print "Node ID:", root['NodeId']
    root_node = PlexilNode(root['@NodeType'], 
                           root['NodeId'])
    root_node_body = root['NodeBody']
    root_children = root_node_body['NodeList']
    recursion_start_node = 
'''
    for child in root_children:
        child_node = PlexilNode(child['@NodeType'],
                                child['NodeId'])
        root_node.children.append(child_node)
'''
