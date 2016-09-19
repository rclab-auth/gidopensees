#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <string.h>
#include <stdlib.h>
#include <sstream>

using namespace std;
    ofstream ResFile;
    string word;
    string ElementType;
    int WordCounter,NumOfEigen;
    int Node1Word,Node2Word,NodeWord,ElemNumWord;
    string Node1,Node2,Node,ElemNum;
    string P,Mz,Vy,My,Vz,T;
    int Forces1Words[6],TrussAxialForceWord[6],Forces1Words2d[3],Forces2Words2d[3];
    int Forces2Words[6];
    string Forces1Values[6],TrussAxialForce[6];;
    string Forces2Values[6],Forces1Values2d[3],Forces2Values2d[3];
    int NodesDisplacementWord[6];
    string NodesDisplacement[6];
    int PlaneGaussPointsStressesWord[4][3];
    string PlaneGaussPointsStresses[4][3];
    string ModalDeform[3][13];
    int ModalDeformWords[3][13];
    int RunningBeamElement; // 1 for Elastic , 2 For Elastic Timoshenko



    string DoubleToString(double value) {

    ostringstream sstream;
    sstream << value;
    string Num = sstream.str();

    return Num;
    }



    double OppValue(string value) {

    double val = atof(value.c_str());

    val *= -1;

    return val;

    }



string removeCharsFromString( string &str, char* charsToRemove ) {
   for ( unsigned int i = 0; i < strlen(charsToRemove); ++i ) {
      str.erase( remove(str.begin(), str.end(), charsToRemove[i]), str.end() );
   }
   return str;
}
// example of usage:
// removeCharsFromString( str, "()-" );

void ReadElemForces2DFile(int x, string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemForces2d.out";

InFile.open (filepath.c_str());

    WordCounter =0;

    for (int i=0;i<3;i++) {
        Forces1Words2d[i]=0;
        Forces2Words2d[i]=0;
        TrussAxialForceWord[i]=0;
        TrussAxialForce[i]="0";
    }

if (InFile.is_open()) {

         while (InFile >> word) {
            WordCounter+=1;

           if (word=="ElasticBeam2d:") {

             ElemNumWord=WordCounter+1;
             Forces1Words2d[0]=WordCounter+19;
             Forces2Words2d[0]=Forces1Words2d[0]+9;

            for (int i=1;i<3;i++) {
                Forces1Words2d[i]=Forces1Words2d[i-1]+1;
                Forces2Words2d[i]=Forces2Words2d[i-1]+1;
            }


            } else if (word=="Element:") {
            ElemNumWord=WordCounter+1;

            } else if (word=="Truss") {
            TrussAxialForceWord[0]=WordCounter+15;
            } else if (word=="ElasticTimoshenkoBeam2d") {
            Forces1Words2d[0]=WordCounter+23;
            Forces2Words2d[0]=Forces1Words2d[0]+3;
              for (int i=1;i<3;i++) {
                Forces1Words2d[i]=Forces1Words2d[i-1]+1;
                Forces2Words2d[i]=Forces2Words2d[i-1]+1;
              }
            } else if (word=="CorotTruss,") {
            ElemNumWord=WordCounter+2;
            TrussAxialForceWord[0]=WordCounter+26;
            }

               if (WordCounter==ElemNumWord) {
                ElemNum=word;
            } else if (WordCounter==Forces1Words2d[0]) {
                Forces1Values2d[0]=DoubleToString(OppValue(word));

            } else if (WordCounter==Forces1Words2d[1]) {
                Forces1Values2d[1]=DoubleToString(OppValue(word));

            } else if (WordCounter==Forces1Words2d[2]) {
                Forces1Values2d[2]=DoubleToString(OppValue(word));

            } else if (WordCounter==Forces2Words2d[0]) {
                Forces2Values2d[0]=word;

            } else if (WordCounter==Forces2Words2d[1]) {
                Forces2Values2d[1]=word;

            } else if (WordCounter==Forces2Words2d[2]) {
                Forces2Values2d[2]=word;
                ResFile << ElemNum << " " << Forces1Values2d[x] << endl;
                ResFile << "  " << Forces2Values2d[x] << endl;
            } else if (WordCounter==TrussAxialForceWord[0]) {
                TrussAxialForce[0]=word;
                ResFile << ElemNum << " " << TrussAxialForce[x] << endl;
                ResFile << "  " << TrussAxialForce[x] << endl;
            }

}
InFile.close();
}
}


