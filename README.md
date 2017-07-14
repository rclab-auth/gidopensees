# GiD + OpenSees Interface

*(c) 2016-2017*

*Lab of R/C and Masonry Structures, School of Civil Engineering, Aristotle University of Thessaloniki, Greece*

**Development team**

- T. Kartalis-Kaounis, Civil Engineer AUTh
- V.K. Protopapadakis, Civil Engineer AUTh
- T. Papadopoulos, Civil Engineer AUTh

**Project coordinator**

V.K. Papanikolaou, Assistant Professor AUTh

---

### KNOWN ISSUES

---
- Due to the large number of new features, transforming older models to version 2.0.0 onwards may lead to some non-updated data (loads, boundary conditions, analysis options etc.). It is highly recommended to check your transformed model thorougly, before running it in the latest version.
- OpenSees does not combine constraints (multiple 'fix' commands on the same node). As a result:
   - Intersection joints that belong to two lines with different constraints should be handled seperately.
   - Intersection lines that belong to two surfaces with different constraints should be handled seperately.
- The horizontal information bar stays in front of GiD material/condition windows when the respective menu options are used; please use the toolbar buttons instead. However, there's no way at the moment to hide the information bar behind the GiD Layer and Copy windows.

---

### VERSION HISTORY

---

**Version 2.1.2 (14/07/2017)**

- Added : **Initial stress** material
- Added : **Initial strain** material
- Added : **Corotational** transformation
- Compatibility with latest GiD developer version
- Minor bug fixes

---

**Version 2.1.1 (16/06/2017)**

- Minor bug fix in multiple constraints

---

**Version 2.1.0 (15/06/2017)**

- Added : **Section aggregator** object
- Added : **Hysteretic material**
- Added : **Prescribed displacement** (SP) loading
- Added : **Tee** fiber section
- Added : User selection of output results
- Added : Option for output **frequency** (every n steps)
- Added : Option for **binary** output (smaller size, faster read)
- Minor bug fixes

---

**Version 2.0.0 (08/05/2017)**

- Now supported : **Multiple model domains** (defined automatically depending on element types)
- Now supported : **Transient Analysis**
- Now supported : **Uniform Ground Motion Excitation from record**
- Now supported : **Multiple Ground Motion Excitation from records**
- Now supported : **Sine Uniform Excitation**
- Now supported : **Multiple Sine Excitation**
- Now supported : More than one displacement peaks can be used for Static Cyclic Analysis
- Added : **Displacement-Based Beam Column** element
- Added : **Viscous** uniaxial material
- Added : **Parallel** uniaxial material
- Added : **Series** uniaxial material
- Added : **Records** dialog window
- Added : **Various analysis options** on GiD+OpenSees menu (for easily running and postprocessing user modified .tcl files)
- Added : On standard uniaxial materials and Steel01 uniaxial material dialogs, new formulations are added for using these materials on a ZeroLength element
- Added : Logging level option on interval data window
- Added : Node relative accelerations and velocities recorders supported in postprocess
- Added : Initial status for every interval is supported in postprocess
- Improved : Rigid Diaphragm condition is split into two conditions, for master and slave nodes, respectively. Rigid diaphragms are now defined on the geometry model
- Improved : Body constraint (equalDOF) condition is split into two conditions, for master and slave nodes, respectively. Body constraints are now defined on the geometry model
- Improved : Pushover Analysis. In case of analysis divergence, **substepping** and alternative convergence criteria are automatically applied
- Improved : Static Cyclic Analysis. In case of analysis divergence, alternative convergence criteria are automatically applied
- Various minor improvements and corrections

---

**Version 1.5.4 (10/01/2017)**

- Added : Concrete04 (Popovics concrete material)
- Added : Reinforcing steel material
- Added : NR with line search, Broyden & BFGS algorithms
- Added : R/C beam fiber section
- Added : Property modification factors for
	- Elastic beam-column elements
	- Elastic Timoshenko beam-column elements
	- Truss elements
- Suggest fiber mesh option
- Local axis info updated
- Minor bug fixes

---

**Version 1.5.3 (14/11/2016)**

- Now supported : **Damage2p** material (von Mises yield and isotropic hardening)
- Now supported : **J2Plasticity** material (Drucker-Prager plasticity + two-parameter damage)
- Now supported : **PressureIndependMultiYield (PIMY)** material for geotechnical problems
- Now supported : **PressureDependMultiYield (PDMY)** material for geotechnical problems
- Now supported : **QuadUP elements** for geotechnical problems
- Now supported : **Series and Parallel uniaxial materials**
- ZeroLength element dialog updated to include series/parallel materials
- Added links to OpenSees wiki for all material/condition dialogs
- Many other minor improvements

---

**Version 1.5.2 (02/11/2016)**

- Frame element **local axes** visualization in GiD postprocessor
- Added more convergence criteria for NR and mNR algorithms
- Added Rayleigh damping
- Added detailed local axis information for frame elements at the end of model file (.tcl)
- Condition symbols (.geo) updated

---

**Version 1.5.1 (31/10/2016)**

- Modified Newton-Raphson algorithm added
- Interval data updated
- Step/iteration output during analysis

---

**Version 1.5.0  (30/10/2016)**

