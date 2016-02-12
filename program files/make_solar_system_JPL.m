%Author: Austin Sagan
%This scripts reads the information in teh Excel sheets in /horizons and
%puts them all into objects.

file=dir('horizons/*.xlsx');
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
    f=file(i);
    obj=body();
    sheet= xlsread(['horizons/',f.name]);
    obj.x=sheet(:,3:5)'*1000;
    obj.v=sheet(:,6:8)'*1000;
    obj.id=id(f.name(1:length(f.name)-5));
    obj.name=f.name;
    list_of_objects=[list_of_objects,obj];
end

save 'solar_system_JPL.mat'