void ReadElemForcesFile(int x, string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemForces.out";

InFile.open (filepath.c_str());

    WordCounter =0;


    for (int i=0;i<6;i++) {
        Forces1Words[i]=0;
        Forces2Words[i]=0;
        TrussAxialForceWord[i]=0;
        TrussAxialForce[i]="0";
    }



    if (InFile.is_open()) {

         while (InFile >> word) {
            WordCounter+=1;

            if (word=="ElasticBeam3d:") {
            RunningBeamElement=1;
            ElemNumWord=WordCounter+1;
            Forces1Words[0]=WordCounter+22;
            Forces2Words[0]=Forces1Words[0]+15;

            for (int i=1;i<6;i++) {
                Forces1Words[i]=Forces1Words[i-1]+1;
                Forces2Words[i]=Forces2Words[i-1]+1;
            }

            } else if (word=="Element:") {
           // Node1Word=WordCounter+2;
           // Node2Word=Node1Word+2;
             ElemNumWord=WordCounter+1;


            } else if (word=="Truss") {
             TrussAxialForceWord[0]=WordCounter+15;

            } else if (word=="ElasticTimoshenkoBeam3d") {
             RunningBeamElement=2;
             Forces1Words[0]=WordCounter+29;
             Forces2Words[0]=Forces1Words[0]+6;
             Forces1Words[1]=Forces1Words[0]+4;
             Forces2Words[1]=Forces2Words[0]+4;
             Forces1Words[2]=Forces1Words[0]+2;
             Forces2Words[2]=Forces2Words[0]+2;
             Forces1Words[3]=Forces1Words[0]+5;
             Forces2Words[3]=Forces2Words[0]+5;
             Forces1Words[4]=Forces1Words[0]+1;
             Forces2Words[4]=Forces2Words[0]+1;
             Forces1Words[5]=Forces1Words[0]+3;
             Forces2Words[5]=Forces2Words[0]+3;
            } else if (word=="CorotTruss,") {
            ElemNumWord=WordCounter+2;
            TrussAxialForceWord[0]=WordCounter+26;
            }

            if (WordCounter==Forces1Words[0]) {
                Forces1Values[0]=DoubleToString(OppValue(word)); // Axial force P for Beam Column elems.

            } else if (WordCounter==Forces1Words[1]) {
                Forces1Values[1]=word;

            } else if (WordCounter==Forces1Words[2]) {
                Forces1Values[2]=word;

            } else if (WordCounter==Forces1Words[3]) {
                Forces1Values[3]=word;

            } else if (WordCounter==Forces1Words[4]) {
                Forces1Values[4]=word;   //shear z-z for ElasticBeamColumn elems

            } else if (WordCounter==Forces1Words[5]) {
                Forces1Values[5]=DoubleToString(OppValue(word));
              //  ResFile << Node1 << " " << Forces1Values[x] << endl;
            } else if (WordCounter==Forces2Words[0]) {
                Forces2Values[0]=word;   // Axial Force

            } else if (WordCounter==Forces2Words[1]) {
                Forces2Values[1]=DoubleToString(OppValue(word)); // Moment about local z

            } else if (WordCounter==Forces2Words[2]) {
                Forces2Values[2]=DoubleToString(OppValue(word));  // Shear y-y

            } else if (WordCounter==Forces2Words[3]) {
                Forces2Values[3]=DoubleToString(OppValue(word)); // Moment about local y
                if (RunningBeamElement==2) { // Timoshenko Beam Element
                    ResFile << ElemNum << " " << Forces1Values[x] << endl;
                    ResFile << "  " << Forces2Values[x] << endl;
                }


            } else if (WordCounter==Forces2Words[4]) {
                Forces2Values[4]=DoubleToString(OppValue(word));  // Shear z-z

            } else if (WordCounter==Forces2Words[5]) {
                Forces2Values[5]=word;      // Torsional Moment about local x
               if (RunningBeamElement==1) { // Elastic Beam Column

                ResFile << ElemNum << " " << Forces1Values[x] << endl;
                ResFile << "  " << Forces2Values[x] << endl;
               }

            } else if (WordCounter==TrussAxialForceWord[0]) {
                TrussAxialForce[0]=word;
                ResFile << ElemNum << " " << TrussAxialForce[x] << endl;
                ResFile << "  " << TrussAxialForce[x] << endl;

            } else if (WordCounter==Node1Word) {
                Node1=word;
            } else if (WordCounter==Node2Word) {
                Node2=word;
            } else if (WordCounter==ElemNumWord) {
                ElemNum=word;
            }

         }
InFile.close();
    }
}



