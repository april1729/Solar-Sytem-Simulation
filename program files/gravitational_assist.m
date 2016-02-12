%Author: Austin Sagan
%This script sets up, runs, and makes relevant plots for a gravitational
%assist scenario.


create_sling_shot1
t_step=0.000001;
t_end=0.08;
list=main(t_step,t_end,'sling_shot_example2.mat');
%list=main(0.000001,.2,'sling_shot_example1.mat');
probe=get_object(list,11);
v=zeros(1,probe.i);
for i=1:probe.i
    v(i)=norm(probe.v(:,i));
end
subplot(3,1,2)
plot(v)
ylabel('Velocity (m/s)')


subplot(3,1,1)
distance_between_objects(list,6,11,1);
ylabel('Distance Between Objects (m)');
subplot(3,1,3)

plot_total_energy(list,t_step);
ylabel('Total Energy (J)');
input('hit enter to continue...')

figure
plot_objects(list,'temps.avi',1,9999999)