%Author: Austin Sagan
%This scripts sets up a scenario with gravitaiotnal assit. It save the file
%to 'sling_shot_example1.mat

clear

v=37000;
G=6.67384* 10^-11;
Mj=1.898*10^27;


jupiter=body();
jupiter.x0=[-3000*v;0;0];
jupiter.v0= [13000;0;0];
jupiter.id=6;
jupiter.mass=Mj;
jupiter.name='Jupiter';
%G*Mj/v^2
probe=body();
probe.x0=[10000*v;(1/15)*G*Mj/v^2;0];
probe.v0= [-1*v;0;0];
probe.id=11;
probe.mass=721.9;
probe.name='Probe';

list_of_objects=[probe,jupiter];
save 'sling_shot_example1.mat'