void ReadPlaneGaussPointsStresses(string &ProjectDir) {
ifstream InFile;

    WordCounter =0;

    for (int i=0;i<4;i++) {
            for (int j=0;j<3;j++) {
        PlaneGaussPointsStressesWord[i][j]=0;
            }
    }

string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemStresses.out";

InFile.open (filepath.c_str());

if (InFile.is_open()) {

         while (InFile >> word) {
            WordCounter+=1;

            if (word=="FourNodeQuad,") {

                ElemNumWord=WordCounter+3;
                PlaneGaussPointsStressesWord[0][0]=WordCounter+37;
                PlaneGaussPointsStressesWord[1][0]=PlaneGaussPointsStressesWord[0][0]+6;
                PlaneGaussPointsStressesWord[2][0]=PlaneGaussPointsStressesWord[1][0]+6;
                PlaneGaussPointsStressesWord[3][0]=PlaneGaussPointsStressesWord[2][0]+6;

                for (int i=0;i<4;i++) {
                    for (int j=1;j<3;j++) {
                        PlaneGaussPointsStressesWord[i][j]=PlaneGaussPointsStressesWord[i][j-1]+1;
                    }
                }
            }

            if (WordCounter==ElemNumWord) {
                ElemNum=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][0]) {
                    PlaneGaussPointsStresses[0][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][1]) {
                    PlaneGaussPointsStresses[0][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][2]) {
                    PlaneGaussPointsStresses[0][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][0]) {
                    PlaneGaussPointsStresses[1][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][1]) {
                    PlaneGaussPointsStresses[1][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][2]) {
                    PlaneGaussPointsStresses[1][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][0]) {
                    PlaneGaussPointsStresses[2][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][1]) {
                    PlaneGaussPointsStresses[2][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][2]) {
                    PlaneGaussPointsStresses[2][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][0]) {
                    PlaneGaussPointsStresses[3][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][1]) {
                    PlaneGaussPointsStresses[3][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][2]) {
                    PlaneGaussPointsStresses[3][2]=word;
                    ResFile << ElemNum;
                    for (int i=0;i<4;i++) {
                        for (int j=0;j<3;j++) {
                            ResFile << " " << PlaneGaussPointsStresses[i][j];
                        }
                        ResFile << endl;

                    }
            }


         }
InFile.close();
}

WordCounter =0;

    for (int i=0;i<4;i++) {
            for (int j=0;j<3;j++) {
        PlaneGaussPointsStressesWord[i][j]=0;
            }
    }
filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemForces2d.out";

