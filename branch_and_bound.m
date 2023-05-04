clc
f=[-3,-4];
A=[7,16;3,-2;-1,0;0,-1];
b=[52,9,0,0];

[x,z]=linprog(f,A,b);

[x_mat,z_val]=solver(f,A,b)


function [x,z]=solver(f,A,b)
    [x,z]=linprog(f,A,b)
    disp(x);
    if isempty(z)
        
        return;
    end

    if x(1)-floor(x(1))<=0.001 || ceil(x(1))-x(1)<=0.001
        if x(2)-floor(x(2))<=0.001 || ceil(x(2))-x(2)<=0.001
            return
        end
    end
    
    if(mod(x(1),1)>mod(x(2),1))
        if ~( x(1)-floor(x(1))>=0.001 && ceil(x(1))-x(1)>=0.001)
            val=x(2,:);
            mat=[0,1];
            mat2=[0,-1];
        else
            val=x(1,:);
            mat=[1,0];
            mat2=[-1,0];
        end
    else
        if ~( x(2)-floor(x(2))>=0.001 && ceil(x(2))-x(2)>=0.001 )
            val=x(1,:);
            mat=[1,0];
            mat2=[-1,0];
        else

            val=x(2,:);
            mat=[0,1];
            mat2=[0,-1];
        end
    end
    [x_1,z_1]=solver(f,[A;mat],[b,floor(val)]);
    [x_2,z_2]=solver(f,[A;mat2],[b,-ceil(val)]);
    disp(z_1);
    disp(z_2);
    if isempty(z_1)
        z = z_2;
        x = x_2;
        return
    end
    if isempty(z_2)
        z = z_1;
        x = x_1;
        return
    end
    if(z_1<=z_2)
        x=x_1;
        z=z_1;
        return;
    else
        x=x_2;
        z=z_2;
        return;
    end
end


