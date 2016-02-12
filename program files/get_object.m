function [ obj ] = get_object(list_of_objects,id)
%Author:Austin Sagan
%This program return the item from th egiven list witht he given id.
%example:
%earth=get_object(list,4);
    obj=false;
    for o=list_of_objects
        if o.id==id
            obj=o;
        end
    end

end

