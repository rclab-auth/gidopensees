# GiD + OpenSees Interface

*(c) 2016-2022*

*Lab of R/C and Masonry Structures, School of Civil Engineering, Aristotle University of Thessaloniki, Greece*

**Development team**

- T. Kartalis-Kaounis, Dipl. Eng. AUTh, MSc
- V.K. Papanikolaou, Dipl. Eng., MSc DIC, PhD, Asst. Prof. AUTh

**Project contributors**

- F. Derveni, Dipl. Eng. AUTh, PhD
- G. Ntinolazos, Dipl. Eng. AUTh
- T. Papadopoulos, Dipl. Eng. AUTh, MSc
- V. Protopapadakis, Dipl. Eng. AUTh, MSc
- T. Zachariadis, Dipl. Eng. AUTh, MSc

---

### KNOWN ISSUES

---
- In order to view the generated .tcl file ('Create and view .tcl only' menu option), first associate the .tcl extension with your favorite text editor (e.g. Notepad, Notepad++ etc.).
- OpenSees does not combine constraints (multiple 'fix' commands on the same node). As a result:
   - Intersection joints that belong to two lines with different constraints should be handled separately.
   - Intersection lines that belong to two surfaces with different constraints should be handled separately.
- The horizontal information bar stays in front of GiD material/condition windows when the respective menu options are used; please use the toolbar buttons instead. However, there's no way at the moment to hide the information bar behind the GiD Layer and Copy windows.

---

### VERSION HISTORY

---

**Version 2.9.0 (10/03/2022)**

- **Material driver** (developed by G. Ntinolazos, Dipl. Eng. AUTh)
- All-in-one installation (with latest OpenSees 3.3.0)
- Various fixes and improvements

---

**Version 2.8.5 (27/06/2021)**

- Added : 'Source' option in autoEDOF and autoZL
- Improved : .tcl import feature
- Various fixes and improvements

---

**Version 2.8.0 (03/07/2020)**

- Added : **User Material** for user material scripts (Data Menu -> Materials/Elements Definition)
- Added : **User Recorder** for user recorder scripts (Options)
- Added : **Layer Recorders** for individual LayeredShell layers (Options)
- Added : **Cracking output** in LayeredShell layers (available in OpenSees source after 30/6/2020)
- Improved : results postprocessor rewritten, supports results on individual LayeredShell layers
- Improved : .tcl import feature
- Improved : LayeredShell element definition
- Improved : option to enable 6DOFs for truss elements
- Various fixes and improvements

---

**Version 2.7.0 (17/01/2020)**

- Improved : .tcl import feature
- New feature : Auto ZeroLength options in ZeroLength condition window
- New feature : Auto EqualDOF options in EqualDOF condition window
- Added : Node displacements can be assigned on lines or surfaces
- Added : **PressureDependMultiYield02** nD Material
- Added : **Contact** nD Material
- Added : **BeamContact** element
- Improved : More options added on GiD+OpenSees menu
- Various improvements and GitHub issue fixes
- Updated User Manual

---

**Version 2.6.0 (03/07/2018)**

- Improved : Nonlinear static analysis solution scheme (load control, displacement control, cyclic displacement control)
- Improved : Information bar displays model state (not created, created, solved, ready to postprocess)
- Supporting the new HDF5 binary format for postprocess
- Added : Open .tcl model file toolbar button
- Minor improvements and bug fixes

---

**Version 2.5.5 (21/05/2018)**

- New feature (beta) : Import geometry from existing .tcl file
- Fixed bug in GiD local axes display when global Y is selected as vertical axis (thanks to tejeswar91 for feedback)

---

**Version 2.5.1 (31/03/2018)**

- Minor bug fixes

---

**Version 2.5.0 (25/02/2018)**

**Introducing the new GID+OpenSees Interface User Manual**

- Added : **Custom Fiber** Section. Any fiber section can be described using explicit TCL code inside the Interface. This code is kept into .tcl files inside /Scripts folder in the project directory and injected in the main .tcl file
- Added : **Record viewer** in Records window
- Added : **LayeredShell** section for RC walls
- Αdded : **Rigid Link** constraint type
- Added : **Elastic Section** force-deformation model
- Added : **ConcreteCM** uniaxial concrete material
- Added : **Ramberg-Osgood** uniaxial steel material
- Added : **BondSP01** uniaxial material
- Added : **MinMax** uniaxial material
- Added : **PySimple1** uniaxial material
- Added : **QzSimple1** uniaxial material
- Added : **TzSimple1** uniaxial material
- Added : **Macros toolbar** for constraint/zerolength IDs/directions, point masses and mesh divisions/sizes
- Added : **Performance and troubleshooting data** (*OpenSees/Analysis performance.out* and *OpenSees/Analysis problems.out*) are generated when **medium** logging level is selected in intervals
- Added : Tolerance relaxation option after failed substepping (in Interval Data)
- Added : Interval enable/disable option
- Added : Interval description field
- Improved : Global Rayleigh damping can be calculated using mode periods
- Improved : Alphanumeric IDs are supported for equal constraints, rigid links and diaphragms
- Minor bug fixes

---

**Version 2.2.5 (14/10/2017)**

- Added : **Auto equalDOF commands** among nodes with different ndf that share the same location in General Data window
- Added : **Auto equalDOF commands** among Quad/QuadUP element nodes which share the same vertical (Y) location.
- Added : **Function** Loading type option (Plain pattern - Path Timeseries)
- Added : **None** Loading type option (No Load pattern is used)
- Added : **KrylovNewton** algorithm
- Added : **set time** option in Intervals Data
- Added : **reset** option in Intervals Data
- Added : **Remove pattern** option in Intervals Data
- Added : **Fluid-pressure** option in Restraints conditions for QuadUP elements
- Improved : Transient analysis. In case of analysis divergence, in addition to alternative convergence criteria, time step bisection is tried
- Minor bug fixes

---

**Version 2.2.0 (01/09/2017)**

- Added : **Flexure-Shear Interaction Displacement-Based Beam-Column** element
- Added : **ShellDKGQ** element
- Added : **FiberInt** Section
- Added : **Viscous Damper** uniaxial material
- Added : **Hyperbolic Gap** uniaxial material
- Added : **Steel02** uniaxial material
- Added : **Bridge Deck** Fiber Section
- Added : **Dead** Loads for Frame, Truss and Shell elements
- Added : Hardening parameters for Steel01 uniaxial materials
- Added : Linear torsional stiffness for Fiber Section available as input
- Added : **Up to 3 optional directions** for Uniform ground motion excitation
- Improved : Pushover Analysis with Load Control. In case of analysis divergence, **substepping** and alternative convergence criteria are automatically applied
- Menu : User guide for DesignSafe-CI (by G.Papageorgiou and A.Tsetas)
- Menu : Automatic check for version update at startup
- Minor bug fixes

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

