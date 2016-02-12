function distance=distance_between_objects(list_of_objects,id1,id2,t_step)
%Author: Austin Sagan
%This program finds the distance between two objects in the list.
%
%parameters:
%   list_of_objects- output from main
%   id1- id of first object
%   id2- id of second oobject
%   t_step- tim3e step of simulation
%
%Example:
%earth_to_moon=distance_between_objects(list,4,10,0.1);
N=(length(list_of_objects(1).x));
distance=zeros(1,N);
obj1=get_object(list_of_objects,id1);
obj2=get_object(list_of_objects,id2);

for i=1:N*t_step
    distance(i)=norm(obj1.x(:,i/t_step)-obj2.x(:,i/t_step));
end

plot(distance)
end