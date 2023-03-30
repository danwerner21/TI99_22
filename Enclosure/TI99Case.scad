

/* [Box dimensions] */
  Length        = 320;       
  Width         = 380;                     
  TopHeight        = 10;  
  BottomHeight     = 21;  
  SlopeHeight      = 20;
  BackShelf     =170;
  Thick         = 3;//[2:5]  


  
/* [Box options] */
  PCBFeet       = 1;// [0:No, 1:Yes]
  Vent          = 1;// [0:No, 1:Yes]
  Vent_width    = 1.5;   



  Filet         = 9;//[0.1:12] 
  Resolution    = 50;//[1:100] 
  m             = 0.9;
  
/* [PCB_Feet--the_board_will_not_be_exported) ] */
PCBPosX         = 0;
PCBPosY         = 0;
PCBLength       = 142;
PCBWidth        = 360;
FootHeight      = 5;
FootDia         = 10;
FootHole        = 5;  /* 4.4 for melt in 5 for glue in */
  

/* [STL element to export] */
//Top shell
  TShell        = 1;// [0:No, 1:Yes]
//Bottom shell
  BShell        = 0;// [0:No, 1:Yes]
// Show PCBs
  ShowPCB       = 0;// [0:No, 1:Yes]
  
/* [Hidden] */
Couleur1        = "Orange";       
Couleur2        = "OrangeRed";    
Dec_Thick       = Vent ? Thick*2 : Thick; 
Dec_size        = Vent ? Thick*2 : 0.8;

PCBL=PCBLength;
PCBW=PCBWidth;



   
module SlopeRoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;     
                         
                        translate([Filet,-Filet/2,Filet])
                        {  
                    minkowski ()
                    {  
              
                    translate([0,($b/2)+1,TopHeight])
                       rotate(a=[0,-90,90])
                          linear_extrude(height =(($b/2)-Filet/2)+1, center = false, convexity = 0, twist = 0)
                              polygon(points=[[0,0],[(SlopeHeight+TopHeight)*-1,0],[(SlopeHeight+TopHeight)*-1,BackShelf*-1],  [TopHeight*-1,($a-Filet*2)*-1],[0,($a-Filet*2)*-1]], paths=[[3,2,1,0]]);                      
                        
                     rotate([270,0,0]){    
                        cylinder(r=Filet,h=Width/2+1, center = false);
                            } 
                        }
                    }
                }// End of SlopeRoundBox Module                


module RoundBox($a=Length, $b=Width, $c=TopHeight+BottomHeight){
                    $fn=Resolution;            
                    translate([0,Filet,Filet]){  
                    minkowski (){                                              
                        cube ([$a-(Length/2),$b-(2*Filet),$c-(2*Filet)], center = false);
                        rotate([0,90,0]){   
                           translate([0,0,Filet]){  
                        cylinder(r=Filet,h=Length/2-(2*Filet), center = false);}
                            } 
                        rotate([270,0,0]){    
                        cylinder(r=Filet,h=.1, center = false);
                            } 
                        }
                    }
                }// End of RoundBox Module

      


