import FreeCAD
import ImportGui
import Mesh
import sys

step_path = sys.argv[1]
glb_path = sys.argv[2]

doc = FreeCAD.newDocument()
ImportGui.insert(step_path, doc.Name)
Mesh.export([obj for obj in doc.Objects], glb_path)