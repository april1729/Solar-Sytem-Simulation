%Author: Austin Sagan
%this script using initial data from the spread sheets in /horizons and
%save initial objects in 'solar_system.mat' and is to but given to main.m
file=dir('horizons/*.xlsx');

masses=containers.Map;

masses('Sun')=1.989*10^30;
masses('Mercury')=328.5*10^21;
masses('Venus')=4.867*10^24;
masses('Earth')=5.972*10^24;
masses('Mars')=639*10^21;
masses('Jupiter')=1.898*10^27;
masses('Saturn')=568.3*10^24;
masses('Uranus')=86.81*10^24;
masses('Neptune')=102.4*10^24;
masses('Moon')=734.9*10^20;



id=containers.Map;

id('Sun')=1;
id('Mercury')=2;
id('Venus')=3;
id('Earth')=4;
id('Mars')=5;
id('Jupiter')=6;
id('Saturn')=7;
id('Uranus')=8;
id('Neptune')=9;
id('Moon')=10;

list_of_objects=[];
for i=1:length(file)
    f.name
    f=file(i);
    obj=body();
    sheet= xlsread(['horizons/',f.name]);
    obj.x0=sheet(1,3:5)'*1000;
    obj.v0=sheet(1,6:8)'*1000;
    obj.id=id(f.name(1:length(f.name)-5));
    obj.name=f.name;
    obj.mass=masses(f.name(1:length(f.name)-5));
    list_of_objects=[list_of_objects,obj];
end

save 'solar_system.mat'