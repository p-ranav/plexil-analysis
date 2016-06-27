__author__ = "Pranav Srinivas Kumar"
__license__ = "GPL"
__version__ = "1.0.1"
__maintainer__ = "Pranav Srinivas Kumar"
__email__ = "pkumar@isis.vanderbilt.edu"
__status__ = "Production"

import os, sys, inspect
import xmltodict
import argparse

working_dir = os.path.dirname(os.path.realpath(__file__))
template_dir = os.path.join(working_dir, "templates")
# Recursively compile on template files in templates directory
os.system("/usr/local/bin/cheetah compile " + template_dir + "/*.tmpl")
cfs_templates = os.path.realpath(os.path.abspath
                                 (os.path.join
                                  (os.path.split
                                   (inspect.getfile
                                    (inspect.currentframe()
                                 )
                                )[0], "templates")
                              ))
if cfs_templates not in sys.path:
    sys.path.insert(0, cfs_templates)

from cpn import *

class PlexilNode():
    def __init__(self, name, kind, guard_wcet, action_wcet, repeat):
        self.name = name
        self.kind = kind
        self.state = "WAITING"
        self.guard_wcet = guard_wcet
        self.action_wcet = action_wcet
        self.repeat = repeat

plexil_nodes = []

def parse_plan(node, indent=""):
    global plexil_nodes
    epx = ""
    guard_wcet = 0
    action_wcet = 0
    if "@epx" in node.keys():
        epx = node["@epx"]
    if "GuardWCET" in node.keys():
        guard_wcet = node["GuardWCET"]
    if "ActionWCET" in node.keys():
        action_wcet = node["ActionWCET"]

    if node['@NodeType'] == "NodeList":
        new_node = PlexilNode(node['NodeId'], node['@NodeType'], guard_wcet, action_wcet, "false")
        plexil_nodes.append(new_node)
        num_children = len(node['NodeBody']['NodeList']['Node'])
        if num_children > 0:
            for child_node in node['NodeBody']['NodeList']['Node']:
                parse_plan(child_node, indent + "  ")

def generate_cpn():
    node_token = "1`["
    for node in plexil_nodes:
        if node_token.endswith("}"):
            node_token += ",\n"
        node_token = node_token + "{name=\"" + node.name + "\", kind=\"" + node.kind + \
                     "\", state=\"WAITING\", parent=\"NULL\", guard_wcet=" + node.guard_wcet + \
                     ", action_wcet=" + node.action_wcet + ", repeat=" + node.repeat + \
                                      ", start_time=0, end_time=0}"
    node_token += "]"
    print node_token
    cpn_text = ""
    cpn_namespace = {'plexil_nodes' : node_token}
    t = cpn(searchList=[cpn_namespace])
    cpn_text = str(t)
    with open(os.path.join(working_dir, "Plexil-Analysis.cpn"), 'w') as temp_file:
        temp_file.write(cpn_text)

# {name="DriveToTarget", kind="List", state="WAITING", parent="NULL", guard_wcet=5, action_wcet=0, repeat=false, start_time=0, end_time=0}, 

def main():

    parser = argparse.ArgumentParser(description=\
                                     'functionality: Generate Plexil Analysis CPN', 
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--plx', nargs='?', default=None, help='Name of plx file to process')
    args = vars(parser.parse_args())

    if (args['plx'] != None):
        with open(args['plx'], 'r') as fd:
            plan = xmltodict.parse(fd.read())
            parse_plan(plan['PlexilPlan']['Node'])
            generate_cpn()
    else:
        print "Usage: python generate.py <.plx file>"

if __name__ == "__main__":
    main()

