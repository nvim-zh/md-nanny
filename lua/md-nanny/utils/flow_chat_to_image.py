#!/usr/bin/python3
import pydot
import sys


def dot_to_image(dot_text, name):
    (graph,) = pydot.graph_from_dot_data(dot_text)
    graph.write_png(name)


if __name__ == "__main__":
    #    dot_string = """graph my_graph {
    #    bgcolor="yellow";
    #    a [label="Foo"];
    #    b [shape=circle];
    #    a -- b -- c [color=blue];
    # }"""
    argv = sys.argv
    if len(argv) > 2:
        dot_to_image(argv[1], argv[2])
