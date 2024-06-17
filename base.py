import sys
import functools
from diagrams import Diagram

graph_attr = {
    "splines": "spline",
    "margin": "-1.8 -1.8",
}
filename = sys.argv[0].rsplit("/")[-1] + ".diag"
Diagram = functools.partial(Diagram, filename=filename,  graph_attr=graph_attr, show=False)