InFile.open (filepath.c_str());
if (InFile.is_open()) {
       while (InFile >> word) {
            WordCounter+=1;

            if (word=="FourNodeQuad,") {

                ElemNumWord=WordCounter+3;
                PlaneGaussPointsStressesWord[0][0]=WordCounter+37;
                PlaneGaussPointsStressesWord[1][0]=PlaneGaussPointsStressesWord[0][0]+6;
                PlaneGaussPointsStressesWord[2][0]=PlaneGaussPointsStressesWord[1][0]+6;
                PlaneGaussPointsStressesWord[3][0]=PlaneGaussPointsStressesWord[2][0]+6;

                for (int i=0;i<4;i++) {
                    for (int j=1;j<3;j++) {
                        PlaneGaussPointsStressesWord[i][j]=PlaneGaussPointsStressesWord[i][j-1]+1;
                    }
                }
            }

            if (WordCounter==ElemNumWord) {
                ElemNum=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][0]) {
                    PlaneGaussPointsStresses[0][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][1]) {
                    PlaneGaussPointsStresses[0][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[0][2]) {
                    PlaneGaussPointsStresses[0][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][0]) {
                    PlaneGaussPointsStresses[1][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][1]) {
                    PlaneGaussPointsStresses[1][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[1][2]) {
                    PlaneGaussPointsStresses[1][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][0]) {
                    PlaneGaussPointsStresses[2][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][1]) {
                    PlaneGaussPointsStresses[2][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[2][2]) {
                    PlaneGaussPointsStresses[2][2]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][0]) {
                    PlaneGaussPointsStresses[3][0]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][1]) {
                    PlaneGaussPointsStresses[3][1]=word;
            } else if (WordCounter==PlaneGaussPointsStressesWord[3][2]) {
                    PlaneGaussPointsStresses[3][2]=word;
                    ResFile << ElemNum;
                    for (int i=0;i<4;i++) {
                        for (int j=0;j<3;j++) {
                            ResFile << " " << PlaneGaussPointsStresses[i][j];
                        }
                        ResFile << endl;
                    }
            }
         }
InFile.close();
}
}

void ReadNodesDispFile(string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "NodesDisp3D.out";

WordCounter=0;

InFile.open(filepath.c_str());

if (InFile.is_open()) {

    while (InFile >> word) {
      WordCounter+=1;

      if (word=="Node:") {
        NodeWord=WordCounter+1;
        NodesDisplacementWord[0]=WordCounter+8;
        for (int i=1;i<6;i++) {
            NodesDisplacementWord[i]=NodesDisplacementWord[i-1]+1;
        }
      }

      if (WordCounter==NodesDisplacementWord[0]) {
            NodesDisplacement[0]=word;

      } else if (WordCounter==NodesDisplacementWord[1]) {
          NodesDisplacement[1]=word;

      } else if (WordCounter==NodesDisplacementWord[2]) {
          NodesDisplacement[2]=word;

      } else if (WordCounter==NodesDisplacementWord[3]) {
          NodesDisplacement[3]=word;

      } else if (WordCounter==NodesDisplacementWord[4]) {
          NodesDisplacement[4]=word;

      } else if (WordCounter==NodesDisplacementWord[5]) {
          NodesDisplacement[5]=word;
          ResFile << Node << " ";
          for (int i=0;i<3;i++) {
            ResFile << NodesDisplacement[i] << " ";
          }
          ResFile << endl;

      } else if (WordCounter==NodeWord) {
          Node=word;
      }

    }

InFile.close();
}

filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "NodesDisp2D.out";

InFile.open(filepath.c_str());

if (InFile.is_open()) {

    while (InFile >> word) {
      WordCounter+=1;

      if (word=="Node:") {
        NodeWord=WordCounter+1;
        NodesDisplacementWord[0]=WordCounter+7;
        NodesDisplacementWord[1]=NodesDisplacementWord[0]+1;

      }

      if (WordCounter==NodesDisplacementWord[0]) {
            NodesDisplacement[0]=word;

      } else if (WordCounter==NodesDisplacementWord[1]) {
          NodesDisplacement[1]=word;

          ResFile << Node << " ";
          for (int i=0;i<2;i++) {
            ResFile << NodesDisplacement[i] << " ";
          }
          ResFile << endl;
      } else if (WordCounter==NodeWord) {
          Node=word;
      }

    }

InFile.close();
}

}


void HowManyEigenValues(string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "NumOfEigenValues.out";

InFile.open(filepath.c_str());

if (InFile.is_open()) {

    while (InFile >> word) {

       NumOfEigen=OppValue(DoubleToString(OppValue(word)));

    }
} else {
NumOfEigen=0;
}

}