- Now supported : **Force-Based Beam-Column**
- Now supported : **Tri31 Element**
- Now supported : **Fiber Section**
- Now supported : **Pushover and Cyclic analysis**
- Fully themed (classic and black)
- New information bar
- Toolbar : Show/hide line local axes
- Toolbar : Interval data
- Toolbar : Show/hide elements and conditions
- Toolbar : Select active interval
- ZeroLength element form updated
- Prompt for model transform when needed
- OpenSeesPost.exe rewritten
- Output data file (.tcl) format improved
- OpenSeesSP and OpenSeesMP supported on installation
- Error message windows for unsuccessful analysis
- Minor bug fixes

---

**Version 1.3.4 (19/09/2016)**

- Meta.bas created
- Node counter added in node.bas
- Elements counters added
- proc TK_CheckModelingOptionsForShellElems was created in tkWidgets.tcl
- TKWIDGET for shell elements added in OpenSees.mat
- Check Element type (in mesh) for Quad, Shell and Brick Elements. If invalid suitable error message is displayed.

---

**Version 1.3.3 (13/09/2016)**

- OpenSees.exe was removed from installation
- Existing OpenSees.exe location is now asked during installation (recommended is C:\OpenSees\OpenSees.exe)

---

**Version 1.3.2 (12/09/2016)**

- Recorders added for every element type
- Dependency about Vertical axis in OpenSees.prb removed

---

**Version 1.3.1 (10/09/2016)**

- Recorders added for shell and quad elements
- Question field names updated in problem data menu
- OpenSees.bat updated: moves more files in OpenSees folder in Project Directory
- OpenSees menu changed to "GiD+OpenSees"
- GiD+OpenSees menu choice added: View version history

---

**Version 1.3.0 (09/09/2016)**

- Brick element recorder commands updated
- Splash icon updated
- btn_About.png updated
- Concrete06C.png updated
- mnu_Site.png added
- OpenSees menu "Visit GiD+OpenSees menu" option added
- OpenSees menu "Create and view .tcl file only" added

---

**Version 1.2.9**

- tcl file format improved

---

**Version 1.2.8**

- OpenSees menu icons added: 4 new icons
- Section icon added on toolbar

---

**Version 1.2.7**

- GiD+OpenSees menu updated:
   - Calculation
   - Create .tcl only
   - Visit OpenSees wiki
   - About

---

**Version 1.2.6**

- Batch file deletes previous OpenSees folder in project directory
- Restraints.bas updated
- RestNodes.tcl deleted
- Toolbars updated and Section F-D button added

---

**Version 1.2.5**

- Error Messages added for Beam Column elements in case of wrong modeling options
- Geometric transformations are printed once now, even you have both Elastic Beam column and Timoshenko beam elements

---

**Version 1.2.4**

- Print Format updated for nodes and brick elements
- OpenSees.exe updated to version 2.5.0
- Comments for local axes updated in Line_uniform_loads condition
- tkWidget added for modeling options about Dimensions and DOFs. Dependencies deleted.
- OpenSees.bat updated: Displays DOS window while OpenSees.exe is running
- Comments added in Restraints Conditions

---

**Version 1.2.3**

- Conditions Line_Restraints/Surface_Restraints added (transferred to the nodes of the geometric entity)
- Condition Line_Body_Constraint added
- Second toolbar added
- Condition Line_Loads added
- Symbols added to these additional Loads and restraints conditions

---

**Version 1.2.2**

- Icons updated

---

**Version 1.2.1**

- Elastic Timoshenko Beam elements postprocess results for 2D and 3D models supported
- Corotational Truss elements postprocess results for 2D and 3D models supported
- Rigid diaphragm bug fixed
- Modal analysis bug fixed: It works for more than 3 modes now (<=12)
- Shell + Beam-Column Models: Deformation in post process is supported plus MQN for Beam-Column elements
- Brick elements can be assigned only in volumes

---

**Version 1.2.0**

- Zero length elements updated: You can assign this condition on more than 2 nodes and command is printed per 2 nodes.
- Truss postprocess results in 2D model are supported
- Wrong calculations about beam column element properties fixed

---

**Version 1.1.9**

- Modal analysis supported in postprocessing for 2D models
- Bug fixed: Body constraints now work in 2D models
- Concrete/steel categories added in elastic isotropic/orthotropic materials

---

**Version 1.1.8**

- Corotational Truss Element supported

---

**Version 1.1.7**

- Timoshenko Elastic Beam elements supported

---

**Version 1.1.6**

- Shell elements supported

---

**Version 1.1.5**

- Rigid diaphragm fixed

---

**Version 1.1.4**

- Modal analysis is supported in postprocessing for 3D models

---

**Version 1.1.3**

- ZeroLength Elemenets supported

---

**Version 1.1.2**

- 2D / 3DOF supported for Beam-Column problems
- Requirements was addeed for Truss and Beam-Column Elements in general tab
- TkWidget added for Elastic Beam-Column elements

---

**Version 1.1.1**

- Mass density supported for Truss and Beam-Column elements

---

**Version 1.1.0**

- Sections Force-Deformation Platefibre and ElasticMembranePlate added
- You can use any elastic isotropic material for Elastic Beam-Column elements not only the template one

---

**Version 1.0.9**

- Brick elemens window added
- Modeling options bug fixed
- Quad and shell windows updated
- Eigen analysis supported

---

**Version 1.0.6**

- Post Processing results for Truss and Elastic Beam-Column elements
- Quad/shell elements properties added

---

**Version 1.0.5**

- Local axes added:
   - Vertical axis: Z axis
   - Vertical elements: Vecxz=(0,0,1)
   - Non-vertical elements: vecxz=(-1,0,0)

---

**Version 1.0.0**

- Initial release

