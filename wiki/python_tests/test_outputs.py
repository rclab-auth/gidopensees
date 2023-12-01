import unittest
import os

def compare_files(fileTcl, filePython):
    with open(fileTcl, 'r') as f1, open(filePython, 'r') as f2:
        tcl_ouput = f1.read()
        python_output = f2.read()
        return tcl_ouput == python_output
    
class FileComparison(unittest.TestCase):
    current_directory = os.path.dirname(os.path.abspath(__file__).parent)
    def test_Masonry_Structure_with_Concrete_Slab(self):
        python_outputs = os.path.join(FileComparison.current_directory,"/datasets/Masonry Structure")


if __name__ == '__main__':
    unittest.main()