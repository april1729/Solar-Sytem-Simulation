classdef body
    %BODY Contains all data on the body and contains function to update it's position.
    %   Detailed explanation goes here
    
    properties
        % name  a unique identifier for the celetial body.  (e.g. "Mars",
        %       "Voyeger 1", "Sun")
        % mass  mass of the body in kg
        % x0    initial position
        % v0    initial velocity
        % x     postion list
        % v     velocity list
        % id    id number of body
        % i     current time step
        name 
        mass
        x0
        v0
        x
        v
        id
        i        
    end
    
    methods
        function obj=update(obj, list,t_step,method)
            % Calls another function that updates the objects speed and location of the object based on
            % gravitational effects of all objects in the list.
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            obj.i=obj.i+1;
            if strcmp(method,'euler cromer')
                obj=euler_cromer(obj,list,t_step);
            elseif strcmp(method,'runge kutta')
                obj=runge_kutta(obj,list,t_step);
            elseif strcmp(method,'verlet')
                obj=leap_frog(obj,list,t_step);
            end
            
        end
        
        function obj=verlet(obj,list,t_step)
            % updates the objects speed and location of the object based on
            % gravitational effects of all objects in the list using the
            % Verlet Method.
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            j=obj.i;
            if j==2
                obj.x(:,j)=obj.x(:,j-1)+obj.v(:,j-1)*t_step;
            else
                j=obj.i;
                obj.x(:,j)=2*obj.x(:,j-1)-obj.x(:,j-2) + obj.total_accel(list)*t_step^2;
                obj.v(:,j-1)=(obj.x(:,j)-obj.x(:,j-2))/(2*t_step);
            end
        end
        
        function obj=runge_kutta(obj,list,t_step)
            % updates the objects speed and location of the object based on
            % gravitational effects of all objects in the list using the
            % 4th order Runge Kutta algorithm.
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            %   t_step      amount of time to move forword.
            
            %find the slope in 4 different ways
            j=obj.i;
            kx1=obj.v(:,j-1);
            kv1=obj.total_accel(list);
            
            kx2=obj.v(:,j-1)+kv1*t_step/2;
            obj2=obj;
            obj2.x(:,j-1)=obj2.x(:,j-1)+kx1*t_step/2;
            kv2=obj2.total_accel(list);
            
            
            kx3=obj.v(:,j-1)+kv2*t_step/2;
            obj3=obj;
            obj3.x(:,j)=obj3.x(:,j-1)+kx2*t_step/2;
            kv3=obj3.total_accel(list);
            
            kx4=obj.v(:,j-1)+kv3*t_step;
            obj4=obj;
            obj4.x(:,j)=obj3.x(:,j-1)+kx3*t_step;
            kv4=obj4.total_accel(list);
            
            
            %find new value of x by taking a weighted average of the 4 positions
            obj.x(:,j)=obj.x(:,j-1)+(kx1+2*kx2+2*kx3+kx4)*t_step/6;
            
            %find new value of v by taking a weighted average of the 4 slopes
            obj.v(:,j)=obj.v(:,j-1)+(kv1+2*kv2+2*kv3+kv4)*t_step/6;
           
        end
        
        function obj=leap_frog(obj,list,t_step)
            % updates the objects speed and location of the object based on
            % gravitational effects of all objects in the list using the
            % Euler Method.
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            
            obj.v=obj.v+total_accel(obj,list)*t_step;
            obj.x=obj.x+obj.v*t_step;
            
            obj.x=[obj.x,obj.x];
            obj.v=[obj.v,obj.v];
        end
        
        function obj=euler_cromer(obj, list,t_step)
            % updates the objects speed and location of the object based on
            % gravitational effects of all objects in the list using the
            % Euler Method.
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            j=obj.i;
            obj.v(:,j)=obj.v(:,j-1)+total_accel(obj,list)*t_step;
            obj.x(:,j)=obj.x(:,j-1)+obj.v(:,j)*t_step;
                        
        end
        
        function a=total_accel(obj,list)
            % returns the total acceleration that obj has from all objects in list
            %
            % Parameters:
            %   obj         this body
            %   list        a list containing all other bodies in the system
            %   direction   "x" if you want the x acceleration, "y" if you
            %               want the y acceleration
            %
            % Returns:
            %   a          the acceleration in the given direction in m/s^2
            a=0;
            for o=list
                if ~(o==obj)
                    a=a+accel(obj,o);
                end
            end
        end    
        
        function a=accel(obj1,obj2)
            % returns the acceleration that other_obj has from obj
            %
            % Parameters:
            %   obj1        this body
            %   obj2        body that is accelerating
            %   direction   "x" if you want the x acceleration, "y" if you
            %               want the y acceleration
            %
            % Returns:
            %   a           the acceleration in the given direction in m/s^2
            j=obj1.i;
            G=6.67384* 10^-11;
            
            r=norm((obj1.x(:,j-1)-obj2.x(:,j-1)));
            F=-1*G*obj2.mass/r^2;
            a=F*((obj1.x(:,j-1)-obj2.x(:,j-1))/r);
        end
        
        function obj=init(obj,t_step,t_end)
            obj.i=1;
            obj.x=zeros(3,round(t_end/t_step));
            obj.v=obj.x;
            obj.x(:,1)=obj.x0;
            obj.v(:,1)=obj.v0;
        end
        
        function plot_path(obj, i)
            x=obj.x(1,1:i);
            y=obj.x(2,1:i);
            z=obj.x(3,1:i);
            plot(x(length(x)),y(length(x)),'o')
            plot(x,y)
        end
            
        function e=eq(obj1,obj2)
            % Function to test if two objects are equal.  The test is only
            % dependent on the names of the objects.
            e=strcmp(obj1.name,obj2.name);
        end
    end
    
end