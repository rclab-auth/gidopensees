import filecmp
import os
import unittest


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
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
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
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Plane_Frame_Pushover_Analysis(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Plane Frame - Pushover Analysis",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Plane Frame - Pushover Analysis",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Plane_Frame_on_Elastic_Soil_Pushover_Analysis(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Plane Frame on Elastic Soil - Pushover Analysis",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Plane Frame on Elastic Soil - Pushover Analysis",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Masonry_Arch(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Masonry Arch",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Masonry Arch",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Masonry_Arch_on_Soil(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Masonry Arch on Soil",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Masonry Arch on Soil",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

    def test_Plane_Truss(self):
        current_directory = os.path.dirname(os.path.abspath(__file__))
        python_outputs = os.path.join(current_directory, "datasets", "Plane Truss",
                                      "Python outputs")
        tcl_outputs = os.path.join(current_directory, "datasets", "Plane Truss",
                                   "Tcl outputs")
        d = filecmp.dircmp(python_outputs, tcl_outputs)
        for common_file in d.common_files:
            py_file = f"{python_outputs}/{common_file}"
            tcl_file = f"{tcl_outputs}/{common_file}"
            print(f"{common_file}: {filecmp.cmp(py_file, tcl_file)}")
        self.assertTrue(filecmp.cmp(py_file, tcl_file))

if __name__ == '__main__':
    unittest.main()
