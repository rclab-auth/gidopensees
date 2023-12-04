import filecmp
import os
import unittest

import pytest


class FileComparison(unittest.TestCase):

    def test_Masonry_Structure_with_Concrete_Slab(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Masonry Structure with Concrete Slab",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Masonry Structure with Concrete Slab",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(filecmp.cmp(py_file, tcl_file))
            print(common_file)

        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Plane_Frame_Static_and_Modal_Analysis(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Plane Frame - Static and Modal Analysis",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Plane Frame - Static and Modal Analysis",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(filecmp.cmp(py_file, tcl_file))
            print(common_file)

        self.assertTrue(filecmp.cmp(py_file, tcl_file))


if __name__ == '__main__':
    pytest.main([__file__])