void ReadModalDeformation(int x, string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "NodesDisp3D.out";

if (NumOfEigen>=1 && NumOfEigen<=13) {

WordCounter=0;

InFile.open(filepath.c_str());

if (InFile.is_open()) {

    while (InFile >> word) {
        WordCounter+=1;

     if (word=="Node:") {

        NodeWord=WordCounter+1;

     } else if (word=="Eigenvectors:") {

        ModalDeformWords[0][0]=WordCounter+1;

        for (int i=1;i<=2;i++) {

            ModalDeformWords[i][0]=ModalDeformWords[i-1][0]+NumOfEigen;
        }

        if (NumOfEigen>=1) {
        for (int i=0;i<=2;i++)  {
        for (int j=1;j<=(NumOfEigen-1);j++) {

            ModalDeformWords[i][j]=ModalDeformWords[i][j-1]+1;

        }
        }
        }


        }

        for (int i=0;i<=2;i++) {
            for (int j=0;j<=(NumOfEigen-1);j++) {

                if (ModalDeformWords[i][j]==WordCounter) {

                    ModalDeform[i][j]=word;

                }

            }

        }

        if (WordCounter==NodeWord) {

            Node=word;
        } else if (WordCounter==ModalDeformWords[2][NumOfEigen-1]) {

        ResFile << Node << " ";

        for(int i=0;i<=2;i++) {
                ResFile << ModalDeform[i][x-1] << " ";
        }
        ResFile << "\n";
    }

}

InFile.close();
}

filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "NodesDisp2D.out";

InFile.open(filepath.c_str());

if (InFile.is_open()) {

    while (InFile >> word) {
        WordCounter+=1;

     if (word=="Node:") {

        NodeWord=WordCounter+1;

     } else if (word=="Eigenvectors:") {

        ModalDeformWords[0][0]=WordCounter+1;



        ModalDeformWords[1][0]=ModalDeformWords[0][0]+NumOfEigen;


        if (NumOfEigen>=1) {
        for (int i=0;i<=1;i++)  { //2-->1
        for (int j=1;j<=(NumOfEigen-1);j++) {

            ModalDeformWords[i][j]=ModalDeformWords[i][j-1]+1;

        }
        }
        }


        }

        for (int i=0;i<=1;i++) { //2->1
            for (int j=0;j<=(NumOfEigen-1);j++) {

                if (ModalDeformWords[i][j]==WordCounter) {

                    ModalDeform[i][j]=word;

                }

            }

        }

        if (WordCounter==NodeWord) {

            Node=word;
        } else if (WordCounter==ModalDeformWords[1][NumOfEigen-1]) {

        ResFile << Node << " ";

        for(int i=0;i<=1;i++) {
                ResFile << ModalDeform[i][x-1] << " ";
        }
        ResFile << "\n";
    }

}

InFile.close();
}
}
}



