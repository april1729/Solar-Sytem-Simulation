function plot_objects(list_of_objects,out_file,t_step,t_end)
%Author: Austin Sagan
%This program makes a neat video of the objects in list_of_objects.  It is
%set to center it around the sun and obly include the inner solar system,
%but that can be changed by changing what the variables center and d are.
%
%Paremeters:
%   list_of_objects- output from main.m
%   out_file- file to write video to
%   t_step-time step from simulation
%   t_end-time to end video.
%
%example:
%plot_objects(list,'temp.avi',1,600)
    center=get_object(list_of_objects,1);

    
    %Prepare the new file.
    vidObj = VideoWriter(out_file);
    open(vidObj);
    
    plot_size=0;
    %d=1.5*384400000;
    %d=4.7*10^9;
    d=1.5*149600000000;
    %d=4.3830e+08;
    for body=list_of_objects
        
        for x=body.x
            
            if max(abs(x))>plot_size
                plot_size=max(abs(x));
            end
        end
    end
    
    
    for i=1:1:list_of_objects(1).i-1
        hold on
        for obj=list_of_objects
            obj.plot_path(i/t_step)
        end
        
        title(sprintf('Time: %f days',i))
        xlabel('x position (m)')
        ylabel('y position (m)')

        axis([center.x(1,i/t_step)-d,center.x(1,i/t_step)+d,center.x(2,i/t_step)-d,center.x(2,i/t_step)+d])

        currFrame = getframe(figure(2));
        writeVideo(vidObj,currFrame);
        clf;
        
        hold off
    end
    % Close the file.
    close(vidObj);
end