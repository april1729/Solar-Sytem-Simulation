function error=compare(listJPL,listAUSTIN,id,t_step)
%Author: Austin Sagan
%plots and retruns the percent difference between the object with
%the given ID in the two lists.  
%
%parameters:
%   listJPL - expected to come from make_objects_JPL 
%   list_AUSTIN - expected to come from the main program.
%   id - id of object to compare
%   t_step - time step for simulation.  error will be calculated once per day.
%
%Example:
%compare(listJPL,list,4,0.1);

jpl=get_object(listJPL,id);
austin=get_object(listAUSTIN,id);
error=zeros(1,round(austin.i*t_step));
for i=0:austin.i*t_step-1
    error(i+1)=norm(jpl.x(:,i+1)-austin.x(:,(i/t_step)+1))/norm(jpl.x(:,i+1));
end
plot(error)