void WriteResultsForLines2D(string &ProjectDir) {

        ResFile << "GiD Post Results File 1.0 \n\n";

        ResFile << "GaussPoints \"Line_GP\" Elemtype Line\n";
        ResFile << "Number Of Gauss Points: 2\n";
        ResFile << "Nodes Included\n";
        ResFile << "Natural Coordinates: Internal\n";
        ResFile << "End GaussPoints\n\n";

        ResFile << "Result \"Axial Force\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kN\"\n\n";
        ResFile << "Values\n";
        ReadElemForces2DFile(0,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Shear Forces\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kN\"\n\n";
        ResFile << "Values\n";
        ReadElemForces2DFile(1,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Moments\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kNm\"\n\n";
        ResFile << "Values\n";
        ReadElemForces2DFile(2,ProjectDir);
        ResFile << "End Values\n\n";


        ResFile << "Result \"Deformation\" \"Static\" 1 Vector OnNodes\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"m\"\n\n";
        ResFile << "Values\n";
        ReadNodesDispFile(ProjectDir);
        ResFile << "End Values\n\n";



        if (NumOfEigen>=1) {

            for (int i=1;i<=NumOfEigen;i++) {

                ResFile << "Result \"mode" << i << "\" \"Modal Analysis\" 1 Vector OnNodes\n";
                ResFile << "ComponentNames \"X-Displacement\" \"Y-Displacement\" \n";
                ResFile << "Unit \" \" \n\n";
                ResFile << "Values\n";
                ReadModalDeformation(i,ProjectDir);
                ResFile << "End Values\n\n";
            }

        }


}

void WriteResultsForLines(string &ProjectDir) {

        ResFile << "GiD Post Results File 1.0 \n\n";

        ResFile << "GaussPoints \"Line_GP\" Elemtype Line\n";
        ResFile << "Number Of Gauss Points: 2\n";
        ResFile << "Nodes Included\n";
        ResFile << "Natural Coordinates: Internal\n";
        ResFile << "End GaussPoints\n\n";

        ResFile << "ResultRangesTable \"Moments\"\n";
        ResFile << "0 - 10: \"Too Less\"\n";
        ResFile << "10 - 50: \"Less\"\n";
        ResFile << "50 - 100: \"Normal\"\n";
        ResFile << "100 - 500: \"Much\"\n";
        ResFile << "500 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "ResultRangesTable \"Axial Forces\"\n";
        ResFile << "0 - 30: \"Too Less\"\n";
        ResFile << "30 - 50: \"Less\"\n";
        ResFile << "50 - 200: \"Normal\"\n";
        ResFile << "200 - 500: \"Much\"\n";
        ResFile << "500 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "ResultRangesTable \"Torsion\" \n";
        ResFile << "0 - 10: \"Less\"\n";
        ResFile << "10 - 50: \"Normal\"\n";
        ResFile << "50 - 100: \"Much\"\n";
        ResFile << "100 -  : \"Too Much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "ResultRangesTable \"Shear Forces\" \n";
        ResFile << "0 - 10: \"Too Less\"\n";
        ResFile << "10 - 40: \"Less\"\n";
        ResFile << "40 - 100: \"Normal\"\n";
        ResFile << "100 - 500: \"Much\"\n";
        ResFile << "500 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "ResultRangesTable \"Deformation\" \n";
        ResFile << "0 - 0.001: \"Too Less\"\n";
        ResFile << "0.001 - 0.003: \"Less\"\n";
        ResFile << "0.003 - 0.01: \"Normal\"\n";
        ResFile << "0.01 - 0.03: \"Much\"\n";
        ResFile << "0.03 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "Result \"Moment about local y axis\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Moments\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kNm\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(3,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Moment about local z axis\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Moments\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kNm\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(1,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Axial Force\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Axial Forces\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kN\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(0,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Shear Force y-y\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Shear Forces\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kN\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(2,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Shear Force z-z\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Shear Forces\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kN\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(4,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Torsion\" \"Static\" 1 Scalar OnGaussPoints \"Line_GP\" \n";
        ResFile << "ResultRangesTable \"Torsion\"\n";
        ResFile << "ComponentNames\n";
        ResFile << "Unit \"kNm\"\n\n";
        ResFile << "Values\n";
        ReadElemForcesFile(5,ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Deformation\" \"Static\" 1 Vector OnNodes\n";
        ResFile << "ResultRangesTable \"Deformation\" \n";
        ResFile << "ComponentNames \"X-Displacement\" \"Y-Displacement\" \"Z-Displacement\" \n"; // \"Z-Displacement\" \"X-Rotation\" \"Y-Rotation\" \"Z-Rotation\" \n";
        ResFile << "Unit \"m\"\n\n";
        ResFile << "Values\n";
        ReadNodesDispFile(ProjectDir);
        ResFile << "End Values\n\n";

        if (NumOfEigen>=1) {

            for (int i=1;i<=NumOfEigen;i++) {

                ResFile << "Result \"mode " << i << "\" \"Modal Analysis\" 1 Vector OnNodes\n";
                ResFile << "ComponentNames \"X-Displacement\" \"Y-Displacement\" \"Z-Displacement\" \n";
                ResFile << "Unit \" \" \n\n";
                ResFile << "Values\n";
                ReadModalDeformation(i,ProjectDir);
                ResFile << "End Values\n\n";
            }

        }

}


void WriteResultsForQuadrilateral2D(string &ProjectDir) {

        ResFile << "GiD Post Results File 1.0 \n\n";

        ResFile << "GaussPoints \"Quadrilateral_GP\" Elemtype Quadrilateral\n";
        ResFile << "Number Of Gauss Points: 4\n";
        ResFile << "Nodes not included\n";
        ResFile << "Natural Coordinates: Internal\n";
        ResFile << "End GaussPoints\n\n";

        ResFile << "ResultRangesTable \"Deformation\" \n";
        ResFile << "0 - 0.001: \"Too Less\"\n";
        ResFile << "0.001 - 0.003: \"Less\"\n";
        ResFile << "0.003 - 0.01: \"Normal\"\n";
        ResFile << "0.01 - 0.03: \"Much\"\n";
        ResFile << "0.03 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "ResultRangesTable \"Stresses\"\n";
        ResFile << "0 - 10: \"Too Less\"\n";
        ResFile << "10 - 50: \"Less\"\n";
        ResFile << "50 - 100: \"Normal\"\n";
        ResFile << "100 - 300: \"Much\"\n";
        ResFile << "300 - : \"Too much\"\n";
        ResFile << "End ResultRangesTable\n\n";

        ResFile << "Result \"Plane Stresses\" \"Static\" 1 Matrix OnGaussPoints \"Quadrilateral_GP\"  \n";
        ResFile << "ResultRangesTable \"Stresses\" \n";
        ResFile << "ComponentNames \"Stress xx\" \"Stress yy\" \"Stress xy\" \n";
        ResFile << "Unit \"KPa\"\n\n";
        ResFile << "Values\n";
        ReadPlaneGaussPointsStresses(ProjectDir);
        ResFile << "End Values\n\n";

        ResFile << "Result \"Deformation\" \"Static\" 1 Vector OnNodes\n";
        ResFile << "ResultRangesTable \"Deformation\" \n";
        ResFile << "ComponentNames \"X-Displacement\" \"Y-Displacement\"  \n"; // \"Z-Displacement\" \"X-Rotation\" \"Y-Rotation\" \"Z-Rotation\" \n";
        ResFile << "Unit \"m\"\n\n";
        ResFile << "Values\n";
        ReadNodesDispFile(ProjectDir);
        ResFile << "End Values\n\n";

}

void WriteResultsForBrick3D(string &ProjectDir) {


        ResFile << "GiD Post Results File 1.0 \n\n";

        ResFile << "Result \"Deformation\" \"Static\" 1 Vector OnNodes\n";
        ResFile << "ComponentNames \"X-Displacement\" \"Y-Displacement\" \"Z-Displacement\" \n"; //  \"X-Rotation\" \"Y-Rotation\" \"Z-Rotation\" \n";
        ResFile << "Unit \"m\"\n\n";
        ResFile << "Values\n";
        ReadNodesDispFile(ProjectDir);
        ResFile << "End Values\n\n";
}


void CheckElementType(string &ProjectDir) {
ifstream InFile;
string filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemForces.out";

InFile.open(filepath.c_str());

if (InFile.is_open()) {
    ElementType="Linear";
    InFile.close();
}

filepath = ProjectDir + '\\' + "OpenSees" + '\\' + "ElemForces2d.out";

InFile.open(filepath.c_str());

if(InFile.is_open()) {
    ElementType="Linear2d";
    InFile.close();
}

filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "ElemStresses.out";

InFile.open(filepath.c_str());

if(InFile.is_open()) {
    ElementType="Quadrilateral";
    InFile.close();
}

filepath= ProjectDir + '\\' + "OpenSees" + '\\' + "stdBrick_stress.out";

InFile.open(filepath.c_str());

if(InFile.is_open()) {
    ElementType="Hexahedra";
    InFile.close();
}

}

int main(int argc, char* argv[])
{

if (argc!=3) { return 0; }

//argv[0] = OpenSeesPost.exe path
// argv[1] = Project name
// argv[2] = Project Dir
string ProjectName=argv[1];
string ProjectDir=argv[2];

HowManyEigenValues(ProjectDir);
CheckElementType(ProjectDir);

   // ResFile.open ("OpenSees.post.res");

        string ResultFile= ProjectName + ".post.res";
        string ResultFilePath=ProjectDir + '\\' + ResultFile;

        ResFile.open(ResultFilePath.c_str());

    if (ResFile.is_open()) {

            if (ElementType=="Linear") {

            WriteResultsForLines(ProjectDir);
            } else if (ElementType=="Quadrilateral") {

            WriteResultsForQuadrilateral2D(ProjectDir);

            } else if (ElementType=="Hexahedra") {

            WriteResultsForBrick3D(ProjectDir);
            } else if (ElementType=="Linear2d") {
             WriteResultsForLines2D(ProjectDir);
            }

        }


 //ResFile << DoubleToString(OppValue("-50"));



ResFile.close();



    return 0;
}