module TopShell(){
    Thick = Thick*2;  
    difference(){    
        difference(){
            union(){    
                     difference() {
                      
                        difference(){
                            union() {                                
                                        KeyboardCutoutReinforcement();

                            difference(){
                                SlopeRoundBox();
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        SlopeRoundBox($a=Length-Thick*2, $b=Width-Thick*2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }
                                    }
                               translate([-Thick,-Thick,TopHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                      }
                                }                                          
                // These are the tabs that attach the top to the bottom
                difference(){
                    union(){
                        
                        // four sides
                        translate([3*Thick +5,Thick,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                       translate([Length-((3*Thick)+5),Thick,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }

                    translate([3*Thick +5,Width-Thick/2-2.4,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                       translate([Length-((3*Thick)+5),Width-Thick/2-2.4,TopHeight]){
                            rotate([90,0,0]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }

                        // front and back
                       translate([Length-Thick-0.5,(Width/2)-Thick/2-2.4,TopHeight]){
                            rotate([90,0,90]){
                                    $fn=6;
                                    cylinder(d=16,Thick/2);
                                    }   
                            }
                            
                        }




                            
                    } 
                    
                    
            }

       }


///Put Difference Keyboard Cutout Here

            union(){ //sides holes
                $fn=50;
                translate([3*Thick+5,20,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),20,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([3*Thick+5,Width+5,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),Width+5,TopHeight+4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                
                
                translate([Thick/2,(Width/2)-Thick/2-2.4,TopHeight+4]){
                    rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-Thick-0.5,(Width/2)-Thick/2-2.4,TopHeight+4]){
                    rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
                
            }



         // Power Switch Opening    
            translate([45,Thick-10,Thick-13]){
              cube([20,13,13]);
            }   


         // Reset Switch Opening    
            translate([85,(Thick),Thick-7]){
             rotate([90,0,0])
                    cylinder(d=7,20);
            }   


        // Power Jack Opening    
            translate([-1,(Thick)+355,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=11,20);
            }
                
       
        // Audio and Video RCA Jack Openings    
            translate([-1,(Thick)+305,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=7,20);
            }   
             translate([-1,(Thick)+325,Thick-7]){
             rotate([0,90,0])
                    cylinder(d=7,20);
            }   



        KeyboardCutout();

        }//fin de difference holes
        KeyboardFeet();
        
   // Reset Switch Opening    
          //  translate([85,(Thick),Thick-7]){
           //  rotate([90,0,0])
             //       cylinder(d=7,20);
            //}   
        
        

}





module BottomShell(){
    Thick = Thick*2;  
    translate([0,2,0]){
    
    difference(){    
        difference(){
            //Main Box
            union(){    
                     difference() {
                      
                        difference(){
                            union() {
                            difference(){
                                RoundBox($a=Length, $b=Width-2, $c=TopHeight+BottomHeight);
                                translate([Thick/2,Thick/2,Thick/2]){     
                                        RoundBox($a=Length-Thick, $b=Width-Thick-2, $c=TopHeight+BottomHeight-Thick);
                                        }
                                        }

                                    }
                               translate([-Thick,-Thick,BottomHeight]){
                                   cube ([Length+100, Width+100, TopHeight+BottomHeight], center=false);
                                            }                                            
                                      }
                                }                                          


              
            }

       
            // vent holes
            union(){           
            for(i=[0:Thick:Length/4]){
                    translate([10+i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/2]);
                    }
                    translate([(Length-10) - i,-Dec_Thick+Dec_size,1]){
                    cube([Vent_width,Dec_Thick,BottomHeight/2]);
                    }
               
                  }
                }
                
        
            // Joystick Opening    
            translate([108,-2,Thick]){    
              cube([40,Dec_Thick+2,BottomHeight-5]);
            }
           

            // Cassette Opening    
            translate([-28,50,Thick]){    
              cube([40,30,BottomHeight-5]);
            }    

            //  Expansion Opening    
            translate([-28,285,Thick]){    
              cube([40,80,BottomHeight-5]);
            }  
        
            
            // Glamour Line        
            translate([Length-1,0,BottomHeight-1.25]){
             cube([20,Width,20]);
                }               
            translate([0,0,BottomHeight-1.25]){
             cube([1,Width,20]);
                }
             translate([0,0,BottomHeight-1.25]){    
              cube([Length,1,5]);
            }  
             translate([0,Width-3,BottomHeight-1.25]){    
              cube([Length,20,5]);
            }  
           
                
            }//fin difference decoration


            union(){ //sides holes
                $fn=50;
                translate([3*Thick+5,20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),20,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([3*Thick+5,Width+5,BottomHeight-4]){
                    rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                translate([Length-((3*Thick)+5),Width+5,BottomHeight-4]){
                   rotate([90,0,0]){
                    cylinder(d=2,20);
                    }
                }
                
               // front and back
               translate([Length-Thick-0.5,(Width/2)-Thick/2+2.4,BottomHeight-4]){
                 rotate([90,0,90]){
                    cylinder(d=2,20);
                    }
                }
            

            }
        }
        }
}



module thinFoot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=(FootDia),FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia)/1.75,0,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole/2,FootHeight+1, $fn=100);
               }          
}

module foot(FootDia,FootHole,FootHeight){
    Filet=2;
    color("Orange")   
    translate([0,0,Filet-1.5])
    difference(){
    
    difference(){
            //translate ([0,0,-Thick]){
                cylinder(d=FootDia+Filet,FootHeight-Thick, $fn=100);
                        //}
                    rotate_extrude($fn=100){
                            translate([(FootDia+Filet*2)/2,Filet,0]){
                                    minkowski(){
                                            square(10);
                                            circle(Filet, $fn=100);
                                        }
                                 }
                           }
                   }
            cylinder(d=FootHole,FootHeight+1, $fn=100);
               }          
}

module KeyboardCutout()
{
      color("OrangeRed"){
        translate([BackShelf+40,Width-20,-16])
          {
           rotate(a=[8,0,270])
           { 
               linear_extrude(height =15, center = false, convexity = 0, twist = 0)              
                                polygon(points=[[20,3],[234,3],[234,23],[243,23],[243,40],[270,40],[270,83],[218,83],[218,100],
                                                [50,100],[50,83],[1,83],[1,40],[28,40],[28,25],[20,25],[20,3]]
               , paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]);                             
           }
                            

               //LED OPENING
                 rotate(a=[8,0,270])
                            linear_extrude(height =12, center = false, convexity = 0, twist = 0)              
                                polygon(points=[[7,-50],[17.1,-50],[17.1,-52.1],[7,-52.1]], paths=[[0,1,2,3]]);  
          }              
        }
    }

module KeyboardCutoutReinforcement()
{
    
      color("Green")
        translate([BackShelf+40,Width-20,-14])
          {
                       rotate(a=[8,0,270])
           { 
               
               linear_extrude(height =5, center = false, convexity = 0, twist = 0)  
                                polygon(points=[[18,1],[236,1],[236,21],[245,21],[245,37],[272,37],[272,85],[220,85],[220,102],
                                                [48,102],[48,85],[-2,85],[-2,38],[26,38],[26,27],[18,27],[18,1]]
               , paths=[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]]); 
       }              
     }
    }


module KeyboardFeet()
{
     color("OrangeRed"){         
        translate([BackShelf+40,Width-20,-15])
          {
                       rotate(a=[8,0,270])
           { 
               // top row
               translate([.8,-2,Thick/2]){foot(FootDia,FootHole,FootHeight+8);}
               translate([159.9,-2,Thick/2]){foot(FootDia,FootHole,FootHeight+8);}
               translate([270.5,-2,Thick/2]){foot(FootDia,FootHole,FootHeight+8);}
               
               //bottom row
               
               translate([270.5,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               translate([.8   ,90.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               translate([227.8,91.5,Thick/2]){foot(FootDia,FootHole,FootHeight+9);}
               }
               
               
            }  
            translate([20,4.7,-18]) cube([3,Width-(Thick*2)-1.2,5]);            
            translate([100,4.7,-18]) cube([3,Width-(Thick*2)-1.2,5]);            
            translate([180,4.7,-18]) cube([3,Width-(Thick*2)-1.2,5]);            
            
            translate([4.7,20,-18]) cube([BackShelf+8,5,5]);            
            translate([4.7,100,-18]) cube([BackShelf+8,5,5]);            
            translate([4.7,200,-18]) cube([BackShelf+8,5,5]);            
            translate([4.7,300,-18]) cube([BackShelf+8,5,5]);            
            translate([4.7,355,-18]) cube([BackShelf+8,5,5]);            
        }
    }

module BottomFeet(){     

//top 
    translate([34.3,354.5,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
    translate([34.3,295.4,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
    translate([10,17,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
    
    translate([11.9,54.5,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
    translate([11.9,79.5,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);

// middle
        translate([151,218.7,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([74.7,107,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([115,18,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
        translate([140,18,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);


//bottom       
        translate([221,355.5,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([221,17,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);


// Unicorn

        translate([233.5,43.8,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);
        translate([233,134.3,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);

        translate([283,134.3,Thick/2-8.2])foot(FootDia,FootHole,FootHeight+8.4);
        translate([283.5,43.8,Thick/2-8.2]) foot(FootDia,FootHole,FootHeight+8.4);

// Reinforcement        
        translate([20,4.7,-6]) cube([3,Width-(Thick*2)-1,5]);
        translate([100,4.7,-6]) cube([3,Width-(Thick*2)-1,5]);
        translate([200,4.7,-6]) cube([3,Width-(Thick*2)-1,5]);
        translate([300,4.7,-6]) cube([3,Width-(Thick*2)-1,5]);
        
        translate([2.4,100,-6]) cube([Length-(Thick*2),3,5]);
        translate([2.4,200,-6]) cube([Length-(Thick*2),3,5]);
        translate([2.4,300,-6]) cube([Length-(Thick*2),3,5]);
}


module MainPCB()
{
rotate([0,0,90])
    translate([185.5,-116,4])
        color("Green",0.30)    
            import("Cons1.stl");
}


module KeyboardPCB()
{
rotate([-171.55,180,270])
    translate([156.7,-246,65])
        color("Green",0.30)    
         import("keyboard.stl");   
}




module UnicornPCB()
{
rotate([0,0,90])
    translate([89,-258.5,4])
        color("Green",0.30)    
         import("unicorn.stl");
}


///////////////////////////////////// - Main - ///////////////////////////////////////



if(BShell==1)
{
    color(Couleur1){ 
        BottomShell();
    }
    if (PCBFeet==1)
    // Feet
    translate([PCBPosX,PCBPosY,0]){ 
    BottomFeet();
    }
}

if(ShowPCB==1)
{
    if(BShell==1)
    {
        MainPCB();        
        UnicornPCB();
    }
    if(TShell==1)
        KeyboardPCB();
}
if(TShell==1)
{
    color( Couleur1,1){
        translate([0,Width,TopHeight+BottomHeight+0.2]){
            rotate([0,180,180]){
                TopShell();
            }
        }
    }
 
}


