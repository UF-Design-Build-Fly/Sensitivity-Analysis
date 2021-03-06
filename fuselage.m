function [plane] = fuselage(plane) 
%Inputs: sensor aspect ratio (2020), number of containers
%Akaash  - For 2021, input will just change to number of syringes, which will be ns

%Akaash: How I'm thinking about putting the syringes is in groups of five
%on the fuselage and then just stacking these groups of five on top of each other
ns = plane.fuselage.numSyringes; %calling number of syringes from the plane function
sw=1.5; %width syringe (in)
sh=2; %height syringe (in)
sl=6.25; %length syringe (in)
nc=0; %number of crates
cl=3.5; %crate length (in) 
ch=cl; %crate height
rml=5; %release mechanism length (in)
sp=1; %spacer length between each crate 
%DEBUG rmar is just a ratio to find fuselage height, can change, also can change the release mechanism length based on what we pick 
rmar=1.7; %release mechanism aspect ratio (how tall compared to crate)
fh=0; %fuse height (in)
fw=0; %fuse width (in)
fl=0; %fuse length (in)
sfl=0; %syringe fuselage length
cfl=0; %crate fuselage length
rhoCarbon=120.486; %lb/ft^3
%DEBUG can change spr to what we want it to be
spr=5; %syringes per row depending on how many we want 

fh=ch*rmar; %this will just be crate height x a ratio we want to ensure they are easily able to fit and also take into account mechanim height. 
fw=sw*spr; %I'm thinking of laying out the syringes in rows of five, so this is why this is sw*5
nc= plane.fuselage.numVials;
tsh=sh*(ceil(ns/spr)); %this will calculate the total syringe height if we lay them out in rows of 5
frml=nc*cl+((nc-1)*sp)+rml; %this will just be the final length of the release mechanism so that we take it into account since we are dropping crates out the back of the fuselage
cfl=frml;%+sl; %crate fueslage length, adding extra syringe length to account for release mechanism taking up too much space

%this is used to find the length of the fuselage
if tsh<fh %this if will be used to extend the length of the fuselage accordingly depending on how many syringes we will carry
    sfl=sl+rml;%+sl; %syringe fueslage length, adding extra syringe length to account for release mechanism taking up too much space
elseif tsh>=fh %if the syringe height after stacking them exceeds the fuselage height, we have to extend the fueslage so we have more space to put them
    a=tsh/fh;
    a=ceil(a); %this a variable will just 
    sfl=(a*sl)+rml;%;+sl; %syringe fuselage length, adding extra syringe length to account for release mechanism taking up too much space
end

%to find temporary temporary length of fuselage since we do not need to carry crates and syringes at the same time
if sfl>cfl
    ttfl=sfl; %when syringe length is more than crate length, temporary temporary fuselage length is the same as syringe length
else
    ttfl=cfl; %other way around now
end

sys=8; %space systems needs for their stuff
tfl=ttfl+sys; %add systems length for avionics package, and this will be the temporary length used only for the main part of the fuselage
fla=3; %assumption for the front length of the fuselage.
bla=3; %assumption for the back length of the fueslage
fl=tfl+fla+bla; %final length of fuselage

SAm=(2*tfl*fh)+(2*tfl*fw); %this will be the surface area of the main portion of the fuselage, aka the middle part
Df=sqrt((0.5*fh)^2+(fla)^2); %we will assume a trapezoidal shape for the front of the fuselage if you view it from the side, so df will be the diagonal length.  
SAf=(Df*fw)+(6*fw)+((fh/2)*fw)+2*((0.75*fh*6)); %this formula is used to the find the surface area of the front section. So it is bottom area + top area + front area(closed section which is the nose) + side area, which are trapezoids
Db=sqrt((fh)^2+(bla)^2); %we will assume a triangular shape for the back of the fuselage if you view it from the side since we need a ramp to release the boxes from. 
SAb=(fw*bla)+(fw*Db)+2*((fh*bla)/2); %this formula is used to find the surface area of the back portion of the fueslage. Same method as front except now we have triangular surface area instead of trapezoidal.
tSAfT=SAm+SAf+SAb; %this will be the temporary surface area of the fuselage total in inches
SAfT=tSAfT/144;%Surface Area fuse Total,ft^2
FSA=(fw*fh)/144;%Frontal Surface Area,ft^2
Vol=SAfT*((1/16)/144);%The volume in ft^3, 1/16 is the thickness of the foam in inches so this will help us find the weight of the fuselage
FW=Vol *rhoCarbon; %Weight of fuselage in lb
fh=fh/12; %convert to feet
fw=fw/12; %convert to feet
fl=fl/12; %convert to feet

%convert these to object orientation
plane.fuselage.frontalSurfaceArea=FSA;
plane.fuselage.height=fh;
plane.fuselage.width=fw;
plane.fuselage.length=fl;
plane.fuselage.totalSA=SAfT;
plane.fuselage.weight=FW;
end